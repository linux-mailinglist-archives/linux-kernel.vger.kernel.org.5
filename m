Return-Path: <linux-kernel+bounces-70037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C630859223
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E6C1F21FFE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA4F7EEE0;
	Sat, 17 Feb 2024 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="js8H22hX"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A017E772;
	Sat, 17 Feb 2024 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708198897; cv=none; b=GP90tBODVKb5O2BNTulGG9ieJtt6gMIFaD/VybE0qYHKB+zpEEzSQWvnmBUFcCeRHivi0EtxcpTOJlaDvJDxVjJTkbJ5pBDk7b6BKqWtMlystz47NMR+BvrvYnE0VnNNWDGYHs2QjtFCKZES9ujbZXNHIoKPKCtfagLPjlQvKpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708198897; c=relaxed/simple;
	bh=mTd7gWZZAv2L+AJWK4gReRVscjNHop7dSwQNqNUKLck=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Df1ykdkCD+c0stMvmzgMLsM4Cgbtt4vLw+qwglYSWE8h/TlnLSYOs9Ia6HMMM7+TMVPyWr7ofrI/TCzsDK/sf+j4I2BKy8sgYH/BITlqoWZPjh/t+EaN7v/X/yj6Hm0k9KV1s0y6g8R2y6D0JW52TJ4sNMhdJlItNY14nJjE70s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=js8H22hX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d3a9f377aso127978f8f.3;
        Sat, 17 Feb 2024 11:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708198894; x=1708803694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZEviv2teb4NzkCVrP/1Qc+rjhnubLMND2DwU0Wh17A=;
        b=js8H22hXIr9XYN2i9WppjzX6ShpIbBke39H8Tt/MS4mQM6nSxl7AvD/vzx2LRWtsOO
         exjjWcPyg28lCsgQ5GMo5OYk19/3kaQC4Nvw+Dmaz6m2nI7k5AINo6ZQpJIUeusaAZyG
         1E5n2qj8Ukfy6vlV2ckNHWzcJQ/3mCP7fr58JJ3i9/1tBBFyTvhZszAyM1akpcS5gyaw
         7QhA68daFhGWEATCFrHHNt6wEFS6vonMRfWhzA9dfqPb057Zq1MfJHotZNmXYIRouNbF
         xgQjlYqVDrRgLG56AYiuwirENaP8vUgArYluJS/pXLZn2LCfDj0nQjHW3bHrK49v1nEr
         2B2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708198894; x=1708803694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZEviv2teb4NzkCVrP/1Qc+rjhnubLMND2DwU0Wh17A=;
        b=RdVZ6fK5RoyFEeQfpkRuIJYcCCAibuueYVvffj+GjFGkwnSOGYb6C6/eeFs2JLdyXg
         wQLBB0gepILA4mI2Fr3JLqXhyQTOPji8qonOMr5jfp2nu4mQQS/DE/JUhs1+GQGCb0zb
         nAks03bu4iJl2TRDMyacyJrFSjVA0tZFRT+s3+r7bLpQf4+dUv/aAl4pSdDNMpN85nuz
         EON5wtq+WLCZlyuGjQyw6yzF3QECSrQgoG23uLhIROzbAcm+cfxl28EzPFCaQAeSN5jr
         o683k/I50O2PWaq2KxCidqJhAKSh2MFxioNkfN7nxD/JrZzIt1xBJ78Hc/xYCXWdSn7p
         n+0A==
X-Forwarded-Encrypted: i=1; AJvYcCXFob8VfmCmU7iXEICDEkdVtD7vq024Ft1KvFtfoj5e4BZBeY+ybuUvimlX/U6dK3p1ZTJNHlfin7G4QzAtKpVCrF4/ffo6srNwgNovZloRewGtLgRKg0Ccpo6Qs93a1n2Xa322miN6DnkNBAvHYJA+RkmYSIgi3TSrqkpV0H/hxLO7xamEsWTdJ+d9/kmnB0Lrz+0cTLIEbNbj8IaFPXbxutQL
X-Gm-Message-State: AOJu0Yxt0JU83RCl0Hd/jy+Od4RZMkWsW/fxqzQdGfWYOgbHfDZ08+nK
	cOl/UtTSclMFdpMtcmureuQ4RQDyIKO0kFs5MwiDZHbuL2+c53jJ
