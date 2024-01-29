Return-Path: <linux-kernel+bounces-42877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2F784080E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E2A28DEFB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CB967A08;
	Mon, 29 Jan 2024 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvqblSE0"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6EB67A0B;
	Mon, 29 Jan 2024 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537821; cv=none; b=DkEezd7nzQaqRauSb09utaf1b4JKWsWQfFtRZKz8xGXem7VbrbGurEKzZbnnjT/hJlBr/L8BltOrnx3NqDIYZ6LwCdtA+pTFNO2pxx2vYpc46GFUmS4R8OBfIkYZ9vDlWnst0/YN4pQ8vzaPGyl70+yxCLBbVAfieHsyMkcFXf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537821; c=relaxed/simple;
	bh=7c0PlbkqHCnoAjeTzBgM65UK6W/sscPozpAD3DvYX/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=absyvzwTJmi7OtWkkiNbDcPfbDQjIMBbhEATAnZNwNIvgDoDT0qK+5OD65laqXgyfEmlKNBbcDzdGU2d09tSeUK4OMJ/w7lCH+FPr659y0e1363uAjQXjH2eBJI1zi0Jj3AMRddCEY2vdrL82mw6HGen7JascRn6aTyaXEpUNT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvqblSE0; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a35d0764076so92497666b.1;
        Mon, 29 Jan 2024 06:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706537816; x=1707142616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jL18hEYjPIXOEbwD+OT/Sjp1R+Ed0i0BC5RAVIfUccY=;
        b=FvqblSE059F/Tf29DZaWi0ZSgagFNKtk2v9FcVbN1Nsc2mx8VlFmREriZAvCOaknRr
         YDVv4t37G/13eeLaB5J1aHkS3lNgFLJJGLw0S13NQeoUlRIaJEY0Ejm5wD6FYPPtSwim
         wYemDeO8HphGWDQ9wIAK7jZAkOdNE7qRWa0+6Kv22KnhuzCxWLIR6179Y+7sikxnNpzb
         Cq3htq4vbWfhAHnX5NXYbWPIpDa+atGIM6Ds2aDAzcDb+foES95W+OO3xLZzImOogW2D
         FKhl0j5cpgKNcc0AwNteDpeVSs2YjzKDioqNIcyQl9qUFJoJR0SIoTvN7kxQnxdR+FTh
         33xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706537816; x=1707142616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jL18hEYjPIXOEbwD+OT/Sjp1R+Ed0i0BC5RAVIfUccY=;
        b=XebGbf5tocNUGOk1hLJH2Iuohkm63/ToJiPFuzHCLz74RcWTfLDQtAppKJpJ1eEBBg
         qI/nv0qc9mzHxSGJ4+tsCveaBFKEkHelWE9X4TEgHWZtJjxqLwAUvslIS5ttr/MhWm/r
         7cFZ6cXq+WdMSQDQ5ui72QCzOxACxiOFoMlauoU/8wZ+/jV8AdFChe/sCNS00kfUh4ik
         etVqq03gOGyQ+etOvE5EX9pbA7WyeCOCzf6aLNoU9p7iwvtuwFC1GAq0sgjMUTQei0TF
         2rW7wKdvvM/tmfNOFkyhqWeN3Qxct7jzk04P0sgR73j6+QJ16466362z6A5SDN/aDRa6
         SaSw==
X-Gm-Message-State: AOJu0Yzo9YzzQGN0462cZ4spQXYu577vnpkKEGJWiLXtXNBw8SehAurv
	0cwdUprvC/lEmGXoI1PvQy2bgOuo8odPDYG3y7rQvJ8R41EJSJZO
X-Google-Smtp-Source: AGHT+IG4TJLbORU3+r2Mqi6QYSXdVTav4Tno+jVbEHyMllpUH9Y/wO+qNbiRxHqBGPnKpgdQHouaMw==
X-Received: by 2002:a17:906:4c56:b0:a35:9414:f46f with SMTP id d22-20020a1709064c5600b00a359414f46fmr2683052ejw.13.1706537816250;
        Mon, 29 Jan 2024 06:16:56 -0800 (PST)
Received: from localhost.localdomain ([78.208.142.203])
        by smtp.googlemail.com with ESMTPSA id cu12-20020a170906ba8c00b00a27a32e6502sm3919470ejd.117.2024.01.29.06.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:16:55 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v4 4/5] net: phy: qcom: move additional functions to shared library
Date: Mon, 29 Jan 2024 15:15:22 +0100
Message-ID: <20240129141600.2592-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129141600.2592-1-ansuelsmth@gmail.com>
References: <20240129141600.2592-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move additional functions to shared library in preparation for qca808x
PHY Family to be detached from at803x driver.

Only the shared defines are moved to the shared qcom.h header.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/qcom/at803x.c       | 426 +---------------------------
 drivers/net/phy/qcom/qcom-phy-lib.c | 376 ++++++++++++++++++++++++
 drivers/net/phy/qcom/qcom.h         |  86 ++++++
 3 files changed, 463 insertions(+), 425 deletions(-)

diff --git a/drivers/net/phy/qcom/at803x.c b/drivers/net/phy/qcom/at803x.c
index 638babc50df1..6a753498b994 100644
--- a/drivers/net/phy/qcom/at803x.c
+++ b/drivers/net/phy/qcom/at803x.c
@@ -24,65 +24,11 @@
 
 #include "qcom.h"
 
