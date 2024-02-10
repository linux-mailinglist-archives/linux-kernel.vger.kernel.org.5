Return-Path: <linux-kernel+bounces-60537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0A485064E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0961C231AD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 20:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500335FEEA;
	Sat, 10 Feb 2024 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYsxVd3X"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DAB5FDBC;
	Sat, 10 Feb 2024 20:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707597984; cv=none; b=dvZjX+sLI8XNlcNxhkaxycPekPGbdGi11fMkpFC9PPg93UIwpX41PXYaVgSr7qJ+0d0aRKm/cx2vlcA5MMJuBiswRIxmcpkfMaip8oGmfTO3SbgTAyThv0Mdo5zZ5yzo9wyoCoTqNTJ/V+bLHhuOTNsVortRXgEGTV6fk7OQUZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707597984; c=relaxed/simple;
	bh=wPCe5wSnxW4uma9yc97atkzASV0vWtGUFCcJ9jC7oqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/AkD10SZkazonxXLDv0UEulsizRDGh63zuRmBikEIOWMbX6PT1AavFmC60bQWxsI++4Je0H1XliVAXHZh4sjLl6P5xIRlDUlgLlwrdFVYJzMXuARSGwkXbg84cMymkLc4RLYeRXuD0mqE8pKM5LkthY79iy5NVv1FUV07yiVdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYsxVd3X; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42c6e2f3aa2so1411941cf.2;
        Sat, 10 Feb 2024 12:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707597981; x=1708202781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkPGBigxuH9warUrMt9eISTDJDr/S8IdWQHRaTUGh/w=;
        b=eYsxVd3Xg9YZor+j2HLTCZ1DnZmkQXAlUeohTzObIuRa++v4iuAFxKn7YW+urAWF+M
         z9hAjhtm38FrRujrsXNJn1R06TIOTBIuFnlrhQwfCHuCIovswf4Xwm9XkUFvJ6Nj0a7K
         oyA94lpYpV8lY8SuFMthyLE6VEkfxHZzsv3Hpx4eq5dLKvNcW457wDIgeVuCVK/TP7bW
         es1kH7yS/+a/Xf+GxswNeYnTKMHFWWdr6GATHwtHrlvEmVpE820CN921TWXKOIP6v8vC
         zr4Yfu76gp5pKeIWCKo9C8i9O/c+tR5sLbrpAHzWKdHogHRFIP3/T6+zZUOaMjKkuA+l
         gR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707597981; x=1708202781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkPGBigxuH9warUrMt9eISTDJDr/S8IdWQHRaTUGh/w=;
        b=QlESJaoq4JU1RHJNI2nqt6YeaToTOIGJv7g5Q/ItRYov8V+V6EwQr4eDz0hunXF+L/
         brhD/9zTwNkZxaPKzeQzVGPQte8F/S7mvLV/8sDZh3zVRsmq8g6NjQBy7PdMj2fqEdDA
         XfpeQVYW2i7M/lIaHCSregUPnl4BRZ+8vBpqE1e/5vXCe1Sz3oAAY0uS3O+RiZHa1KeI
         oHFF8WCGLmER0Ctk/NH9zOCrh0NuVC6XeQ9h8ajwmvZRMy62ZTgwTAf1meF+KG0v/x4D
         pP+GhtCMrr0uo69IOx54vOcxhYpEvrz9oRmWUCFtQwWHQPRMt0o8cRnAGF3ZO5SrXHpF
         rNVg==
X-Gm-Message-State: AOJu0Yy5zo8pg5G0QYRL//4x8Bwb3TlnrGE9YBHCKXkZZ/IBkp3ClU+G
	O1OZcHAUipgdsWs68i+msCXeAQl1yNtlatGTKpGgrKAz0WeS5c361xVLhtHc
X-Google-Smtp-Source: AGHT+IGA5jTR8rbO9GFV5Cactli80P+8FqAVr4MamrMgKdmUzAd3U6TmzRRxOi8L9apQmkui2XmgGQ==
X-Received: by 2002:a0c:f305:0:b0:68c:5486:b770 with SMTP id j5-20020a0cf305000000b0068c5486b770mr2987680qvl.65.1707597981058;
        Sat, 10 Feb 2024 12:46:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWwPUg7jQCU9zpiMnkJHX2PaZdnoPbfRQAb3l654g5UmDK2Kzxnq5p5DFDyAvQClGbX7gr+C2IIMT1uohlzRYwOjJuyh32Nm16HkxkeWs9+ZnKidfzsLrtyZZxDV3ajKeiVNSwJBOjNsFA7dko8d8eEHbGb/EBiYlIo2HvwiY04uKjnCPVUSAOiFq/X52Bpe35pBHgb0P641jwCUcJZ+SqMdsdThueQZDEyDZKgfwn6+tGY+caMfFmSf1g9HUKpG5oAjtbzaqUBqZls2qyVDJbvHFoj1KKUco0xgzr1wUCini+n5tmce1ms3oacNWKxRcSN30M980X6YyvG7sqWNWYjDbQn9l1xMOWMEvH9L6jwfgQr7m0J5NrfDQwadlpyXPica+jWFaf5vfu2EUkNOObWDRFun/3nQHweFaS4gW5Et5evqs1iFjkkcBFbK9vnYABBs5t2pcMAqS+V4ezi3ur7cVG7xqqYGs2Y9fkWQREA5u+uMmvZERV2X8I48eHYVP21mP9huEMrQMH2SP3ZSMsDla+C3iKsrvr1sMrL3y5auqbUw6LThn9cEI+yy5gtnyqCQ8cCjqfASnoVqM28ViH2Sq0I0lGQWOKRgZGCYkW1KEZzSo7NZPhJsVI7C1b66k0N53NQMQe0wb8bS1qPqVqLBlSEKZOrizGsNu3hiaYs4JCYq7ijIXeTQ557EyJHGBAD5UQo4RIG9w1C+G+7tkyoEiAw+r2UFUGyDvbb2xnJShozE6syfUbYExFoIxmDyYvU5AZE8CUEFV5jb9kDMzgka6TNahoqEZVt006EPJks
