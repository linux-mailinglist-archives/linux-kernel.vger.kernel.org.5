Return-Path: <linux-kernel+bounces-70528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC9F8598DF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D856F1C21098
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC45776034;
	Sun, 18 Feb 2024 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFgcR6sg"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C62F745D0;
	Sun, 18 Feb 2024 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282854; cv=none; b=kt/66KL9hl7Sfm50JIVf069uXU+OiP14O/hAkWOFNxtIAp7jix8bGN62L+b+P0ydl0YTY/X3BQprfCiWDsYb34lS8oy+WE5RYo+OT1eAL84lmK0vc4z0emMF2DKwSnNffCXIpmJ2X+r4GeDF7/0P59lwDA/qrZK56rUZtfWh6lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282854; c=relaxed/simple;
	bh=X4Dgs1+oA9FIuXWyYEmtL0W3o+8D/VQnJV5zcr/C9d0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaZpsiQQUoW78Pk0x5H2yNERy4xthR0zHYMyvdIKyI45TtPfENYvQtnJoBIVRYfWZE6rNzgkLem2EWW8nKn1Z0qR0EL8R+lws/lT9NomALYsSMLh6NAfmTOvNLujU1RCsR9WuDGhXXjgBjkyl0GsSqwk2gcvp9wFJ5kIvhuS3+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFgcR6sg; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d4c11bd34so286606f8f.3;
        Sun, 18 Feb 2024 11:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708282851; x=1708887651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVCDWG5HyyNzD3ROBUiUfCNlTle5zKPM92sFTYbMog8=;
        b=XFgcR6sggisqPR51O3FvovfBB6tSIhv2iwrQxnLpMFDcXAVLYUNaxNFmh3uNptX4r+
         9HKXR8qZd//9GJ3D6DgXG40zwymxsGwfSmpiqwGaYACADJ55gK9RDEeLYj8//YiqBdu1
         HUU7ear5C7kbe9GB+RuvxRn6/aABIvn01QHuxXwQG1iV3qiESYzYHSZJala1tTih0RZ9
         GEda4D1I7A7oK6yWoNvdWGoHfv+Bf8hesJ6Ouut09Krme8QrouRlbyqMvfrF5XrPMo/K
         IG5Wfg5tsjGD5I8HtNYbA5pa9GUKKFkhSGyWkRbM8xL9yCHWCFXA/1IdlfcBUmJSU3dR
         +06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708282851; x=1708887651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVCDWG5HyyNzD3ROBUiUfCNlTle5zKPM92sFTYbMog8=;
        b=q+xkaVxdHd2OhVDGsB4vVE5PM8X2Mi4QjrBEpwaRTSuXeMbKGp2+Q+eEAOsWRftYBy
         mBT+LzGnW5VAWtLrxV+lbv9E01TftuIsXUWe4qrUoS4RNlbNXipdaIA5lLtsiSjzAWHz
         0lo5FGj2iyyQnjJnMgDnbWwCyk9qqZ5ARYWGHTGPDLEBcJYdUiXe2y8WT9rmInc3pi3d
         /VStTor/FsyyKpzFsdqHnU8i7bG2pElNDOsbejJFxCGEzLLWScY6jAU0EZI5gscuo/QV
         AwnTlgkGCqmHSNMlXMC17VcaZQNngBo6RhjVguE8Y6eT7v0Nwgzc2hINaHKz1iKnMfKa
         Dipw==
X-Forwarded-Encrypted: i=1; AJvYcCVGW0MGibrtb2GNiaqwE5a8LqISAr1ps0QaIJSE4iHJPQw21ZPqkWrXPF4MPJ2CZzrszPSLLL8NpxkGMAAKsdECrVUQROXJh+AMlPEHC63+WT/VHaaVG1Xmk7TJcgX5Unr6tA0S
X-Gm-Message-State: AOJu0Yyc6qtWSFbQqr1w3ZqO4C78jlRua37WkjLD2Nn9a4kyoJa03C6P
	Qc/3HhAhfRESBvIzVr+ICdA8V7D1AUSjBbzOk0I6OQxLMUShEEr6