-#define AT803X_SPECIFIC_FUNCTION_CONTROL	0x10
-#define AT803X_SFC_ASSERT_CRS			BIT(11)
-#define AT803X_SFC_FORCE_LINK			BIT(10)
-#define AT803X_SFC_MDI_CROSSOVER_MODE_M		GENMASK(6, 5)
-#define AT803X_SFC_AUTOMATIC_CROSSOVER		0x3
-#define AT803X_SFC_MANUAL_MDIX			0x1
-#define AT803X_SFC_MANUAL_MDI			0x0
-#define AT803X_SFC_SQE_TEST			BIT(2)
-#define AT803X_SFC_POLARITY_REVERSAL		BIT(1)
-#define AT803X_SFC_DISABLE_JABBER		BIT(0)
-
-#define AT803X_SPECIFIC_STATUS			0x11
-#define AT803X_SS_SPEED_MASK			GENMASK(15, 14)
-#define AT803X_SS_SPEED_1000			2
-#define AT803X_SS_SPEED_100			1
-#define AT803X_SS_SPEED_10			0
-#define AT803X_SS_DUPLEX			BIT(13)
-#define AT803X_SS_SPEED_DUPLEX_RESOLVED		BIT(11)
-#define AT803X_SS_MDIX				BIT(6)
-
-#define QCA808X_SS_SPEED_MASK			GENMASK(9, 7)
-#define QCA808X_SS_SPEED_2500			4
-
-#define AT803X_INTR_ENABLE			0x12
-#define AT803X_INTR_ENABLE_AUTONEG_ERR		BIT(15)
-#define AT803X_INTR_ENABLE_SPEED_CHANGED	BIT(14)
-#define AT803X_INTR_ENABLE_DUPLEX_CHANGED	BIT(13)
-#define AT803X_INTR_ENABLE_PAGE_RECEIVED	BIT(12)
-#define AT803X_INTR_ENABLE_LINK_FAIL		BIT(11)
-#define AT803X_INTR_ENABLE_LINK_SUCCESS		BIT(10)
-#define AT803X_INTR_ENABLE_LINK_FAIL_BX		BIT(8)
-#define AT803X_INTR_ENABLE_LINK_SUCCESS_BX	BIT(7)
-#define AT803X_INTR_ENABLE_WIRESPEED_DOWNGRADE	BIT(5)
-#define AT803X_INTR_ENABLE_POLARITY_CHANGED	BIT(1)
-#define AT803X_INTR_ENABLE_WOL			BIT(0)
-
-#define AT803X_INTR_STATUS			0x13
-
-#define AT803X_SMART_SPEED			0x14
-#define AT803X_SMART_SPEED_ENABLE		BIT(5)
-#define AT803X_SMART_SPEED_RETRY_LIMIT_MASK	GENMASK(4, 2)
-#define AT803X_SMART_SPEED_BYPASS_TIMER		BIT(1)
-#define AT803X_CDT				0x16
-#define AT803X_CDT_MDI_PAIR_MASK		GENMASK(9, 8)
-#define AT803X_CDT_ENABLE_TEST			BIT(0)
-#define AT803X_CDT_STATUS			0x1c
-#define AT803X_CDT_STATUS_STAT_NORMAL		0
-#define AT803X_CDT_STATUS_STAT_SHORT		1
-#define AT803X_CDT_STATUS_STAT_OPEN		2
-#define AT803X_CDT_STATUS_STAT_FAIL		3
-#define AT803X_CDT_STATUS_STAT_MASK		GENMASK(9, 8)
-#define AT803X_CDT_STATUS_DELTA_TIME_MASK	GENMASK(7, 0)
 #define AT803X_LED_CONTROL			0x18
 
 #define AT803X_PHY_MMD3_WOL_CTRL		0x8012
 #define AT803X_WOL_EN				BIT(5)
-#define AT803X_LOC_MAC_ADDR_0_15_OFFSET		0x804C
-#define AT803X_LOC_MAC_ADDR_16_31_OFFSET	0x804B
-#define AT803X_LOC_MAC_ADDR_32_47_OFFSET	0x804A
+
 #define AT803X_REG_CHIP_CONFIG			0x1f
 #define AT803X_BT_BX_REG_SEL			0x8000
 
@@ -138,10 +84,6 @@
 #define AT803X_CLK_OUT_STRENGTH_HALF		1
 #define AT803X_CLK_OUT_STRENGTH_QUARTER		2
 
-#define AT803X_DEFAULT_DOWNSHIFT		5
-#define AT803X_MIN_DOWNSHIFT			2
-#define AT803X_MAX_DOWNSHIFT			9
-
 #define AT803X_MMD3_SMARTEEE_CTL1		0x805b
 #define AT803X_MMD3_SMARTEEE_CTL2		0x805c
 #define AT803X_MMD3_SMARTEEE_CTL3		0x805d
@@ -366,11 +308,6 @@ MODULE_DESCRIPTION("Qualcomm Atheros AR803x and QCA808X PHY driver");
 MODULE_AUTHOR("Matus Ujhelyi");
 MODULE_LICENSE("GPL");
 
