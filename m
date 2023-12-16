Return-Path: <linux-kernel+bounces-2244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53382815A1F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A551F239AB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA6B31A66;
	Sat, 16 Dec 2023 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX2dreHZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7959530D10;
	Sat, 16 Dec 2023 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c6ea99429so12275175e9.3;
        Sat, 16 Dec 2023 08:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702743136; x=1703347936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8KycpmoEY28RLHnfyVEt7HZvLA/Co1CVDklFA2THj0=;
        b=NX2dreHZxTuFC5btUwKWWLKVXY0n2rVS86Txrlg1vQQb9pjTFobTaeJeBNrXIyRBmi
         5yT4eEa9RqWPW2hjLcvKePbi1192uFn45sCMTY3Iuh02e6yjfRtObb1OChN2ngv06/nA
         RmUrrdDrVxVDA3KuURIa/2xLDnIiz9iaRs2IcWKubEMSkGh5Tpz+2M9GZ1e0j985jnaD
         d9HEpNFtJXEHryycseodOjvTQIlYx/sbpEJ24/LXtuR0AOx6EeUK2QYqKJ+AGowygQtT
         I+elf2DFLW3qcClDpR7LZHeQEOf0g9eHst9IrdDGk3u9+WuCSTttZXGON5YjwnxRkVjV
         cboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702743136; x=1703347936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8KycpmoEY28RLHnfyVEt7HZvLA/Co1CVDklFA2THj0=;
        b=cy08CKtaS3vpfXXSjWapb2tGrFylcVpjiY+GVYoOy4p1WD0GdTPv4mHHUTQSOiyTqp
         p5PUIUuR50Xvv5vrTAKGcx+5fYJB4J3rLD0dU9/OYhzPZO/jQIpaTTLkieBp4pDkgAXu
         hDBVNKupgoXSyTnfS3De2HsirxPxBgRujo+/qLeIVDQlg0jAIMaNAewFiJf/9N1lyOoz
         R7gJiozYJ2Iirk7ezptGPER3Izwy220BtLmtjW+445AGu+zYdCzL7T0r1B87IbSIfK+Q
         4Svt+zHOP1sIT44/MRs4+GdLL9KtjNrX0JrskUjM72ckvgRYmo2H6gFzrqbaEIs1UYni
         vlHw==
X-Gm-Message-State: AOJu0YzYqCEp+GkzSH/Hpw/1AQFZzLfcwltXm8XgsL6VUs+BxuMNucH+
	Og794zLOG7+ddEgDuITXgEk=
X-Google-Smtp-Source: AGHT+IG+PosLTFC/WuXxcQPX59iIK88iPx8jKXdJ2Reu1gJNxhJX7oPTHSzzmS6Op7WxrU2CkOXdOg==
X-Received: by 2002:a05:600c:22d8:b0:40c:66a8:3567 with SMTP id 24-20020a05600c22d800b0040c66a83567mr1669571wmg.59.1702743135543;
        Sat, 16 Dec 2023 08:12:15 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g9-20020a05600c310900b0040c3953cda5sm30818925wmo.45.2023.12.16.08.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:12:14 -0800 (PST)
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
Subject: [net-next PATCH v4 3/3] net: phy: led: dynamically allocate speed modes array
Date: Sat, 16 Dec 2023 17:12:06 +0100
Message-Id: <20231216161206.1729-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231216161206.1729-1-ansuelsmth@gmail.com>
References: <20231216161206.1729-1-ansuelsmth@gmail.com>
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
index f550576eb9da..3b962ec13d90 100644
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
 
+	kfree(speeds);
+
 	return 0;
 out_unreg:
 	while (i--)
@@ -134,6 +143,7 @@ int phy_led_triggers_register(struct phy_device *phy)
 	devm_kfree(&phy->mdio.dev, phy->led_link_trigger);
 	phy->led_link_trigger = NULL;
 out_clear:
+	kfree(speeds);
 	phy->phy_num_led_triggers = 0;
 	return err;
 }
-- 
2.40.1


