Return-Path: <linux-kernel+bounces-70039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411D185922B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497921C21E68
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5027E58C;
	Sat, 17 Feb 2024 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kudhV7Y6"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86627E59E;
	Sat, 17 Feb 2024 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708198900; cv=none; b=RrcopweXG0scvL83hf5XJ5BycrdGXd2q24xugC+nBmuWn3/Ot9F3dXIDQQXgGVzaw9dc+bLokS39WI/yao/xW4PnnSUDPhdOIRdqrIoq2odIWC3ol0FVR/BVIpnrlyIRgA4npN5z6Ww/ASbNR9ylgzqYxFsfYLl75vuwAKIEwZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708198900; c=relaxed/simple;
	bh=GxrCgNiuseMm6ZnabLCX2TWr815rQNSl+Kt+kibMH2k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCDNcHMdChCaQtrvBF8d+w98KBbYF7TOx1PgiEjKyhZGUdUGDgjTPiuEzxB99kwrpa/Ar0/iRMGFpyK3txvT5kSD5YtlMOC7Mfhbb60DrgxK0P+V52+RgLt5BbsRBPqzaeGeN3fToP1eA+2T/zHuyocQWMS310S506ulseSvWBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kudhV7Y6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d153254b7so1242348f8f.0;
        Sat, 17 Feb 2024 11:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708198892; x=1708803692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kiP+1vOsL9ZENAgwFxyDI6lf6XbrCUud7RXafPoEdX0=;
        b=kudhV7Y6Sd1LTi28tZyvBr0RV6er71jbro6mBALww+BniNV23am9aDXQapJZrBclr4
         ImUaI8LQ0Ikk2wA9FMoJlp1g/QiO8MFkQR7lp0qz2cjhuo/x6A7I/rqi1wrE2T7wpgi0
         VF+gDaGllgMYshdV7+8MBDhbBB5U5O1oh/lpcM3BRkWvQE66KX3EnSaIOpf6RGYKYyA+
         fv6h1u79Bn1h1z04jKpk6F72hr0RQbMFbvixChSmPGoQgHIWJMMyC0EdEzcrokCMByOA
         U+wF/FZsXy+mwZlFrsVzXVtFDqQpIwpRBttMI5qik1XyTMVnKnMWO+srWm1Dq1bex6Jx
         0d9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708198892; x=1708803692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kiP+1vOsL9ZENAgwFxyDI6lf6XbrCUud7RXafPoEdX0=;
        b=ruzT+lYnCxFEYL0l3N6e4fAWGbduUe0OXbMmc8r70anuavuesulO9+zvd6m/SGNS58
         09v2xk7wgdke4N+tNwMF+QbCjfMjxQ18t5vI/bNzwrlKCM0vJdzfRm9WRdSHsnQG5Efm
         wo8E0tTD+8s3Y69SyO8AwJaHzuW74786G8fGZ666B40gW8jr4jqJ9cZRrqjYc2LE/bGs
         6MM6cLVrB+YXmGJpNiPtCEyiR4TzZDOSRDeOYB4V5U0eI+WM8QmDllxE5+K0XfUbi/h0
         3aapzSryNuVVJznzlbYwI2AL5ft1yyxvqev2JwEcjAy9RHzGrWnaDYA8qWqRPXIlPZRm
         hqkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOx02R+6t16b89gdm3A++4cRZ3jBudtd2jT9DqBlm+1kt/Q/JYpVAAq/MXfsRQ8c3bvrbSKnIOVMUUh8XfDuEggTuErMoyyYsRpiMpDtdiPY8jM6MkMmOuAtA4RpwodokWbyAAd5sBsRRynCYE5gUTrcMrPKTCkd0hrnsTTVt74TMwK2WwB14d4GrZSqSl1u4YguFS5870NFN6y2DqCw9LbO5+
X-Gm-Message-State: AOJu0YznzbQWEiNzDxpm3t6upV0/IhzR+vBVDjjBBR/rCvpI8tprQ+z6
	qsbyJRocGUhKDN2rBrkvhqt6MxYYH9JFFY4Mht7ERk09rRX+pRwQ
X-Google-Smtp-Source: AGHT+IHgTR1dEUhAmK9F7NgOvv3iDlbM1cCjX5vlVyKQPy9ZEXmOmYE9oKd5miiMN4VUYffmm9GY4w==
X-Received: by 2002:a5d:62cc:0:b0:33d:3ad2:67ae with SMTP id o12-20020a5d62cc000000b0033d3ad267aemr413527wrv.57.1708198891493;
        Sat, 17 Feb 2024 11:41:31 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id b10-20020a5d40ca000000b0033ceca3a3dbsm5661169wrq.2.2024.02.17.11.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 11:41:30 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Hennerich <michael.hennerich@analog.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Richard Cochran <richardcochran@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Peter Geis <pgwipeout@gmail.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Xu Liang <lxu@maxlinear.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	Harini Katakam <harini.katakam@amd.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	rust-for-linux@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [net-next RFC PATCH 1/3] net: phy: detach PHY driver OPs from phy_driver struct
Date: Sat, 17 Feb 2024 20:41:12 +0100
Message-ID: <20240217194116.8565-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217194116.8565-1-ansuelsmth@gmail.com>
References: <20240217194116.8565-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Detach PHY driver OPs from phy_driver struct. This permits a strict
separation between const OPs and PHY model/family specific values/flags.

Many if not all PHYs driver currently have duplicated OPs for different
PHY model/family where PHY_ID matching/mask can't be used. This
limitation cause the side-effect of having to duplicate the PHY OPs for
each PHY ID causing useless bloat/wasted space.

To solve this problem, deatch PHY driver OPs from phy_driver so they
can be declared statically and just be referenced by pointer.

Each PHY driver is updated to this new phy_driver structure by simply
declaring the OPs in a locally define struct inside phy_driver to reduce
patch delta.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/adin.c                   |  4 ++
 drivers/net/phy/adin1100.c               |  2 +
 drivers/net/phy/amd.c                    |  4 ++
 drivers/net/phy/aquantia/aquantia_main.c | 26 ++++++++
 drivers/net/phy/ax88796b.c               |  6 ++
 drivers/net/phy/bcm-cygnus.c             |  4 ++
 drivers/net/phy/bcm54140.c               |  2 +
 drivers/net/phy/bcm63xx.c                |  4 ++
 drivers/net/phy/bcm7xxx.c                |  8 +++
 drivers/net/phy/bcm84881.c               |  2 +
 drivers/net/phy/bcm87xx.c                |  4 ++
 drivers/net/phy/broadcom.c               | 42 ++++++++++++
 drivers/net/phy/cicada.c                 |  4 ++
 drivers/net/phy/cortina.c                |  2 +
 drivers/net/phy/davicom.c                |  8 +++
 drivers/net/phy/dp83640.c                |  2 +
 drivers/net/phy/dp83822.c                |  8 ++-
 drivers/net/phy/dp83848.c                |  2 +
 drivers/net/phy/dp83867.c                |  2 +
 drivers/net/phy/dp83869.c                |  2 +
 drivers/net/phy/dp83tc811.c              |  2 +
 drivers/net/phy/dp83td510.c              |  2 +
 drivers/net/phy/dp83tg720.c              |  2 +
 drivers/net/phy/et1011c.c                |  2 +
 drivers/net/phy/icplus.c                 |  8 +++
 drivers/net/phy/intel-xway.c             | 20 ++++++
 drivers/net/phy/lxt.c                    |  8 +++
 drivers/net/phy/marvell-88q2xxx.c        |  2 +
 drivers/net/phy/marvell-88x2222.c        |  2 +
 drivers/net/phy/marvell.c                | 44 +++++++++++-
 drivers/net/phy/marvell10g.c             | 16 +++--
 drivers/net/phy/mediatek-ge-soc.c        |  4 ++
 drivers/net/phy/mediatek-ge.c            |  4 ++
 drivers/net/phy/meson-gxl.c              |  4 ++
 drivers/net/phy/micrel.c                 | 54 ++++++++++++---
 drivers/net/phy/microchip.c              |  2 +
 drivers/net/phy/microchip_t1.c           |  4 ++
 drivers/net/phy/microchip_t1s.c          |  4 ++
 drivers/net/phy/motorcomm.c              |  8 +++
 drivers/net/phy/mscc/mscc_main.c         | 30 +++++++++
 drivers/net/phy/mxl-gpy.c                | 24 +++++++
 drivers/net/phy/national.c               |  2 +
 drivers/net/phy/ncn26000.c               |  2 +
 drivers/net/phy/nxp-c45-tja11xx.c        |  8 ++-
 drivers/net/phy/nxp-cbtx.c               |  2 +
 drivers/net/phy/nxp-tja11xx.c            | 16 +++--
 drivers/net/phy/phy-c45.c                |  2 +
 drivers/net/phy/phy-core.c               | 18 ++---
 drivers/net/phy/phy.c                    | 85 ++++++++++++------------
 drivers/net/phy/phy_device.c             | 79 +++++++++++-----------
 drivers/net/phy/qcom/at803x.c            | 18 ++++-
 drivers/net/phy/qcom/qca807x.c           |  4 ++
 drivers/net/phy/qcom/qca808x.c           |  2 +
 drivers/net/phy/qcom/qca83xx.c           | 12 +++-
 drivers/net/phy/qsemi.c                  |  2 +
 drivers/net/phy/realtek.c                | 46 ++++++++++++-
 drivers/net/phy/rockchip.c               |  2 +
 drivers/net/phy/smsc.c                   | 14 ++++
 drivers/net/phy/ste10Xp.c                |  4 ++
 drivers/net/phy/teranetics.c             |  2 +
 drivers/net/phy/uPD60620.c               |  2 +
 drivers/net/phy/vitesse.c                | 22 ++++++
 drivers/net/phy/xilinx_gmii2rgmii.c      | 16 +++--
 include/linux/phy.h                      | 57 +++++++++-------
 64 files changed, 654 insertions(+), 147 deletions(-)

diff --git a/drivers/net/phy/adin.c b/drivers/net/phy/adin.c
index 2e1a46e121d9..469fba4eb500 100644
--- a/drivers/net/phy/adin.c
+++ b/drivers/net/phy/adin.c
@@ -994,6 +994,7 @@ static struct phy_driver adin_driver[] = {
 		PHY_ID_MATCH_MODEL(PHY_ID_ADIN1200),
 		.name		= "ADIN1200",
 		.flags		= PHY_POLL_CABLE_TEST,
+		.ops		= &(const struct phy_driver_ops){
 		.probe		= adin_probe,
 		.config_init	= adin_config_init,
 		.soft_reset	= adin_soft_reset,
@@ -1012,11 +1013,13 @@ static struct phy_driver adin_driver[] = {
 		.write_mmd	= adin_write_mmd,
 		.cable_test_start	= adin_cable_test_start,
 		.cable_test_get_status	= adin_cable_test_get_status,
+		},
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_ADIN1300),
 		.name		= "ADIN1300",
 		.flags		= PHY_POLL_CABLE_TEST,
+		.ops		= &(const struct phy_driver_ops){
 		.probe		= adin_probe,
 		.config_init	= adin_config_init,
 		.soft_reset	= adin_soft_reset,
@@ -1035,6 +1038,7 @@ static struct phy_driver adin_driver[] = {
 		.write_mmd	= adin_write_mmd,
 		.cable_test_start	= adin_cable_test_start,
 		.cable_test_get_status	= adin_cable_test_get_status,
+		},
 	},
 };
 
diff --git a/drivers/net/phy/adin1100.c b/drivers/net/phy/adin1100.c
index 85f910e2d4fb..0e85f177d4d8 100644
--- a/drivers/net/phy/adin1100.c
+++ b/drivers/net/phy/adin1100.c
@@ -323,6 +323,7 @@ static struct phy_driver adin_driver[] = {
 		.phy_id			= PHY_ID_ADIN1100,
 		.phy_id_mask		= 0xffffffcf,
 		.name			= "ADIN1100",
+		.ops			= &(const struct phy_driver_ops){
 		.get_features		= adin_get_features,
 		.soft_reset		= adin_soft_reset,
 		.probe			= adin_probe,
@@ -335,6 +336,7 @@ static struct phy_driver adin_driver[] = {
 		.resume			= adin_resume,
 		.get_sqi		= adin_get_sqi,
 		.get_sqi_max		= adin_get_sqi_max,
+		},
 	},
 };
 
diff --git a/drivers/net/phy/amd.c b/drivers/net/phy/amd.c
index 930b15fa6ce9..7bf5031a8021 100644
--- a/drivers/net/phy/amd.c
+++ b/drivers/net/phy/amd.c
@@ -94,18 +94,22 @@ static struct phy_driver am79c_drivers[] = {
 		.name		= "AM79C874",
 		.phy_id_mask	= 0xfffffff0,
 		/* PHY_BASIC_FEATURES */
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= am79c_config_init,
 		.config_intr	= am79c_config_intr,
 		.handle_interrupt = am79c_handle_interrupt,
+		},
 	},
 	{
 		.phy_id		= PHY_ID_AC101L,
 		.name		= "AC101L",
 		.phy_id_mask	= 0xfffffff0,
 		/* PHY_BASIC_FEATURES */
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= am79c_config_init,
 		.config_intr	= am79c_config_intr,
 		.handle_interrupt = am79c_handle_interrupt,
+		},
 	},
 };
 
diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index a6a7980585f5..2166370ccc82 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -772,40 +772,49 @@ static struct phy_driver aqr_driver[] = {
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQ1202),
 	.name		= "Aquantia AQ1202",
+	.ops		= &(const struct phy_driver_ops){
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
 	.read_status	= aqr_read_status,
+	},
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQ2104),
 	.name		= "Aquantia AQ2104",
+	.ops		= &(const struct phy_driver_ops){
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
 	.read_status	= aqr_read_status,
+	},
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR105),
 	.name		= "Aquantia AQR105",
+	.ops		= &(const struct phy_driver_ops){
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
 	.read_status	= aqr_read_status,
 	.suspend	= aqr107_suspend,
 	.resume		= aqr107_resume,
+	},
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR106),
 	.name		= "Aquantia AQR106",
+	.ops		= &(const struct phy_driver_ops){
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
 	.read_status	= aqr_read_status,
+	},
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR107),
 	.name		= "Aquantia AQR107",
+	.ops		= &(const struct phy_driver_ops){
 	.probe		= aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
 	.config_init	= aqr107_config_init,
@@ -821,10 +830,12 @@ static struct phy_driver aqr_driver[] = {
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
+	},
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQCS109),
 	.name		= "Aquantia AQCS109",
+	.ops		= &(const struct phy_driver_ops){
 	.probe		= aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
 	.config_init	= aqcs109_config_init,
@@ -840,10 +851,12 @@ static struct phy_driver aqr_driver[] = {
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
+	},
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR111),
 	.name		= "Aquantia AQR111",
+	.ops		= &(const struct phy_driver_ops){
 	.probe		= aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
 	.config_init	= aqr111_config_init,
@@ -859,10 +872,12 @@ static struct phy_driver aqr_driver[] = {
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
+	},
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR111B0),
 	.name		= "Aquantia AQR111B0",
+	.ops		= &(const struct phy_driver_ops){
 	.probe		= aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
 	.config_init	= aqr111_config_init,
@@ -878,18 +893,22 @@ static struct phy_driver aqr_driver[] = {
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
+	},
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR405),
 	.name		= "Aquantia AQR405",
+	.ops		= &(const struct phy_driver_ops){
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
 	.read_status	= aqr_read_status,
+	},
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR112),
 	.name		= "Aquantia AQR112",
+	.ops		= &(const struct phy_driver_ops){
 	.probe		= aqr107_probe,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
@@ -904,10 +923,12 @@ static struct phy_driver aqr_driver[] = {
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
+	},
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR412),
 	.name		= "Aquantia AQR412",
+	.ops		= &(const struct phy_driver_ops){
 	.probe		= aqr107_probe,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
@@ -922,10 +943,12 @@ static struct phy_driver aqr_driver[] = {
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
+	},
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR113),
 	.name		= "Aquantia AQR113",
+	.ops		= &(const struct phy_driver_ops){
 	.probe          = aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
 	.config_init    = aqr113c_config_init,
@@ -941,10 +964,12 @@ static struct phy_driver aqr_driver[] = {
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
+	},
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR113C),
 	.name           = "Aquantia AQR113C",
+	.ops		= &(const struct phy_driver_ops){
 	.probe          = aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
 	.config_init    = aqr113c_config_init,
@@ -960,6 +985,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
+	},
 },
 };
 
diff --git a/drivers/net/phy/ax88796b.c b/drivers/net/phy/ax88796b.c
index eb74a8cf8df1..a89ffa5231c8 100644
--- a/drivers/net/phy/ax88796b.c
+++ b/drivers/net/phy/ax88796b.c
@@ -99,24 +99,30 @@ static struct phy_driver asix_driver[] = {
 	PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88772A),
 	.name		= "Asix Electronics AX88772A",
 	.flags		= PHY_IS_INTERNAL,
+	.ops		= &(const struct phy_driver_ops){
 	.read_status	= asix_ax88772a_read_status,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 	.soft_reset	= asix_soft_reset,
 	.link_change_notify	= asix_ax88772a_link_change_notify,
+	},
 }, {
 	PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88772C),
 	.name		= "Asix Electronics AX88772C",
 	.flags		= PHY_IS_INTERNAL,
+	.ops		= &(const struct phy_driver_ops){
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 	.soft_reset	= asix_soft_reset,
+	},
 }, {
 	.phy_id		= PHY_ID_ASIX_AX88796B,
 	.name		= "Asix Electronics AX88796B",
 	.phy_id_mask	= 0xfffffff0,
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.soft_reset	= asix_soft_reset,
+	},
 } };
 
 module_phy_driver(asix_driver);
diff --git a/drivers/net/phy/bcm-cygnus.c b/drivers/net/phy/bcm-cygnus.c
index da8f7cb41b44..0ba02757e578 100644
--- a/drivers/net/phy/bcm-cygnus.c
+++ b/drivers/net/phy/bcm-cygnus.c
@@ -255,17 +255,20 @@ static struct phy_driver bcm_cygnus_phy_driver[] = {
 	.phy_id_mask   = 0xfffffff0,
 	.name          = "Broadcom Cygnus PHY",
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init   = bcm_cygnus_config_init,
 	.config_intr   = bcm_phy_config_intr,
 	.handle_interrupt = bcm_phy_handle_interrupt,
 	.suspend       = genphy_suspend,
 	.resume        = bcm_cygnus_resume,
+	},
 }, {
 	.phy_id		= PHY_ID_BCM_OMEGA,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom Omega Combo GPHY",
 	/* PHY_GBIT_FEATURES */
 	.flags		= PHY_IS_INTERNAL,
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= bcm_omega_config_init,
 	.suspend	= genphy_suspend,
 	.resume		= bcm_omega_resume,
@@ -275,6 +278,7 @@ static struct phy_driver bcm_cygnus_phy_driver[] = {
 	.get_strings	= bcm_phy_get_strings,
 	.get_stats	= bcm_omega_get_phy_stats,
 	.probe		= bcm_omega_probe,
+	},
 }
 };
 
diff --git a/drivers/net/phy/bcm54140.c b/drivers/net/phy/bcm54140.c
index 2eea3d09b1e6..62961334a4f2 100644
--- a/drivers/net/phy/bcm54140.c
+++ b/drivers/net/phy/bcm54140.c
@@ -868,6 +868,7 @@ static struct phy_driver bcm54140_drivers[] = {
 		.name           = "Broadcom BCM54140",
 		.flags		= PHY_POLL_CABLE_TEST,
 		.features       = PHY_GBIT_FEATURES,
+		.ops		= &(const struct phy_driver_ops){
 		.config_init    = bcm54140_config_init,
 		.handle_interrupt = bcm54140_handle_interrupt,
 		.config_intr    = bcm54140_config_intr,
@@ -879,6 +880,7 @@ static struct phy_driver bcm54140_drivers[] = {
 		.set_tunable	= bcm54140_set_tunable,
 		.cable_test_start = bcm_phy_cable_test_start_rdb,
 		.cable_test_get_status = bcm_phy_cable_test_get_status_rdb,
+		},
 	},
 };
 module_phy_driver(bcm54140_drivers);
diff --git a/drivers/net/phy/bcm63xx.c b/drivers/net/phy/bcm63xx.c
index 0eb33be824f1..76bcde45c65b 100644
--- a/drivers/net/phy/bcm63xx.c
+++ b/drivers/net/phy/bcm63xx.c
@@ -76,9 +76,11 @@ static struct phy_driver bcm63xx_driver[] = {
 	.name		= "Broadcom BCM63XX (1)",
 	/* PHY_BASIC_FEATURES */
 	.flags		= PHY_IS_INTERNAL,
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= bcm63xx_config_init,
 	.config_intr	= bcm63xx_config_intr,
 	.handle_interrupt = bcm_phy_handle_interrupt,
+	},
 }, {
 	/* same phy as above, with just a different OUI */
 	.phy_id		= 0x002bdc00,
@@ -86,9 +88,11 @@ static struct phy_driver bcm63xx_driver[] = {
 	.name		= "Broadcom BCM63XX (2)",
 	/* PHY_BASIC_FEATURES */
 	.flags		= PHY_IS_INTERNAL,
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= bcm63xx_config_init,
 	.config_intr	= bcm63xx_config_intr,
 	.handle_interrupt = bcm_phy_handle_interrupt,
+	},
 } };
 
 module_phy_driver(bcm63xx_driver);
