Return-Path: <linux-kernel+bounces-48378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58882845B37
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B343CB28DD2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6AA15DBC4;
	Thu,  1 Feb 2024 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqqsuHfy"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D7E77A0D;
	Thu,  1 Feb 2024 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800704; cv=none; b=Qj/oHwkpYaArs8gR5rpI1oCQ3wHc/oeginkFHkRrmR1e0WolRLV85WTpdtTloA6YESUTtQwujrwL35pYtFaxZZ6jLaH10ZVZkQhkJ2z6VCdqkb4P7A0reuPXJiRCmM3Vu5feAj4uNXGhYLSCWlcMlgmBre5hqDNhcYGy3IPOwqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800704; c=relaxed/simple;
	bh=bdGHFT01GXpmJAQStvsRsVbmYpKcKYK9cB/9/B8I5YA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+uALknGqXfXhM2uXak1jlLHWLmXXHNwhjN36Su7s9PVv45Xu4IRSDzYYeoVbGJ6ETin8HHa6wDt1p9myVazcFb/AgbS2GdNHXI+sBsxCf5B8Hi6qydQgd7hsZuHqgR/dKzW2R4tAWpSWnFQhhw9fYbik3Ajew/+6CoSMgps0OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqqsuHfy; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-511318ef27fso591372e87.1;
        Thu, 01 Feb 2024 07:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706800700; x=1707405500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QAcRaCEqZ94Pf+SfvUe08GyZuxBTp3ojtTnlOyieSA=;
        b=QqqsuHfyKnFShqIKpIIylz3h0tJ6icDziwaRZJGv16SD7tR9D+s0qz61Ia1SfbIyiu
         xVrKqjACPUhRl647Opm3k56WGruknSWCvJVTKpvxsJCumnU2FtQBpAsOUFrpcI2mC9TD
         +nR0RDLQdjog00jwxaou1mZy9b+Ey1ENJSv5AgJKDlg48JJwx8L50nRdMhyc3LcgoA3J
         xNMCndSyulhO7A5bcBIW323wp3ghkxaDKJjqWlMIt6E+GIjmRngzn9Ld0b+G/qmHlnaG
         lk/AwGxqrisSo9OpH7/bn/OonduCFh6BoBHJzctN7KKltRt5M+08iwrXOevuGJ1Q2Ib2
         B9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706800700; x=1707405500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QAcRaCEqZ94Pf+SfvUe08GyZuxBTp3ojtTnlOyieSA=;
        b=MI8sF4lVZjEAuugu7YI1qhCtzz86qxGvtfIF+yx5ac//0U5la1DIn1z0udKfjbfr21
         M/DIOK6VuroIhhPWKDhIrvCD/Z7Diz7+WFMF7Cy+TwAbMpxCOyOpjqC1wUpvA4AERHnE
         OU1hQXv3f2ZerI4N7QTIMm/TLou9PiY5nqpM2+jV27hAXBoPWX2Kg+RiADFguA3aRiBW
         X32u69n/N1vcXbtru604OE7Qg8LA2pDeeyHPCj9MVhmpSQDbgISC6iZhlutNB32J5U93
         EwvsAgoptjcUvJXbd55WieafFyjDTYFedXJN53p0pTMTVS1nnL5XOHkxduPCWgjBRQJb
         HPiA==
X-Gm-Message-State: AOJu0YwztY3hETWo+U3r1Qfas64iO5cF2C9u6DOuGvDnTmEmcRxMSFBl
	YEUnTGCf7k+X46Nkfe7YKz4uOrzaiIv4Qhi7dPzEN1y0V7gtwgq7
