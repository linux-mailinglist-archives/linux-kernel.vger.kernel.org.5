Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D853F7BFD46
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjJJNW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjJJNW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:22:57 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF751A9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:22:54 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3af609cb0afso9409318b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696944174; x=1697548974;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WPs0ReiPqc/aFRNaFX27U5xWvgbH7T8ffytrVNorhwU=;
        b=bXQdPpg3vYwFiFxxd0eC6ez6PJpuhXWOODM8jZ3YM8m6TAPl5vUZU7L8QS7OV7jJpV
         4ks0ayxFIRlVUPJEfFPSXC8OmRuPiiKkS+31ZJq4uCLgzSgkMAB4qNxZiKbhacUTad1g
         1miO6V6O0lee1Ta2SFO1/wDdHJPzKG0IBsmXHK2WFfX/FvC6wjz3w5aB9LBopf4CswEF
         J1y3l2GaQQEuRoXNBO+bGzfHYjHiRpYmdRjdiOMS5zAD7AaR/1hTuAMbZjWGP3M4fPdr
         kbEUXeGLdvN7jMYSLRa3UKPH8VEW7qMOKawx36yfldtkoRUW6O+GR1kSoyzws6VzqD5B
         ln5Q==
X-Gm-Message-State: AOJu0YzFEV3vb8/YX2Ylk9agwdlwzIsOFi3TQGahQP4LzIDjCZG2Mpj5
        7lY+irb/9nFI7ai0XfS7+g2p6EjJGUjFu+0g91SG/mHv2ybL
X-Google-Smtp-Source: AGHT+IFHx5WfmP0h9Q2MCM9z8WbUPQSg/Jz4igQl/wNAd2wui14vy0S8nBfGLd05U2kGX5Su/5dXoVMNhk3c1zcpplau+S4O9z0F
MIME-Version: 1.0
X-Received: by 2002:a05:6808:198d:b0:3a3:e17e:d2f7 with SMTP id
 bj13-20020a056808198d00b003a3e17ed2f7mr9278450oib.4.1696944174318; Tue, 10
 Oct 2023 06:22:54 -0700 (PDT)
Date:   Tue, 10 Oct 2023 06:22:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6cc0106075c9a7e@google.com>
Subject: [syzbot] Monthly fs report (Oct 2023)
From:   syzbot <syzbot+list7a2521329a03e73f2fa8@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 6 new issues were detected and 0 were fixed.
In total, 53 issues are still open and 331 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3341    Yes   BUG: sleeping function called from invalid context in __getblk_gfp
                   https://syzkaller.appspot.com/bug?extid=69b40dc5fd40f32c199f
<2>  2456    Yes   WARNING in firmware_fallback_sysfs
                   https://syzkaller.appspot.com/bug?extid=95f2e2439b97575ec3c0
<3>  1413    Yes   possible deadlock in input_event (2)
                   https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
<4>  327     Yes   BUG: sleeping function called from invalid context in __bread_gfp
                   https://syzkaller.appspot.com/bug?extid=5869fb71f59eac925756
<5>  244     No    KASAN: slab-use-after-free Read in __ext4_iget
                   https://syzkaller.appspot.com/bug?extid=5407ecf3112f882d2ef3
<6>  141     Yes   possible deadlock in pipe_write
                   https://syzkaller.appspot.com/bug?extid=011e4ea1da6692cf881c
<7>  56      Yes   WARNING in path_openat
                   https://syzkaller.appspot.com/bug?extid=be8872fcb764bf9fea73
<8>  42      Yes   INFO: task hung in filename_create (4)
                   https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
<9>  40      No    INFO: task hung in __fdget_pos (4)
                   https://syzkaller.appspot.com/bug?extid=e245f0516ee625aaa412
<10> 36      Yes   INFO: rcu detected stall in sys_clock_adjtime
                   https://syzkaller.appspot.com/bug?extid=25b7addb06e92c482190

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
