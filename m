Return-Path: <linux-kernel+bounces-119151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C5888C4DD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DCD0320E24
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE35B12EBC8;
	Tue, 26 Mar 2024 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaUcad1r"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACB712DDA0;
	Tue, 26 Mar 2024 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462395; cv=none; b=urlkuIUIuN82JYqR6GH59DEz7G2bHP/Yc3hy0ITNEtFAMezgI6PvdqCZLF5OFH3rF0GfYc/6rYj5g6pIG64VSiARMvZucEivHqKO5FNPRnFAxrJLSWH7gx7PNf0OkuTm2SRTpG1r7lrBdWBPLDyWjSsCeVBY4qU/Nkj/PL7+sY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462395; c=relaxed/simple;
	bh=rd+GujPVaOvUJwVylR9IElXqqM9cFOri2AQWjsbGONw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SUmTrZd57THE0gMWt8+4kXAa8DO0hAlduiVG5aNO0GPJAErGdNgxUUrpYi/h6tcBETmC3mIauDlKIZm7T+p//lhm3AzU6L/Ze1mt0IdFrChLAS+ur4ZEZNK452Akasl0j2ODIK59hY8MUmAdwVjLyUqLjhh1sOkGWKzo2kMtCCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaUcad1r; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so963740166b.1;
        Tue, 26 Mar 2024 07:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711462392; x=1712067192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFsmieGNc1bxhgiMa27ija0tbeAhS5xqyMs1Xxv+l1U=;
        b=AaUcad1rYQMBc9IvxTfJqUIoIx4B6an9eRIxAxlYuCuNgjdRYu879YUJCoO88yRSP8
         /7p01pxsALuRpTgqMEr38VsrcHnx1I6ioipeTp0gbCov+58uxiXJl+pYm7cnaNOJyh6c
         xF6eFXgEMynXYEtcszpTAGIfrN5DmVrRLDBJxJC1phgoT/Yje/zAQqnezSCHfAifH5JW
         FZkZ6Z0Iswee03co/PDP9YkG0KChp95E+d7LCZBTnH/qTVhmhcFIE6hFPfTjtvwMdd9A
         63RqeG1ILA9JqVVCw4Z91RsGOfHvaO/TgVb+uw/BkHHP0Uksj+ymqngqEDE8W5eiReAY
         wQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711462392; x=1712067192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFsmieGNc1bxhgiMa27ija0tbeAhS5xqyMs1Xxv+l1U=;
        b=oQ/2emhnwaZMiSF2FkJ/i8ZcdugiV/llY2Ks+SKLIy4MdhRPsd5BnjUwk8aML/PD+P
         tCBoFhx9NuVH6NvnmX3PiFZQyFUYos8bkpFyG2jhXmY43/8ce97eF0OxKByueLXk8A0A
         +vzSNJkVj2QO5XmbE46TWEGN76EGU/KvBmWefY+K9px4OfajQBssI6oqTHJNaKi2+vNY
         nnnqG7QriMi2raCScshwYDtggx7nGOKc8j34stp8U9OT0u3AtB+NhO5oj32oPtrVaaiY
         Gldwd8xkLkP8t6lCIY2NHGdFXKF25NugSlQw5DdWHN2DKQsMJVeRXhv3SBzJazIZduvx
         0N3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmNA7ceNL06EtqHR5Ad5fV67vB4kUaRLl4ZuRwQIM0jPs0Nb4tqDnss/5ND9OJPWHKquIocZ7THSlKbiwC2UHWx73YvdJq19sMUnjI
X-Gm-Message-State: AOJu0YwRHgixYsVBoSWgz0FvTmTi9HIHj2GzIBubqlOlxLeOtCra7n8F
	8NQe8E1WM3Cf93DbqFIOqOpJICMyvpGOxpqmfQvkXWVGFkml7blpgmCNXL7r9q4=
