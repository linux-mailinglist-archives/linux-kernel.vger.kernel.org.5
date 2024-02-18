Return-Path: <linux-kernel+bounces-70262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AE685955F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19859281A16
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16D61CD38;
	Sun, 18 Feb 2024 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvSK+lNC"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D2B1B944;
	Sun, 18 Feb 2024 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708243093; cv=none; b=o9NEkBY69s9Un5DVcEKUoTGRzOQ4xTulZVcHN5ZNW7k1Cmb/L9o+ddi7xMunO1akhAgBaAFdavW/eEQzx3sHRSZXphK2fDOZupOL4Al1G6aYK7iSvv/x5nhCW8Ww2xaqwDN3UU8GefqG6Tkt5utxz5dl86vjNxJd8sRgKJeSjzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708243093; c=relaxed/simple;
	bh=P9kbg96h8nA+vzLjsIPg4kILNbxrfwclXgGSuVa0iV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e+dOy0DPM6uKv+nT1tawsILJXJhQL1Y9MuJnMxtsuVFUdCWzNKzIiBi2X2WaEsoQkc87N9mMNF6H08B1qSIBEMP/bjQWPhFYkWqG2Q0hRVVQFzceSeSfhfVYMmFg9SHcWmUFdWPt0A3VRaInSIyOIRZqO3YVKb48geEMUwm9JwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvSK+lNC; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso568150966b.0;
        Sat, 17 Feb 2024 23:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708243089; x=1708847889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhWArK/7gr86CDN8jWRWkGtNc20privf2Tsm1Zz0aTk=;
        b=AvSK+lNCPMCCVT1IYydviXcc7KSFSX8Fab4qPwyqjJqGPIGmlJzGIVDPsyuDKl/et1
         z/r1TcGmcnMltN0SBxF7SXdxPCmzBGBkdwDVQUY5uMKR5prcyHaUgiel+Zz9N63ss57x
         VNCsZ8JN3H7kfy7xoA/rriVcE5KOwcX+im/VlK5w2hOd8E5mEp6eMpWifpOg119w9KzP
         +l2Y7YTggKxQG6025/+EFt5NwUuvCdzj1d5PxXggXYSsAcKuwdRsittLijU4UslpxPk0
         I3FzaNG7isu/i75e+f7kPBiLkD1+uGKbAvVsxaOKpFmY/0+r0od1+uVjx+8OJGJIFCkl
         PFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708243089; x=1708847889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhWArK/7gr86CDN8jWRWkGtNc20privf2Tsm1Zz0aTk=;
        b=k7piuhXFRFXyUKr1+HPEDKqcruVge5mCq22lQfhoDuvNAxohAG03f7S6bPgXFVr1jl
         tuKDJ+zX2dtEFvhRisTJ2bZm5iQ++XB4sOrlce9m4aw0LvnrCvgYkzBADh86uzY66A20
         F14IiFfKhYf7VKc7GhQOGe7VYDWN/rQ2uvnGgg5AN4Zk3tjSCtj/qTyBAiEEvkiF52fP
         oKo+PaGHGnD4ZZtNhFgHnwQSYq31CIq+OAH7cb6hE0txZszPNMmIRNMDaYXXvWhGOmMq
         8SLqUPKKLG1In2q80hFo8UlGLUbTNbKoQjiK5AVJEEfBr/NFaDlndaS68TWCxDdAmBsi
         MwuA==
X-Forwarded-Encrypted: i=1; AJvYcCXuse1UWE3nJc+F8+CzrN7GSxZxIg+p/vaw3/LptZ3p65te/hlReyMq9bwhV4nMfoFtY70BoXXqcVwqH3cHcAFiulmVXfi4FBRQ+jsL7HG605QTBrO+HljdyYmcPxAl1TaSHr9D
X-Gm-Message-State: AOJu0Yz2wEw6T65W9C0qYcNkZB3CSQkDDh6hMxOiRs6rBldMMOU1T1u5
	ERvD6Gws5wOTKp3nGLYeq/hXaS/VYmYLy3aqJI0zxNyIDaYtWdzN
X-Google-Smtp-Source: AGHT+IFiDEu/otHrEkvC4JbegXwDX5tFC46jhmBrsl4lYMLsqVFq07U3vFqGdj7liKSFqg372Mv3vg==
X-Received: by 2002:a17:906:254f:b0:a3e:5d4d:69e8 with SMTP id j15-20020a170906254f00b00a3e5d4d69e8mr997470ejb.10.1708243089606;
        Sat, 17 Feb 2024 23:58:09 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id jj12-20020a170907984c00b00a3e64bcd2c1sm458732ejc.142.2024.02.17.23.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 23:58:09 -0800 (PST)
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
Subject: [PATCH v7 net-next 04/14] net: phy: marvell-88q2xxx: fix typos
Date: Sun, 18 Feb 2024 08:57:41 +0100
Message-Id: <20240218075753.18067-5-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240218075753.18067-1-dima.fedrau@gmail.com>
References: <20240218075753.18067-1-dima.fedrau@gmail.com>
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


