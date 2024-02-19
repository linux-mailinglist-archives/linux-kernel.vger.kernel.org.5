Return-Path: <linux-kernel+bounces-71453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A98185A573
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE451C208ED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7A937160;
	Mon, 19 Feb 2024 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="GaI+akPG"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF63376EA;
	Mon, 19 Feb 2024 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708351650; cv=none; b=G8E+CFslzgGMUH5m1nqAC39gYHQmhqoL1xC3d9gUpYZU0xLSVngd4xQGcjIRoSEo5BWeG0MxAaFnQ52Y5MMAMMSWJN2IYT4jtJ+0sehVAyzYDV5hVO4rdZZUSibJOvM8G3EWqyugC776SXrRNmZshYIPPyVqVtYgGw6Ni6sZ8wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708351650; c=relaxed/simple;
	bh=nFKSpS3PemvDLmUNh7OXOjfDkEFFKvCwt+Q77tt/2Iw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QbiE8MbXTuQUTF33n9MmYlqRXHLORNol01CUYGK5YPzDZiz/x9rh2iEm0O4jY2ziGWqBWOq5imfxxZCvfwEpmv17vK9EWHkzGHfBRZkbZA7lQ1Xa6u94KW/sxP7cJDX/IkCTqsQ/Ojec9ZXFRrubOTVceBQlTBxyWcgMLvE20Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=GaI+akPG; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41JBjavi010682;
	Mon, 19 Feb 2024 15:07:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=bQIpKoFRIw2Mc0ACsi+d25xPFjAM3ujZnUnmxEvKVDY=; b=Ga
	I+akPG5hcdjMPrIxO32nIQ+rVS5/yxR16g2OB0jZr4VqIMFT77VcbbIzBiFMXvAh
	eCF3pemAGBBHbIfGQGkqyDOvJvRKX2ixnY5jLP8oDjrmhlY3ljGYQ9cWMH0ldAn8
	6qn8BS8jCvEJvF1oGxEgVsf+N7kqr7f6fmuT9TSkvuJD5Sy65649gDx2XgPzzY2C
	wz9RYzCyEGDGzVv3TL5hSVAaWBed9qZWciLiHmqPAinrc/kIzunsiGYUKJyxjn2a
	sheWuKpWyr7m4+KOTzxIBmsJ3Y6GhqczSVVwm1mQBjNaDfO9OEC72UrjZAR0ZHB6
	NNDdi2xMRQWJ6+J1YZCw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wan11q1ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 15:07:04 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D8A034002D;
	Mon, 19 Feb 2024 15:06:47 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3EF532690A8;
	Mon, 19 Feb 2024 15:06:07 +0100 (CET)
Received: from localhost (10.201.21.177) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 19 Feb
 2024 15:06:06 +0100
From: Christophe Kerello <christophe.kerello@foss.st.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH v2 3/3] mtd: rawnand: stm32_fmc2: add MP25 support
Date: Mon, 19 Feb 2024 15:05:05 +0100
Message-ID: <20240219140505.85794-4-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240219140505.85794-1-christophe.kerello@foss.st.com>
References: <20240219140505.85794-1-christophe.kerello@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_10,2024-02-19_01,2023-05-22_02

FMC2 IP supports up to 4 chip select. On MP1 SoC, only 2 of them are
available when on MP25 SoC, the 4 chip select are available.

Let's use a platform data structure for parameters that will differ.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
Changes in v2:
 - V1 patch 10, 11 and 12 have been squashed and reworked.
 - a platform data structure is handling the difference between MP1 and MP25.

 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 54 +++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index a7db7b675514..264556939a00 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -37,7 +38,7 @@
 #define FMC2_MAX_SG			16
 
 /* Max chip enable */
-#define FMC2_MAX_CE			2
+#define FMC2_MAX_CE			4
 
 /* Max ECC buffer length */
 #define FMC2_MAX_ECC_BUF_LEN		(FMC2_BCHDSRS_LEN * FMC2_MAX_SG)
@@ -243,6 +244,13 @@ static inline struct stm32_fmc2_nand *to_fmc2_nand(struct nand_chip *chip)
 	return container_of(chip, struct stm32_fmc2_nand, chip);
 }
 