X-Google-Smtp-Source: AGHT+IETeB24EDLUg8iFv85WCoD2KiJkMyLGozTrW7q8pasox/2K+NPUznFf1sRc3MwEmK0OFHZD0A==
X-Received: by 2002:a2e:9dc8:0:b0:2cf:495a:1396 with SMTP id x8-20020a2e9dc8000000b002cf495a1396mr3546235ljj.17.1706800699851;
        Thu, 01 Feb 2024 07:18:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUZhfpkwauqipM6AxT/5MBwDq+AXyhQlMEzs9EkRat+urWzgDVcCn3/9UkKPGsIFqOMz203nQp5J1mdTyEhArspgVUzQaMWxlm+y29f5XOglD/pteGiznoUKOQN7fWxjlLkmOYZo+2SIkxMhodj85v/g31EqVyru77239hM91Dbxf5h+MUtMqOesHru4d12U4+osicUBWUxHwNTTr7ipzWrT7ot6aOGz/WnE4k81b/nljo3Hq4yRblE5AuYQ2vmCGe+Rr9guvYEgReJYB6IosZuDFN/ZElItl0bSXRchovSGeJFFFdW64f7rWLOpiREozyHXxsl7HyMPAaY8zS4NiIMNqvvWGJJt45tRmY8K+gvJV+rgcN5TeD3Dbid9x/KWDHMVTSuw83rsk2B8tAyLIdDvcwry+LpAjZIWkT+y4R7LnqF2GVUm4MEZEKfU/Fbb+ZD+Ox3CryiXbEOF70kZ+dzTHPgsZTfkyASc+RRf73mNpg1HOXbWXvfJPTttSS8ZWy5B4htaFzK36RYqShmwlCQB5Y/d+Zqdj1X3YSAKc5FsjlwCdZ+6ghSAPolioToH0Ufqg7CdqZvGEGnMl5yGd3APO0I1yxWcPpq1WQd0IpohkN912GvmQvP
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id z9-20020a2e3509000000b002cdf37ee19dsm2437978ljz.7.2024.02.01.07.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:18:19 -0800 (PST)
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
	Frank Rowand <frowand.list@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v5 4/9] net: phy: qcom: move more function to shared library
Date: Thu,  1 Feb 2024 16:17:30 +0100
Message-ID: <20240201151747.7524-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201151747.7524-1-ansuelsmth@gmail.com>
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move more function to shared library in preparation for introduction of
new PHY Family qca807x that will make use of both functions from at803x
and qca808x as it's a transition PHY with some implementation of at803x
and some from the new qca808x.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/qcom/at803x.c       |  35 -----
 drivers/net/phy/qcom/qca808x.c      | 205 ----------------------------
 drivers/net/phy/qcom/qcom-phy-lib.c | 193 ++++++++++++++++++++++++++
 drivers/net/phy/qcom/qcom.h         |  51 +++++++
 4 files changed, 244 insertions(+), 240 deletions(-)

diff --git a/drivers/net/phy/qcom/at803x.c b/drivers/net/phy/qcom/at803x.c
index 36b70e88394e..3e3ee4c1d4bc 100644
--- a/drivers/net/phy/qcom/at803x.c
+++ b/drivers/net/phy/qcom/at803x.c
@@ -504,41 +504,6 @@ static void at803x_link_change_notify(struct phy_device *phydev)
 	}
 }
 