-struct at803x_ss_mask {
-	u16 speed_mask;
-	u8 speed_shift;
-};
-
 struct at803x_priv {
 	int flags;
 	u16 clk_25m_reg;
@@ -470,80 +407,6 @@ static void at803x_context_restore(struct phy_device *phydev,
 	phy_write(phydev, AT803X_LED_CONTROL, context->led_control);
 }
 
-static int at803x_set_wol(struct phy_device *phydev,
-			  struct ethtool_wolinfo *wol)
-{
-	int ret, irq_enabled;
-
-	if (wol->wolopts & WAKE_MAGIC) {
-		struct net_device *ndev = phydev->attached_dev;
-		const u8 *mac;
-		unsigned int i;
-		static const unsigned int offsets[] = {
-			AT803X_LOC_MAC_ADDR_32_47_OFFSET,
-			AT803X_LOC_MAC_ADDR_16_31_OFFSET,
-			AT803X_LOC_MAC_ADDR_0_15_OFFSET,
-		};
-
-		if (!ndev)
-			return -ENODEV;
-
-		mac = (const u8 *)ndev->dev_addr;
-
-		if (!is_valid_ether_addr(mac))
-			return -EINVAL;
-
-		for (i = 0; i < 3; i++)
-			phy_write_mmd(phydev, MDIO_MMD_PCS, offsets[i],
-				      mac[(i * 2) + 1] | (mac[(i * 2)] << 8));
-
-		/* Enable WOL interrupt */
-		ret = phy_modify(phydev, AT803X_INTR_ENABLE, 0, AT803X_INTR_ENABLE_WOL);
-		if (ret)
-			return ret;
-	} else {
-		/* Disable WOL interrupt */
-		ret = phy_modify(phydev, AT803X_INTR_ENABLE, AT803X_INTR_ENABLE_WOL, 0);
-		if (ret)
-			return ret;
-	}
-
-	/* Clear WOL status */
-	ret = phy_read(phydev, AT803X_INTR_STATUS);
-	if (ret < 0)
-		return ret;
-
-	/* Check if there are other interrupts except for WOL triggered when PHY is
-	 * in interrupt mode, only the interrupts enabled by AT803X_INTR_ENABLE can
-	 * be passed up to the interrupt PIN.
-	 */
-	irq_enabled = phy_read(phydev, AT803X_INTR_ENABLE);
-	if (irq_enabled < 0)
-		return irq_enabled;
-
-	irq_enabled &= ~AT803X_INTR_ENABLE_WOL;
-	if (ret & irq_enabled && !phy_polling_mode(phydev))
-		phy_trigger_machine(phydev);
-
-	return 0;
-}
-
-static void at803x_get_wol(struct phy_device *phydev,
-			   struct ethtool_wolinfo *wol)
-{
-	int value;
-
-	wol->supported = WAKE_MAGIC;
-	wol->wolopts = 0;
-
-	value = phy_read(phydev, AT803X_INTR_ENABLE);
-	if (value < 0)
-		return;
-
-	if (value & AT803X_INTR_ENABLE_WOL)
-		wol->wolopts |= WAKE_MAGIC;
-}
-
 static int at803x_suspend(struct phy_device *phydev)
 {
 	int value;
@@ -816,73 +679,6 @@ static int at803x_config_init(struct phy_device *phydev)
 	return phy_modify(phydev, MII_ADVERTISE, MDIO_AN_CTRL1_XNP, 0);
 }
 
-static int at803x_ack_interrupt(struct phy_device *phydev)
-{
-	int err;
-
-	err = phy_read(phydev, AT803X_INTR_STATUS);
-
-	return (err < 0) ? err : 0;
-}
-
-static int at803x_config_intr(struct phy_device *phydev)
-{
-	int err;
-	int value;
-
-	value = phy_read(phydev, AT803X_INTR_ENABLE);
-
-	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
-		/* Clear any pending interrupts */
-		err = at803x_ack_interrupt(phydev);
-		if (err)
-			return err;
-
-		value |= AT803X_INTR_ENABLE_AUTONEG_ERR;
-		value |= AT803X_INTR_ENABLE_SPEED_CHANGED;
-		value |= AT803X_INTR_ENABLE_DUPLEX_CHANGED;
-		value |= AT803X_INTR_ENABLE_LINK_FAIL;
-		value |= AT803X_INTR_ENABLE_LINK_SUCCESS;
-
-		err = phy_write(phydev, AT803X_INTR_ENABLE, value);
-	} else {
-		err = phy_write(phydev, AT803X_INTR_ENABLE, 0);
-		if (err)
-			return err;
-
-		/* Clear any pending interrupts */
-		err = at803x_ack_interrupt(phydev);
-	}
-
-	return err;
-}
-
-static irqreturn_t at803x_handle_interrupt(struct phy_device *phydev)
-{
-	int irq_status, int_enabled;
-
-	irq_status = phy_read(phydev, AT803X_INTR_STATUS);
-	if (irq_status < 0) {
-		phy_error(phydev);
-		return IRQ_NONE;
-	}
-
-	/* Read the current enabled interrupts */
-	int_enabled = phy_read(phydev, AT803X_INTR_ENABLE);
-	if (int_enabled < 0) {
-		phy_error(phydev);
-		return IRQ_NONE;
-	}
-
-	/* See if this was one of our enabled interrupts */
-	if (!(irq_status & int_enabled))
-		return IRQ_NONE;
-
-	phy_trigger_machine(phydev);
-
-	return IRQ_HANDLED;
-}
-
 static void at803x_link_change_notify(struct phy_device *phydev)
 {
 	/*
@@ -908,69 +704,6 @@ static void at803x_link_change_notify(struct phy_device *phydev)
 	}
 }
 
-static int at803x_read_specific_status(struct phy_device *phydev,
-				       struct at803x_ss_mask ss_mask)
-{
-	int ss;
-
-	/* Read the AT8035 PHY-Specific Status register, which indicates the
-	 * speed and duplex that the PHY is actually using, irrespective of
-	 * whether we are in autoneg mode or not.
-	 */
-	ss = phy_read(phydev, AT803X_SPECIFIC_STATUS);
-	if (ss < 0)
-		return ss;
-
-	if (ss & AT803X_SS_SPEED_DUPLEX_RESOLVED) {
-		int sfc, speed;
-
-		sfc = phy_read(phydev, AT803X_SPECIFIC_FUNCTION_CONTROL);
-		if (sfc < 0)
-			return sfc;
-
-		speed = ss & ss_mask.speed_mask;
-		speed >>= ss_mask.speed_shift;
-
-		switch (speed) {
-		case AT803X_SS_SPEED_10:
-			phydev->speed = SPEED_10;
-			break;
-		case AT803X_SS_SPEED_100:
-			phydev->speed = SPEED_100;
-			break;
-		case AT803X_SS_SPEED_1000:
-			phydev->speed = SPEED_1000;
-			break;
-		case QCA808X_SS_SPEED_2500:
-			phydev->speed = SPEED_2500;
-			break;
-		}
-		if (ss & AT803X_SS_DUPLEX)
-			phydev->duplex = DUPLEX_FULL;
-		else
-			phydev->duplex = DUPLEX_HALF;
-
-		if (ss & AT803X_SS_MDIX)
-			phydev->mdix = ETH_TP_MDI_X;
-		else
-			phydev->mdix = ETH_TP_MDI;
-
-		switch (FIELD_GET(AT803X_SFC_MDI_CROSSOVER_MODE_M, sfc)) {
-		case AT803X_SFC_MANUAL_MDI:
-			phydev->mdix_ctrl = ETH_TP_MDI;
-			break;
-		case AT803X_SFC_MANUAL_MDIX:
-			phydev->mdix_ctrl = ETH_TP_MDI_X;
-			break;
-		case AT803X_SFC_AUTOMATIC_CROSSOVER:
-			phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
-			break;
-		}
-	}
-
-	return 0;
-}
-
 static int at803x_read_status(struct phy_device *phydev)
 {
 	struct at803x_ss_mask ss_mask = { 0 };
@@ -1006,50 +739,6 @@ static int at803x_read_status(struct phy_device *phydev)
 	return 0;
 }
 
