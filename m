Return-Path: <linux-kernel+bounces-121634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6910E88EB52
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBDD1C32175
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2138136E2C;
	Wed, 27 Mar 2024 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBGT8Vu0"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03501DFCB;
	Wed, 27 Mar 2024 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711557026; cv=none; b=Uc7tpnIbw9MHHeqG1upHdTZcV8K8nFu+2tFxSEkEJWPTDntFV5GTk3TK40M6Tk5z4KpaSYpYWY6snGh+esTgcCNnhUUYsgLj5lYDsr6i3sbxqdzkMgwSRC5SVj5cAa0FMtZBYu2TnxsZT8cIEpsAuam2HzGgcv2GDhWRIuL/z18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711557026; c=relaxed/simple;
	bh=yLBQ7Q0YxRU1ROEH3J+Qzg6pfT50iqbp/WPyQNCl1FQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gLu0OFhTRaPGZxHH5Rj0M/9Xix1QAXxSTXNAWmQ1k5Qvy2zNjjpq18HooGm2ZeF4eCHrS7WOY1ilm+a/fm21O3DTu7h1Y/SOOstPj199opD1VMQCZFdWV2BGcC4n0M73fyrnLO1t6XAahTast6pim2gghHL7Vqo3fYlQBy9yCFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBGT8Vu0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so39536a12.0;
        Wed, 27 Mar 2024 09:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711557023; x=1712161823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qa3Xe54wxRB8ay5mVcTPHoXbgX743k6R3tOiAM+3u94=;
        b=CBGT8Vu0OyvQ1gmWXOTogOSx+m77ohPdojE0a4ZzeGSCKPUrGskKiBlYZoFPLbS8K/
         OAowX9AXIQf2yNskR6LPMZY/jd86/4n5ACXgNeB2ZNaCrseFzLiAk2+G7kq93JHnjgsz
         0JPd3FM62tEI5CimXXBYDzeia5Na/BTJFGxLoNsEZzpXWuGIXH9iPqB/rQuqXZ0u8Hky
         uzmp1Kk4nmz4wignM5iDz9Vk8U6QWw/oNKNqyRk9jRF16mBtrRXVJE5droEF4XP2El0N
         Q0NZxmcg0bypzS55KZoUWQsah1RXlyVj/GYfYKuCe1eRInNkKrBSG93kzym3aoQPjsbd
         8F6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711557023; x=1712161823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qa3Xe54wxRB8ay5mVcTPHoXbgX743k6R3tOiAM+3u94=;
        b=sCBhQVh7CzFo5aZQpBk/uJfTYQ//UiCNTv6P6KqAT+KEyLtHv4wzefs9THuUHU0uMO
         bsl0c+eV4lHl8WMWx4Ow8FMukdn1s8n6iyK+aoxqennvJmHecAgVLM0DDCVwD3Noszsn
         I10/lZ4059dJxPmzJ+lmexGXAmREfdQROKLV2h2t9nuYIayzU1qgGNccegFlheqwZJmk
         EP2IRgBJwZuWZdtJLlZPKXd0KiY38ZAun40yPEUdseZbcCZUqbHyeP3peSdDMt/Vcc/x
         ONNENxyXi60JYx3tm1W+2YwaOsfXP6kmEqq0wM7I8mrm9CphrVSXg4y7KY1C9li3/V0z
         dYvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcuXm3rMsiYhSBRVp/OLKrL+KDZ78Jl4EGvRcNS8zLImLk2ZmFn34RDMber5b8qJ8oXGFXlfoPBvBqFKp2Ajs4sT+9yyayA+f9tM0x
X-Gm-Message-State: AOJu0YzHkZtmwB6CuCqpgrVzcGwIg6t0Aj+aQFyK4HhwMTSK4dkRaXw5
	D5fcb3ASpYEJa6pjb9dB2Dr7czkFrMtIOaUHIRvsjbEapO43J8z+S2aq5t3gXiA=