-static int at803x_read_status(struct phy_device *phydev)
-{
-	struct at803x_ss_mask ss_mask = { 0 };
-	int err, old_link = phydev->link;
-
-	/* Update the link, but return if there was an error */
-	err = genphy_update_link(phydev);
-	if (err)
-		return err;
-
-	/* why bother the PHY if nothing can have changed */
-	if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link)
-		return 0;
-
-	phydev->speed = SPEED_UNKNOWN;
-	phydev->duplex = DUPLEX_UNKNOWN;
-	phydev->pause = 0;
-	phydev->asym_pause = 0;
-
-	err = genphy_read_lpa(phydev);
-	if (err < 0)
-		return err;
-
-	ss_mask.speed_mask = AT803X_SS_SPEED_MASK;
-	ss_mask.speed_shift = __bf_shf(AT803X_SS_SPEED_MASK);
-	err = at803x_read_specific_status(phydev, ss_mask);
-	if (err < 0)
-		return err;
-
-	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete)
-		phy_resolve_aneg_pause(phydev);
-
-	return 0;
-}
-
 static int at803x_config_aneg(struct phy_device *phydev)
 {
 	struct at803x_priv *priv = phydev->priv;
diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
index 0f549027d899..8124bc2d5e5f 100644
--- a/drivers/net/phy/qcom/qca808x.c
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -2,7 +2,6 @@
 
 #include <linux/phy.h>
 #include <linux/module.h>
-#include <linux/ethtool_netlink.h>
 
 #include "qcom.h"
 
@@ -63,55 +62,6 @@
 #define QCA808X_DBG_AN_TEST			0xb
 #define QCA808X_HIBERNATION_EN			BIT(15)
 
-#define QCA808X_CDT_ENABLE_TEST			BIT(15)
-#define QCA808X_CDT_INTER_CHECK_DIS		BIT(13)
-#define QCA808X_CDT_STATUS			BIT(11)
-#define QCA808X_CDT_LENGTH_UNIT			BIT(10)
-
-#define QCA808X_MMD3_CDT_STATUS			0x8064
-#define QCA808X_MMD3_CDT_DIAG_PAIR_A		0x8065
-#define QCA808X_MMD3_CDT_DIAG_PAIR_B		0x8066
-#define QCA808X_MMD3_CDT_DIAG_PAIR_C		0x8067
-#define QCA808X_MMD3_CDT_DIAG_PAIR_D		0x8068
-#define QCA808X_CDT_DIAG_LENGTH_SAME_SHORT	GENMASK(15, 8)
-#define QCA808X_CDT_DIAG_LENGTH_CROSS_SHORT	GENMASK(7, 0)
-
-#define QCA808X_CDT_CODE_PAIR_A			GENMASK(15, 12)
-#define QCA808X_CDT_CODE_PAIR_B			GENMASK(11, 8)
-#define QCA808X_CDT_CODE_PAIR_C			GENMASK(7, 4)
-#define QCA808X_CDT_CODE_PAIR_D			GENMASK(3, 0)
-
-#define QCA808X_CDT_STATUS_STAT_TYPE		GENMASK(1, 0)
-#define QCA808X_CDT_STATUS_STAT_FAIL		FIELD_PREP_CONST(QCA808X_CDT_STATUS_STAT_TYPE, 0)
-#define QCA808X_CDT_STATUS_STAT_NORMAL		FIELD_PREP_CONST(QCA808X_CDT_STATUS_STAT_TYPE, 1)
-#define QCA808X_CDT_STATUS_STAT_SAME_OPEN	FIELD_PREP_CONST(QCA808X_CDT_STATUS_STAT_TYPE, 2)
-#define QCA808X_CDT_STATUS_STAT_SAME_SHORT	FIELD_PREP_CONST(QCA808X_CDT_STATUS_STAT_TYPE, 3)
-
-#define QCA808X_CDT_STATUS_STAT_MDI		GENMASK(3, 2)
-#define QCA808X_CDT_STATUS_STAT_MDI1		FIELD_PREP_CONST(QCA808X_CDT_STATUS_STAT_MDI, 1)
-#define QCA808X_CDT_STATUS_STAT_MDI2		FIELD_PREP_CONST(QCA808X_CDT_STATUS_STAT_MDI, 2)
-#define QCA808X_CDT_STATUS_STAT_MDI3		FIELD_PREP_CONST(QCA808X_CDT_STATUS_STAT_MDI, 3)
-
-/* NORMAL are MDI with type set to 0 */
-#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_NORMAL	QCA808X_CDT_STATUS_STAT_MDI1
-#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_OPEN		(QCA808X_CDT_STATUS_STAT_SAME_OPEN |\
-									 QCA808X_CDT_STATUS_STAT_MDI1)
-#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_SHORT	(QCA808X_CDT_STATUS_STAT_SAME_SHORT |\
-									 QCA808X_CDT_STATUS_STAT_MDI1)
-#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_NORMAL	QCA808X_CDT_STATUS_STAT_MDI2
-#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_OPEN		(QCA808X_CDT_STATUS_STAT_SAME_OPEN |\
-									 QCA808X_CDT_STATUS_STAT_MDI2)
-#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_SHORT	(QCA808X_CDT_STATUS_STAT_SAME_SHORT |\
-									 QCA808X_CDT_STATUS_STAT_MDI2)
-#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_NORMAL	QCA808X_CDT_STATUS_STAT_MDI3
-#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_OPEN		(QCA808X_CDT_STATUS_STAT_SAME_OPEN |\
-									 QCA808X_CDT_STATUS_STAT_MDI3)
-#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_SHORT	(QCA808X_CDT_STATUS_STAT_SAME_SHORT |\
-									 QCA808X_CDT_STATUS_STAT_MDI3)
-
-/* Added for reference of existence but should be handled by wait_for_completion already */
-#define QCA808X_CDT_STATUS_STAT_BUSY		(BIT(1) | BIT(3))
-
 #define QCA808X_MMD7_LED_GLOBAL			0x8073
 #define QCA808X_LED_BLINK_1			GENMASK(11, 6)
 #define QCA808X_LED_BLINK_2			GENMASK(5, 0)
