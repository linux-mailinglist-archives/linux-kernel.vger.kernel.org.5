Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644CF76856E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 15:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjG3NPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 09:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjG3NPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 09:15:06 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BC2130
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 06:15:04 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a5b92b4b63so7477504b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 06:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690722904; x=1691327704;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ujxfyGz6aP3+bL3wx8HXRBterKxnWJIS46oEXqsvR9M=;
        b=NhNsfjAhDcwpJUwA+SSSol7/h0lFF7qRHfytnyAgQ9ApB4958TAsgwebDfB1brG9db
         dvfe6Bg4h0M0Hj9HQ3vtBZM0nh0sv4f2mxwTt3R2cN0YwtleIVk488yDdsn6xMgi83LR
         oh4MBNPsdlyE12qZSG/k3eIFMsJ1YJbTakvaA5eR4zNx/X6hl4u0/CIlvW/sps1GQGoX
         UwC/CjSnh27ZnkHf4PloR9jHMVHIsSryNqy1Yb83hmZF4I2ySnhH8ZtFXbK9C89QgflP
         +D3gIDEA0vQql2vNAwR7Yl+oerWHF5Kkt3m82wJaBCMZFfekExUjCrqZSfydX5jTmmX8
         wWqw==
X-Gm-Message-State: ABy/qLalaxYJe3KfWF67vIQU5GihQACrdcbYsVU46E5xQ4e8UQGIBSbt
        FA4XNWSZhBWClbZME4dIsIvHrTbMA4ZXxE+5VhX9nOGQFJgr
X-Google-Smtp-Source: APBJJlHtBlxRMaOo42huwetO6El+kvMunHmSRso82LX/eGklZ6M3gBwmCtOfCmCosZg3xOG7qZ0H9fypADjBmDys9yhFNUx9h0sm
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1993:b0:3a4:18d1:1638 with SMTP id
 bj19-20020a056808199300b003a418d11638mr13908863oib.5.1690722904062; Sun, 30
 Jul 2023 06:15:04 -0700 (PDT)
Date:   Sun, 30 Jul 2023 06:15:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c40170601b41a3e@google.com>
Subject: [syzbot] Monthly btrfs report (Jul 2023)
From:   syzbot <syzbot+list78bb969b37073eea676a@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 4 new issues were detected and 3 were fixed.
In total, 51 issues are still open and 35 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4533    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  1115    Yes   VFS: Busy inodes after unmount (use-after-free)
                   https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
<3>  804     Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<4>  678     Yes   WARNING in __kernel_write_iter
                   https://syzkaller.appspot.com/bug?extid=12e098239d20385264d3
<5>  373     Yes   WARNING in btrfs_block_rsv_release
                   https://syzkaller.appspot.com/bug?extid=dde7e853812ed57835ea
<6>  294     Yes   kernel BUG at fs/inode.c:LINE! (2)
                   https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db
<7>  249     Yes   WARNING in lookup_inline_extent_backref
                   https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
<8>  210     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<9>  200     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<10> 142     Yes   INFO: task hung in lock_extent
                   https://syzkaller.appspot.com/bug?extid=eaa05fbc7563874b7ad2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
