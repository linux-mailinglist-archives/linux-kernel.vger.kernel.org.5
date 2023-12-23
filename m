Return-Path: <linux-kernel+bounces-10575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E6081D666
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 21:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021781F21FED
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 20:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579E015EB0;
	Sat, 23 Dec 2023 19:59:54 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E53415E99
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bac08a97c1so27704339f.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 11:59:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703361591; x=1703966391;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1kfJmhJKcf/fccgwHKZPrreJdcdZjh/nguV+pdm7xVY=;
        b=t36/n60dPvNrg1XPVmeyVXdlT0xGsEEv2DPrU4GGAt24qA/Kb+HDPxNH8w7ERRAFBl
         4urpmoPxjlvxMNMNPkzfscG4iw35M76k7fYcL6H0XURtdre0RAu5V1QRydD03WXk3C/i
         pV8LAyqyUXpfvH7yhHLutf43WKlK0nsAxztEGy8uW3zDGVN90OXaM4gh8Gm9DTLzF5Z4
         gvemnlD+mwaUXmudq7KIqkvylh5ZHyr70I/kYsIfIzDwp+56ry1LQXhEiZpdQDjKgdGJ
         pgWx9cQs/kgAUu2G6OXmuNbe3xpQSaA0LQI49MypwCMD82TxqtFxBn0dhShGRPbHhCRx
         VJwg==
X-Gm-Message-State: AOJu0YzXn1631ER85ZL18e3j9dMEvsOm+VMnIZ8X+1wsXtrE7HuWuo1d
	Ev8XvPL73DPVwcJ10t9+L1zaAplwfCJl/JMLfavMlouVCFZKUW8=
X-Google-Smtp-Source: AGHT+IER33aozZwavUjDuzHg+Oxxjgqo+zaBpPluwgqXN/Z4Mia788TZ3kL/s+b11aRkuRMmDn3yj6ouBm6fZW8Uu7a7YfXA8la7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e1:b0:35f:989c:a85b with SMTP id
 q1-20020a056e0220e100b0035f989ca85bmr310343ilv.6.1703361591827; Sat, 23 Dec
 2023 11:59:51 -0800 (PST)
Date: Sat, 23 Dec 2023 11:59:51 -0800
In-Reply-To: <000000000000d330500607d85a5f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ae37b060d32c643@google.com>
Subject: Re: [syzbot] [PATCH] usbhid: fix array-index-out-of-bounds in
 usbhid_parse UBSAN warning
From: syzbot <syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] usbhid: fix array-index-out-of-bounds in usbhid_parse UBSAN warning
Author: tintinm2017@gmail.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Look at the bug https://syzkaller.appspot.com/bug?extid=c52569baf0c843f35495 reported by syzbot. Tested a patch through syzbot, which gives an error. 
Requesting help from the maintainers to understand what is really going wrong in the code. 

Based on my understanding, I believe the value of the number of descriptors is calculated incorrectly before the for loop.

Signed-off-by: Attreyee Mukherjee <tintinm2017@gmail.com>
---
 drivers/hid/usbhid/hid-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index a90ed2ceae84..582ddbef448f 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1021,6 +1021,8 @@ static int usbhid_parse(struct hid_device *hid)
 	       (hdesc->bLength - offset) / sizeof(struct hid_class_descriptor));
 
 	for (n = 0; n < num_descriptors; n++)
+		if (n >= ARRAY_SIZE(hdesc->desc))
+			break;
 		if (hdesc->desc[n].bDescriptorType == HID_DT_REPORT)
 			rsize = le16_to_cpu(hdesc->desc[n].wDescriptorLength);
 
-- 
2.34.1


