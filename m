Return-Path: <linux-kernel+bounces-70038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0CD85922A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84223283774
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAE07F466;
	Sat, 17 Feb 2024 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zp65E9yj"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0E01E863;
	Sat, 17 Feb 2024 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708198899; cv=none; b=hJmdel5d74sSCVO6rkP/Tyq+lMHtq+TnkuQWzYPaLbJzDZPh5oUoiUMdFKg+xn6ekV3vb23nMXvxoDpu6sp1b8NxZBfmBBSChVFksTwwOxpvKM8n0fMEU68GkEVSIz3bkVs7g4dl5+Mym7Z+/eEWdVZ10xHL7xm+gjUqJZGjsbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708198899; c=relaxed/simple;
	bh=7l+4WmcZhRm+cQXIUxCvDteAB3XdXH5QXlynCwU1qq4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2MQAmKUGMz0sTWd19itI3fvEEAPTZ2s2c8wDguqbWBUseYmkSDlnvqUhcQlgCzeSRG5JaaLRVR0M4jBjlh+mSc2B44jYK7N8w2Ng4c0y2YrLslvwUr0l953e90/I0+Nt5mtJx6shCTgOCb47wYLYlTaDLbckTFoZoyNJr5GtlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zp65E9yj; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d38c9f227so131153f8f.0;
        Sat, 17 Feb 2024 11:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708198896; x=1708803696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pEGqx9swrd2Efs0TPhy/y31ToK5jrlVR+4ffHyJyKoM=;
        b=Zp65E9yjSzzfs9w0zqjXmFpPWIvc6ryOatypdrsonRJR8xzP10at40ET5L4abUVbip
         Q5Oq6mGG1AB5Ivs+z1nWljfWl75YZe/cPsg3P6FSUnt4xLzcJ7mGC9wsGdoIKTzN4ao8
         WnW4VMAPXZMzwX2zTpHHXMaKkSRl2ZbTm+CG/EooUOZjsa2JsaQQ4aPQ/Sys5WD24rxv
         NOaxH1G/oEKUnfWSwZZtlWXlcS5Te7Kf27E3JamM40gzY6eAqpf1DSi3eSUAE+R+47if
         GgJ+aYLCuZAFXRgsL3pMCT1aB1yqrE27MPsLgi2SgmQfXMtbVNHkme9vR3cVQbL7nSB/
         HSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708198896; x=1708803696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEGqx9swrd2Efs0TPhy/y31ToK5jrlVR+4ffHyJyKoM=;
        b=F3+kFpmEciEekOs6s9gOiPheI+tyPDZ89LS/oRUnG/7KGNxAM9tXda484CLaPGSrvp
         TY2tF6peNFKhiZYGA1p9sGneGG7rg5NtyhjkcUy6ooqvyo1LLtDUcRuAtKGYCnDFJ9Qo
         N+LtM8R6gn/tqOMb4HpjJPU/I7lvPxGjJrcmdit4f8I3lBHNJWbKTScZV+7BuegN4HCc
         Qp0SgYWebjEvsyQWVgccv9Chyf5FtGaH/Mvll88BlQDXVTgu2Bsv1ddDiJ79weV1RiFj
         jXY6Urvc2tDhdf0rB3QIDbIYDjGqejLB6z6G8fYgzBkaY5vr5bR32m3bbFLverayWwVK
         KzEw==
X-Forwarded-Encrypted: i=1; AJvYcCXp8LPm0Z4WYw1D9A9I3rWSpJ0eSL4pAu+rgRRcAwZBKsy3PXvoOzfy84VwZG1Dz+4YqdPZJLZowAcUMt8zWE0CkgilTeQ8qkTTXhV1YKGk8xHpeMj5rOJ09+kqeBdHv/UVeK4SriwGuZDKeKWi7zF2CxGYV2cnpC0z6OnVUCS9cQD0wlHmxqSfXldd8rSCGnvJD8CBtUxmrK3cFx37QAB+eONu
X-Gm-Message-State: AOJu0YxBcpWulFPGNA+wvTPXbTXwmbGzj1zQZb46cvdwBYAVSwBpDD2s
	T5M2v+MH6mdM6Xa/obhlWEayaSuNEdf+5ixN/hOGTTjS+3TVnunV
