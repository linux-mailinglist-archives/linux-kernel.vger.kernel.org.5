Return-Path: <linux-kernel+bounces-15405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EAE822B94
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA311F22570
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B1718E31;
	Wed,  3 Jan 2024 10:47:23 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955F718E0D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bbb3de4dcbso240102039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 02:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704278841; x=1704883641;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/q3fX7yfr4+OxT/fgvLyZ0FBGYrlGsDU4PTbrFMXMU=;
        b=PReLrBamokgx3Q0pX7s+mvktqoNEbSx/d4CDRhrzUczFqGL/Zk3mCCHNCsQ6shr3Md
         v2nunCjLhFvMI6dHppuwF9Fj2hRwLRtL0neEEmXnlv63gb2bgN5/fX+vatLODW78AOcw
         RvpeCSeOkiQAhnz6UEGV7Uiz0MbbbcGI6HLsXpYuEXqUBqha4TK+0XnlX8+HRkJZHwLN
         26dLRHtSAEk2dwfKXZJQdU6h0z8cfdhBYcuML0P410AQnOt55uuNxQmyNh2duT/aerlt
         5zApZWbkXB+uDQI22R5M67BsFP0ah1ACnCh7Lk6UY51BEZC+vlSlvUiwoO/wkfBiLWMG
         xFIw==
X-Gm-Message-State: AOJu0YyIO3wQg1mudxtT19Fsl1m1whJMu2FtQmvWEJf7TsSq/rEmb4JN
	/kFKzEChgfOBCjoBv0wog3NCdU/oJ8tJTGVEY/EJyq4aHOFrI/A=
X-Google-Smtp-Source: AGHT+IF+FHvBiFwTjzjx9Sl+fixAoS3nuebFzJcxhwO8WYaTRSv/XaTiDQiVzT4ZY+vs8TKQ/L+uZlA6cALEF5IwX/UhPcRY/XBS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2d:b0:35f:f683:f817 with SMTP id
 g13-20020a056e021a2d00b0035ff683f817mr2185154ile.5.1704278840869; Wed, 03 Jan
 2024 02:47:20 -0800 (PST)
Date: Wed, 03 Jan 2024 02:47:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8ad89060e0856f8@google.com>
Subject: [syzbot] Monthly wireless report (Jan 2024)
From: syzbot <syzbot+list2ced74a42cd2d7138cf6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 0 new issues were detected and 0 were fixed.
In total, 30 issues are still open and 119 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6261    Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  4378    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<3>  3715    Yes   WARNING in ieee80211_link_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=de87c09cc7b964ea2e23
<4>  2836    No    WARNING in ieee80211_ibss_csa_beacon (2)
                   https://syzkaller.appspot.com/bug?extid=b10a54cb0355d83fd75c
<5>  842     Yes   WARNING in ar5523_submit_rx_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=6101b0c732dea13ea55b
<6>  744     Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<7>  507     Yes   WARNING in ieee80211_bss_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=dd4779978217b1973180
<8>  65      Yes   WARNING in ieee80211_free_ack_frame (2)
                   https://syzkaller.appspot.com/bug?extid=ac648b0525be1feba506
<9>  46      Yes   WARNING in carl9170_usb_submit_cmd_urb/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=9468df99cb63a4a4c4e1
<10> 38      Yes   WARNING in ar5523_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=1bc2c2afd44f820a669f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

