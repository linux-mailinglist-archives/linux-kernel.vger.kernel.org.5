Return-Path: <linux-kernel+bounces-34190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F21283755E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F27F1F29E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65574C608;
	Mon, 22 Jan 2024 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3xfB1ND"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C5F4C3AC;
	Mon, 22 Jan 2024 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959000; cv=none; b=IE64LR7c7vbMC8GiyQO5Y8WASbX0sru3W+siG/rJjlVtg4uI5Xb3/oMNyTczfM/PIknni6Ged8vpXf/j6algTrl///Fj1AHCPzfgonjMkDIoXGW+Y02oqaMLEdQeHXlzMl/J1eRcq0VGIYyTWNvBOoM5JN4F4oMV6ix4QWXWTZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959000; c=relaxed/simple;
	bh=qVyFNiyrOxvam5PJRduGqnbcLSNbHYORFfEpx8Gr/k4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NO3MnfiLcuDeOIicgJasktDROpURMyjf9QoD9em3aDbs/ZQKi7WicmoezAkHiG1p4AyiO5gBsNFN/GdBim0VQVYDrVqchuU3o3s6F32NgjXoAGQM/FAmZ0jXWFFDla7ocLXM2CMGPLbbu5K5p3EzM2qkiBQyjOrR2I9vf5fo5H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3xfB1ND; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e67f70f34so3669163e87.0;
        Mon, 22 Jan 2024 13:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705958997; x=1706563797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mj04PlTaa1VFbNNnp5D3mtUH9xjfkOXtxn0mSDn054Y=;
        b=I3xfB1NDG+PIofXUtpWXLn6v5lY6CZZnmucv59SR4mSFSVJ9Gf+R3Az0ouD1G701n1
         gknNDYwoYtOQAXJYok+LC7ToySUf5f0htS9gbTkT9DeYMrg5q+vvd2lggT9FA6Fvg+li
         qAXS0Uge2TjSEJjl7ZdihBbg/1dM8gdBpMrR1P99ysCF889xe2xvcD7F33QfJiZDG3i/
         Ws5NyHpENlwY36t2L+bXOHc/pyHrY/LNyt3PLxUtlc0FmOIONpj/es/H+XjuYRT1JfBx
         IOfoOJMc+owNQHx2QdLYqHLbt/yMLt+wnEMJ58znU18+fVQtG2m5HtyR64Zg5yXtbLrJ
         R9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705958997; x=1706563797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mj04PlTaa1VFbNNnp5D3mtUH9xjfkOXtxn0mSDn054Y=;
        b=ohpv4rSGvyErNc3NCCitOKCPXwhvXL/mNUIPnUOO/34WRwSgNsgfPUQglZt5eDG0Bz
         1sR7y8F0APUhpEBV4OLnpAHvnKJqXlAUwNaPxiwP6vKAGgvnxkRmszmwmWKcnxn/8pXT
         XvkC7QPuMipa9unlqwm7+oP3iN7+q59VTPcn6CW0OB+QPdT06qoG4oKgelOwHbRd5sK/
         JTg7r1HBf2LKpcDrL2rrsaWo+RnNVmJkKURI57fpRmLsWeg1e9PKgmf173xkIKrlVAq6
         FdEGgQrwIgVpNDsh3Qu7iLK7c7yj6F68silrYxSBbUt5DClUY47aBtOXaYim6EjCsYi6
         xq5w==
X-Gm-Message-State: AOJu0YxlcZQ0D4TnlAeeOgu+BJ1vvjVaEs5e4U2kNQzI7tkwXWGIJjT+
	ntScB8uzs6wJZ5NeRU9Np7ErjkPRQ+TfxyAByOTglAfnN4PjMck1
X-Google-Smtp-Source: AGHT+IHHouQq7KhdHok3D7fdv8M2tJI2VXrn2glQM5A4YDt7icaQYPRSJ/vSOcj7b4hOPktZJD8+xg==
X-Received: by 2002:a05:6512:b11:b0:50e:7e29:b0e9 with SMTP id w17-20020a0565120b1100b0050e7e29b0e9mr2333212lfu.73.1705958997044;
        Mon, 22 Jan 2024 13:29:57 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a26af4d96c6sm13823336ejt.4.2024.01.22.13.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:29:56 -0800 (PST)
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
Subject: [PATCH v5 net-next 09/13] net: phy: marvell-88q2xxx: add cable test support
Date: Mon, 22 Jan 2024 22:28:42 +0100
Message-Id: <20240122212848.3645785-10-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122212848.3645785-1-dima.fedrau@gmail.com>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add cable test support for Marvell 88Q222x devices. Reported distance
granularity is 1m.

1m cable, open:
  Cable test started for device eth0.
  Cable test completed for device eth0.
  Pair A code Open Circuit
  Pair A, fault length: 1.00m

1m cable, shorted:
  Cable test started for device eth0.
  Cable test completed for device eth0.
  Pair A code Short within Pair
  Pair A, fault length: 1.00m

6m cable, open:
  Cable test started for device eth0.
  Cable test completed for device eth0.
  Pair A code Open Circuit
  Pair A, fault length: 6.00m

6m cable, shorted:
  Cable test started for device eth0.
  Cable test completed for device eth0.
  Pair A code Short within Pair
  Pair A, fault length: 6.00m

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 99 +++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 6900bad275d0..f59822cf9526 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -69,6 +69,27 @@
 
 #define MDIO_MMD_PCS_MV_RX_STAT			33328
 
