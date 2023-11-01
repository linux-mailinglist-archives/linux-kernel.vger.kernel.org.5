Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678D47DDF1B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbjKAKNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjKAKNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:13:32 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EE4F4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 03:13:25 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6d31f885789so91286a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 03:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698833605; x=1699438405;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H0X5+nC7jNHDCCTzWCwWOWfQ3Z6jzhEzmqgYVwfBxgs=;
        b=WBuTdpLu+xfrH1JHTH4fIN7Nu7q9DA7pbv2W8/V8knliINAMqXnKS0dgEQPqIliu/S
         EQUzxJyUhtsedN726j0RgFksDzY5wIzn2bBsudzttAU7HwMBHk8e0llp2X+kt9iWQNTH
         D/aqpBTBUr7VHkMcYDQ+Nqmz6dC/2EVxWAWvxJTWH/kYtxPxYKGBwZdZgR/V+m8b6B6l
         +vsQ/lb1ag8THbAT63QVK1OKhP9585aoSGAG5KBAeR0b91HgQEyJWOjrNEeowtbzHrm/
         COYg1a5XyMnKGD2X6H72C3II7Degupph/SoBDUFmvWAMJg7mv3oQQgIP+R9Ttxq7ohWg
         w88g==
X-Gm-Message-State: AOJu0YyezmDLl2uZKOkP77EO04zj0qe/qUgHpCnWRnJESpNUz4RfsB2M
        HTvu44XJ7qLOXUxAFVP+XYROTh+eAMHYEQSzX57suxfQBFE2
X-Google-Smtp-Source: AGHT+IGFSKBn9JzoyB4reWv8CcgGNMZjtRCfcFyjCHWO02tqqZSwfzmDuaO0vGgnMepapskNikf7cVBGP2rDCjV+nWJppqSTDRz1
MIME-Version: 1.0
X-Received: by 2002:a05:6830:8d6:b0:6c6:2b19:7270 with SMTP id
 z22-20020a05683008d600b006c62b197270mr532346otg.1.1698833605405; Wed, 01 Nov
 2023 03:13:25 -0700 (PDT)
Date:   Wed, 01 Nov 2023 03:13:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000953abd0609148558@google.com>
Subject: [syzbot] Monthly ntfs3 report (Oct 2023)
From:   syzbot <syzbot+listbc4ef25e49f52c411bed@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 3 new issues were detected and 0 were fixed.
In total, 56 issues are still open and 28 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  11317   Yes   VFS: Busy inodes after unmount (use-after-free)
                   https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
<2>  3613    Yes   KASAN: slab-out-of-bounds Read in ntfs_iget5
                   https://syzkaller.appspot.com/bug?extid=b4084c18420f9fad0b4f
<3>  2014    Yes   possible deadlock in ni_fiemap
                   https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
<4>  1786    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<5>  1358    Yes   possible deadlock in attr_data_get_block
                   https://syzkaller.appspot.com/bug?extid=36bb70085ef6edc2ebb9
<6>  1347    Yes   possible deadlock in ntfs_set_state
                   https://syzkaller.appspot.com/bug?extid=f91c29a5d5a01ada051a
<7>  825     No    possible deadlock in ntfs_mark_rec_free
                   https://syzkaller.appspot.com/bug?extid=f83f0dbef763c426e3cf
<8>  626     Yes   possible deadlock in mi_read
                   https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
<9>  531     Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<10> 482     Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
