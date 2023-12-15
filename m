Return-Path: <linux-kernel+bounces-988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09E18148E2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBB21F24A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA412FE3E;
	Fri, 15 Dec 2023 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcEjVaXE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0649E2DB9A;
	Fri, 15 Dec 2023 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3333074512bso1004931f8f.1;
        Fri, 15 Dec 2023 05:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702646144; x=1703250944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZZO03R1yzWivtorMM7YimtX2jOHr2R8ovLMDu2TRDw=;
        b=AcEjVaXEv5/SnCI96KCk4v11KGxh64AJLcsTVxF2k7Ys+Wm/cyBOw65UepsJr2YkNQ
         VHWXbrMwXgNQoi9dxCCNBb10Khe6pFEaD0rwF3PBWqGoAHluJiwAq4WpNMLV4RolRT0I
         Ku0GZ7i5SwrakkmaZpGBEk1+uFFAoHYmvtrJOZmxeK6ZDTSZlF1WmCqMMi+njNN4gKl0
         mYlDqnAjrna8CXRK8CcCoBaeituqbCgHf8WP8fxSqFBQAOgQL0ZE2u7Wn5T5zRizXUcJ
         bx0QVvNPvBv2urVuNucRIXXE4BsfiGbLzvdVwLwqMgRGM6Zw2/rY8wq7qubxzCHHkymu
         gCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702646144; x=1703250944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZZO03R1yzWivtorMM7YimtX2jOHr2R8ovLMDu2TRDw=;
        b=IyHY4rBIIV3V2SCN47cUK62G3LqIlE7px2/6TWsZ25KlCasAL3PZ0I+OJKwQi9jRAm
         JGlvSfywIGcWJh6MLaSTzGEXWVffdiQfe20FEHRL2U7V2+x1jQRKJmn5D9q9lFvNUd58
         AjUXAQTMkZ0Qy9bEHfUg4EqGX5/Y6ZfQiq7/CSBmAfBR+bYTflaZKV6rXURxfyhzHCyT
         Wd82f4IfhhLBeK6tyKvka3H5tGgSaso31nMPYaESBrw6CK+iwSbsXriAPJFZWD9RGgHh
         lvojbnWvE4+LpYQRRPYMWteqDE94K08rPlsODo1SlQWwC7eVA5WHEOv6l217hnKBvw4z
         PEuw==
X-Gm-Message-State: AOJu0Yy6p4vOX2VjLJwTdQkZrIY4UYX0itJgPw2mmjdCm3/oET0PJV9X
	O7t68wQ2nrCAAN05l1Czc/o=
X-Google-Smtp-Source: AGHT+IFHHcW3vUfmmVz5lE8wPwq7DZU6imJ3yCC/P/73l3r3eH0qBus4Rt6IR7g/7oN3KUXn4ZS+iw==
X-Received: by 2002:a05:600c:4d0d:b0:40b:5e26:2376 with SMTP id u13-20020a05600c4d0d00b0040b5e262376mr5512604wmp.39.1702646144118;
        Fri, 15 Dec 2023 05:15:44 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id fc7-20020a05600c524700b0040c44cb251dsm21618324wmb.46.2023.12.15.05.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 05:15:43 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Harini Katakam <harini.katakam@amd.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [net-next PATCH v8 3/4] net: phy: restructure __phy_write/read_mmd to helper and phydev user
Date: Fri, 15 Dec 2023 14:15:33 +0100
Message-Id: <20231215131534.7188-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215131534.7188-1-ansuelsmth@gmail.com>
References: <20231215131534.7188-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Restructure phy_write_mmd and phy_read_mmd to implement generic helper
for direct mdiobus access for mmd and use these helper for phydev user.

This is needed in preparation of PHY package API that requires generic
access to the mdiobus and are deatched from phydev struct but instead
access them based on PHY package base_addr and offsets.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes v6:
- Add Reviewed-by tag
Changes v3:
- Move to phy-core.c instead of inline in phy.h
Changes v2:
- Introduce this patch

 drivers/net/phy/phy-core.c | 64 ++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 966c93cbe616..b729ac8b2640 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -540,6 +540,28 @@ static void mmd_phy_indirect(struct mii_bus *bus, int phy_addr, int devad,
 			devad | MII_MMD_CTRL_NOINCR);
 }
 
