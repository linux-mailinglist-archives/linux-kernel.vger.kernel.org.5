Return-Path: <linux-kernel+bounces-128646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE68895D60
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EBD1C230CD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD16E15E209;
	Tue,  2 Apr 2024 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IegChvxo"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BC815D5D3;
	Tue,  2 Apr 2024 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088715; cv=none; b=mG6DfVDDQb4I3AVO9NxG1s/Z9CogSs8iybPFEMeI0oaDAj6WgqHdV80pgZGxzPYNs+FjSY9CtFjg5iqvr4wbtyo2RjNAOJsLT4gt+/6OYnm4/8TmWbk0aysF/RXiCtjPfstMxbUyTnB+wEbMP91hGi86e2F75Bk9465drpbRXfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088715; c=relaxed/simple;
	bh=Xl1YewxDylWIO2dZkm8zwCYMzPwKRG8PgxV4KCekhtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OdLscCr3qedC6+bcOJ9EFWsUlX9h8T/H1w4YCBhyt4uyQS7pz5XKcvE+IA9neo9vsAip/VuZd1WGar9B2AvJKBLFcIpVpFZo/uYrP7ih2GgB9ubx62oA13vEQb4Q3+YolS10iZWNaMyOXWSLJhKFY4yauDq5OCQq6YAUUTrf3ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IegChvxo; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56df9c119a4so447058a12.0;
        Tue, 02 Apr 2024 13:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712088711; x=1712693511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQb6wWI55VWZ7l2V0zWTjrCkmpGa/fvx/M1pkRbMvxw=;
        b=IegChvxoJHJUAZGqLx8YYkfBnA6kq2BwTPAZO/0MQE0D2fkTkc3jKhqF27a9+sIX07
         FB42hwX/AGQM7GFchWBkM9a59Eci2BdV7x+MBNSV1D+j3PFlmLFf84jTHgayAbSQR4g9
         VizmsgQWOJ+FgbTPMfKhlDNyRIHA6DYn7LVQxsG9WlCJmVMqj4lTs7foRr1YQ9t3nfAG
         aB5M6TYEWMqFaoyjMe6+xUyVUObRg3dlHMAgB3mDBEySomtbbfJPpFM98/dzIBTGeqVu
         SaSToJC56z9msEBXB8X0m65BKqAzjZ8CGNQSHVpTfVLxGYz5sVSZuTD0y/e3kSaAYnAB
         IxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712088711; x=1712693511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQb6wWI55VWZ7l2V0zWTjrCkmpGa/fvx/M1pkRbMvxw=;
        b=wa3EgZaQU9Bm95tLH1Qu8f3zKG+vaBV5xsTDUHu/6fWhtU+JQqxZJpWWDLWLeuC4kj
         MoQc6MRuLOP3cTWs6mPp0DzG29kt970r2ob/I4y4uwjagaYlKjehp5jzEWxakwoUCE+U
         c7/xmRYWYwFc7PBbMmBcT0xIWNdaCG55UAknfty4+Avf7qiQ3xhNQXF2Z+KCgXCmteb1
         d5zaKOJi4hQ1MkLr8uxOIGffdU6CoQ2tfqh2xwJ68IZXRaxPJTdMc25c+OPxKnMma3tg
         3VIKXBEegxva1n+oIfG90XDgEKvwWeaDr7umdFyrAF93+0CDkXv5AzSMEuSA2bFWYynF
         gV+A==
X-Forwarded-Encrypted: i=1; AJvYcCX3YQ6bWctBQW2S62hsbBQPz5C4Uauxt388A6DVopoA838XZHPBnGLGVHXSq0XiBbrvPh5pEyZdzZNbLQ+jT5ZgSMWkWevSjNhQWXaA
X-Gm-Message-State: AOJu0YzY667nXxn9JdgsKt5Q9bVZEfav8xK8TJi3VGicKi3R8oZhWRme
	+d7H4E3lps3YpnBlPGw8Xe0CHWOVIl8eM+Neo7d5T/y3yKmsGlcXGsrPi/R7X8U=
X-Google-Smtp-Source: AGHT+IFkXNBNt8uCe83nWR9wQQkxTjn3pVDhJZ4cnifn/4gyxj1yo4UU7J0DMjy4L2gJL0Q0bx4oRg==
X-Received: by 2002:a17:906:6bca:b0:a4e:e4:7b66 with SMTP id t10-20020a1709066bca00b00a4e00e47b66mr495137ejs.19.1712088711052;
        Tue, 02 Apr 2024 13:11:51 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id re26-20020a170906d8da00b00a474ef94fddsm6903829ejb.70.2024.04.02.13.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 13:11:50 -0700 (PDT)
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
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 3/3] net: phy: marvell: implement cable-test for 88E308X/88E609X family
Date: Tue,  2 Apr 2024 22:11:20 +0200
Message-Id: <20240402201123.2961909-3-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402201123.2961909-1-paweldembicki@gmail.com>
References: <20240402201123.2961909-1-paweldembicki@gmail.com>
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
v3:
  - resend only
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