X-Google-Smtp-Source: AGHT+IHfrfujSOFtGoOI11tvJv/NxuhsnlchHAmi90dsftBI3Cy4Qw+45xXPIwfUh7W0aLbMrHs+Bw==
X-Received: by 2002:a17:906:5ad7:b0:a46:ab93:9848 with SMTP id x23-20020a1709065ad700b00a46ab939848mr1452245ejs.26.1711462391616;
        Tue, 26 Mar 2024 07:13:11 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id t21-20020a170906179500b00a468bf8586bsm4324094eje.174.2024.03.26.07.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 07:13:11 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: phy: marvell: implement cable-test for 88E308X/88E609X family
Date: Tue, 26 Mar 2024 15:12:36 +0100
Message-Id: <20240326141238.2315974-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326141238.2315974-1-paweldembicki@gmail.com>
References: <20240326141238.2315974-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit implements VCT in 88E308X/88E609X Family.

It require two workarounds with some magic configuration.
Regular use require only one register configuration. But Open Circuit
require second workaround.
It cause implementation two phases for fault length measuring.

Fast Ethernet PHY have implemented very simple version of VCT. It's
complitley different than vct5 or vct7.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/phy/marvell.c | 252 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 252 insertions(+)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index fae7eb57ee2c..38316d641d31 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -279,6 +279,23 @@
 #define MII_VCT7_CTRL_METERS			BIT(10)
 #define MII_VCT7_CTRL_CENTIMETERS		0
 
+#define MII_VCT_TXPINS			0x1A
+#define MII_VCT_RXPINS			0x1B
+#define MII_VCT_TXPINS_ENVCT		BIT(15)
+#define MII_VCT_TXRXPINS_VCTTST		GENMASK(14, 13)
+#define MII_VCT_TXRXPINS_VCTTST_SHIFT	13
+#define MII_VCT_TXRXPINS_VCTTST_OK	0
+#define MII_VCT_TXRXPINS_VCTTST_SHORT	1
+#define MII_VCT_TXRXPINS_VCTTST_OPEN	2
+#define MII_VCT_TXRXPINS_VCTTST_FAIL	3
+#define MII_VCT_TXRXPINS_AMPRFLN	GENMASK(12, 8)
+#define MII_VCT_TXRXPINS_AMPRFLN_SHIFT	8
+#define MII_VCT_TXRXPINS_DISTRFLN	GENMASK(7, 0)
+#define MII_VCT_TXRXPINS_DISTRFLN_MAX	0xff
+
+#define M88E3082_PAIR_A		BIT(0)
+#define M88E3082_PAIR_B		BIT(1)
+
 #define LPA_PAUSE_FIBER		0x180
 #define LPA_PAUSE_ASYM_FIBER	0x100
 
@@ -301,6 +318,12 @@ static struct marvell_hw_stat marvell_hw_stats[] = {
 	{ "phy_receive_errors_fiber", 1, 21, 16},
 };
 
