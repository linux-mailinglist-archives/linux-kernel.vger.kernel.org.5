Return-Path: <linux-kernel+bounces-8818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F04B81BCAB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F131C21E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E798627E1;
	Thu, 21 Dec 2023 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/Ks9dfX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A505990D;
	Thu, 21 Dec 2023 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c6ea99429so11290215e9.3;
        Thu, 21 Dec 2023 09:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703178704; x=1703783504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hihuwD9LbPKxqf+5u/wIYAygOzw3x2ScxGnztieWIY=;
        b=g/Ks9dfXIIRlAeccp1BL6Hc+uoIGLlwxajFeImZtV0TTPG2n/+RWHLuGHgVaLBTb4P
         uccFoARcW26L7aDOTB3JSKh+lOk9Aci3+Qovryxhit7LQ6HzkPg2AdnjpwnGgbYvwKUU
         3tfvHDpseJk696liEfp8TA3s0Vkn/9k9LyunA5jR62EvbyUVKo6ETbolTNRaVfeCyysv
         +HMmIXJsDxaS4C8H49cW1zFYx23519wWrNQTShCPO85nNo1mIO9r7b3loNRXjYAE1x0M
         4aOTj8AWJMenS/t9/V2PfQHTLOhVsCU9PiGmEtISFZ1pvOYGHRU1gYAQ1bJVGA1NUGeY
         HykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703178704; x=1703783504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hihuwD9LbPKxqf+5u/wIYAygOzw3x2ScxGnztieWIY=;
        b=I+0hY+zeF/kFcPXjwRur8bBXW06ILEQqdMch6bXNlmxlAWXd5lSTAsaiHEtot2MnEO
         +olIJGnQsaVz5GjOj2bjGmfaw3g9fbOlmcF0/gCXOidLZISbZDyUFgbpZFT/0+3oGppd
         FA+ZTqKHGmMEzR3TTR+HdLNvmInVSIzNSb7d/p4cVnABuo1J4/oEu1MrArojqbrYOfY2
         p5dD6aApeOFbA37dOJLHaNfFC8T0JKSn1Rf5yXWivpx7WRB4bpryZ40UmdPOFzkIV6z3
         wJ0ChozBSp7JB9+j6RCpd3jFiNdUd/NqM7wEJbw5jj/GdvjgWLZclMr888ZdTkyq0TTW
         siCA==
X-Gm-Message-State: AOJu0YypXUqaKhI48mu/5p220ZwaR7xfB1BFNcZnxuagZxecKOegA05S
	sjidWfRZ6DjenICilP4lfhk=
X-Google-Smtp-Source: AGHT+IGBLVnxRHlRMvofJQB+iAIQbr0MCLIkNX2d66hvC70LVg7/zeoDCXf5ihKWKFF0V53VJ9pg5Q==
X-Received: by 2002:a05:600c:b8f:b0:40c:3548:1f0e with SMTP id fl15-20020a05600c0b8f00b0040c35481f0emr15196wmb.64.1703178704340;
        Thu, 21 Dec 2023 09:11:44 -0800 (PST)
Received: from localhost.localdomain (host-95-250-248-68.retail.telecomitalia.it. [95.250.248.68])
        by smtp.googlemail.com with ESMTPSA id m20-20020a05600c4f5400b0040c44b4a282sm4020727wmq.43.2023.12.21.09.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:11:44 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Li Zetao <lizetao1@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v6 2/2] docs: ABI: sysfs-class-led-trigger-netdev: Document now hidable link_*
Date: Thu, 21 Dec 2023 18:11:25 +0100
Message-Id: <20231221171125.1732-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231221171125.1732-1-ansuelsmth@gmail.com>
References: <20231221171125.1732-1-ansuelsmth@gmail.com>
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
---
Changes v6:
- Add Reviewed-by tag
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


