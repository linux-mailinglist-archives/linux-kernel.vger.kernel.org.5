Return-Path: <linux-kernel+bounces-1018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0852A814944
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D5E28675F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618EC30D05;
	Fri, 15 Dec 2023 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mhix1SNK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F55530321;
	Fri, 15 Dec 2023 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c38e292c8so3513915e9.0;
        Fri, 15 Dec 2023 05:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702646981; x=1703251781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8KycpmoEY28RLHnfyVEt7HZvLA/Co1CVDklFA2THj0=;
        b=Mhix1SNKzn25mpmaQJA/pZ7i75Y8TA9Q54sj3hZE+lCzV587iu5W4fwvNyq3kOvNhU
         bH5dvQDGMrQTx/fa/0kaIQqlLrH2m9ILUSTQlcUu/sQSGOE0Rlivj94r2CTGZmlTxoNp
         f+/cUzIRGXFNR4h13PjNVUINhYeRBx2SYs8tOF5UiewfQyosrWvwiVhPYglxHDAxLcP2
         iavOVx+SOr5jiuamrUrfrZ8AOrSTlrwbsrgveafixUG98mJldQml6/PGSWxlHA9g3bUj
         8rho2uZ6RojnpppcOaZ1MFeejOElKBuISSkfk11kkcmSsTVr7fPX/oKkgE5SbCfsRSRj
         ke5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702646981; x=1703251781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8KycpmoEY28RLHnfyVEt7HZvLA/Co1CVDklFA2THj0=;
        b=wz5BdHf4G6FLU49Wvz3HVbqwvD3lmCf3oex13kj+XyGqq56eI0weCkTy/HoumxACni
         LxAigQF3TeKSLcVNZPbDfG9jXKcWKfdbmeYz0S9r8rRCKQ5ysz7SYddO9urE1h/mBBqg
         Tom97nMqI5MIE3LhqPHdMEoNRSx4WV2s2ts+LMU5UlcRLxyXtLU827sUw4uZcFWOnnL5
         hcFQMfAFcJlIr9uXg57z3N71z2VVzRsqaSEG8CkeR2Q3dj8CoDeLnoTDmgPi+Y40Wvcz
         aU0HPBfPDYUsgAHvnbZ/bnB2CvtXbbmxJlUBeFllAmjjGWoOgXUDAI0S7MpasJwZR0ll
         KA6A==
X-Gm-Message-State: AOJu0YwafsAroLj6iqnesHQlrsv5MGwNfsxbPUvETEZAKBYbSuLX/pGM
	u32gpRdt1T2m2e57rNZPxma6mfzNjpM=
X-Google-Smtp-Source: AGHT+IGCuZef8REAlKzw59ZBBJ+UeH4/0eh5MO6e1D0CdDAZHUQXjtNFnkntk8XvYKs5aijPV2d94A==
X-Received: by 2002:a05:600c:808e:b0:40b:47d0:cff with SMTP id ew14-20020a05600c808e00b0040b47d00cffmr6101245wmb.10.1702646981425;
        Fri, 15 Dec 2023 05:29:41 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id o3-20020a05600c4fc300b004042dbb8925sm31434543wmq.38.2023.12.15.05.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 05:29:41 -0800 (PST)
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
Subject: [net-next PATCH v3 3/3] net: phy: led: dynamically allocate speed modes array
Date: Fri, 15 Dec 2023 14:29:21 +0100
Message-Id: <20231215132921.16808-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215132921.16808-1-ansuelsmth@gmail.com>
References: <20231215132921.16808-1-ansuelsmth@gmail.com>
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