+enum {
+	M88E3082_VCT_OFF,
+	M88E3082_VCT_PHASE1,
+	M88E3082_VCT_PHASE2,
+};
+
 struct marvell_priv {
 	u64 stats[ARRAY_SIZE(marvell_hw_stats)];
 	char *hwmon_name;
@@ -310,6 +333,8 @@ struct marvell_priv {
 	u32 last;
 	u32 step;
 	s8 pair;
+	u8 vct_phase;
+	u16 m88e3082_vct_reg_backup;
 };
 
 static int marvell_read_page(struct phy_device *phydev)
@@ -2417,6 +2442,231 @@ static int marvell_vct7_cable_test_get_status(struct phy_device *phydev,
 	return 0;
 }
 
+static int m88e3082_vct_cable_test_start(struct phy_device *phydev)
+{
+	struct marvell_priv *priv = phydev->priv;
+	int ret;
+
+	/* It needs some magic workaround described in VCT manual for this PHY.
+	 */
+
+	switch (priv->vct_phase) {
+	case M88E3082_VCT_OFF:
+		ret = phy_write(phydev, 29, 0x0003);
+		if (ret < 0)
+			return ret;
+
+		ret = phy_write(phydev, 30, 0x6440);
+		if (ret < 0)
+			return ret;
+
+		ret = phy_read(phydev, MII_BMCR);
+		if (ret < 0)
+			return ret;
+		priv->m88e3082_vct_reg_backup = ret;
+
+		ret = phy_write(phydev, MII_BMCR, 0xa100);
+		if (ret < 0)
+			return ret;
+
+		ret = phy_write(phydev, MII_VCT_TXPINS, MII_VCT_TXPINS_ENVCT);
+		if (ret < 0)
+			return ret;
+
+		ret = phy_write(phydev, 29, 0x0003);
+		if (ret < 0)
+			return ret;
+
+		ret = phy_write(phydev, 30, 0x0);
+		if (ret < 0)
+			return ret;
+
+		priv->vct_phase = M88E3082_VCT_PHASE1;
+		priv->pair = 0;
+
+		break;
+
+	case M88E3082_VCT_PHASE1:
+		ret = phy_write(phydev, 29, 0x0003);
+		if (ret < 0)
+			return ret;
+
+		ret = phy_write(phydev, 30, 0x6440);
+		if (ret < 0)
+			return ret;
+
+		ret = phy_write(phydev, 29, 0x000a);
+		if (ret < 0)
+			return ret;
+
+		ret = phy_write(phydev, 30, 0x0002);
+		if (ret < 0)
+			return ret;
+
+		ret = phy_read(phydev, MII_BMCR);
+		if (ret < 0)
+			return ret;
+		priv->m88e3082_vct_reg_backup = ret;
+
+		ret = phy_write(phydev, MII_BMCR, 0xa100);
+		if (ret < 0)
+			return ret;
+
+		ret = phy_write(phydev, MII_VCT_TXPINS, MII_VCT_TXPINS_ENVCT);
+		if (ret < 0)
+			return ret;
+
+		ret = phy_write(phydev, 29, 0x0003);
+		if (ret < 0)
+			return ret;
+
+		ret = phy_write(phydev, 30, 0x0);
+		if (ret < 0)
+			return ret;
+
+		ret = phy_write(phydev, 29, 0x000a);
+		if (ret < 0)
+			return ret;
+
+		ret = phy_write(phydev, 30, 0x0);
+		if (ret < 0)
+			return ret;
+
+		priv->vct_phase = M88E3082_VCT_PHASE2;
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int m88e3082_vct_cable_test_report_trans(int result, u8 distance)
+{
+	switch (result) {
+	case MII_VCT_TXRXPINS_VCTTST_OK:
+		if (distance == MII_VCT_TXRXPINS_DISTRFLN_MAX)
+			return ETHTOOL_A_CABLE_RESULT_CODE_OK;
+		/* Impedance mismatch */
+		return ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;
+	case MII_VCT_TXRXPINS_VCTTST_SHORT:
+		return ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT;
+	case MII_VCT_TXRXPINS_VCTTST_OPEN:
+		return ETHTOOL_A_CABLE_RESULT_CODE_OPEN;
+	default:
+		return ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;
+	}
+}
+
+u32 m88e3082_vct_distrfln_2_cm(u8 distrfln)
+{
+	if (distrfln < 24)
+		return 0;
+
+	/* Original function for meters: y = 0.7861x - 18.862 */
+	return (7861 * distrfln - 188620) / 100;
+}
+
+static int m88e3082_vct_cable_test_get_status(struct phy_device *phydev,
+					      bool *finished)
+{
+	u8 tx_vcttst_res, rx_vcttst_res, tx_distrfln, rx_distrfln;
+	struct marvell_priv *priv = phydev->priv;
+	int ret, tx_result, rx_result;
+	bool done_phase = true;
+
+	*finished = false;
+
+	ret = phy_read(phydev, MII_VCT_TXPINS);
+	if (ret < 0)
+		return ret;
+	else if (ret & MII_VCT_TXPINS_ENVCT)
+		return 0;
+
+	tx_distrfln = ret & MII_VCT_TXRXPINS_DISTRFLN;
+	tx_vcttst_res = (ret & MII_VCT_TXRXPINS_VCTTST) >>
+			MII_VCT_TXRXPINS_VCTTST_SHIFT;
+
+	ret = phy_read(phydev, MII_VCT_RXPINS);
+	if (ret < 0)
+		return ret;
+
+	rx_distrfln = ret & MII_VCT_TXRXPINS_DISTRFLN;
+	rx_vcttst_res = (ret & MII_VCT_TXRXPINS_VCTTST) >>
+			MII_VCT_TXRXPINS_VCTTST_SHIFT;
+
+	*finished = true;
+
+	switch (priv->vct_phase) {
+	case M88E3082_VCT_PHASE1:
+		tx_result = m88e3082_vct_cable_test_report_trans(tx_vcttst_res,
+								 tx_distrfln);
+		rx_result = m88e3082_vct_cable_test_report_trans(rx_vcttst_res,
+								 rx_distrfln);
+
+		ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_A,
+					tx_result);
+		ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_B,
+					rx_result);
+
+		if (tx_vcttst_res == MII_VCT_TXRXPINS_VCTTST_OPEN) {
+			done_phase = false;
+			priv->pair |= M88E3082_PAIR_A;
+		} else if (tx_distrfln < MII_VCT_TXRXPINS_DISTRFLN_MAX) {
+			u8 pair = ETHTOOL_A_CABLE_PAIR_A;
+			u32 cm = m88e3082_vct_distrfln_2_cm(tx_distrfln);
+
+			ethnl_cable_test_fault_length(phydev, pair, cm);
+		}
+
+		if (rx_vcttst_res == MII_VCT_TXRXPINS_VCTTST_OPEN) {
+			done_phase = false;
+			priv->pair |= M88E3082_PAIR_B;
+		} else if (rx_distrfln < MII_VCT_TXRXPINS_DISTRFLN_MAX) {
+			u8 pair = ETHTOOL_A_CABLE_PAIR_B;
+			u32 cm = m88e3082_vct_distrfln_2_cm(rx_distrfln);
+
+			ethnl_cable_test_fault_length(phydev, pair, cm);
+		}
+
+		break;
+	case M88E3082_VCT_PHASE2:
+		if (priv->pair & M88E3082_PAIR_A &&
+		    tx_vcttst_res == MII_VCT_TXRXPINS_VCTTST_OPEN &&
+		    tx_distrfln < MII_VCT_TXRXPINS_DISTRFLN_MAX) {
+			u8 pair = ETHTOOL_A_CABLE_PAIR_A;
+			u32 cm = m88e3082_vct_distrfln_2_cm(tx_distrfln);
+
+			ethnl_cable_test_fault_length(phydev, pair, cm);
+		}
+		if (priv->pair & M88E3082_PAIR_B &&
+		    rx_vcttst_res == MII_VCT_TXRXPINS_VCTTST_OPEN &&
+		    rx_distrfln < MII_VCT_TXRXPINS_DISTRFLN_MAX) {
+			u8 pair = ETHTOOL_A_CABLE_PAIR_B;
+			u32 cm = m88e3082_vct_distrfln_2_cm(rx_distrfln);
+
+			ethnl_cable_test_fault_length(phydev, pair, cm);
+		}
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = phy_write(phydev, MII_BMCR, priv->m88e3082_vct_reg_backup);
+	if (ret < 0)
+		return ret;
+
+	if (!done_phase) {
+		*finished = false;
+		return m88e3082_vct_cable_test_start(phydev);
+	}
+	if (*finished)
+		priv->vct_phase = M88E3082_VCT_OFF;
+	return 0;
+}
+
 #ifdef CONFIG_HWMON
 struct marvell_hwmon_ops {
 	int (*config)(struct phy_device *phydev);
@@ -3300,6 +3550,8 @@ static struct phy_driver marvell_drivers[] = {
 		.read_status = marvell_read_status,
 		.resume = genphy_resume,
 		.suspend = genphy_suspend,
+		.cable_test_start = m88e3082_vct_cable_test_start,
+		.cable_test_get_status = m88e3082_vct_cable_test_get_status,
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1112,
-- 
2.25.1


