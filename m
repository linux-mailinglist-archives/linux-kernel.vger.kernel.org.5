Return-Path: <linux-kernel+bounces-55385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE6684BBFC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33402287B08
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97D013AE3;
	Tue,  6 Feb 2024 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OedQnV7k"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4868F7D;
	Tue,  6 Feb 2024 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240781; cv=none; b=IZTKYALQNMCkb+AD5/pLu45JfG2H4/h8EJ6fIRwZ14igxU4828m2WeFHfpnISYnZyvCabU8hXj8cQf8nBjoLtgAreXG0+C0i1tRBd1Z+ctxJJ2IqxZYa0Ac7h8V5lM7qQgJFCit8zuMZt0dttOn0lOKfvrH1mvjlAXOlvBQk/Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240781; c=relaxed/simple;
	bh=J78yXE5qwS90R4EgpQlY1uiAZERyB7nhqi/EFAgqCCk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRm32180BK9RRg6jdnzTDn02sv4aa58tqIGoCuNUKgGZWt490jA8A44VbtYQ75tr/3BRHia3A0N9vdLoFit2HQCFpfq86M8ywcGHia+8QL3aGOaeeIwW5sTmzZ+Uu9vYXKeXXxpkahCMFAEapCLBlsfvYM4CJt4ZNUF/PMHc7CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OedQnV7k; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40ffce2ceffso1264875e9.2;
        Tue, 06 Feb 2024 09:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707240778; x=1707845578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvEq+NsiNLdpqkcur7fcDxX3BE0a2LiFsPz8eCkRlBo=;
        b=OedQnV7k8e7/zr7s4ciBPgBTBB+m7AICc/7IOG/01lBzPfzT6ZC+WybrvVJiN3AJfs
         n/dIZlLe4MnJoWaD+BUU2QuJeqQXi7HKmEnzEtPTmKVZs3871GWwDdRQ0jrWGBwG8/Ct
         58HnGr7UqJscSZ8geBf+5ZVKt5iaKpGPMnIFvCTniVmoU63cSmXQCK7hpju16BwrrRug
         sTUqThNgvKh1AJdTi52FD6LXxYRjWOdU9HKZmdCL2pYsOr5txV2jXlfbPRlWtST2V8pd
         X6/PoAAO/plNG7KAnG6jLU6aB6YCe9ntChD3qxza0mgaW5JoLzNB1W6eausXT5AZN94I
         pXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240778; x=1707845578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvEq+NsiNLdpqkcur7fcDxX3BE0a2LiFsPz8eCkRlBo=;
        b=a5Kgjh9y2Hhro1PGkpszL0RuWpcrexx1z/dnsNMdzvS8VECOZs3qEzMlzQlHTD6NoZ
         /gstdj7EICdzF1uearL8nyVFgGCFU6k5HSVLqjWWkbN9GXjDvkxEMkOq3L1Mnh0dtNXR
         rXrzdzb4MkLoN2HWNl58BD+VXu3/bEyVMOUAz23bhyyGLorZMcjyFv4qQfceCAV1flUv
         /1s7ySRpfYMh24iU6f/PsyGbCXtaxmv1TQdvPnwm9PONT11uVVV9OpaBPDANcktNH5QQ
         cVkD5XIRNapYMvqEWOCu0+2OUrLRzpQ2ZPNsOAz9lqIrwPWObzeA8M5mAd/lVyBZZooB
         Yy5w==
X-Gm-Message-State: AOJu0Yzpgmm83h/1gf+d9023vN4F4KSEWsjF3a6XY7VaQINCuvgQosN1
	TWluZGOtzHqhqHhJ8vknWlM1hZTfOgxwyN5WguRyv8rmSO0a+tJv
