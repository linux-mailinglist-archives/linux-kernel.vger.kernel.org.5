Return-Path: <linux-kernel+bounces-6376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0786E8197E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B879D28735C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F80BDDC6;
	Wed, 20 Dec 2023 04:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1yXN7tr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FAAC2C3;
	Wed, 20 Dec 2023 04:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3ec3db764so1714905ad.2;
        Tue, 19 Dec 2023 20:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703048006; x=1703652806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oCdzME/wc/7u1TobMBsXQV40LzKB+51jmYS/oXHHLXc=;
        b=U1yXN7trYxo5D5Cxn2wMtvdgBW3I5iibYfDFs+EFVSw5RrbfgW0V2JnepSR/eknnuU
         EpsL1gq9zU6faocDbEF/Ti5rt/BJZ6sCf9LKtG6rp+EtS/AXtm154DOsdw1KiJGz/8+Q
         90xmBL1sHW2UxzNBmw3aYdpGUwgpof+FhbTMA/Fl+6aZVcqpgnRmy0MKJIgc5xP97YJy
         F1wF+OcWP3zrw+0a0dThfuDTzdTIACAlYBAzUuGY2hZu+AvFIkVRkEnYjU9TMWyxGUmW
         k1MbWzy4dpmD0LefHPRdQvz5G56rv0fzHrQSKfEr2fLUcwx+zoBHRPiuohAygutq9bhC
         Nq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703048006; x=1703652806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oCdzME/wc/7u1TobMBsXQV40LzKB+51jmYS/oXHHLXc=;
        b=rE5XCdMQRrA3mriUyyQ+b2wzaQK1WiBM2T0NBYltjj3Z5GidlMHsjofugLiTpWnkM/
         xgVKCwzyFXOgb6yYWrKEz9LPv43NDWG2emKDWMxj2ZsmyX4UBjq/piVFuho4XkI6+dNK
         cVvNbI5Xjb3NZpTonZ6QdPhqz/4MygRSNih8eYQVpwgAacpkTOYEgB2io7akENIKfbuY
         G/Is3ERQEP8KcC+x2DNaHQhgI/bhzcQrBdWpOGnGtCTFcxAZdYDoqKXAN+xpDfet5aeZ
         h4ebF38e6FMGTD3rLE444TNrJOHQEqKJx/0dVZtQba80iHEtAtFg4Ac7ga5I3n9sLA1E
         rLEA==
X-Gm-Message-State: AOJu0YwmqkWB0eNs26ofu06VAp536AlnUby5Arj7eERb6aYSvKIk4thQ
	hFwqaAQT0BOK5nMhzSSkqCctq/ZqFT+DPimB
X-Google-Smtp-Source: AGHT+IF3u/O7Dv8UZexVlCWkA9GaEQFhA0ieTFtwHTi+OR/olqfkZ7X0BSr1dk7b18xZlKq863OlDg==
X-Received: by 2002:a17:902:a58b:b0:1d0:8d57:482 with SMTP id az11-20020a170902a58b00b001d08d570482mr9234611plb.50.1703048006398;
        Tue, 19 Dec 2023 20:53:26 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902b28700b001cfcd2fb7b0sm3049318plr.285.2023.12.19.20.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 20:53:25 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next] net: mdio: get/put device node during (un)registration
Date: Wed, 20 Dec 2023 01:52:29 -0300
Message-ID: <20231220045228.27079-2-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __of_mdiobus_register() function was storing the device node in
dev.of_node without increasing its reference count. It implicitly relied
on the caller to maintain the allocated node until the mdiobus was
unregistered.

Now, __of_mdiobus_register() will acquire the node before assigning it,
and of_mdiobus_unregister_callback() will be called at the end of
mdio_unregister().

Drivers can now release the node immediately after MDIO registration.
Some of them are already doing that even before this patch.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/mdio/of_mdio.c | 12 +++++++++++-
 drivers/net/phy/mdio_bus.c |  3 +++
 include/linux/phy.h        |  3 +++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index 64ebcb6d235c..9b6cab6154e0 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -139,6 +139,11 @@ bool of_mdiobus_child_is_phy(struct device_node *child)
 }
 EXPORT_SYMBOL(of_mdiobus_child_is_phy);
 
+static void __of_mdiobus_unregister_callback(struct mii_bus *mdio)
+{
+	of_node_put(mdio->dev.of_node);
+}
+
 /**
  * __of_mdiobus_register - Register mii_bus and create PHYs from the device tree
  * @mdio: pointer to mii_bus structure
@@ -166,6 +171,8 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 	 * the device tree are populated after the bus has been registered */
 	mdio->phy_mask = ~0;
 
+	mdio->__unregister_callback = __of_mdiobus_unregister_callback;
+	of_node_get(np);
 	device_set_node(&mdio->dev, of_fwnode_handle(np));
 
 	/* Get bus level PHY reset GPIO details */
@@ -177,7 +184,7 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 	/* Register the MDIO bus */
 	rc = __mdiobus_register(mdio, owner);
 	if (rc)
-		return rc;
+		goto put_node;
 
 	/* Loop over the child nodes and register a phy_device for each phy */
 	for_each_available_child_of_node(np, child) {
@@ -237,6 +244,9 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 unregister:
 	of_node_put(child);
 	mdiobus_unregister(mdio);
+
+put_node:
+	of_node_put(np);
 	return rc;
 }
 EXPORT_SYMBOL(__of_mdiobus_register);
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 25dcaa49ab8b..1229b8e4c53b 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -787,6 +787,9 @@ void mdiobus_unregister(struct mii_bus *bus)
 		gpiod_set_value_cansleep(bus->reset_gpiod, 1);
 
 	device_del(&bus->dev);
+
+	if (bus->__unregister_callback)
+		bus->__unregister_callback(bus);
 }
 EXPORT_SYMBOL(mdiobus_unregister);
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e5f1f41e399c..2b383da4d825 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -433,6 +433,9 @@ struct mii_bus {
 
 	/** @shared: shared state across different PHYs */
 	struct phy_package_shared *shared[PHY_MAX_ADDR];
+
+	/** @__unregister_callback: called at the last step of unregistration */
+	void (*__unregister_callback)(struct mii_bus *bus);
 };
 #define to_mii_bus(d) container_of(d, struct mii_bus, dev)
 
-- 
2.43.0