+struct stm32_fmc2_nfc;
+
+struct stm32_fmc2_nfc_data {
+	int max_ncs;
+	int (*set_cdev)(struct stm32_fmc2_nfc *nfc);
+};
+
 struct stm32_fmc2_nfc {
 	struct nand_controller base;
 	struct stm32_fmc2_nand nand;
@@ -256,6 +264,7 @@ struct stm32_fmc2_nfc {
 	phys_addr_t data_phys_addr[FMC2_MAX_CE];
 	struct clk *clk;
 	u8 irq_state;
+	const struct stm32_fmc2_nfc_data *data;
 
 	struct dma_chan *dma_tx_ch;
 	struct dma_chan *dma_rx_ch;
@@ -1809,7 +1818,7 @@ static int stm32_fmc2_nfc_parse_child(struct stm32_fmc2_nfc *nfc,
 			return ret;
 		}
 
-		if (cs >= FMC2_MAX_CE) {
+		if (cs >= nfc->data->max_ncs) {
 			dev_err(nfc->dev, "invalid reg value: %d\n", cs);
 			return -EINVAL;
 		}
@@ -1915,9 +1924,17 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
 	nand_controller_init(&nfc->base);
 	nfc->base.ops = &stm32_fmc2_nfc_controller_ops;
 
-	ret = stm32_fmc2_nfc_set_cdev(nfc);
-	if (ret)
-		return ret;
+	nfc->data = of_device_get_match_data(dev);
+	if (!nfc->data)
+		return -EINVAL;
+
+	if (nfc->data->set_cdev) {
+		ret = nfc->data->set_cdev(nfc);
+		if (ret)
+			return ret;
+	} else {
+		nfc->cdev = dev->parent;
+	}
 
 	ret = stm32_fmc2_nfc_parse_dt(nfc);
 	if (ret)
@@ -1936,7 +1953,7 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
 	if (nfc->dev == nfc->cdev)
 		start_region = 1;
 
-	for (chip_cs = 0, mem_region = start_region; chip_cs < FMC2_MAX_CE;
+	for (chip_cs = 0, mem_region = start_region; chip_cs < nfc->data->max_ncs;
 	     chip_cs++, mem_region += 3) {
 		if (!(nfc->cs_assigned & BIT(chip_cs)))
 			continue;
@@ -2092,7 +2109,7 @@ static int __maybe_unused stm32_fmc2_nfc_resume(struct device *dev)
 
 	stm32_fmc2_nfc_wp_disable(nand);
 
-	for (chip_cs = 0; chip_cs < FMC2_MAX_CE; chip_cs++) {
+	for (chip_cs = 0; chip_cs < nfc->data->max_ncs; chip_cs++) {
 		if (!(nfc->cs_assigned & BIT(chip_cs)))
 			continue;
 
@@ -2105,9 +2122,28 @@ static int __maybe_unused stm32_fmc2_nfc_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(stm32_fmc2_nfc_pm_ops, stm32_fmc2_nfc_suspend,
 			 stm32_fmc2_nfc_resume);
 
+static const struct stm32_fmc2_nfc_data stm32_fmc2_nfc_mp1_data = {
+	.max_ncs = 2,
+	.set_cdev = stm32_fmc2_nfc_set_cdev,
+};
+
+static const struct stm32_fmc2_nfc_data stm32_fmc2_nfc_mp25_data = {
+	.max_ncs = 4,
+};
+
 static const struct of_device_id stm32_fmc2_nfc_match[] = {
-	{.compatible = "st,stm32mp15-fmc2"},
-	{.compatible = "st,stm32mp1-fmc2-nfc"},
+	{
+		.compatible = "st,stm32mp15-fmc2",
+		.data = &stm32_fmc2_nfc_mp1_data,
+	},
+	{
+		.compatible = "st,stm32mp1-fmc2-nfc",
+		.data = &stm32_fmc2_nfc_mp1_data,
+	},
+	{
+		.compatible = "st,stm32mp25-fmc2-nfc",
+		.data = &stm32_fmc2_nfc_mp25_data,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, stm32_fmc2_nfc_match);
-- 
2.25.1