diff --git a/drivers/net/phy/bcm7xxx.c b/drivers/net/phy/bcm7xxx.c
index 97638ba7ae85..c820a94b30a4 100644
--- a/drivers/net/phy/bcm7xxx.c
+++ b/drivers/net/phy/bcm7xxx.c
@@ -847,6 +847,7 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.name		= _name,					\
 	/* PHY_GBIT_FEATURES */						\
 	.flags		= PHY_IS_INTERNAL,				\
+	.ops		= &(const struct phy_driver_ops){		\
 	.config_init	= bcm7xxx_28nm_config_init,			\
 	.resume		= bcm7xxx_28nm_resume,				\
 	.get_tunable	= bcm7xxx_28nm_get_tunable,			\
@@ -855,6 +856,7 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.get_strings	= bcm_phy_get_strings,				\
 	.get_stats	= bcm7xxx_28nm_get_phy_stats,			\
 	.probe		= bcm7xxx_28nm_probe,				\
+	},								\
 }
 
 #define BCM7XXX_28NM_EPHY(_oui, _name)					\
@@ -864,6 +866,7 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.name		= _name,					\
 	/* PHY_BASIC_FEATURES */					\
 	.flags		= PHY_IS_INTERNAL,				\
+	.ops		= &(const struct phy_driver_ops){		\
 	.config_init	= bcm7xxx_28nm_ephy_config_init,		\
 	.resume		= bcm7xxx_28nm_ephy_resume,			\
 	.get_sset_count	= bcm_phy_get_sset_count,			\
@@ -872,6 +875,7 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.probe		= bcm7xxx_28nm_probe,				\
 	.read_mmd	= bcm7xxx_28nm_ephy_read_mmd,			\
 	.write_mmd	= bcm7xxx_28nm_ephy_write_mmd,			\
+	},								\
 }
 
 #define BCM7XXX_40NM_EPHY(_oui, _name)					\
@@ -881,10 +885,12 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.name           = _name,					\
 	/* PHY_BASIC_FEATURES */					\
 	.flags          = PHY_IS_INTERNAL,				\
+	.ops		= &(const struct phy_driver_ops){		\
 	.soft_reset	= genphy_soft_reset,				\
 	.config_init    = bcm7xxx_config_init,				\
 	.suspend        = bcm7xxx_suspend,				\
 	.resume         = bcm7xxx_config_init,				\
+	},								\
 }
 
 #define BCM7XXX_16NM_EPHY(_oui, _name)					\
@@ -894,6 +900,7 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.name		= _name,					\
 	/* PHY_BASIC_FEATURES */					\
 	.flags		= PHY_IS_INTERNAL,				\
+	.ops		= &(const struct phy_driver_ops){		\
 	.get_sset_count	= bcm_phy_get_sset_count,			\
 	.get_strings	= bcm_phy_get_strings,				\
 	.get_stats	= bcm7xxx_28nm_get_phy_stats,			\
@@ -902,6 +909,7 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.config_aneg	= genphy_config_aneg,				\
 	.read_status	= genphy_read_status,				\
 	.resume		= bcm7xxx_16nm_ephy_resume,			\
+	},								\
 }
 
 static struct phy_driver bcm7xxx_driver[] = {
diff --git a/drivers/net/phy/bcm84881.c b/drivers/net/phy/bcm84881.c
index f1d47c264058..12ced2b60519 100644
--- a/drivers/net/phy/bcm84881.c
+++ b/drivers/net/phy/bcm84881.c
@@ -240,12 +240,14 @@ static struct phy_driver bcm84881_drivers[] = {
 		.phy_id		= 0xae025150,
 		.phy_id_mask	= 0xfffffff0,
 		.name		= "Broadcom BCM84881",
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= bcm84881_config_init,
 		.probe		= bcm84881_probe,
 		.get_features	= bcm84881_get_features,
 		.config_aneg	= bcm84881_config_aneg,
 		.aneg_done	= bcm84881_aneg_done,
 		.read_status	= bcm84881_read_status,
+		},
 	},
 };
 
diff --git a/drivers/net/phy/bcm87xx.c b/drivers/net/phy/bcm87xx.c
index e81404bf8994..d2f837c93d79 100644
--- a/drivers/net/phy/bcm87xx.c
+++ b/drivers/net/phy/bcm87xx.c
@@ -200,6 +200,7 @@ static struct phy_driver bcm87xx_driver[] = {
 	.phy_id		= PHY_ID_BCM8706,
 	.phy_id_mask	= 0xffffffff,
 	.name		= "Broadcom BCM8706",
+	.ops		= &(const struct phy_driver_ops){
 	.get_features	= bcm87xx_get_features,
 	.config_init	= bcm87xx_config_init,
 	.config_aneg	= bcm87xx_config_aneg,
@@ -207,10 +208,12 @@ static struct phy_driver bcm87xx_driver[] = {
 	.config_intr	= bcm87xx_config_intr,
 	.handle_interrupt = bcm87xx_handle_interrupt,
 	.match_phy_device = bcm8706_match_phy_device,
+	},
 }, {
 	.phy_id		= PHY_ID_BCM8727,
 	.phy_id_mask	= 0xffffffff,
 	.name		= "Broadcom BCM8727",
+	.ops		= &(const struct phy_driver_ops){
 	.get_features	= bcm87xx_get_features,
 	.config_init	= bcm87xx_config_init,
 	.config_aneg	= bcm87xx_config_aneg,
@@ -218,6 +221,7 @@ static struct phy_driver bcm87xx_driver[] = {
 	.config_intr	= bcm87xx_config_intr,
 	.handle_interrupt = bcm87xx_handle_interrupt,
 	.match_phy_device = bcm8727_match_phy_device,
+	},
 } };
 
 module_phy_driver(bcm87xx_driver);
diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 370e4ed45098..48f4949d7f29 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -1068,6 +1068,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM5411",
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.get_sset_count	= bcm_phy_get_sset_count,
 	.get_strings	= bcm_phy_get_strings,
 	.get_stats	= bcm54xx_get_stats,
@@ -1076,11 +1077,13 @@ static struct phy_driver broadcom_drivers[] = {
 	.config_intr	= bcm_phy_config_intr,
 	.handle_interrupt = bcm_phy_handle_interrupt,
 	.link_change_notify	= bcm54xx_link_change_notify,
+	},
 }, {
 	.phy_id		= PHY_ID_BCM5421,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM5421",
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.get_sset_count	= bcm_phy_get_sset_count,
 	.get_strings	= bcm_phy_get_strings,
 	.get_stats	= bcm54xx_get_stats,
@@ -1089,12 +1092,14 @@ static struct phy_driver broadcom_drivers[] = {
 	.config_intr	= bcm_phy_config_intr,
 	.handle_interrupt = bcm_phy_handle_interrupt,
 	.link_change_notify	= bcm54xx_link_change_notify,
+	},
 }, {
 	.phy_id		= PHY_ID_BCM54210E,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM54210E",
 	/* PHY_GBIT_FEATURES */
 	.flags		= PHY_ALWAYS_CALL_SUSPEND,
+	.ops		= &(const struct phy_driver_ops){
 	.get_sset_count	= bcm_phy_get_sset_count,
 	.get_strings	= bcm_phy_get_strings,
 	.get_stats	= bcm54xx_get_stats,
@@ -1108,11 +1113,13 @@ static struct phy_driver broadcom_drivers[] = {
 	.get_wol	= bcm54xx_phy_get_wol,
 	.set_wol	= bcm54xx_phy_set_wol,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
+	},
 }, {
 	.phy_id		= PHY_ID_BCM5461,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM5461",
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.get_sset_count	= bcm_phy_get_sset_count,
 	.get_strings	= bcm_phy_get_strings,
 	.get_stats	= bcm54xx_get_stats,
@@ -1122,11 +1129,13 @@ static struct phy_driver broadcom_drivers[] = {
 	.handle_interrupt = bcm_phy_handle_interrupt,
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
+	},
 }, {
 	.phy_id		= PHY_ID_BCM54612E,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM54612E",
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.get_sset_count	= bcm_phy_get_sset_count,
 	.get_strings	= bcm_phy_get_strings,
 	.get_stats	= bcm54xx_get_stats,
@@ -1138,11 +1147,13 @@ static struct phy_driver broadcom_drivers[] = {
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 	.suspend	= bcm54xx_suspend,
 	.resume		= bcm54xx_resume,
+	},
 }, {
 	.phy_id		= PHY_ID_BCM54616S,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM54616S",
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.soft_reset     = genphy_soft_reset,
 	.config_init	= bcm54xx_config_init,
 	.config_aneg	= bcm54616s_config_aneg,
@@ -1152,11 +1163,13 @@ static struct phy_driver broadcom_drivers[] = {
 	.probe		= bcm54616s_probe,
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
+	},
 }, {
 	.phy_id		= PHY_ID_BCM5464,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM5464",
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.get_sset_count	= bcm_phy_get_sset_count,
 	.get_strings	= bcm_phy_get_strings,
 	.get_stats	= bcm54xx_get_stats,
@@ -1168,11 +1181,13 @@ static struct phy_driver broadcom_drivers[] = {
 	.resume		= genphy_resume,
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
+	},
 }, {
 	.phy_id		= PHY_ID_BCM5481,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM5481",
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.get_sset_count	= bcm_phy_get_sset_count,
 	.get_strings	= bcm_phy_get_strings,
 	.get_stats	= bcm54xx_get_stats,
@@ -1183,11 +1198,13 @@ static struct phy_driver broadcom_drivers[] = {
 	.handle_interrupt = bcm_phy_handle_interrupt,
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
+	},
 }, {
 	.phy_id         = PHY_ID_BCM54810,
 	.phy_id_mask    = 0xfffffff0,
 	.name           = "Broadcom BCM54810",
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.get_sset_count	= bcm_phy_get_sset_count,
 	.get_strings	= bcm_phy_get_strings,
 	.get_stats	= bcm54xx_get_stats,
@@ -1202,11 +1219,13 @@ static struct phy_driver broadcom_drivers[] = {
 	.resume		= bcm54xx_resume,
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
+	},
 }, {
 	.phy_id         = PHY_ID_BCM54811,
 	.phy_id_mask    = 0xfffffff0,
 	.name           = "Broadcom BCM54811",
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.get_sset_count	= bcm_phy_get_sset_count,
 	.get_strings	= bcm_phy_get_strings,
 	.get_stats	= bcm54xx_get_stats,
@@ -1219,11 +1238,13 @@ static struct phy_driver broadcom_drivers[] = {
 	.resume		= bcm54xx_resume,
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
+	},
 }, {
 	.phy_id		= PHY_ID_BCM5482,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM5482",
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.get_sset_count	= bcm_phy_get_sset_count,
 	.get_strings	= bcm_phy_get_strings,
 	.get_stats	= bcm54xx_get_stats,
@@ -1233,11 +1254,13 @@ static struct phy_driver broadcom_drivers[] = {
 	.handle_interrupt = bcm_phy_handle_interrupt,
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
+	},
 }, {
 	.phy_id		= PHY_ID_BCM50610,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM50610",
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.get_sset_count	= bcm_phy_get_sset_count,
 	.get_strings	= bcm_phy_get_strings,
 	.get_stats	= bcm54xx_get_stats,
@@ -1249,11 +1272,13 @@ static struct phy_driver broadcom_drivers[] = {
 	.suspend	= bcm54xx_suspend,
 	.resume		= bcm54xx_resume,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
+	},
 }, {
 	.phy_id		= PHY_ID_BCM50610M,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM50610M",
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.get_sset_count	= bcm_phy_get_sset_count,
 	.get_strings	= bcm_phy_get_strings,
 	.get_stats	= bcm54xx_get_stats,
@@ -1265,11 +1290,13 @@ static struct phy_driver broadcom_drivers[] = {
 	.suspend	= bcm54xx_suspend,
 	.resume		= bcm54xx_resume,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
+	},
 }, {
 	.phy_id		= PHY_ID_BCM57780,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM57780",
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.get_sset_count	= bcm_phy_get_sset_count,
 	.get_strings	= bcm_phy_get_strings,
 	.get_stats	= bcm54xx_get_stats,
@@ -1279,31 +1306,37 @@ static struct phy_driver broadcom_drivers[] = {
 	.handle_interrupt = bcm_phy_handle_interrupt,
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
+	},
 }, {
 	.phy_id		= PHY_ID_BCMAC131,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCMAC131",
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= brcm_fet_config_init,
 	.config_intr	= brcm_fet_config_intr,
 	.handle_interrupt = brcm_fet_handle_interrupt,
 	.suspend	= brcm_fet_suspend,
 	.resume		= brcm_fet_config_init,
+	},
 }, {
 	.phy_id		= PHY_ID_BCM5241,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM5241",
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= brcm_fet_config_init,
 	.config_intr	= brcm_fet_config_intr,
 	.handle_interrupt = brcm_fet_handle_interrupt,
 	.suspend	= brcm_fet_suspend,
 	.resume		= brcm_fet_config_init,
+	},
 }, {
 	.phy_id		= PHY_ID_BCM5221,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM5221",
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= brcm_fet_config_init,
 	.config_intr	= brcm_fet_config_intr,
 	.handle_interrupt = brcm_fet_handle_interrupt,
@@ -1311,24 +1344,28 @@ static struct phy_driver broadcom_drivers[] = {
 	.resume		= brcm_fet_config_init,
 	.config_aneg	= bcm5221_config_aneg,
 	.read_status	= bcm5221_read_status,
+	},
 }, {
 	.phy_id		= PHY_ID_BCM5395,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM5395",
 	.flags		= PHY_IS_INTERNAL,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.get_sset_count	= bcm_phy_get_sset_count,
 	.get_strings	= bcm_phy_get_strings,
 	.get_stats	= bcm54xx_get_stats,
 	.probe		= bcm54xx_phy_probe,
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
+	},
 }, {
 	.phy_id		= PHY_ID_BCM53125,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM53125",
 	.flags		= PHY_IS_INTERNAL,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.get_sset_count	= bcm_phy_get_sset_count,
 	.get_strings	= bcm_phy_get_strings,
 	.get_stats	= bcm54xx_get_stats,
@@ -1338,12 +1375,14 @@ static struct phy_driver broadcom_drivers[] = {
 	.handle_interrupt = bcm_phy_handle_interrupt,
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
+	},
 }, {
 	.phy_id		= PHY_ID_BCM53128,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM53128",
 	.flags		= PHY_IS_INTERNAL,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.get_sset_count	= bcm_phy_get_sset_count,
 	.get_strings	= bcm_phy_get_strings,
 	.get_stats	= bcm54xx_get_stats,
@@ -1353,11 +1392,13 @@ static struct phy_driver broadcom_drivers[] = {
 	.handle_interrupt = bcm_phy_handle_interrupt,
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
+	},
 }, {
 	.phy_id         = PHY_ID_BCM89610,
 	.phy_id_mask    = 0xfffffff0,
 	.name           = "Broadcom BCM89610",
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.get_sset_count	= bcm_phy_get_sset_count,
 	.get_strings	= bcm_phy_get_strings,
 	.get_stats	= bcm54xx_get_stats,
@@ -1366,6 +1407,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.config_intr    = bcm_phy_config_intr,
 	.handle_interrupt = bcm_phy_handle_interrupt,
 	.link_change_notify	= bcm54xx_link_change_notify,
+	},
 } };
 
 module_phy_driver(broadcom_drivers);
diff --git a/drivers/net/phy/cicada.c b/drivers/net/phy/cicada.c
index ef5f412e101f..77269c11d305 100644
--- a/drivers/net/phy/cicada.c
+++ b/drivers/net/phy/cicada.c
@@ -130,17 +130,21 @@ static struct phy_driver cis820x_driver[] = {
 	.name		= "Cicada Cis8201",
 	.phy_id_mask	= 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= &cis820x_config_init,
 	.config_intr	= &cis820x_config_intr,
 	.handle_interrupt = &cis820x_handle_interrupt,
+	},
 }, {
 	.phy_id		= 0x000fc440,
 	.name		= "Cicada Cis8204",
 	.phy_id_mask	= 0x000fffc0,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= &cis820x_config_init,
 	.config_intr	= &cis820x_config_intr,
 	.handle_interrupt = &cis820x_handle_interrupt,
+	},
 } };
 
 module_phy_driver(cis820x_driver);
diff --git a/drivers/net/phy/cortina.c b/drivers/net/phy/cortina.c
index 40514a94e6ff..8e76865533fa 100644
--- a/drivers/net/phy/cortina.c
+++ b/drivers/net/phy/cortina.c
@@ -79,9 +79,11 @@ static struct phy_driver cortina_driver[] = {
 	.phy_id_mask	= 0xffffffff,
 	.name		= "Cortina CS4340",
 	.features       = PHY_10GBIT_FEATURES,
+	.ops		= &(const struct phy_driver_ops){
 	.config_aneg	= gen10g_config_aneg,
 	.read_status	= cortina_read_status,
 	.probe		= cortina_probe,
+	},
 },
 };
 
diff --git a/drivers/net/phy/davicom.c b/drivers/net/phy/davicom.c
index 4ac4bce1bf32..874ef7c947e3 100644
--- a/drivers/net/phy/davicom.c
+++ b/drivers/net/phy/davicom.c
@@ -176,35 +176,43 @@ static struct phy_driver dm91xx_driver[] = {
 	.name		= "Davicom DM9161E",
 	.phy_id_mask	= 0x0ffffff0,
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= dm9161_config_init,
 	.config_aneg	= dm9161_config_aneg,
 	.config_intr	= dm9161_config_intr,
 	.handle_interrupt = dm9161_handle_interrupt,
+	},
 }, {
 	.phy_id		= 0x0181b8b0,
 	.name		= "Davicom DM9161B/C",
 	.phy_id_mask	= 0x0ffffff0,
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= dm9161_config_init,
 	.config_aneg	= dm9161_config_aneg,
 	.config_intr	= dm9161_config_intr,
 	.handle_interrupt = dm9161_handle_interrupt,
+	},
 }, {
 	.phy_id		= 0x0181b8a0,
 	.name		= "Davicom DM9161A",
 	.phy_id_mask	= 0x0ffffff0,
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= dm9161_config_init,
 	.config_aneg	= dm9161_config_aneg,
 	.config_intr	= dm9161_config_intr,
 	.handle_interrupt = dm9161_handle_interrupt,
+	},
 }, {
 	.phy_id		= 0x00181b80,
 	.name		= "Davicom DM9131",
 	.phy_id_mask	= 0x0ffffff0,
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_intr	= dm9161_config_intr,
 	.handle_interrupt = dm9161_handle_interrupt,
+	},
 } };
 
 module_phy_driver(dm91xx_driver);
diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 5c42c47dc564..3c601608d713 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -1520,12 +1520,14 @@ static struct phy_driver dp83640_driver = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "NatSemi DP83640",
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.probe		= dp83640_probe,
 	.remove		= dp83640_remove,
 	.soft_reset	= dp83640_soft_reset,
 	.config_init	= dp83640_config_init,
 	.config_intr    = dp83640_config_intr,
 	.handle_interrupt = dp83640_handle_interrupt,
+	},
 };
 
 static int __init dp83640_init(void)
diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 30f2616ab1c2..7e12c89586c2 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -544,7 +544,7 @@ static int dp83822_phy_reset(struct phy_device *phydev)
 	if (err < 0)
 		return err;
 
-	return phydev->drv->config_init(phydev);
+	return phydev->drv->ops->config_init(phydev);
 }
 
 #ifdef CONFIG_OF_MDIO
@@ -704,6 +704,7 @@ static int dp83822_resume(struct phy_device *phydev)
 		PHY_ID_MATCH_MODEL(_id),			\
 		.name		= (_name),			\
 		/* PHY_BASIC_FEATURES */			\
+		.ops		= &(const struct phy_driver_ops){\
 		.probe          = dp83822_probe,		\
 		.soft_reset	= dp83822_phy_reset,		\
 		.config_init	= dp83822_config_init,		\
@@ -714,6 +715,7 @@ static int dp83822_resume(struct phy_device *phydev)
 		.handle_interrupt = dp83822_handle_interrupt,	\
 		.suspend = dp83822_suspend,			\
 		.resume = dp83822_resume,			\
+		},						\
 	}
 
 #define DP83826_PHY_DRIVER(_id, _name)				\
@@ -721,6 +723,7 @@ static int dp83822_resume(struct phy_device *phydev)
 		PHY_ID_MATCH_MODEL(_id),			\
 		.name		= (_name),			\
 		/* PHY_BASIC_FEATURES */			\
+		.ops		= &(const struct phy_driver_ops){\
 		.probe          = dp83826_probe,		\
 		.soft_reset	= dp83822_phy_reset,		\
 		.config_init	= dp83826_config_init,		\
@@ -730,6 +733,7 @@ static int dp83822_resume(struct phy_device *phydev)
 		.handle_interrupt = dp83822_handle_interrupt,	\
 		.suspend = dp83822_suspend,			\
 		.resume = dp83822_resume,			\
+		},						\
 	}
 
 #define DP8382X_PHY_DRIVER(_id, _name)				\
@@ -737,6 +741,7 @@ static int dp83822_resume(struct phy_device *phydev)
 		PHY_ID_MATCH_MODEL(_id),			\
 		.name		= (_name),			\
 		/* PHY_BASIC_FEATURES */			\
