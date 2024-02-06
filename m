Return-Path: <linux-kernel+bounces-55386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BE684BC03
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CAFA1C23A92
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40AE1426D;
	Tue,  6 Feb 2024 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnhBsyPA"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57BABA3F;
	Tue,  6 Feb 2024 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240784; cv=none; b=Vjqak4N3gUj4ifwKcwcZ/GyjWscHOhLGaLZhPthflrwVWgvFnGKECHzGkDDCHVGWTEat11nDP6OjLgVPMtkviyxMyOAq5yipBrox9wb6QLeYiagW44LFpzmguInYtzDSKBBvd4UUF9+exTNeYUaocP+fiIovSwn+h8/JecZQP/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240784; c=relaxed/simple;
	bh=oPxMEZWAyg2qRL0yS2P7u9xEpG6GttLt28qXdFKsViI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDbd1oJqhpXRq0fFT+AFUPnsEv2fJUBBmfovdJdwaPLeR4/+G55gFDJQSRQa7/ckfNrpfIbpFrDrBj7t5eeEdHx3zJ4xCPru9ROG7gXszM/TKF449jw7w57PHRR0K+CVBvLywy42ClMNbeh/s10KhTQ9vApDhF+Ix8hj608aVag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnhBsyPA; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3394ca0c874so4181354f8f.2;
        Tue, 06 Feb 2024 09:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707240780; x=1707845580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kbh8rqeYY03RgbOQ94/D59JmMRtePccIdeL610jMQyY=;
        b=XnhBsyPAyGyNeYp2vwMizQ2ODj9/MA3TunQmdb3rkSj5BEz/JhfrD9rHU0Fq8mv0cd
         ZpncUz2b8unTXIt+/Zo/F+/B+iJUiYX5o38FDuvXhCarBplGd/Ov5vPY7d9GQJvpueVc
         42caA1iklXD8EsQxGXERkmoK7lwjMSt+29cwnw7jN0wnmsZNz2ddNt/0fQgvnCNoE7vX
         tL53P0VA5dEw8jNsoDSXU74n411mXp7HkilL1Y6WbRIA1kYW6ccro34j8bmismKe+bR0
         QSUyndnwdAVeIlMwnNa9VT5fMsgIUL3gfUplL9O8Mjwc0f54zhySfNrlAmL/NclyxfyL
         GhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240780; x=1707845580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kbh8rqeYY03RgbOQ94/D59JmMRtePccIdeL610jMQyY=;
        b=aX/XBhrCdJD9uqt6ffS0kgY8vZs2P7VbzFB4Tr+j2HtpDBZb0v3K9zgglaGvNTOJkZ
         7Gx0N9Ndd7ERMuvOCI1XccBQudtMiVfQHCS7eXonHpho4AZ3whRR8jHfMlhjkZquVVsX
         wmA5U+Lv0BFJ6fWvIYyTygKP9bmh7L1EJrRMM5qL9Bygy52blnb5Z73x0mwgMZq+ci65
         WWRzEuFrZHxVlHBgOEkyGUuovxU2jELeyTpcyZPDz6pdsVTAm0jdCsJ3bIJ6e60Gll+l
         FpX8VEqP5jFyD3AGhZHEpR9vTjVI/ESMt4ejriV1+lEvvVvZrIvorLgg7yHaTszZ7nKc
         I1Uw==
X-Gm-Message-State: AOJu0YzyychnIK/ot9654FG6Za28vSFKgcoU/Ma6ACyNfU2niDa++BKM
	BnzV5aqrRYOAYmoPJmLftl3zFzYM+890RGMahKLx5flJzzQiSXAk
X-Google-Smtp-Source: AGHT+IGpYJB3EQifqrHTfgdzstXOlJrZifGq7DgQhrlDnUe4q/QUz/2cqfCSZky+eruSWRf4Ermt6g==
X-Received: by 2002:adf:ea89:0:b0:33b:1e84:9684 with SMTP id s9-20020adfea89000000b0033b1e849684mr1560918wrm.70.1707240779922;
        Tue, 06 Feb 2024 09:32:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVEGblCQWkfcbhgR/sx5JvYJbCwI4SdioML7hbLp9WuHnzW5RJsDeOz1ZEg2ekoM36/MJWvp0AafMT37w6Bec/RetsfUI66J2Z/zoNjUsYilBNc0bceRS2Budu/E0rrsH9ppaYSA/adgmpwgYxzMJ9rVr7IzJW8d+RGbClGrd/Dd/QfZ6M64++6rWhiuohDa/d6VfuTxyQxVyEvjSKXGwKM4VW/vRMTHmInjsd+iPi0tiX5f7yux7WQvtdQPciveRqy/jL1Y8Ufv6+LPdfarLAH4Q3BXqmcp1ddt8jEzQ7UFRB+8AZvrO0iXvQ6o1dfmaOVzZw43/WX4jGvF5cP611Krg6+7L9L2v6f2nvP4qCrOMaYo/LyPjfuubW5aQJwYTBUHIdDc8oxYl9jG3oNkon5SzenP2IiDxgj0gTYcBD2gN01W1ASDTCe1MnFVj/XJKQLkeXtMgxTGY0UNrL6wd+ICYjDnsqQtEeEDEl4CdXOIhRg88wH/EyUQ7Ux2+JvNqS+PoIritC4Xc+tobtLDFJoi16KwvRYBGqT2TNiv8hsqJ3BRJ2dAHDkO1iLGr27fdkIc5vqVzxCI9YNTpqmZD15oCOng5pYj9OkdyDqGwUUYKHQWscm/QRUYGUObl/vtbHymbPG+Ovb2yyjtBYAfiJiteuMJ3oT8Szx//Zm/00y2yFrxBvB5w==
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id l14-20020a05600c4f0e00b0040fc56712e8sm2621215wmq.17.2024.02.06.09.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:32:58 -0800 (PST)
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
Subject: [net-next PATCH v7 04/10] net: phy: qcom: move more function to shared library
Date: Tue,  6 Feb 2024 18:31:07 +0100
Message-ID: <20240206173115.7654-5-ansuelsmth@gmail.com>
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
index d88e04278fc4..8377325f157e 100644
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
@@ -406,86 +356,6 @@ static int qca808x_soft_reset(struct phy_device *phydev)
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
@@ -527,81 +397,6 @@ static int qca808x_cable_test_start(struct phy_device *phydev)
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


