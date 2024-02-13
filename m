Return-Path: <linux-kernel+bounces-64356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76529853D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0A7281334
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBAE63105;
	Tue, 13 Feb 2024 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnjJm1oh"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D030629ED;
	Tue, 13 Feb 2024 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860426; cv=none; b=ujMJ4+tT1Ao2cWj2T5nJ8H2/vqt4EMWTjolJBtutM/mnOkRg0s4FSXRFJmbEPc8rBDZaI67ffM6ryMOJ2z+n1/JcUvIovF0i8FH0PALtOUnyRXlkSjz/fOw5A5r5qeeR53uwB46zayl1rxvMmSIi2Qm+y1EEM+SBcsYh97Gcu1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860426; c=relaxed/simple;
	bh=P9kbg96h8nA+vzLjsIPg4kILNbxrfwclXgGSuVa0iV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DehwWSpMECRAnER6C2vJU1cVxCbtl0ipsLVnzk+7qlYKa8X3W5npwfSpgMVrQmFT55dBZ3ilm60KBKy5vniqZeDmKfL+GNA6edKeyvNQD5d6iZbHXkGisyLEg8kyHcWHDTNQM/zfO85QG3OLo908yQz5BpmTWmcd05nzqwyEiEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnjJm1oh; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so15326801fa.3;
        Tue, 13 Feb 2024 13:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707860422; x=1708465222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhWArK/7gr86CDN8jWRWkGtNc20privf2Tsm1Zz0aTk=;
        b=DnjJm1ohyTKGhZHNcU8vrNVUPibl7zg/xk2/LoEkKkoBa0mS0Y6ZEo9PerPNg7Js1X
         uzHYIiFyEYdn0LXnkfp862jpYdAEwsFoRfyINYv/Y+xdLawfeld3zvrdWZ3JsCzuzoGi
         aoDd/oPvhOS96dYlGZN6vFrxm7+byCFsLOJxSKUICn4rag1RYmJfVqkxNX4iDf1FJ3aG
         2beKzrvAx8D25tA8tON8wdBjROO4AYmsMhWJwZVI+NoiidP2RVstEGdhcAyeH3dQII3x
         roh6uWCJOGTNfpgvvXKwxzVa1NUGfBogs8E7cK6YkezTMJUNj+UbNRgkQcg7l2T0htaP
         2kMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707860422; x=1708465222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhWArK/7gr86CDN8jWRWkGtNc20privf2Tsm1Zz0aTk=;
        b=j8HOTP6dSwPd+K8LCQAoMr4pEjJhJXIkaOiX81n9OZF5uV5bDbT7X1nKQ4hrIUbB5u
         q635rpZD94UQWU5v9bfG2BI2mGArTJTdr7MZVhDES0PT8B2wieMvmLa1RDeWY4YAvVJl
         0crIU5rRHVkLKMIWgwraVUEB+cUTISi0ItFW04OLF/jG7A01/tXhJ/g1smRp+6NfcIr9
         bhVknzkyL0EHB7I3PFb/XA4js8hPlAkzlsBwDBTJULK0dxkEpqk9QpbPwDEh9PKT6Jut
         Xta+YCypK6H+4kh6y6isR9Dm5RKIbFw/j+Lotv2hboHFYj+mszmh3RHUCH6s8yfhKant
         aa8g==
X-Forwarded-Encrypted: i=1; AJvYcCWTSkVlWbXZbiMrLrYhLvGaYitTT1Oa9zyVD2jvI+vZG5SS/cPTBpF1RVlBDaKe5HrZtUMlps82l82YqtUop/MbDjfp4h7eN5O3cIQg9NmmEKCwGNPss0ZIC6TMq2QXiLKT6FP3
X-Gm-Message-State: AOJu0YwaGqXvsoj6tyaXSABBP0fjUQWFkePU2cEWbo9e8P6XNbuacGej
	4RoeV/o0JetSGGPV0Wrn/03iLu7mM9VN+hHuSv1n9z2zYM85dFGo
X-Google-Smtp-Source: AGHT+IGstANoms+UFbnJKknPAUv7SdGszKG7pGLDLY5atnR8LujkVPvCqWUxvAaANcXuCwXiAtIZ6A==
X-Received: by 2002:a2e:98d6:0:b0:2d0:e35a:3bab with SMTP id s22-20020a2e98d6000000b002d0e35a3babmr520694ljj.48.1707860422495;
        Tue, 13 Feb 2024 13:40:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEctUJOxW4T8/ZV6vGaNHaWPBZAvHDlT3gBHyDp/z9BAZJYQdz8BaLcUtnKwGDdcxrC7MDCBJZjDOPoSC7PYHtDKadWGWcQvw69uoYz+Rx7Iq4wvX4FlJf65ThFhs4uY+f/FvQdfln4HlMVGcMSZJWCEv3tp0ta29pICNngY+cvizfHW3JvtysHtPpIwosdKgdwlIAKz+vmh68ArYuppE0am/UbrT9zAh6/TBv9eQSjhokGym3omz9YhhT2miHGcIdLvojfb2xGPiZFJMlICul4WVOhyt2u4f5aCdHJmXdHFnRSgNBFTSlV9quPyw2KRwAVI6D37eMLJRbB/VvVMCVAjk=
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id k23-20020a05640212d700b005612987a525sm4003913edx.89.2024.02.13.13.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:40:22 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 net-next 04/14] net: phy: marvell-88q2xxx: fix typos
Date: Tue, 13 Feb 2024 22:39:43 +0100
Message-Id: <20240213213955.178762-5-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213213955.178762-1-dima.fedrau@gmail.com>
References: <20240213213955.178762-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename mv88q2xxxx_get_sqi to mv88q2xxx_get_sqi and
mv88q2xxxx_get_sqi_max to mv88q2xxx_get_sqi_max.
Fix linebreaks and use everywhere hexadecimal numbers written with
lowercase letters instead of mixing it up.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 1c3ff77de56b..dcebb4643aff 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -14,7 +14,7 @@
 #define MDIO_MMD_AN_MV_STAT_MS_CONF_FAULT	0x8000
 
 #define MDIO_MMD_PCS_MV_100BT1_STAT1			33032
