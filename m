Return-Path: <linux-kernel+bounces-11931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DCE81EDB6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5891C2166F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1F92E638;
	Wed, 27 Dec 2023 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geNpBe3a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457382DF65;
	Wed, 27 Dec 2023 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33666fb9318so4840605f8f.2;
        Wed, 27 Dec 2023 01:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703668803; x=1704273603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SK3beSWkL1WdKpoVMiSUuExdWouQ1FOB/P9yoXlJNOA=;
        b=geNpBe3aTn72lfEyVWXcjgdMF/dEyPcqeAfmA2RynctaDBWx/GQ7daq7HsYKYk8+v+
         tH/JQIWL2h/CILGq1xRGRKv1mmoR4D/ghwQITMjOXvMleXZleXUeChLOUWqnIuHn0ilZ
         GV+KEw2lshBnx4nPqU1DkjKDuwY8wzwbGAWJw26wTaJLHqAvToRhCcfMDyz2fc4IB05J
         WobItAzQFkmfg6+zfkq7IKvQGy3ljJxXV9HhqkjIHkfhQhY+023qQaAIuMliqNH1HyyJ
         GA/NPfOxbMRhHmxeuc02qIxvFK0/KbjhhSoLm5O1S/paeg3bIih3og9p0/TOcNGK1TvU
         Thng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703668803; x=1704273603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SK3beSWkL1WdKpoVMiSUuExdWouQ1FOB/P9yoXlJNOA=;
        b=uH1XbxE2Du2JFKMNu6h73wjmBuzvOm0BG0tbiiyD/qqGbV2tI6VaYmTqdgqDp/zSwK
         CA4bUpp2s/QjZ5dygUIDBpqBA/wu+KJVvAqsBkL6oOlo0itivWxmSYTfCx/s5OoXB2KP
         gvrZ4AUKDRcHzp4gNrVlvjzBinG3JLVH7V/GXsmVNSNr6JgRs1he7jiC4cb4QX09liE2
         BaydVbEGdrYc3e8cQUwPKbG7FWIGKx90oetOweOWinzwYjy7Oz6egPTbKZv8tI1QeEf0
         4dq0Ky+Uy/WVzuUuYzYOS0dlMHRHHvD/B9fjbxuzDFTzt8MkHs11yQHB26lc9Ayhcocx
         lbFw==
X-Gm-Message-State: AOJu0YwmZXqcv15fL+S4fSs7+nVzGaxSveH0IvJ9JrsgCe73IWGaj4i/
	4hA6XTd3IoMVyCiZKc9HokzY2ndyBfg=
X-Google-Smtp-Source: AGHT+IH0AB+sxgAGAE+tVfjVCst8e4xv4yDG02IhR8CPL1Zd+3nCm+mGZBakZahIoWxE2tDzHOU9IA==
X-Received: by 2002:a05:600c:4e92:b0:40d:53c4:9eec with SMTP id f18-20020a05600c4e9200b0040d53c49eecmr2608669wmq.73.1703668803461;
        Wed, 27 Dec 2023 01:20:03 -0800 (PST)
Received: from localhost.localdomain (host-95-250-248-68.retail.telecomitalia.it. [95.250.248.68])
        by smtp.googlemail.com with ESMTPSA id i2-20020a05600c354200b0040d5ac00dc6sm4539749wmq.8.2023.12.27.01.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 01:20:03 -0800 (PST)
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
Subject: [net-next PATCH 3/3] net: phy: at803x: make read_status more generic
Date: Wed, 27 Dec 2023 10:19:46 +0100
Message-Id: <20231227091946.12937-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231227091946.12937-1-ansuelsmth@gmail.com>
References: <20231227091946.12937-1-ansuelsmth@gmail.com>
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
index a2f5d608b59e..2408001683cf 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1087,13 +1087,9 @@ static int at803x_read_specific_status(struct phy_device *phydev,
 
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
@@ -1685,6 +1681,17 @@ static int at8031_config_intr(struct phy_device *phydev)
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
@@ -2569,7 +2576,7 @@ static struct phy_driver at803x_driver[] = {
 	.read_page		= at803x_read_page,
 	.write_page		= at803x_write_page,
 	.get_features		= at803x_get_features,
-	.read_status		= at803x_read_status,
+	.read_status		= at8031_read_status,
 	.config_intr		= at8031_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.get_tunable		= at803x_get_tunable,
-- 
2.40.1