+		.ops		= &(const struct phy_driver_ops){\
 		.soft_reset	= dp83822_phy_reset,		\
 		.config_init	= dp8382x_config_init,		\
 		.get_wol = dp83822_get_wol,			\
@@ -745,6 +750,7 @@ static int dp83822_resume(struct phy_device *phydev)
 		.handle_interrupt = dp83822_handle_interrupt,	\
 		.suspend = dp83822_suspend,			\
 		.resume = dp83822_resume,			\
+		},						\
 	}
 
 static struct phy_driver dp83822_driver[] = {
diff --git a/drivers/net/phy/dp83848.c b/drivers/net/phy/dp83848.c
index 937061acfc61..2d21614eab5e 100644
--- a/drivers/net/phy/dp83848.c
+++ b/drivers/net/phy/dp83848.c
@@ -139,6 +139,7 @@ MODULE_DEVICE_TABLE(mdio, dp83848_tbl);
 		.name		= _name,			\
 		/* PHY_BASIC_FEATURES */			\
 								\
+		.ops		= &(const struct phy_driver_ops){\
 		.soft_reset	= genphy_soft_reset,		\
 		.config_init	= _config_init,			\
 		.suspend	= genphy_suspend,		\
@@ -147,6 +148,7 @@ MODULE_DEVICE_TABLE(mdio, dp83848_tbl);
 		/* IRQ related */				\
 		.config_intr	= dp83848_config_intr,		\
 		.handle_interrupt = dp83848_handle_interrupt,	\
+		},						\
 	}
 
 static struct phy_driver dp83848_driver[] = {
diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 4120385c5a79..efd0bf47ee8d 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -1180,6 +1180,7 @@ static struct phy_driver dp83867_driver[] = {
 		.name		= "TI DP83867",
 		/* PHY_GBIT_FEATURES */
 
+		.ops		= &(const struct phy_driver_ops){
 		.probe          = dp83867_probe,
 		.config_init	= dp83867_config_init,
 		.soft_reset	= dp83867_phy_reset,
@@ -1206,6 +1207,7 @@ static struct phy_driver dp83867_driver[] = {
 		.led_hw_control_set = dp83867_led_hw_control_set,
 		.led_hw_control_get = dp83867_led_hw_control_get,
 		.led_polarity_set = dp83867_led_polarity_set,
+		},
 	},
 };
 module_phy_driver(dp83867_driver);
diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index fa8c6fdcf301..f9313483333d 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -893,6 +893,7 @@ static int dp83869_phy_reset(struct phy_device *phydev)
 {								\
 	PHY_ID_MATCH_MODEL(_id),				\
 	.name		= (_name),				\
+	.ops		= &(const struct phy_driver_ops){	\
 	.probe          = dp83869_probe,			\
 	.config_init	= dp83869_config_init,			\
 	.soft_reset	= dp83869_phy_reset,			\
@@ -905,6 +906,7 @@ static int dp83869_phy_reset(struct phy_device *phydev)
 	.set_wol	= dp83869_set_wol,			\
 	.suspend	= genphy_suspend,			\
 	.resume		= genphy_resume,			\
+	},							\
 }
 
 static struct phy_driver dp83869_driver[] = {
diff --git a/drivers/net/phy/dp83tc811.c b/drivers/net/phy/dp83tc811.c
index 7ea32fb77190..20ea42f1b753 100644
--- a/drivers/net/phy/dp83tc811.c
+++ b/drivers/net/phy/dp83tc811.c
@@ -390,6 +390,7 @@ static struct phy_driver dp83811_driver[] = {
 		.phy_id_mask = 0xfffffff0,
 		.name = "TI DP83TC811",
 		/* PHY_BASIC_FEATURES */
+		.ops = &(const struct phy_driver_ops){
 		.config_init = dp83811_config_init,
 		.config_aneg = dp83811_config_aneg,
 		.soft_reset = dp83811_phy_reset,
@@ -399,6 +400,7 @@ static struct phy_driver dp83811_driver[] = {
 		.handle_interrupt = dp83811_handle_interrupt,
 		.suspend = dp83811_suspend,
 		.resume = dp83811_resume,
+		},
 	 },
 };
 module_phy_driver(dp83811_driver);
diff --git a/drivers/net/phy/dp83td510.c b/drivers/net/phy/dp83td510.c
index d7616b13c594..354800718d66 100644
--- a/drivers/net/phy/dp83td510.c
+++ b/drivers/net/phy/dp83td510.c
@@ -221,6 +221,7 @@ static struct phy_driver dp83td510_driver[] = {
 	PHY_ID_MATCH_MODEL(DP83TD510E_PHY_ID),
 	.name		= "TI DP83TD510E",
 
+	.ops		= &(const struct phy_driver_ops){
 	.config_aneg	= dp83td510_config_aneg,
 	.read_status	= dp83td510_read_status,
 	.get_features	= dp83td510_get_features,
@@ -231,6 +232,7 @@ static struct phy_driver dp83td510_driver[] = {
 
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	},
 } };
 module_phy_driver(dp83td510_driver);
 
diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
index 326c9770a6dc..216db7a8945e 100644
--- a/drivers/net/phy/dp83tg720.c
+++ b/drivers/net/phy/dp83tg720.c
@@ -165,6 +165,7 @@ static struct phy_driver dp83tg720_driver[] = {
 	PHY_ID_MATCH_MODEL(DP83TG720S_PHY_ID),
 	.name		= "TI DP83TG720S",
 
+	.ops		= &(const struct phy_driver_ops){
 	.config_aneg	= dp83tg720_config_aneg,
 	.read_status	= dp83tg720_read_status,
 	.get_features	= genphy_c45_pma_read_ext_abilities,
@@ -174,6 +175,7 @@ static struct phy_driver dp83tg720_driver[] = {
 
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	},
 } };
 module_phy_driver(dp83tg720_driver);
 
diff --git a/drivers/net/phy/et1011c.c b/drivers/net/phy/et1011c.c
index be1b71d7cab7..9b570f6c1f3c 100644
--- a/drivers/net/phy/et1011c.c
+++ b/drivers/net/phy/et1011c.c
@@ -88,8 +88,10 @@ static struct phy_driver et1011c_driver[] = { {
 	.name		= "ET1011C",
 	.phy_id_mask	= 0xfffffff0,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_aneg	= et1011c_config_aneg,
 	.read_status	= et1011c_read_status,
+	},
 } };
 
 module_phy_driver(et1011c_driver);
diff --git a/drivers/net/phy/icplus.c b/drivers/net/phy/icplus.c
index a00a667454a9..37611df4705f 100644
--- a/drivers/net/phy/icplus.c
+++ b/drivers/net/phy/icplus.c
@@ -576,21 +576,26 @@ static struct phy_driver icplus_driver[] = {
 	PHY_ID_MATCH_MODEL(IP175C_PHY_ID),
 	.name		= "ICPlus IP175C",
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= ip175c_config_init,
 	.config_aneg	= ip175c_config_aneg,
 	.read_status	= ip175c_read_status,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	},
 }, {
 	PHY_ID_MATCH_MODEL(IP1001_PHY_ID),
 	.name		= "ICPlus IP1001",
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= ip1001_config_init,
 	.soft_reset	= genphy_soft_reset,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	},
 }, {
 	.name		= "ICPlus IP101A",
+	.ops		= &(const struct phy_driver_ops){
 	.match_phy_device = ip101a_match_phy_device,
 	.probe		= ip101a_g_probe,
 	.read_page	= ip101a_read_page,
@@ -603,8 +608,10 @@ static struct phy_driver icplus_driver[] = {
 	.soft_reset	= genphy_soft_reset,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	},
 }, {
 	.name		= "ICPlus IP101G",
+	.ops		= &(const struct phy_driver_ops){
 	.match_phy_device = ip101g_match_phy_device,
 	.probe		= ip101a_g_probe,
 	.read_page	= ip101g_read_page,
@@ -620,6 +627,7 @@ static struct phy_driver icplus_driver[] = {
 	.get_stats	= ip101g_get_stats,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	},
 } };
 
 module_phy_driver(icplus_driver);
diff --git a/drivers/net/phy/intel-xway.c b/drivers/net/phy/intel-xway.c
index 3c032868ef04..ce22d89e92ec 100644
--- a/drivers/net/phy/intel-xway.c
+++ b/drivers/net/phy/intel-xway.c
@@ -353,105 +353,125 @@ static struct phy_driver xway_gphy[] = {
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY11G (PEF 7071/PEF 7072) v1.3",
 		/* PHY_GBIT_FEATURES */
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= xway_gphy_config_init,
 		.config_aneg	= xway_gphy14_config_aneg,
 		.handle_interrupt = xway_gphy_handle_interrupt,
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+		},
 	}, {
 		.phy_id		= PHY_ID_PHY22F_1_3,
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY22F (PEF 7061) v1.3",
 		/* PHY_BASIC_FEATURES */
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= xway_gphy_config_init,
 		.config_aneg	= xway_gphy14_config_aneg,
 		.handle_interrupt = xway_gphy_handle_interrupt,
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+		},
 	}, {
 		.phy_id		= PHY_ID_PHY11G_1_4,
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY11G (PEF 7071/PEF 7072) v1.4",
 		/* PHY_GBIT_FEATURES */
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= xway_gphy_config_init,
 		.config_aneg	= xway_gphy14_config_aneg,
 		.handle_interrupt = xway_gphy_handle_interrupt,
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+		},
 	}, {
 		.phy_id		= PHY_ID_PHY22F_1_4,
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY22F (PEF 7061) v1.4",
 		/* PHY_BASIC_FEATURES */
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= xway_gphy_config_init,
 		.config_aneg	= xway_gphy14_config_aneg,
 		.handle_interrupt = xway_gphy_handle_interrupt,
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+		},
 	}, {
 		.phy_id		= PHY_ID_PHY11G_1_5,
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY11G (PEF 7071/PEF 7072) v1.5 / v1.6",
 		/* PHY_GBIT_FEATURES */
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= xway_gphy_config_init,
 		.handle_interrupt = xway_gphy_handle_interrupt,
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+		},
 	}, {
 		.phy_id		= PHY_ID_PHY22F_1_5,
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY22F (PEF 7061) v1.5 / v1.6",
 		/* PHY_BASIC_FEATURES */
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= xway_gphy_config_init,
 		.handle_interrupt = xway_gphy_handle_interrupt,
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+		},
 	}, {
 		.phy_id		= PHY_ID_PHY11G_VR9_1_1,
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY11G (xRX v1.1 integrated)",
 		/* PHY_GBIT_FEATURES */
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= xway_gphy_config_init,
 		.handle_interrupt = xway_gphy_handle_interrupt,
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+		},
 	}, {
 		.phy_id		= PHY_ID_PHY22F_VR9_1_1,
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY22F (xRX v1.1 integrated)",
 		/* PHY_BASIC_FEATURES */
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= xway_gphy_config_init,
 		.handle_interrupt = xway_gphy_handle_interrupt,
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+		},
 	}, {
 		.phy_id		= PHY_ID_PHY11G_VR9_1_2,
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY11G (xRX v1.2 integrated)",
 		/* PHY_GBIT_FEATURES */
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= xway_gphy_config_init,
 		.handle_interrupt = xway_gphy_handle_interrupt,
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+		},
 	}, {
 		.phy_id		= PHY_ID_PHY22F_VR9_1_2,
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY22F (xRX v1.2 integrated)",
 		/* PHY_BASIC_FEATURES */
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= xway_gphy_config_init,
 		.handle_interrupt = xway_gphy_handle_interrupt,
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+		},
 	},
 };
 module_phy_driver(xway_gphy);
diff --git a/drivers/net/phy/lxt.c b/drivers/net/phy/lxt.c
index e3bf827b7959..b0bcb1b1bc4c 100644
--- a/drivers/net/phy/lxt.c
+++ b/drivers/net/phy/lxt.c
@@ -311,39 +311,47 @@ static struct phy_driver lxt97x_driver[] = {
 	.name		= "LXT970",
 	.phy_id_mask	= 0xfffffff0,
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= lxt970_config_init,
 	.config_intr	= lxt970_config_intr,
 	.handle_interrupt = lxt970_handle_interrupt,
+	},
 }, {
 	.phy_id		= 0x001378e0,
 	.name		= "LXT971",
 	.phy_id_mask	= 0xfffffff0,
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_intr	= lxt971_config_intr,
 	.handle_interrupt = lxt971_handle_interrupt,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	},
 }, {
 	.phy_id		= 0x00137a10,
 	.name		= "LXT973-A2",
 	.phy_id_mask	= 0xffffffff,
 	/* PHY_BASIC_FEATURES */
 	.flags		= 0,
+	.ops		= &(const struct phy_driver_ops){
 	.probe		= lxt973_probe,
 	.config_aneg	= lxt973_config_aneg,
 	.read_status	= lxt973a2_read_status,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	},
 }, {
 	.phy_id		= 0x00137a10,
 	.name		= "LXT973",
 	.phy_id_mask	= 0xfffffff0,
 	/* PHY_BASIC_FEATURES */
 	.flags		= 0,
+	.ops		= &(const struct phy_driver_ops){
 	.probe		= lxt973_probe,
 	.config_aneg	= lxt973_config_aneg,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	},
 } };
 
 module_phy_driver(lxt97x_driver);
diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 1c3ff77de56b..6ff13060cd2e 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -240,6 +240,7 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.phy_id			= MARVELL_PHY_ID_88Q2110,
 		.phy_id_mask		= MARVELL_PHY_ID_MASK,
 		.name			= "mv88q2110",
+		.ops			= &(const struct phy_driver_ops){
 		.get_features		= mv88q2xxx_get_features,
 		.config_aneg		= mv88q2xxx_config_aneg,
 		.config_init		= mv88q2xxx_config_init,
@@ -248,6 +249,7 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.set_loopback		= genphy_c45_loopback,
 		.get_sqi		= mv88q2xxxx_get_sqi,
 		.get_sqi_max		= mv88q2xxxx_get_sqi_max,
+		},
 	},
 };
 
diff --git a/drivers/net/phy/marvell-88x2222.c b/drivers/net/phy/marvell-88x2222.c
index e3aa30dad2e6..9de149fca07e 100644
--- a/drivers/net/phy/marvell-88x2222.c
+++ b/drivers/net/phy/marvell-88x2222.c
@@ -600,6 +600,7 @@ static struct phy_driver mv2222_drivers[] = {
 		.phy_id = MARVELL_PHY_ID_88X2222,
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88X2222",
+		.ops = &(const struct phy_driver_ops){
 		.get_features = mv2222_get_features,
 		.soft_reset = mv2222_soft_reset,
 		.config_init = mv2222_config_init,
@@ -609,6 +610,7 @@ static struct phy_driver mv2222_drivers[] = {
 		.suspend = mv2222_suspend,
 		.resume = mv2222_resume,
 		.read_status = mv2222_read_status,
+		},
 	},
 };
 module_phy_driver(mv2222_drivers);
diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 1faa22f58366..033c10c82c6a 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -3273,6 +3273,7 @@ static struct phy_driver marvell_drivers[] = {
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1101",
 		/* PHY_GBIT_FEATURES */
+		.ops = &(const struct phy_driver_ops){
 		.probe = marvell_probe,
 		.config_init = marvell_config_init,
 		.config_aneg = m88e1101_config_aneg,
@@ -3285,12 +3286,14 @@ static struct phy_driver marvell_drivers[] = {
 		.get_sset_count = marvell_get_sset_count,
 		.get_strings = marvell_get_strings,
 		.get_stats = marvell_get_stats,
+		},
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1112,
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1112",
 		/* PHY_GBIT_FEATURES */
+		.ops = &(const struct phy_driver_ops){
 		.probe = marvell_probe,
 		.config_init = m88e1112_config_init,
 		.config_aneg = marvell_config_aneg,
@@ -3305,12 +3308,14 @@ static struct phy_driver marvell_drivers[] = {
 		.get_stats = marvell_get_stats,
 		.get_tunable = m88e1011_get_tunable,
 		.set_tunable = m88e1011_set_tunable,
+		},
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1111,
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1111",
 		/* PHY_GBIT_FEATURES */
+		.ops = &(const struct phy_driver_ops){
 		.probe = marvell_probe,
 		.config_init = m88e1111gbe_config_init,
 		.config_aneg = m88e1111_config_aneg,
@@ -3326,12 +3331,14 @@ static struct phy_driver marvell_drivers[] = {
 		.get_stats = marvell_get_stats,
 		.get_tunable = m88e1111_get_tunable,
 		.set_tunable = m88e1111_set_tunable,
+		},
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1111_FINISAR,
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1111 (Finisar)",
 		/* PHY_GBIT_FEATURES */
+		.ops = &(const struct phy_driver_ops){
 		.probe = marvell_probe,
 		.config_init = m88e1111gbe_config_init,
 		.config_aneg = m88e1111_config_aneg,
@@ -3347,12 +3354,14 @@ static struct phy_driver marvell_drivers[] = {
 		.get_stats = marvell_get_stats,
 		.get_tunable = m88e1111_get_tunable,
 		.set_tunable = m88e1111_set_tunable,
+		},
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1118,
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1118",
 		/* PHY_GBIT_FEATURES */
+		.ops = &(const struct phy_driver_ops){
 		.probe = marvell_probe,
 		.config_init = m88e1118_config_init,
 		.config_aneg = m88e1118_config_aneg,
@@ -3365,6 +3374,7 @@ static struct phy_driver marvell_drivers[] = {
 		.get_sset_count = marvell_get_sset_count,
 		.get_strings = marvell_get_strings,
 		.get_stats = marvell_get_stats,
+		},
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1121R,
@@ -3372,6 +3382,7 @@ static struct phy_driver marvell_drivers[] = {
 		.name = "Marvell 88E1121R",
 		.driver_data = DEF_MARVELL_HWMON_OPS(m88e1121_hwmon_ops),
 		/* PHY_GBIT_FEATURES */
+		.ops = &(const struct phy_driver_ops){
 		.probe = marvell_probe,
 		.config_init = marvell_1011gbe_config_init,
 		.config_aneg = m88e1121_config_aneg,
@@ -3387,12 +3398,14 @@ static struct phy_driver marvell_drivers[] = {
 		.get_stats = marvell_get_stats,
 		.get_tunable = m88e1011_get_tunable,
 		.set_tunable = m88e1011_set_tunable,
+		},
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1318S,
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1318S",
 		/* PHY_GBIT_FEATURES */
+		.ops = &(const struct phy_driver_ops){
 		.probe = marvell_probe,
 		.config_init = m88e1318_config_init,
 		.config_aneg = m88e1318_config_aneg,
@@ -3413,12 +3426,14 @@ static struct phy_driver marvell_drivers[] = {
 		.led_hw_is_supported = m88e1318_led_hw_is_supported,
 		.led_hw_control_set = m88e1318_led_hw_control_set,
 		.led_hw_control_get = m88e1318_led_hw_control_get,
+		},
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1145,
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1145",
 		/* PHY_GBIT_FEATURES */
+		.ops = &(const struct phy_driver_ops){
 		.probe = marvell_probe,
 		.config_init = m88e1145_config_init,
 		.config_aneg = m88e1101_config_aneg,
@@ -3433,12 +3448,14 @@ static struct phy_driver marvell_drivers[] = {
 		.get_stats = marvell_get_stats,
 		.get_tunable = m88e1111_get_tunable,
 		.set_tunable = m88e1111_set_tunable,
+		},
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1149R,
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1149R",
 		/* PHY_GBIT_FEATURES */
+		.ops = &(const struct phy_driver_ops){
 		.probe = marvell_probe,
 		.config_init = m88e1149_config_init,
 		.config_aneg = m88e1118_config_aneg,
@@ -3451,12 +3468,14 @@ static struct phy_driver marvell_drivers[] = {
 		.get_sset_count = marvell_get_sset_count,
 		.get_strings = marvell_get_strings,
 		.get_stats = marvell_get_stats,
+		},
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1240,
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1240",
 		/* PHY_GBIT_FEATURES */
+		.ops = &(const struct phy_driver_ops){
 		.probe = marvell_probe,
 		.config_init = m88e1112_config_init,
 		.config_aneg = marvell_config_aneg,
@@ -3471,12 +3490,14 @@ static struct phy_driver marvell_drivers[] = {
 		.get_stats = marvell_get_stats,
 		.get_tunable = m88e1011_get_tunable,
 		.set_tunable = m88e1011_set_tunable,
+		},
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1116R,
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1116R",
 		/* PHY_GBIT_FEATURES */
+		.ops = &(const struct phy_driver_ops){
 		.probe = marvell_probe,
 		.config_init = m88e1116r_config_init,
 		.config_intr = marvell_config_intr,
@@ -3490,6 +3511,7 @@ static struct phy_driver marvell_drivers[] = {
 		.get_stats = marvell_get_stats,
 		.get_tunable = m88e1011_get_tunable,
 		.set_tunable = m88e1011_set_tunable,
+		},
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1510,
@@ -3498,6 +3520,7 @@ static struct phy_driver marvell_drivers[] = {
 		.driver_data = DEF_MARVELL_HWMON_OPS(m88e1510_hwmon_ops),
 		.features = PHY_GBIT_FIBRE_FEATURES,
 		.flags = PHY_POLL_CABLE_TEST,
+		.ops = &(const struct phy_driver_ops){
 		.probe = m88e1510_probe,
 		.config_init = m88e1510_config_init,
 		.config_aneg = m88e1510_config_aneg,
@@ -3524,6 +3547,7 @@ static struct phy_driver marvell_drivers[] = {
 		.led_hw_is_supported = m88e1318_led_hw_is_supported,
 		.led_hw_control_set = m88e1318_led_hw_control_set,
 		.led_hw_control_get = m88e1318_led_hw_control_get,
+		},
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1540,
@@ -3532,6 +3556,7 @@ static struct phy_driver marvell_drivers[] = {
 		.driver_data = DEF_MARVELL_HWMON_OPS(m88e1510_hwmon_ops),
 		/* PHY_GBIT_FEATURES */
 		.flags = PHY_POLL_CABLE_TEST,
+		.ops = &(const struct phy_driver_ops){
 		.probe = marvell_probe,
 		.config_init = marvell_1011gbe_config_init,
 		.config_aneg = m88e1510_config_aneg,
@@ -3555,15 +3580,17 @@ static struct phy_driver marvell_drivers[] = {
 		.led_hw_is_supported = m88e1318_led_hw_is_supported,
 		.led_hw_control_set = m88e1318_led_hw_control_set,
 		.led_hw_control_get = m88e1318_led_hw_control_get,
+		},
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1545,
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1545",
 		.driver_data = DEF_MARVELL_HWMON_OPS(m88e1510_hwmon_ops),
-		.probe = marvell_probe,
 		/* PHY_GBIT_FEATURES */
 		.flags = PHY_POLL_CABLE_TEST,
+		.ops = &(const struct phy_driver_ops){
+		.probe = marvell_probe,
 		.config_init = marvell_1011gbe_config_init,
 		.config_aneg = m88e1510_config_aneg,
 		.read_status = marvell_read_status,
@@ -3586,12 +3613,14 @@ static struct phy_driver marvell_drivers[] = {
 		.led_hw_is_supported = m88e1318_led_hw_is_supported,
 		.led_hw_control_set = m88e1318_led_hw_control_set,
 		.led_hw_control_get = m88e1318_led_hw_control_get,
+		},
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E3016,
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E3016",
 		/* PHY_BASIC_FEATURES */
+		.ops = &(const struct phy_driver_ops){
 		.probe = marvell_probe,
 		.config_init = m88e3016_config_init,
 		.aneg_done = marvell_aneg_done,
@@ -3605,6 +3634,7 @@ static struct phy_driver marvell_drivers[] = {
 		.get_sset_count = marvell_get_sset_count,
 		.get_strings = marvell_get_strings,
 		.get_stats = marvell_get_stats,
+		},
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E6341_FAMILY,
@@ -3613,6 +3643,7 @@ static struct phy_driver marvell_drivers[] = {
 		.driver_data = DEF_MARVELL_HWMON_OPS(m88e1510_hwmon_ops),
 		/* PHY_GBIT_FEATURES */
 		.flags = PHY_POLL_CABLE_TEST,
+		.ops = &(const struct phy_driver_ops){
 		.probe = marvell_probe,
 		.config_init = marvell_1011gbe_config_init,
 		.config_aneg = m88e6390_config_aneg,
@@ -3631,6 +3662,7 @@ static struct phy_driver marvell_drivers[] = {
 		.cable_test_start = marvell_vct7_cable_test_start,
 		.cable_test_tdr_start = marvell_vct5_cable_test_tdr_start,
 		.cable_test_get_status = marvell_vct7_cable_test_get_status,
+		},
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E6390_FAMILY,
@@ -3639,6 +3671,7 @@ static struct phy_driver marvell_drivers[] = {
 		.driver_data = DEF_MARVELL_HWMON_OPS(m88e6390_hwmon_ops),
 		/* PHY_GBIT_FEATURES */
 		.flags = PHY_POLL_CABLE_TEST,
+		.ops = &(const struct phy_driver_ops){
 		.probe = marvell_probe,
 		.config_init = marvell_1011gbe_config_init,
 		.config_aneg = m88e6390_config_aneg,
@@ -3657,6 +3690,7 @@ static struct phy_driver marvell_drivers[] = {
 		.cable_test_start = marvell_vct7_cable_test_start,
 		.cable_test_tdr_start = marvell_vct5_cable_test_tdr_start,
 		.cable_test_get_status = marvell_vct7_cable_test_get_status,
+		},
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E6393_FAMILY,
@@ -3665,6 +3699,7 @@ static struct phy_driver marvell_drivers[] = {
 		.driver_data = DEF_MARVELL_HWMON_OPS(m88e6393_hwmon_ops),
 		/* PHY_GBIT_FEATURES */
 		.flags = PHY_POLL_CABLE_TEST,
+		.ops = &(const struct phy_driver_ops){
 		.probe = marvell_probe,
 		.config_init = marvell_1011gbe_config_init,
 		.config_aneg = m88e1510_config_aneg,
@@ -3683,12 +3718,14 @@ static struct phy_driver marvell_drivers[] = {
 		.cable_test_start = marvell_vct7_cable_test_start,
 		.cable_test_tdr_start = marvell_vct5_cable_test_tdr_start,
 		.cable_test_get_status = marvell_vct7_cable_test_get_status,
+		},
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1340S,
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1340S",
 		.driver_data = DEF_MARVELL_HWMON_OPS(m88e1510_hwmon_ops),
+		.ops = &(const struct phy_driver_ops){
 		.probe = marvell_probe,
 		/* PHY_GBIT_FEATURES */
 		.config_init = marvell_1011gbe_config_init,
@@ -3705,14 +3742,16 @@ static struct phy_driver marvell_drivers[] = {
 		.get_stats = marvell_get_stats,
 		.get_tunable = m88e1540_get_tunable,
 		.set_tunable = m88e1540_set_tunable,
+		},
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1548P,
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1548P",
 		.driver_data = DEF_MARVELL_HWMON_OPS(m88e1510_hwmon_ops),
-		.probe = marvell_probe,
 		.features = PHY_GBIT_FIBRE_FEATURES,
+		.ops = &(const struct phy_driver_ops){
+		.probe = marvell_probe,
 		.config_init = marvell_1011gbe_config_init,
 		.config_aneg = m88e1510_config_aneg,
 		.read_status = marvell_read_status,
@@ -3732,6 +3771,7 @@ static struct phy_driver marvell_drivers[] = {
 		.led_hw_is_supported = m88e1318_led_hw_is_supported,
 		.led_hw_control_set = m88e1318_led_hw_control_set,
 		.led_hw_control_get = m88e1318_led_hw_control_get,
+		},
 	},
 };
 
diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index ad43e280930c..9681c0083ca4 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -1403,9 +1403,10 @@ static struct phy_driver mv3310_drivers[] = {
 	{
 		.phy_id		= MARVELL_PHY_ID_88X3310,
 		.phy_id_mask	= MARVELL_PHY_ID_MASK,
-		.match_phy_device = mv3310_match_phy_device,
 		.name		= "mv88x3310",
 		.driver_data	= &mv3310_type,
+		.ops		= &(const struct phy_driver_ops){
+		.match_phy_device = mv3310_match_phy_device,
 		.get_features	= mv3310_get_features,
 		.config_init	= mv3310_config_init,
 		.probe		= mv3310_probe,
@@ -1420,13 +1421,15 @@ static struct phy_driver mv3310_drivers[] = {
 		.set_loopback	= genphy_c45_loopback,
 		.get_wol	= mv3110_get_wol,
 		.set_wol	= mv3110_set_wol,
+		},
 	},
 	{
 		.phy_id		= MARVELL_PHY_ID_88X3310,
 		.phy_id_mask	= MARVELL_PHY_ID_MASK,
-		.match_phy_device = mv3340_match_phy_device,
 		.name		= "mv88x3340",
 		.driver_data	= &mv3340_type,
+		.ops		= &(const struct phy_driver_ops){
+		.match_phy_device = mv3340_match_phy_device,
 		.get_features	= mv3310_get_features,
 		.config_init	= mv3310_config_init,
 		.probe		= mv3310_probe,
@@ -1439,13 +1442,15 @@ static struct phy_driver mv3310_drivers[] = {
 		.set_tunable	= mv3310_set_tunable,
 		.remove		= mv3310_remove,
 		.set_loopback	= genphy_c45_loopback,
+		},
 	},
 	{
 		.phy_id		= MARVELL_PHY_ID_88E2110,
 		.phy_id_mask	= MARVELL_PHY_ID_MASK,
-		.match_phy_device = mv2110_match_phy_device,
 		.name		= "mv88e2110",
 		.driver_data	= &mv2110_type,
+		.ops		= &(const struct phy_driver_ops){
+		.match_phy_device = mv2110_match_phy_device,
 		.probe		= mv3310_probe,
 		.suspend	= mv3310_suspend,
 		.resume		= mv3310_resume,
@@ -1459,13 +1464,15 @@ static struct phy_driver mv3310_drivers[] = {
 		.set_loopback	= genphy_c45_loopback,
 		.get_wol	= mv3110_get_wol,
 		.set_wol	= mv3110_set_wol,
+		},
 	},
 	{
 		.phy_id		= MARVELL_PHY_ID_88E2110,
 		.phy_id_mask	= MARVELL_PHY_ID_MASK,
-		.match_phy_device = mv2111_match_phy_device,
 		.name		= "mv88e2111",
 		.driver_data	= &mv2111_type,
+		.ops		= &(const struct phy_driver_ops){
+		.match_phy_device = mv2111_match_phy_device,
 		.probe		= mv3310_probe,
 		.suspend	= mv3310_suspend,
 		.resume		= mv3310_resume,
@@ -1477,6 +1484,7 @@ static struct phy_driver mv3310_drivers[] = {
 		.set_tunable	= mv3310_set_tunable,
 		.remove		= mv3310_remove,
 		.set_loopback	= genphy_c45_loopback,
+		},
 	},
 };
 
diff --git a/drivers/net/phy/mediatek-ge-soc.c b/drivers/net/phy/mediatek-ge-soc.c
index 0f3a1538a8b8..f24dc1e37ea1 100644
--- a/drivers/net/phy/mediatek-ge-soc.c
+++ b/drivers/net/phy/mediatek-ge-soc.c
@@ -1497,6 +1497,7 @@ static struct phy_driver mtk_socphy_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7981),
 		.name		= "MediaTek MT7981 PHY",
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= mt798x_phy_config_init,
 		.config_intr	= genphy_no_config_intr,
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
@@ -1510,10 +1511,12 @@ static struct phy_driver mtk_socphy_driver[] = {
 		.led_hw_is_supported = mt798x_phy_led_hw_is_supported,
 		.led_hw_control_set = mt798x_phy_led_hw_control_set,
 		.led_hw_control_get = mt798x_phy_led_hw_control_get,
+		},
 	},
 	{
 		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7988),
 		.name		= "MediaTek MT7988 PHY",
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= mt798x_phy_config_init,
 		.config_intr	= genphy_no_config_intr,
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
@@ -1527,6 +1530,7 @@ static struct phy_driver mtk_socphy_driver[] = {
 		.led_hw_is_supported = mt798x_phy_led_hw_is_supported,
 		.led_hw_control_set = mt798x_phy_led_hw_control_set,
 		.led_hw_control_get = mt798x_phy_led_hw_control_get,
+		},
 	},
 };
 
diff --git a/drivers/net/phy/mediatek-ge.c b/drivers/net/phy/mediatek-ge.c
index a493ae01b267..9ac1d02b0b96 100644
--- a/drivers/net/phy/mediatek-ge.c
+++ b/drivers/net/phy/mediatek-ge.c
@@ -72,6 +72,7 @@ static struct phy_driver mtk_gephy_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(0x03a29412),
 		.name		= "MediaTek MT7530 PHY",
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= mt7530_phy_config_init,
 		/* Interrupts are handled by the switch, not the PHY
 		 * itself.
@@ -82,10 +83,12 @@ static struct phy_driver mtk_gephy_driver[] = {
 		.resume		= genphy_resume,
 		.read_page	= mtk_gephy_read_page,
 		.write_page	= mtk_gephy_write_page,
+		},
 	},
 	{
 		PHY_ID_MATCH_EXACT(0x03a29441),
 		.name		= "MediaTek MT7531 PHY",
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= mt7531_phy_config_init,
 		/* Interrupts are handled by the switch, not the PHY
 		 * itself.
@@ -96,6 +99,7 @@ static struct phy_driver mtk_gephy_driver[] = {
 		.resume		= genphy_resume,
 		.read_page	= mtk_gephy_read_page,
 		.write_page	= mtk_gephy_write_page,
+		},
 	},
 };
 
diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index bb9b33b6bce2..6e839ea7c74b 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -190,6 +190,7 @@ static struct phy_driver meson_gxl_phy[] = {
 		.name		= "Meson GXL Internal PHY",
 		/* PHY_BASIC_FEATURES */
 		.flags		= PHY_IS_INTERNAL,
+		.ops		= &(const struct phy_driver_ops){
 		.soft_reset     = genphy_soft_reset,
 		.config_init	= meson_gxl_config_init,
 		.read_status	= meson_gxl_read_status,
@@ -199,11 +200,13 @@ static struct phy_driver meson_gxl_phy[] = {
 		.resume         = genphy_resume,
 		.read_mmd	= genphy_read_mmd_unsupported,
 		.write_mmd	= genphy_write_mmd_unsupported,
+		},
 	}, {
 		PHY_ID_MATCH_EXACT(0x01803301),
 		.name		= "Meson G12A Internal PHY",
 		/* PHY_BASIC_FEATURES */
 		.flags		= PHY_IS_INTERNAL,
+		.ops		= &(const struct phy_driver_ops){
 		.probe		= smsc_phy_probe,
 		.config_init	= smsc_phy_config_init,
 		.soft_reset     = genphy_soft_reset,
@@ -218,6 +221,7 @@ static struct phy_driver meson_gxl_phy[] = {
 		.resume         = genphy_resume,
 		.read_mmd	= genphy_read_mmd_unsupported,
 		.write_mmd	= genphy_write_mmd_unsupported,
+		},
 	},
 };
 
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 9b6973581989..4ae508e87040 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1502,8 +1502,8 @@ static int ksz9031_read_status(struct phy_device *phydev)
 	if ((regval & 0xFF) == 0xFF) {
 		phy_init_hw(phydev);
 		phydev->link = 0;
-		if (phydev->drv->config_intr && phy_interrupt_is_valid(phydev))
-			phydev->drv->config_intr(phydev);
+		if (phydev->drv->ops->config_intr && phy_interrupt_is_valid(phydev))
+			phydev->drv->ops->config_intr(phydev);
 		return genphy_config_aneg(phydev);
 	}
 
@@ -1940,8 +1940,8 @@ static int kszphy_suspend(struct phy_device *phydev)
 	/* Disable PHY Interrupts */
 	if (phy_interrupt_is_valid(phydev)) {
 		phydev->interrupts = PHY_INTERRUPT_DISABLED;
-		if (phydev->drv->config_intr)
-			phydev->drv->config_intr(phydev);
+		if (phydev->drv->ops->config_intr)
+			phydev->drv->ops->config_intr(phydev);
 	}
 
 	return genphy_suspend(phydev);
@@ -1990,8 +1990,8 @@ static int kszphy_resume(struct phy_device *phydev)
 	/* Enable PHY Interrupts */
 	if (phy_interrupt_is_valid(phydev)) {
 		phydev->interrupts = PHY_INTERRUPT_ENABLED;
-		if (phydev->drv->config_intr)
-			phydev->drv->config_intr(phydev);
+		if (phydev->drv->ops->config_intr)
+			phydev->drv->ops->config_intr(phydev);
 	}
 
 	return 0;
@@ -4633,18 +4633,21 @@ static struct phy_driver ksphy_driver[] = {
 	.name		= "Micrel KS8737",
 	/* PHY_BASIC_FEATURES */
 	.driver_data	= &ks8737_type,
+	.ops		= &(const struct phy_driver_ops){
 	.probe		= kszphy_probe,
 	.config_init	= kszphy_config_init,
 	.config_intr	= kszphy_config_intr,
 	.handle_interrupt = kszphy_handle_interrupt,
 	.suspend	= kszphy_suspend,
 	.resume		= kszphy_resume,
+	},
 }, {
 	.phy_id		= PHY_ID_KSZ8021,
 	.phy_id_mask	= 0x00ffffff,
 	.name		= "Micrel KSZ8021 or KSZ8031",
 	/* PHY_BASIC_FEATURES */
 	.driver_data	= &ksz8021_type,
+	.ops		= &(const struct phy_driver_ops){
 	.probe		= kszphy_probe,
 	.config_init	= kszphy_config_init,
 	.config_intr	= kszphy_config_intr,
@@ -4654,12 +4657,14 @@ static struct phy_driver ksphy_driver[] = {
 	.get_stats	= kszphy_get_stats,
 	.suspend	= kszphy_suspend,
 	.resume		= kszphy_resume,
+	},
 }, {
 	.phy_id		= PHY_ID_KSZ8031,
 	.phy_id_mask	= 0x00ffffff,
 	.name		= "Micrel KSZ8031",
 	/* PHY_BASIC_FEATURES */
 	.driver_data	= &ksz8021_type,
+	.ops		= &(const struct phy_driver_ops){
 	.probe		= kszphy_probe,
 	.config_init	= kszphy_config_init,
 	.config_intr	= kszphy_config_intr,
@@ -4669,12 +4674,14 @@ static struct phy_driver ksphy_driver[] = {
 	.get_stats	= kszphy_get_stats,
 	.suspend	= kszphy_suspend,
 	.resume		= kszphy_resume,
+	},
 }, {
 	.phy_id		= PHY_ID_KSZ8041,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.name		= "Micrel KSZ8041",
 	/* PHY_BASIC_FEATURES */
 	.driver_data	= &ksz8041_type,
+	.ops		= &(const struct phy_driver_ops){
 	.probe		= kszphy_probe,
 	.config_init	= ksz8041_config_init,
 	.config_aneg	= ksz8041_config_aneg,
@@ -4686,12 +4693,14 @@ static struct phy_driver ksphy_driver[] = {
 	/* No suspend/resume callbacks because of errata DS80000700A,
 	 * receiver error following software power down.
 	 */
+	},
 }, {
 	.phy_id		= PHY_ID_KSZ8041RNLI,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.name		= "Micrel KSZ8041RNLI",
 	/* PHY_BASIC_FEATURES */
 	.driver_data	= &ksz8041_type,
+	.ops		= &(const struct phy_driver_ops){
 	.probe		= kszphy_probe,
 	.config_init	= kszphy_config_init,
 	.config_intr	= kszphy_config_intr,
@@ -4701,10 +4710,12 @@ static struct phy_driver ksphy_driver[] = {
 	.get_stats	= kszphy_get_stats,
 	.suspend	= kszphy_suspend,
 	.resume		= kszphy_resume,
+	},
 }, {
 	.name		= "Micrel KSZ8051",
 	/* PHY_BASIC_FEATURES */
 	.driver_data	= &ksz8051_type,
+	.ops		= &(const struct phy_driver_ops){
 	.probe		= kszphy_probe,
 	.config_init	= kszphy_config_init,
 	.config_intr	= kszphy_config_intr,
@@ -4715,12 +4726,14 @@ static struct phy_driver ksphy_driver[] = {
 	.match_phy_device = ksz8051_match_phy_device,
 	.suspend	= kszphy_suspend,
 	.resume		= kszphy_resume,
+	},
 }, {
 	.phy_id		= PHY_ID_KSZ8001,
 	.name		= "Micrel KSZ8001 or KS8721",
 	.phy_id_mask	= 0x00fffffc,
 	/* PHY_BASIC_FEATURES */
 	.driver_data	= &ksz8041_type,
+	.ops		= &(const struct phy_driver_ops){
 	.probe		= kszphy_probe,
 	.config_init	= kszphy_config_init,
 	.config_intr	= kszphy_config_intr,
@@ -4730,6 +4743,7 @@ static struct phy_driver ksphy_driver[] = {
 	.get_stats	= kszphy_get_stats,
 	.suspend	= kszphy_suspend,
 	.resume		= kszphy_resume,
+	},
 }, {
 	.phy_id		= PHY_ID_KSZ8081,
 	.name		= "Micrel KSZ8081 or KSZ8091",
@@ -4737,6 +4751,7 @@ static struct phy_driver ksphy_driver[] = {
 	.flags		= PHY_POLL_CABLE_TEST,
 	/* PHY_BASIC_FEATURES */
 	.driver_data	= &ksz8081_type,
+	.ops		= &(const struct phy_driver_ops){
 	.probe		= kszphy_probe,
 	.config_init	= ksz8081_config_init,
 	.soft_reset	= genphy_soft_reset,
@@ -4751,23 +4766,27 @@ static struct phy_driver ksphy_driver[] = {
 	.resume		= kszphy_resume,
 	.cable_test_start	= ksz886x_cable_test_start,
 	.cable_test_get_status	= ksz886x_cable_test_get_status,
+	},
 }, {
 	.phy_id		= PHY_ID_KSZ8061,
 	.name		= "Micrel KSZ8061",
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.probe		= kszphy_probe,
 	.config_init	= ksz8061_config_init,
 	.config_intr	= kszphy_config_intr,
 	.handle_interrupt = kszphy_handle_interrupt,
 	.suspend	= kszphy_suspend,
 	.resume		= kszphy_resume,
+	},
 }, {
 	.phy_id		= PHY_ID_KSZ9021,
 	.phy_id_mask	= 0x000ffffe,
 	.name		= "Micrel KSZ9021 Gigabit PHY",
 	/* PHY_GBIT_FEATURES */
 	.driver_data	= &ksz9021_type,
+	.ops		= &(const struct phy_driver_ops){
 	.probe		= kszphy_probe,
 	.get_features	= ksz9031_get_features,
 	.config_init	= ksz9021_config_init,
@@ -4780,12 +4799,14 @@ static struct phy_driver ksphy_driver[] = {
 	.resume		= kszphy_resume,
 	.read_mmd	= genphy_read_mmd_unsupported,
 	.write_mmd	= genphy_write_mmd_unsupported,
+	},
 }, {
 	.phy_id		= PHY_ID_KSZ9031,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.name		= "Micrel KSZ9031 Gigabit PHY",
 	.flags		= PHY_POLL_CABLE_TEST,
 	.driver_data	= &ksz9021_type,
+	.ops		= &(const struct phy_driver_ops){
 	.probe		= kszphy_probe,
 	.get_features	= ksz9031_get_features,
 	.config_init	= ksz9031_config_init,
@@ -4800,13 +4821,15 @@ static struct phy_driver ksphy_driver[] = {
 	.resume		= kszphy_resume,
 	.cable_test_start	= ksz9x31_cable_test_start,
 	.cable_test_get_status	= ksz9x31_cable_test_get_status,
+	},
 }, {
 	.phy_id		= PHY_ID_LAN8814,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.name		= "Microchip INDY Gigabit Quad PHY",
 	.flags          = PHY_POLL_CABLE_TEST,
-	.config_init	= lan8814_config_init,
 	.driver_data	= &lan8814_type,
+	.ops		= &(const struct phy_driver_ops){
+	.config_init	= lan8814_config_init,
 	.probe		= lan8814_probe,
 	.soft_reset	= genphy_soft_reset,
 	.read_status	= ksz9031_read_status,
@@ -4819,12 +4842,14 @@ static struct phy_driver ksphy_driver[] = {
 	.handle_interrupt = lan8814_handle_interrupt,
 	.cable_test_start	= lan8814_cable_test_start,
 	.cable_test_get_status	= ksz886x_cable_test_get_status,
+	},
 }, {
 	.phy_id		= PHY_ID_LAN8804,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.name		= "Microchip LAN966X Gigabit PHY",
-	.config_init	= lan8804_config_init,
 	.driver_data	= &ksz9021_type,
+	.ops		= &(const struct phy_driver_ops){
+	.config_init	= lan8804_config_init,
 	.probe		= kszphy_probe,
 	.soft_reset	= genphy_soft_reset,
 	.read_status	= ksz9031_read_status,
@@ -4835,12 +4860,14 @@ static struct phy_driver ksphy_driver[] = {
 	.resume		= kszphy_resume,
 	.config_intr	= lan8804_config_intr,
 	.handle_interrupt = lan8804_handle_interrupt,
+	},
 }, {
 	.phy_id		= PHY_ID_LAN8841,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.name		= "Microchip LAN8841 Gigabit PHY",
 	.flags		= PHY_POLL_CABLE_TEST,
 	.driver_data	= &lan8841_type,
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= lan8841_config_init,
 	.probe		= lan8841_probe,
 	.soft_reset	= genphy_soft_reset,
@@ -4853,6 +4880,7 @@ static struct phy_driver ksphy_driver[] = {
 	.resume		= genphy_resume,
 	.cable_test_start	= lan8814_cable_test_start,
 	.cable_test_get_status	= ksz886x_cable_test_get_status,
+	},
 }, {
 	.phy_id		= PHY_ID_KSZ9131,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
@@ -4860,6 +4888,7 @@ static struct phy_driver ksphy_driver[] = {
 	/* PHY_GBIT_FEATURES */
 	.flags		= PHY_POLL_CABLE_TEST,
 	.driver_data	= &ksz9131_type,
+	.ops		= &(const struct phy_driver_ops){
 	.probe		= kszphy_probe,
 	.soft_reset	= genphy_soft_reset,
 	.config_init	= ksz9131_config_init,
@@ -4875,16 +4904,19 @@ static struct phy_driver ksphy_driver[] = {
 	.cable_test_start	= ksz9x31_cable_test_start,
 	.cable_test_get_status	= ksz9x31_cable_test_get_status,
 	.get_features	= ksz9477_get_features,
+	},
 }, {
 	.phy_id		= PHY_ID_KSZ8873MLL,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.name		= "Micrel KSZ8873MLL Switch",
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= kszphy_config_init,
 	.config_aneg	= ksz8873mll_config_aneg,
 	.read_status	= ksz8873mll_read_status,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	},
 }, {
 	.phy_id		= PHY_ID_KSZ886X,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
@@ -4892,6 +4924,7 @@ static struct phy_driver ksphy_driver[] = {
 	.driver_data	= &ksz886x_type,
 	/* PHY_BASIC_FEATURES */
 	.flags		= PHY_POLL_CABLE_TEST,
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= kszphy_config_init,
 	.config_aneg	= ksz886x_config_aneg,
 	.read_status	= ksz886x_read_status,
@@ -4899,24 +4932,29 @@ static struct phy_driver ksphy_driver[] = {
 	.resume		= genphy_resume,
 	.cable_test_start	= ksz886x_cable_test_start,
 	.cable_test_get_status	= ksz886x_cable_test_get_status,
+	},
 }, {
 	.name		= "Micrel KSZ87XX Switch",
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= kszphy_config_init,
 	.match_phy_device = ksz8795_match_phy_device,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	},
 }, {
 	.phy_id		= PHY_ID_KSZ9477,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.name		= "Microchip KSZ9477",
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= ksz9477_config_init,
 	.config_intr	= kszphy_config_intr,
 	.handle_interrupt = kszphy_handle_interrupt,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 	.get_features	= ksz9477_get_features,
+	},
 } };
 
 module_phy_driver(ksphy_driver);
diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index 0b88635f4fbc..aa0e720cfb6b 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -384,6 +384,7 @@ static struct phy_driver microchip_phy_driver[] = {
 	.name		= "Microchip LAN88xx",
 
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 
 	.probe		= lan88xx_probe,
 	.remove		= lan88xx_remove,
@@ -400,6 +401,7 @@ static struct phy_driver microchip_phy_driver[] = {
 	.set_wol	= lan88xx_set_wol,
 	.read_page	= lan88xx_read_page,
 	.write_page	= lan88xx_write_page,
+	},
 } };
 
 module_phy_driver(microchip_phy_driver);
diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index a838b61cd844..df9eb70c998e 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -866,6 +866,7 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 		.name           = "Microchip LAN87xx T1",
 		.flags          = PHY_POLL_CABLE_TEST,
 		.features       = PHY_BASIC_T1_FEATURES,
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= lan87xx_config_init,
 		.config_intr    = lan87xx_phy_config_intr,
 		.handle_interrupt = lan87xx_handle_interrupt,
@@ -877,12 +878,14 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 		.get_sqi_max	= lan87xx_get_sqi_max,
 		.cable_test_start = lan87xx_cable_test_start,
 		.cable_test_get_status = lan87xx_cable_test_get_status,
+		},
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_LAN937X),
 		.name		= "Microchip LAN937x T1",
 		.flags          = PHY_POLL_CABLE_TEST,
 		.features	= PHY_BASIC_T1_FEATURES,
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= lan87xx_config_init,
 		.config_intr    = lan87xx_phy_config_intr,
 		.handle_interrupt = lan87xx_handle_interrupt,
@@ -894,6 +897,7 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 		.get_sqi_max	= lan87xx_get_sqi_max,
 		.cable_test_start = lan87xx_cable_test_start,
 		.cable_test_get_status = lan87xx_cable_test_get_status,
+		},
 	}
 };
 
diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 534ca7d1b061..17b99f1ed090 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -273,21 +273,25 @@ static struct phy_driver microchip_t1s_driver[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1),
 		.name               = "LAN867X Rev.B1",
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
+		.ops                = &(const struct phy_driver_ops){
 		.config_init        = lan867x_revb1_config_init,
 		.read_status        = lan86xx_read_status,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
+		},
 	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB0),
 		.name               = "LAN865X Rev.B0 Internal Phy",
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
+		.ops                = &(const struct phy_driver_ops){
 		.config_init        = lan865x_revb0_config_init,
 		.read_status        = lan86xx_read_status,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
+		},
 	},
 };
 
diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 7a11fdb687cc..22d6bbc876e7 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -2256,15 +2256,18 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_YT8511),
 		.name		= "YT8511 Gigabit Ethernet",
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= yt8511_config_init,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.read_page	= yt8511_read_page,
 		.write_page	= yt8511_write_page,
+		},
 	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_YT8521),
 		.name		= "YT8521 Gigabit Ethernet",
+		.ops		= &(const struct phy_driver_ops){
 		.get_features	= yt8521_get_features,
 		.probe		= yt8521_probe,
 		.read_page	= yt8521_read_page,
@@ -2278,10 +2281,12 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 		.soft_reset	= yt8521_soft_reset,
 		.suspend	= yt8521_suspend,
 		.resume		= yt8521_resume,
+		},
 	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_YT8531),
 		.name		= "YT8531 Gigabit Ethernet",
+		.ops		= &(const struct phy_driver_ops){
 		.probe		= yt8531_probe,
 		.config_init	= yt8531_config_init,
 		.suspend	= genphy_suspend,
@@ -2289,10 +2294,12 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 		.get_wol	= ytphy_get_wol,
 		.set_wol	= yt8531_set_wol,
 		.link_change_notify = yt8531_link_change_notify,
+		},
 	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_YT8531S),
 		.name		= "YT8531S Gigabit Ethernet",
+		.ops		= &(const struct phy_driver_ops){
 		.get_features	= yt8521_get_features,
 		.probe		= yt8521_probe,
 		.read_page	= yt8521_read_page,
@@ -2306,6 +2313,7 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 		.soft_reset	= yt8521_soft_reset,
 		.suspend	= yt8521_suspend,
 		.resume		= yt8521_resume,
+		},
 	},
 };
 
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 6f74ce0ab1aa..923aa45a61f7 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -2342,6 +2342,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.name		= "Microsemi GE VSC8501 SyncE",
 	.phy_id_mask	= 0xfffffff0,
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.soft_reset	= &genphy_soft_reset,
 	.config_init	= &vsc85xx_config_init,
 	.config_aneg    = &vsc85xx_config_aneg,
@@ -2360,12 +2361,14 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	},
 },
 {
 	.phy_id		= PHY_ID_VSC8502,
 	.name		= "Microsemi GE VSC8502 SyncE",
 	.phy_id_mask	= 0xfffffff0,
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.soft_reset	= &genphy_soft_reset,
 	.config_init	= &vsc85xx_config_init,
 	.config_aneg    = &vsc85xx_config_aneg,
@@ -2384,12 +2387,14 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	},
 },
 {
 	.phy_id		= PHY_ID_VSC8504,
 	.name		= "Microsemi GE VSC8504 SyncE",
 	.phy_id_mask	= 0xfffffff0,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc8584_config_init,
 	.config_aneg    = &vsc85xx_config_aneg,
@@ -2409,11 +2414,13 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	},
 },
 {
 	.phy_id		= PHY_ID_VSC8514,
 	.name		= "Microsemi GE VSC8514 SyncE",
 	.phy_id_mask	= 0xfffffff0,
+	.ops		= &(const struct phy_driver_ops){
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc8514_config_init,
 	.config_aneg    = &vsc85xx_config_aneg,
@@ -2432,12 +2439,14 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	},
 },
 {
 	.phy_id		= PHY_ID_VSC8530,
 	.name		= "Microsemi FE VSC8530",
 	.phy_id_mask	= 0xfffffff0,
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.soft_reset	= &genphy_soft_reset,
 	.config_init	= &vsc85xx_config_init,
 	.config_aneg    = &vsc85xx_config_aneg,
@@ -2456,12 +2465,14 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	},
 },
 {
 	.phy_id		= PHY_ID_VSC8531,
 	.name		= "Microsemi VSC8531",
 	.phy_id_mask    = 0xfffffff0,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc85xx_config_init,
 	.config_aneg    = &vsc85xx_config_aneg,
@@ -2480,12 +2491,14 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	},
 },
 {
 	.phy_id		= PHY_ID_VSC8540,
 	.name		= "Microsemi FE VSC8540 SyncE",
 	.phy_id_mask	= 0xfffffff0,
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.soft_reset	= &genphy_soft_reset,
 	.config_init	= &vsc85xx_config_init,
 	.config_aneg	= &vsc85xx_config_aneg,
@@ -2504,12 +2517,14 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	},
 },
 {
 	.phy_id		= PHY_ID_VSC8541,
 	.name		= "Microsemi VSC8541 SyncE",
 	.phy_id_mask    = 0xfffffff0,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc85xx_config_init,
 	.config_aneg    = &vsc85xx_config_aneg,
@@ -2528,12 +2543,14 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	},
 },
 {
 	.phy_id		= PHY_ID_VSC8552,
 	.name		= "Microsemi GE VSC8552 SyncE",
 	.phy_id_mask	= 0xfffffff0,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc8584_config_init,
 	.config_aneg    = &vsc85xx_config_aneg,
@@ -2552,12 +2569,14 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	},
 },
 {
 	.phy_id		= PHY_ID_VSC856X,
 	.name		= "Microsemi GE VSC856X SyncE",
 	.phy_id_mask	= 0xfffffff0,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc8584_config_init,
 	.config_aneg    = &vsc85xx_config_aneg,
@@ -2574,12 +2593,14 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	},
 },
 {
 	.phy_id		= PHY_ID_VSC8572,
 	.name		= "Microsemi GE VSC8572 SyncE",
 	.phy_id_mask	= 0xfffffff0,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc8584_config_init,
 	.config_aneg    = &vsc85xx_config_aneg,
@@ -2599,12 +2620,14 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	},
 },
 {
 	.phy_id		= PHY_ID_VSC8574,
 	.name		= "Microsemi GE VSC8574 SyncE",
 	.phy_id_mask	= 0xfffffff0,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc8584_config_init,
 	.config_aneg    = &vsc85xx_config_aneg,
@@ -2624,12 +2647,14 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	},
 },
 {
 	.phy_id		= PHY_ID_VSC8575,
 	.name		= "Microsemi GE VSC8575 SyncE",
 	.phy_id_mask	= 0xfffffff0,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc8584_config_init,
 	.config_aneg    = &vsc85xx_config_aneg,
@@ -2647,12 +2672,14 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	},
 },
 {
 	.phy_id		= PHY_ID_VSC8582,
 	.name		= "Microsemi GE VSC8582 SyncE",
 	.phy_id_mask	= 0xfffffff0,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc8584_config_init,
 	.config_aneg    = &vsc85xx_config_aneg,
@@ -2670,12 +2697,14 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	},
 },
 {
 	.phy_id		= PHY_ID_VSC8584,
 	.name		= "Microsemi GE VSC8584 SyncE",
 	.phy_id_mask	= 0xfffffff0,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc8584_config_init,
 	.config_aneg    = &vsc85xx_config_aneg,
@@ -2694,6 +2723,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
 	.link_change_notify = &vsc85xx_link_change_notify,
+	},
 }
 
 };
diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index ea1073adc5a1..5ac5f03fb7ce 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -813,6 +813,7 @@ static struct phy_driver gpy_drivers[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY2xx),
 		.name		= "Maxlinear Ethernet GPY2xx",
+		.ops		= &(const struct phy_driver_ops){
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy_config_init,
 		.probe		= gpy_probe,
@@ -826,11 +827,13 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		},
 	},
 	{
 		.phy_id		= PHY_ID_GPY115B,
 		.phy_id_mask	= PHY_ID_GPYx15B_MASK,
 		.name		= "Maxlinear Ethernet GPY115B",
+		.ops		= &(const struct phy_driver_ops){
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy_config_init,
 		.probe		= gpy_probe,
@@ -844,10 +847,12 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy115_loopback,
+		},
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY115C),
 		.name		= "Maxlinear Ethernet GPY115C",
+		.ops		= &(const struct phy_driver_ops){
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy_config_init,
 		.probe		= gpy_probe,
@@ -861,11 +866,13 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy115_loopback,
+		},
 	},
 	{
 		.phy_id		= PHY_ID_GPY211B,
 		.phy_id_mask	= PHY_ID_GPY21xB_MASK,
 		.name		= "Maxlinear Ethernet GPY211B",
+		.ops		= &(const struct phy_driver_ops){
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy_config_init,
 		.probe		= gpy_probe,
@@ -879,10 +886,12 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		},
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY211C),
 		.name		= "Maxlinear Ethernet GPY211C",
+		.ops		= &(const struct phy_driver_ops){
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy_config_init,
 		.probe		= gpy_probe,
@@ -896,11 +905,13 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		},
 	},
 	{
 		.phy_id		= PHY_ID_GPY212B,
 		.phy_id_mask	= PHY_ID_GPY21xB_MASK,
 		.name		= "Maxlinear Ethernet GPY212B",
+		.ops		= &(const struct phy_driver_ops){
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy_config_init,
 		.probe		= gpy_probe,
@@ -914,10 +925,12 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		},
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY212C),
 		.name		= "Maxlinear Ethernet GPY212C",
