Return-Path: <linux-kernel+bounces-989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C2C8148E5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01AC61F24A52
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AB73064F;
	Fri, 15 Dec 2023 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uc+ee6YL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7E32DF8E;
	Fri, 15 Dec 2023 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c256ffdbcso7456785e9.2;
        Fri, 15 Dec 2023 05:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702646146; x=1703250946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbeZ6c53cwolfsJXL8W/mW8ZWbgFKNj82lz0nxrDSHc=;
        b=Uc+ee6YLiHCJzkoOZdQuriSKXv5FOjkdoqRFPfju+Mzm7d3aiDgWzJE5HRyvjUYm0O
         H/7b61pRtwyfzwQtLnmm9cbq39midTKr7WQmqwYp8zFMOHlfP+XCVDxKxgyBO9nmcibQ
         cMpy7Iw7G7WzatKoA94wZyDUV3qq8UMnCULLP8AXMUvgxE7NtqGfpGEJfIFBl2KF2D38
         fdD73C5ZWP7DSOnwhlCZxZH45owwWxZ9UI3fYb4j5cSboj1DfmCOitxLNxedZuDolIMK
         Mc00s2Kym1edn/kXniLgJe+Ar6ogLtbnXKAqvPGf3qXc34KJUgtMW9el+juvyesxwAq5
         8x/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702646146; x=1703250946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbeZ6c53cwolfsJXL8W/mW8ZWbgFKNj82lz0nxrDSHc=;
        b=XaG619by3+yleEiQWhZzkCaJrYHwDnrUMfCnTrxZsfav8eAKLmfpSqNINwN99qhrhU
         VdfpBBB9p/AQ7WKh9OXv1xnVGmbhYV0peVpqkZ0GsoQkGub70BOQyvUtFc6SwxXYS/wm
         QV9PjzpPnuIWZ1BOrNxi3DsJueqS6Waq+jdCZAGjQ+bjNFC8BcU8Kkx6rhKjVeVg/5MO
         wuQeCxWgNHeuW80iyzD0pnMxaZTn1YiON9nKzJw/wkxJfFLLLLbJ4yfQ1ZWsY8ON6TnZ
         A12ffJ6xI+Hfg3zqmynKJATPkgQmPho79Mehk52sq9vsXrul8c26gS74pNndq9zST3jL
         8sHg==
X-Gm-Message-State: AOJu0YxgoF7fEd4QqGYiyHZdqvv+KraiC132qGFqZvZp2L7R642axNRo
	eb3T2lZKOcY1E7+c7kaP8a8=
X-Google-Smtp-Source: AGHT+IF/q2qRVo16yIcIrEvV2VVslJXtVvwNg4wc4iEsBIT5SJGmoFpVKc8VKOOMBrjqrScyic2AHA==
X-Received: by 2002:a05:600c:5012:b0:40c:6bfc:4bb1 with SMTP id n18-20020a05600c501200b0040c6bfc4bb1mr407557wmr.38.1702646145765;
        Fri, 15 Dec 2023 05:15:45 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id fc7-20020a05600c524700b0040c44cb251dsm21618324wmb.46.2023.12.15.05.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 05:15:45 -0800 (PST)
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
Subject: [net-next PATCH v8 4/4] net: phy: add support for PHY package MMD read/write
Date: Fri, 15 Dec 2023 14:15:34 +0100
Message-Id: <20231215131534.7188-5-ansuelsmth@gmail.com>
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

Some PHY in PHY package may require to read/write MMD regs to correctly
configure the PHY package.

Add support for these additional required function in both lock and no
lock variant.

It's assumed that the entire PHY package is either C22 or C45. We use
C22 or C45 way of writing/reading to mmd regs based on the passed phydev
whether it's C22 or C45.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changesv8:
- Use helper to validate final addr 
Changes v7:
- Change addr to u8
Changes v6:
- Fix copy paste error for kdoc
Changes v5:
- Improve function description
Changes v4:
- Drop function comments in header file
Changes v3:
- Move in phy-core.c from phy.h
- Base c45 from phydev
Changes v2:
- Rework to use newly introduced helper
- Add common check for regnum and devad

 drivers/net/phy/phy-core.c | 140 +++++++++++++++++++++++++++++++++++++
 include/linux/phy.h        |  16 +++++
 2 files changed, 156 insertions(+)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index b729ac8b2640..15f349e5995a 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -650,6 +650,146 @@ int phy_write_mmd(struct phy_device *phydev, int devad, u32 regnum, u16 val)
 }
 EXPORT_SYMBOL(phy_write_mmd);
 
