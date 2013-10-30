//
//  SBPreviewRaindrop.m
//  Preview
//
//  Created by H.P.Logsdon on 10/30/13.
//  Copyright (c) 2013 Selective Bytes. All rights reserved.
//

#import "SBPreviewRaindrop.h"
#import "Preview.h"


@implementation SBPreviewRaindrop

- (NSString *)pasteboardNameForTriggeredRaindrop
{
    PreviewApplication *preview = [SBApplication applicationWithBundleIdentifier:@"com.apple.Preview"];
    NSArray *windows = nil;
    if ([preview frontmost]) {
        windows = [[preview windows] get];
    }

    if (!windows || [windows count] == 0) {
        return nil;
    }

    NSMutableArray *pbWindows = [NSMutableArray array];
    for (PreviewWindow *window in windows) {
        if (![window document]) {
            return nil;
        }

        NSURL *pathUrl = [NSURL URLWithString:[[window document] path]];
        NSPasteboardItem *item = [[NSPasteboardItem alloc] init];
        [item setString:[pathUrl absoluteString] forType:(NSString *)kUTTypeFileURL];
        [pbWindows addObject:item];
    }

    if ([pbWindows count] == 0) {
        return nil;
    }

    NSPasteboard *pasteboard = [NSPasteboard pasteboardWithUniqueName];
    [pasteboard writeObjects:pbWindows];

    return pasteboard.name;
}

@end
