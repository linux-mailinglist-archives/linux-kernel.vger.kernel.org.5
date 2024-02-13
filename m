Return-Path: <linux-kernel+bounces-64075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C67A8539D9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4801F21D78
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14855608F1;
	Tue, 13 Feb 2024 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxKpCBVI"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9702B605D7;
	Tue, 13 Feb 2024 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848684; cv=none; b=VBaSb75ODnGuV6+0AzCjbbllJVOUGgzH4cGiyLPAM6SvQemjVv9KgoljLCHTXA/l/4xOV9/pM/02yCMjtqOixf9P90CquN9wMIKpT5xUColdjfMlNcbeJBZ3CG75mJTa2phBhdSrE3rTqWqyEF6WAjmMEeLjCmEAdmpO2D0Sw/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848684; c=relaxed/simple;
	bh=fnTzBjLURMPPnnFwAqXvcee6LhO+VYPuwjsXSyZI66U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vg240UNIot6h7gG+N2UM7NVBvcNBIUbjENz5IcDHZVFzP0tCQG1N2PKZApJW+bMU9Xr69rFM3/nwk3fKHQaxRXOqtTas0X/gmYqZorruGNFIVkfiPRlBvKoELE25nAWDHdUZ0p7IPcVSryJWHYNPy+L4N9rAMMV2HhcA+L+IrAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxKpCBVI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-411c779ab2dso6087395e9.0;
        Tue, 13 Feb 2024 10:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707848681; x=1708453481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4TjUgrrN8kUFZKa9YdsCe7iLr0TTloHFQfT8i4JwJA=;
        b=dxKpCBVILLPZF3axeAj6K3/2vK8s1rWELw2ufqXczKvCZuqlipSf1e4VO1mrcjnDmq
         Mqanw8o4c4+/gQnWDpqF7wvqYXzEnHL3PXsdE2yHeDt3eb8WMIc9Xy4RoB/+7WERYWwh
         wkk+28/oFO9B8zmaQDdxS8y0TEHcRAZz7vIdRsbFKbULHrEfqT7dCtg9uvTVrvlw6fk5
         +OZt8AblKCQqfexOo1rHUnqIAKMwh3R0gnPpJkc/lfPXm/y+PvH1HZmDxg++UZftHhv7
         dBtLDUoIEXYAaSPQavLr7KII810V0RmdebsIw7lNlKtaWHVwHy7pnIuCuKerqV07sAAt
         Hecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707848681; x=1708453481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4TjUgrrN8kUFZKa9YdsCe7iLr0TTloHFQfT8i4JwJA=;
        b=UFVStLNGUma5+UrqSFgnKaKZMuU1/gzzf8W90zXsWDmBL5AFQnVJanmTAMw0EHaO4C
         oZrmdIt7rKKm4GLi9gdD3NUmeuZsQvmBjABuvRkCpwe5nFNpgsXsc24gbyAHF9Q+raGs
         iChuOBq53MXTqmXKRCZbnjNqF/gp95NJbPpnXy00bVa5xfsTfvbQXmr/Iuuir898I93C
         FDLZaqIXaJLaJTQaHO6QKmUnftk7Fs5b2Y0MJRYV9M8F57VfsyXxGx9rWlkowJ/MKqd3
         AggSEtZEa551Hzo1q0LGIHDHnKDpEJo41768Aw5FwPiH0/YH0zazO9uIVJtiE3ecWxdo
         sekQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJWWkOCXVfyeU2ysxPiDx1RsweWWdF2bDnv+l3deHtWXR0XpQktKQg1du2BaRW+ORP+bHb0EbBxbgXWKNT/Td3Rfk/p/FX7PVL3pEqyF1lNfvGNZd9x14VJbFBGHplhiMrCADK
X-Gm-Message-State: AOJu0YyD4wJrKA4lNRcgOW1e7iAyYyYpXj+/puuDMvlwX+uV0AW87RGt
	P7b/doQ7DfHwlskrScJUeC//PHB9SevndxNWI3qwiHU/et7+3ZDg