+#define MDIO_MMD_PCS_MV_TDR_RESET			65226
+#define MDIO_MMD_PCS_MV_TDR_RESET_TDR_RST		0x1000
+
+#define MDIO_MMD_PCS_MV_TDR_OFF_SHORT_CABLE		65241
+
+#define MDIO_MMD_PCS_MV_TDR_OFF_LONG_CABLE		65242
+
+#define MDIO_MMD_PCS_MV_TDR_STATUS			65245
+#define MDIO_MMD_PCS_MV_TDR_STATUS_OFF			0x0001
+#define MDIO_MMD_PCS_MV_TDR_STATUS_ON			0x0002
+#define MDIO_MMD_PCS_MV_TDR_STATUS_DIST_MASK		0xff00
+#define MDIO_MMD_PCS_MV_TDR_STATUS_DIST_SHIFT		8
+#define MDIO_MMD_PCS_MV_TDR_STATUS_VCT_STAT_MASK	0x00f0
+#define MDIO_MMD_PCS_MV_TDR_STATUS_VCT_STAT_SHORT	0x0030
+#define MDIO_MMD_PCS_MV_TDR_STATUS_VCT_STAT_OPEN	0x00e0
+#define MDIO_MMD_PCS_MV_TDR_STATUS_VCT_STAT_OK		0x0070
+#define MDIO_MMD_PCS_MV_TDR_STATUS_VCT_STAT_IN_PROGR	0x0080
+#define MDIO_MMD_PCS_MV_TDR_STATUS_VCT_STAT_NOISE	0x0050
+
+#define MDIO_MMD_PCS_MV_TDR_OFF_CUTOFF			65246
+
 struct mmd_val {
 	int devad;
 	u32 regnum;
@@ -717,6 +738,81 @@ static int mv88q222x_revb0_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int mv88q222x_cable_test_start(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS,
+			    MDIO_MMD_PCS_MV_TDR_OFF_CUTOFF, 0x0058);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS,
+			    MDIO_MMD_PCS_MV_TDR_OFF_LONG_CABLE, 0x00eb);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS,
+			    MDIO_MMD_PCS_MV_TDR_OFF_SHORT_CABLE, 0x010e);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TDR_RESET,
+			    0x0d90);
+	if (ret < 0)
+		return ret;
+
+	return phy_write_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TDR_STATUS,
+			     MDIO_MMD_PCS_MV_TDR_STATUS_ON);
+}
+
+static int mv88q222x_cable_test_get_status(struct phy_device *phydev,
+					   bool *finished)
+{
+	int ret;
+	u32 dist;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TDR_STATUS);
+	if (ret < 0)
+		return ret;
+
+	*finished = true;
+	/* fault length in meters */
+	dist = ((ret & MDIO_MMD_PCS_MV_TDR_STATUS_DIST_MASK) >>
+		MDIO_MMD_PCS_MV_TDR_STATUS_DIST_SHIFT) * 100;
+	switch (ret & MDIO_MMD_PCS_MV_TDR_STATUS_VCT_STAT_MASK) {
+	case MDIO_MMD_PCS_MV_TDR_STATUS_VCT_STAT_OPEN:
+		ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_A,
+					ETHTOOL_A_CABLE_RESULT_CODE_OPEN);
+		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A,
+					      dist);
+		break;
+	case MDIO_MMD_PCS_MV_TDR_STATUS_VCT_STAT_SHORT:
+		ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_A,
+					ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT);
+		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A,
+					      dist);
+		break;
+	case MDIO_MMD_PCS_MV_TDR_STATUS_VCT_STAT_OK:
+		ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_A,
+					ETHTOOL_A_CABLE_RESULT_CODE_OK);
+		break;
+	case MDIO_MMD_PCS_MV_TDR_STATUS_VCT_STAT_IN_PROGR:
+		*finished = false;
+		break;
+	default:
+		ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_A,
+					ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC);
+	}
+
+	if (*finished)
+		return phy_write_mmd(phydev, MDIO_MMD_PCS,
+				     MDIO_MMD_PCS_MV_TDR_RESET,
+				     MDIO_MMD_PCS_MV_TDR_RESET_TDR_RST | 0xd90);
+
+	return 0;
+}
+
 static struct phy_driver mv88q2xxx_driver[] = {
 	{
 		.phy_id			= MARVELL_PHY_ID_88Q2110,
@@ -734,6 +830,7 @@ static struct phy_driver mv88q2xxx_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_88Q2220_REVB0),
 		.name			= "mv88q2220",
+		.flags			= PHY_POLL_CABLE_TEST,
 		.probe			= mv88q2xxx_probe,
 		.get_features		= mv88q2xxx_get_features,
 		.config_aneg		= mv88q222x_config_aneg,
@@ -744,6 +841,8 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.config_intr		= mv88q2xxx_config_intr,
 		.handle_interrupt	= mv88q2xxx_handle_interrupt,
 		.set_loopback		= genphy_c45_loopback,
+		.cable_test_start	= mv88q222x_cable_test_start,
+		.cable_test_get_status	= mv88q222x_cable_test_get_status,
 		.get_sqi		= mv88q2xxx_get_sqi,
 		.get_sqi_max		= mv88q2xxx_get_sqi_max,
 		.suspend		= mv88q2xxx_suspend,
-- 
2.39.2