X-Google-Smtp-Source: AGHT+IH5z0lQxM8SWKlZjhmYQZswVu+KcjSTCP84/EW6jYLGcTWFQHxT2+612mD4BXGNG14DlFINyw==
X-Received: by 2002:a05:6000:24a:b0:33d:3b44:aaa6 with SMTP id m10-20020a056000024a00b0033d3b44aaa6mr339545wrz.58.1708198893894;
        Sat, 17 Feb 2024 11:41:33 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id b10-20020a5d40ca000000b0033ceca3a3dbsm5661169wrq.2.2024.02.17.11.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 11:41:33 -0800 (PST)
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
Subject: [net-next RFC PATCH 2/3] net: phy: aquantia: use common OPs for PHYs where possible
Date: Sat, 17 Feb 2024 20:41:13 +0100
Message-ID: <20240217194116.8565-3-ansuelsmth@gmail.com>
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

Group common OPs for PHY, make them static and reference these
statically link OPs table instead of duplicating them for each PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 207 ++++++++---------------
 1 file changed, 69 insertions(+), 138 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 2166370ccc82..5720ceda303f 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -768,53 +768,14 @@ static int aqr111_config_init(struct phy_device *phydev)
 	return aqr107_config_init(phydev);
 }
 
-static struct phy_driver aqr_driver[] = {
-{
-	PHY_ID_MATCH_MODEL(PHY_ID_AQ1202),
-	.name		= "Aquantia AQ1202",
-	.ops		= &(const struct phy_driver_ops){
-	.config_aneg    = aqr_config_aneg,
-	.config_intr	= aqr_config_intr,
-	.handle_interrupt = aqr_handle_interrupt,
-	.read_status	= aqr_read_status,
-	},
-},
-{
-	PHY_ID_MATCH_MODEL(PHY_ID_AQ2104),
-	.name		= "Aquantia AQ2104",
-	.ops		= &(const struct phy_driver_ops){
-	.config_aneg    = aqr_config_aneg,
-	.config_intr	= aqr_config_intr,
-	.handle_interrupt = aqr_handle_interrupt,
-	.read_status	= aqr_read_status,
-	},
-},
-{
-	PHY_ID_MATCH_MODEL(PHY_ID_AQR105),
-	.name		= "Aquantia AQR105",
-	.ops		= &(const struct phy_driver_ops){
-	.config_aneg    = aqr_config_aneg,
-	.config_intr	= aqr_config_intr,
-	.handle_interrupt = aqr_handle_interrupt,
-	.read_status	= aqr_read_status,
-	.suspend	= aqr107_suspend,
-	.resume		= aqr107_resume,
-	},
-},
-{
-	PHY_ID_MATCH_MODEL(PHY_ID_AQR106),
-	.name		= "Aquantia AQR106",
-	.ops		= &(const struct phy_driver_ops){
+static const struct phy_driver_ops aqr106_ops = {
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
 	.read_status	= aqr_read_status,
-	},
-},
-{
-	PHY_ID_MATCH_MODEL(PHY_ID_AQR107),
-	.name		= "Aquantia AQR107",
-	.ops		= &(const struct phy_driver_ops){
+};
+
+static const struct phy_driver_ops aqr107_ops = {
 	.probe		= aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
 	.config_init	= aqr107_config_init,
@@ -830,15 +791,12 @@ static struct phy_driver aqr_driver[] = {
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
-	},
-},
-{
-	PHY_ID_MATCH_MODEL(PHY_ID_AQCS109),
-	.name		= "Aquantia AQCS109",
-	.ops		= &(const struct phy_driver_ops){
+};
+
+static const struct phy_driver_ops aqr111_ops = {
 	.probe		= aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init	= aqcs109_config_init,
+	.config_init	= aqr111_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
@@ -851,36 +809,66 @@ static struct phy_driver aqr_driver[] = {
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
-	},
+};
+
+static const struct phy_driver_ops aqr113_ops = {
+	.probe          = aqr107_probe,
+	.get_rate_matching = aqr107_get_rate_matching,
+	.config_init    = aqr113c_config_init,
+	.config_aneg    = aqr_config_aneg,
+	.config_intr    = aqr_config_intr,
+	.handle_interrupt       = aqr_handle_interrupt,
+	.read_status    = aqr107_read_status,
+	.get_tunable    = aqr107_get_tunable,
+	.set_tunable    = aqr107_set_tunable,
+	.suspend        = aqr107_suspend,
+	.resume         = aqr107_resume,
+	.get_sset_count = aqr107_get_sset_count,
+	.get_strings    = aqr107_get_strings,
+	.get_stats      = aqr107_get_stats,
+	.link_change_notify = aqr107_link_change_notify,
+};
+
+static struct phy_driver aqr_driver[] = {
+{
+	PHY_ID_MATCH_MODEL(PHY_ID_AQ1202),
+	.name		= "Aquantia AQ1202",
+	.ops		= &aqr106_ops,
 },
 {
-	PHY_ID_MATCH_MODEL(PHY_ID_AQR111),
-	.name		= "Aquantia AQR111",
+	PHY_ID_MATCH_MODEL(PHY_ID_AQ2104),
+	.name		= "Aquantia AQ2104",
+	.ops		= &aqr106_ops,
+},
+{
+	PHY_ID_MATCH_MODEL(PHY_ID_AQR105),
+	.name		= "Aquantia AQR105",
 	.ops		= &(const struct phy_driver_ops){
-	.probe		= aqr107_probe,
-	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init	= aqr111_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
-	.read_status	= aqr107_read_status,
-	.get_tunable    = aqr107_get_tunable,
-	.set_tunable    = aqr107_set_tunable,
+	.read_status	= aqr_read_status,
 	.suspend	= aqr107_suspend,
 	.resume		= aqr107_resume,
-	.get_sset_count	= aqr107_get_sset_count,
-	.get_strings	= aqr107_get_strings,
-	.get_stats	= aqr107_get_stats,
-	.link_change_notify = aqr107_link_change_notify,
 	},
 },
 {
-	PHY_ID_MATCH_MODEL(PHY_ID_AQR111B0),
-	.name		= "Aquantia AQR111B0",
+	PHY_ID_MATCH_MODEL(PHY_ID_AQR106),
+	.name		= "Aquantia AQR106",
+	.ops		= &aqr106_ops,
+},
+{
+	PHY_ID_MATCH_MODEL(PHY_ID_AQR107),
+	.name		= "Aquantia AQR107",
+	.ops		= &aqr107_ops,
+},
+{
+	PHY_ID_MATCH_MODEL(PHY_ID_AQCS109),
+	.name		= "Aquantia AQCS109",
 	.ops		= &(const struct phy_driver_ops){
 	.probe		= aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init	= aqr111_config_init,
+	.config_init	= aqcs109_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
@@ -895,97 +883,40 @@ static struct phy_driver aqr_driver[] = {
 	.link_change_notify = aqr107_link_change_notify,
 	},
 },
+{
+	PHY_ID_MATCH_MODEL(PHY_ID_AQR111),
+	.name		= "Aquantia AQR111",
+	.ops		= &aqr111_ops,
+},
+{
+	PHY_ID_MATCH_MODEL(PHY_ID_AQR111B0),
+	.name		= "Aquantia AQR111B0",
+	.ops		= &aqr111_ops,
+},
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR405),
 	.name		= "Aquantia AQR405",
-	.ops		= &(const struct phy_driver_ops){
-	.config_aneg    = aqr_config_aneg,
-	.config_intr	= aqr_config_intr,
-	.handle_interrupt = aqr_handle_interrupt,
-	.read_status	= aqr_read_status,
-	},
+	.ops		= &aqr106_ops,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR112),
 	.name		= "Aquantia AQR112",
-	.ops		= &(const struct phy_driver_ops){
-	.probe		= aqr107_probe,
-	.config_aneg    = aqr_config_aneg,
-	.config_intr	= aqr_config_intr,
-	.handle_interrupt = aqr_handle_interrupt,
-	.get_tunable    = aqr107_get_tunable,
-	.set_tunable    = aqr107_set_tunable,
-	.suspend	= aqr107_suspend,
-	.resume		= aqr107_resume,
-	.read_status	= aqr107_read_status,
-	.get_rate_matching = aqr107_get_rate_matching,
-	.get_sset_count = aqr107_get_sset_count,
-	.get_strings	= aqr107_get_strings,
-	.get_stats	= aqr107_get_stats,
-	.link_change_notify = aqr107_link_change_notify,
-	},
+	.ops		= &aqr107_ops,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR412),
 	.name		= "Aquantia AQR412",
-	.ops		= &(const struct phy_driver_ops){
-	.probe		= aqr107_probe,
-	.config_aneg    = aqr_config_aneg,
-	.config_intr	= aqr_config_intr,
-	.handle_interrupt = aqr_handle_interrupt,
-	.get_tunable    = aqr107_get_tunable,
-	.set_tunable    = aqr107_set_tunable,
-	.suspend	= aqr107_suspend,
-	.resume		= aqr107_resume,
-	.read_status	= aqr107_read_status,
-	.get_rate_matching = aqr107_get_rate_matching,
-	.get_sset_count = aqr107_get_sset_count,
-	.get_strings	= aqr107_get_strings,
-	.get_stats	= aqr107_get_stats,
-	.link_change_notify = aqr107_link_change_notify,
-	},
+	.ops		= &aqr107_ops,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR113),
 	.name		= "Aquantia AQR113",
-	.ops		= &(const struct phy_driver_ops){
-	.probe          = aqr107_probe,
-	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init    = aqr113c_config_init,
-	.config_aneg    = aqr_config_aneg,
-	.config_intr    = aqr_config_intr,
-	.handle_interrupt       = aqr_handle_interrupt,
-	.read_status    = aqr107_read_status,
-	.get_tunable    = aqr107_get_tunable,
-	.set_tunable    = aqr107_set_tunable,
-	.suspend        = aqr107_suspend,
-	.resume         = aqr107_resume,
-	.get_sset_count = aqr107_get_sset_count,
-	.get_strings    = aqr107_get_strings,
-	.get_stats      = aqr107_get_stats,
-	.link_change_notify = aqr107_link_change_notify,
-	},
+	.ops		= &aqr113_ops,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR113C),
 	.name           = "Aquantia AQR113C",
-	.ops		= &(const struct phy_driver_ops){
-	.probe          = aqr107_probe,
-	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init    = aqr113c_config_init,
-	.config_aneg    = aqr_config_aneg,
-	.config_intr    = aqr_config_intr,
-	.handle_interrupt       = aqr_handle_interrupt,
-	.read_status    = aqr107_read_status,
-	.get_tunable    = aqr107_get_tunable,
-	.set_tunable    = aqr107_set_tunable,
-	.suspend        = aqr107_suspend,
-	.resume         = aqr107_resume,
-	.get_sset_count = aqr107_get_sset_count,
-	.get_strings    = aqr107_get_strings,
-	.get_stats      = aqr107_get_stats,
-	.link_change_notify = aqr107_link_change_notify,
-	},
+	.ops		= &aqr113_ops,
 },
 };
 
-- 
2.43.0


