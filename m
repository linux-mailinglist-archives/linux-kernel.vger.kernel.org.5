Return-Path: <linux-kernel+bounces-23828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5B882B264
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B566C1F23E11
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23C04F898;
	Thu, 11 Jan 2024 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUzp57/e"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792734EB5C;
	Thu, 11 Jan 2024 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e60e135a7so6081155e9.0;
        Thu, 11 Jan 2024 08:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704989114; x=1705593914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ge1javvkMyc2on9Y/XLUyyRYw7YHPVmAVzO564jDQSk=;
        b=HUzp57/eMCUmzJWOmHtiaYXthUB5rwXawDRTJcH2hWgkjs+Nykd2EqWXBsHQEv7ufd
         rCVZp7J0OjPRCKTPw091uVk1ghjIUyHiWWTfeUCzrRfxQFIWI/msgZ0cB/0lPsw5dKP1
         LIGZke24U8zbEUD7TTjwE6DWHTvqo91zW2g9anOk8woGYFywdk4g1+Bl2MdwDnaWB8/K
         1WQpNzpRBhIUijhCcdfIXH95fkf9hJnLXqzoQzBQyMj1A2EJI+1YjA6nnhcLSw/88/0I
         0tQM4B6s5abyHHaDEAq5goJ70EEdNKXr6D5PO9UrHvGGus6EYem9wxiw1plCN7FOolFG
         nkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704989114; x=1705593914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ge1javvkMyc2on9Y/XLUyyRYw7YHPVmAVzO564jDQSk=;
        b=cXarkyUYg8dzK80ooX0mIRqyuichcTdewVo9foeVYqBu+N+NazfjkI8B7saqUOgveb
         xdMCwuPlwX1CWTyqSu9eat8R4t5OnUWoIOOMuip8HPSKvs7KY7lJD0gb0l6KFrag6UW+
         AY1XV2M6pUAwbaQQerIZRXDvcrZgSJCHw8nL/n5hDt9uNRV+Ba/OJJgCb25b7Sf0P/og
         aJpHF23Cf5ty0XGQ39DsoLPyWoYMS3ujVwmtUeYNEvG1mIO1hBmgJeD/08tWQy3Ttc8o
         Cy1htIHQih9mJ1Mjf+efm1EwzmDs0DaK35vr58OpqSAGzH3GPUr2IS0BlY8rXqHCDcPv
         6ymQ==
X-Gm-Message-State: AOJu0YyKuMXAPmrtavqlo4F21qxNBqidpl4aHJh3/TAO/stiDDtj1R3I
	Z7f/l16iJWJbRvKkv+QStCc=
X-Google-Smtp-Source: AGHT+IHey3K3b83k+WVGbnrd9VKWvXoF/N5B3rQs0p6L50ESnIJWB0L0OxnPzqhoOmNe3fM0eNwY1Q==
X-Received: by 2002:a05:600c:2246:b0:40d:87eb:fa98 with SMTP id a6-20020a05600c224600b0040d87ebfa98mr37242wmm.28.1704989113327;
        Thu, 11 Jan 2024 08:05:13 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j17-20020a05600c1c1100b0040c46719966sm6350002wms.25.2024.01.11.08.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 08:05:12 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Li Zetao <lizetao1@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v7 2/2] docs: ABI: sysfs-class-led-trigger-netdev: Document now hidable link_*
Date: Thu, 11 Jan 2024 17:04:55 +0100
Message-ID: <20240111160501.1774-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111160501.1774-1-ansuelsmth@gmail.com>
References: <20240111160501.1774-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document now hidable link speed modes for the LED netdev trigger.

Link speed modes are now showed only if the named network device
supports them and are hidden if not.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Lee Jones <lee@kernel.org>
---
Changes v7:
- Add Reviewed-by tag (Lee)
Changes v6:
- Add Reviewed-by tag (Marek)
Changes v2:
- Add this patch

 .../ABI/testing/sysfs-class-led-trigger-netdev       | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-netdev b/Documentation/ABI/testing/sysfs-class-led-trigger-netdev
index a6c307c4befa..ed46b37ab8a2 100644
--- a/Documentation/ABI/testing/sysfs-class-led-trigger-netdev
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-netdev
@@ -88,6 +88,8 @@ Description:
 		speed of 10MBps of the named network device.
 		Setting this value also immediately changes the LED state.
 
+		Present only if the named network device supports 10Mbps link speed.
+
 What:		/sys/class/leds/<led>/link_100
 Date:		Jun 2023
 KernelVersion:	6.5
@@ -101,6 +103,8 @@ Description:
 		speed of 100Mbps of the named network device.
 		Setting this value also immediately changes the LED state.
 
+		Present only if the named network device supports 100Mbps link speed.
+
 What:		/sys/class/leds/<led>/link_1000
 Date:		Jun 2023
 KernelVersion:	6.5
@@ -114,6 +118,8 @@ Description:
 		speed of 1000Mbps of the named network device.
 		Setting this value also immediately changes the LED state.
 
+		Present only if the named network device supports 1000Mbps link speed.
+
 What:		/sys/class/leds/<led>/link_2500
 Date:		Nov 2023
 KernelVersion:	6.8
@@ -127,6 +133,8 @@ Description:
 		speed of 2500Mbps of the named network device.
 		Setting this value also immediately changes the LED state.
 
+		Present only if the named network device supports 2500Mbps link speed.
+
 What:		/sys/class/leds/<led>/link_5000
 Date:		Nov 2023
 KernelVersion:	6.8
@@ -140,6 +148,8 @@ Description:
 		speed of 5000Mbps of the named network device.
 		Setting this value also immediately changes the LED state.
 
+		Present only if the named network device supports 5000Mbps link speed.
+
 What:		/sys/class/leds/<led>/link_10000
 Date:		Nov 2023
 KernelVersion:	6.8
@@ -153,6 +163,8 @@ Description:
 		speed of 10000Mbps of the named network device.
 		Setting this value also immediately changes the LED state.
 
+		Present only if the named network device supports 10000Mbps link speed.
+
 What:		/sys/class/leds/<led>/half_duplex
 Date:		Jun 2023
 KernelVersion:	6.5
-- 
2.43.0