+		.ops		= &(const struct phy_driver_ops){
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy_config_init,
 		.probe		= gpy_probe,
@@ -931,11 +944,13 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		},
 	},
 	{
 		.phy_id		= PHY_ID_GPY215B,
 		.phy_id_mask	= PHY_ID_GPYx15B_MASK,
 		.name		= "Maxlinear Ethernet GPY215B",
+		.ops		= &(const struct phy_driver_ops){
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy_config_init,
 		.probe		= gpy_probe,
@@ -949,10 +964,12 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		},
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY215C),
 		.name		= "Maxlinear Ethernet GPY215C",
+		.ops		= &(const struct phy_driver_ops){
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy_config_init,
 		.probe		= gpy_probe,
@@ -966,10 +983,12 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		},
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY241B),
 		.name		= "Maxlinear Ethernet GPY241B",
+		.ops		= &(const struct phy_driver_ops){
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy_config_init,
 		.probe		= gpy_probe,
@@ -983,10 +1002,12 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		},
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY241BM),
 		.name		= "Maxlinear Ethernet GPY241BM",
+		.ops		= &(const struct phy_driver_ops){
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy_config_init,
 		.probe		= gpy_probe,
@@ -1000,10 +1021,12 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		},
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY245B),
 		.name		= "Maxlinear Ethernet GPY245B",
+		.ops		= &(const struct phy_driver_ops){
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy_config_init,
 		.probe		= gpy_probe,
@@ -1017,6 +1040,7 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		},
 	},
 };
 module_phy_driver(gpy_drivers);
diff --git a/drivers/net/phy/national.c b/drivers/net/phy/national.c
index 9ae9cc6b23c2..acdf6477b304 100644
--- a/drivers/net/phy/national.c
+++ b/drivers/net/phy/national.c
@@ -162,9 +162,11 @@ static struct phy_driver dp83865_driver[] = { {
 	.phy_id_mask = 0xfffffff0,
 	.name = "NatSemi DP83865",
 	/* PHY_GBIT_FEATURES */
+	.ops = &(const struct phy_driver_ops){
 	.config_init = ns_config_init,
 	.config_intr = ns_config_intr,
 	.handle_interrupt = ns_handle_interrupt,
+	},
 } };
 
 module_phy_driver(dp83865_driver);
diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
index 5680584f659e..56fae7e36611 100644
--- a/drivers/net/phy/ncn26000.c
+++ b/drivers/net/phy/ncn26000.c
@@ -145,6 +145,7 @@ static struct phy_driver ncn26000_driver[] = {
 		PHY_ID_MATCH_MODEL(PHY_ID_NCN26000),
 		.name			= "NCN26000",
 		.features		= PHY_BASIC_T1S_P2MP_FEATURES,
+		.ops			= &(const struct phy_driver_ops){
 		.config_init            = ncn26000_config_init,
 		.config_intr            = ncn26000_config_intr,
 		.config_aneg		= ncn26000_config_aneg,
@@ -154,6 +155,7 @@ static struct phy_driver ncn26000_driver[] = {
 		.set_plca_cfg		= genphy_c45_plca_set_cfg,
 		.get_plca_status	= genphy_c45_plca_get_status,
 		.soft_reset             = genphy_soft_reset,
+		},
 	},
 };
 
diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 3cf614b4cd52..4cd410d56277 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1929,8 +1929,9 @@ static struct phy_driver nxp_c45_driver[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103),
 		.name			= "NXP C45 TJA1103",
-		.get_features		= nxp_c45_get_features,
 		.driver_data		= &tja1103_phy_data,
+		.ops			= &(const struct phy_driver_ops){
+		.get_features		= nxp_c45_get_features,
 		.probe			= nxp_c45_probe,
 		.soft_reset		= nxp_c45_soft_reset,
 		.config_aneg		= genphy_c45_config_aneg,
@@ -1949,12 +1950,14 @@ static struct phy_driver nxp_c45_driver[] = {
 		.get_sqi		= nxp_c45_get_sqi,
 		.get_sqi_max		= nxp_c45_get_sqi_max,
 		.remove			= nxp_c45_remove,
+		},
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1120),
 		.name			= "NXP C45 TJA1120",
-		.get_features		= nxp_c45_get_features,
 		.driver_data		= &tja1120_phy_data,
