Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6917B78B4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbjJDH2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjJDH2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:28:47 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AF2A7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 00:28:43 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3ae4cefdee5so2640891b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 00:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696404522; x=1697009322;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BgKrvAHPPnFbgL/jHnrLa+rBLBl2K8FRSAuVolVvCxs=;
        b=a64uxWexWp/aprg30q8SUql/319a76kPV2QRFw+qP6cOUd0m0emyzBUt292T+MkxHC
         IGb0a0IT4Zv6nKHn9GfK9PFybmZfprWeylORJc5UzJTWAk7lL6l8eDPGH3jdRhz81iBj
         SBSXZ4QF765RaJWgaInw14U6symLGaaZp+wn/S0ZrLhEMjpNyAE1a0lKupk7Pc2kKlSR
         zKjZaPfib9XcpafrSkDR8Uo/+ZqC6gebQ3dcTxKckqIdpppiXlP9jGbDnVOdILSC/b6j
         MiWaO5tbfrCA7YGytEJUDlOIYsAywjGG1hkl8tZkD7TRUYnDofVFYqMcnJ7xoKhaJj5E
         pHlA==
X-Gm-Message-State: AOJu0YzxEO3GaBpq1hFa6vtb1R5oBxtI0e1qPlUtwQVkaPDM8SetmNOe
        mdDYg2vdHCbPSdy67GNI+GrnNKlPzvH7hjhTp3V7EiNcKUC0DaU=
X-Google-Smtp-Source: AGHT+IEKnqwUXjDT8KGKajjXUfZjvk7G8CMKOZZO7VzMAYCqELb908xqmZ4AvW9TdfulGPOKu8qSHC7o440QZlbPCnodhzgzRm/G
MIME-Version: 1.0
X-Received: by 2002:a05:6808:30a7:b0:3af:6c87:144c with SMTP id
 bl39-20020a05680830a700b003af6c87144cmr921058oib.2.1696404522572; Wed, 04 Oct
 2023 00:28:42 -0700 (PDT)
Date:   Wed, 04 Oct 2023 00:28:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6a4630606def4cd@google.com>
Subject: [syzbot] Monthly usb report (Oct 2023)
From:   syzbot <syzbot+listfa0313a2fe512dcdce74@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello usb maintainers/developers,

This is a 31-day syzbot report for the usb subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/usb

During the period, 3 new issues were detected and 0 were fixed.
In total, 67 issues are still open and 325 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2705    Yes   KMSAN: uninit-value in dib3000mb_attach (2)
                   https://syzkaller.appspot.com/bug?extid=c88fc0ebe0d5935c70da
<2>  2437    Yes   KMSAN: uninit-value in mii_nway_restart
                   https://syzkaller.appspot.com/bug?extid=1f53a30781af65d2c955
<3>  2367    Yes   WARNING in firmware_fallback_sysfs
                   https://syzkaller.appspot.com/bug?extid=95f2e2439b97575ec3c0
<4>  816     Yes   general protection fault in ir_raw_event_store_with_filter
                   https://syzkaller.appspot.com/bug?extid=34008406ee9a31b13c73
<5>  519     Yes   INFO: task hung in hub_port_init (3)
                   https://syzkaller.appspot.com/bug?extid=b6f11035e572f08bc20f
<6>  468     Yes   KMSAN: uninit-value in smsc95xx_eeprom_confirm_not_busy
                   https://syzkaller.appspot.com/bug?extid=2c97a98a5ba9ea9c23bd
<7>  363     Yes   INFO: task hung in r871xu_dev_remove
                   https://syzkaller.appspot.com/bug?extid=f39c1dad0b7db49ca4a8
<8>  361     Yes   KMSAN: uninit-value in smsc95xx_reset
                   https://syzkaller.appspot.com/bug?extid=c74c24b43c9ae534f0e0
<9>  350     Yes   INFO: task hung in usbdev_open (2)
                   https://syzkaller.appspot.com/bug?extid=b73659f5bb96fac34820
<10> 304     Yes   KASAN: use-after-free Read in v4l2_fh_init
                   https://syzkaller.appspot.com/bug?extid=c025d34b8eaa54c571b8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
