Return-Path: <linux-kernel+bounces-53042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BF1849FE0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BBF6B24C45
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04484481C0;
	Mon,  5 Feb 2024 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAELeNmG"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA24E3EA86;
	Mon,  5 Feb 2024 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151752; cv=none; b=kZdFUcOw/6Hu5Alffp5dlq8+cfJ3zTkzhuL+U98kfSijnS4lp9F+BC1KeMCS4jXK5XSfXBmWDu9Wo9rDD7WjzC3DcTCh8ERy8N9pbKhuYxh5UvkoPRQ4iyl2Vw82aPZ2fNFwGiMnZzrn9F6enQlVgUAlXdrmzvfeaLeapgfS3p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151752; c=relaxed/simple;
	bh=bdGHFT01GXpmJAQStvsRsVbmYpKcKYK9cB/9/B8I5YA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+ha+BHjU2cLAhK918ggAcy5cZsjy2eN0G+XLP2tCHDJea0dDS0vnAAht8uDUDEqccdfgtpdowV3pa/ym4RYHERdE5o8fKDSGGiRvXJx53Jld+JwU6FVyc3mCB7VwetPCKXK0ZEI5Qr/9MeL4/Jx6olrgq8wLn9+D8xM1JFRDjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAELeNmG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fdf17fa89so2086365e9.0;
        Mon, 05 Feb 2024 08:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707151748; x=1707756548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QAcRaCEqZ94Pf+SfvUe08GyZuxBTp3ojtTnlOyieSA=;
        b=bAELeNmGWi9DVENr742f+WiEtC9kr5U3m0GX28FAthCEGJB6uNOOEL/9pn+/Auv7r/
         bTq8QSDjCpYaSvf4b4tjhIyLeuW9tfC610fUIP2l1A/9SkjYFQecssBZsKsdkTkOKGx2
         cM2+0T2bCQKaMtqV3Iu5kUcwtct9Iemo66E8CxnJIKevPCBtfyEbBkQCJIafsZCyyMw2
         NVWJYa+GDC+dgnDpSXlPyKtfcyBE+A7oLxvQ/u4lwvzQpOo8xV+a7C3Wuu5vDOsNX0AO
         cXtN6+d7OppJBh/e9E80FKaBsAF//WTj6pR/UREiasK4UnsAFIYHHj5EuYTURWjMr06S
         Qgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707151748; x=1707756548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QAcRaCEqZ94Pf+SfvUe08GyZuxBTp3ojtTnlOyieSA=;
        b=hS/vlHJe4G86mGIonWVTkMjsMhU6945/KWCpSCHIihYeAgCDeQYRww6McXbprR2Syv
         nBHJryiqD5f2IA/trGct1JUY4zSwuBRIf5EbazVVL3SrCx8s9ECjHsolSBE9uVCGNVnp
         fKX1bK/u/epKtN+KyVaiJS3S227j8FxuLNUZTf5QChO/3W2JOj3dF5ZvM0ut7Ihdjy5z
         l9W/82i1QpAV1cTmG74UEq2EmpzK5Ruw4cdIJ80P6MHqH0TWcDFj+lYXB9xlwK/WGvw4
         42M7+QzrZ1gP38u/M7Uk1WaLN8bGyvfAkp2oENmg31mywPsX/1w5oRt4j2CiM30RVL+z
         tUaw==
X-Gm-Message-State: AOJu0YywZnh0m2Kj3YaiGW5+kj6n8iC72sQ0nHPXQ20K0OuLpOQHImON
	HqHywBIrdbGvNDo30UEtmIvKb+WKGcm5D4z6ugOkBB1cZKRSbpXd
X-Google-Smtp-Source: AGHT+IG2gULhDU3nCYWCLxtI6WfSusENKORohcqM7kphczKlU5s+0oO1NBbQD2PobJc5TofeOj7Piw==
X-Received: by 2002:a05:600c:4fc6:b0:40f:bbdb:4f2b with SMTP id o6-20020a05600c4fc600b0040fbbdb4f2bmr4482359wmq.19.1707151747809;
        Mon, 05 Feb 2024 08:49:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUr6sP26m9lWQLj+mVy2hEI8IXJexNrk3ELknMBHdf4epazno6fCfxP06o7D6IRRvV5Vu2kSvoGY4NYeMrX6MQwpxEFTtd6AmAdRY557/NK3UA72pTB0ltXAUdiyuXZ5/nAsCd3/2hvMj8yyT5qOVQAUNqCGgjKxkGleyl4mmgPsXMaboG/awac0rRxfGdWRGdrQAhmVXx3rqQE09sswXZbLlvbL8xKFNSM26VI1p5nsCCCtCGgcvPKEHbvuIbBObLRmp++aYLpLt4quHfbeWQB8ura2E40JsiIJyebzF7TQbJGLWVlce4r6OHHtkdmsKTJDG/cPWbD1Zbfbr3WfgS+d/Aj9Vun8d5sKSync+P0OVEkBYBI6xLlft8PBWx1L4KFvQTEJHvhGt+qBoIuGENx7vBJOEiyU8VG+A2ODchwBrrQ9Z0rCp+HNfj8/+H6AKAFTNZ8pXALegZW0ys4QTnUQTsx+KRevt2DWfvkzB1O1Zu/K2XBIcNtYXL+Kd5MqPDHEIkHj6mDhpaPurQArg3zymTrED3NujiRiRmFVvF8fHQPCd5BLmbZ6XbKLBR+2ZMWX5e64V8xqd8OOXnmkZwkGAdh676oQAkgOg09eUAjTeHivmtmTZ2IdXyD95LtzhM4bV4vjxXmwNlenelNcncjVliUccPQcV/4BdesA/PF9KdF2zHBdA==
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id k2-20020a05600c1c8200b0040fafd84095sm9140567wms.41.2024.02.05.08.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:49:07 -0800 (PST)
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
Subject: [net-next PATCH v6 04/10] net: phy: qcom: move more function to shared library
Date: Mon,  5 Feb 2024 17:48:36 +0100
Message-ID: <20240205164851.1351-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205164851.1351-1-ansuelsmth@gmail.com>
References: <20240205164851.1351-1-ansuelsmth@gmail.com>
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


