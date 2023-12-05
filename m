Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294D6804EC1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346439AbjLEJxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346380AbjLEJx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:53:27 -0500
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D9DA9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:53:33 -0800 (PST)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b9b4f7df33so2666084b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701770013; x=1702374813;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2f7L18jtFttpvJFfes6CBhMW1LVntx6OZdWwTsAFipQ=;
        b=WElEsLqOQLJu1v3Cwa0NfFqgfvoHeXsgax7aCyi3VLGkOyzayluqAbebVJTrKL5iys
         jMia7pZVSFnRrGpElCtFhBdy9PshV4UGC0VqS7yBZYseVN3iVyilBPSp6u64bWi0SxoU
         R3cRX3pwHGYg4u+elEjfiGkDEnT1FQpbn3ZmrsH07klXVAIcpYZDTC4u1LvviT8iQp8o
         57Zxw8Y34etmg/Yjcs6q13z1jMlDSk+vjL51AjT04tctzvS9vKAjpEiAO4HPP1S4gwg4
         +MHmEgZZEnpOaLtSUv9NfRYkJdC0OCGvv/cvj+IehGFIK3UI3jrLGissZ4+GGWEJnVS/
         7Lig==
X-Gm-Message-State: AOJu0Yxr0GpPEZXlHq4t5i3QIhyf1+35Fps4tFmBrL+kDUFxW2P25Bc3
        VEDHUBAdK1Voj/mz62qAXoxlr0auH2i2adEyBJ+hZPr1MyRbaPg=
X-Google-Smtp-Source: AGHT+IEVw8D2Bi6fgJqzWq5fTn8AdF4hUojkIQidaLYC27w7CjFxBSrOw0n+HTOSGj26IC8mslr2u0JL6NHQfZdLWygWHofy+zoW
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2122:b0:3b9:b430:2908 with SMTP id
 r34-20020a056808212200b003b9b4302908mr2084994oiw.11.1701770013096; Tue, 05
 Dec 2023 01:53:33 -0800 (PST)
Date:   Tue, 05 Dec 2023 01:53:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ebfe6060bc035a3@google.com>
Subject: [syzbot] Monthly usb report (Dec 2023)
From:   syzbot <syzbot+list834ca8cfb649c1b10f3c@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello usb maintainers/developers,

This is a 31-day syzbot report for the usb subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/usb

During the period, 2 new issues were detected and 0 were fixed.
In total, 63 issues are still open and 331 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2852    Yes   WARNING in firmware_fallback_sysfs
                   https://syzkaller.appspot.com/bug?extid=95f2e2439b97575ec3c0
<2>  2755    Yes   KMSAN: uninit-value in dib3000mb_attach (2)
                   https://syzkaller.appspot.com/bug?extid=c88fc0ebe0d5935c70da
<3>  824     Yes   general protection fault in ir_raw_event_store_with_filter
                   https://syzkaller.appspot.com/bug?extid=34008406ee9a31b13c73
<4>  540     Yes   INFO: task hung in hub_port_init (3)
                   https://syzkaller.appspot.com/bug?extid=b6f11035e572f08bc20f
<5>  395     Yes   INFO: task hung in usbdev_open (2)
                   https://syzkaller.appspot.com/bug?extid=b73659f5bb96fac34820
<6>  304     Yes   KASAN: use-after-free Read in v4l2_fh_init
                   https://syzkaller.appspot.com/bug?extid=c025d34b8eaa54c571b8
<7>  239     Yes   INFO: task hung in netdev_run_todo (2)
                   https://syzkaller.appspot.com/bug?extid=9d77543f47951a63d5c1
<8>  226     No    INFO: task hung in hub_event (3)
                   https://syzkaller.appspot.com/bug?extid=a7edecbf389d11a369d4
<9>  187     Yes   INFO: rcu detected stall in hub_event
                   https://syzkaller.appspot.com/bug?extid=ec5f884c4a135aa0dbb9
<10> 132     Yes   WARNING in cm109_urb_irq_callback/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=2d6d691af5ab4b7e66df

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