X-Google-Smtp-Source: AGHT+IHTBfuLFBgxYDXyAEdhLvoS/uyVjXtTiqArx5lwkdOqMzfSKqV8T9BR5k1vk63E8j+lc/Nsdg==
X-Received: by 2002:a05:6000:105:b0:33d:39bb:a350 with SMTP id o5-20020a056000010500b0033d39bba350mr736402wrx.59.1708198896316;
        Sat, 17 Feb 2024 11:41:36 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id b10-20020a5d40ca000000b0033ceca3a3dbsm5661169wrq.2.2024.02.17.11.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 11:41:35 -0800 (PST)
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
Subject: [net-next RFC PATCH 3/3] net: phy: bcm7xxx: use common OPs for PHYs where possible
Date: Sat, 17 Feb 2024 20:41:14 +0100
Message-ID: <20240217194116.8565-4-ansuelsmth@gmail.com>
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
 drivers/net/phy/bcm7xxx.c | 80 +++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 36 deletions(-)

diff --git a/drivers/net/phy/bcm7xxx.c b/drivers/net/phy/bcm7xxx.c
index c820a94b30a4..adfe364846dd 100644
--- a/drivers/net/phy/bcm7xxx.c
+++ b/drivers/net/phy/bcm7xxx.c
@@ -840,6 +840,17 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	return ret;
 }
 
+static const struct phy_driver_ops bcm7xxx_28nm_gpy_ops = {
+	.config_init	= bcm7xxx_28nm_config_init,
+	.resume		= bcm7xxx_28nm_resume,
+	.get_tunable	= bcm7xxx_28nm_get_tunable,
+	.set_tunable	= bcm7xxx_28nm_set_tunable,
+	.get_sset_count	= bcm_phy_get_sset_count,
+	.get_strings	= bcm_phy_get_strings,
+	.get_stats	= bcm7xxx_28nm_get_phy_stats,
+	.probe		= bcm7xxx_28nm_probe,
+};
+
 #define BCM7XXX_28NM_GPHY(_oui, _name)					\
 {									\
 	.phy_id		= (_oui),					\
@@ -847,18 +858,20 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.name		= _name,					\
 	/* PHY_GBIT_FEATURES */						\
 	.flags		= PHY_IS_INTERNAL,				\
-	.ops		= &(const struct phy_driver_ops){		\
-	.config_init	= bcm7xxx_28nm_config_init,			\
-	.resume		= bcm7xxx_28nm_resume,				\
-	.get_tunable	= bcm7xxx_28nm_get_tunable,			\
-	.set_tunable	= bcm7xxx_28nm_set_tunable,			\
-	.get_sset_count	= bcm_phy_get_sset_count,			\
-	.get_strings	= bcm_phy_get_strings,				\
-	.get_stats	= bcm7xxx_28nm_get_phy_stats,			\
-	.probe		= bcm7xxx_28nm_probe,				\
-	},								\
+	.ops		= &bcm7xxx_28nm_gpy_ops,			\
 }
 
