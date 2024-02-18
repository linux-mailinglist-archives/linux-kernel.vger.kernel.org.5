Return-Path: <linux-kernel+bounces-70267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCEE85956A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788191F21D76
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B499208C0;
	Sun, 18 Feb 2024 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDdX/nla"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CDE20316;
	Sun, 18 Feb 2024 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708243108; cv=none; b=YKbfy/lPCjiv3N8GF8LjUop7JD9ybvFyadpxQ1LFRKXBAfYfAU3j3JGSIH+7KmtO6bS85VmLkyeGxHetALiTSATcmf24sQWVLJhx/CaxfGIST5akp2q1DxDG6RQvoAIq/c2M33gGt81whwcEuN23W1/jUJZGOsY4PK/iUb/+QNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708243108; c=relaxed/simple;
	bh=UedqRELMO7e8o7c66PHVA/kd0dvR8BduXQgVhk7eUpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eKMqRpWajSEH1vIwYKcdIx88V/QDZJ8odZbSLcu2rce0jBUEk1IGi93kzw3dkwYmGAB/+RoLmItvAQXBwAhVhyVZ0kQ8MWD3Gmdlmivnxw0zLC5eZY2h2SCVW92mH7mHQxnj/crYkz5DGRZQyyjNaad1TxulhbhEWTLZ7lJ4Hak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDdX/nla; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2a17f3217aso432182766b.2;
        Sat, 17 Feb 2024 23:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708243105; x=1708847905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJGv4BnTeZKfUPwk1e7iNloffsoJmrlyLh8bOyrQHPY=;
        b=ZDdX/nla1gOr7q7eW1D3nlmLBtjtucskP96ilgLSUqGVTKOg5q2QgCVAJdsJhIUQbn
         NUiHUFOFTA9qdd2mnQtzsLzY0F8sfaKHZ3mHt16v3qAwVr5XvBgUvKdAUB7sjuB6P2jh
         wKmWxYVlSOHWRs16e8nNzkAw2Tp5XOpGFM09VO5ANHn72GH440ZTXOP3tmVCvB6Tl0h1
         lZWtwmRa9BuZFwpEEPDS9N/i8K32ownEIHA6kf09AK0d90cjwRgZ2y3zgst6n/4l0INq
         jMq2Ya30qylsVeVvzRoThRc3C8vvBhDNd2cU7oQ/3nJu7UBEA9DCTJ+Lfq5NDbV73+WF
         GmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708243105; x=1708847905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJGv4BnTeZKfUPwk1e7iNloffsoJmrlyLh8bOyrQHPY=;
        b=SY00o4kzFj8ASu1EAViQ2A77kspll8SbsiqbBkEdj+9pzDnedaWKjdpdV3UkU+oH67
         cF/WBtvtnb502a9fv4JnEuqoDM8rIOJvUrJrqXooVCGqU9jMMiN+zpHgiAnfVw4UJfwI
         F9sMc9NYafJFYOR+7qukLXFimnQEdkDdkTMUH4hba+sX1WTexyQ+fJoKqnHOcuOH1zzb
         u/YQSosRezYQMpUBB0RDvWqmxcXklgngaxYD+/TtPBys2m/FqA7P8qrOhHPf3pW9ajNc
         n6StmvlA5UprJP0LMChlULOkh7Wr794p5iRnGxAdj/ST6KdODurlIUjSGoUM8IwsswPR
         6S6g==
X-Forwarded-Encrypted: i=1; AJvYcCXWJ4WtcZZkuqJ05/kGX59+gNaJHgyIjiUAJHQ4FJPLGsViqCh+pNYs3XgXSxFd0P+8A57oZObcjUsVZg2qw4zO+v3NuTrcTnzmW1GMGd+d9eAVnd7UqyMZq+Ii27YZznt4/4Cn
X-Gm-Message-State: AOJu0Yxr9dfzW64rzBs/plIp4JrFdIhEWk6LqGRF99Z71wOjR6WurbYR
	xgAdBW/32vhLVhXYT8NNXe/5k/InvQz7ms9UjVTZ/RO0/u0z4skL
