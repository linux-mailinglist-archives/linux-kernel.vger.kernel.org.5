Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60342797818
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjIGQlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242377AbjIGQlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:41:31 -0400
Received: from mail-oi1-x248.google.com (mail-oi1-x248.google.com [IPv6:2607:f8b0:4864:20::248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6EF518E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:49:25 -0700 (PDT)
Received: by mail-oi1-x248.google.com with SMTP id 5614622812f47-3ab244d5c9cso1199740b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101395; x=1694706195;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=54RnD0/eaUNNcZhsg2FpPlchnXTxP0bbQAOVgGCedQA=;
        b=iy2vvPH2jnRdGBTYYRUdOcmkbkiqDqHC5rha1Bj6mDBuo++2pXG68RZVojB+v3M5Dm
         t/mmNX/4v2IQ/kPUhtClPsY2s0nQRUGobmxD2ceY76bX7jUKMU5s8fjaJawJac3T04jV
         373X9x0UjoPPa+Oqc1tPjKjnnmEPZ0fMV0unETewCKGFaQo6ScHsyjzlPHn4AM1eBlmz
         2tJjMcSwd4+0VOxdp6lVigd1fRYEB8dSzYQm9cAi8nB3iGP7QMu8/1rk7/P1ZZxouuP8
         u9OvtQOTe4T+x8vrf7LL+tsKb4nOVSA6+NnHcJHgJyfGUqcQjYFI4mGjJP7+r8GFXJw/
         7i7Q==
X-Gm-Message-State: AOJu0YwsxSxmmXGMIESaHVV8xM7VJwnjiN0w098P9wjFjP/uygAt9X3X
        JxL+vUXAWNyNv1Se57pgPOAfWmJCXO7fRR0jLP5Q5foBkgF1
X-Google-Smtp-Source: AGHT+IF7nJp7WfGi/JuZ3Xso9VmPQE+Eu5dyn+9jnS4PZNmBcTODjnhA1xHWBvLIq3kc3jCCDDcd8W091tI9+51MmrUx3l8NWUou
MIME-Version: 1.0
X-Received: by 2002:a17:90a:c286:b0:263:317f:7ca4 with SMTP id
 f6-20020a17090ac28600b00263317f7ca4mr4271411pjt.9.1694078750527; Thu, 07 Sep
 2023 02:25:50 -0700 (PDT)
Date:   Thu, 07 Sep 2023 02:25:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002598420604c1721a@google.com>
Subject: [syzbot] Monthly ext4 report (Sep 2023)
From:   syzbot <syzbot+list8aecbc15d3f04988df93@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 3 new issues were detected and 2 were fixed.
In total, 40 issues are still open and 118 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2826    Yes   WARNING: locking bug in ext4_move_extents
                   https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
<2>  221     Yes   WARNING: locking bug in __ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<3>  138     No    possible deadlock in evict (3)
                   https://syzkaller.appspot.com/bug?extid=dd426ae4af71f1e74729
<4>  117     Yes   WARNING: locking bug in ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<5>  73      Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<6>  28      Yes   kernel BUG in ext4_write_inline_data_end
                   https://syzkaller.appspot.com/bug?extid=198e7455f3a4f38b838a
<7>  14      No    KASAN: slab-use-after-free Read in check_igot_inode
                   https://syzkaller.appspot.com/bug?extid=741810aea4ac24243b2f
<8>  7       Yes   KASAN: slab-use-after-free Read in ext4_convert_inline_data_nolock
                   https://syzkaller.appspot.com/bug?extid=db6caad9ebd2c8022b41
<9>  6       Yes   INFO: task hung in ext4_evict_ea_inode
                   https://syzkaller.appspot.com/bug?extid=38e6635a03c83c76297a
<10> 6       Yes   KASAN: out-of-bounds Read in ext4_ext_remove_space
                   https://syzkaller.appspot.com/bug?extid=6e5f2db05775244c73b7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