+static int mmd_phy_read(struct mii_bus *bus, int phy_addr, bool is_c45,
+			int devad, u32 regnum)
+{
+	if (is_c45)
+		return __mdiobus_c45_read(bus, phy_addr, devad, regnum);
+
+	mmd_phy_indirect(bus, phy_addr, devad, regnum);
+	/* Read the content of the MMD's selected register */
+	return __mdiobus_read(bus, phy_addr, MII_MMD_DATA);
+}
+
+static int mmd_phy_write(struct mii_bus *bus, int phy_addr, bool is_c45,
+			 int devad, u32 regnum, u16 val)
+{
+	if (is_c45)
+		return __mdiobus_c45_write(bus, phy_addr, devad, regnum, val);
+
+	mmd_phy_indirect(bus, phy_addr, devad, regnum);
+	/* Write the data into MMD's selected register */
+	return __mdiobus_write(bus, phy_addr, MII_MMD_DATA, val);
+}
+
 /**
  * __phy_read_mmd - Convenience function for reading a register
  * from an MMD on a given PHY.
@@ -551,26 +573,14 @@ static void mmd_phy_indirect(struct mii_bus *bus, int phy_addr, int devad,
  */
 int __phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum)
 {
-	int val;
-
 	if (regnum > (u16)~0 || devad > 32)
 		return -EINVAL;
 
-	if (phydev->drv && phydev->drv->read_mmd) {
-		val = phydev->drv->read_mmd(phydev, devad, regnum);
-	} else if (phydev->is_c45) {
-		val = __mdiobus_c45_read(phydev->mdio.bus, phydev->mdio.addr,
-					 devad, regnum);
-	} else {
-		struct mii_bus *bus = phydev->mdio.bus;
-		int phy_addr = phydev->mdio.addr;
+	if (phydev->drv && phydev->drv->read_mmd)
+		return phydev->drv->read_mmd(phydev, devad, regnum);
 
-		mmd_phy_indirect(bus, phy_addr, devad, regnum);
-
-		/* Read the content of the MMD's selected register */
-		val = __mdiobus_read(bus, phy_addr, MII_MMD_DATA);
-	}
-	return val;
+	return mmd_phy_read(phydev->mdio.bus, phydev->mdio.addr,
+			    phydev->is_c45, devad, regnum);
 }
 EXPORT_SYMBOL(__phy_read_mmd);
 
@@ -607,28 +617,14 @@ EXPORT_SYMBOL(phy_read_mmd);
  */
 int __phy_write_mmd(struct phy_device *phydev, int devad, u32 regnum, u16 val)
 {
-	int ret;
-
 	if (regnum > (u16)~0 || devad > 32)
 		return -EINVAL;
 
-	if (phydev->drv && phydev->drv->write_mmd) {
-		ret = phydev->drv->write_mmd(phydev, devad, regnum, val);
-	} else if (phydev->is_c45) {
-		ret = __mdiobus_c45_write(phydev->mdio.bus, phydev->mdio.addr,
-					  devad, regnum, val);
-	} else {
-		struct mii_bus *bus = phydev->mdio.bus;
-		int phy_addr = phydev->mdio.addr;
+	if (phydev->drv && phydev->drv->write_mmd)
+		return phydev->drv->write_mmd(phydev, devad, regnum, val);
 
-		mmd_phy_indirect(bus, phy_addr, devad, regnum);
-
-		/* Write the data into MMD's selected register */
-		__mdiobus_write(bus, phy_addr, MII_MMD_DATA, val);
-
-		ret = 0;
-	}
-	return ret;
+	return mmd_phy_write(phydev->mdio.bus, phydev->mdio.addr,
+			     phydev->is_c45, devad, regnum, val);
 }
 EXPORT_SYMBOL(__phy_write_mmd);
 
-- 
2.40.1