+static const struct phy_driver_ops bcm7xxx_28nm_ephy_ops = {
+	.config_init	= bcm7xxx_28nm_ephy_config_init,
+	.resume		= bcm7xxx_28nm_ephy_resume,
+	.get_sset_count	= bcm_phy_get_sset_count,
+	.get_strings	= bcm_phy_get_strings,
+	.get_stats	= bcm7xxx_28nm_get_phy_stats,
+	.probe		= bcm7xxx_28nm_probe,
+	.read_mmd	= bcm7xxx_28nm_ephy_read_mmd,
+	.write_mmd	= bcm7xxx_28nm_ephy_write_mmd,
+};
+
 #define BCM7XXX_28NM_EPHY(_oui, _name)					\
 {									\
 	.phy_id		= (_oui),					\
@@ -866,18 +879,16 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.name		= _name,					\
 	/* PHY_BASIC_FEATURES */					\
 	.flags		= PHY_IS_INTERNAL,				\
-	.ops		= &(const struct phy_driver_ops){		\
-	.config_init	= bcm7xxx_28nm_ephy_config_init,		\
-	.resume		= bcm7xxx_28nm_ephy_resume,			\
-	.get_sset_count	= bcm_phy_get_sset_count,			\
-	.get_strings	= bcm_phy_get_strings,				\
-	.get_stats	= bcm7xxx_28nm_get_phy_stats,			\
-	.probe		= bcm7xxx_28nm_probe,				\
-	.read_mmd	= bcm7xxx_28nm_ephy_read_mmd,			\
-	.write_mmd	= bcm7xxx_28nm_ephy_write_mmd,			\
-	},								\
+	.ops		= &bcm7xxx_28nm_ephy_ops,			\
 }
 
+static const struct phy_driver_ops bcm7xxx_40nm_ephy_ops = {
+	.soft_reset	= genphy_soft_reset,
+	.config_init    = bcm7xxx_config_init,
+	.suspend        = bcm7xxx_suspend,
+	.resume         = bcm7xxx_config_init,
+};
+
 #define BCM7XXX_40NM_EPHY(_oui, _name)					\
 {									\
 	.phy_id         = (_oui),					\
@@ -885,14 +896,20 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.name           = _name,					\
 	/* PHY_BASIC_FEATURES */					\
 	.flags          = PHY_IS_INTERNAL,				\
-	.ops		= &(const struct phy_driver_ops){		\
-	.soft_reset	= genphy_soft_reset,				\
-	.config_init    = bcm7xxx_config_init,				\
-	.suspend        = bcm7xxx_suspend,				\
-	.resume         = bcm7xxx_config_init,				\
-	},								\
+	.ops		= &bcm7xxx_40nm_ephy_ops,			\
 }
 
+static const struct phy_driver_ops bcm7xxx_16nm_ephy_ops = {
+	.get_sset_count	= bcm_phy_get_sset_count,
+	.get_strings	= bcm_phy_get_strings,
+	.get_stats	= bcm7xxx_28nm_get_phy_stats,
+	.probe		= bcm7xxx_28nm_probe,
+	.config_init	= bcm7xxx_16nm_ephy_config_init,
+	.config_aneg	= genphy_config_aneg,
+	.read_status	= genphy_read_status,
+	.resume		= bcm7xxx_16nm_ephy_resume,
+};
+
 #define BCM7XXX_16NM_EPHY(_oui, _name)					\
 {									\
 	.phy_id		= (_oui),					\
@@ -900,16 +917,7 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.name		= _name,					\
 	/* PHY_BASIC_FEATURES */					\
 	.flags		= PHY_IS_INTERNAL,				\
-	.ops		= &(const struct phy_driver_ops){		\
-	.get_sset_count	= bcm_phy_get_sset_count,			\
-	.get_strings	= bcm_phy_get_strings,				\
-	.get_stats	= bcm7xxx_28nm_get_phy_stats,			\
-	.probe		= bcm7xxx_28nm_probe,				\
-	.config_init	= bcm7xxx_16nm_ephy_config_init,		\
-	.config_aneg	= genphy_config_aneg,				\
-	.read_status	= genphy_read_status,				\
-	.resume		= bcm7xxx_16nm_ephy_resume,			\
-	},								\
+	.ops		= &bcm7xxx_16nm_ephy_ops,			\
 }
 
 static struct phy_driver bcm7xxx_driver[] = {
-- 
2.43.0


