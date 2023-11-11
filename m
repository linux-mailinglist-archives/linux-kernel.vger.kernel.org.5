Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5CE7E8755
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 02:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345149AbjKKBI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 20:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjKKBI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 20:08:28 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A027E448C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 17:08:23 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cc1ddb34ccso28236875ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 17:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699664903; x=1700269703;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dwdFPnuTOA9bzSYhfknyestbGOHfAOANZJb099tUQ0g=;
        b=MJWULwlQgHR+6oUSXD/6WgOvSsUNnSxhy6HHtNvwJVkiMrjCRMayjyGUhzDRY5w5Di
         XJ4CAFZogsP+yZEAbwQiviTe3stHCaqXTLF9zzJPg7LeDKINmnGq017Mfb4xHsesHZrH
         gBx77q+lumUdCMzmoo7dkShhswJcCsussrA3Pcv9OP9r3GzcuCODxXYcUwQ9V/cf/0zk
         piqM9H7bTGzs5pnlRcmpdgHv/rvkHrOBPo1xkVL5UoX2JfQF8a3oIWM+rI502YIM8N2R
         Ix0ZjBELkGwPLCeDmdd+iT/wMWxiq0KyOYvBcF+eUPvdaE6Jv5d7iv/GAH9/jRk2y5XI
         CYSA==
X-Gm-Message-State: AOJu0YzceOM1+X3niNLwfv3bdqoTcT4deynM0HBG5pQrPpl7g8Lnlek1
        RcODHCIX02000Dyn/M/c7NI2yY7OSucZ5uCc4uPykSezLxFh
X-Google-Smtp-Source: AGHT+IF+oN9pCGz6CtQwFDycnMrLZbA5yVGGDmNRIscnoKmcaZaQf6Gfo4MxN3Qtqa06MwuRlceEYh0qLKl04qlDjngOhhlEd62X
MIME-Version: 1.0
X-Received: by 2002:a17:903:25cf:b0:1cc:323c:fe4a with SMTP id
 jc15-20020a17090325cf00b001cc323cfe4amr242167plb.12.1699664903193; Fri, 10
 Nov 2023 17:08:23 -0800 (PST)
Date:   Fri, 10 Nov 2023 17:08:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000caca800609d612cc@google.com>
Subject: [syzbot] Monthly fs report (Nov 2023)
From:   syzbot <syzbot+listd7ef1e6b20cd71d38256@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 2 new issues were detected and 0 were fixed.
In total, 50 issues are still open and 331 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3631    Yes   BUG: sleeping function called from invalid context in __getblk_gfp
                   https://syzkaller.appspot.com/bug?extid=69b40dc5fd40f32c199f
<2>  1500    Yes   possible deadlock in input_event (2)
                   https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
<3>  359     Yes   BUG: sleeping function called from invalid context in __bread_gfp
                   https://syzkaller.appspot.com/bug?extid=5869fb71f59eac925756
<4>  254     No    KASAN: slab-use-after-free Read in __ext4_iget
                   https://syzkaller.appspot.com/bug?extid=5407ecf3112f882d2ef3
<5>  145     Yes   possible deadlock in pipe_write
                   https://syzkaller.appspot.com/bug?extid=011e4ea1da6692cf881c
<6>  75      Yes   BUG: sleeping function called from invalid context in bdev_getblk
                   https://syzkaller.appspot.com/bug?extid=51c61e2b1259fcd64071
<7>  57      Yes   WARNING in path_openat
                   https://syzkaller.appspot.com/bug?extid=be8872fcb764bf9fea73
<8>  47      Yes   INFO: task hung in filename_create (4)
                   https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
<9>  43      No    INFO: task hung in __fdget_pos (4)
                   https://syzkaller.appspot.com/bug?extid=e245f0516ee625aaa412
<10> 40      Yes   INFO: rcu detected stall in sys_clock_adjtime
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