Received: from aford-System-Version.lan ([2601:447:d002:5be:27d7:3989:2897:88a7])
        by smtp.gmail.com with ESMTPSA id m20-20020a0cdb94000000b0068c9db26ae1sm2079526qvk.41.2024.02.10.12.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 12:46:20 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: marex@denx.de,
	aford@beaconembedded.com,
	Lucas Stach <l.stach@pengutronix.de>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Richard Leitner <richard.leitner@skidata.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Adam Ford <aford173@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/6] phy: freescale: add Samsung HDMI PHY
Date: Sat, 10 Feb 2024 14:45:58 -0600
Message-ID: <20240210204606.11944-3-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210204606.11944-1-aford173@gmail.com>
References: <20240210204606.11944-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lucas Stach <l.stach@pengutronix.de>

This adds the driver for the Samsung HDMI PHY found on the
i.MX8MP SoC. Based on downstream implementation from
Sandor Yu <Sandor.yu@nxp.com>.  According to the TRM, the PHY
receives parallel data from the link and serializes it.  It
also sets the PLL clock needed for the TX serializer.

Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com> (v2)
Tested-by: Richard Leitner <richard.leitner@skidata.com> (v2)
Co-developed-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron BL
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Adam Ford <aford173@gmail.com>
---
V4:
- I (Adam) added a comment in the code for clarifcation
  based on questions from Luca concerning a difference
  between the code and the ref manual.
- Fixed the GENMASK on REG14
- Expanded the commit message briefly describing
  a bit more of what this driver does.
- Removed some unnecessary include files.

v3:
- use GENMASK/FIELD_PREP
- lowercase hex values
- correct coding style
v2:
- use DEFINE_RUNTIME_DEV_PM_OPS
---
 drivers/phy/freescale/Kconfig                |   6 +
 drivers/phy/freescale/Makefile               |   1 +
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 721 +++++++++++++++++++
 3 files changed, 728 insertions(+)
 create mode 100644 drivers/phy/freescale/phy-fsl-samsung-hdmi.c

diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
index 853958fb2c06..5c2b73042dfc 100644
--- a/drivers/phy/freescale/Kconfig
+++ b/drivers/phy/freescale/Kconfig
@@ -35,6 +35,12 @@ config PHY_FSL_IMX8M_PCIE
 	  Enable this to add support for the PCIE PHY as found on
 	  i.MX8M family of SOCs.
 
+config PHY_FSL_SAMSUNG_HDMI_PHY
+	tristate "Samsung HDMI PHY support"
+	depends on OF && HAS_IOMEM
+	help
+	  Enable this to add support for the Samsung HDMI PHY in i.MX8MP.
+
 endif
 
 config PHY_FSL_LYNX_28G
diff --git a/drivers/phy/freescale/Makefile b/drivers/phy/freescale/Makefile
index cedb328bc4d2..c4386bfdb853 100644
--- a/drivers/phy/freescale/Makefile
+++ b/drivers/phy/freescale/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_PHY_MIXEL_LVDS_PHY)	+= phy-fsl-imx8qm-lvds-phy.o
 obj-$(CONFIG_PHY_MIXEL_MIPI_DPHY)	+= phy-fsl-imx8-mipi-dphy.o
 obj-$(CONFIG_PHY_FSL_IMX8M_PCIE)	+= phy-fsl-imx8m-pcie.o
 obj-$(CONFIG_PHY_FSL_LYNX_28G)		+= phy-fsl-lynx-28g.o
