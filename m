Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6667EBD2C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 07:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbjKOGoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 01:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKOGoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 01:44:07 -0500
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0B2CA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 22:44:04 -0800 (PST)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2806501f8efso380796a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 22:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700030643; x=1700635443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPkpJiyboP3YDsqMigwzj3L9aPPH8ZkCr0KvfUH0uFs=;
        b=rTx0TtPWUHmw3x4Sokx/MoQHsluqLcf+DDStPd+PkL4x9D8vaSDUynXLHsn1QWt/9N
         YLt00K8Pig7e2wRYc+5r8E5CvSbmPX3iDK7dEr+E/BiKk8z4iaOmsp19e6huDmVu3Ey7
         6yBifQpqZ3aP7IBksHimyx3YSOdac7Q+YKEzwX20vM0zxS1BQX9crk8hgTQd2fjg0T5m
         ETmaFlCmdGGSmvKQPyNQGbWErgS2pnkmIawd1A3sP2buMyx5haUhOeA6Z+4Eqm+4HdUh
         kDEq9gCXIk85UsFSGqBUq5fxwjgcDbfa84Orl4iSSahPhmuNUaUVdSPltwgp/xPD/ORl
         Qzjw==
X-Gm-Message-State: AOJu0YyTZ/rqukO6pOn9j1WuaAqUnZThN59TjfWDPRPlk8KTzlilHUZk
        //9hBg2e2qlUSZppu3fKRlg5sA2QJaP66px3SCGXDMoJNXIQf1Q=
X-Google-Smtp-Source: AGHT+IEz+m5ZExnHJOCyrXVXqFFNbhGEh/IIgnncuPaMrp+MHRF4oDHJo15QvoPxJzORKJLjy1H2LWDRZwAiUtsyAm8L3R8brnJE
MIME-Version: 1.0
X-Received: by 2002:a17:90a:9a82:b0:280:98bd:d8df with SMTP id
 e2-20020a17090a9a8200b0028098bdd8dfmr3574078pjp.7.1700030643661; Tue, 14 Nov
 2023 22:44:03 -0800 (PST)
Date:   Tue, 14 Nov 2023 22:44:03 -0800
In-Reply-To: <CA+LQOUfmbgj9a769zcp_7AYz-=RkTeaxsinKarhyKO17Sij6FA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009f7441060a2b3ac8@google.com>
Subject: Re: [syzbot] [wireless?] [net?] WARNING in ieee80211_rfkill_poll
From:   syzbot <syzbot+7e59a5bfc7a897247e18@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mukattreyee@gmail.com,
        syzkaller-bugs@googlegroups.com
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

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in ieee80211_rfkill_poll

------------[ cut here ]------------
WARNING: CPU: 1 PID: 22 at net/mac80211/driver-ops.h:688 drv_rfkill_poll net/mac80211/driver-ops.h:688 [inline]
WARNING: CPU: 1 PID: 22 at net/mac80211/driver-ops.h:688 ieee80211_rfkill_poll+0x134/0x170 net/mac80211/cfg.c:3100
Modules linked in:
CPU: 1 PID: 22 Comm: kworker/1:0 Not tainted 6.7.0-rc1-syzkaller-00019-gc42d9eeef8e5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: events_power_efficient rfkill_poll
RIP: 0010:drv_rfkill_poll net/mac80211/driver-ops.h:688 [inline]
RIP: 0010:ieee80211_rfkill_poll+0x134/0x170 net/mac80211/cfg.c:3100
Code: 60 07 00 00 be ff ff ff ff 48 8d 78 68 e8 24 f4 38 00 31 ff 89 c5 89 c6 e8 79 22 39 fb 85 ed 0f 85 44 ff ff ff e8 fc 26 39 fb <0f> 0b e9 38 ff ff ff e8 f0 26 39 fb 0f 0b 48 c7 c7 78 13 34 89 e8
RSP: 0018:ffffc9000017fc90 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888112e50700 RCX: ffffffff8614d1d7
RDX: ffff888103a6ba00 RSI: ffffffff8614d1e4 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 1ffffffff15c0565 R12: ffff888112e50700
R13: 0000000000000001 R14: ffffc9000017fd80 R15: ffff8881f673ad40
FS:  0000000000000000(0000) GS:ffff8881f6700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056206539e088 CR3: 0000000109b43000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rdev_rfkill_poll net/wireless/rdev-ops.h:636 [inline]
 cfg80211_rfkill_poll+0xc9/0x240 net/wireless/core.c:224
 rfkill_poll+0x8d/0x110 net/rfkill/core.c:1037
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


Tested on:

commit:         c42d9eee Merge tag 'hardening-v6.7-rc2' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1232175b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc2b6251fe8086ab
dashboard link: https://syzkaller.appspot.com/bug?extid=7e59a5bfc7a897247e18
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
