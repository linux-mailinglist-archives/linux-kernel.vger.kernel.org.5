Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A517DBA38
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjJ3NAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjJ3NAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:00:34 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266B9C2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 06:00:32 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1ef5310a497so6623897fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 06:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698670831; x=1699275631;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JTjdLhPSR8o/s4EdG0NLUrckI4j66D3bWvV2ySVwA3Y=;
        b=dYkinJwX9hUywWVIhCKz8CmVgYj5JqgUTIXRPRrjdwLxVxbfLY3PojeLujo48KGQAN
         8khkVnOyTQtLGX89Q2++kD9sG9y9tsCkIsOa0UIft2OknzIdcYR57zN2dPWI/qbTDYAK
         Tm7O4o5mPMk2RV8djzs5deBDiV29+y+rlkcvDIeS0uW/LxIVwleAOiRqUZpeySgoshGR
         l3lzT/d0Mm/RNxkWNXqMMT5c50WjiWt12hUARtbHhaNcRLNAq+QDMitoRuMQXjjUFUms
         pg5l3Fss1ZZjAW9dDGHbrRR5h6DrKlJbSmK250IJ/6OC9gZny3ZTDKeUTNNip0tj/eJ8
         TqLg==
X-Gm-Message-State: AOJu0YyIRsq4ZcHs6N8mGvHuaJ6HTngsX+kx34nuIP86LSXXa1Q+UXRt
        2sYjiOyTz6Jhxky9KaXD5pOI4fu+5QGvDqdrUxbaP10qNgwWLEM=
X-Google-Smtp-Source: AGHT+IHbzZNuIVkbe0hpThrJ/UudcchJUGoS16Zn++U8CdurW9lVoNZBYPeISznISNT67JSyCiudAcXlS7q8gSiEAOryVqNDecws
MIME-Version: 1.0
X-Received: by 2002:a05:6870:3646:b0:1e9:dc1e:8384 with SMTP id
 v6-20020a056870364600b001e9dc1e8384mr4860767oak.5.1698670831553; Mon, 30 Oct
 2023 06:00:31 -0700 (PDT)
Date:   Mon, 30 Oct 2023 06:00:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081565c0608ee9ff7@google.com>
Subject: [syzbot] Monthly wireless report (Oct 2023)
From:   syzbot <syzbot+list5fc659ef9f99e160b97e@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 3 new issues were detected and 1 were fixed.
In total, 31 issues are still open and 117 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5673    Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  4356    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<3>  3473    Yes   WARNING in ieee80211_rx_list
                   https://syzkaller.appspot.com/bug?extid=8830db5d3593b5546d2e
<4>  2775    Yes   WARNING in ieee80211_link_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=de87c09cc7b964ea2e23
<5>  2440    No    WARNING in ieee80211_ibss_csa_beacon (2)
                   https://syzkaller.appspot.com/bug?extid=b10a54cb0355d83fd75c
<6>  940     Yes   WARNING in __rate_control_send_low
                   https://syzkaller.appspot.com/bug?extid=fdc5123366fb9c3fdc6d
<7>  824     Yes   WARNING in ar5523_submit_rx_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=6101b0c732dea13ea55b
<8>  706     Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<9>  477     No    INFO: task hung in ath9k_hif_usb_firmware_cb (2)
                   https://syzkaller.appspot.com/bug?extid=d5635158fb0281b27bff
<10> 87      Yes   WARNING in ieee80211_bss_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=dd4779978217b1973180

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
