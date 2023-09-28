Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B997B1B53
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjI1Lml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 07:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjI1Lmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:42:36 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2418B139
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 04:42:34 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3af59142cfaso6902521b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 04:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695901353; x=1696506153;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qTaDubZXEWSEPslgclOxwc7+Ad3m/lBvUqQUG3lQH1U=;
        b=E6w2E118UHs1P6NnbD5upuYBQj32jJ7sP+1TC1anoHRG/89MCyBg5EYBYd58NSD3td
         V970l4WWUOy4Gs9jE5xsu7CRBWItq9m3UooNUGaDFaOCT0ozmyh0uQ/P+gyp6p7fBYGc
         GuI8lTvXRfFJXqVvAd3D17dfM/0raGvOrozCoe85RNpAn+/2NpcrgPFUXs85C5fdHsOy
         4F8Pr+4xR1qNHJmBo7UPAOMbAQCh7r/k8JnhzMLii0MTfyYc9sdkud+SSA4zyVDrUZEG
         FjwRGOHhza33tCj6L21Fjli6EsLWdDYKrY/lGfUbqqddFoBzXkdwEMPFVLHef82S7i23
         o78A==
X-Gm-Message-State: AOJu0Yypbjkupep8+tn6nnz51vIHi8m5TZ6rXNIro6U62HGwre6TOcxv
        TSQwo1GZ7tPmIWXeEJACqlP8V+k5pcLZY/iSmIVVYb8+9D/Jrtw=
X-Google-Smtp-Source: AGHT+IGzJDdL7CGRqLCO9dfIof4cK7XxRZfPS6R1Yj25M96dgd53FV7gcHWycFeFD3YcwU49Wd3DOxR7JcS43H35tFBpUrBbu5Nt
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3086:b0:3a7:3ced:532a with SMTP id
 bl6-20020a056808308600b003a73ced532amr381328oib.7.1695901353486; Thu, 28 Sep
 2023 04:42:33 -0700 (PDT)
Date:   Thu, 28 Sep 2023 04:42:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bfaf33060669cd6b@google.com>
Subject: [syzbot] Monthly wireless report (Sep 2023)
From:   syzbot <syzbot+liste709cb91ac7b8a619720@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 2 new issues were detected and 0 were fixed.
In total, 28 issues are still open and 115 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5399    Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  4322    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<3>  3473    Yes   WARNING in ieee80211_rx_list
                   https://syzkaller.appspot.com/bug?extid=8830db5d3593b5546d2e
<4>  2422    Yes   WARNING in ieee80211_link_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=de87c09cc7b964ea2e23
<5>  2066    No    WARNING in ieee80211_ibss_csa_beacon (2)
                   https://syzkaller.appspot.com/bug?extid=b10a54cb0355d83fd75c
<6>  870     Yes   WARNING in __rate_control_send_low
                   https://syzkaller.appspot.com/bug?extid=fdc5123366fb9c3fdc6d
<7>  816     Yes   WARNING in ar5523_submit_rx_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=6101b0c732dea13ea55b
<8>  693     Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<9>  475     No    INFO: task hung in ath9k_hif_usb_firmware_cb (2)
                   https://syzkaller.appspot.com/bug?extid=d5635158fb0281b27bff
<10> 55      Yes   WARNING in ieee80211_free_ack_frame (2)
                   https://syzkaller.appspot.com/bug?extid=ac648b0525be1feba506

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