-static int at803x_config_mdix(struct phy_device *phydev, u8 ctrl)
-{
-	u16 val;
-
-	switch (ctrl) {
-	case ETH_TP_MDI:
-		val = AT803X_SFC_MANUAL_MDI;
-		break;
-	case ETH_TP_MDI_X:
-		val = AT803X_SFC_MANUAL_MDIX;
-		break;
-	case ETH_TP_MDI_AUTO:
-		val = AT803X_SFC_AUTOMATIC_CROSSOVER;
-		break;
-	default:
-		return 0;
-	}
-
-	return phy_modify_changed(phydev, AT803X_SPECIFIC_FUNCTION_CONTROL,
-			  AT803X_SFC_MDI_CROSSOVER_MODE_M,
-			  FIELD_PREP(AT803X_SFC_MDI_CROSSOVER_MODE_M, val));
-}
-
-static int at803x_prepare_config_aneg(struct phy_device *phydev)
-{
-	int ret;
-
-	ret = at803x_config_mdix(phydev, phydev->mdix_ctrl);
-	if (ret < 0)
-		return ret;
-
-	/* Changes of the midx bits are disruptive to the normal operation;
-	 * therefore any changes to these registers must be followed by a
-	 * software reset to take effect.
-	 */
-	if (ret == 1) {
-		ret = genphy_soft_reset(phydev);
-		if (ret < 0)
-			return ret;
-	}
-
-	return 0;
-}
-
 static int at803x_config_aneg(struct phy_device *phydev)
 {
 	struct at803x_priv *priv = phydev->priv;
@@ -1065,80 +754,6 @@ static int at803x_config_aneg(struct phy_device *phydev)
 	return genphy_config_aneg(phydev);
 }
 