X-Google-Smtp-Source: AGHT+IFA+ihnfwGzQ5lwjMeITLI9ICJOubGxAayNdeBL4PPr1dASByyJ6iNLwwDS+TIgDe9lqlAbRQ==
X-Received: by 2002:a05:600c:4f0e:b0:40f:dde8:1663 with SMTP id l14-20020a05600c4f0e00b0040fdde81663mr2935082wmq.19.1707240777897;
        Tue, 06 Feb 2024 09:32:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXlA35Uq5N1Nys7Xu67Fa9mPzf3mhp/AXnH7iE2VN7PZO7oPKHnCPkdteXwzbMr7qPwz0sOtgsbs/gHTrfpl5Qzegr77KvWSiiBOToICtNxvzSDzwVlWJMv92zJW6KcpvQYl2GsM4DH4S/NwSZbF9YaJpGOS2g0TXpH3gL0Z0xxkopxmB8FrmXJQMHjc7qBTbVyJrcq6Zxt8L6sj91IXI0U+GpR4BEdIeSDbLd79DBmyeXzpVHPVvOLdXPQ8Q7ftKnpldwRkZVhEaRtIL132BAxYaZXofJgUHPLDAuAxMEZHMxz+tlYWDemF1WC86Wh7f0dfdOuZBTEGmIV9L4jZrDD1x09FncsX7s8bwmDpGQw0JWKOzWpGFOFAJS5guV3wjbOqy3HeAWJohDsYUUyAtjR4m4Kozj305Hj3TaYbBrcoIaoxZzQCzKUN5UVqBgVlTUsZGyICcYKl0QzpmDTsgQgqeOPvwZKOt90PBGWBYHElzt6iJjMy5V1z44mFgp0goN08X311Zr8++Q5pKevUwVzKW2thdYv4YzfGO9Du8CwLY2eKbbSJClzezOGSbD236XgljgB0CQx4kwQmwcos1OOKSNBARNTR+J+QrlB9bTJuJUCsm3SoPu7Oyhxihzn9XuYgwALF2DjbMx9DDtSZAdlageTT9T2CpPe3tdw3rc0Iksp0EqjYg==
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id l14-20020a05600c4f0e00b0040fc56712e8sm2621215wmq.17.2024.02.06.09.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:32:56 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v7 03/10] net: phy: add devm/of_phy_package_join helper
Date: Tue,  6 Feb 2024 18:31:06 +0100
Message-ID: <20240206173115.7654-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206173115.7654-1-ansuelsmth@gmail.com>
References: <20240206173115.7654-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devm/of_phy_package_join helper to join PHYs in a PHY package. These
are variant of the manual phy_package_join with the difference that
these will use DT nodes to derive the base_addr instead of manually
passing an hardcoded value.

An additional value is added in phy_package_shared, "np" to reference
the PHY package node pointer in specific PHY driver probe_once and
config_init_once functions to make use of additional specific properties
defined in the PHY package node in DT.

The np value is filled only with of_phy_package_join if a valid PHY
package node is found. A valid PHY package node must have the node name
set to "ethernet-phy-package".

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy_device.c | 96 ++++++++++++++++++++++++++++++++++++
 include/linux/phy.h          |  6 +++
 2 files changed, 102 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2eed8f03621d..9014ac3c0fc8 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1708,6 +1708,7 @@ int phy_package_join(struct phy_device *phydev, int base_addr, size_t priv_size)
 			shared->priv_size = priv_size;
 		}
 		shared->base_addr = base_addr;
+		shared->np = NULL;
 		refcount_set(&shared->refcnt, 1);
 		bus->shared[base_addr] = shared;
 	} else {
@@ -1730,6 +1731,63 @@ int phy_package_join(struct phy_device *phydev, int base_addr, size_t priv_size)
 }
 EXPORT_SYMBOL_GPL(phy_package_join);
 