X-Google-Smtp-Source: AGHT+IEVUF1NnX7Elpx+nifzxqXhaYeWXIA9JhgVDxU4irWZFhuY+c9KYxwiQrLPBT7TTI+D0cCNrg==
X-Received: by 2002:a5d:5487:0:b0:33d:3ee3:cc0b with SMTP id h7-20020a5d5487000000b0033d3ee3cc0bmr2003541wrv.49.1708282850734;
        Sun, 18 Feb 2024 11:00:50 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id m15-20020a056000008f00b0033b728190c1sm8115762wrx.79.2024.02.18.11.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:00:50 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Puneet Gupta <puneet.gupta@amd.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH 6/6] net: phy: bcm7xxx: rework phy_driver table to new multiple PHY ID format
Date: Sun, 18 Feb 2024 20:00:32 +0100
Message-ID: <20240218190034.15447-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240218190034.15447-1-ansuelsmth@gmail.com>
References: <20240218190034.15447-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework bcm7xxx PHY driver table to new multiple PHY format
implementation to reduce code duplication and final size of the compiled
module.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/bcm7xxx.c | 140 ++++++++++++++++++++++----------------
 1 file changed, 82 insertions(+), 58 deletions(-)

diff --git a/drivers/net/phy/bcm7xxx.c b/drivers/net/phy/bcm7xxx.c
index 97638ba7ae85..4d886bb8a3e2 100644
--- a/drivers/net/phy/bcm7xxx.c
+++ b/drivers/net/phy/bcm7xxx.c
@@ -845,16 +845,6 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.phy_id		= (_oui),					\
 	.phy_id_mask	= 0xfffffff0,					\
 	.name		= _name,					\
-	/* PHY_GBIT_FEATURES */						\
-	.flags		= PHY_IS_INTERNAL,				\
-	.config_init	= bcm7xxx_28nm_config_init,			\
-	.resume		= bcm7xxx_28nm_resume,				\
-	.get_tunable	= bcm7xxx_28nm_get_tunable,			\
-	.set_tunable	= bcm7xxx_28nm_set_tunable,			\
-	.get_sset_count	= bcm_phy_get_sset_count,			\
-	.get_strings	= bcm_phy_get_strings,				\
-	.get_stats	= bcm7xxx_28nm_get_phy_stats,			\
-	.probe		= bcm7xxx_28nm_probe,				\
 }
 
 #define BCM7XXX_28NM_EPHY(_oui, _name)					\
@@ -862,16 +852,6 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.phy_id		= (_oui),					\
 	.phy_id_mask	= 0xfffffff0,					\
 	.name		= _name,					\
-	/* PHY_BASIC_FEATURES */					\
-	.flags		= PHY_IS_INTERNAL,				\
-	.config_init	= bcm7xxx_28nm_ephy_config_init,		\
-	.resume		= bcm7xxx_28nm_ephy_resume,			\
-	.get_sset_count	= bcm_phy_get_sset_count,			\
-	.get_strings	= bcm_phy_get_strings,				\
-	.get_stats	= bcm7xxx_28nm_get_phy_stats,			\
-	.probe		= bcm7xxx_28nm_probe,				\
-	.read_mmd	= bcm7xxx_28nm_ephy_read_mmd,			\
-	.write_mmd	= bcm7xxx_28nm_ephy_write_mmd,			\
 }
 
 #define BCM7XXX_40NM_EPHY(_oui, _name)					\
@@ -879,12 +859,6 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.phy_id         = (_oui),					\
 	.phy_id_mask    = 0xfffffff0,					\
 	.name           = _name,					\
-	/* PHY_BASIC_FEATURES */					\
-	.flags          = PHY_IS_INTERNAL,				\
-	.soft_reset	= genphy_soft_reset,				\
-	.config_init    = bcm7xxx_config_init,				\
-	.suspend        = bcm7xxx_suspend,				\
-	.resume         = bcm7xxx_config_init,				\
 }
 
 #define BCM7XXX_16NM_EPHY(_oui, _name)					\
@@ -892,41 +866,91 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.phy_id		= (_oui),					\
 	.phy_id_mask	= 0xfffffff0,					\
 	.name		= _name,					\
