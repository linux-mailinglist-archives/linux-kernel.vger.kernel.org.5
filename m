Return-Path: <linux-kernel+bounces-202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5556F813D66
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A8FEB209C8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013396E2C2;
	Thu, 14 Dec 2023 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaM6CsDX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DDE6A34D;
	Thu, 14 Dec 2023 22:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c38de1ee4so720065e9.0;
        Thu, 14 Dec 2023 14:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702593516; x=1703198316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tI12aCWJQCHdnL9tpy1TZqFUoLiTbzcedlrkIrXRyzo=;
        b=gaM6CsDXN9QTmZ+6tuMHtvQBtsZyL+6jo0kQtDGBFUdLQsHYspNnvIucVWR2cYaX9q
         9BMSfEKtMMhg+cBnjZBzJ/vnLiiaXoIEYOGLQVYqFo0FcWbZphwQlvnih5TjuoYFf/ZF
         suyMFPhZHnTwYxft20sAb2hSkEebwkhHEKW0lBdKFcoVPyw/CSCdAzwoS64KvOqESTYR
         8S1Lt9AvRaUvMbNHxWfVupBFDYBKCuQT21RW6D1K3c188LSe7vr6e2STNY8DNsFRsQOS
         uL06OXcXIH/30wN5WXFsh6nupeBNUgraWgX+HW/4RjbALScpIJPMAEvghrYCh1s2lmgk
         lzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702593516; x=1703198316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tI12aCWJQCHdnL9tpy1TZqFUoLiTbzcedlrkIrXRyzo=;
        b=jYCSJ5BmWj831aV+KylsBg6YH96KpPalN12AdU8BRbszXyGQuW4m/1SBUVz7IKulN4
         C6wWxe4avsVJigSyaNbasgcPFhBJrrVk9G/FXVRfOboFLwb9bBPT9KqHXfTy20yEwF6J
         /hb5qQH400W3JVCliDFnWYke7x3sdVu/M0vTGAbJ0Gsrs5h9qfJl/JzTOfLP1lXA66zN
         4NCkhYemF3GwfjSUr2u9SyQlNlVioOSXv7b8u6LAZfyQuOx/QfiS7mvpXXk2VF4QvQa8
         lRUHS7+eays/zpagMfFZTcnd7i/2wG+mpxAx9YbcLv/Zc7ZK+t+udolOeC4o70dBm6bd
         Jb3g==
X-Gm-Message-State: AOJu0YyEch4sL7Z7Ynd2rEm5tagj16eKR3L+VlIpY7vBmmd8Qq7IYTZ6
	JxMhGMpVaPa8snRhcTzgxD4MTFlbGOE=
X-Google-Smtp-Source: AGHT+IFdoARMWmZNzhKw0rwFY0f1WPM6SFtGq0GrsXkXpKS4ch37Yu7Qx+DrPnfxw4CUT6SR/0KkkQ==
X-Received: by 2002:a05:600c:1f1a:b0:40c:31f1:145c with SMTP id bd26-20020a05600c1f1a00b0040c31f1145cmr5011868wmb.169.1702593515923;
        Thu, 14 Dec 2023 14:38:35 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id n41-20020a05600c3ba900b0040c61ee0816sm54746wms.0.2023.12.14.14.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:38:35 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v2 3/3] net: phy: led: dynamically allocate speed modes array
Date: Thu, 14 Dec 2023 16:49:06 +0100
Message-Id: <20231214154906.29436-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231214154906.29436-1-ansuelsmth@gmail.com>
References: <20231214154906.29436-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of defining a big enough array for speed modes use the newly
introduced API to get the actual number of supported speed modes and
dynamically allocate them.

Allocated space is freed at the end of the LED register loop.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy_led_triggers.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy_led_triggers.c b/drivers/net/phy/phy_led_triggers.c
index f550576eb9da..2e41d10e323c 100644
--- a/drivers/net/phy/phy_led_triggers.c
+++ b/drivers/net/phy/phy_led_triggers.c
@@ -83,14 +83,21 @@ static void phy_led_trigger_unregister(struct phy_led_trigger *plt)
 
 int phy_led_triggers_register(struct phy_device *phy)
 {
+	unsigned int *speeds;
 	int i, err;
-	unsigned int speeds[50];
 
-	phy->phy_num_led_triggers = phy_supported_speeds(phy, speeds,
-							 ARRAY_SIZE(speeds));
+	phy->phy_num_led_triggers = phy_supported_speeds_num(phy);
 	if (!phy->phy_num_led_triggers)
 		return 0;
 
+	speeds = kmalloc_array(phy->phy_num_led_triggers, sizeof(*speeds),
+			       GFP_KERNEL);
+	if (!speeds)
+		return -ENOMEM;
+
+	/* Presence of speed modes already checked up */
+	phy_supported_speeds(phy, speeds, phy->phy_num_led_triggers);
+
 	phy->led_link_trigger = devm_kzalloc(&phy->mdio.dev,
 					     sizeof(*phy->led_link_trigger),
 					     GFP_KERNEL);
@@ -123,6 +130,8 @@ int phy_led_triggers_register(struct phy_device *phy)
 	phy->last_triggered = NULL;
 	phy_led_trigger_change_speed(phy);
 
+	free(speeds);
+
 	return 0;
 out_unreg:
 	while (i--)
@@ -134,6 +143,7 @@ int phy_led_triggers_register(struct phy_device *phy)
 	devm_kfree(&phy->mdio.dev, phy->led_link_trigger);
 	phy->led_link_trigger = NULL;
 out_clear:
+	free(speeds);
 	phy->phy_num_led_triggers = 0;
 	return err;
 }
-- 
2.40.1


