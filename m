Return-Path: <linux-kernel+bounces-64361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8213A853D78
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0801F218C5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F8164CD2;
	Tue, 13 Feb 2024 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrK2JmOo"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398DD64A8A;
	Tue, 13 Feb 2024 21:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860441; cv=none; b=nfmD522N7L2ypRQX+qxLrRTyPxXZSSq0ZUeTqGX0zmqtc9LuPdewMS7LId5e2uDQ27dIXnKytQRVA424ZiaRMikv9bYNVVuDohjJgws62uOttuS1y7JdQeHTaVi7Lc6EgKITx/Ti1RkejUE1IeuawpaA0+dLxlVUu4JbKGZvRUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860441; c=relaxed/simple;
	bh=/CDF4FFzzPAWghGNTUm7S6kFdUaIxw2+IbQwN7IiNFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fvJHKlg+A379p6e/wupY86sKoe3J8n+lAuj9xfH+lJO0AA/UjxMZBZX4N3TyiHIoN9JiafFAERJFIPSdtLRkHT9p/4NuaeGfuZuqRsrhrvKlVW7MZFQdDwPVpUcZR5OwYMyjfRe3FrFhFtBAe792wua5QD+snIP4RKpAMtxsLQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrK2JmOo; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5621f7c86c9so381744a12.0;
        Tue, 13 Feb 2024 13:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707860437; x=1708465237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGBYqZsltXYC+5JrS5KQP7H6qx5a94ybTWliBzFTS6A=;
        b=lrK2JmOouClswcJbk3fcqnk0hDnjTLPNon97VeSk6/V4BdMCtiy0fR4v9xBN8IjscP
         sLT0ETK6grOzfJhQm+fFRnj0N8V69jKOe1t62poKnRgVT0KVnfCHRVvQt3bdXlL69adu
         HxO9HxPq+JKOZ1YWMQ11F7emlmpHQoPHMfKBgdYpjlh811qxob/4eNyDUhb+pVGhNOPw
         KJ6eLv590HtSM5LGa+C4gyy2ff84k9FcGZ1yxS8J5rum6p8Wn/butRpdYgv71pn5XT0E
         ujxCuz7t3wIWWtAGvBKr2guUd1a9JHpi0AtyojyRysGRvXQiBrPfguy6QrMKo1SEbLpJ
         SP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707860437; x=1708465237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGBYqZsltXYC+5JrS5KQP7H6qx5a94ybTWliBzFTS6A=;
        b=U+d21xNDfyDhyi+G2JCZyD57XcaNPToa+dbbGNS1Trogtt4aJRC7rQ9DO3UCwTwJ2/
         mWLQ5XwnJND9zBYUNUlNIiRREx8ayh/zr5VlMYEC90KAg36xIhJN6OIlsgOsjmE1Zr9y
         IZ9LeSWtsiJ/SVLwMHahoyV26+4AoC3DKFjC7pBIeJjEXV1prkoA/QiNoehIk9L0ATbO
         WmFLBz9o81sFEAgsdLYrohKIN2f4Tma7fS/x1PogA24a89Y3G3hb9gP8Vly+1dX15ag8
         +WwlYkc4+QipG10dvD6urpH1ecxtOi8HsamQwPosH58BfibOjCpPq4unmN6L/4APzrJS
         AfXA==
X-Forwarded-Encrypted: i=1; AJvYcCVSeXP7zit6Ff+UzsOOI6CGH61w8O3ISf3hM+peAvE0O7qpDvhx0/dttODN/JBaU61yC4om9nqf0as+ZHZ8VV1BBqJrzrWQ6HANO5p1ynrZeYYcXJHa6fM5ZA9FLsMNaJB11lKc
X-Gm-Message-State: AOJu0Yzi6ms1auEB5cP5/v1zOkl8KP/GcVQkDJ22hzpltvpYzgnt92xB
	R2CjlRFOcQH6onKbKgTgG/mlBUjDMXXj1FYHuyRWaaH4IGQK8zDu
X-Google-Smtp-Source: AGHT+IE/+U5swRexCsL5tU/3AZadAypcal31siC7UkLGZQbNwh7s/LUVnCtU9afpwvblc8QX4Hl0Zw==
X-Received: by 2002:a05:6402:3709:b0:562:6198:1aaa with SMTP id ek9-20020a056402370900b0056261981aaamr60032edb.19.1707860437559;
        Tue, 13 Feb 2024 13:40:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVC+m9nI/HfsehLhahkuDV7kBkWlEdSssPeoMyRGyZMg5gh3vMEqHLYfLOVUYJsHhJ9FZ0nBgYscGKWX1r4ni6l/2Feu8JLyd/swcaNrhqkAQBi7uHIVpUbh13QcJrgwbST5hg0quWamORZt625ysC6jPah/8RSrUTprt8+wd2o7A0Endo7bS/4h7IwrRC0h6k/DF/QyGiJkfTzVGewGmMNbiFoSc20gkwGjzg4MxQWI4evN3hP+iyfs4pOLnRYls+oaIL3xa3R/zT2MJ7s40ZZUNxRkdTcGi1Ch9OrY2/WQUJhDUfp8F9B5VvK61blAeGSoyX79qD4asSGks41m2Whcgw=
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id k23-20020a05640212d700b005612987a525sm4003913edx.89.2024.02.13.13.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:40:37 -0800 (PST)
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
Subject: [PATCH v6 net-next 09/14] net: phy: marvell-88q2xxx: add cable test support
Date: Tue, 13 Feb 2024 22:39:48 +0100
Message-Id: <20240213213955.178762-10-dima.fedrau@gmail.com>
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
 drivers/net/phy/marvell-88q2xxx.c | 97 +++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 2ca1b47e8f8f..93a6a9dff722 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -72,6 +72,26 @@
 
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
@@ -715,6 +735,80 @@ static int mv88q222x_revb0_config_init(struct phy_device *phydev)
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
+	dist = FIELD_GET(MDIO_MMD_PCS_MV_TDR_STATUS_DIST_MASK, ret) * 100;
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
@@ -732,6 +826,7 @@ static struct phy_driver mv88q2xxx_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_88Q2220_REVB0),
 		.name			= "mv88q2220",
+		.flags			= PHY_POLL_CABLE_TEST,
 		.probe			= mv88q2xxx_probe,
 		.get_features		= mv88q2xxx_get_features,
 		.config_aneg		= mv88q222x_config_aneg,
@@ -742,6 +837,8 @@ static struct phy_driver mv88q2xxx_driver[] = {
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


