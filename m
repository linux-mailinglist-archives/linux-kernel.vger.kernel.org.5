Return-Path: <linux-kernel+bounces-72468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CAF85B3E6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F001F21F74
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DC95A7A0;
	Tue, 20 Feb 2024 07:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnIGnxia"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF815A780;
	Tue, 20 Feb 2024 07:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413867; cv=none; b=EDih0hlGYmJZWgocav8va7Eo9tISs0UW3bzwwzDBNQR6jlbtgS/71m45pqKupMGgl2Qttn6s8yL8V9fsB/rtpwPIwoL1Kqk/yFkwXU4jerxa7X9d3mrO7NyNFXXe8xw+XHBPr19sbeD3lEBagFUOMrIs1zYGBlcEGZ+0TSmE9Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413867; c=relaxed/simple;
	bh=EeE4AlogZWmof4+1Rdj/5hdch7Ym4f/hZzssGvkV88Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Zo10cRXawXYqxkDJ36Ddz3j5iEXGTVcuGicVNA1q2v+FAt0kJXjM9Y0HNSWxp4nhMqUIc6IoLVeKGHN801veRr27mxsH0GMeq7QEApP78qzo4RHwLAmqudAKu+qyHWfCQSwl013MHg1s2B1qyilEg/PaSCJfAKXLXzwFqvbZw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnIGnxia; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-1d7354ba334so46559955ad.1;
        Mon, 19 Feb 2024 23:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708413865; x=1709018665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RwZPEQqi5vRm0n5e0HWhps0mr3zdrb62kOUW5wKsWDs=;
        b=gnIGnxia1XlDhsMD6rrZoqPNLmX9b2Vi5a+rQXXbqunu3VEZq/ucw3WQr5GLWHj5IY
         Cc8CgEJ3Cpgfx3qR1N0pA84gFf07QFx6L4Ej20EULVJIQ0yQv04PCOwtLu7ZWxL+Gxym
         dMn+XhAFqno6y3I/UULr37FIRscoyo9tLXf6pWSMYovpwP3spX0BfUgRfQIAPjp277/3
         x3znMU/PVN/QmJ6I3MAwDkzWvKNz3lNDgG4VyI3MgdFUFU59UtFeIcnGh9pGOCpairKX
         YDDw2oWE3P3k7GjSUlEi6U6wuVUhWokD1jS1uGPTxmrk6nKIWD1NtNnJ6++J1aAYyNIL
         l1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708413865; x=1709018665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RwZPEQqi5vRm0n5e0HWhps0mr3zdrb62kOUW5wKsWDs=;
        b=iWdz6m+pN9XVZNCXNK9MBHDUEKXbhY/pdRsDsOjgbM66yyv3ZralVUYzUeek1tw1cX
         wUH5IPKUyEtHLET9dz8zw2wqp2eDkqJH17dFc+awi1WNTyZ3tGcdHBzEMOA3y/K1XzNi
         fEeIGOfleMFlRgQjeTD1UtvaCoteOaWFAzyg5w8/v25IkRmqpsKwhWoTib+MGYBpVHOn
         Y5SwgM1QfZA5/zY3i1xwb3xhGAcLDmguphTSa6YN0rQYEEKLko2BZ0wtVxKCHC4EH+4V
         TrLZ1/67MejyKSq1jnHdwiI9jeh43DC+r3/c45rnNmcaUUY5r7Ce4rw8eEAow0kevLEF
         kHGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw6f2swiZWReJ4tIfK1KnJFFgaA9KuKUETKZhADcjMCiJpsVFPItntZ5q1wHU8yD6Yj4dzUW3IOqEdx0Leyic9GJnhobusaeTN/j4R
X-Gm-Message-State: AOJu0Yzfz6P+zuIYK/rOjEeHBBfQ0ozyzk0M5tcoXq+kalbtx/ew1Pbz
	sSuTexJZCKZ7NQsf4geo4o8rvs3kuzWYZ+9NUFFOfQkrE4R2S34D
X-Google-Smtp-Source: AGHT+IFDZ1Vn5gvkuFy1Y9kEprmwgAErRRmtPW/kCryRk5tmCB/kjftganFKTAr9l4OZRYwMhiRmUw==
X-Received: by 2002:a17:903:11cd:b0:1db:82e3:8d7f with SMTP id q13-20020a17090311cd00b001db82e38d7fmr19448176plh.16.1708413864548;
        Mon, 19 Feb 2024 23:24:24 -0800 (PST)
Received: from ubuntu.localdomain ([137.220.142.132])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902748700b001d9ef367c85sm5510053pll.104.2024.02.19.23.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 23:24:24 -0800 (PST)
From: buckzhangwh@gmail.com
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	weihui zhang <buckzhangwh@gmail.com>
Subject: [PATCH] drivers:usb:disable usb hub&port async suspend to avoid block system PM
Date: Mon, 19 Feb 2024 23:24:13 -0800
Message-Id: <20240220072413.4026-1-buckzhangwh@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: weihui zhang <buckzhangwh@gmail.com>

many phones are crashed and unable to wake up by power key.
We analyzed more than ten kernel-dumps, 
the common was  that system were all blocked by usb.
the phone doesn't crash again,after we disable usb hub&port async suspend.

here is one kernel-dump analysis case:
task 446 & 4511 &365 state are Uninterrupt
task 446 dpm_wait_for_superior then schedule out.

