Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEC4768575
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 15:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjG3NQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 09:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjG3NQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 09:16:52 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEF91B6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 06:16:51 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6bc6a2650a5so7100579a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 06:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690723011; x=1691327811;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGVUirxVTDZ7vJHx7E2WkvsFtu2tIh0g/z5nRixG5LQ=;
        b=VhLDREglHvxLjtHekN3bsyYY4uYniXqaB9n5OcxMZGzKn3A8s6nLStszfv0j76pByf
         E8mN0itU0fsqnzr9x2rAko8nDlzYn3Waa7lLaKU7FA0WR06IiWhWw4KjfzSDJwF2+4F5
         xlFFoTUnzV0/IcVR9iP2BpLQzqiDJBlrfsQWd7w5AYdziis1VzjLCLamMU6R8GlWXIzL
         RGSrzRjDybT0ZQ36HcQPmQm+hZ5yweiXUuhncEiGfirzoyaOATk5tfhOkmgrXj3Snlj/
         btq00ds+kLEv0f6bc1vII1L1s9xlfGQoOt1OrRyuLxnBCYGXpR4oynCy/WlRK67gohb8
         cttw==
X-Gm-Message-State: ABy/qLZJiw1w6tHn5eEp/QyHvFIPeAMolYL3bFAmTvTfNXtD2XDRErcL
        VZvXJ9eQR0SYdlmlMiMOVAsbxOBliaWzOWym78A8DEyhwb61
X-Google-Smtp-Source: APBJJlELZvKOcEMzlyL5FN02V7iwD/Wiz1fiY/pl6RhA5Z/G4zWxNMQ1IKl1Kngkm7uBKI1zTQfgrnzcsrHqxLvCLOctEzlZdobJ
MIME-Version: 1.0
X-Received: by 2002:a9d:4e9a:0:b0:6bb:2244:cb72 with SMTP id
 v26-20020a9d4e9a000000b006bb2244cb72mr8840045otk.2.1690723010882; Sun, 30 Jul
 2023 06:16:50 -0700 (PDT)
Date:   Sun, 30 Jul 2023 06:16:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a34010601b420d6@google.com>
Subject: [syzbot] Monthly jfs report (Jul 2023)
From:   syzbot <syzbot+listd87de47c524d3cfa086b@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 50 issues are still open and 13 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1009    Yes   UBSAN: array-index-out-of-bounds in xtInsert
                   https://syzkaller.appspot.com/bug?extid=55a7541cfd25df68109e
<2>  992     Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<3>  686     Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<4>  560     Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<5>  343     Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<6>  312     Yes   UBSAN: array-index-out-of-bounds in txCommit
                   https://syzkaller.appspot.com/bug?extid=0558d19c373e44da3c18
<7>  215     Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6
<8>  150     Yes   KASAN: use-after-free Read in release_metapage
                   https://syzkaller.appspot.com/bug?extid=f1521383cec5f7baaa94
<9>  93      Yes   KASAN: use-after-free Read in diFree
                   https://syzkaller.appspot.com/bug?extid=1964c915c8c3913b3d7a
<10> 90      Yes   UBSAN: array-index-out-of-bounds in xtSearch
                   https://syzkaller.appspot.com/bug?extid=76a072c2f8a60280bd70

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
