Return-Path: <linux-kernel+bounces-62142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F259851C24
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844151F2316A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD43745943;
	Mon, 12 Feb 2024 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="eluW8pGd"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421F647A5C;
	Mon, 12 Feb 2024 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760329; cv=none; b=SR622Q0dSLR5ACRxs1moAfESgChORbm4A34WSwOq53ltIwzo7+ENN12lYIQmj5O2CJCanLa3RWfXdOvwxqYCikuV3ahqqfaYhj7/RPv44aiqu7DgbXDWRYaWwDTQ658YAteS8EpISfc7/eim1rD5JE9K7UZQozOB9SPoEhTDrZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760329; c=relaxed/simple;
	bh=MufxIPI+sfhGlYDGH/yYw/RZ9xHX0C9eXHu9vHVABb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5Vx4nY35wAkpM7iME4Gk1C0qemG99j1n1GSAYSeH+M/caDTRn5VeYyvp18ybflJAGKwpFuWESKVpwCCbiGL/OYx1/v20N3ik8gN4gmnrSb0bf4xKi21WV+0DoOZykCCKxVpvyUngfdWADalz7Rv1LOx1GWJpdYHX1p6kHl7HWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=eluW8pGd; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CEfn0A026396;
	Mon, 12 Feb 2024 18:51:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=3EOXGoTP+R1HW7bP4qKKmfrikdGwpwacU3HR0veKSg4=; b=el
	uW8pGdUiMv+RW2wNLCdHpR7DTNIH2WyS8myye/rSOzYCqvGCu+3WU6lGCM0YP5Xa
	DBGIDi3NFHC1sBd79xQJGtYMBjVao80MqLEn8MxPzjlvQ9x2T3SffP0UA+aiM6tf
	ZoAIVyO9+zVpnnfVbkuVIMDGvsctQ4ffr60whzJkG9itTwfx7mmgeFlEZiLWBejh
	bHTui8qLZ4nDuDhiGwwmie1Myv8idxzW4IqUNQa6NTlGKTlB/CC56MIYMalmW8lq
	y065hj6fXsOiLcIlW+xaUT25M9VJz4V8YXQbkZ8qmL8d0jLhB/D2iACr+AOyL9tE
	xkkQtX4vjOsjY35AcIyw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w6kk4nb2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 18:51:54 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AE0CB40044;
	Mon, 12 Feb 2024 18:51:50 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 15EAF231529;
	Mon, 12 Feb 2024 18:51:07 +0100 (CET)
Received: from localhost (10.201.22.200) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 12 Feb
 2024 18:51:06 +0100
From: Christophe Kerello <christophe.kerello@foss.st.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH 10/12] mtd: rawnand: stm32_fmc2: add a platform data structure
Date: Mon, 12 Feb 2024 18:48:20 +0100
Message-ID: <20240212174822.77734-11-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240212174822.77734-1-christophe.kerello@foss.st.com>
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_15,2024-02-12_03,2023-05-22_02

Before the introduction of MP25 SOC, let's use a platform data
structure for parameters that will differ (number of chip select).

The FMC2 NAND can support up to 4 chips select. On MP1 SOCs, only 2
chip select are available.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 32 +++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index a7db7b675514..c5bdb43f7221 100644
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
@@ -243,6 +244,10 @@ static inline struct stm32_fmc2_nand *to_fmc2_nand(struct nand_chip *chip)
 	return container_of(chip, struct stm32_fmc2_nand, chip);
 }
 
+struct stm32_fmc2_nfc_data {
+	int max_ncs;
+};
+
 struct stm32_fmc2_nfc {
 	struct nand_controller base;
 	struct stm32_fmc2_nand nand;
@@ -256,6 +261,7 @@ struct stm32_fmc2_nfc {
 	phys_addr_t data_phys_addr[FMC2_MAX_CE];
 	struct clk *clk;
 	u8 irq_state;
+	const struct stm32_fmc2_nfc_data *data;
 
 	struct dma_chan *dma_tx_ch;
 	struct dma_chan *dma_rx_ch;
@@ -1809,7 +1815,7 @@ static int stm32_fmc2_nfc_parse_child(struct stm32_fmc2_nfc *nfc,
 			return ret;
 		}
 
-		if (cs >= FMC2_MAX_CE) {
+		if (cs >= nfc->data->max_ncs) {
 			dev_err(nfc->dev, "invalid reg value: %d\n", cs);
 			return -EINVAL;
 		}
@@ -1915,6 +1921,10 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
 	nand_controller_init(&nfc->base);
 	nfc->base.ops = &stm32_fmc2_nfc_controller_ops;
 
+	nfc->data = of_device_get_match_data(dev);
+	if (!nfc->data)
+		return -EINVAL;
+
 	ret = stm32_fmc2_nfc_set_cdev(nfc);
 	if (ret)
 		return ret;
@@ -1936,7 +1946,7 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
 	if (nfc->dev == nfc->cdev)
 		start_region = 1;
 
-	for (chip_cs = 0, mem_region = start_region; chip_cs < FMC2_MAX_CE;
+	for (chip_cs = 0, mem_region = start_region; chip_cs < nfc->data->max_ncs;
 	     chip_cs++, mem_region += 3) {
 		if (!(nfc->cs_assigned & BIT(chip_cs)))
 			continue;
@@ -2092,7 +2102,7 @@ static int __maybe_unused stm32_fmc2_nfc_resume(struct device *dev)
 
 	stm32_fmc2_nfc_wp_disable(nand);
 
-	for (chip_cs = 0; chip_cs < FMC2_MAX_CE; chip_cs++) {
+	for (chip_cs = 0; chip_cs < nfc->data->max_ncs; chip_cs++) {
 		if (!(nfc->cs_assigned & BIT(chip_cs)))
 			continue;
 
@@ -2105,9 +2115,19 @@ static int __maybe_unused stm32_fmc2_nfc_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(stm32_fmc2_nfc_pm_ops, stm32_fmc2_nfc_suspend,
 			 stm32_fmc2_nfc_resume);
 
+static const struct stm32_fmc2_nfc_data stm32_fmc2_nfc_mp1_data = {
+	.max_ncs = 2,
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
 	{}
 };
 MODULE_DEVICE_TABLE(of, stm32_fmc2_nfc_match);
-- 
2.25.1