+/**
+ * __phy_package_read_mmd - read MMD reg relative to PHY package base addr
+ * @phydev: The phy_device struct
+ * @addr_offset: The offset to be added to PHY package base_addr
+ * @devad: The MMD to read from
+ * @regnum: The register on the MMD to read
+ *
+ * Convenience helper for reading a register of an MMD on a given PHY
+ * using the PHY package base address. The base address is added to
+ * the addr_offset value.
+ *
+ * Same calling rules as for __phy_read();
+ *
+ * NOTE: It's assumed that the entire PHY package is either C22 or C45.
+ */
+int __phy_package_read_mmd(struct phy_device *phydev,
+			   unsigned int addr_offset, int devad,
+			   u32 regnum)
+{
+	int addr = phy_package_address(phydev, addr_offset);
+
+	if (addr < 0)
+		return addr;
+
+	if (regnum > (u16)~0 || devad > 32)
+		return -EINVAL;
+
+	return mmd_phy_read(phydev->mdio.bus, addr, phydev->is_c45, devad,
+			    regnum);
+}
+EXPORT_SYMBOL(__phy_package_read_mmd);
+
+/**
+ * phy_package_read_mmd - read MMD reg relative to PHY package base addr
+ * @phydev: The phy_device struct
+ * @addr_offset: The offset to be added to PHY package base_addr
+ * @devad: The MMD to read from
+ * @regnum: The register on the MMD to read
+ *
+ * Convenience helper for reading a register of an MMD on a given PHY
+ * using the PHY package base address. The base address is added to
+ * the addr_offset value.
+ *
+ * Same calling rules as for phy_read();
+ *
+ * NOTE: It's assumed that the entire PHY package is either C22 or C45.
+ */
+int phy_package_read_mmd(struct phy_device *phydev,
+			 unsigned int addr_offset, int devad,
+			 u32 regnum)
+{
+	int addr = phy_package_address(phydev, addr_offset);
+	int val;
+
+	if (addr < 0)
+		return addr;
+
+	if (regnum > (u16)~0 || devad > 32)
+		return -EINVAL;
+
+	phy_lock_mdio_bus(phydev);
+	val = mmd_phy_read(phydev->mdio.bus, addr, phydev->is_c45, devad,
+			   regnum);
+	phy_unlock_mdio_bus(phydev);
+
+	return val;
+}
+EXPORT_SYMBOL(phy_package_read_mmd);
+
+/**
+ * __phy_package_write_mmd - write MMD reg relative to PHY package base addr
+ * @phydev: The phy_device struct
+ * @addr_offset: The offset to be added to PHY package base_addr
+ * @devad: The MMD to write to
+ * @regnum: The register on the MMD to write
+ * @val: value to write to @regnum
+ *
+ * Convenience helper for writing a register of an MMD on a given PHY
+ * using the PHY package base address. The base address is added to
+ * the addr_offset value.
+ *
+ * Same calling rules as for __phy_write();
+ *
+ * NOTE: It's assumed that the entire PHY package is either C22 or C45.
+ */
+int __phy_package_write_mmd(struct phy_device *phydev,
+			    unsigned int addr_offset, int devad,
+			    u32 regnum, u16 val)
+{
+	int addr = phy_package_address(phydev, addr_offset);
+
+	if (addr < 0)
+		return addr;
+
+	if (regnum > (u16)~0 || devad > 32)
+		return -EINVAL;
+
+	return mmd_phy_write(phydev->mdio.bus, addr, phydev->is_c45, devad,
+			     regnum, val);
+}
+EXPORT_SYMBOL(__phy_package_write_mmd);
+
+/**
+ * phy_package_write_mmd - write MMD reg relative to PHY package base addr
+ * @phydev: The phy_device struct
+ * @addr_offset: The offset to be added to PHY package base_addr
+ * @devad: The MMD to write to
+ * @regnum: The register on the MMD to write
+ * @val: value to write to @regnum
+ *
+ * Convenience helper for writing a register of an MMD on a given PHY
+ * using the PHY package base address. The base address is added to
+ * the addr_offset value.
+ *
+ * Same calling rules as for phy_write();
+ *
+ * NOTE: It's assumed that the entire PHY package is either C22 or C45.
+ */
+int phy_package_write_mmd(struct phy_device *phydev,
+			  unsigned int addr_offset, int devad,
+			  u32 regnum, u16 val)
+{
+	int addr = phy_package_address(phydev, addr_offset);
+	int ret;
+
+	if (addr < 0)
+		return addr;
+
+	if (regnum > (u16)~0 || devad > 32)
+		return -EINVAL;
+
+	phy_lock_mdio_bus(phydev);
+	ret = mmd_phy_write(phydev->mdio.bus, addr, phydev->is_c45, devad,
+			    regnum, val);
+	phy_unlock_mdio_bus(phydev);
+
+	return ret;
+}
+EXPORT_SYMBOL(phy_package_write_mmd);
+
 /**
  * phy_modify_changed - Function for modifying a PHY register
  * @phydev: the phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 85fdba43b813..191762d89ed8 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2060,6 +2060,22 @@ static inline int __phy_package_write(struct phy_device *phydev,
 	return __mdiobus_write(phydev->mdio.bus, addr, regnum, val);
 }
 
+int __phy_package_read_mmd(struct phy_device *phydev,
+			   unsigned int addr_offset, int devad,
+			   u32 regnum);
+
+int phy_package_read_mmd(struct phy_device *phydev,
+			 unsigned int addr_offset, int devad,
+			 u32 regnum);
+
+int __phy_package_write_mmd(struct phy_device *phydev,
+			    unsigned int addr_offset, int devad,
+			    u32 regnum, u16 val);
+
+int phy_package_write_mmd(struct phy_device *phydev,
+			  unsigned int addr_offset, int devad,
+			  u32 regnum, u16 val);
+
 static inline bool __phy_package_set_once(struct phy_device *phydev,
 					  unsigned int b)
 {
-- 
2.40.1