+obj-$(CONFIG_PHY_FSL_SAMSUNG_HDMI_PHY)	+= phy-fsl-samsung-hdmi.o
diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
new file mode 100644
index 000000000000..91cf8e4668b2
--- /dev/null
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -0,0 +1,721 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2020 NXP
+ * Copyright 2022 Pengutronix, Lucas Stach <kernel@pengutronix.de>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+#define PHY_REG_00		0x00
+#define PHY_REG_01		0x04
+#define PHY_REG_02		0x08
+#define PHY_REG_08		0x20
+#define PHY_REG_09		0x24
+#define PHY_REG_10		0x28
+#define PHY_REG_11		0x2c
+
+#define PHY_REG_12		0x30
+#define  REG12_CK_DIV_MASK	GENMASK(5, 4)
+
+#define PHY_REG_13		0x34
+#define  REG13_TG_CODE_LOW_MASK	GENMASK(7, 0)
+
+#define PHY_REG_14		0x38
+#define  REG14_TOL_MASK		GENMASK(7, 4)
+#define  REG14_RP_CODE_MASK	GENMASK(3, 1)
+#define  REG14_TG_CODE_HIGH_MASK	GENMASK(0, 0)
+
+#define PHY_REG_15		0x3c
+#define PHY_REG_16		0x40
+#define PHY_REG_17		0x44
+#define PHY_REG_18		0x48
+#define PHY_REG_19		0x4c
+#define PHY_REG_20		0x50
+
+#define PHY_REG_21		0x54
+#define  REG21_SEL_TX_CK_INV	BIT(7)
+#define  REG21_PMS_S_MASK	GENMASK(3, 0)
+
+#define PHY_REG_22		0x58
+#define PHY_REG_23		0x5c
+#define PHY_REG_24		0x60
+#define PHY_REG_25		0x64
+#define PHY_REG_26		0x68
+#define PHY_REG_27		0x6c
+#define PHY_REG_28		0x70
+#define PHY_REG_29		0x74
+#define PHY_REG_30		0x78
+#define PHY_REG_31		0x7c
+#define PHY_REG_32		0x80
+
+/*
+ * REG33 does not match the ref manual. According to Sandor Yu from NXP,
+ * "There is a doc issue on the i.MX8MP latest RM"
+ * REG33 is being used per guidance from Sandor
+ */
+
+#define PHY_REG_33		0x84
+#define  REG33_MODE_SET_DONE	BIT(7)
+#define  REG33_FIX_DA		BIT(1)
+
+#define PHY_REG_34		0x88
+#define  REG34_PHY_READY	BIT(7)
+#define  REG34_PLL_LOCK		BIT(6)
+#define  REG34_PHY_CLK_READY	BIT(5)
+
+#define PHY_REG_35		0x8c
+#define PHY_REG_36		0x90
+#define PHY_REG_37		0x94
+#define PHY_REG_38		0x98
+#define PHY_REG_39		0x9c
+#define PHY_REG_40		0xa0
+#define PHY_REG_41		0xa4
+#define PHY_REG_42		0xa8
+#define PHY_REG_43		0xac
+#define PHY_REG_44		0xb0
+#define PHY_REG_45		0xb4
+#define PHY_REG_46		0xb8
+#define PHY_REG_47		0xbc
+
+#define PHY_PLL_DIV_REGS_NUM 6
+
+struct phy_config {
+	u32	pixclk;
+	u8	pll_div_regs[PHY_PLL_DIV_REGS_NUM];
+};
+
+const struct phy_config phy_pll_cfg[] = {
+	{
+		.pixclk = 22250000,
+		.pll_div_regs = { 0x4b, 0xf1, 0x89, 0x88, 0x80, 0x40 },
+	}, {
+		.pixclk = 23750000,
+		.pll_div_regs = { 0x50, 0xf1, 0x86, 0x85, 0x80, 0x40 },
+	}, {
+		.pixclk = 24000000,
+		.pll_div_regs = { 0x50, 0xf0, 0x00, 0x00, 0x80, 0x00 },
+	}, {
+		.pixclk = 24024000,
+		.pll_div_regs = { 0x50, 0xf1, 0x99, 0x02, 0x80, 0x40 },
+	}, {
+		.pixclk = 25175000,
+		.pll_div_regs = { 0x54, 0xfc, 0xcc, 0x91, 0x80, 0x40 },
+	}, {
+		.pixclk = 25200000,
+		.pll_div_regs = { 0x54, 0xf0, 0x00, 0x00, 0x80, 0x00 },
+	}, {
+		.pixclk = 26750000,
+		.pll_div_regs = { 0x5a, 0xf2, 0x89, 0x88, 0x80, 0x40 },
+	}, {
+		.pixclk = 27000000,
+		.pll_div_regs = { 0x5a, 0xf0, 0x00, 0x00, 0x80, 0x00 },
+	}, {
+		.pixclk = 27027000,
+		.pll_div_regs = { 0x5a, 0xf2, 0xfd, 0x0c, 0x80, 0x40 },
+	}, {
+		.pixclk = 29500000,
+		.pll_div_regs = { 0x62, 0xf4, 0x95, 0x08, 0x80, 0x40 },
+	}, {
+		.pixclk = 30750000,
+		.pll_div_regs = { 0x66, 0xf4, 0x82, 0x01, 0x88, 0x45 },
+	}, {
+		.pixclk = 30888000,
+		.pll_div_regs = { 0x66, 0xf4, 0x99, 0x18, 0x88, 0x45 },
+	}, {
+		.pixclk = 33750000,
+		.pll_div_regs = { 0x70, 0xf4, 0x82, 0x01, 0x80, 0x40 },
+	}, {
+		.pixclk = 35000000,
+		.pll_div_regs = { 0x58, 0xb8, 0x8b, 0x88, 0x80, 0x40 },
+	}, {
+		.pixclk = 36000000,
+		.pll_div_regs = { 0x5a, 0xb0, 0x00, 0x00, 0x80, 0x00 },
+	}, {
+		.pixclk = 36036000,
+		.pll_div_regs = { 0x5a, 0xb2, 0xfd, 0x0c, 0x80, 0x40 },
+	}, {
+		.pixclk = 40000000,
+		.pll_div_regs = { 0x64, 0xb0, 0x00, 0x00, 0x80, 0x00 },
+	}, {
+		.pixclk = 43200000,
+		.pll_div_regs = { 0x5a, 0x90, 0x00, 0x00, 0x80, 0x00 },
+	}, {
+		.pixclk = 43243200,
+		.pll_div_regs = { 0x5a, 0x92, 0xfd, 0x0c, 0x80, 0x40 },
+	}, {
+		.pixclk = 44500000,
+		.pll_div_regs = { 0x5c, 0x92, 0x98, 0x11, 0x84, 0x41 },
+	}, {
+		.pixclk = 47000000,
+		.pll_div_regs = { 0x62, 0x94, 0x95, 0x82, 0x80, 0x40 },
+	}, {
+		.pixclk = 47500000,
+		.pll_div_regs = { 0x63, 0x96, 0xa1, 0x82, 0x80, 0x40 },
+	}, {
+		.pixclk = 50349650,
+		.pll_div_regs = { 0x54, 0x7c, 0xc3, 0x8f, 0x80, 0x40 },
+	}, {
+		.pixclk = 50400000,
+		.pll_div_regs = { 0x54, 0x70, 0x00, 0x00, 0x80, 0x00 },
+	}, {
+		.pixclk = 53250000,
+		.pll_div_regs = { 0x58, 0x72, 0x84, 0x03, 0x82, 0x41 },
+	}, {
+		.pixclk = 53500000,
+		.pll_div_regs = { 0x5a, 0x72, 0x89, 0x88, 0x80, 0x40 },
+	}, {
+		.pixclk = 54000000,
+		.pll_div_regs = { 0x5a, 0x70, 0x00, 0x00, 0x80, 0x00 },
+	}, {
+		.pixclk = 54054000,
+		.pll_div_regs = { 0x5a, 0x72, 0xfd, 0x0c, 0x80, 0x40 },
+	}, {
+		.pixclk = 59000000,
+		.pll_div_regs = { 0x62, 0x74, 0x95, 0x08, 0x80, 0x40 },
+	}, {
+		.pixclk = 59340659,
+		.pll_div_regs = { 0x62, 0x74, 0xdb, 0x52, 0x88, 0x47 },
+	}, {
+		.pixclk = 59400000,
+		.pll_div_regs = { 0x63, 0x70, 0x00, 0x00, 0x80, 0x00 },
+	}, {
+		.pixclk = 61500000,
+		.pll_div_regs = { 0x66, 0x74, 0x82, 0x01, 0x88, 0x45 },
+	}, {
+		.pixclk = 63500000,
+		.pll_div_regs = { 0x69, 0x74, 0x89, 0x08, 0x80, 0x40 },
+	}, {
+		.pixclk = 67500000,
+		.pll_div_regs = { 0x54, 0x52, 0x87, 0x03, 0x80, 0x40 },
+	}, {
+		.pixclk = 70000000,
+		.pll_div_regs = { 0x58, 0x58, 0x8b, 0x88, 0x80, 0x40 },
+	}, {
+		.pixclk = 72000000,
+		.pll_div_regs = { 0x5a, 0x50, 0x00, 0x00, 0x80, 0x00 },
+	}, {
+		.pixclk = 72072000,
+		.pll_div_regs = { 0x5a, 0x52, 0xfd, 0x0c, 0x80, 0x40 },
+	}, {
+		.pixclk = 74176000,
+		.pll_div_regs = { 0x5d, 0x58, 0xdb, 0xA2, 0x88, 0x41 },
+	}, {
+		.pixclk = 74250000,
+		.pll_div_regs = { 0x5c, 0x52, 0x90, 0x0d, 0x84, 0x41 },
+	}, {
+		.pixclk = 78500000,
+		.pll_div_regs = { 0x62, 0x54, 0x87, 0x01, 0x80, 0x40 },
+	}, {
+		.pixclk = 80000000,
+		.pll_div_regs = { 0x64, 0x50, 0x00, 0x00, 0x80, 0x00 },
+	}, {
+		.pixclk = 82000000,
+		.pll_div_regs = { 0x66, 0x54, 0x82, 0x01, 0x88, 0x45 },
+	}, {
+		.pixclk = 82500000,
+		.pll_div_regs = { 0x67, 0x54, 0x88, 0x01, 0x90, 0x49 },
+	}, {
+		.pixclk = 89000000,
+		.pll_div_regs = { 0x70, 0x54, 0x84, 0x83, 0x80, 0x40 },
+	}, {
+		.pixclk = 90000000,
+		.pll_div_regs = { 0x70, 0x54, 0x82, 0x01, 0x80, 0x40 },
+	}, {
+		.pixclk = 94000000,
+		.pll_div_regs = { 0x4e, 0x32, 0xa7, 0x10, 0x80, 0x40 },
+	}, {
+		.pixclk = 95000000,
+		.pll_div_regs = { 0x50, 0x31, 0x86, 0x85, 0x80, 0x40 },
+	}, {
+		.pixclk = 98901099,
+		.pll_div_regs = { 0x52, 0x3a, 0xdb, 0x4c, 0x88, 0x47 },
+	}, {
+		.pixclk = 99000000,
+		.pll_div_regs = { 0x52, 0x32, 0x82, 0x01, 0x88, 0x47 },
+	}, {
+		.pixclk = 100699300,
+		.pll_div_regs = { 0x54, 0x3c, 0xc3, 0x8f, 0x80, 0x40 },
+	}, {
+		.pixclk = 100800000,
+		.pll_div_regs = { 0x54, 0x30, 0x00, 0x00, 0x80, 0x00 },
+	}, {
+		.pixclk = 102500000,
+		.pll_div_regs = { 0x55, 0x32, 0x8c, 0x05, 0x90, 0x4b },
+	}, {
+		.pixclk = 104750000,
+		.pll_div_regs = { 0x57, 0x32, 0x98, 0x07, 0x90, 0x49 },
+	}, {
+		.pixclk = 106500000,
+		.pll_div_regs = { 0x58, 0x32, 0x84, 0x03, 0x82, 0x41 },
+	}, {
+		.pixclk = 107000000,
+		.pll_div_regs = { 0x5a, 0x32, 0x89, 0x88, 0x80, 0x40 },
+	}, {
+		.pixclk = 108000000,
+		.pll_div_regs = { 0x5a, 0x30, 0x00, 0x00, 0x80, 0x00 },
+	}, {
+		.pixclk = 108108000,
+		.pll_div_regs = { 0x5a, 0x32, 0xfd, 0x0c, 0x80, 0x40 },
+	}, {
+		.pixclk = 118000000,
+		.pll_div_regs = { 0x62, 0x34, 0x95, 0x08, 0x80, 0x40 },
+	}, {
+		.pixclk = 118800000,
+		.pll_div_regs = { 0x63, 0x30, 0x00, 0x00, 0x80, 0x00 },
+	}, {
+		.pixclk = 123000000,
+		.pll_div_regs = { 0x66, 0x34, 0x82, 0x01, 0x88, 0x45 },
+	}, {
+		.pixclk = 127000000,
+		.pll_div_regs = { 0x69, 0x34, 0x89, 0x08, 0x80, 0x40 },
+	}, {
+		.pixclk = 135000000,
+		.pll_div_regs = { 0x70, 0x34, 0x82, 0x01, 0x80, 0x40 },
+	}, {
+		.pixclk = 135580000,
+		.pll_div_regs = { 0x71, 0x39, 0xe9, 0x82, 0x9c, 0x5b },
+	}, {
+		.pixclk = 137520000,
+		.pll_div_regs = { 0x72, 0x38, 0x99, 0x10, 0x85, 0x41 },
+	}, {
+		.pixclk = 138750000,
+		.pll_div_regs = { 0x73, 0x35, 0x88, 0x05, 0x90, 0x4d },
+	}, {
+		.pixclk = 140000000,
+		.pll_div_regs = { 0x75, 0x36, 0xa7, 0x90, 0x80, 0x40 },
+	}, {
+		.pixclk = 144000000,
+		.pll_div_regs = { 0x78, 0x30, 0x00, 0x00, 0x80, 0x00 },
+	}, {
+		.pixclk = 148352000,
+		.pll_div_regs = { 0x7b, 0x35, 0xdb, 0x39, 0x90, 0x45 },
+	}, {
+		.pixclk = 148500000,
+		.pll_div_regs = { 0x7b, 0x35, 0x84, 0x03, 0x90, 0x45 },
+	}, {
+		.pixclk = 154000000,
+		.pll_div_regs = { 0x40, 0x18, 0x83, 0x01, 0x00, 0x40 },
+	}, {
+		.pixclk = 157000000,
+		.pll_div_regs = { 0x41, 0x11, 0xa7, 0x14, 0x80, 0x40 },
+	}, {
+		.pixclk = 160000000,
+		.pll_div_regs = { 0x42, 0x12, 0xa1, 0x20, 0x80, 0x40 },
+	}, {
+		.pixclk = 162000000,
+		.pll_div_regs = { 0x43, 0x18, 0x8b, 0x08, 0x96, 0x55 },
+	}, {
+		.pixclk = 164000000,
+		.pll_div_regs = { 0x45, 0x11, 0x83, 0x82, 0x90, 0x4b },
+	}, {
+		.pixclk = 165000000,
+		.pll_div_regs = { 0x45, 0x11, 0x84, 0x81, 0x90, 0x4b },
+	}, {
+		.pixclk = 180000000,
+		.pll_div_regs = { 0x4b, 0x10, 0x00, 0x00, 0x80, 0x00 },
+	}, {
+		.pixclk = 185625000,
+		.pll_div_regs = { 0x4e, 0x12, 0x9a, 0x95, 0x80, 0x40 },
+	}, {
+		.pixclk = 188000000,
+		.pll_div_regs = { 0x4e, 0x12, 0xa7, 0x10, 0x80, 0x40 },
+	}, {
+		.pixclk = 198000000,
+		.pll_div_regs = { 0x52, 0x12, 0x82, 0x01, 0x88, 0x47 },
+	}, {
+		.pixclk = 205000000,
+		.pll_div_regs = { 0x55, 0x12, 0x8c, 0x05, 0x90, 0x4b },
+	}, {
+		.pixclk = 209500000,
+		.pll_div_regs = { 0x57, 0x12, 0x98, 0x07, 0x90, 0x49 },
+	}, {
+		.pixclk = 213000000,
+		.pll_div_regs = { 0x58, 0x12, 0x84, 0x03, 0x82, 0x41 },
+	}, {
+		.pixclk = 216000000,
+		.pll_div_regs = { 0x5a, 0x10, 0x00, 0x00, 0x80, 0x00 },
+	}, {
+		.pixclk = 216216000,
+		.pll_div_regs = { 0x5a, 0x12, 0xfd, 0x0c, 0x80, 0x40 },
+	}, {
+		.pixclk = 237600000,
+		.pll_div_regs = { 0x63, 0x10, 0x00, 0x00, 0x80, 0x00 },
+	}, {
+		.pixclk = 254000000,
+		.pll_div_regs = { 0x69, 0x14, 0x89, 0x08, 0x80, 0x40 },
+	}, {
+		.pixclk = 277500000,
+		.pll_div_regs = { 0x73, 0x15, 0x88, 0x05, 0x90, 0x4d },
+	}, {
+		.pixclk = 288000000,
+		.pll_div_regs = { 0x78, 0x10, 0x00, 0x00, 0x80, 0x00 },
+	}, {
+		.pixclk = 297000000,
+		.pll_div_regs = { 0x7b, 0x15, 0x84, 0x03, 0x90, 0x45 },
+	},
+};
+
+struct reg_settings {
+	u8 reg;
+	u8 val;
+};
+
+const struct reg_settings common_phy_cfg[] = {
+	{ PHY_REG_00, 0x00 }, { PHY_REG_01, 0xd1 },
+	{ PHY_REG_08, 0x4f }, { PHY_REG_09, 0x30 },
+	{ PHY_REG_10, 0x33 }, { PHY_REG_11, 0x65 },
+	/* REG12 pixclk specific */
+	/* REG13 pixclk specific */
+	/* REG14 pixclk specific */
+	{ PHY_REG_15, 0x80 }, { PHY_REG_16, 0x6c },
+	{ PHY_REG_17, 0xf2 }, { PHY_REG_18, 0x67 },
+	{ PHY_REG_19, 0x00 }, { PHY_REG_20, 0x10 },
+	/* REG21 pixclk specific */
+	{ PHY_REG_22, 0x30 }, { PHY_REG_23, 0x32 },
+	{ PHY_REG_24, 0x60 }, { PHY_REG_25, 0x8f },
+	{ PHY_REG_26, 0x00 }, { PHY_REG_27, 0x00 },
+	{ PHY_REG_28, 0x08 }, { PHY_REG_29, 0x00 },
+	{ PHY_REG_30, 0x00 }, { PHY_REG_31, 0x00 },
+	{ PHY_REG_32, 0x00 }, { PHY_REG_33, 0x80 },
+	{ PHY_REG_34, 0x00 }, { PHY_REG_35, 0x00 },
+	{ PHY_REG_36, 0x00 }, { PHY_REG_37, 0x00 },
+	{ PHY_REG_38, 0x00 }, { PHY_REG_39, 0x00 },
+	{ PHY_REG_40, 0x00 }, { PHY_REG_41, 0xe0 },
+	{ PHY_REG_42, 0x83 }, { PHY_REG_43, 0x0f },
+	{ PHY_REG_44, 0x3E }, { PHY_REG_45, 0xf8 },
+	{ PHY_REG_46, 0x00 }, { PHY_REG_47, 0x00 }
+};
+
+struct fsl_samsung_hdmi_phy {
+	struct device *dev;
+	void __iomem *regs;
+	struct clk *apbclk;
+	struct clk *refclk;
+
+	/* clk provider */
+	struct clk_hw hw;
+	const struct phy_config *cur_cfg;
+};
+
+static inline struct fsl_samsung_hdmi_phy *
+to_fsl_samsung_hdmi_phy(struct clk_hw *hw)
+{
+	return container_of(hw, struct fsl_samsung_hdmi_phy, hw);
+}
+
+static void
+fsl_samsung_hdmi_phy_configure_pixclk(struct fsl_samsung_hdmi_phy *phy,
+				      const struct phy_config *cfg)
+{
+	u8 div;
+
+	switch (cfg->pixclk) {
+	case  22250000 ...  33750000:
+		div = 0xf;
+		break;
+	case  35000000 ...  40000000:
+		div = 0xb;
+		break;
+	case  43200000 ...  47500000:
+		div = 0x9;
+		break;
+	case  50349650 ...  63500000:
+		div = 0x7;
+		break;
+	case  67500000 ...  90000000:
+		div = 0x5;
+		break;
+	case  94000000 ... 148500000:
+		div = 0x3;
+		break;
+	case 154000000 ... 297000000:
+		div = 0x1;
+		break;
+	}
+
+	writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK, div),
+	       phy->regs + PHY_REG_21);
+}
+
+static void
+fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
+					    const struct phy_config *cfg)
+{
+	u32 pclk = cfg->pixclk;
+	u32 fld_tg_code;
+	u32 pclk_khz;
+	u8 div;
+
+	switch (cfg->pixclk) {
+	case  22250000 ...  47500000:
+		div = 1;
+		break;
+	case  50349650 ...  99000000:
+		div = 2;
+		break;
+	case 100699300 ... 198000000:
+		div = 4;
+		break;
+	case 205000000 ... 297000000:
+		div = 8;
+		break;
+	}
+
+	writeb(FIELD_PREP(REG12_CK_DIV_MASK, ilog2(div)), phy->regs + PHY_REG_12);
+
+	/*
+	 * Calculation for the frequency lock detector target code (fld_tg_code)
+	 * is based on reference manual register description of PHY_REG13
+	 * (13.10.3.1.14.2):
+	 *   1st) Calculate int_pllclk which is determinded by FLD_CK_DIV
+	 *   2nd) Increase resolution to avoid rounding issues
+	 *   3th) Do the div (256 / Freq. of int_pllclk) * 24
+	 *   4th) Reduce the resolution and always round up since the NXP
+	 *        settings rounding up always too. TODO: Check if that is
+	 *        correct.
+	 */
+	pclk /= div;
+	pclk_khz = pclk / 1000;
+	fld_tg_code = 256 * 1000 * 1000 / pclk_khz * 24;
+	fld_tg_code = DIV_ROUND_UP(fld_tg_code, 1000);
+
+	/* FLD_TOL and FLD_RP_CODE taken from downstream driver */
+	writeb(FIELD_PREP(REG13_TG_CODE_LOW_MASK, fld_tg_code),
+	       phy->regs + PHY_REG_13);
+	writeb(FIELD_PREP(REG14_TOL_MASK, 2) |
+	       FIELD_PREP(REG14_RP_CODE_MASK, 2) |
+	       FIELD_PREP(REG14_TG_CODE_HIGH_MASK, fld_tg_code >> 8),
+	       phy->regs + PHY_REG_14);
+}
+
+static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
+					  const struct phy_config *cfg)
+{
+	int i, ret;
+	u8 val;
+
+	/* HDMI PHY init */
+	writeb(REG33_FIX_DA, phy->regs + PHY_REG_33);
+
+	/* common PHY registers */
+	for (i = 0; i < ARRAY_SIZE(common_phy_cfg); i++)
+		writeb(common_phy_cfg[i].val, phy->regs + common_phy_cfg[i].reg);
+
+	/* set individual PLL registers PHY_REG2 ... PHY_REG7 */
+	for (i = 0; i < PHY_PLL_DIV_REGS_NUM; i++)
+		writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG_02 + i * 4);
+
+	fsl_samsung_hdmi_phy_configure_pixclk(phy, cfg);
+	fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
+
+	writeb(REG33_FIX_DA | REG33_MODE_SET_DONE, phy->regs + PHY_REG_33);
+
+	ret = readb_poll_timeout(phy->regs + PHY_REG_34, val,
+				 val & REG34_PLL_LOCK, 50, 20000);
+	if (ret)
+		dev_err(phy->dev, "PLL failed to lock\n");
+
+	return ret;
+}
+
+static unsigned long phy_clk_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct fsl_samsung_hdmi_phy *phy = to_fsl_samsung_hdmi_phy(hw);
+
+	if (!phy->cur_cfg)
+		return 74250000;
+
+	return phy->cur_cfg->pixclk;
+}
+
+static long phy_clk_round_rate(struct clk_hw *hw,
+			       unsigned long rate, unsigned long *parent_rate)
+{
+	int i;
+
+	for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
+		if (phy_pll_cfg[i].pixclk <= rate)
+			return phy_pll_cfg[i].pixclk;
+
+	return -EINVAL;
+}
+
+static int phy_clk_set_rate(struct clk_hw *hw,
+			    unsigned long rate, unsigned long parent_rate)
+{
+	struct fsl_samsung_hdmi_phy *phy = to_fsl_samsung_hdmi_phy(hw);
+	int i;
+
+	for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
+		if (phy_pll_cfg[i].pixclk <= rate)
+			break;
+
+	if (i < 0)
+		return -EINVAL;
+
+	phy->cur_cfg = &phy_pll_cfg[i];
+
+	return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
+}
+
+static const struct clk_ops phy_clk_ops = {
+	.recalc_rate = phy_clk_recalc_rate,
+	.round_rate = phy_clk_round_rate,
+	.set_rate = phy_clk_set_rate,
+};
+
+static int phy_clk_register(struct fsl_samsung_hdmi_phy *phy)
+{
+	struct device *dev = phy->dev;
+	struct device_node *np = dev->of_node;
+	struct clk_init_data init;
+	const char *parent_name;
+	struct clk *phyclk;
+	int ret;
+
+	parent_name = __clk_get_name(phy->refclk);
+
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	init.flags = 0;
+	init.name = "hdmi_pclk";
+	init.ops = &phy_clk_ops;
+
+	phy->hw.init = &init;
+
+	phyclk = devm_clk_register(dev, &phy->hw);
+	if (IS_ERR(phyclk))
+		return dev_err_probe(dev, PTR_ERR(phyclk),
+				     "failed to register clock\n");
+
+	ret = of_clk_add_provider(np, of_clk_src_simple_get, phyclk);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register clock provider\n");
+
+	return 0;
+}
+
+static int fsl_samsung_hdmi_phy_probe(struct platform_device *pdev)
+{
+	struct fsl_samsung_hdmi_phy *phy;
+	int ret;
+
+	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, phy);
+	phy->dev = &pdev->dev;
+
+	phy->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(phy->regs))
+		return PTR_ERR(phy->regs);
+
+	phy->apbclk = devm_clk_get(phy->dev, "apb");
+	if (IS_ERR(phy->apbclk))
+		return dev_err_probe(phy->dev, PTR_ERR(phy->apbclk),
+				     "failed to get apb clk\n");
+
+	phy->refclk = devm_clk_get(phy->dev, "ref");
+	if (IS_ERR(phy->refclk))
+		return dev_err_probe(phy->dev, PTR_ERR(phy->refclk),
+				     "failed to get ref clk\n");
+
+	ret = clk_prepare_enable(phy->apbclk);
+	if (ret) {
+		dev_err(phy->dev, "failed to enable apbclk\n");
+		return ret;
+	}
+
+	pm_runtime_get_noresume(phy->dev);
+	pm_runtime_set_active(phy->dev);
+	pm_runtime_enable(phy->dev);
+
+	ret = phy_clk_register(phy);
+	if (ret) {
+		dev_err(&pdev->dev, "register clk failed\n");
+		goto register_clk_failed;
+	}
+
+	pm_runtime_put(phy->dev);
+
+	return 0;
+
+register_clk_failed:
+	clk_disable_unprepare(phy->apbclk);
+
+	return ret;
+}
+
+static int fsl_samsung_hdmi_phy_remove(struct platform_device *pdev)
+{
+	of_clk_del_provider(pdev->dev.of_node);
+
+	return 0;
+}
+
+static int fsl_samsung_hdmi_phy_suspend(struct device *dev)
+{
+	struct fsl_samsung_hdmi_phy *phy = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(phy->apbclk);
+
+	return 0;
+}
+
+static int fsl_samsung_hdmi_phy_resume(struct device *dev)
+{
+	struct fsl_samsung_hdmi_phy *phy = dev_get_drvdata(dev);
+	int ret = 0;
+
+	ret = clk_prepare_enable(phy->apbclk);
+	if (ret) {
+		dev_err(phy->dev, "failed to enable apbclk\n");
+		return ret;
+	}
+
+	if (phy->cur_cfg)
+		ret = fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
+
+	return ret;
+
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(fsl_samsung_hdmi_phy_pm_ops,
+				 fsl_samsung_hdmi_phy_suspend,
+				 fsl_samsung_hdmi_phy_resume, NULL);
+
+static const struct of_device_id fsl_samsung_hdmi_phy_of_match[] = {
+	{
+		.compatible = "fsl,imx8mp-hdmi-phy",
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, fsl_samsung_hdmi_phy_of_match);
+
+static struct platform_driver fsl_samsung_hdmi_phy_driver = {
+	.probe  = fsl_samsung_hdmi_phy_probe,
+	.remove = fsl_samsung_hdmi_phy_remove,
+	.driver = {
+		.name = "fsl-samsung-hdmi-phy",
+		.of_match_table = fsl_samsung_hdmi_phy_of_match,
+		.pm = pm_ptr(&fsl_samsung_hdmi_phy_pm_ops),
+	},
+};
+module_platform_driver(fsl_samsung_hdmi_phy_driver);
+
+MODULE_AUTHOR("Sandor Yu <Sandor.yu@nxp.com>");
+MODULE_DESCRIPTION("SAMSUNG HDMI 2.0 Transmitter PHY Driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