+		.ops			= &(const struct phy_driver_ops){
+		.get_features		= nxp_c45_get_features,
 		.probe			= nxp_c45_probe,
 		.soft_reset		= nxp_c45_soft_reset,
 		.config_aneg		= genphy_c45_config_aneg,
@@ -1974,6 +1977,7 @@ static struct phy_driver nxp_c45_driver[] = {
 		.get_sqi		= nxp_c45_get_sqi,
 		.get_sqi_max		= nxp_c45_get_sqi_max,
 		.remove			= nxp_c45_remove,
+		},
 	},
 };
 
diff --git a/drivers/net/phy/nxp-cbtx.c b/drivers/net/phy/nxp-cbtx.c
index 145703f0a406..5f2b6513d2ad 100644
--- a/drivers/net/phy/nxp-cbtx.c
+++ b/drivers/net/phy/nxp-cbtx.c
@@ -199,6 +199,7 @@ static struct phy_driver cbtx_driver[] = {
 		PHY_ID_MATCH_MODEL(PHY_ID_CBTX_SJA1110),
 		.name			= "NXP CBTX (SJA1110)",
 		/* PHY_BASIC_FEATURES */
+		.ops			= &(const struct phy_driver_ops){
 		.soft_reset		= cbtx_soft_reset,
 		.config_init		= cbtx_config_init,
 		.suspend		= genphy_suspend,
@@ -210,6 +211,7 @@ static struct phy_driver cbtx_driver[] = {
 		.get_sset_count		= cbtx_get_sset_count,
 		.get_strings		= cbtx_get_strings,
 		.get_stats		= cbtx_get_stats,
+		},
 	},
 };
 
diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
index 2c263ae44b4f..66e0f9fca2da 100644
--- a/drivers/net/phy/nxp-tja11xx.c
+++ b/drivers/net/phy/nxp-tja11xx.c
@@ -205,22 +205,22 @@ static int tja11xx_config_aneg_cable_test(struct phy_device *phydev)
 	if (phydev->link)
 		return 0;
 
-	if (!phydev->drv->cable_test_start ||
-	    !phydev->drv->cable_test_get_status)
+	if (!phydev->drv->ops->cable_test_start ||
+	    !phydev->drv->ops->cable_test_get_status)
 		return 0;
 
 	ret = ethnl_cable_test_alloc(phydev, ETHTOOL_MSG_CABLE_TEST_NTF);
 	if (ret)
 		return ret;
 
-	ret = phydev->drv->cable_test_start(phydev);
+	ret = phydev->drv->ops->cable_test_start(phydev);
 	if (ret)
 		return ret;
 
 	/* According to the documentation this test takes 100 usec */
 	usleep_range(100, 200);
 
-	ret = phydev->drv->cable_test_get_status(phydev, &finished);
+	ret = phydev->drv->ops->cable_test_get_status(phydev, &finished);
 	if (ret)
 		return ret;
 
