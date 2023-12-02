Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802E2801D5F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 15:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjLBOpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 09:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjLBOpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 09:45:17 -0500
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E999E197
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 06:45:22 -0800 (PST)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1fa1e468769so2595325fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 06:45:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701528322; x=1702133122;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJ+HK/57SrNL+umRt6DpFtBi1spX/Qk4kvhA68cafI4=;
        b=YpVnjQWRS+YozCfxipkbf3/cDmsyTVcbvJyZ1hq9sJwqbR+LxEOfrH1RvBvi4O6j4P
         TAJg3s59LI1gHlHquFlbgklYTLF6IWeooOv9em7vQWmbUILmaxMGug7Sy+pSk6WIA4Pj
         XNSInajsGHQAsXJbXLi3mFq3WJc3OX77wQZKuiekEMEo5KIqCbieVswXaUoLoKcpCqIK
         i1R0qJJEVcP2myEsxafwliy+bfa0kbmmS0NjC+Y4g9RzHrvotAGjem01DUwb1+RtSG44
         2IMvVEnnoY6njw6P2TgQSGIcxg5Ze4oxst/dyGIpyY85KXdrqWxEx6Wok3VFboCFzRZA
         yGWg==
X-Gm-Message-State: AOJu0YzmGoOUrhaBj2DXXmU/CHue8YBW7I6h2vngxzaJ/uJDhSObKdmr
        rTg0sdwbzOPNK0EyBjVWyFaffSC81/GFLIVR7/lqoosnRosn
X-Google-Smtp-Source: AGHT+IGicoq0MmWqtro50KVMIzLkQtw//H6rkSt+wf233vNaE87lUhU/Mp+LljrqWLOGrXr5E4ZBDnDvoDLlzihe3NjPj1F/xWQR
MIME-Version: 1.0
X-Received: by 2002:a05:6870:d252:b0:1fa:ee9e:85d5 with SMTP id
 h18-20020a056870d25200b001faee9e85d5mr683657oac.11.1701528322317; Sat, 02 Dec
 2023 06:45:22 -0800 (PST)
Date:   Sat, 02 Dec 2023 06:45:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a2370060b87efc3@google.com>
Subject: [syzbot] Monthly ntfs3 report (Dec 2023)
From:   syzbot <syzbot+list782c9445342e49a6357c@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
In total, 57 issues are still open and 28 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  11352   Yes   VFS: Busy inodes after unmount (use-after-free)
                   https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
<2>  3624    Yes   KASAN: slab-out-of-bounds Read in ntfs_iget5
                   https://syzkaller.appspot.com/bug?extid=b4084c18420f9fad0b4f
<3>  2143    Yes   possible deadlock in ni_fiemap
                   https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
<4>  1875    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<5>  1451    Yes   possible deadlock in attr_data_get_block
                   https://syzkaller.appspot.com/bug?extid=36bb70085ef6edc2ebb9
<6>  1359    Yes   possible deadlock in ntfs_set_state
                   https://syzkaller.appspot.com/bug?extid=f91c29a5d5a01ada051a
<7>  691     Yes   possible deadlock in mi_read
                   https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
<8>  550     Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<9>  527     Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
<10> 311     Yes   kernel BUG at fs/inode.c:LINE! (2)
                   https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
