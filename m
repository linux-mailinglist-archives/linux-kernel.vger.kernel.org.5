Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F23801319
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379375AbjLAStU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjLAStT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:49:19 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880D910DA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:49:22 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ce02f230a8so1129564b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701456562; x=1702061362;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V7uf/nKmgeB4s8AOYp5odSuJMyINXnSr8QWYtuxIBzY=;
        b=jPo/4SmuGW8IVpko4VJBoIm0rb/XTwnrHpZlrvrounmsJErWPtPGluO2O3se0FGRFp
         j3eyGOvx4P6JnE+a7+GvKBnhskGsmBDVR5cOGLCm2AZQMsouZECuG5AAMxdXV1S5AHbF
         FplYKejx0TCIZy23jfCs7ZmmC+59hA8/HEuYCaSMEWKUAK1kwS7jHhNnS7LDsWz3nlt2
         zMawBE0GTD1i2XMmDWbPt7xiRhHaB2PR19DkcMVZ2nDpqDy3h59B73pzniALVW5lpvod
         wM4huADfMg3Bnd049KDpRkiVUOB2a55rTkRdKtj8EuChORWnLeUDGDHxxmvdyjG3UYAQ
         6raA==
X-Gm-Message-State: AOJu0YwqNxZ9aKWwyOHiM377G8D+pYZgly8ULGnZ7BQS4TLl/mN6JApc
        mx2Zcs0DlGWlEO7Jhq0h88cMk1IKGawDR3xT1az74l55Ac6pvPU=
X-Google-Smtp-Source: AGHT+IGUlw4/hagoD6X3KinajDD/07g+mo7vw/4QKPKJaydC8FYQx5YjjtYPkMk1e4oyqU+KF7hBYuo2j8nElT2I5fPFt+RJv8tj
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:b4c:b0:6ce:d0:118c with SMTP id
 p12-20020a056a000b4c00b006ce00d0118cmr381472pfo.6.1701456561791; Fri, 01 Dec
 2023 10:49:21 -0800 (PST)
Date:   Fri, 01 Dec 2023 10:49:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f76a65060b7739da@google.com>
Subject: [syzbot] Monthly wireless report (Nov 2023)
From:   syzbot <syzbot+listd3e5fd84a00bcad8b79e@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 1 new issues were detected and 0 were fixed.
In total, 32 issues are still open and 117 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5951    Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  4366    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<3>  3474    Yes   WARNING in ieee80211_rx_list
                   https://syzkaller.appspot.com/bug?extid=8830db5d3593b5546d2e
<4>  3175    Yes   WARNING in ieee80211_link_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=de87c09cc7b964ea2e23
<5>  2663    No    WARNING in ieee80211_ibss_csa_beacon (2)
                   https://syzkaller.appspot.com/bug?extid=b10a54cb0355d83fd75c
<6>  984     Yes   WARNING in __rate_control_send_low
                   https://syzkaller.appspot.com/bug?extid=fdc5123366fb9c3fdc6d
<7>  829     Yes   WARNING in ar5523_submit_rx_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=6101b0c732dea13ea55b
<8>  734     Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<9>  357     Yes   WARNING in ieee80211_bss_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=dd4779978217b1973180
<10> 61      Yes   WARNING in ieee80211_free_ack_frame (2)
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