+/**
+ * of_phy_package_join - join a common PHY group in PHY package
+ * @phydev: target phy_device struct
+ * @priv_size: if non-zero allocate this amount of bytes for private data
+ *
+ * This is a variant of phy_package_join for PHY package defined in DT.
+ *
+ * The parent node of the @phydev is checked as a valid PHY package node
+ * structure (by matching the node name "ethernet-phy-package") and the
+ * base_addr for the PHY package is passed to phy_package_join.
+ *
+ * With this configuration the shared struct will also have the np value
+ * filled to use additional DT defined properties in PHY specific
+ * probe_once and config_init_once PHY package OPs.
+ *
+ * Returns < 0 on error, 0 on success. Esp. calling phy_package_join()
+ * with the same cookie but a different priv_size is an error. Or a parent
+ * node is not detected or is not valid or doesn't match the expected node
+ * name for PHY package.
+ */
+int of_phy_package_join(struct phy_device *phydev, size_t priv_size)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	struct device_node *package_node;
+	u32 base_addr;
+	int ret;
+
+	if (!node)
+		return -EINVAL;
+
+	package_node = of_get_parent(node);
+	if (!package_node)
+		return -EINVAL;
+
+	if (!of_node_name_eq(package_node, "ethernet-phy-package")) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (of_property_read_u32(package_node, "reg", &base_addr)) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	ret = phy_package_join(phydev, base_addr, priv_size);
+	if (ret)
+		goto exit;
+
+	phydev->shared->np = package_node;
+
+	return 0;
+exit:
+	of_node_put(package_node);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_phy_package_join);
+
 /**
  * phy_package_leave - leave a common PHY group
  * @phydev: target phy_device struct
@@ -1746,6 +1804,10 @@ void phy_package_leave(struct phy_device *phydev)
 	if (!shared)
 		return;
 
+	/* Decrease the node refcount on leave if present */
+	if (shared->np)
+		of_node_put(shared->np);
+
 	if (refcount_dec_and_mutex_lock(&shared->refcnt, &bus->shared_lock)) {
 		bus->shared[shared->base_addr] = NULL;
 		mutex_unlock(&bus->shared_lock);
@@ -1798,6 +1860,40 @@ int devm_phy_package_join(struct device *dev, struct phy_device *phydev,
 }
 EXPORT_SYMBOL_GPL(devm_phy_package_join);
 
+/**
+ * devm_of_phy_package_join - resource managed of_phy_package_join()
+ * @dev: device that is registering this PHY package
+ * @phydev: target phy_device struct
+ * @priv_size: if non-zero allocate this amount of bytes for private data
+ *
+ * Managed of_phy_package_join(). Shared storage fetched by this function,
+ * phy_package_leave() is automatically called on driver detach. See
+ * of_phy_package_join() for more information.
+ */
+int devm_of_phy_package_join(struct device *dev, struct phy_device *phydev,
+			     size_t priv_size)
+{
+	struct phy_device **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_phy_package_leave, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = of_phy_package_join(phydev, priv_size);
+
+	if (!ret) {
+		*ptr = phydev;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_of_phy_package_join);
+
 /**
  * phy_detach - detach a PHY device from its network device
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index ad93f8b1b128..f8ce8a757ed0 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -329,6 +329,7 @@ struct mdio_bus_stats {
  * struct phy_package_shared - Shared information in PHY packages
  * @base_addr: Base PHY address of PHY package used to combine PHYs
  *   in one package and for offset calculation of phy_package_read/write
+ * @np: Pointer to the Device Node if PHY package defined in DT
  * @refcnt: Number of PHYs connected to this shared data
  * @flags: Initialization of PHY package
  * @priv_size: Size of the shared private data @priv
@@ -340,6 +341,8 @@ struct mdio_bus_stats {
  */
 struct phy_package_shared {
 	u8 base_addr;
+	/* With PHY package defined in DT this points to the PHY package node */
+	struct device_node *np;
 	refcount_t refcnt;
 	unsigned long flags;
 	size_t priv_size;
@@ -1999,9 +2002,12 @@ int phy_ethtool_set_link_ksettings(struct net_device *ndev,
 				   const struct ethtool_link_ksettings *cmd);
 int phy_ethtool_nway_reset(struct net_device *ndev);
 int phy_package_join(struct phy_device *phydev, int base_addr, size_t priv_size);
+int of_phy_package_join(struct phy_device *phydev, size_t priv_size);
 void phy_package_leave(struct phy_device *phydev);
 int devm_phy_package_join(struct device *dev, struct phy_device *phydev,
 			  int base_addr, size_t priv_size);
+int devm_of_phy_package_join(struct device *dev, struct phy_device *phydev,
+			     size_t priv_size);
 
 int __init mdio_bus_init(void);
 void mdio_bus_exit(void);
-- 
2.43.0