-#define MDIO_MMD_PCS_MV_100BT1_STAT1_IDLE_ERROR	0x00FF
+#define MDIO_MMD_PCS_MV_100BT1_STAT1_IDLE_ERROR		0x00ff
 #define MDIO_MMD_PCS_MV_100BT1_STAT1_JABBER		0x0100
 #define MDIO_MMD_PCS_MV_100BT1_STAT1_LINK		0x0200
 #define MDIO_MMD_PCS_MV_100BT1_STAT1_LOCAL_RX		0x1000
@@ -27,6 +27,8 @@
 #define MDIO_MMD_PCS_MV_100BT1_STAT2_LINK	0x0004
 #define MDIO_MMD_PCS_MV_100BT1_STAT2_ANGE	0x0008
 
+#define MDIO_MMD_PCS_MV_RX_STAT			33328
+
 static int mv88q2xxx_soft_reset(struct phy_device *phydev)
 {
 	int ret;
@@ -63,7 +65,8 @@ static int mv88q2xxx_read_link_gbit(struct phy_device *phydev)
 		 * the link was already down.
 		 */
 		if (!phy_polling_mode(phydev) || !phydev->link) {
-			ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_1000BT1_STAT);
+			ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
+					   MDIO_PCS_1000BT1_STAT);
 			if (ret < 0)
 				return ret;
 			else if (ret & MDIO_PCS_1000BT1_STAT_LINK)
@@ -71,7 +74,8 @@ static int mv88q2xxx_read_link_gbit(struct phy_device *phydev)
 		}
 
 		if (!link) {
-			ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_1000BT1_STAT);
+			ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
+					   MDIO_PCS_1000BT1_STAT);
 			if (ret < 0)
 				return ret;
 			else if (ret & MDIO_PCS_1000BT1_STAT_LINK)
@@ -95,7 +99,8 @@ static int mv88q2xxx_read_link_100m(struct phy_device *phydev)
 	 * we always read the realtime status.
 	 */
 	if (!phy_polling_mode(phydev) || !phydev->link) {
-		ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_100BT1_STAT1);
+		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
+				   MDIO_MMD_PCS_MV_100BT1_STAT1);
 		if (ret < 0)
 			return ret;
 		else if (ret & MDIO_MMD_PCS_MV_100BT1_STAT1_LINK)
@@ -200,7 +205,7 @@ static int mv88q2xxx_config_init(struct phy_device *phydev)
 	return mv88q2xxx_config_aneg(phydev);
 }
 
-static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
+static int mv88q2xxx_get_sqi(struct phy_device *phydev)
 {
 	int ret;
 
@@ -208,7 +213,8 @@ static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
 		/* Read the SQI from the vendor specific receiver status
 		 * register
 		 */
-		ret = phy_read_mmd(phydev, MDIO_MMD_PCS, 0x8230);
+		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
+				   MDIO_MMD_PCS_MV_RX_STAT);
 		if (ret < 0)
 			return ret;
 
@@ -218,7 +224,7 @@ static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
 		 * but can be found in the Software Initialization Guide. Only
 		 * revisions >= A0 are supported.
 		 */
-		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, 0xFC5D, 0x00FF, 0x00AC);
+		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, 0xfc5d, 0xff, 0xac);
 		if (ret < 0)
 			return ret;
 
@@ -227,10 +233,10 @@ static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
 			return ret;
 	}
 
-	return ret & 0x0F;
+	return ret & 0x0f;
 }
 
-static int mv88q2xxxx_get_sqi_max(struct phy_device *phydev)
+static int mv88q2xxx_get_sqi_max(struct phy_device *phydev)
 {
 	return 15;
 }
@@ -246,8 +252,8 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.read_status		= mv88q2xxx_read_status,
 		.soft_reset		= mv88q2xxx_soft_reset,
 		.set_loopback		= genphy_c45_loopback,
-		.get_sqi		= mv88q2xxxx_get_sqi,
-		.get_sqi_max		= mv88q2xxxx_get_sqi_max,
+		.get_sqi		= mv88q2xxx_get_sqi,
+		.get_sqi_max		= mv88q2xxx_get_sqi_max,
 	},
 };
 
-- 
2.39.2


