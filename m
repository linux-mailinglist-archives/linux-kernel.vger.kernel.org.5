Return-Path: <linux-kernel+bounces-15535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E3F822D77
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 225C8B221CD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C173C1A59D;
	Wed,  3 Jan 2024 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaZjJE3F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFF119BCD;
	Wed,  3 Jan 2024 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d5d898162so49165475e9.3;
        Wed, 03 Jan 2024 04:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704286015; x=1704890815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNLTRaIyuxFbq61p3RNSu84SuTxURa8ax70mY+8XCbA=;
        b=eaZjJE3FrALOPof5TAkwL+cqUXuQQn25OvqNuMRR8GYomJE7V+3MC5Vxe6cNPke/48
         GIjB9ylhT2YXqBWqj1u93QDrf1HFUV04WqG36jZAxB/VwylqUfN3q7BucysNaivWTb5C
         vfaPywM/MRS+lNyrO2CSChSLU5TAIy6Bj2IJhtOFUON3MdC8PJTadS+yy136x4ZtToFt
         yVXOubwJfR3kz7Ffv05Un2KAL3aTYTBtpgapXk6KGhAR1Tng9G0WwGxeye2u8VZ+corU
         sGJn3PuCpgGg7g231+0+BlBEdrtBYS59eJuq49jEUqdCCgIijWuWfjUe4TT+gfrCpEsi
         HygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704286015; x=1704890815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNLTRaIyuxFbq61p3RNSu84SuTxURa8ax70mY+8XCbA=;
        b=lV1m05mLjh1iVcLXhOhCNTCwjDHXwSueqlACrTTwgoslNXiPRvu0ELdriyR7PhAq0g
         mwkXfrKAyBwVz6H+QPsFFsRsa5ea2duXeC432T9OTu90gf5omesTLTT7dr1pTvRLagTN
         NZCK9CvgSNzkMl4sR4T9IcA/WR5YSq4zJ9vapiOI7V2xmr8UPeFOS+gT1xxaStDkJEDj
         FC0u9x+dwUtzE9LlL0nU3Hvd8UlKKBvSRSbOaOXV6rYaidIhzYw5Mkgrjhy8DitV8BwI
         9AmFA+VkXzuYXBzmxA2BrWh+DKDdUZPpPPxjG6aEbLkrdgJdWA/IJXVGNuPrRyYKvh9E
         f6iA==
X-Gm-Message-State: AOJu0Yw8V32+zycZ6pEM3VaWmQGxfUlqMcuKlQEjbmEKt5SJ7KkkCJer
	811UsOR9cD6x6o3HVcbBzls=
X-Google-Smtp-Source: AGHT+IGh1e7o8Es+BEwB6mEpjbTB9s70LeHZYOx0AqeMMz94p/WWtsf/PtngFsIodfZoSirJa7y8IQ==
X-Received: by 2002:a05:600c:5409:b0:40c:2b29:1bbe with SMTP id he9-20020a05600c540900b0040c2b291bbemr10967229wmb.54.1704286014598;
        Wed, 03 Jan 2024 04:46:54 -0800 (PST)
Received: from localhost.localdomain (host-87-10-250-100.retail.telecomitalia.it. [87.10.250.100])
        by smtp.googlemail.com with ESMTPSA id fc16-20020a05600c525000b0040d5c58c41dsm2219676wmb.24.2024.01.03.04.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 04:46:54 -0800 (PST)
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
Subject: [net-next PATCH v3 4/4] net: phy: at803x: make read_status more generic
Date: Wed,  3 Jan 2024 13:46:35 +0100
Message-ID: <20240103124637.3078-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103124637.3078-1-ansuelsmth@gmail.com>
References: <20240103124637.3078-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make read_status more generic in preparation on moving it to shared
library as other PHY Family Driver will have the exact same
implementation.

The only specific part was a check for AR8031/33 if 1000basex was used.
The check is moved to a dedicated function specific for those PHYs.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index d6dfe906cb62..6f64a809e413 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1020,13 +1020,9 @@ static int at803x_read_specific_status(struct phy_device *phydev,
 
 static int at803x_read_status(struct phy_device *phydev)
 {
-	struct at803x_priv *priv = phydev->priv;
 	struct at803x_ss_mask ss_mask = { 0 };
 	int err, old_link = phydev->link;
 
-	if (priv->is_1000basex)
-		return genphy_c37_read_status(phydev);
-
 	/* Update the link, but return if there was an error */
 	err = genphy_update_link(phydev);
 	if (err)
@@ -1620,6 +1616,17 @@ static int at8031_config_intr(struct phy_device *phydev)
 	return at803x_config_intr(phydev);
 }
 
+/* AR8031 and AR8033 share the same read status logic */
+static int at8031_read_status(struct phy_device *phydev)
+{
+	struct at803x_priv *priv = phydev->priv;
+
+	if (priv->is_1000basex)
+		return genphy_c37_read_status(phydev);
+
+	return at803x_read_status(phydev);
+}
+
 /* AR8031 and AR8035 share the same cable test get status reg */
 static int at8031_cable_test_get_status(struct phy_device *phydev,
 					bool *finished)
@@ -2268,7 +2275,7 @@ static struct phy_driver at803x_driver[] = {
 	.read_page		= at803x_read_page,
 	.write_page		= at803x_write_page,
 	.get_features		= at803x_get_features,
-	.read_status		= at803x_read_status,
+	.read_status		= at8031_read_status,
 	.config_intr		= at8031_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.get_tunable		= at803x_get_tunable,
-- 
2.43.0


