Return-Path: <linux-kernel+bounces-71452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560DB85A571
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884241C21891
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ECC36B1D;
	Mon, 19 Feb 2024 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="TKiSSgtT"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FB1374EC;
	Mon, 19 Feb 2024 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708351622; cv=none; b=bLc2NN9dTcTD+tG+SlFKsC5onnWsSPLDYRFH6A0fmGEOwHK1jteikItpQZdzrl7qn5yOrrvEL1ZBjmxfT4Gg1ECo1Ag0SHb1A724K5Eylxa7Fvg1ljOS19K6wZM/SiKFtOEl07+iGQSzsWTBzk+bRdrx4RVTyjVMbFopuzcMCYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708351622; c=relaxed/simple;
	bh=RdsRzreTHMNz57nWCI2dsPZimXgvZiMRK3IDydqC72A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0DzjysxjboYf1qf4iEP6gmCy13jov8Ko7BEcLXbz6WyAx8N224n6otWnkaidi/v8pMvRt24DQjL5LZNL/kF2zeOLfKdFKdT30YgghpnD2Jw7/Lp2BhD0juLuPTm2eg52KKI6LoRfCdxcciFZ8JXN5WEpgJkvaqEmQMfg3bPj9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=TKiSSgtT; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41JDQ2Na016201;
	Mon, 19 Feb 2024 15:06:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=vJQs1g05kFP9D2QsdMX/NjwJEI2VkKEsSmtoy+yfc1E=; b=TK
	iSSgtTb/aTFX4S3Ej5Wqf1zIN0iU5pguH0UrfUR6PtAUREpDtJfHVuhn1GmP87J6
	mUs2I4C3ClOP/W784Gc7t+EFXX7EjMmk7Zo9hESUQCPTAiqiIkc/+aXGUdvDdzm5
	YehHkGZ4dsIyNs3TxzcyLjS+qpH0cuBISDdoifnfXUSXcsBv7ozF3E7ZHCQlEjCi
	lE3uz0zlhEX/L4qVQ/Er1ASs6NL0micENcgFwr4iPJkoBZAs3/8AhDfzYPYAzbD4
	ONxfO9cH5mPYes9aM1yaJhtxZxxeI3k/QJb8aCdrEQvGImh9+uJAgARYmDRoSDKz
	a0MsvXyC1YrXewKqHIHg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wajt8eus9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 15:06:35 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DB22E4002D;
	Mon, 19 Feb 2024 15:06:31 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4693B26A9A9;
	Mon, 19 Feb 2024 15:05:51 +0100 (CET)
Received: from localhost (10.201.21.177) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 19 Feb
 2024 15:05:50 +0100
From: Christophe Kerello <christophe.kerello@foss.st.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH v2 2/3] mtd: rawnand: stm32_fmc2: use dma_get_slave_caps to get DMA max burst
Date: Mon, 19 Feb 2024 15:05:04 +0100
Message-ID: <20240219140505.85794-3-christophe.kerello@foss.st.com>
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

Use dma_get_slave_caps API to get the max burst size of a DMA channel.

For MP1 SoCs, MDMA is used and the max burst size is 128.
For MP25 SoC, DMA3 is used and the max burst size is 64.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 29 +++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index 88811139aaf5..a7db7b675514 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -264,6 +264,8 @@ struct stm32_fmc2_nfc {
 	struct sg_table dma_ecc_sg;
 	u8 *ecc_buf;
 	int dma_ecc_len;
+	u32 tx_dma_max_burst;
+	u32 rx_dma_max_burst;
 
 	struct completion complete;
 	struct completion dma_data_complete;
@@ -347,20 +349,26 @@ static int stm32_fmc2_nfc_select_chip(struct nand_chip *chip, int chipnr)
 	stm32_fmc2_nfc_setup(chip);
 	stm32_fmc2_nfc_timings_init(chip);
 
-	if (nfc->dma_tx_ch && nfc->dma_rx_ch) {
+	if (nfc->dma_tx_ch) {
 		memset(&dma_cfg, 0, sizeof(dma_cfg));
-		dma_cfg.src_addr = nfc->data_phys_addr[nfc->cs_sel];
 		dma_cfg.dst_addr = nfc->data_phys_addr[nfc->cs_sel];
-		dma_cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		dma_cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		dma_cfg.src_maxburst = 32;
-		dma_cfg.dst_maxburst = 32;
+		dma_cfg.dst_maxburst = nfc->tx_dma_max_burst /
+				       dma_cfg.dst_addr_width;
 
 		ret = dmaengine_slave_config(nfc->dma_tx_ch, &dma_cfg);
 		if (ret) {
 			dev_err(nfc->dev, "tx DMA engine slave config failed\n");
 			return ret;
 		}
+	}
+
+	if (nfc->dma_rx_ch) {
+		memset(&dma_cfg, 0, sizeof(dma_cfg));
+		dma_cfg.src_addr = nfc->data_phys_addr[nfc->cs_sel];
+		dma_cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		dma_cfg.src_maxburst = nfc->rx_dma_max_burst /
+				       dma_cfg.src_addr_width;
 
 		ret = dmaengine_slave_config(nfc->dma_rx_ch, &dma_cfg);
 		if (ret) {
@@ -1545,6 +1553,7 @@ static int stm32_fmc2_nfc_setup_interface(struct nand_chip *chip, int chipnr,
 
 static int stm32_fmc2_nfc_dma_setup(struct stm32_fmc2_nfc *nfc)
 {
+	struct dma_slave_caps caps;
 	int ret = 0;
 
 	nfc->dma_tx_ch = dma_request_chan(nfc->dev, "tx");
@@ -1557,6 +1566,11 @@ static int stm32_fmc2_nfc_dma_setup(struct stm32_fmc2_nfc *nfc)
 		goto err_dma;
 	}
 
+	ret = dma_get_slave_caps(nfc->dma_tx_ch, &caps);
+	if (ret)
+		return ret;
+	nfc->tx_dma_max_burst = caps.max_burst;
+
 	nfc->dma_rx_ch = dma_request_chan(nfc->dev, "rx");
 	if (IS_ERR(nfc->dma_rx_ch)) {
 		ret = PTR_ERR(nfc->dma_rx_ch);
@@ -1567,6 +1581,11 @@ static int stm32_fmc2_nfc_dma_setup(struct stm32_fmc2_nfc *nfc)
 		goto err_dma;
 	}
 
+	ret = dma_get_slave_caps(nfc->dma_rx_ch, &caps);
+	if (ret)
+		return ret;
+	nfc->rx_dma_max_burst = caps.max_burst;
+
 	nfc->dma_ecc_ch = dma_request_chan(nfc->dev, "ecc");
 	if (IS_ERR(nfc->dma_ecc_ch)) {
 		ret = PTR_ERR(nfc->dma_ecc_ch);
-- 
2.25.1