X-Google-Smtp-Source: AGHT+IFfE+WWdPVmkY/X+GJ+aQZG7IukTb+HGNX6RlQGRFjR22i3CERWAPD34sD7pM0vliGAfGf1Gg==
X-Received: by 2002:a05:600c:4f95:b0:410:ee8e:d3b2 with SMTP id n21-20020a05600c4f9500b00410ee8ed3b2mr363617wmq.5.1707848680803;
        Tue, 13 Feb 2024 10:24:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtATT/hqyfHbAajUMcA27FRnBa3cCMwhOv9kxStVv5Zs5DLAeHRjqnDmRRNojAlbXo1ATnBzbBjAAUKx9pbleJ8cusSKp7J+5LtAmxZa+z/s01Nu/Udet12S2tqkPV/vBl04HOf9ShkeIYCSzVcbzvklftTL1IypkEsUyr8RhE17IwLEqIgdUUHrVD5W3gYLPQhhrZerburEJyE9y+181RFZUzzHJNYOgMXhGjcpGitc/AdzcJPEa+4VvoNNPxJSWWD2/yok1JViHD8FOKjQ0lp8AF3M3XwvcEewtfgTTzmOZXOYqP91WFyss5FVtwcZN1Wl1iOhM8XDzlHzrvS4VQbGnXS/Ok7DXNGOMc+rpZdi0DxN7KAvTkDZTzTjXlwIsfeN0LifA=
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id bs25-20020a056000071900b0033b45bdb2a1sm10347974wrb.4.2024.02.13.10.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 10:24:40 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH 2/2] net: phy: aquantia: add AQR112C and AQR112R PHY ID
Date: Tue, 13 Feb 2024 19:24:12 +0100
Message-ID: <20240213182415.17223-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213182415.17223-1-ansuelsmth@gmail.com>
References: <20240213182415.17223-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Aquantia AQR112C and AQR112R PHY ID. These additional PHY are just
variant of the AQR112 with a different chip size or a different target
market. The R variant is usually found on commercial product from PUZZEL
OEM.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 42 ++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 6ee1a134bc60..fd7a79dbb4fb 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -23,6 +23,8 @@
 #define PHY_ID_AQCS109	0x03a1b5c2
 #define PHY_ID_AQR405	0x03a1b4b0
 #define PHY_ID_AQR112	0x03a1b662
+#define PHY_ID_AQR112C	0x03a1b790
+#define PHY_ID_AQR112R	0x31c31d12
 #define PHY_ID_AQR412	0x03a1b712
 #define PHY_ID_AQR113C	0x31c31c12
 
@@ -954,6 +956,44 @@ static struct phy_driver aqr_driver[] = {
 	.get_stats	= aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
 },
+{
+	PHY_ID_MATCH_MODEL(PHY_ID_AQR112C),
+	.name		= "Aquantia AQR112C",
+	.probe		= aqr107_probe,
+	.config_init	= aqr112_config_init,
+	.config_aneg    = aqr_config_aneg,
+	.config_intr	= aqr_config_intr,
+	.handle_interrupt = aqr_handle_interrupt,
+	.get_tunable    = aqr107_get_tunable,
+	.set_tunable    = aqr107_set_tunable,
+	.suspend	= aqr107_suspend,
+	.resume		= aqr107_resume,
+	.read_status	= aqr107_read_status,
+	.get_rate_matching = aqr107_get_rate_matching,
+	.get_sset_count = aqr107_get_sset_count,
+	.get_strings	= aqr107_get_strings,
+	.get_stats	= aqr107_get_stats,
+	.link_change_notify = aqr107_link_change_notify,
+},
+{
+	PHY_ID_MATCH_MODEL(PHY_ID_AQR112R),
+	.name		= "Aquantia AQR112R",
+	.probe		= aqr107_probe,
+	.config_init	= aqr112_config_init,
+	.config_aneg    = aqr_config_aneg,
+	.config_intr	= aqr_config_intr,
+	.handle_interrupt = aqr_handle_interrupt,
+	.get_tunable    = aqr107_get_tunable,
+	.set_tunable    = aqr107_set_tunable,
+	.suspend	= aqr107_suspend,
+	.resume		= aqr107_resume,
+	.read_status	= aqr107_read_status,
+	.get_rate_matching = aqr107_get_rate_matching,
+	.get_sset_count = aqr107_get_sset_count,
+	.get_strings	= aqr107_get_strings,
+	.get_stats	= aqr107_get_stats,
+	.link_change_notify = aqr107_link_change_notify,
+},
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR412),
 	.name		= "Aquantia AQR412",
@@ -1005,6 +1045,8 @@ static struct mdio_device_id __maybe_unused aqr_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQCS109) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR405) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR112) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR112C) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR112R) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR412) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113C) },
 	{ }
-- 
2.43.0


