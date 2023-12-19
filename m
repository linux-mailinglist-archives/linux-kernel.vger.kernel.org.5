Return-Path: <linux-kernel+bounces-5885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4268190FD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008E51F23A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E15B39AC8;
	Tue, 19 Dec 2023 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu4HmzQE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A1A3984A;
	Tue, 19 Dec 2023 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33664b4e038so2823327f8f.3;
        Tue, 19 Dec 2023 11:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703014954; x=1703619754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsKFunyIEF//ykMeSfV/a0SwdfxlBLJSsRhTiMN79G0=;
        b=iu4HmzQE8VWD2eX/2gjxVit6GWIeaE3Ta4WAy93Zr9lieSHOMcynckmZaCzY7rPNwV
         mVAb+aXDquIEWNoi6yvNhIKrSO4MNrZBgW3UXNIeT1Z1AoTy0Shltr0VqXvcW4M9XiUF
         jEj7oa6rYLqfSN4BzquWgDxcCkggDwDIXQ7D9YP9RNeObb5/9fpTOF7Xv8ReA7RrkGxr
         wwIae6d36BDkzD5CUgH6EAtmbr1QM+rP3+Kfhfbv/d1VKkBPflgPuVp/XO4d5ah9j0Vq
         XXbBg+Rli8P5gAFc1XatIaeqnwfWU7xL+kU6yG83UqB8QL8fXDkRMGFXsIxKcp2Hi6w+
         Rsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703014954; x=1703619754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsKFunyIEF//ykMeSfV/a0SwdfxlBLJSsRhTiMN79G0=;
        b=F8I99CzhOqrrkySA2ssgQT6uzFY+Vobic2Rld4KpbLj4l2Ne54enMWQLps5y7qMyxZ
         WgDTSe8UEkKoy4Y62WbmU1e4Al48E9m1KN7mCciVTPpgUKP3C5IjrmgvZg6k/xYWqMx/
         dYpjjtgWjZCUpHLnw8rbyjRGAh9vEPwpw5aoJTQ26wfwUfqiX8/vgKJJnYY/1MMA35o8
         uNLbosbfL7txi0Fs0HdDqaVh86ERnTnjGMeHoj3J60nZbbvoOJcO+k1MPnT5dZXlHEwF
         kmZL9Fw17PmN4qcPVbVDN3fb8kVZkLM7LZqzEnj3mfKlHg15dpXs94SFJAzvonc7ABUj
         lZng==
X-Gm-Message-State: AOJu0Ywu3Z2qS8m9yWSEVTZchPpxCE3Mb+/ArcZqFt47KX0JJZElpzxd
	8BIxOkkC+sF6m2L40QF0FPE=
X-Google-Smtp-Source: AGHT+IGLcJA09AG2A4iz8tglFN5r93D1NbZTKKSC9pIZr6zAKcMq5LkcjPLvJ/zxmHcAoujRLQARUQ==
X-Received: by 2002:adf:ef04:0:b0:336:6907:cbb4 with SMTP id e4-20020adfef04000000b003366907cbb4mr1681121wro.53.1703014953480;
        Tue, 19 Dec 2023 11:42:33 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id f18-20020adffcd2000000b0033660aabe76sm9131524wrs.39.2023.12.19.11.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 11:42:32 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Li Zetao <lizetao1@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v4 2/2] docs: ABI: sysfs-class-led-trigger-netdev: Document now hidable link_*
Date: Tue, 19 Dec 2023 17:53:53 +0100
Message-Id: <20231219165353.23233-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231219165353.23233-1-ansuelsmth@gmail.com>
References: <20231219165353.23233-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document now hidable link speed modes for the LED netdev trigger.

Link speed modes are now showed only if the named network device
supports them and are hidden if not.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
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
2.40.1