@@ -805,6 +805,7 @@ static struct phy_driver tja11xx_driver[] = {
 		PHY_ID_MATCH_MODEL(PHY_ID_TJA1100),
 		.name		= "NXP TJA1100",
 		.features       = PHY_BASIC_T1_FEATURES,
+		.ops		= &(const struct phy_driver_ops){
 		.probe		= tja11xx_probe,
 		.soft_reset	= tja11xx_soft_reset,
 		.config_aneg	= tja11xx_config_aneg,
@@ -819,10 +820,12 @@ static struct phy_driver tja11xx_driver[] = {
 		.get_sset_count = tja11xx_get_sset_count,
 		.get_strings	= tja11xx_get_strings,
 		.get_stats	= tja11xx_get_stats,
+		},
 	}, {
 		PHY_ID_MATCH_MODEL(PHY_ID_TJA1101),
 		.name		= "NXP TJA1101",
 		.features       = PHY_BASIC_T1_FEATURES,
+		.ops		= &(const struct phy_driver_ops){
 		.probe		= tja11xx_probe,
 		.soft_reset	= tja11xx_soft_reset,
 		.config_aneg	= tja11xx_config_aneg,
@@ -837,10 +840,12 @@ static struct phy_driver tja11xx_driver[] = {
 		.get_sset_count = tja11xx_get_sset_count,
 		.get_strings	= tja11xx_get_strings,
 		.get_stats	= tja11xx_get_stats,
+		},
 	}, {
 		.name		= "NXP TJA1102 Port 0",
 		.features       = PHY_BASIC_T1_FEATURES,
 		.flags          = PHY_POLL_CABLE_TEST,
+		.ops		= &(const struct phy_driver_ops){
 		.probe		= tja1102_p0_probe,
 		.soft_reset	= tja11xx_soft_reset,
 		.config_aneg	= tja11xx_config_aneg,
@@ -860,11 +865,13 @@ static struct phy_driver tja11xx_driver[] = {
 		.handle_interrupt = tja11xx_handle_interrupt,
 		.cable_test_start = tja11xx_cable_test_start,
 		.cable_test_get_status = tja11xx_cable_test_get_status,
+		},
 	}, {
 		.name		= "NXP TJA1102 Port 1",
 		.features       = PHY_BASIC_T1_FEATURES,
 		.flags          = PHY_POLL_CABLE_TEST,
 		/* currently no probe for Port 1 is need */
+		.ops		= &(const struct phy_driver_ops){
 		.soft_reset	= tja11xx_soft_reset,
 		.config_aneg	= tja11xx_config_aneg,
 		.config_init	= tja11xx_config_init,
@@ -883,6 +890,7 @@ static struct phy_driver tja11xx_driver[] = {
 		.handle_interrupt = tja11xx_handle_interrupt,
 		.cable_test_start = tja11xx_cable_test_start,
 		.cable_test_get_status = tja11xx_cable_test_get_status,
+		},
 	}
 };
 
diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 46c87a903efd..9e7e72062335 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1522,5 +1522,7 @@ struct phy_driver genphy_c45_driver = {
 	.phy_id         = 0xffffffff,
 	.phy_id_mask    = 0xffffffff,
 	.name           = "Generic Clause 45 PHY",
+	.ops		= &(const struct phy_driver_ops){
 	.read_status    = genphy_c45_read_status,
+	},
 };
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 15f349e5995a..0dcd8d5934ef 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -576,8 +576,8 @@ int __phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum)
 	if (regnum > (u16)~0 || devad > 32)
 		return -EINVAL;
 
-	if (phydev->drv && phydev->drv->read_mmd)
-		return phydev->drv->read_mmd(phydev, devad, regnum);
+	if (phydev->drv && phydev->drv->ops && phydev->drv->ops->read_mmd)
+		return phydev->drv->ops->read_mmd(phydev, devad, regnum);
 
 	return mmd_phy_read(phydev->mdio.bus, phydev->mdio.addr,
 			    phydev->is_c45, devad, regnum);
@@ -620,8 +620,8 @@ int __phy_write_mmd(struct phy_device *phydev, int devad, u32 regnum, u16 val)
 	if (regnum > (u16)~0 || devad > 32)
 		return -EINVAL;
 
-	if (phydev->drv && phydev->drv->write_mmd)
-		return phydev->drv->write_mmd(phydev, devad, regnum, val);
+	if (phydev->drv && phydev->drv->ops && phydev->drv->ops->write_mmd)
+		return phydev->drv->ops->write_mmd(phydev, devad, regnum, val);
 
 	return mmd_phy_write(phydev->mdio.bus, phydev->mdio.addr,
 			     phydev->is_c45, devad, regnum, val);
@@ -968,18 +968,20 @@ EXPORT_SYMBOL_GPL(phy_modify_mmd);
 
 static int __phy_read_page(struct phy_device *phydev)
 {
-	if (WARN_ONCE(!phydev->drv->read_page, "read_page callback not available, PHY driver not loaded?\n"))
+	if (WARN_ONCE(!phydev->drv->ops || !phydev->drv->ops->read_page,
+		      "read_page callback not available, PHY driver not loaded?\n"))
 		return -EOPNOTSUPP;
 
-	return phydev->drv->read_page(phydev);
+	return phydev->drv->ops->read_page(phydev);
 }
 
 static int __phy_write_page(struct phy_device *phydev, int page)
 {
-	if (WARN_ONCE(!phydev->drv->write_page, "write_page callback not available, PHY driver not loaded?\n"))
+	if (WARN_ONCE(!phydev->drv->ops || !phydev->drv->ops->write_page,
+		      "write_page callback not available, PHY driver not loaded?\n"))
 		return -EOPNOTSUPP;
 
-	return phydev->drv->write_page(phydev, page);
+	return phydev->drv->ops->write_page(phydev, page);
 }
 
 /**
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 14224e06d69f..185a8c60de54 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -65,8 +65,9 @@ static void phy_process_state_change(struct phy_device *phydev,
 		phydev_dbg(phydev, "PHY state change %s -> %s\n",
 			   phy_state_to_str(old_state),
 			   phy_state_to_str(phydev->state));
-		if (phydev->drv && phydev->drv->link_change_notify)
-			phydev->drv->link_change_notify(phydev);
+		if (phydev->drv && phydev->drv->ops &&
+		    phydev->drv->ops->link_change_notify)
+			phydev->drv->ops->link_change_notify(phydev);
 	}
 }
 
@@ -145,9 +146,9 @@ int phy_get_rate_matching(struct phy_device *phydev,
 {
 	int ret = RATE_MATCH_NONE;
 
-	if (phydev->drv->get_rate_matching) {
+	if (phydev->drv->ops && phydev->drv->ops->get_rate_matching) {
 		mutex_lock(&phydev->lock);
-		ret = phydev->drv->get_rate_matching(phydev, iface);
+		ret = phydev->drv->ops->get_rate_matching(phydev, iface);
 		mutex_unlock(&phydev->lock);
 	}
 
@@ -165,8 +166,8 @@ EXPORT_SYMBOL_GPL(phy_get_rate_matching);
 static int phy_config_interrupt(struct phy_device *phydev, bool interrupts)
 {
 	phydev->interrupts = interrupts ? 1 : 0;
-	if (phydev->drv->config_intr)
-		return phydev->drv->config_intr(phydev);
+	if (phydev->drv->ops && phydev->drv->ops->config_intr)
+		return phydev->drv->ops->config_intr(phydev);
 
 	return 0;
 }
@@ -201,8 +202,8 @@ EXPORT_SYMBOL_GPL(phy_restart_aneg);
  */
 int phy_aneg_done(struct phy_device *phydev)
 {
-	if (phydev->drv && phydev->drv->aneg_done)
-		return phydev->drv->aneg_done(phydev);
+	if (phydev->drv && phydev->drv->ops && phydev->drv->ops->aneg_done)
+		return phydev->drv->ops->aneg_done(phydev);
 	else if (phydev->is_c45)
 		return genphy_c45_aneg_done(phydev);
 	else
@@ -552,11 +553,11 @@ static void phy_abort_cable_test(struct phy_device *phydev)
  */
 int phy_ethtool_get_strings(struct phy_device *phydev, u8 *data)
 {
-	if (!phydev->drv)
+	if (!phydev->drv || !phydev->drv->ops)
 		return -EIO;
 
 	mutex_lock(&phydev->lock);
-	phydev->drv->get_strings(phydev, data);
+	phydev->drv->ops->get_strings(phydev, data);
 	mutex_unlock(&phydev->lock);
 
 	return 0;
@@ -572,14 +573,14 @@ int phy_ethtool_get_sset_count(struct phy_device *phydev)
 {
 	int ret;
 
-	if (!phydev->drv)
+	if (!phydev->drv || !phydev->drv->ops)
 		return -EIO;
 
-	if (phydev->drv->get_sset_count &&
-	    phydev->drv->get_strings &&
-	    phydev->drv->get_stats) {
+	if (phydev->drv->ops->get_sset_count &&
+	    phydev->drv->ops->get_strings &&
+	    phydev->drv->ops->get_stats) {
 		mutex_lock(&phydev->lock);
-		ret = phydev->drv->get_sset_count(phydev);
+		ret = phydev->drv->ops->get_sset_count(phydev);
 		mutex_unlock(&phydev->lock);
 
 		return ret;
@@ -599,11 +600,11 @@ EXPORT_SYMBOL(phy_ethtool_get_sset_count);
 int phy_ethtool_get_stats(struct phy_device *phydev,
 			  struct ethtool_stats *stats, u64 *data)
 {
-	if (!phydev->drv)
+	if (!phydev->drv || !phydev->drv->ops)
 		return -EIO;
 
 	mutex_lock(&phydev->lock);
-	phydev->drv->get_stats(phydev, stats, data);
+	phydev->drv->ops->get_stats(phydev, stats, data);
 	mutex_unlock(&phydev->lock);
 
 	return 0;
@@ -628,13 +629,13 @@ int phy_ethtool_get_plca_cfg(struct phy_device *phydev,
 		goto out;
 	}
 
-	if (!phydev->drv->get_plca_cfg) {
+	if (!phydev->drv->ops || phydev->drv->ops->get_plca_cfg) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
 
 	mutex_lock(&phydev->lock);
-	ret = phydev->drv->get_plca_cfg(phydev, plca_cfg);
+	ret = phydev->drv->ops->get_plca_cfg(phydev, plca_cfg);
 
 	mutex_unlock(&phydev->lock);
 out:
@@ -691,8 +692,9 @@ int phy_ethtool_set_plca_cfg(struct phy_device *phydev,
 		goto out;
 	}
 
-	if (!phydev->drv->set_plca_cfg ||
-	    !phydev->drv->get_plca_cfg) {
+	if (!phydev->drv->ops ||
+	    !phydev->drv->ops->set_plca_cfg ||
+	    !phydev->drv->ops->get_plca_cfg) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
@@ -705,7 +707,7 @@ int phy_ethtool_set_plca_cfg(struct phy_device *phydev,
 
 	mutex_lock(&phydev->lock);
 
-	ret = phydev->drv->get_plca_cfg(phydev, curr_plca_cfg);
+	ret = phydev->drv->ops->get_plca_cfg(phydev, curr_plca_cfg);
 	if (ret)
 		goto out_drv;
 
@@ -762,7 +764,7 @@ int phy_ethtool_set_plca_cfg(struct phy_device *phydev,
 			goto out_drv;
 	}
 
-	ret = phydev->drv->set_plca_cfg(phydev, plca_cfg);
+	ret = phydev->drv->ops->set_plca_cfg(phydev, plca_cfg);
 
 out_drv:
 	kfree(curr_plca_cfg);
@@ -789,13 +791,14 @@ int phy_ethtool_get_plca_status(struct phy_device *phydev,
 		goto out;
 	}
 
-	if (!phydev->drv->get_plca_status) {
+	if (!phydev->drv->ops ||
+	    !phydev->drv->ops->get_plca_status) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
 
 	mutex_lock(&phydev->lock);
-	ret = phydev->drv->get_plca_status(phydev, plca_st);
+	ret = phydev->drv->ops->get_plca_status(phydev, plca_st);
 
 	mutex_unlock(&phydev->lock);
 out:
@@ -814,9 +817,9 @@ int phy_start_cable_test(struct phy_device *phydev,
 	struct net_device *dev = phydev->attached_dev;
 	int err = -ENOMEM;
 
-	if (!(phydev->drv &&
-	      phydev->drv->cable_test_start &&
-	      phydev->drv->cable_test_get_status)) {
+	if (!(phydev->drv && phydev->drv->ops &&
+	      phydev->drv->ops->cable_test_start &&
+	      phydev->drv->ops->cable_test_get_status)) {
 		NL_SET_ERR_MSG(extack,
 			       "PHY driver does not support cable testing");
 		return -EOPNOTSUPP;
@@ -846,7 +849,7 @@ int phy_start_cable_test(struct phy_device *phydev,
 	phy_link_down(phydev);
 
 	netif_testing_on(dev);
-	err = phydev->drv->cable_test_start(phydev);
+	err = phydev->drv->ops->cable_test_start(phydev);
 	if (err) {
 		netif_testing_off(dev);
 		phy_link_up(phydev);
@@ -885,9 +888,9 @@ int phy_start_cable_test_tdr(struct phy_device *phydev,
 	struct net_device *dev = phydev->attached_dev;
 	int err = -ENOMEM;
 
-	if (!(phydev->drv &&
-	      phydev->drv->cable_test_tdr_start &&
-	      phydev->drv->cable_test_get_status)) {
+	if (!(phydev->drv && phydev->drv->ops &&
+	      phydev->drv->ops->cable_test_tdr_start &&
+	      phydev->drv->ops->cable_test_get_status)) {
 		NL_SET_ERR_MSG(extack,
 			       "PHY driver does not support cable test TDR");
 		return -EOPNOTSUPP;
@@ -917,7 +920,7 @@ int phy_start_cable_test_tdr(struct phy_device *phydev,
 	phy_link_down(phydev);
 
 	netif_testing_on(dev);
-	err = phydev->drv->cable_test_tdr_start(phydev, config);
+	err = phydev->drv->ops->cable_test_tdr_start(phydev, config);
 	if (err) {
 		netif_testing_off(dev);
 		phy_link_up(phydev);
@@ -944,8 +947,8 @@ EXPORT_SYMBOL(phy_start_cable_test_tdr);
 
 int phy_config_aneg(struct phy_device *phydev)
 {
-	if (phydev->drv->config_aneg)
-		return phydev->drv->config_aneg(phydev);
+	if (phydev->drv->ops && phydev->drv->ops->config_aneg)
+		return phydev->drv->ops->config_aneg(phydev);
 
 	/* Clause 45 PHYs that don't implement Clause 22 registers are not
 	 * allowed to call genphy_config_aneg()
@@ -1315,7 +1318,7 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 	}
 
 	mutex_lock(&phydev->lock);
-	ret = phydev->drv->handle_interrupt(phydev);
+	ret = phydev->drv->ops->handle_interrupt(phydev);
 	mutex_unlock(&phydev->lock);
 
 	return ret;
@@ -1401,7 +1404,7 @@ static enum phy_state_work _phy_state_machine(struct phy_device *phydev)
 		func = &phy_check_link_status;
 		break;
 	case PHY_CABLETEST:
-		err = phydev->drv->cable_test_get_status(phydev, &finished);
+		err = phydev->drv->ops->cable_test_get_status(phydev, &finished);
 		if (err) {
 			phy_abort_cable_test(phydev);
 			netif_testing_off(dev);
@@ -1683,9 +1686,9 @@ int phy_ethtool_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
 {
 	int ret;
 
-	if (phydev->drv && phydev->drv->set_wol) {
+	if (phydev->drv && phydev->drv->ops && phydev->drv->ops->set_wol) {
 		mutex_lock(&phydev->lock);
-		ret = phydev->drv->set_wol(phydev, wol);
+		ret = phydev->drv->ops->set_wol(phydev, wol);
 		mutex_unlock(&phydev->lock);
 
 		return ret;
@@ -1703,9 +1706,9 @@ EXPORT_SYMBOL(phy_ethtool_set_wol);
  */
 void phy_ethtool_get_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
 {
-	if (phydev->drv && phydev->drv->get_wol) {
+	if (phydev->drv && phydev->drv->ops && phydev->drv->ops->get_wol) {
 		mutex_lock(&phydev->lock);
-		phydev->drv->get_wol(phydev, wol);
+		phydev->drv->ops->get_wol(phydev, wol);
 		mutex_unlock(&phydev->lock);
 	}
 }
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index d63dca535746..2f4e28416726 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -274,7 +274,7 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 	struct phy_driver *phydrv = to_phy_driver(drv);
 	struct net_device *netdev = phydev->attached_dev;
 
-	if (!drv || !phydrv->suspend)
+	if (!drv || !phydrv->ops || !phydrv->ops->suspend)
 		return false;
 
 	/* PHY not attached? May suspend if the PHY has not already been
@@ -532,8 +532,8 @@ static int phy_bus_match(struct device *dev, struct device_driver *drv)
 	if (!(phydrv->mdiodrv.flags & MDIO_DEVICE_IS_PHY))
 		return 0;
 
-	if (phydrv->match_phy_device)
-		return phydrv->match_phy_device(phydev);
+	if (phydrv->ops && phydrv->ops->match_phy_device)
+		return phydrv->ops->match_phy_device(phydev);
 
 	if (phydev->is_c45) {
 		for (i = 1; i < num_ids; i++) {
@@ -1235,11 +1235,11 @@ int phy_init_hw(struct phy_device *phydev)
 	/* Deassert the reset signal */
 	phy_device_reset(phydev, 0);
 
-	if (!phydev->drv)
+	if (!phydev->drv || !phydev->drv->ops)
 		return 0;
 
-	if (phydev->drv->soft_reset) {
-		ret = phydev->drv->soft_reset(phydev);
+	if (phydev->drv->ops->soft_reset) {
+		ret = phydev->drv->ops->soft_reset(phydev);
 		if (ret < 0)
 			return ret;
 
@@ -1253,14 +1253,14 @@ int phy_init_hw(struct phy_device *phydev)
 
 	phy_interface_zero(phydev->possible_interfaces);
 
-	if (phydev->drv->config_init) {
-		ret = phydev->drv->config_init(phydev);
+	if (phydev->drv->ops->config_init) {
+		ret = phydev->drv->ops->config_init(phydev);
 		if (ret < 0)
 			return ret;
 	}
 
-	if (phydev->drv->config_intr) {
-		ret = phydev->drv->config_intr(phydev);
+	if (phydev->drv->ops->config_intr) {
+		ret = phydev->drv->ops->config_intr(phydev);
 		if (ret < 0)
 			return ret;
 	}
@@ -1419,7 +1419,7 @@ EXPORT_SYMBOL(phy_sfp_probe);
 
 static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
 {
-	return phydrv->config_intr && phydrv->handle_interrupt;
+	return phydrv->ops && phydrv->ops->config_intr && phydrv->ops->handle_interrupt;
 }
 
 /**
@@ -1978,10 +1978,10 @@ int phy_suspend(struct phy_device *phydev)
 	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
 		return -EBUSY;
 
-	if (!phydrv || !phydrv->suspend)
+	if (!phydrv || !phydrv->ops || !phydrv->ops->suspend)
 		return 0;
 
-	ret = phydrv->suspend(phydev);
+	ret = phydrv->ops->suspend(phydev);
 	if (!ret)
 		phydev->suspended = true;
 
@@ -1996,10 +1996,10 @@ int __phy_resume(struct phy_device *phydev)
 
 	lockdep_assert_held(&phydev->lock);
 
-	if (!phydrv || !phydrv->resume)
+	if (!phydrv || !phydrv->ops || !phydrv->ops->resume)
 		return 0;
 
-	ret = phydrv->resume(phydev);
+	ret = phydrv->ops->resume(phydev);
 	if (!ret)
 		phydev->suspended = false;
 
@@ -2038,8 +2038,8 @@ int phy_loopback(struct phy_device *phydev, bool enable)
 		goto out;
 	}
 
-	if (phydev->drv->set_loopback)
-		ret = phydev->drv->set_loopback(phydev, enable);
+	if (phydev->drv->ops && phydev->drv->ops->set_loopback)
+		ret = phydev->drv->ops->set_loopback(phydev, enable);
 	else
 		ret = genphy_loopback(phydev, enable);
 
@@ -3130,7 +3130,7 @@ static int phy_led_set_brightness(struct led_classdev *led_cdev,
 	int err;
 
 	mutex_lock(&phydev->lock);
-	err = phydev->drv->led_brightness_set(phydev, phyled->index, value);
+	err = phydev->drv->ops->led_brightness_set(phydev, phyled->index, value);
 	mutex_unlock(&phydev->lock);
 
 	return err;
@@ -3145,8 +3145,8 @@ static int phy_led_blink_set(struct led_classdev *led_cdev,
 	int err;
 
 	mutex_lock(&phydev->lock);
-	err = phydev->drv->led_blink_set(phydev, phyled->index,
-					 delay_on, delay_off);
+	err = phydev->drv->ops->led_blink_set(phydev, phyled->index,
+					      delay_on, delay_off);
 	mutex_unlock(&phydev->lock);
 
 	return err;
@@ -3172,7 +3172,7 @@ phy_led_hw_control_get(struct led_classdev *led_cdev,
 	int err;
 
 	mutex_lock(&phydev->lock);
-	err = phydev->drv->led_hw_control_get(phydev, phyled->index, rules);
+	err = phydev->drv->ops->led_hw_control_get(phydev, phyled->index, rules);
 	mutex_unlock(&phydev->lock);
 
 	return err;
@@ -3187,7 +3187,7 @@ phy_led_hw_control_set(struct led_classdev *led_cdev,
 	int err;
 
 	mutex_lock(&phydev->lock);
-	err = phydev->drv->led_hw_control_set(phydev, phyled->index, rules);
+	err = phydev->drv->ops->led_hw_control_set(phydev, phyled->index, rules);
 	mutex_unlock(&phydev->lock);
 
 	return err;
@@ -3201,7 +3201,7 @@ static __maybe_unused int phy_led_hw_is_supported(struct led_classdev *led_cdev,
 	int err;
 
 	mutex_lock(&phydev->lock);
-	err = phydev->drv->led_hw_is_supported(phydev, phyled->index, rules);
+	err = phydev->drv->ops->led_hw_is_supported(phydev, phyled->index, rules);
 	mutex_unlock(&phydev->lock);
 
 	return err;
@@ -3247,24 +3247,25 @@ static int of_phy_led(struct phy_device *phydev,
 
 	if (modes) {
 		/* Return error if asked to set polarity modes but not supported */
-		if (!phydev->drv->led_polarity_set)
+		if (phydev->drv->ops && !phydev->drv->ops->led_polarity_set)
 			return -EINVAL;
 
-		err = phydev->drv->led_polarity_set(phydev, index, modes);
+		err = phydev->drv->ops->led_polarity_set(phydev, index, modes);
 		if (err)
 			return err;
 	}
 
 	phyled->index = index;
-	if (phydev->drv->led_brightness_set)
+	if (phydev->drv->ops && phydev->drv->ops->led_brightness_set)
 		cdev->brightness_set_blocking = phy_led_set_brightness;
-	if (phydev->drv->led_blink_set)
+	if (phydev->drv->ops && phydev->drv->ops->led_blink_set)
 		cdev->blink_set = phy_led_blink_set;
 
 #ifdef CONFIG_LEDS_TRIGGERS
-	if (phydev->drv->led_hw_is_supported &&
-	    phydev->drv->led_hw_control_set &&
-	    phydev->drv->led_hw_control_get) {
+	if (phydev->drv->ops &&
+	    phydev->drv->ops->led_hw_is_supported &&
+	    phydev->drv->ops->led_hw_control_set &&
+	    phydev->drv->ops->led_hw_control_get) {
 		cdev->hw_control_is_supported = phy_led_hw_is_supported;
 		cdev->hw_control_set = phy_led_hw_control_set;
 		cdev->hw_control_get = phy_led_hw_control_get;
@@ -3426,8 +3427,8 @@ static int phy_probe(struct device *dev)
 	/* Deassert the reset signal */
 	phy_device_reset(phydev, 0);
 
-	if (phydev->drv->probe) {
-		err = phydev->drv->probe(phydev);
+	if (phydev->drv->ops && phydev->drv->ops->probe) {
+		err = phydev->drv->ops->probe(phydev);
 		if (err)
 			goto out;
 	}
@@ -3441,9 +3442,8 @@ static int phy_probe(struct device *dev)
 	if (phydrv->features) {
 		linkmode_copy(phydev->supported, phydrv->features);
 		genphy_c45_read_eee_abilities(phydev);
-	}
-	else if (phydrv->get_features)
-		err = phydrv->get_features(phydev);
+	} else if (phydev->drv->ops && phydrv->ops->get_features)
+		err = phydrv->ops->get_features(phydev);
 	else if (phydev->is_c45)
 		err = genphy_c45_pma_read_abilities(phydev);
 	else
@@ -3540,8 +3540,9 @@ static int phy_remove(struct device *dev)
 	sfp_bus_del_upstream(phydev->sfp_bus);
 	phydev->sfp_bus = NULL;
 
-	if (phydev->drv && phydev->drv->remove)
-		phydev->drv->remove(phydev);
+	if (phydev->drv && phydev->drv->ops &&
+	    phydev->drv->ops->remove)
+		phydev->drv->ops->remove(phydev);
 
 	/* Assert the reset signal */
 	phy_device_reset(phydev, 1);
@@ -3563,7 +3564,7 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
 	/* Either the features are hard coded, or dynamically
 	 * determined. It cannot be both.
 	 */
-	if (WARN_ON(new_driver->features && new_driver->get_features)) {
+	if (WARN_ON(new_driver->features && new_driver->ops && new_driver->ops->get_features)) {
 		pr_err("%s: features and get_features must not both be set\n",
 		       new_driver->name);
 		return -EINVAL;
@@ -3637,10 +3638,12 @@ static struct phy_driver genphy_driver = {
 	.phy_id		= 0xffffffff,
 	.phy_id_mask	= 0xffffffff,
 	.name		= "Generic PHY",
+	.ops		= &(const struct phy_driver_ops){
 	.get_features	= genphy_read_abilities,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 	.set_loopback   = genphy_loopback,
+	},
 };
 
 static const struct ethtool_phy_ops phy_ethtool_phy_ops = {
diff --git a/drivers/net/phy/qcom/at803x.c b/drivers/net/phy/qcom/at803x.c
index 4717c59d51d0..96666c5d58e0 100644
--- a/drivers/net/phy/qcom/at803x.c
+++ b/drivers/net/phy/qcom/at803x.c
@@ -988,6 +988,7 @@ static struct phy_driver at803x_driver[] = {
 	PHY_ID_MATCH_EXACT(ATH8035_PHY_ID),
 	.name			= "Qualcomm Atheros AR8035",
 	.flags			= PHY_POLL_CABLE_TEST,
+	.ops			= &(const struct phy_driver_ops){
 	.probe			= at8035_probe,
 	.config_aneg		= at803x_config_aneg,
 	.config_init		= at803x_config_init,
@@ -1004,11 +1005,13 @@ static struct phy_driver at803x_driver[] = {
 	.set_tunable		= at803x_set_tunable,
 	.cable_test_start	= at8031_cable_test_start,
 	.cable_test_get_status	= at8031_cable_test_get_status,
+	},
 }, {
 	/* Qualcomm Atheros AR8030 */
 	.phy_id			= ATH8030_PHY_ID,
 	.name			= "Qualcomm Atheros AR8030",
 	.phy_id_mask		= AT8030_PHY_ID_MASK,
+	.ops			= &(const struct phy_driver_ops){
 	.probe			= at8035_probe,
 	.config_init		= at803x_config_init,
 	.link_change_notify	= at803x_link_change_notify,
@@ -1019,11 +1022,13 @@ static struct phy_driver at803x_driver[] = {
 	/* PHY_BASIC_FEATURES */
 	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
+	},
 }, {
 	/* Qualcomm Atheros AR8031/AR8033 */
 	PHY_ID_MATCH_EXACT(ATH8031_PHY_ID),
 	.name			= "Qualcomm Atheros AR8031/AR8033",
 	.flags			= PHY_POLL_CABLE_TEST,
+	.ops			= &(const struct phy_driver_ops){
 	.probe			= at8031_probe,
 	.config_init		= at8031_config_init,
 	.config_aneg		= at803x_config_aneg,
@@ -1042,12 +1047,14 @@ static struct phy_driver at803x_driver[] = {
 	.set_tunable		= at803x_set_tunable,
 	.cable_test_start	= at8031_cable_test_start,
 	.cable_test_get_status	= at8031_cable_test_get_status,
+	},
 }, {
 	/* Qualcomm Atheros AR8032 */
 	PHY_ID_MATCH_EXACT(ATH8032_PHY_ID),
 	.name			= "Qualcomm Atheros AR8032",
-	.probe			= at803x_probe,
 	.flags			= PHY_POLL_CABLE_TEST,
+	.ops			= &(const struct phy_driver_ops){
+	.probe			= at803x_probe,
 	.config_init		= at803x_config_init,
 	.link_change_notify	= at803x_link_change_notify,
 	.suspend		= at803x_suspend,
@@ -1057,14 +1064,16 @@ static struct phy_driver at803x_driver[] = {
 	.handle_interrupt	= at803x_handle_interrupt,
 	.cable_test_start	= at803x_cable_test_start,
 	.cable_test_get_status	= at8032_cable_test_get_status,
+	},
 }, {
 	/* ATHEROS AR9331 */
 	PHY_ID_MATCH_EXACT(ATH9331_PHY_ID),
 	.name			= "Qualcomm Atheros AR9331 built-in PHY",
+	.flags			= PHY_POLL_CABLE_TEST,
+	.ops			= &(const struct phy_driver_ops){
 	.probe			= at803x_probe,
 	.suspend		= at803x_suspend,
 	.resume			= at803x_resume,
-	.flags			= PHY_POLL_CABLE_TEST,
 	/* PHY_BASIC_FEATURES */
 	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
@@ -1073,14 +1082,16 @@ static struct phy_driver at803x_driver[] = {
 	.read_status		= at803x_read_status,
 	.soft_reset		= genphy_soft_reset,
 	.config_aneg		= at803x_config_aneg,
+	},
 }, {
 	/* Qualcomm Atheros QCA9561 */
 	PHY_ID_MATCH_EXACT(QCA9561_PHY_ID),
 	.name			= "Qualcomm Atheros QCA9561 built-in PHY",
+	.flags			= PHY_POLL_CABLE_TEST,
+	.ops			= &(const struct phy_driver_ops){
 	.probe			= at803x_probe,
 	.suspend		= at803x_suspend,
 	.resume			= at803x_resume,
-	.flags			= PHY_POLL_CABLE_TEST,
 	/* PHY_BASIC_FEATURES */
 	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
@@ -1089,6 +1100,7 @@ static struct phy_driver at803x_driver[] = {
 	.read_status		= at803x_read_status,
 	.soft_reset		= genphy_soft_reset,
 	.config_aneg		= at803x_config_aneg,
+	},
 }, };
 
 module_phy_driver(at803x_driver);
diff --git a/drivers/net/phy/qcom/qca807x.c b/drivers/net/phy/qcom/qca807x.c
index 780c28e2e4aa..9ff9a8a062a9 100644
--- a/drivers/net/phy/qcom/qca807x.c
+++ b/drivers/net/phy/qcom/qca807x.c
@@ -797,6 +797,7 @@ static struct phy_driver qca807x_drivers[] = {
 		.name           = "Qualcomm QCA8072",
 		.flags		= PHY_POLL_CABLE_TEST,
 		/* PHY_GBIT_FEATURES */
+		.ops		= &(const struct phy_driver_ops){
 		.probe		= qca807x_probe,
 		.config_init	= qca807x_config_init,
 		.read_status	= qca807x_read_status,
@@ -809,12 +810,14 @@ static struct phy_driver qca807x_drivers[] = {
 		.suspend	= genphy_suspend,
 		.cable_test_start	= qca807x_cable_test_start,
 		.cable_test_get_status	= qca808x_cable_test_get_status,
+		},
 	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_QCA8075),
 		.name           = "Qualcomm QCA8075",
 		.flags		= PHY_POLL_CABLE_TEST,
 		/* PHY_GBIT_FEATURES */
+		.ops		= &(const struct phy_driver_ops){
 		.probe		= qca807x_probe,
 		.config_init	= qca807x_config_init,
 		.read_status	= qca807x_read_status,
@@ -832,6 +835,7 @@ static struct phy_driver qca807x_drivers[] = {
 		.led_hw_is_supported = qca807x_led_hw_is_supported,
 		.led_hw_control_set = qca807x_led_hw_control_set,
 		.led_hw_control_get = qca807x_led_hw_control_get,
+		},
 	},
 };
 module_phy_driver(qca807x_drivers);
diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
index 2acf852fb4de..5aee2529f329 100644
--- a/drivers/net/phy/qcom/qca808x.c
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -609,6 +609,7 @@ static struct phy_driver qca808x_driver[] = {
 	PHY_ID_MATCH_EXACT(QCA8081_PHY_ID),
 	.name			= "Qualcomm QCA8081",
 	.flags			= PHY_POLL_CABLE_TEST,
+	.ops			= &(const struct phy_driver_ops){
 	.probe			= qca808x_probe,
 	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
@@ -632,6 +633,7 @@ static struct phy_driver qca808x_driver[] = {
 	.led_hw_control_set	= qca808x_led_hw_control_set,
 	.led_hw_control_get	= qca808x_led_hw_control_get,
 	.led_polarity_set	= qca808x_led_polarity_set,
+	},
 }, };
 
 module_phy_driver(qca808x_driver);
diff --git a/drivers/net/phy/qcom/qca83xx.c b/drivers/net/phy/qcom/qca83xx.c
index 5d083ef0250e..6630c0e6de90 100644
--- a/drivers/net/phy/qcom/qca83xx.c
+++ b/drivers/net/phy/qcom/qca83xx.c
@@ -220,8 +220,9 @@ static struct phy_driver qca83xx_driver[] = {
 	.phy_id_mask		= QCA8K_PHY_ID_MASK,
 	.name			= "Qualcomm Atheros 8337 internal PHY",
 	/* PHY_GBIT_FEATURES */
-	.probe			= qca83xx_probe,
 	.flags			= PHY_IS_INTERNAL,
+	.ops			= &(const struct phy_driver_ops){
+	.probe			= qca83xx_probe,
 	.config_init		= qca83xx_config_init,
 	.soft_reset		= genphy_soft_reset,
 	.get_sset_count		= qca83xx_get_sset_count,
@@ -229,15 +230,17 @@ static struct phy_driver qca83xx_driver[] = {
 	.get_stats		= qca83xx_get_stats,
 	.suspend		= qca8337_suspend,
 	.resume			= qca83xx_resume,
+	},
 }, {
 	/* QCA8327-A from switch QCA8327-AL1A */
 	.phy_id			= QCA8327_A_PHY_ID,
 	.phy_id_mask		= QCA8K_PHY_ID_MASK,
 	.name			= "Qualcomm Atheros 8327-A internal PHY",
 	/* PHY_GBIT_FEATURES */
+	.flags			= PHY_IS_INTERNAL,
+	.ops			= &(const struct phy_driver_ops){
 	.link_change_notify	= qca83xx_link_change_notify,
 	.probe			= qca83xx_probe,
-	.flags			= PHY_IS_INTERNAL,
 	.config_init		= qca8327_config_init,
 	.soft_reset		= genphy_soft_reset,
 	.get_sset_count		= qca83xx_get_sset_count,
@@ -245,15 +248,17 @@ static struct phy_driver qca83xx_driver[] = {
 	.get_stats		= qca83xx_get_stats,
 	.suspend		= qca8327_suspend,
 	.resume			= qca83xx_resume,
+	},
 }, {
 	/* QCA8327-B from switch QCA8327-BL1A */
 	.phy_id			= QCA8327_B_PHY_ID,
 	.phy_id_mask		= QCA8K_PHY_ID_MASK,
 	.name			= "Qualcomm Atheros 8327-B internal PHY",
 	/* PHY_GBIT_FEATURES */
+	.flags			= PHY_IS_INTERNAL,
+	.ops			= &(const struct phy_driver_ops){
 	.link_change_notify	= qca83xx_link_change_notify,
 	.probe			= qca83xx_probe,
-	.flags			= PHY_IS_INTERNAL,
 	.config_init		= qca8327_config_init,
 	.soft_reset		= genphy_soft_reset,
 	.get_sset_count		= qca83xx_get_sset_count,
@@ -261,6 +266,7 @@ static struct phy_driver qca83xx_driver[] = {
 	.get_stats		= qca83xx_get_stats,
 	.suspend		= qca8327_suspend,
 	.resume			= qca83xx_resume,
+	},
 }, };
 
 module_phy_driver(qca83xx_driver);
diff --git a/drivers/net/phy/qsemi.c b/drivers/net/phy/qsemi.c
index 30d15f7c9b03..a8c5c263669d 100644
--- a/drivers/net/phy/qsemi.c
+++ b/drivers/net/phy/qsemi.c
@@ -148,9 +148,11 @@ static struct phy_driver qs6612_driver[] = { {
 	.name		= "QS6612",
 	.phy_id_mask	= 0xfffffff0,
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= qs6612_config_init,
 	.config_intr	= qs6612_config_intr,
 	.handle_interrupt = qs6612_handle_interrupt,
+	},
 } };
 
 module_phy_driver(qs6612_driver);
diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 481c79fbd6eb..b5db40d783d8 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -867,37 +867,46 @@ static struct phy_driver realtek_drvs[] = {
 	{
 		PHY_ID_MATCH_EXACT(0x00008201),
 		.name           = "RTL8201CP Ethernet",
+		.ops		= &(const struct phy_driver_ops){
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		},
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc816),
 		.name		= "RTL8201F Fast Ethernet",
+		.ops		= &(const struct phy_driver_ops){
 		.config_intr	= &rtl8201_config_intr,
 		.handle_interrupt = rtl8201_handle_interrupt,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		},
 	}, {
 		PHY_ID_MATCH_MODEL(0x001cc880),
 		.name		= "RTL8208 Fast Ethernet",
+		.ops		= &(const struct phy_driver_ops){
 		.read_mmd	= genphy_read_mmd_unsupported,
 		.write_mmd	= genphy_write_mmd_unsupported,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		},
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc910),
 		.name		= "RTL8211 Gigabit Ethernet",
+		.ops		= &(const struct phy_driver_ops){
 		.config_aneg	= rtl8211_config_aneg,
 		.read_mmd	= &genphy_read_mmd_unsupported,
 		.write_mmd	= &genphy_write_mmd_unsupported,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		},
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc912),
 		.name		= "RTL8211B Gigabit Ethernet",
+		.ops		= &(const struct phy_driver_ops){
 		.config_intr	= &rtl8211b_config_intr,
 		.handle_interrupt = rtl821x_handle_interrupt,
 		.read_mmd	= &genphy_read_mmd_unsupported,
@@ -906,26 +915,32 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= rtl8211b_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		},
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc913),
 		.name		= "RTL8211C Gigabit Ethernet",
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= rtl8211c_config_init,
 		.read_mmd	= &genphy_read_mmd_unsupported,
 		.write_mmd	= &genphy_write_mmd_unsupported,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		},
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc914),
 		.name		= "RTL8211DN Gigabit Ethernet",
+		.ops		= &(const struct phy_driver_ops){
 		.config_intr	= rtl8211e_config_intr,
 		.handle_interrupt = rtl821x_handle_interrupt,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		},
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc915),
 		.name		= "RTL8211E Gigabit Ethernet",
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= &rtl8211e_config_init,
 		.config_intr	= &rtl8211e_config_intr,
 		.handle_interrupt = rtl821x_handle_interrupt,
@@ -933,9 +948,12 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= genphy_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		},
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc916),
 		.name		= "RTL8211F Gigabit Ethernet",
+		.flags		= PHY_ALWAYS_CALL_SUSPEND,
+		.ops		= &(const struct phy_driver_ops){
 		.probe		= rtl821x_probe,
 		.config_init	= &rtl8211f_config_init,
 		.read_status	= rtlgen_read_status,
@@ -945,10 +963,12 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= rtl821x_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
-		.flags		= PHY_ALWAYS_CALL_SUSPEND,
+		},
 	}, {
 		PHY_ID_MATCH_EXACT(RTL_8211FVD_PHYID),
 		.name		= "RTL8211F-VD Gigabit Ethernet",
+		.flags		= PHY_ALWAYS_CALL_SUSPEND,
+		.ops		= &(const struct phy_driver_ops){
 		.probe		= rtl821x_probe,
 		.config_init	= &rtl8211f_config_init,
 		.read_status	= rtlgen_read_status,
@@ -958,9 +978,10 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= rtl821x_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
-		.flags		= PHY_ALWAYS_CALL_SUSPEND,
+		},
 	}, {
 		.name		= "Generic FE-GE Realtek PHY",
+		.ops		= &(const struct phy_driver_ops){
 		.match_phy_device = rtlgen_match_phy_device,
 		.read_status	= rtlgen_read_status,
 		.suspend	= genphy_suspend,
@@ -969,8 +990,10 @@ static struct phy_driver realtek_drvs[] = {
 		.write_page	= rtl821x_write_page,
 		.read_mmd	= rtlgen_read_mmd,
 		.write_mmd	= rtlgen_write_mmd,
+		},
 	}, {
 		.name		= "RTL8226 2.5Gbps PHY",
+		.ops		= &(const struct phy_driver_ops){
 		.match_phy_device = rtl8226_match_phy_device,
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
@@ -981,9 +1004,11 @@ static struct phy_driver realtek_drvs[] = {
 		.write_page	= rtl821x_write_page,
 		.read_mmd	= rtl822x_read_mmd,
 		.write_mmd	= rtl822x_write_mmd,
+		},
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc840),
 		.name		= "RTL8226B_RTL8221B 2.5Gbps PHY",
+		.ops		= &(const struct phy_driver_ops){
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
 		.read_status	= rtl822x_read_status,
@@ -993,9 +1018,11 @@ static struct phy_driver realtek_drvs[] = {
 		.write_page	= rtl821x_write_page,
 		.read_mmd	= rtl822x_read_mmd,
 		.write_mmd	= rtl822x_write_mmd,
+		},
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc838),
 		.name           = "RTL8226-CG 2.5Gbps PHY",
+		.ops		= &(const struct phy_driver_ops){
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
@@ -1003,9 +1030,11 @@ static struct phy_driver realtek_drvs[] = {
 		.resume         = rtlgen_resume,
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
+		},
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc848),
 		.name           = "RTL8226B-CG_RTL8221B-CG 2.5Gbps PHY",
+		.ops		= &(const struct phy_driver_ops){
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
@@ -1013,9 +1042,11 @@ static struct phy_driver realtek_drvs[] = {
 		.resume         = rtlgen_resume,
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
+		},
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc849),
 		.name           = "RTL8221B-VB-CG 2.5Gbps PHY",
+		.ops		= &(const struct phy_driver_ops){
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
@@ -1023,9 +1054,11 @@ static struct phy_driver realtek_drvs[] = {
 		.resume         = rtlgen_resume,
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
+		},
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc84a),
 		.name           = "RTL8221B-VM-CG 2.5Gbps PHY",
+		.ops		= &(const struct phy_driver_ops){
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
@@ -1033,9 +1066,11 @@ static struct phy_driver realtek_drvs[] = {
 		.resume         = rtlgen_resume,
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
+		},
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc862),
 		.name           = "RTL8251B 5Gbps PHY",
+		.ops		= &(const struct phy_driver_ops){
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
@@ -1043,9 +1078,11 @@ static struct phy_driver realtek_drvs[] = {
 		.resume         = rtlgen_resume,
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
+		},
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc961),
 		.name		= "RTL8366RB Gigabit Ethernet",
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= &rtl8366rb_config_init,
 		/* These interrupts are handled by the irq controller
 		 * embedded inside the RTL8366RB, they get unmasked when the
@@ -1056,10 +1093,12 @@ static struct phy_driver realtek_drvs[] = {
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+		},
 	}, {
 		PHY_ID_MATCH_EXACT(0x001ccb00),
 		.name		= "RTL9000AA_RTL9000AN Ethernet",
 		.features       = PHY_BASIC_T1_FEATURES,
+		.ops		= &(const struct phy_driver_ops){
 		.config_init	= rtl9000a_config_init,
 		.config_aneg	= rtl9000a_config_aneg,
 		.read_status	= rtl9000a_read_status,
@@ -1069,14 +1108,17 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= genphy_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		},
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc942),
 		.name		= "RTL8365MB-VC Gigabit Ethernet",
+		.ops		= &(const struct phy_driver_ops){
 		/* Interrupt handling analogous to RTL8366RB */
 		.config_intr	= genphy_no_config_intr,
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+		},
 	},
 };
 
diff --git a/drivers/net/phy/rockchip.c b/drivers/net/phy/rockchip.c
index bb13e75183ee..45e18fbec58d 100644
--- a/drivers/net/phy/rockchip.c
+++ b/drivers/net/phy/rockchip.c
@@ -177,12 +177,14 @@ static struct phy_driver rockchip_phy_driver[] = {
 	.name			= "Rockchip integrated EPHY",
 	/* PHY_BASIC_FEATURES */
 	.flags			= 0,
+	.ops			= &(const struct phy_driver_ops){
 	.link_change_notify	= rockchip_link_change_notify,
 	.soft_reset		= genphy_soft_reset,
 	.config_init		= rockchip_integrated_phy_config_init,
 	.config_aneg		= rockchip_config_aneg,
 	.suspend		= genphy_suspend,
 	.resume			= rockchip_phy_resume,
+	},
 },
 };
 
diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index 150aea7c9c36..0860d30901a2 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -643,6 +643,7 @@ static struct phy_driver smsc_phy_driver[] = {
 	.name		= "SMSC LAN83C185",
 
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 
 	.probe		= smsc_phy_probe,
 
@@ -656,12 +657,14 @@ static struct phy_driver smsc_phy_driver[] = {
 
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	},
 }, {
 	.phy_id		= 0x0007c0b0, /* OUI=0x00800f, Model#=0x0b */
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "SMSC LAN8187",
 
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 
 	.probe		= smsc_phy_probe,
 
@@ -680,6 +683,7 @@ static struct phy_driver smsc_phy_driver[] = {
 
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	},
 }, {
 	/* This covers internal PHY (phy_id: 0x0007C0C3) for
 	 * LAN9500 (PID: 0x9500), LAN9514 (PID: 0xec00), LAN9505 (PID: 0x9505)
@@ -689,6 +693,7 @@ static struct phy_driver smsc_phy_driver[] = {
 	.name		= "SMSC LAN8700",
 
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 
 	.probe		= smsc_phy_probe,
 
@@ -712,12 +717,14 @@ static struct phy_driver smsc_phy_driver[] = {
 
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	},
 }, {
 	.phy_id		= 0x0007c0d0, /* OUI=0x00800f, Model#=0x0d */
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "SMSC LAN911x Internal PHY",
 
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 
 	.probe		= smsc_phy_probe,
 
@@ -727,6 +734,7 @@ static struct phy_driver smsc_phy_driver[] = {
 
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	},
 }, {
 	/* This covers internal PHY (phy_id: 0x0007C0F0) for
 	 * LAN9500A (PID: 0x9E00), LAN9505A (PID: 0x9E01)
@@ -736,6 +744,7 @@ static struct phy_driver smsc_phy_driver[] = {
 	.name		= "SMSC LAN8710/LAN8720",
 
 	/* PHY_BASIC_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 
 	.probe		= smsc_phy_probe,
 
@@ -759,6 +768,7 @@ static struct phy_driver smsc_phy_driver[] = {
 
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	},
 }, {
 	.phy_id		= 0x0007c110,
 	.phy_id_mask	= 0xfffffff0,
@@ -766,6 +776,7 @@ static struct phy_driver smsc_phy_driver[] = {
 
 	/* PHY_BASIC_FEATURES */
 	.flags		= PHY_RST_AFTER_CLK_EN,
+	.ops		= &(const struct phy_driver_ops){
 
 	.probe		= smsc_phy_probe,
 
@@ -792,6 +803,7 @@ static struct phy_driver smsc_phy_driver[] = {
 
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	},
 }, {
 	.phy_id		= 0x0007c130,	/* 0x0007c130 and 0x0007c131 */
 	/* This mask (0xfffffff2) is to differentiate from
@@ -803,6 +815,7 @@ static struct phy_driver smsc_phy_driver[] = {
 
 	/* PHY_BASIC_FEATURES */
 	.flags		= PHY_RST_AFTER_CLK_EN,
+	.ops		= &(const struct phy_driver_ops){
 
 	.probe		= smsc_phy_probe,
 
@@ -829,6 +842,7 @@ static struct phy_driver smsc_phy_driver[] = {
 
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	},
 } };
 
 module_phy_driver(smsc_phy_driver);
diff --git a/drivers/net/phy/ste10Xp.c b/drivers/net/phy/ste10Xp.c
index 309e4c3496c4..1af413906823 100644
--- a/drivers/net/phy/ste10Xp.c
+++ b/drivers/net/phy/ste10Xp.c
@@ -105,21 +105,25 @@ static struct phy_driver ste10xp_pdriver[] = {
 	.phy_id_mask = 0xfffffff0,
 	.name = "STe101p",
 	/* PHY_BASIC_FEATURES */
+	.ops = &(const struct phy_driver_ops){
 	.config_init = ste10Xp_config_init,
 	.config_intr = ste10Xp_config_intr,
 	.handle_interrupt = ste10Xp_handle_interrupt,
 	.suspend = genphy_suspend,
 	.resume = genphy_resume,
+	},
 }, {
 	.phy_id = STE100P_PHY_ID,
 	.phy_id_mask = 0xffffffff,
 	.name = "STe100p",
 	/* PHY_BASIC_FEATURES */
+	.ops = &(const struct phy_driver_ops){
 	.config_init = ste10Xp_config_init,
 	.config_intr = ste10Xp_config_intr,
 	.handle_interrupt = ste10Xp_handle_interrupt,
 	.suspend = genphy_suspend,
 	.resume = genphy_resume,
+	},
 } };
 
 module_phy_driver(ste10xp_pdriver);
diff --git a/drivers/net/phy/teranetics.c b/drivers/net/phy/teranetics.c
index 8057ea8dbc21..d1eadd7074a3 100644
--- a/drivers/net/phy/teranetics.c
+++ b/drivers/net/phy/teranetics.c
@@ -78,10 +78,12 @@ static struct phy_driver teranetics_driver[] = {
 	.phy_id_mask	= 0xffffffff,
 	.name		= "Teranetics TN2020",
 	.features       = PHY_10GBIT_FEATURES,
+	.ops		= &(const struct phy_driver_ops){
 	.aneg_done	= teranetics_aneg_done,
 	.config_aneg    = gen10g_config_aneg,
 	.read_status	= teranetics_read_status,
 	.match_phy_device = teranetics_match_phy_device,
+	},
 },
 };
 
diff --git a/drivers/net/phy/uPD60620.c b/drivers/net/phy/uPD60620.c
index 38834347a427..865f62844d58 100644
--- a/drivers/net/phy/uPD60620.c
+++ b/drivers/net/phy/uPD60620.c
@@ -84,8 +84,10 @@ static struct phy_driver upd60620_driver[1] = { {
 	.name           = "Renesas uPD60620",
 	/* PHY_BASIC_FEATURES */
 	.flags          = 0,
+	.ops		= &(const struct phy_driver_ops){
 	.config_init    = upd60620_config_init,
 	.read_status    = upd60620_read_status,
+	},
 } };
 
 module_phy_driver(upd60620_driver);
diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
index 897b979ec03c..41fc63ce3b2e 100644
--- a/drivers/net/phy/vitesse.c
+++ b/drivers/net/phy/vitesse.c
@@ -408,99 +408,121 @@ static struct phy_driver vsc82xx_driver[] = {
 	.name           = "Vitesse VSC8234",
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init    = &vsc824x_config_init,
 	.config_aneg    = &vsc82x4_config_aneg,
 	.config_intr    = &vsc82xx_config_intr,
 	.handle_interrupt = &vsc82xx_handle_interrupt,
+	},
 }, {
 	.phy_id		= PHY_ID_VSC8244,
 	.name		= "Vitesse VSC8244",
 	.phy_id_mask	= 0x000fffc0,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= &vsc824x_config_init,
 	.config_aneg	= &vsc82x4_config_aneg,
 	.config_intr	= &vsc82xx_config_intr,
 	.handle_interrupt = &vsc82xx_handle_interrupt,
+	},
 }, {
 	.phy_id         = PHY_ID_VSC8572,
 	.name           = "Vitesse VSC8572",
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init    = &vsc824x_config_init,
 	.config_aneg    = &vsc82x4_config_aneg,
 	.config_intr    = &vsc82xx_config_intr,
 	.handle_interrupt = &vsc82xx_handle_interrupt,
+	},
 }, {
 	.phy_id         = PHY_ID_VSC8601,
 	.name           = "Vitesse VSC8601",
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init    = &vsc8601_config_init,
 	.config_intr    = &vsc82xx_config_intr,
 	.handle_interrupt = &vsc82xx_handle_interrupt,
+	},
 }, {
 	.phy_id         = PHY_ID_VSC7385,
 	.name           = "Vitesse VSC7385",
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init    = vsc738x_config_init,
 	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
+	},
 }, {
 	.phy_id         = PHY_ID_VSC7388,
 	.name           = "Vitesse VSC7388",
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init    = vsc738x_config_init,
 	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
+	},
 }, {
 	.phy_id         = PHY_ID_VSC7395,
 	.name           = "Vitesse VSC7395",
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init    = vsc739x_config_init,
 	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
+	},
 }, {
 	.phy_id         = PHY_ID_VSC7398,
 	.name           = "Vitesse VSC7398",
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init    = vsc739x_config_init,
 	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
+	},
 }, {
 	.phy_id         = PHY_ID_VSC8662,
 	.name           = "Vitesse VSC8662",
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init    = &vsc824x_config_init,
 	.config_aneg    = &vsc82x4_config_aneg,
 	.config_intr    = &vsc82xx_config_intr,
 	.handle_interrupt = &vsc82xx_handle_interrupt,
+	},
 }, {
 	/* Vitesse 8221 */
 	.phy_id		= PHY_ID_VSC8221,
 	.phy_id_mask	= 0x000ffff0,
 	.name		= "Vitesse VSC8221",
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= &vsc8221_config_init,
 	.config_intr	= &vsc82xx_config_intr,
 	.handle_interrupt = &vsc82xx_handle_interrupt,
+	},
 }, {
 	/* Vitesse 8211 */
 	.phy_id		= PHY_ID_VSC8211,
 	.phy_id_mask	= 0x000ffff0,
 	.name		= "Vitesse VSC8211",
 	/* PHY_GBIT_FEATURES */
+	.ops		= &(const struct phy_driver_ops){
 	.config_init	= &vsc8221_config_init,
 	.config_intr	= &vsc82xx_config_intr,
 	.handle_interrupt = &vsc82xx_handle_interrupt,
+	},
 } };
 
 module_phy_driver(vsc82xx_driver);
diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index 7b1bc5fcef9b..46f64c1fa143 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -24,6 +24,7 @@ struct gmii2rgmii {
 	struct phy_device *phy_dev;
 	const struct phy_driver *phy_drv;
 	struct phy_driver conv_phy_drv;
+	struct phy_driver_ops conv_phy_drv_ops;
 	struct mdio_device *mdio;
 };
 
@@ -51,8 +52,8 @@ static int xgmiitorgmii_read_status(struct phy_device *phydev)
 	struct gmii2rgmii *priv = mdiodev_get_drvdata(&phydev->mdio);
 	int err;
 
-	if (priv->phy_drv->read_status)
-		err = priv->phy_drv->read_status(phydev);
+	if (priv->phy_drv->ops && priv->phy_drv->ops->read_status)
+		err = priv->phy_drv->ops->read_status(phydev);
 	else
 		err = genphy_read_status(phydev);
 	if (err < 0)
@@ -68,8 +69,8 @@ static int xgmiitorgmii_set_loopback(struct phy_device *phydev, bool enable)
 	struct gmii2rgmii *priv = mdiodev_get_drvdata(&phydev->mdio);
 	int err;
 
-	if (priv->phy_drv->set_loopback)
-		err = priv->phy_drv->set_loopback(phydev, enable);
+	if (priv->phy_drv->ops && priv->phy_drv->ops->set_loopback)
+		err = priv->phy_drv->ops->set_loopback(phydev, enable);
 	else
 		err = genphy_loopback(phydev, enable);
 	if (err < 0)
@@ -113,8 +114,11 @@ static int xgmiitorgmii_probe(struct mdio_device *mdiodev)
 	priv->phy_drv = priv->phy_dev->drv;
 	memcpy(&priv->conv_phy_drv, priv->phy_dev->drv,
 	       sizeof(struct phy_driver));
-	priv->conv_phy_drv.read_status = xgmiitorgmii_read_status;
-	priv->conv_phy_drv.set_loopback = xgmiitorgmii_set_loopback;
+	memcpy(&priv->conv_phy_drv_ops, priv->phy_dev->drv->ops,
+	       sizeof(struct phy_driver_ops));
+	priv->conv_phy_drv_ops.read_status = xgmiitorgmii_read_status;
+	priv->conv_phy_drv_ops.set_loopback = xgmiitorgmii_set_loopback;
+	priv->conv_phy_drv.ops = &priv->conv_phy_drv_ops;
 	mdiodev_set_drvdata(&priv->phy_dev->mdio, priv);
 	priv->phy_dev->drv = &priv->conv_phy_drv;
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index c2dda21b39e1..bce995067b4c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -882,19 +882,7 @@ struct phy_led {
 #define to_phy_led(d) container_of(d, struct phy_led, led_cdev)
 
 /**
- * struct phy_driver - Driver structure for a particular PHY type
- *
- * @mdiodrv: Data common to all MDIO devices
- * @phy_id: The result of reading the UID registers of this PHY
- *   type, and ANDing them with the phy_id_mask.  This driver
- *   only works for PHYs with IDs which match this field
- * @name: The friendly name of this PHY type
- * @phy_id_mask: Defines the important bits of the phy_id
- * @features: A mandatory list of features (speed, duplex, etc)
- *   supported by this PHY
- * @flags: A bitfield defining certain other features this PHY
- *   supports (like interrupts)
- * @driver_data: Static driver data
+ * struct phy_driver_ops - Driver structure for all OPs of a particular PHY
  *
  * All functions are optional. If config_aneg or read_status
  * are not implemented, the phy core uses the genphy versions.
@@ -903,16 +891,8 @@ struct phy_led {
  * to be able to block when the bus transaction is happening,
  * and be freed up by an interrupt (The MPC85xx has this ability,
  * though it is not currently supported in the driver).
- */
-struct phy_driver {
-	struct mdio_driver_common mdiodrv;
-	u32 phy_id;
-	char *name;
-	u32 phy_id_mask;
-	const unsigned long * const features;
-	u32 flags;
-	const void *driver_data;
-
+*/
+struct phy_driver_ops {
 	/**
 	 * @soft_reset: Called to issue a PHY software reset
 	 */
@@ -1171,6 +1151,33 @@ struct phy_driver {
 	int (*led_polarity_set)(struct phy_device *dev, int index,
 				unsigned long modes);
 };
+
+/**
+ * struct phy_driver - Driver structure for a particular PHY type
+ *
+ * @mdiodrv: Data common to all MDIO devices
+ * @phy_id: The result of reading the UID registers of this PHY
+ *   type, and ANDing them with the phy_id_mask.  This driver
+ *   only works for PHYs with IDs which match this field
+ * @name: The friendly name of this PHY type
+ * @phy_id_mask: Defines the important bits of the phy_id
+ * @features: A mandatory list of features (speed, duplex, etc)
+ *   supported by this PHY
+ * @flags: A bitfield defining certain other features this PHY
+ *   supports (like interrupts)
+ * @driver_data: Static driver data
+ * @ops: Pointer to PHY driver OPs
+ */
+struct phy_driver {
+	struct mdio_driver_common mdiodrv;
+	u32 phy_id;
+	char *name;
+	u32 phy_id_mask;
+	const unsigned long * const features;
+	u32 flags;
+	const void *driver_data;
+	const struct phy_driver_ops *ops;
+};
 #define to_phy_driver(d) container_of(to_mdio_common_driver(d),		\
 				      struct phy_driver, mdiodrv)
 
@@ -1929,8 +1936,8 @@ static inline int phy_read_status(struct phy_device *phydev)
 	if (!phydev->drv)
 		return -EIO;
 
-	if (phydev->drv->read_status)
-		return phydev->drv->read_status(phydev);
+	if (phydev->drv->ops && phydev->drv->ops->read_status)
+		return phydev->drv->ops->read_status(phydev);
 	else
 		return genphy_read_status(phydev);
 }
-- 
2.43.0


