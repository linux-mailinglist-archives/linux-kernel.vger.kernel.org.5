Return-Path: <linux-kernel+bounces-7609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8BC81AAC6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859D81C211BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401E14CB4D;
	Wed, 20 Dec 2023 22:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwOXiCHa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D6A4C634;
	Wed, 20 Dec 2023 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d05ebe642so7820055e9.0;
        Wed, 20 Dec 2023 14:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703112545; x=1703717345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsKFunyIEF//ykMeSfV/a0SwdfxlBLJSsRhTiMN79G0=;
        b=ZwOXiCHasH2dqJ1hZ0lVqm8bm7LQXXSUC15smv25RqICJmzN4MAsbLI5CX4qvmw3iI
         LKxh7hgd3qxi9z0OL6GzDafXySkTYoMjgTlNHPGoh6m8HcXMEpvfGIZbladbsuMhZBvN
         x+FhIcbmV04Af0J+LLkMzzjIFSuieleslJaEiz1gRZPuvhv6haZm+XWuueLmM1JyzvSu
         iBOI0hP7B9Mo5Ov+GkrgxSjRH1MpwFjtaS/a1D8f0Laej7AO0zMwQzQushs/mKfWuQQ1
         gjfkShuNuKVUc0c2o4b9HnVadte0uyRn1UJC5/6n56fyCOtp2iEpYOWf8c4dyuaAOopt
         +gSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703112545; x=1703717345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsKFunyIEF//ykMeSfV/a0SwdfxlBLJSsRhTiMN79G0=;
        b=UWtEsrvD2m6nKQrareyGTGlbVylIn+bwtEW3y8ywdx32kfLi6KmLEpmZVAo68Qm8C4
         q2Kai5EfFLbZ1KpqKKmoplFEmQIL4WuVJFGQKLUQ4XchQAZrj+G5DClbhe8ETMTIfLPQ
         H2thKnMVuf9NaeWFewFlu4JpvcoI7fRDT8cghNkEd1Eplccvk6Jl4k/8aS5HchO7/XOh
         +HOQcTL32+UzMgqYOhmWPxEuhr+ptMrr31L5P4wCSruo774qFJSkSYE2SvwJSEIwlpXS
         5pxTR2vz3XWP94k4u2CU7AGRD6Zgek1q5IS31Qo4Fg4o70nWkQc1ykihH0XxHZ5EXKK9
         +h+Q==
X-Gm-Message-State: AOJu0Yw14VUrMGl4C2HpblmMhhK4AZuByDSAoaAh2Dzi7ctJsHsCHQ+D
	oaM/DZqhvxhAZUKkZr1QXMU=
X-Google-Smtp-Source: AGHT+IE0GQS8h9Bn6EEDpz71Q3KqeYEHpWCA6O//K+GbvqyOaflgKNE6Gt2tJdtve2W+HxxxigiJlQ==
X-Received: by 2002:a7b:ce0f:0:b0:40c:3c2b:b72e with SMTP id m15-20020a7bce0f000000b0040c3c2bb72emr142289wmc.116.1703112544559;
        Wed, 20 Dec 2023 14:49:04 -0800 (PST)
Received: from localhost.localdomain (host-95-250-248-68.retail.telecomitalia.it. [95.250.248.68])
        by smtp.googlemail.com with ESMTPSA id bi8-20020a05600c3d8800b0040d28bbaf7bsm8220838wmb.10.2023.12.20.14.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:49:04 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Li Zetao <lizetao1@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v5 2/2] docs: ABI: sysfs-class-led-trigger-netdev: Document now hidable link_*
Date: Wed, 20 Dec 2023 23:48:27 +0100
Message-Id: <20231220224827.27667-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231220224827.27667-1-ansuelsmth@gmail.com>
References: <20231220224827.27667-1-ansuelsmth@gmail.com>
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