@@ -396,86 +346,6 @@ static int qca808x_soft_reset(struct phy_device *phydev)
 	return ret;
 }
 
-static bool qca808x_cdt_fault_length_valid(int cdt_code)
-{
-	switch (cdt_code) {
-	case QCA808X_CDT_STATUS_STAT_SAME_SHORT:
-	case QCA808X_CDT_STATUS_STAT_SAME_OPEN:
-	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_NORMAL:
-	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_OPEN:
-	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_SHORT:
-	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_NORMAL:
-	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_OPEN:
-	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_SHORT:
-	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_NORMAL:
-	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_OPEN:
-	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_SHORT:
-		return true;
-	default:
-		return false;
-	}
-}
-
-static int qca808x_cable_test_result_trans(int cdt_code)
-{
-	switch (cdt_code) {
-	case QCA808X_CDT_STATUS_STAT_NORMAL:
-		return ETHTOOL_A_CABLE_RESULT_CODE_OK;
-	case QCA808X_CDT_STATUS_STAT_SAME_SHORT:
-		return ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT;
-	case QCA808X_CDT_STATUS_STAT_SAME_OPEN:
-		return ETHTOOL_A_CABLE_RESULT_CODE_OPEN;
-	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_NORMAL:
-	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_OPEN:
-	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_SHORT:
-	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_NORMAL:
-	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_OPEN:
-	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_SHORT:
-	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_NORMAL:
-	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_OPEN:
-	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_SHORT:
-		return ETHTOOL_A_CABLE_RESULT_CODE_CROSS_SHORT;
-	case QCA808X_CDT_STATUS_STAT_FAIL:
-	default:
-		return ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;
-	}
-}
-
-static int qca808x_cdt_fault_length(struct phy_device *phydev, int pair,
-				    int result)
-{
-	int val;
-	u32 cdt_length_reg = 0;
-
-	switch (pair) {
-	case ETHTOOL_A_CABLE_PAIR_A:
-		cdt_length_reg = QCA808X_MMD3_CDT_DIAG_PAIR_A;
-		break;
-	case ETHTOOL_A_CABLE_PAIR_B:
-		cdt_length_reg = QCA808X_MMD3_CDT_DIAG_PAIR_B;
-		break;
-	case ETHTOOL_A_CABLE_PAIR_C:
-		cdt_length_reg = QCA808X_MMD3_CDT_DIAG_PAIR_C;
-		break;
-	case ETHTOOL_A_CABLE_PAIR_D:
-		cdt_length_reg = QCA808X_MMD3_CDT_DIAG_PAIR_D;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	val = phy_read_mmd(phydev, MDIO_MMD_PCS, cdt_length_reg);
-	if (val < 0)
-		return val;
-
-	if (result == ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT)
-		val = FIELD_GET(QCA808X_CDT_DIAG_LENGTH_SAME_SHORT, val);
-	else
-		val = FIELD_GET(QCA808X_CDT_DIAG_LENGTH_CROSS_SHORT, val);
-
-	return at803x_cdt_fault_length(val);
-}
-
 static int qca808x_cable_test_start(struct phy_device *phydev)
 {
 	int ret;
@@ -517,81 +387,6 @@ static int qca808x_cable_test_start(struct phy_device *phydev)
 	return 0;
 }
 
-static int qca808x_cable_test_get_pair_status(struct phy_device *phydev, u8 pair,
-					      u16 status)
-{
-	int length, result;
-	u16 pair_code;
-
-	switch (pair) {
-	case ETHTOOL_A_CABLE_PAIR_A:
-		pair_code = FIELD_GET(QCA808X_CDT_CODE_PAIR_A, status);
-		break;
-	case ETHTOOL_A_CABLE_PAIR_B:
-		pair_code = FIELD_GET(QCA808X_CDT_CODE_PAIR_B, status);
-		break;
-	case ETHTOOL_A_CABLE_PAIR_C:
-		pair_code = FIELD_GET(QCA808X_CDT_CODE_PAIR_C, status);
-		break;
-	case ETHTOOL_A_CABLE_PAIR_D:
-		pair_code = FIELD_GET(QCA808X_CDT_CODE_PAIR_D, status);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	result = qca808x_cable_test_result_trans(pair_code);
-	ethnl_cable_test_result(phydev, pair, result);
-
-	if (qca808x_cdt_fault_length_valid(pair_code)) {
-		length = qca808x_cdt_fault_length(phydev, pair, result);
-		ethnl_cable_test_fault_length(phydev, pair, length);
-	}
-
-	return 0;
-}
-
-static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finished)
-{
-	int ret, val;
-
-	*finished = false;
-
-	val = QCA808X_CDT_ENABLE_TEST |
-	      QCA808X_CDT_LENGTH_UNIT;
-	ret = at803x_cdt_start(phydev, val);
-	if (ret)
-		return ret;
-
-	ret = at803x_cdt_wait_for_completion(phydev, QCA808X_CDT_ENABLE_TEST);
-	if (ret)
-		return ret;
-
-	val = phy_read_mmd(phydev, MDIO_MMD_PCS, QCA808X_MMD3_CDT_STATUS);
-	if (val < 0)
-		return val;
-
-	ret = qca808x_cable_test_get_pair_status(phydev, ETHTOOL_A_CABLE_PAIR_A, val);
-	if (ret)
-		return ret;
-
-	ret = qca808x_cable_test_get_pair_status(phydev, ETHTOOL_A_CABLE_PAIR_B, val);
-	if (ret)
-		return ret;
-
-	ret = qca808x_cable_test_get_pair_status(phydev, ETHTOOL_A_CABLE_PAIR_C, val);
-	if (ret)
-		return ret;
-
-	ret = qca808x_cable_test_get_pair_status(phydev, ETHTOOL_A_CABLE_PAIR_D, val);
-	if (ret)
-		return ret;
-
-	*finished = true;
-
-	return 0;
-}
-
 static int qca808x_get_features(struct phy_device *phydev)
 {
 	int ret;
diff --git a/drivers/net/phy/qcom/qcom-phy-lib.c b/drivers/net/phy/qcom/qcom-phy-lib.c
index e0295d4b4a51..786bfc39912c 100644
--- a/drivers/net/phy/qcom/qcom-phy-lib.c
+++ b/drivers/net/phy/qcom/qcom-phy-lib.c
@@ -5,6 +5,7 @@
 
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/ethtool_netlink.h>
 
 #include "qcom.h"
 
@@ -311,6 +312,42 @@ int at803x_prepare_config_aneg(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(at803x_prepare_config_aneg);
 
+int at803x_read_status(struct phy_device *phydev)
+{
+	struct at803x_ss_mask ss_mask = { 0 };
+	int err, old_link = phydev->link;
+
+	/* Update the link, but return if there was an error */
+	err = genphy_update_link(phydev);
+	if (err)
+		return err;
+
+	/* why bother the PHY if nothing can have changed */
+	if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link)
+		return 0;
+
+	phydev->speed = SPEED_UNKNOWN;
+	phydev->duplex = DUPLEX_UNKNOWN;
+	phydev->pause = 0;
+	phydev->asym_pause = 0;
+
+	err = genphy_read_lpa(phydev);
+	if (err < 0)
+		return err;
+
+	ss_mask.speed_mask = AT803X_SS_SPEED_MASK;
+	ss_mask.speed_shift = __bf_shf(AT803X_SS_SPEED_MASK);
+	err = at803x_read_specific_status(phydev, ss_mask);
+	if (err < 0)
+		return err;
+
+	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete)
+		phy_resolve_aneg_pause(phydev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(at803x_read_status);
+
 static int at803x_get_downshift(struct phy_device *phydev, u8 *d)
 {
 	int val;
@@ -427,3 +464,159 @@ int at803x_cdt_wait_for_completion(struct phy_device *phydev,
 	return ret < 0 ? ret : 0;
 }
 EXPORT_SYMBOL_GPL(at803x_cdt_wait_for_completion);
+
+static bool qca808x_cdt_fault_length_valid(int cdt_code)
+{
+	switch (cdt_code) {
+	case QCA808X_CDT_STATUS_STAT_SAME_SHORT:
+	case QCA808X_CDT_STATUS_STAT_SAME_OPEN:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_NORMAL:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_OPEN:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_SHORT:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_NORMAL:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_OPEN:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_SHORT:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_NORMAL:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_OPEN:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_SHORT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int qca808x_cable_test_result_trans(int cdt_code)
+{
+	switch (cdt_code) {
+	case QCA808X_CDT_STATUS_STAT_NORMAL:
+		return ETHTOOL_A_CABLE_RESULT_CODE_OK;
+	case QCA808X_CDT_STATUS_STAT_SAME_SHORT:
+		return ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT;
+	case QCA808X_CDT_STATUS_STAT_SAME_OPEN:
+		return ETHTOOL_A_CABLE_RESULT_CODE_OPEN;
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_NORMAL:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_OPEN:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_SHORT:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_NORMAL:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_OPEN:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_SHORT:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_NORMAL:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_OPEN:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_SHORT:
+		return ETHTOOL_A_CABLE_RESULT_CODE_CROSS_SHORT;
+	case QCA808X_CDT_STATUS_STAT_FAIL:
+	default:
+		return ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;
+	}
+}
+
+static int qca808x_cdt_fault_length(struct phy_device *phydev, int pair,
+				    int result)
+{
+	int val;
+	u32 cdt_length_reg = 0;
+
+	switch (pair) {
+	case ETHTOOL_A_CABLE_PAIR_A:
+		cdt_length_reg = QCA808X_MMD3_CDT_DIAG_PAIR_A;
+		break;
+	case ETHTOOL_A_CABLE_PAIR_B:
+		cdt_length_reg = QCA808X_MMD3_CDT_DIAG_PAIR_B;
+		break;
+	case ETHTOOL_A_CABLE_PAIR_C:
+		cdt_length_reg = QCA808X_MMD3_CDT_DIAG_PAIR_C;
+		break;
+	case ETHTOOL_A_CABLE_PAIR_D:
+		cdt_length_reg = QCA808X_MMD3_CDT_DIAG_PAIR_D;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	val = phy_read_mmd(phydev, MDIO_MMD_PCS, cdt_length_reg);
+	if (val < 0)
+		return val;
+
+	if (result == ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT)
+		val = FIELD_GET(QCA808X_CDT_DIAG_LENGTH_SAME_SHORT, val);
+	else
+		val = FIELD_GET(QCA808X_CDT_DIAG_LENGTH_CROSS_SHORT, val);
+
+	return at803x_cdt_fault_length(val);
+}
+
+static int qca808x_cable_test_get_pair_status(struct phy_device *phydev, u8 pair,
+					      u16 status)
+{
+	int length, result;
+	u16 pair_code;
+
+	switch (pair) {
+	case ETHTOOL_A_CABLE_PAIR_A:
+		pair_code = FIELD_GET(QCA808X_CDT_CODE_PAIR_A, status);
+		break;
+	case ETHTOOL_A_CABLE_PAIR_B:
+		pair_code = FIELD_GET(QCA808X_CDT_CODE_PAIR_B, status);
+		break;
+	case ETHTOOL_A_CABLE_PAIR_C:
+		pair_code = FIELD_GET(QCA808X_CDT_CODE_PAIR_C, status);
+		break;
+	case ETHTOOL_A_CABLE_PAIR_D:
+		pair_code = FIELD_GET(QCA808X_CDT_CODE_PAIR_D, status);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	result = qca808x_cable_test_result_trans(pair_code);
+	ethnl_cable_test_result(phydev, pair, result);
+
+	if (qca808x_cdt_fault_length_valid(pair_code)) {
+		length = qca808x_cdt_fault_length(phydev, pair, result);
+		ethnl_cable_test_fault_length(phydev, pair, length);
+	}
+
+	return 0;
+}
+
+int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finished)
+{
+	int ret, val;
+
+	*finished = false;
+
+	val = QCA808X_CDT_ENABLE_TEST |
+	      QCA808X_CDT_LENGTH_UNIT;
+	ret = at803x_cdt_start(phydev, val);
+	if (ret)
+		return ret;
+
+	ret = at803x_cdt_wait_for_completion(phydev, QCA808X_CDT_ENABLE_TEST);
+	if (ret)
+		return ret;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_PCS, QCA808X_MMD3_CDT_STATUS);
+	if (val < 0)
+		return val;
+
+	ret = qca808x_cable_test_get_pair_status(phydev, ETHTOOL_A_CABLE_PAIR_A, val);
+	if (ret)
+		return ret;
+
+	ret = qca808x_cable_test_get_pair_status(phydev, ETHTOOL_A_CABLE_PAIR_B, val);
+	if (ret)
+		return ret;
+
+	ret = qca808x_cable_test_get_pair_status(phydev, ETHTOOL_A_CABLE_PAIR_C, val);
+	if (ret)
+		return ret;
+
+	ret = qca808x_cable_test_get_pair_status(phydev, ETHTOOL_A_CABLE_PAIR_D, val);
+	if (ret)
+		return ret;
+
+	*finished = true;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qca808x_cable_test_get_status);
diff --git a/drivers/net/phy/qcom/qcom.h b/drivers/net/phy/qcom/qcom.h
index c127d8f50f0f..dc259bbf0678 100644
--- a/drivers/net/phy/qcom/qcom.h
+++ b/drivers/net/phy/qcom/qcom.h
@@ -54,6 +54,55 @@
 #define AT803X_CDT_STATUS_STAT_MASK		GENMASK(9, 8)
 #define AT803X_CDT_STATUS_DELTA_TIME_MASK	GENMASK(7, 0)
 
+#define QCA808X_CDT_ENABLE_TEST			BIT(15)
+#define QCA808X_CDT_INTER_CHECK_DIS		BIT(13)
+#define QCA808X_CDT_STATUS			BIT(11)
+#define QCA808X_CDT_LENGTH_UNIT			BIT(10)
+
+#define QCA808X_MMD3_CDT_STATUS			0x8064
+#define QCA808X_MMD3_CDT_DIAG_PAIR_A		0x8065
+#define QCA808X_MMD3_CDT_DIAG_PAIR_B		0x8066
+#define QCA808X_MMD3_CDT_DIAG_PAIR_C		0x8067
+#define QCA808X_MMD3_CDT_DIAG_PAIR_D		0x8068
+#define QCA808X_CDT_DIAG_LENGTH_SAME_SHORT	GENMASK(15, 8)
+#define QCA808X_CDT_DIAG_LENGTH_CROSS_SHORT	GENMASK(7, 0)
+
+#define QCA808X_CDT_CODE_PAIR_A			GENMASK(15, 12)
+#define QCA808X_CDT_CODE_PAIR_B			GENMASK(11, 8)
+#define QCA808X_CDT_CODE_PAIR_C			GENMASK(7, 4)
+#define QCA808X_CDT_CODE_PAIR_D			GENMASK(3, 0)
+
+#define QCA808X_CDT_STATUS_STAT_TYPE		GENMASK(1, 0)
+#define QCA808X_CDT_STATUS_STAT_FAIL		FIELD_PREP_CONST(QCA808X_CDT_STATUS_STAT_TYPE, 0)
+#define QCA808X_CDT_STATUS_STAT_NORMAL		FIELD_PREP_CONST(QCA808X_CDT_STATUS_STAT_TYPE, 1)
+#define QCA808X_CDT_STATUS_STAT_SAME_OPEN	FIELD_PREP_CONST(QCA808X_CDT_STATUS_STAT_TYPE, 2)
+#define QCA808X_CDT_STATUS_STAT_SAME_SHORT	FIELD_PREP_CONST(QCA808X_CDT_STATUS_STAT_TYPE, 3)
+
+#define QCA808X_CDT_STATUS_STAT_MDI		GENMASK(3, 2)
+#define QCA808X_CDT_STATUS_STAT_MDI1		FIELD_PREP_CONST(QCA808X_CDT_STATUS_STAT_MDI, 1)
+#define QCA808X_CDT_STATUS_STAT_MDI2		FIELD_PREP_CONST(QCA808X_CDT_STATUS_STAT_MDI, 2)
+#define QCA808X_CDT_STATUS_STAT_MDI3		FIELD_PREP_CONST(QCA808X_CDT_STATUS_STAT_MDI, 3)
+
+/* NORMAL are MDI with type set to 0 */
+#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_NORMAL	QCA808X_CDT_STATUS_STAT_MDI1
+#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_OPEN		(QCA808X_CDT_STATUS_STAT_SAME_OPEN |\
+									 QCA808X_CDT_STATUS_STAT_MDI1)
+#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_SHORT	(QCA808X_CDT_STATUS_STAT_SAME_SHORT |\
+									 QCA808X_CDT_STATUS_STAT_MDI1)
+#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_NORMAL	QCA808X_CDT_STATUS_STAT_MDI2
+#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_OPEN		(QCA808X_CDT_STATUS_STAT_SAME_OPEN |\
+									 QCA808X_CDT_STATUS_STAT_MDI2)
+#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_SHORT	(QCA808X_CDT_STATUS_STAT_SAME_SHORT |\
+									 QCA808X_CDT_STATUS_STAT_MDI2)
+#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_NORMAL	QCA808X_CDT_STATUS_STAT_MDI3
+#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_OPEN		(QCA808X_CDT_STATUS_STAT_SAME_OPEN |\
+									 QCA808X_CDT_STATUS_STAT_MDI3)
+#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_SHORT	(QCA808X_CDT_STATUS_STAT_SAME_SHORT |\
+									 QCA808X_CDT_STATUS_STAT_MDI3)
+
+/* Added for reference of existence but should be handled by wait_for_completion already */
+#define QCA808X_CDT_STATUS_STAT_BUSY		(BIT(1) | BIT(3))
+
 #define AT803X_LOC_MAC_ADDR_0_15_OFFSET		0x804C
 #define AT803X_LOC_MAC_ADDR_16_31_OFFSET	0x804B
 #define AT803X_LOC_MAC_ADDR_32_47_OFFSET	0x804A
@@ -110,6 +159,7 @@ int at803x_read_specific_status(struct phy_device *phydev,
 				struct at803x_ss_mask ss_mask);
 int at803x_config_mdix(struct phy_device *phydev, u8 ctrl);
 int at803x_prepare_config_aneg(struct phy_device *phydev);
+int at803x_read_status(struct phy_device *phydev);
 int at803x_get_tunable(struct phy_device *phydev,
 		       struct ethtool_tunable *tuna, void *data);
 int at803x_set_tunable(struct phy_device *phydev,
@@ -118,3 +168,4 @@ int at803x_cdt_fault_length(int dt);
 int at803x_cdt_start(struct phy_device *phydev, u32 cdt_start);
 int at803x_cdt_wait_for_completion(struct phy_device *phydev,
 				   u32 cdt_en);
+int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finished);
-- 
2.43.0


