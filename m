Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C649B7F907B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 01:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjKZAh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 19:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjKZAhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 19:37:53 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E6C182;
        Sat, 25 Nov 2023 16:37:59 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-332d2b6a84cso2118174f8f.0;
        Sat, 25 Nov 2023 16:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700959077; x=1701563877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uPUXkFTFTY3wjyppF4kZdPmBYcUNyv8eWABZcZLvEU=;
        b=dqCtQy9xgG5eo3lWyOVCPujrfXvDkvzHwAlLoMtWgFom2c5zBciE+6ta28FmYAnjJj
         7ynfMKXA5WCJBakigtwReQJoECIGerjMcZsngMUdoC+iDWpsh5Fy1y6Iu8yqiW1A6yA+
         SCQjcp7F/Hxm9v+YwG8Jlkm3BNAntfTrlDFzqR+rvjiPXHkAiGeuxIXGhhuYTmzPC4wY
         qUY84+Cc4N23AvCdwRhh7Hbmmu0Hn/expUrGqZsDLbbGSNiiebgLxXTZtM1r0Bpgxgj2
         Ha6+ObIxcvBeElM0cvgodvjm4qwj3YPOrKPlFMSHWmRH89SlL8I7eDBoulU5xDhqhlpG
         4/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700959077; x=1701563877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uPUXkFTFTY3wjyppF4kZdPmBYcUNyv8eWABZcZLvEU=;
        b=a41u3qlvnBbMgnr1tRXZFw2JMupn7d9Pm3z7AON4cVrjfosrojSiZIfzNsgQZY0I4g
         LFS1O42slvIBLdq3bPUyAVf271N3i+0nNOK7DdFgrVqf81jYGBHB3ioACt+n1PcuZ8U6
         TGP/bA1wnmxXoEkFF8M9V5y4bS8TMm0ijQSbrfqT8xZg+JRVd77cR1b94ZUtK7zB8bLS
         4CPrsLumBvNUFUOWb3ZE1k94RjBLbCCFUPI5Bc2C4kqMsPw3aA/k5QVdlU1dHSYVCT23
         qk4Se03QM5EfarHwHIv82PYBT4DXkTlW9qi/SUt0NbySwWxjAtiNf9sfMzt2LYfdjd1l
         g3nA==
X-Gm-Message-State: AOJu0YzcvZtXNizTBFgZU9WKE3ulrA8IUoXeiNu8JInDYncpNn6lyxKv
        4Bgo9taZBhkb6tLt8gim6l0=
X-Google-Smtp-Source: AGHT+IFbjCVaPkKuump1gsxBNZe2guiftP25Uvws8RLzuh7OnwNLqC2X/9V7y2UNRbD1wave5mjM+w==
X-Received: by 2002:adf:fd48:0:b0:332:e9f7:9a99 with SMTP id h8-20020adffd48000000b00332e9f79a99mr4703218wrs.43.1700959077474;
        Sat, 25 Nov 2023 16:37:57 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id v19-20020adfd053000000b0032f9688ea48sm7735249wrh.10.2023.11.25.16.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 16:37:57 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Harini Katakam <harini.katakam@amd.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next PATCH 3/3] net: phy: add support for PHY package MMD read/write
Date:   Sun, 26 Nov 2023 01:37:48 +0100
Message-Id: <20231126003748.9600-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231126003748.9600-1-ansuelsmth@gmail.com>
References: <20231126003748.9600-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some PHY in PHY package may require to read/write MMD regs to correctly
configure the PHY package.

Add support for these additional required function in both lock and no
lock variant.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/phy.h | 74 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 984bca9a82f4..1799133c8387 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2067,6 +2067,80 @@ static inline int __phy_package_write(struct phy_device *phydev,
 	return __mdiobus_write(phydev->mdio.bus, addr, regnum, val);
 }
 
+static inline int phy_package_read_mmd(struct phy_device *phydev,
+				       unsigned int addr_offset, int devad,
+				       u32 regnum)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr, val;
+
+	if (!shared || shared->base_addr + addr_offset > PHY_MAX_ADDR)
+		return -EIO;
+
+	addr = shared->base_addr + addr_offset;
+
+	phy_lock_mdio_bus(phydev);
+	mmd_phy_indirect(bus, addr, devad, regnum);
+	val = __mdiobus_read(bus, addr, MII_MMD_DATA);
+	phy_unlock_mdio_bus(phydev);
+
+	return val;
+}
+
+static inline int __phy_package_read_mmd(struct phy_device *phydev,
+					 unsigned int addr_offset, int devad,
+					 u32 regnum)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr;
+
+	if (!shared || shared->base_addr + addr_offset > PHY_MAX_ADDR)
+		return -EIO;
+
+	addr = shared->base_addr + addr_offset;
+	mmd_phy_indirect(bus, addr, devad, regnum);
+	return __mdiobus_read(bus, addr, MII_MMD_DATA);
+}
+
+static inline int phy_package_write_mmd(struct phy_device *phydev,
+					unsigned int addr_offset, int devad,
+					u32 regnum, u16 val)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr, ret;
+
+	if (!shared || shared->base_addr + addr_offset > PHY_MAX_ADDR)
+		return -EIO;
+
+	addr = shared->base_addr + addr_offset;
+
+	phy_lock_mdio_bus(phydev);
+	mmd_phy_indirect(bus, addr, devad, regnum);
+	ret = __mdiobus_write(bus, addr, MII_MMD_DATA, val);
+	phy_unlock_mdio_bus(phydev);
+
+	return ret;
+}
+
+static inline int __phy_package_write_mmd(struct phy_device *phydev,
+					  unsigned int addr_offset, int devad,
+					  u32 regnum, u16 val)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr;
+
+	if (!shared || shared->base_addr + addr_offset > PHY_MAX_ADDR)
+		return -EIO;
+
+	addr = shared->base_addr + addr_offset;
+	mmd_phy_indirect(bus, addr, devad, regnum);
+	return __mdiobus_write(bus, addr, MII_MMD_DATA, val);
+}
+
 static inline bool __phy_package_set_once(struct phy_device *phydev,
 					  unsigned int b)
 {
-- 
2.40.1