X-Google-Smtp-Source: AGHT+IFJnZYjiv6Rl7dgXluxt1+cAqLscj82FxxRFywoVAhkRGJsCE+5RlkFAbf9TFw1Sq4P1sTtYA==
X-Received: by 2002:a17:906:278c:b0:a3e:5993:96e9 with SMTP id j12-20020a170906278c00b00a3e599396e9mr886455ejc.42.1708243104817;
        Sat, 17 Feb 2024 23:58:24 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id jj12-20020a170907984c00b00a3e64bcd2c1sm458732ejc.142.2024.02.17.23.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 23:58:24 -0800 (PST)
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
Subject: [PATCH v7 net-next 09/14] net: phy: marvell-88q2xxx: add cable test support
Date: Sun, 18 Feb 2024 08:57:46 +0100
Message-Id: <20240218075753.18067-10-dima.fedrau@gmail.com>
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
 drivers/net/phy/marvell-88q2xxx.c | 107 ++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 2ca1b47e8f8f..11963d8176b2 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -72,6 +72,27 @@
 
 #define MDIO_MMD_PCS_MV_RX_STAT			33328
 
+#define MDIO_MMD_PCS_MV_TDR_RESET			65226
+#define MDIO_MMD_PCS_MV_TDR_RESET_TDR_RST		0x1000
+
+#define MDIO_MMD_PCS_MV_TDR_OFF_SHORT_CABLE		65241
+
+#define MDIO_MMD_PCS_MV_TDR_OFF_LONG_CABLE		65242
+
+#define MDIO_MMD_PCS_MV_TDR_STATUS			65245
+#define MDIO_MMD_PCS_MV_TDR_STATUS_MASK			0x0003
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
@@ -715,6 +736,89 @@ static int mv88q222x_revb0_config_init(struct phy_device *phydev)
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
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TDR_STATUS,
+			    MDIO_MMD_PCS_MV_TDR_STATUS_ON);
+	if (ret < 0)
+		return ret;
+
+	/* According to the Marvell API the test is finished within 500 ms */
+	msleep(500);
+
+	return 0;
+}
+
+static int mv88q222x_cable_test_get_status(struct phy_device *phydev,
+					   bool *finished)
+{
+	int ret, status;
+	u32 dist;
+
+	status = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TDR_STATUS);
+	if (status < 0)
+		return status;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TDR_RESET,
+			    MDIO_MMD_PCS_MV_TDR_RESET_TDR_RST | 0xd90);
+	if (ret < 0)
+		return ret;
+
+	/* Test could not be finished */
+	if (FIELD_GET(MDIO_MMD_PCS_MV_TDR_STATUS_MASK, status) !=
+	    MDIO_MMD_PCS_MV_TDR_STATUS_OFF)
+		return -ETIMEDOUT;
+
+	*finished = true;
+	/* Fault length reported in meters, convert to centimeters */
+	dist = FIELD_GET(MDIO_MMD_PCS_MV_TDR_STATUS_DIST_MASK, status) * 100;
+	switch (status & MDIO_MMD_PCS_MV_TDR_STATUS_VCT_STAT_MASK) {
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
+	default:
+		ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_A,
+					ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC);
+	}
+
+	return 0;
+}
+
 static struct phy_driver mv88q2xxx_driver[] = {
 	{
 		.phy_id			= MARVELL_PHY_ID_88Q2110,
@@ -732,6 +836,7 @@ static struct phy_driver mv88q2xxx_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_88Q2220_REVB0),
 		.name			= "mv88q2220",
+		.flags			= PHY_POLL_CABLE_TEST,
 		.probe			= mv88q2xxx_probe,
 		.get_features		= mv88q2xxx_get_features,
 		.config_aneg		= mv88q222x_config_aneg,
@@ -742,6 +847,8 @@ static struct phy_driver mv88q2xxx_driver[] = {
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