PID: 446  TASK: ffffff81f3e9cb00 CPU: 4 COMMAND: "charge"

 #0 [ffffffc015a0b9a0] __switch_to at ffffffc010088b54

 #1 [ffffffc015a0b9f0] __schedule at ffffffc010f7ef2c

 #2 [ffffffc015a0ba40] schedule at ffffffc010f7f3a4

 #3 [ffffffc015a0baa0] async_synchronize_cookie_domain at 

 #4 [ffffffc015a0bb00] async_synchronize_full at ffffffc010131e0c

 #5 [ffffffc015a0bb10] dpm_resume at ffffffc0107ec408

 #6 [ffffffc015a0bb70] dpm_resume_end at ffffffc0107ed0e8

 #7 [ffffffc015a0bbb0] suspend_devices_and_enter at ffffffc0101776d8

 #8 [ffffffc015a0bbf0] enter_state at ffffffc010177e70

 #9 [ffffffc015a0bc20] pm_suspend at ffffffc010177d5c

PID: 4511 TASK: ffffff8153b0e740 CPU: 6 COMMAND: "kworker/u16:11"

 #0 [ffffffc01bc9baa0] __switch_to at ffffffc01010293c

 #1 [ffffffc01bc9bb10] __schedule at ffffffc0116b0008

 #2 [ffffffc01bc9bb70] schedule at ffffffc0116b0794

 #3 [ffffffc01bc9bbe0] schedule_timeout at ffffffc0116b6c2c

 #4 [ffffffc01bc9bc40] wait_for_common at ffffffc0116b198c

 #5 [ffffffc01bc9bca0] dpm_wait_for_superior at ffffffc010b999e8  

 #6 [ffffffc01bc9bce0] device_resume at ffffffc010b9d804 
//x0(struct device)= ffffff81f32a3808

 #7 [ffffffc01bc9bd10] async_resume at ffffffc010b9d6ec

 #8 [ffffffc01bc9bd40] async_run_entry_fn at ffffffc0101e238c

 #9 [ffffffc01bc9bdb0] process_one_work at ffffffc0101d00e0

crash_arm64> struct device ffffff81f32a3808 -x

struct device {

  kobj = {

    name = 0xffffff81f15c6d80 "usb1-port1",

    entry = {

      next = 0xffffff81f32a6018,

      prev = 0xffffff81e4103838

    },
 type = 0xffffffc0124102b8 <usb_port_device_type>,

  bus = 0x0,

  driver = 0xffffffc0124102e8 <usb_port_driver>,

    async_suspend = 0x1,
  ...........

PID: 365 TASK: ffffff81f3bf6900 CPU: 0 COMMAND: "kworker/u16:5"

 #0 [ffffffc0158dbac0] __switch_to at ffffffc010088b54

 #1 [ffffffc0158dbb10] __schedule at ffffffc010f7ef2c

 #2 [ffffffc0158dbb60] schedule at ffffffc010f7f3a4

 #3 [ffffffc0158dbbe0] schedule_timeout at ffffffc010f83fd8

 #4 [ffffffc0158dbc40] wait_for_common at ffffffc010f80600

 #5 [ffffffc0158dbc90] wait_for_completion at ffffffc010f8051c

 #6 [ffffffc0158dbcb0] dpm_wait_for_superior at ffffffc0107eee00

 #7 [ffffffc0158dbd00] device_resume at ffffffc0107ec6a8 
//x0(struct device) = 0xffffff81ee1b3030

 #8 [ffffffc0158dbd40] async_resume at ffffffc0107ec588

 #9 [ffffffc0158dbd60] async_run_entry_fn at ffffffc010131c60

 crash_arm64> struct device ffffff81ee1b3030 -x

struct device {

  kobj = {

    name = 0xffffff81f1fc1500 "1-0:1.0",

	  type = 0xffffffc011b62a38 <usb_if_device_type>,
 ............

Signed-off-by: weihui zhang <buckzhangwh@gmail.com>
---
 drivers/usb/core/hub.c     | 2 +-
 drivers/usb/core/message.c | 2 +-
 drivers/usb/core/port.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index e38a4124f..de74f70e5 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2602,7 +2602,7 @@ int usb_new_device(struct usb_device *udev)
 		add_device_randomness(udev->manufacturer,
 				      strlen(udev->manufacturer));
 
-	device_enable_async_suspend(&udev->dev);
+	device_disable_async_suspend(&udev->dev);
 
 	/* check whether the hub or firmware marks this port as non-removable */
 	set_usb_port_removable(udev);
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 077dfe48d..944f01aa7 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -2203,7 +2203,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 			"adding %s (config #%d, interface %d)\n",
 			dev_name(&intf->dev), configuration,
 			intf->cur_altsetting->desc.bInterfaceNumber);
-		device_enable_async_suspend(&intf->dev);
+		device_disable_async_suspend(&intf->dev);
 		ret = device_add(&intf->dev);
 		if (ret != 0) {
 			dev_err(&dev->dev, "device_add(%s) --> %d\n",
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index c628c1abc..97696c415 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -760,7 +760,7 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 	pm_runtime_set_active(&port_dev->dev);
 	pm_runtime_get_noresume(&port_dev->dev);
 	pm_runtime_enable(&port_dev->dev);
-	device_enable_async_suspend(&port_dev->dev);
+	device_disable_async_suspend(&port_dev->dev);
 
 	/*
 	 * Keep hidden the ability to enable port-poweroff if the hub
-- 
2.17.1