-static int at803x_get_downshift(struct phy_device *phydev, u8 *d)
-{
-	int val;
-
-	val = phy_read(phydev, AT803X_SMART_SPEED);
-	if (val < 0)
-		return val;
-
-	if (val & AT803X_SMART_SPEED_ENABLE)
-		*d = FIELD_GET(AT803X_SMART_SPEED_RETRY_LIMIT_MASK, val) + 2;
-	else
-		*d = DOWNSHIFT_DEV_DISABLE;
-
-	return 0;
-}
-
-static int at803x_set_downshift(struct phy_device *phydev, u8 cnt)
-{
-	u16 mask, set;
-	int ret;
-
-	switch (cnt) {
-	case DOWNSHIFT_DEV_DEFAULT_COUNT:
-		cnt = AT803X_DEFAULT_DOWNSHIFT;
-		fallthrough;
-	case AT803X_MIN_DOWNSHIFT ... AT803X_MAX_DOWNSHIFT:
-		set = AT803X_SMART_SPEED_ENABLE |
-		      AT803X_SMART_SPEED_BYPASS_TIMER |
-		      FIELD_PREP(AT803X_SMART_SPEED_RETRY_LIMIT_MASK, cnt - 2);
-		mask = AT803X_SMART_SPEED_RETRY_LIMIT_MASK;
-		break;
-	case DOWNSHIFT_DEV_DISABLE:
-		set = 0;
-		mask = AT803X_SMART_SPEED_ENABLE |
-		       AT803X_SMART_SPEED_BYPASS_TIMER;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	ret = phy_modify_changed(phydev, AT803X_SMART_SPEED, mask, set);
-
-	/* After changing the smart speed settings, we need to perform a
-	 * software reset, use phy_init_hw() to make sure we set the
-	 * reapply any values which might got lost during software reset.
-	 */
-	if (ret == 1)
-		ret = phy_init_hw(phydev);
-
-	return ret;
-}
-
-static int at803x_get_tunable(struct phy_device *phydev,
-			      struct ethtool_tunable *tuna, void *data)
-{
-	switch (tuna->id) {
-	case ETHTOOL_PHY_DOWNSHIFT:
-		return at803x_get_downshift(phydev, data);
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
-static int at803x_set_tunable(struct phy_device *phydev,
-			      struct ethtool_tunable *tuna, const void *data)
-{
-	switch (tuna->id) {
-	case ETHTOOL_PHY_DOWNSHIFT:
-		return at803x_set_downshift(phydev, *(const u8 *)data);
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
 static int at803x_cable_test_result_trans(u16 status)
 {
 	switch (FIELD_GET(AT803X_CDT_STATUS_STAT_MASK, status)) {
@@ -1170,45 +785,6 @@ static bool at803x_cdt_fault_length_valid(u16 status)
 	return false;
 }
 
-static int at803x_cdt_fault_length(int dt)
-{
-	/* According to the datasheet the distance to the fault is
-	 * DELTA_TIME * 0.824 meters.
-	 *
-	 * The author suspect the correct formula is:
-	 *
-	 *   fault_distance = DELTA_TIME * (c * VF) / 125MHz / 2
-	 *
-	 * where c is the speed of light, VF is the velocity factor of
-	 * the twisted pair cable, 125MHz the counter frequency and
-	 * we need to divide by 2 because the hardware will measure the
-	 * round trip time to the fault and back to the PHY.
-	 *
-	 * With a VF of 0.69 we get the factor 0.824 mentioned in the
-	 * datasheet.
-	 */
-	return (dt * 824) / 10;
-}
-
-static int at803x_cdt_start(struct phy_device *phydev,
-			    u32 cdt_start)
-{
-	return phy_write(phydev, AT803X_CDT, cdt_start);
-}
-
-static int at803x_cdt_wait_for_completion(struct phy_device *phydev,
-					  u32 cdt_en)
-{
-	int val, ret;
-
-	/* One test run takes about 25ms */
-	ret = phy_read_poll_timeout(phydev, AT803X_CDT, val,
-				    !(val & cdt_en),
-				    30000, 100000, true);
-
-	return ret < 0 ? ret : 0;
-}
-
 static int at803x_cable_test_one_pair(struct phy_device *phydev, int pair)
 {
 	static const int ethtool_pair[] = {
diff --git a/drivers/net/phy/qcom/qcom-phy-lib.c b/drivers/net/phy/qcom/qcom-phy-lib.c
index 7192184429b7..e0295d4b4a51 100644
--- a/drivers/net/phy/qcom/qcom-phy-lib.c
+++ b/drivers/net/phy/qcom/qcom-phy-lib.c
@@ -3,6 +3,9 @@
 #include <linux/phy.h>
 #include <linux/module.h>
 
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+
 #include "qcom.h"
 
 MODULE_DESCRIPTION("Qualcomm PHY driver Common Functions");
@@ -51,3 +54,376 @@ int at803x_debug_reg_write(struct phy_device *phydev, u16 reg, u16 data)
 	return phy_write(phydev, AT803X_DEBUG_DATA, data);
 }
 EXPORT_SYMBOL_GPL(at803x_debug_reg_write);
+
+int at803x_set_wol(struct phy_device *phydev,
+		   struct ethtool_wolinfo *wol)
+{
+	int ret, irq_enabled;
+
+	if (wol->wolopts & WAKE_MAGIC) {
+		struct net_device *ndev = phydev->attached_dev;
+		const u8 *mac;
+		unsigned int i;
+		static const unsigned int offsets[] = {
+			AT803X_LOC_MAC_ADDR_32_47_OFFSET,
+			AT803X_LOC_MAC_ADDR_16_31_OFFSET,
+			AT803X_LOC_MAC_ADDR_0_15_OFFSET,
+		};
+
+		if (!ndev)
+			return -ENODEV;
+
+		mac = (const u8 *)ndev->dev_addr;
+
+		if (!is_valid_ether_addr(mac))
+			return -EINVAL;
+
+		for (i = 0; i < 3; i++)
+			phy_write_mmd(phydev, MDIO_MMD_PCS, offsets[i],
+				      mac[(i * 2) + 1] | (mac[(i * 2)] << 8));
+
+		/* Enable WOL interrupt */
+		ret = phy_modify(phydev, AT803X_INTR_ENABLE, 0, AT803X_INTR_ENABLE_WOL);
+		if (ret)
+			return ret;
+	} else {
+		/* Disable WOL interrupt */
+		ret = phy_modify(phydev, AT803X_INTR_ENABLE, AT803X_INTR_ENABLE_WOL, 0);
+		if (ret)
+			return ret;
+	}
+
+	/* Clear WOL status */
+	ret = phy_read(phydev, AT803X_INTR_STATUS);
+	if (ret < 0)
+		return ret;
+
+	/* Check if there are other interrupts except for WOL triggered when PHY is
+	 * in interrupt mode, only the interrupts enabled by AT803X_INTR_ENABLE can
+	 * be passed up to the interrupt PIN.
+	 */
+	irq_enabled = phy_read(phydev, AT803X_INTR_ENABLE);
+	if (irq_enabled < 0)
+		return irq_enabled;
+
+	irq_enabled &= ~AT803X_INTR_ENABLE_WOL;
+	if (ret & irq_enabled && !phy_polling_mode(phydev))
+		phy_trigger_machine(phydev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(at803x_set_wol);
+
+void at803x_get_wol(struct phy_device *phydev,
+		    struct ethtool_wolinfo *wol)
+{
+	int value;
+
+	wol->supported = WAKE_MAGIC;
+	wol->wolopts = 0;
+
+	value = phy_read(phydev, AT803X_INTR_ENABLE);
+	if (value < 0)
+		return;
+
+	if (value & AT803X_INTR_ENABLE_WOL)
+		wol->wolopts |= WAKE_MAGIC;
+}
+EXPORT_SYMBOL_GPL(at803x_get_wol);
+
+int at803x_ack_interrupt(struct phy_device *phydev)
+{
+	int err;
+
+	err = phy_read(phydev, AT803X_INTR_STATUS);
+
+	return (err < 0) ? err : 0;
+}
+EXPORT_SYMBOL_GPL(at803x_ack_interrupt);
+
+int at803x_config_intr(struct phy_device *phydev)
+{
+	int err;
+	int value;
+
+	value = phy_read(phydev, AT803X_INTR_ENABLE);
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		/* Clear any pending interrupts */
+		err = at803x_ack_interrupt(phydev);
+		if (err)
+			return err;
+
+		value |= AT803X_INTR_ENABLE_AUTONEG_ERR;
+		value |= AT803X_INTR_ENABLE_SPEED_CHANGED;
+		value |= AT803X_INTR_ENABLE_DUPLEX_CHANGED;
+		value |= AT803X_INTR_ENABLE_LINK_FAIL;
+		value |= AT803X_INTR_ENABLE_LINK_SUCCESS;
+
+		err = phy_write(phydev, AT803X_INTR_ENABLE, value);
+	} else {
+		err = phy_write(phydev, AT803X_INTR_ENABLE, 0);
+		if (err)
+			return err;
+
+		/* Clear any pending interrupts */
+		err = at803x_ack_interrupt(phydev);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(at803x_config_intr);
+
+irqreturn_t at803x_handle_interrupt(struct phy_device *phydev)
+{
+	int irq_status, int_enabled;
+
+	irq_status = phy_read(phydev, AT803X_INTR_STATUS);
+	if (irq_status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	/* Read the current enabled interrupts */
+	int_enabled = phy_read(phydev, AT803X_INTR_ENABLE);
+	if (int_enabled < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	/* See if this was one of our enabled interrupts */
+	if (!(irq_status & int_enabled))
+		return IRQ_NONE;
+
+	phy_trigger_machine(phydev);
+
+	return IRQ_HANDLED;
+}
+EXPORT_SYMBOL_GPL(at803x_handle_interrupt);
+
+int at803x_read_specific_status(struct phy_device *phydev,
+				struct at803x_ss_mask ss_mask)
+{
+	int ss;
+
+	/* Read the AT8035 PHY-Specific Status register, which indicates the
+	 * speed and duplex that the PHY is actually using, irrespective of
+	 * whether we are in autoneg mode or not.
+	 */
+	ss = phy_read(phydev, AT803X_SPECIFIC_STATUS);
+	if (ss < 0)
+		return ss;
+
+	if (ss & AT803X_SS_SPEED_DUPLEX_RESOLVED) {
+		int sfc, speed;
+
+		sfc = phy_read(phydev, AT803X_SPECIFIC_FUNCTION_CONTROL);
+		if (sfc < 0)
+			return sfc;
+
+		speed = ss & ss_mask.speed_mask;
+		speed >>= ss_mask.speed_shift;
+
+		switch (speed) {
+		case AT803X_SS_SPEED_10:
+			phydev->speed = SPEED_10;
+			break;
+		case AT803X_SS_SPEED_100:
+			phydev->speed = SPEED_100;
+			break;
+		case AT803X_SS_SPEED_1000:
+			phydev->speed = SPEED_1000;
+			break;
+		case QCA808X_SS_SPEED_2500:
+			phydev->speed = SPEED_2500;
+			break;
+		}
+		if (ss & AT803X_SS_DUPLEX)
+			phydev->duplex = DUPLEX_FULL;
+		else
+			phydev->duplex = DUPLEX_HALF;
+
+		if (ss & AT803X_SS_MDIX)
+			phydev->mdix = ETH_TP_MDI_X;
+		else
+			phydev->mdix = ETH_TP_MDI;
+
+		switch (FIELD_GET(AT803X_SFC_MDI_CROSSOVER_MODE_M, sfc)) {
+		case AT803X_SFC_MANUAL_MDI:
+			phydev->mdix_ctrl = ETH_TP_MDI;
+			break;
+		case AT803X_SFC_MANUAL_MDIX:
+			phydev->mdix_ctrl = ETH_TP_MDI_X;
+			break;
+		case AT803X_SFC_AUTOMATIC_CROSSOVER:
+			phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
+			break;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(at803x_read_specific_status);
+
+int at803x_config_mdix(struct phy_device *phydev, u8 ctrl)
+{
+	u16 val;
+
+	switch (ctrl) {
+	case ETH_TP_MDI:
+		val = AT803X_SFC_MANUAL_MDI;
+		break;
+	case ETH_TP_MDI_X:
+		val = AT803X_SFC_MANUAL_MDIX;
+		break;
+	case ETH_TP_MDI_AUTO:
+		val = AT803X_SFC_AUTOMATIC_CROSSOVER;
+		break;
+	default:
+		return 0;
+	}
+
+	return phy_modify_changed(phydev, AT803X_SPECIFIC_FUNCTION_CONTROL,
+			  AT803X_SFC_MDI_CROSSOVER_MODE_M,
+			  FIELD_PREP(AT803X_SFC_MDI_CROSSOVER_MODE_M, val));
+}
+EXPORT_SYMBOL_GPL(at803x_config_mdix);
+
+int at803x_prepare_config_aneg(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = at803x_config_mdix(phydev, phydev->mdix_ctrl);
+	if (ret < 0)
+		return ret;
+
+	/* Changes of the midx bits are disruptive to the normal operation;
+	 * therefore any changes to these registers must be followed by a
+	 * software reset to take effect.
+	 */
+	if (ret == 1) {
+		ret = genphy_soft_reset(phydev);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(at803x_prepare_config_aneg);
+
+static int at803x_get_downshift(struct phy_device *phydev, u8 *d)
+{
+	int val;
+
+	val = phy_read(phydev, AT803X_SMART_SPEED);
+	if (val < 0)
+		return val;
+
+	if (val & AT803X_SMART_SPEED_ENABLE)
+		*d = FIELD_GET(AT803X_SMART_SPEED_RETRY_LIMIT_MASK, val) + 2;
+	else
+		*d = DOWNSHIFT_DEV_DISABLE;
+
+	return 0;
+}
+
+static int at803x_set_downshift(struct phy_device *phydev, u8 cnt)
+{
+	u16 mask, set;
+	int ret;
+
+	switch (cnt) {
+	case DOWNSHIFT_DEV_DEFAULT_COUNT:
+		cnt = AT803X_DEFAULT_DOWNSHIFT;
+		fallthrough;
+	case AT803X_MIN_DOWNSHIFT ... AT803X_MAX_DOWNSHIFT:
+		set = AT803X_SMART_SPEED_ENABLE |
+		      AT803X_SMART_SPEED_BYPASS_TIMER |
+		      FIELD_PREP(AT803X_SMART_SPEED_RETRY_LIMIT_MASK, cnt - 2);
+		mask = AT803X_SMART_SPEED_RETRY_LIMIT_MASK;
+		break;
+	case DOWNSHIFT_DEV_DISABLE:
+		set = 0;
+		mask = AT803X_SMART_SPEED_ENABLE |
+		       AT803X_SMART_SPEED_BYPASS_TIMER;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = phy_modify_changed(phydev, AT803X_SMART_SPEED, mask, set);
+
+	/* After changing the smart speed settings, we need to perform a
+	 * software reset, use phy_init_hw() to make sure we set the
+	 * reapply any values which might got lost during software reset.
+	 */
+	if (ret == 1)
+		ret = phy_init_hw(phydev);
+
+	return ret;
+}
+
+int at803x_get_tunable(struct phy_device *phydev,
+		       struct ethtool_tunable *tuna, void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_DOWNSHIFT:
+		return at803x_get_downshift(phydev, data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+EXPORT_SYMBOL_GPL(at803x_get_tunable);
+
+int at803x_set_tunable(struct phy_device *phydev,
+		       struct ethtool_tunable *tuna, const void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_DOWNSHIFT:
+		return at803x_set_downshift(phydev, *(const u8 *)data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+EXPORT_SYMBOL_GPL(at803x_set_tunable);
+
+int at803x_cdt_fault_length(int dt)
+{
+	/* According to the datasheet the distance to the fault is
+	 * DELTA_TIME * 0.824 meters.
+	 *
+	 * The author suspect the correct formula is:
+	 *
+	 *   fault_distance = DELTA_TIME * (c * VF) / 125MHz / 2
+	 *
+	 * where c is the speed of light, VF is the velocity factor of
+	 * the twisted pair cable, 125MHz the counter frequency and
+	 * we need to divide by 2 because the hardware will measure the
+	 * round trip time to the fault and back to the PHY.
+	 *
+	 * With a VF of 0.69 we get the factor 0.824 mentioned in the
+	 * datasheet.
+	 */
+	return (dt * 824) / 10;
+}
+EXPORT_SYMBOL_GPL(at803x_cdt_fault_length);
+
+int at803x_cdt_start(struct phy_device *phydev, u32 cdt_start)
+{
+	return phy_write(phydev, AT803X_CDT, cdt_start);
+}
+EXPORT_SYMBOL_GPL(at803x_cdt_start);
+
+int at803x_cdt_wait_for_completion(struct phy_device *phydev,
+				   u32 cdt_en)
+{
+	int val, ret;
+
+	/* One test run takes about 25ms */
+	ret = phy_read_poll_timeout(phydev, AT803X_CDT, val,
+				    !(val & cdt_en),
+				    30000, 100000, true);
+
+	return ret < 0 ? ret : 0;
+}
+EXPORT_SYMBOL_GPL(at803x_cdt_wait_for_completion);
diff --git a/drivers/net/phy/qcom/qcom.h b/drivers/net/phy/qcom/qcom.h
index 8eb476d7c282..c127d8f50f0f 100644
--- a/drivers/net/phy/qcom/qcom.h
+++ b/drivers/net/phy/qcom/qcom.h
@@ -1,5 +1,63 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#define AT803X_SPECIFIC_FUNCTION_CONTROL	0x10
+#define AT803X_SFC_ASSERT_CRS			BIT(11)
+#define AT803X_SFC_FORCE_LINK			BIT(10)
+#define AT803X_SFC_MDI_CROSSOVER_MODE_M		GENMASK(6, 5)
+#define AT803X_SFC_AUTOMATIC_CROSSOVER		0x3
+#define AT803X_SFC_MANUAL_MDIX			0x1
+#define AT803X_SFC_MANUAL_MDI			0x0
+#define AT803X_SFC_SQE_TEST			BIT(2)
+#define AT803X_SFC_POLARITY_REVERSAL		BIT(1)
+#define AT803X_SFC_DISABLE_JABBER		BIT(0)
+
+#define AT803X_SPECIFIC_STATUS			0x11
+#define AT803X_SS_SPEED_MASK			GENMASK(15, 14)
+#define AT803X_SS_SPEED_1000			2
+#define AT803X_SS_SPEED_100			1
+#define AT803X_SS_SPEED_10			0
+#define AT803X_SS_DUPLEX			BIT(13)
+#define AT803X_SS_SPEED_DUPLEX_RESOLVED		BIT(11)
+#define AT803X_SS_MDIX				BIT(6)
+
+#define QCA808X_SS_SPEED_MASK			GENMASK(9, 7)
+#define QCA808X_SS_SPEED_2500			4
+
+#define AT803X_INTR_ENABLE			0x12
+#define AT803X_INTR_ENABLE_AUTONEG_ERR		BIT(15)
+#define AT803X_INTR_ENABLE_SPEED_CHANGED	BIT(14)
+#define AT803X_INTR_ENABLE_DUPLEX_CHANGED	BIT(13)
+#define AT803X_INTR_ENABLE_PAGE_RECEIVED	BIT(12)
+#define AT803X_INTR_ENABLE_LINK_FAIL		BIT(11)
+#define AT803X_INTR_ENABLE_LINK_SUCCESS		BIT(10)
+#define AT803X_INTR_ENABLE_LINK_FAIL_BX		BIT(8)
+#define AT803X_INTR_ENABLE_LINK_SUCCESS_BX	BIT(7)
+#define AT803X_INTR_ENABLE_WIRESPEED_DOWNGRADE	BIT(5)
+#define AT803X_INTR_ENABLE_POLARITY_CHANGED	BIT(1)
+#define AT803X_INTR_ENABLE_WOL			BIT(0)
+
+#define AT803X_INTR_STATUS			0x13
+
+#define AT803X_SMART_SPEED			0x14
+#define AT803X_SMART_SPEED_ENABLE		BIT(5)
+#define AT803X_SMART_SPEED_RETRY_LIMIT_MASK	GENMASK(4, 2)
+#define AT803X_SMART_SPEED_BYPASS_TIMER		BIT(1)
+
+#define AT803X_CDT				0x16
+#define AT803X_CDT_MDI_PAIR_MASK		GENMASK(9, 8)
+#define AT803X_CDT_ENABLE_TEST			BIT(0)
+#define AT803X_CDT_STATUS			0x1c
+#define AT803X_CDT_STATUS_STAT_NORMAL		0
+#define AT803X_CDT_STATUS_STAT_SHORT		1
+#define AT803X_CDT_STATUS_STAT_OPEN		2
+#define AT803X_CDT_STATUS_STAT_FAIL		3
+#define AT803X_CDT_STATUS_STAT_MASK		GENMASK(9, 8)
+#define AT803X_CDT_STATUS_DELTA_TIME_MASK	GENMASK(7, 0)
+
+#define AT803X_LOC_MAC_ADDR_0_15_OFFSET		0x804C
+#define AT803X_LOC_MAC_ADDR_16_31_OFFSET	0x804B
+#define AT803X_LOC_MAC_ADDR_32_47_OFFSET	0x804A
+
 #define AT803X_DEBUG_ADDR			0x1D
 #define AT803X_DEBUG_DATA			0x1E
 
@@ -16,6 +74,10 @@
 #define   AT803X_DEBUG_HIB_CTRL_EN_ANY_CHANGE	BIT(13)
 #define   AT803X_DEBUG_HIB_CTRL_PS_HIB_EN	BIT(15)
 
+#define AT803X_DEFAULT_DOWNSHIFT		5
+#define AT803X_MIN_DOWNSHIFT			2
+#define AT803X_MAX_DOWNSHIFT			9
+
 enum stat_access_type {
 	PHY,
 	MMD
@@ -28,7 +90,31 @@ struct at803x_hw_stat {
 	enum stat_access_type access_type;
 };
 
+struct at803x_ss_mask {
+	u16 speed_mask;
+	u8 speed_shift;
+};
+
 int at803x_debug_reg_read(struct phy_device *phydev, u16 reg);
 int at803x_debug_reg_mask(struct phy_device *phydev, u16 reg,
 			  u16 clear, u16 set);
 int at803x_debug_reg_write(struct phy_device *phydev, u16 reg, u16 data);
+int at803x_set_wol(struct phy_device *phydev,
+		   struct ethtool_wolinfo *wol);
+void at803x_get_wol(struct phy_device *phydev,
+		    struct ethtool_wolinfo *wol);
+int at803x_ack_interrupt(struct phy_device *phydev);
+int at803x_config_intr(struct phy_device *phydev);
+irqreturn_t at803x_handle_interrupt(struct phy_device *phydev);
+int at803x_read_specific_status(struct phy_device *phydev,
+				struct at803x_ss_mask ss_mask);
+int at803x_config_mdix(struct phy_device *phydev, u8 ctrl);
+int at803x_prepare_config_aneg(struct phy_device *phydev);
+int at803x_get_tunable(struct phy_device *phydev,
+		       struct ethtool_tunable *tuna, void *data);
+int at803x_set_tunable(struct phy_device *phydev,
+		       struct ethtool_tunable *tuna, const void *data);
+int at803x_cdt_fault_length(int dt);
+int at803x_cdt_start(struct phy_device *phydev, u32 cdt_start);
+int at803x_cdt_wait_for_completion(struct phy_device *phydev,
+				   u32 cdt_en);
-- 
2.43.0


