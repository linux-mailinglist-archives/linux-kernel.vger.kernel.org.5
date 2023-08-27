Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30640789FBA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 16:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjH0OG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 10:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjH0OGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 10:06:10 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA5B128
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 07:06:05 -0700 (PDT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1c08a6763b3so28932515ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 07:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693145165; x=1693749965;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DEsVrIr97VEhELJ+S8m4nEcUrnz7jIH9M5zgjazlI78=;
        b=HSh7sGTVPqJGLDG7HORG3H++ATDSfO61RcZK/i7lVxNMYlf2o54rXOqfHRxeMP34VR
         Vh+lSy0i0VFAPX+QxSvq1vAB6s8wa1FJFISE6gpxRieT5cwpQs89fm1JcdsFCEdj8OJO
         OUkRNxUDn0+HKd1dzesd2ETqj8sHgunrJb195ukNKgGFvp4H4b0O3iNLNBaNpHDmMwOc
         aI1KaQbwwmkeAc+ndzWziY8Wv31OlctAE4UVcLOcStwEASnhk42R//3lSOp06RBDdWwF
         EtIRxCLEZX2xwlIxrlFukCzSuknmyLvhGQ/1WnhGD3AU0Sa+G4SDwU9u9C/2qftQXZx2
         k3dw==
X-Gm-Message-State: AOJu0YzqjpzvWCkpVs6Xe1xK20F3gNE9H5f5dS2ZAD3DIyupsy45Y+J5
        Tm4jnydIF5FlZ1d+ly/ax5SF/zxBwkvMKTN5f4uXBTWZfqlDFDw=
X-Google-Smtp-Source: AGHT+IHWrDKyUSOIV/Ua3zI464JtXwvhPeWH7YdvGxLbS0EZjCOvbGJETdl14zoIH3fDGS0QfSWpeaPeLJW2C3/hGz0qXUuOiMd+
MIME-Version: 1.0
X-Received: by 2002:a17:902:d48e:b0:1bc:4c3d:eb08 with SMTP id
 c14-20020a170902d48e00b001bc4c3deb08mr8010736plg.8.1693145165547; Sun, 27 Aug
 2023 07:06:05 -0700 (PDT)
Date:   Sun, 27 Aug 2023 07:06:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025510c0603e814e3@google.com>
Subject: [syzbot] Monthly wireless report (Aug 2023)
From:   syzbot <syzbot+listf421a02dce8c614d0752@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
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

During the period, 1 new issues were detected and 0 were fixed.
In total, 27 issues are still open and 114 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4261    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<2>  3471    Yes   WARNING in ieee80211_rx_list
                   https://syzkaller.appspot.com/bug?extid=8830db5d3593b5546d2e
<3>  1969    Yes   WARNING in ieee80211_link_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=de87c09cc7b964ea2e23
<4>  1762    No    WARNING in ieee80211_ibss_csa_beacon (2)
                   https://syzkaller.appspot.com/bug?extid=b10a54cb0355d83fd75c
<5>  812     Yes   WARNING in ar5523_submit_rx_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=6101b0c732dea13ea55b
<6>  801     Yes   WARNING in __rate_control_send_low
                   https://syzkaller.appspot.com/bug?extid=fdc5123366fb9c3fdc6d
<7>  689     Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<8>  465     No    INFO: task hung in ath9k_hif_usb_firmware_cb (2)
                   https://syzkaller.appspot.com/bug?extid=d5635158fb0281b27bff
<9>  43      Yes   WARNING in carl9170_usb_submit_cmd_urb/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=9468df99cb63a4a4c4e1
<10> 41      Yes   WARNING in ieee80211_free_ack_frame (2)
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