-	/* PHY_BASIC_FEATURES */					\
-	.flags		= PHY_IS_INTERNAL,				\
-	.get_sset_count	= bcm_phy_get_sset_count,			\
-	.get_strings	= bcm_phy_get_strings,				\
-	.get_stats	= bcm7xxx_28nm_get_phy_stats,			\
-	.probe		= bcm7xxx_28nm_probe,				\
-	.config_init	= bcm7xxx_16nm_ephy_config_init,		\
-	.config_aneg	= genphy_config_aneg,				\
-	.read_status	= genphy_read_status,				\
-	.resume		= bcm7xxx_16nm_ephy_resume,			\
 }
 
 static struct phy_driver bcm7xxx_driver[] = {
-	BCM7XXX_28NM_EPHY(PHY_ID_BCM72113, "Broadcom BCM72113"),
-	BCM7XXX_28NM_EPHY(PHY_ID_BCM72116, "Broadcom BCM72116"),
-	BCM7XXX_16NM_EPHY(PHY_ID_BCM72165, "Broadcom BCM72165"),
-	BCM7XXX_28NM_GPHY(PHY_ID_BCM7250, "Broadcom BCM7250"),
-	BCM7XXX_28NM_EPHY(PHY_ID_BCM7255, "Broadcom BCM7255"),
-	BCM7XXX_28NM_EPHY(PHY_ID_BCM7260, "Broadcom BCM7260"),
-	BCM7XXX_28NM_EPHY(PHY_ID_BCM7268, "Broadcom BCM7268"),
-	BCM7XXX_28NM_EPHY(PHY_ID_BCM7271, "Broadcom BCM7271"),
-	BCM7XXX_28NM_GPHY(PHY_ID_BCM7278, "Broadcom BCM7278"),
-	BCM7XXX_28NM_GPHY(PHY_ID_BCM7364, "Broadcom BCM7364"),
-	BCM7XXX_28NM_GPHY(PHY_ID_BCM7366, "Broadcom BCM7366"),
-	BCM7XXX_16NM_EPHY(PHY_ID_BCM74165, "Broadcom BCM74165"),
-	BCM7XXX_28NM_GPHY(PHY_ID_BCM74371, "Broadcom BCM74371"),
-	BCM7XXX_28NM_GPHY(PHY_ID_BCM7439, "Broadcom BCM7439"),
-	BCM7XXX_28NM_GPHY(PHY_ID_BCM7439_2, "Broadcom BCM7439 (2)"),
-	BCM7XXX_28NM_GPHY(PHY_ID_BCM7445, "Broadcom BCM7445"),
-	BCM7XXX_40NM_EPHY(PHY_ID_BCM7346, "Broadcom BCM7346"),
-	BCM7XXX_40NM_EPHY(PHY_ID_BCM7362, "Broadcom BCM7362"),
-	BCM7XXX_40NM_EPHY(PHY_ID_BCM7425, "Broadcom BCM7425"),
-	BCM7XXX_40NM_EPHY(PHY_ID_BCM7429, "Broadcom BCM7429"),
-	BCM7XXX_40NM_EPHY(PHY_ID_BCM7435, "Broadcom BCM7435"),
-	BCM7XXX_16NM_EPHY(PHY_ID_BCM7712, "Broadcom BCM7712"),
+{
+	.name		= "Broadcom BCM7XXX 16NM EPHY",
+	.ids		= (const struct mdio_device_id []){
+		BCM7XXX_16NM_EPHY(PHY_ID_BCM72165, "Broadcom BCM72165"),
+		BCM7XXX_16NM_EPHY(PHY_ID_BCM74165, "Broadcom BCM74165"),
+		BCM7XXX_16NM_EPHY(PHY_ID_BCM7712, "Broadcom BCM7712"),
+		{ /* sentinel */ },
+	},
+	/* PHY_BASIC_FEATURES */
+	.flags		= PHY_IS_INTERNAL,
+	.get_sset_count	= bcm_phy_get_sset_count,
+	.get_strings	= bcm_phy_get_strings,
+	.get_stats	= bcm7xxx_28nm_get_phy_stats,
+	.probe		= bcm7xxx_28nm_probe,
+	.config_init	= bcm7xxx_16nm_ephy_config_init,
+	.config_aneg	= genphy_config_aneg,
+	.read_status	= genphy_read_status,
+	.resume		= bcm7xxx_16nm_ephy_resume,
+},
+{
+	.name		= "Broadcom BCM7XXX 28NM GPHY",
+	.ids		= (const struct mdio_device_id []){
+		BCM7XXX_28NM_GPHY(PHY_ID_BCM7250, "Broadcom BCM7250"),
+		BCM7XXX_28NM_GPHY(PHY_ID_BCM7278, "Broadcom BCM7278"),
+		BCM7XXX_28NM_GPHY(PHY_ID_BCM7364, "Broadcom BCM7364"),
+		BCM7XXX_28NM_GPHY(PHY_ID_BCM7366, "Broadcom BCM7366"),
+		BCM7XXX_28NM_GPHY(PHY_ID_BCM74371, "Broadcom BCM74371"),
+		BCM7XXX_28NM_GPHY(PHY_ID_BCM7439, "Broadcom BCM7439"),
+		BCM7XXX_28NM_GPHY(PHY_ID_BCM7439_2, "Broadcom BCM7439 (2)"),
+		BCM7XXX_28NM_GPHY(PHY_ID_BCM7445, "Broadcom BCM7445"),
+		{ /* sentinel */ },
+	},
+	/* PHY_GBIT_FEATURES */
+	.flags		= PHY_IS_INTERNAL,
+	.config_init	= bcm7xxx_28nm_config_init,
+	.resume		= bcm7xxx_28nm_resume,
+	.get_tunable	= bcm7xxx_28nm_get_tunable,
+	.set_tunable	= bcm7xxx_28nm_set_tunable,
+	.get_sset_count	= bcm_phy_get_sset_count,
+	.get_strings	= bcm_phy_get_strings,
+	.get_stats	= bcm7xxx_28nm_get_phy_stats,
+	.probe		= bcm7xxx_28nm_probe,
+},
+{
+	.name		= "Broadcom BCM7XXX 28NM EPHY",
+	.ids		= (const struct mdio_device_id []){
+		BCM7XXX_28NM_EPHY(PHY_ID_BCM72113, "Broadcom BCM72113"),
+		BCM7XXX_28NM_EPHY(PHY_ID_BCM72116, "Broadcom BCM72116"),
+		BCM7XXX_28NM_EPHY(PHY_ID_BCM7255, "Broadcom BCM7255"),
+		BCM7XXX_28NM_EPHY(PHY_ID_BCM7260, "Broadcom BCM7260"),
+		BCM7XXX_28NM_EPHY(PHY_ID_BCM7268, "Broadcom BCM7268"),
+		BCM7XXX_28NM_EPHY(PHY_ID_BCM7271, "Broadcom BCM7271"),
+		{ /* sentinel */ },
+	},
+	/* PHY_BASIC_FEATURES */
+	.flags		= PHY_IS_INTERNAL,
+	.config_init	= bcm7xxx_28nm_ephy_config_init,
+	.resume		= bcm7xxx_28nm_ephy_resume,
+	.get_sset_count	= bcm_phy_get_sset_count,
+	.get_strings	= bcm_phy_get_strings,
+	.get_stats	= bcm7xxx_28nm_get_phy_stats,
+	.probe		= bcm7xxx_28nm_probe,
+	.read_mmd	= bcm7xxx_28nm_ephy_read_mmd,
+	.write_mmd	= bcm7xxx_28nm_ephy_write_mmd,
+},
+{
+	.name		= "Broadcom BCM7XXX 40NM EPHY",
+	.ids		= (const struct mdio_device_id []){
+		BCM7XXX_40NM_EPHY(PHY_ID_BCM7346, "Broadcom BCM7346"),
+		BCM7XXX_40NM_EPHY(PHY_ID_BCM7362, "Broadcom BCM7362"),
+		BCM7XXX_40NM_EPHY(PHY_ID_BCM7425, "Broadcom BCM7425"),
+		BCM7XXX_40NM_EPHY(PHY_ID_BCM7429, "Broadcom BCM7429"),
+		BCM7XXX_40NM_EPHY(PHY_ID_BCM7435, "Broadcom BCM7435"),
+		{ /* sentinel */ },
+	},
+	/* PHY_BASIC_FEATURES */
+	.flags          = PHY_IS_INTERNAL,
+	.soft_reset	= genphy_soft_reset,
+	.config_init    = bcm7xxx_config_init,
+	.suspend        = bcm7xxx_suspend,
+	.resume         = bcm7xxx_config_init,
+},
 };
 
 static struct mdio_device_id __maybe_unused bcm7xxx_tbl[] = {
-- 
2.43.0