X-Google-Smtp-Source: AGHT+IH835/ycakfmCVtZ2zbHRsV0/xC3B1kH3VCrc/cYQSM/XP1PT2dLQdjHygS7IdpZ5eQtyR8IA==
X-Received: by 2002:a17:906:1358:b0:a47:df55:cf6c with SMTP id x24-20020a170906135800b00a47df55cf6cmr1355175ejb.63.1711557022477;
        Wed, 27 Mar 2024 09:30:22 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id o9-20020a170906774900b00a46a2ac0dbasm5609385ejn.197.2024.03.27.09.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 09:30:22 -0700 (PDT)
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
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	David Ahern <dsahern@kernel.org>,
	Shay Agroskin <shayagr@amazon.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/3] net: phy: marvell: implement cable-test for 88E308X/88E609X family
Date: Wed, 27 Mar 2024 17:29:14 +0100
Message-Id: <20240327162918.2426792-3-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327162918.2426792-1-paweldembicki@gmail.com>
References: <20240327162918.2426792-1-paweldembicki@gmail.com>
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
v2:
  - change 'm88e3082_vct_distrfln_2_cm' to static
  - simplify 'm88e3082_vct_cable_test_get_status'
  - replace magic numbers in MII_BMCR configuration
  - remove unnecessary backup of MII_BMCR register
  - use ETHTOOL_A_CABLE_RESULT_CODE_IMPEDANCE_MISMATCH for impedance
    mismatch

 drivers/net/phy/marvell.c | 208 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index fae7eb57ee2c..7c00f47e4ded 100644
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
@@ -310,6 +333,7 @@ struct marvell_priv {
 	u32 last;
 	u32 step;
 	s8 pair;
+	u8 vct_phase;
 };
 
 static int marvell_read_page(struct phy_device *phydev)
@@ -2417,6 +2441,188 @@ static int marvell_vct7_cable_test_get_status(struct phy_device *phydev,
 	return 0;
 }
 
+static int m88e3082_vct_cable_test_start(struct phy_device *phydev)
+{
+	struct marvell_priv *priv = phydev->priv;
+	int ret;
+
+	/* It needs some magic workarounds described in VCT manual for this PHY.
+	 */
+	ret = phy_write(phydev, 29, 0x0003);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write(phydev, 30, 0x6440);
+	if (ret < 0)
+		return ret;
+
+	if (priv->vct_phase == M88E3082_VCT_PHASE1) {
+		ret = phy_write(phydev, 29, 0x000a);
+		if (ret < 0)
+			return ret;
+
+		ret = phy_write(phydev, 30, 0x0002);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = phy_write(phydev, MII_BMCR,
+			BMCR_RESET | BMCR_SPEED100 | BMCR_FULLDPLX);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write(phydev, MII_VCT_TXPINS, MII_VCT_TXPINS_ENVCT);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write(phydev, 29, 0x0003);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write(phydev, 30, 0x0);
+	if (ret < 0)
+		return ret;
+
+	if (priv->vct_phase == M88E3082_VCT_OFF) {
+		priv->vct_phase = M88E3082_VCT_PHASE1;
+		priv->pair = 0;
+
+		return 0;
+	}
+
+	ret = phy_write(phydev, 29, 0x000a);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write(phydev, 30, 0x0);
+	if (ret < 0)
+		return ret;
+
+	priv->vct_phase = M88E3082_VCT_PHASE2;
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
+		return ETHTOOL_A_CABLE_RESULT_CODE_IMPEDANCE_MISMATCH;
+	case MII_VCT_TXRXPINS_VCTTST_SHORT:
+		return ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT;
+	case MII_VCT_TXRXPINS_VCTTST_OPEN:
+		return ETHTOOL_A_CABLE_RESULT_CODE_OPEN;
+	default:
+		return ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;
+	}
+}
+
+static u32 m88e3082_vct_distrfln_2_cm(u8 distrfln)
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
@@ -3300,6 +3506,8 @@ static struct phy_driver marvell_drivers[] = {
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


