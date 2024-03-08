Return-Path: <linux-kernel+bounces-96738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0332E8760D7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AE63B220A8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346A75579D;
	Fri,  8 Mar 2024 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Khqaen6P"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CFB54BFC;
	Fri,  8 Mar 2024 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709889518; cv=none; b=B4Fr1iAeQ1AlqaM9M4n1rYNYB3HYAAVUq/yFxxCZEBXyWqW1mjKRxTVwkTv9pjgt/U+R7AuT8f2I2FQqmLc0h5HQqk7EYmaPfGPtsxTlkcfWe03tQU05IfvZn6sE6qukWe/QAT0gx8/aq+S9VUm/eWCLmJXpYndKJZ/lZG29l+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709889518; c=relaxed/simple;
	bh=oqxuhv+j0PaBKbdI62Zfjqix+GAsw5CLmKuwYh/098s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YGm901MGIutqW3x8ZEZ9M5E8x8+2hw2c8diutV+EQAyTofBzlvagNsCgToQKyWppWA4wVnr20nxDk9sR8+iw+YGCbzKM76p0kd/tfXd8cdBYcJUpPk41P7XB6n1og5wg07DkxB9awOD3vOrY3SaUjJl8FRl5mroNOsQa/ujr3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Khqaen6P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4283jKTP013985;
	Fri, 8 Mar 2024 09:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=4gJ+Vwh
	Z6H62p7IHYUKk2W2ftg/7QzlT8sOZ1RrIMl8=; b=Khqaen6PJSrl/YuQY529hDS
	8ZJqb7LjJB2YWsOsqShYfceZP9VwxJ9Mzvuo0cpNKgN1xSid+8bVsH8WBvotcst/
	1UH8DtX/1gDZBNU5weHJX2ymgjGLtnoBTooSKk7z2s1okI4hKMbHeByJEgt8Bx1B
	/tj4iDDhFPB1CCwpMJYcXysB/hwJvIsm1cTJNhFV4Mhx2OxQmOgN+CcCv98iRlGb
	PYkHpxvHposMcRiqph/jEfo+FqiyifQpht4F3H8PVlZaCQAcOSctsqoGNBCtw7Dy
	9j7D38fgpRSEEFFM2gbuGLwFVBz/BGa9sdtrqwYjoDw6shtxZCJ00dPSgeaz8zA=
	=
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqn8q1at1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 09:18:02 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 4289HupW000775;
	Fri, 8 Mar 2024 09:17:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3wkw6m3h0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 09:17:56 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4289HtUV000743;
	Fri, 8 Mar 2024 09:17:56 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4289HtY2000739
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 09:17:55 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id EDBF84135B; Fri,  8 Mar 2024 14:47:54 +0530 (+0530)
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org, broonie@kernel.org,
        robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, manivannan.sadhasivam@linaro.org,
        neil.armstrong@linaro.org, daniel@makrotopia.org, arnd@arndb.de,
        chris.packham@alliedtelesis.co.nz, christophe.kerello@foss.st.com,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com,
        quic_mdalam@quicinc.com
Subject: [PATCH v4 2/5] drivers: mtd: nand: Add qpic_common API file
Date: Fri,  8 Mar 2024 14:47:49 +0530
Message-Id: <20240308091752.16136-3-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308091752.16136-1-quic_mdalam@quicinc.com>
References: <20240308091752.16136-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PCJLK9QmHJt8JdLr-JPWGsKv5ZagaFSf
X-Proofpoint-ORIG-GUID: PCJLK9QmHJt8JdLr-JPWGsKv5ZagaFSf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_06,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080073

Add qpic_common.c file which hold all the common
qpic APIs which will be used by both qpic raw nand
driver and qpic spi nand driver.

Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
Change in [v4]

* Added kernel doc for all common api as per kernel doc
  standard

* Added QPIC_COMMON config to build qpic_common.c

Change in [v3]

* Added original copy right

* Removed all EXPORT_SYMBOL()

* Made this common api file more generic

* Added qcom_ prefix to all api in this file

* Removed devm_kfree and added kfree

* Moved to_qcom_nand_controller() to raw nand driver
  since it was only used by raw nand driver, so not needed
  as common

* Added kernel doc for all api

* made reverse tree of variable declaration in 
  prep_adm_dma_desc() function

* Added if(!ret) condition in prep_adm_dma_desc()
  function

* Initialized slave_conf as 0 while declaration

Change in [v2]

* Posted initial support for common api file

Change in [v1]

* Posted as RFC patch for design review

 drivers/mtd/nand/Kconfig             |    7 +
 drivers/mtd/nand/Makefile            |    1 +
 drivers/mtd/nand/qpic_common.c       |  826 +++++++++++++++
 drivers/mtd/nand/raw/Kconfig         |    1 +
 drivers/mtd/nand/raw/qcom_nandc.c    | 1440 +++-----------------------
 include/linux/mtd/nand-qpic-common.h |  486 +++++++++
 6 files changed, 1456 insertions(+), 1305 deletions(-)
 create mode 100644 drivers/mtd/nand/qpic_common.c
 create mode 100644 include/linux/mtd/nand-qpic-common.h

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 5b0c2c95f10c..609072c5fd9e 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -61,6 +61,13 @@ config MTD_NAND_ECC_MEDIATEK
 	help
 	  This enables support for the hardware ECC engine from Mediatek.
 
+config QPIC_COMMON
+	tristate "QPIC common api file"
+	depends on ARCH_QCOM || COMPILE_TEST
+	help
+	  This enables support for common api for qpic nand controller.
+	  common apis will be used by both raw nand driver and serial nand
+	  driver.
 endmenu
 
 endmenu
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 19e1291ac4d5..c0c1f8bd0220 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -3,6 +3,7 @@
 nandcore-objs := core.o bbt.o
 obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
 obj-$(CONFIG_MTD_NAND_ECC_MEDIATEK) += ecc-mtk.o
+obj-$(CONFIG_QPIC_COMMON) += qpic_common.o
 
 obj-y	+= onenand/
 obj-y	+= raw/
diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_common.c
new file mode 100644
index 000000000000..5b7c0d119d9a
--- /dev/null
+++ b/drivers/mtd/nand/qpic_common.c
@@ -0,0 +1,826 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2016, The Linux Foundation. All rights reserved.
+ */
+#include <linux/mtd/nand-qpic-common.h>
+
+
+/**
+ * qcom_free_bam_transaction() - Frees the BAM transaction memory
+ * @nandc: qpic nand controller
+ *
+ * This function frees the bam transaction memory
+ */
+void qcom_free_bam_transaction(struct qcom_nand_controller *nandc)
+{
+	struct bam_transaction *bam_txn = nandc->bam_txn;
+
+	kfree(bam_txn);
+}
+
+/**
+ * qcom_clear_read_regs() - reset the read register buffer
+ * @nandc: qpic nand controller
+ *
+ * This function reset the register read buffer for next NAND operation
+ */
+void qcom_clear_read_regs(struct qcom_nand_controller *nandc)
+{
+	nandc->reg_read_pos = 0;
+	qcom_nandc_read_buffer_sync(nandc, false);
+}
+
+/**
+ * qcom_qpic_bam_dma_done() - Callback for DMA descriptor completion
+ * @data: data pointer
+ *
+ * This function is a callback for DMA descriptor completion
+ */
+void qcom_qpic_bam_dma_done(void *data)
+{
+	struct bam_transaction *bam_txn = data;
+
+	/*
+	 * In case of data transfer with NAND, 2 callbacks will be generated.
+	 * One for command channel and another one for data channel.
+	 * If current transaction has data descriptors
+	 * (i.e. wait_second_completion is true), then set this to false
+	 * and wait for second DMA descriptor completion.
+	 */
+	if (bam_txn->wait_second_completion)
+		bam_txn->wait_second_completion = false;
+	else
+		complete(&bam_txn->txn_done);
+}
+
+/**
+ * qcom_nandc_read_buffer_sync() - Check for dma sync for cpu or device
+ * @nandc: qpic nand controller
+ * @is_cpu: cpu or Device
+ *
+ * This function will check for dma sync for cpu or device
+ */
+void qcom_nandc_read_buffer_sync(struct qcom_nand_controller *nandc,
+				 bool is_cpu)
+{
+	if (!nandc->props->is_bam)
+		return;
+
+	if (is_cpu)
+		dma_sync_single_for_cpu(nandc->dev, nandc->reg_read_dma,
+					MAX_REG_RD *
+					sizeof(*nandc->reg_read_buf),
+					DMA_FROM_DEVICE);
+	else
+		dma_sync_single_for_device(nandc->dev, nandc->reg_read_dma,
+					   MAX_REG_RD *
+					   sizeof(*nandc->reg_read_buf),
+					   DMA_FROM_DEVICE);
+}
+
+/**
+ * qcom_offset_to_nandc_reg() - Get the actual offset
+ * @regs: pointer to nandc_reg structure
+ * @offset: register offset
+ *
+ * This function will reurn the actual offset for qpic controller register
+ */
+__le32 *qcom_offset_to_nandc_reg(struct nandc_regs *regs, int offset)
+{
+	switch (offset) {
+	case NAND_FLASH_CMD:
+		return &regs->cmd;
+	case NAND_ADDR0:
+		return &regs->addr0;
+	case NAND_ADDR1:
+		return &regs->addr1;
+	case NAND_FLASH_CHIP_SELECT:
+		return &regs->chip_sel;
+	case NAND_EXEC_CMD:
+		return &regs->exec;
+	case NAND_FLASH_STATUS:
+		return &regs->clrflashstatus;
+	case NAND_DEV0_CFG0:
+		return &regs->cfg0;
+	case NAND_DEV0_CFG1:
+		return &regs->cfg1;
+	case NAND_DEV0_ECC_CFG:
+		return &regs->ecc_bch_cfg;
+	case NAND_READ_STATUS:
+		return &regs->clrreadstatus;
+	case NAND_DEV_CMD1:
+		return &regs->cmd1;
+	case NAND_DEV_CMD1_RESTORE:
+		return &regs->orig_cmd1;
+	case NAND_DEV_CMD_VLD:
+		return &regs->vld;
+	case NAND_DEV_CMD_VLD_RESTORE:
+		return &regs->orig_vld;
+	case NAND_EBI2_ECC_BUF_CFG:
+		return &regs->ecc_buf_cfg;
+	case NAND_READ_LOCATION_0:
+		return &regs->read_location0;
+	case NAND_READ_LOCATION_1:
+		return &regs->read_location1;
+	case NAND_READ_LOCATION_2:
+		return &regs->read_location2;
+	case NAND_READ_LOCATION_3:
+		return &regs->read_location3;
+	case NAND_READ_LOCATION_LAST_CW_0:
+		return &regs->read_location_last0;
+	case NAND_READ_LOCATION_LAST_CW_1:
+		return &regs->read_location_last1;
+	case NAND_READ_LOCATION_LAST_CW_2:
+		return &regs->read_location_last2;
+	case NAND_READ_LOCATION_LAST_CW_3:
+		return &regs->read_location_last3;
+	default:
+		return NULL;
+	}
+}
+
+/**
+ * qcom_prep_adm_dma_desc() - Prepare descriptor for adma
+ * @nandc: qpic nand controller
+ * @read: read or write type
+ * @reg_off: offset within the controller's data buffer
+ * @vaddr: virtual address of the buffer we want to write to
+ * @size: adm dma transaction size in bytes
+ * @flow_control: flow controller
+ *
+ * This function will prepare descriptor for adma
+ */
+int qcom_prep_adm_dma_desc(struct qcom_nand_controller *nandc, bool read,
+			   int reg_off, const void *vaddr, int size,
+			     bool flow_control)
+{
+	struct qcom_adm_peripheral_config periph_conf = {};
+	struct dma_async_tx_descriptor *dma_desc;
+	struct dma_slave_config slave_conf = {0};
+	enum dma_transfer_direction dir_eng;
+	struct scatterlist *sgl;
+	struct desc_info *desc;
+	int ret;
+
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+
+	sgl = &desc->adm_sgl;
+
+	sg_init_one(sgl, vaddr, size);
+
+	if (read) {
+		dir_eng = DMA_DEV_TO_MEM;
+		desc->dir = DMA_FROM_DEVICE;
+	} else {
+		dir_eng = DMA_MEM_TO_DEV;
+		desc->dir = DMA_TO_DEVICE;
+	}
+
+	ret = dma_map_sg(nandc->dev, sgl, 1, desc->dir);
+	if (!ret) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	slave_conf.device_fc = flow_control;
+	if (read) {
+		slave_conf.src_maxburst = 16;
+		slave_conf.src_addr = nandc->base_dma + reg_off;
+		if (nandc->data_crci) {
+			periph_conf.crci = nandc->data_crci;
+			slave_conf.peripheral_config = &periph_conf;
+			slave_conf.peripheral_size = sizeof(periph_conf);
+		}
+	} else {
+		slave_conf.dst_maxburst = 16;
+		slave_conf.dst_addr = nandc->base_dma + reg_off;
+		if (nandc->cmd_crci) {
+			periph_conf.crci = nandc->cmd_crci;
+			slave_conf.peripheral_config = &periph_conf;
+			slave_conf.peripheral_size = sizeof(periph_conf);
+		}
+	}
+
+	ret = dmaengine_slave_config(nandc->chan, &slave_conf);
+	if (ret) {
+		dev_err(nandc->dev, "failed to configure dma channel\n");
+		goto err;
+	}
+
+	dma_desc = dmaengine_prep_slave_sg(nandc->chan, sgl, 1, dir_eng, 0);
+	if (!dma_desc) {
+		dev_err(nandc->dev, "failed to prepare desc\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	desc->dma_desc = dma_desc;
+
+	list_add_tail(&desc->node, &nandc->desc_list);
+
+	return 0;
+err:
+	kfree(desc);
+
+	return ret;
+}
+
+/**
+ * qcom_submit_descs() - submit dma descriptor
+ * @nandc: qpic nand controller
+ *
+ * This function will submit all the prepared dma descriptor
+ * cmd or data descriptor
+ */
+int qcom_submit_descs(struct qcom_nand_controller *nandc)
+{
+	struct desc_info *desc, *n;
+	dma_cookie_t cookie = 0;
+	struct bam_transaction *bam_txn = nandc->bam_txn;
+	int ret = 0;
+
+	if (nandc->props->is_bam) {
+		if (bam_txn->rx_sgl_pos > bam_txn->rx_sgl_start) {
+			ret = qcom_prepare_bam_async_desc(nandc, nandc->rx_chan, 0);
+			if (ret)
+				goto err_unmap_free_desc;
+		}
+
+		if (bam_txn->tx_sgl_pos > bam_txn->tx_sgl_start) {
+			ret = qcom_prepare_bam_async_desc(nandc, nandc->tx_chan,
+							  DMA_PREP_INTERRUPT);
+			if (ret)
+				goto err_unmap_free_desc;
+		}
+
+		if (bam_txn->cmd_sgl_pos > bam_txn->cmd_sgl_start) {
+			ret = qcom_prepare_bam_async_desc(nandc, nandc->cmd_chan,
+							  DMA_PREP_CMD);
+			if (ret)
+				goto err_unmap_free_desc;
+		}
+	}
+
+	list_for_each_entry(desc, &nandc->desc_list, node)
+		cookie = dmaengine_submit(desc->dma_desc);
+
+	if (nandc->props->is_bam) {
+		bam_txn->last_cmd_desc->callback = qcom_qpic_bam_dma_done;
+		bam_txn->last_cmd_desc->callback_param = bam_txn;
+		if (bam_txn->last_data_desc) {
+			bam_txn->last_data_desc->callback = qcom_qpic_bam_dma_done;
+			bam_txn->last_data_desc->callback_param = bam_txn;
+			bam_txn->wait_second_completion = true;
+		}
+
+		dma_async_issue_pending(nandc->tx_chan);
+		dma_async_issue_pending(nandc->rx_chan);
+		dma_async_issue_pending(nandc->cmd_chan);
+
+		if (!wait_for_completion_timeout(&bam_txn->txn_done,
+						 QPIC_NAND_COMPLETION_TIMEOUT))
+			ret = -ETIMEDOUT;
+	} else {
+		if (dma_sync_wait(nandc->chan, cookie) != DMA_COMPLETE)
+			ret = -ETIMEDOUT;
+	}
+
+err_unmap_free_desc:
+	/*
+	 * Unmap the dma sg_list and free the desc allocated by both
+	 * prepare_bam_async_desc() and prep_adm_dma_desc() functions.
+	 */
+	list_for_each_entry_safe(desc, n, &nandc->desc_list, node) {
+		list_del(&desc->node);
+
+		if (nandc->props->is_bam)
+			dma_unmap_sg(nandc->dev, desc->bam_sgl,
+				     desc->sgl_cnt, desc->dir);
+		else
+			dma_unmap_sg(nandc->dev, &desc->adm_sgl, 1,
+				     desc->dir);
+
+		kfree(desc);
+	}
+
+	return ret;
+}
+
+/**
+ * qcom_prepare_bam_async_desc() - Prepare DMA descriptor
+ * @nandc: qpic nand controller
+ * @chan: dma channel
+ * @flags: flags to control DMA descriptor preparation
+ *
+ * This function maps the scatter gather list for DMA transfer and forms the
+ * DMA descriptor for BAM.This descriptor will be added in the NAND DMA
+ * descriptor queue which will be submitted to DMA engine.
+ */
+int qcom_prepare_bam_async_desc(struct qcom_nand_controller *nandc,
+				struct dma_chan *chan,
+				  unsigned long flags)
+{
+	struct desc_info *desc;
+	struct scatterlist *sgl;
+	unsigned int sgl_cnt;
+	int ret;
+	struct bam_transaction *bam_txn = nandc->bam_txn;
+	enum dma_transfer_direction dir_eng;
+	struct dma_async_tx_descriptor *dma_desc;
+
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+
+	if (chan == nandc->cmd_chan) {
+		sgl = &bam_txn->cmd_sgl[bam_txn->cmd_sgl_start];
+		sgl_cnt = bam_txn->cmd_sgl_pos - bam_txn->cmd_sgl_start;
+		bam_txn->cmd_sgl_start = bam_txn->cmd_sgl_pos;
+		dir_eng = DMA_MEM_TO_DEV;
+		desc->dir = DMA_TO_DEVICE;
+	} else if (chan == nandc->tx_chan) {
+		sgl = &bam_txn->data_sgl[bam_txn->tx_sgl_start];
+		sgl_cnt = bam_txn->tx_sgl_pos - bam_txn->tx_sgl_start;
+		bam_txn->tx_sgl_start = bam_txn->tx_sgl_pos;
+		dir_eng = DMA_MEM_TO_DEV;
+		desc->dir = DMA_TO_DEVICE;
+	} else {
+		sgl = &bam_txn->data_sgl[bam_txn->rx_sgl_start];
+		sgl_cnt = bam_txn->rx_sgl_pos - bam_txn->rx_sgl_start;
+		bam_txn->rx_sgl_start = bam_txn->rx_sgl_pos;
+		dir_eng = DMA_DEV_TO_MEM;
+		desc->dir = DMA_FROM_DEVICE;
+	}
+
+	sg_mark_end(sgl + sgl_cnt - 1);
+	ret = dma_map_sg(nandc->dev, sgl, sgl_cnt, desc->dir);
+	if (ret == 0) {
+		dev_err(nandc->dev, "failure in mapping desc\n");
+		kfree(desc);
+		return -ENOMEM;
+	}
+
+	desc->sgl_cnt = sgl_cnt;
+	desc->bam_sgl = sgl;
+
+	dma_desc = dmaengine_prep_slave_sg(chan, sgl, sgl_cnt, dir_eng,
+					   flags);
+
+	if (!dma_desc) {
+		dev_err(nandc->dev, "failure in prep desc\n");
+		dma_unmap_sg(nandc->dev, sgl, sgl_cnt, desc->dir);
+		kfree(desc);
+		return -EINVAL;
+	}
+
+	desc->dma_desc = dma_desc;
+
+	/* update last data/command descriptor */
+	if (chan == nandc->cmd_chan)
+		bam_txn->last_cmd_desc = dma_desc;
+	else
+		bam_txn->last_data_desc = dma_desc;
+
+	list_add_tail(&desc->node, &nandc->desc_list);
+
+	return 0;
+}
+
+/**
+ * qcom_prep_bam_dma_desc_cmd() - Prepares the command descriptor for BAM DMA
+ * @nandc: qpic nand controller
+ * @read: read or write type
+ * @reg_off: offset within the controller's data buffer
+ * @vaddr: virtual address of the buffer we want to write to
+ * @size: DMA transaction size in bytes
+ * @flags: flags to control DMA descriptor preparation
+ *
+ * This function will prepares the command descriptor for BAM DMA
+ * which will be used for NAND register reads and writes.
+ */
+int qcom_prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
+			       int reg_off, const void *vaddr,
+				 int size, unsigned int flags)
+{
+	int bam_ce_size;
+	int i, ret;
+	struct bam_cmd_element *bam_ce_buffer;
+	struct bam_transaction *bam_txn = nandc->bam_txn;
+
+	bam_ce_buffer = &bam_txn->bam_ce[bam_txn->bam_ce_pos];
+
+	/* fill the command desc */
+	for (i = 0; i < size; i++) {
+		if (read)
+			bam_prep_ce(&bam_ce_buffer[i],
+				    nandc_reg_phys(nandc, reg_off + 4 * i),
+				    BAM_READ_COMMAND,
+				    reg_buf_dma_addr(nandc,
+						     (__le32 *)vaddr + i));
+		else
+			bam_prep_ce_le32(&bam_ce_buffer[i],
+					 nandc_reg_phys(nandc, reg_off + 4 * i),
+					 BAM_WRITE_COMMAND,
+					 *((__le32 *)vaddr + i));
+	}
+
+	bam_txn->bam_ce_pos += size;
+
+	/* use the separate sgl after this command */
+	if (flags & NAND_BAM_NEXT_SGL) {
+		bam_ce_buffer = &bam_txn->bam_ce[bam_txn->bam_ce_start];
+		bam_ce_size = (bam_txn->bam_ce_pos -
+				bam_txn->bam_ce_start) *
+				sizeof(struct bam_cmd_element);
+		sg_set_buf(&bam_txn->cmd_sgl[bam_txn->cmd_sgl_pos],
+			   bam_ce_buffer, bam_ce_size);
+		bam_txn->cmd_sgl_pos++;
+		bam_txn->bam_ce_start = bam_txn->bam_ce_pos;
+
+		if (flags & NAND_BAM_NWD) {
+			ret = qcom_prepare_bam_async_desc(nandc, nandc->cmd_chan,
+							  DMA_PREP_FENCE |
+						     DMA_PREP_CMD);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * qcom_prep_bam_dma_desc_data() - Prepares the data descriptor for BAM DMA
+ * @nandc: qpic nand controller
+ * @read: read or write type
+ * @vaddr: virtual address of the buffer we want to write to
+ * @size: DMA transaction size in bytes
+ * @flags: flags to control DMA descriptor preparation
+ *
+ * This function will prepares the data descriptor for BAM DMA which
+ * will be used for NAND data reads and writes.
+ */
+int qcom_prep_bam_dma_desc_data(struct qcom_nand_controller *nandc, bool read,
+				const void *vaddr,
+				  int size, unsigned int flags)
+{
+	int ret;
+	struct bam_transaction *bam_txn = nandc->bam_txn;
+
+	if (read) {
+		sg_set_buf(&bam_txn->data_sgl[bam_txn->rx_sgl_pos],
+			   vaddr, size);
+		bam_txn->rx_sgl_pos++;
+	} else {
+		sg_set_buf(&bam_txn->data_sgl[bam_txn->tx_sgl_pos],
+			   vaddr, size);
+		bam_txn->tx_sgl_pos++;
+
+		/*
+		 * BAM will only set EOT for DMA_PREP_INTERRUPT so if this flag
+		 * is not set, form the DMA descriptor
+		 */
+		if (!(flags & NAND_BAM_NO_EOT)) {
+			ret = qcom_prepare_bam_async_desc(nandc, nandc->tx_chan,
+							  DMA_PREP_INTERRUPT);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * qcom_read_reg_dma() - read a given number of registers to the reg_read_buf pointer
+ * @nandc: qpic nand controller
+ * @first: offset of the first register in the contiguous block
+ * @num_regs: number of registers to read
+ * @flags: flags to control DMA descriptor preparation
+ *
+ * This function will prepares a descriptor to read a given number of
+ * contiguous registers to the reg_read_buf pointer.
+ */
+int qcom_read_reg_dma(struct qcom_nand_controller *nandc, int first,
+		      int num_regs, unsigned int flags)
+{
+	bool flow_control = false;
+	void *vaddr;
+
+	vaddr = nandc->reg_read_buf + nandc->reg_read_pos;
+	nandc->reg_read_pos += num_regs;
+
+	if (first == NAND_DEV_CMD_VLD || first == NAND_DEV_CMD1)
+		first = dev_cmd_reg_addr(nandc, first);
+
+	if (nandc->props->is_bam)
+		return qcom_prep_bam_dma_desc_cmd(nandc, true, first, vaddr,
+					     num_regs, flags);
+
+	if (first == NAND_READ_ID || first == NAND_FLASH_STATUS)
+		flow_control = true;
+
+	return qcom_prep_adm_dma_desc(nandc, true, first, vaddr,
+				 num_regs * sizeof(u32), flow_control);
+}
+
+/**
+ * qcom_write_reg_dma() - write a given number of registers
+ * @nandc: qpic nand controller
+ * @first: offset of the first register in the contiguous block
+ * @num_regs: number of registers to write
+ * @flags: flags to control DMA descriptor preparation
+ *
+ * This function will prepares a descriptor to write a given number of
+ * contiguous registers
+ */
+int qcom_write_reg_dma(struct qcom_nand_controller *nandc, int first,
+		       int num_regs, unsigned int flags)
+{
+	bool flow_control = false;
+	struct nandc_regs *regs = nandc->regs;
+	void *vaddr;
+
+	vaddr = qcom_offset_to_nandc_reg(regs, first);
+
+	if (first == NAND_ERASED_CW_DETECT_CFG) {
+		if (flags & NAND_ERASED_CW_SET)
+			vaddr = &regs->erased_cw_detect_cfg_set;
+		else
+			vaddr = &regs->erased_cw_detect_cfg_clr;
+	}
+
+	if (first == NAND_EXEC_CMD)
+		flags |= NAND_BAM_NWD;
+
+	if (first == NAND_DEV_CMD1_RESTORE || first == NAND_DEV_CMD1)
+		first = dev_cmd_reg_addr(nandc, NAND_DEV_CMD1);
+
+	if (first == NAND_DEV_CMD_VLD_RESTORE || first == NAND_DEV_CMD_VLD)
+		first = dev_cmd_reg_addr(nandc, NAND_DEV_CMD_VLD);
+
+	if (nandc->props->is_bam)
+		return qcom_prep_bam_dma_desc_cmd(nandc, false, first, vaddr,
+					     num_regs, flags);
+
+	if (first == NAND_FLASH_CMD)
+		flow_control = true;
+
+	return qcom_prep_adm_dma_desc(nandc, false, first, vaddr,
+				 num_regs * sizeof(u32), flow_control);
+}
+
+/**
+ * qcom_read_data_dma() - transfer data
+ * @nandc: qpic nand controller
+ * @reg_off: offset within the controller's data buffer
+ * @vaddr: virtual address of the buffer we want to write to
+ * @size: DMA transaction size in bytes
+ * @flags: flags to control DMA descriptor preparation
+ *
+ * This function will prepares a DMA descriptor to transfer data from the
+ * controller's internal buffer to the buffer 'vaddr'
+ */
+int qcom_read_data_dma(struct qcom_nand_controller *nandc, int reg_off,
+		       const u8 *vaddr, int size, unsigned int flags)
+{
+	if (nandc->props->is_bam)
+		return qcom_prep_bam_dma_desc_data(nandc, true, vaddr, size, flags);
+
+	return qcom_prep_adm_dma_desc(nandc, true, reg_off, vaddr, size, false);
+}
+
+/**
+ * qcom_write_data_dma() - transfer data
+ * @nandc: qpic nand controller
+ * @reg_off: offset within the controller's data buffer
+ * @vaddr: virtual address of the buffer we want to read from
+ * @size: DMA transaction size in bytes
+ * @flags: flags to control DMA descriptor preparation
+ *
+ * This function will prepares a DMA descriptor to transfer data from
+ * 'vaddr' to the controller's internal buffer
+ */
+int qcom_write_data_dma(struct qcom_nand_controller *nandc, int reg_off,
+			const u8 *vaddr, int size, unsigned int flags)
+{
+	if (nandc->props->is_bam)
+		return qcom_prep_bam_dma_desc_data(nandc, false, vaddr, size, flags);
+
+	return qcom_prep_adm_dma_desc(nandc, false, reg_off, vaddr, size, false);
+}
+
+/**
+ * qcom_alloc_bam_transaction() - allocate BAM transaction
+ * @nandc: qpic nand controller
+ *
+ * This function will allocate and initialize the BAM transaction structure
+ */
+struct bam_transaction *
+qcom_alloc_bam_transaction(struct qcom_nand_controller *nandc)
+{
+	struct bam_transaction *bam_txn;
+	size_t bam_txn_size;
+	unsigned int num_cw = nandc->max_cwperpage;
+	void *bam_txn_buf;
+
+	bam_txn_size =
+		sizeof(*bam_txn) + num_cw *
+		((sizeof(*bam_txn->bam_ce) * QPIC_PER_CW_CMD_ELEMENTS) +
+		(sizeof(*bam_txn->cmd_sgl) * QPIC_PER_CW_CMD_SGL) +
+		(sizeof(*bam_txn->data_sgl) * QPIC_PER_CW_DATA_SGL));
+
+	bam_txn_buf = kzalloc(bam_txn_size, GFP_KERNEL);
+	if (!bam_txn_buf)
+		return NULL;
+
+	bam_txn = bam_txn_buf;
+	bam_txn_buf += sizeof(*bam_txn);
+
+	bam_txn->bam_ce = bam_txn_buf;
+	bam_txn_buf +=
+		sizeof(*bam_txn->bam_ce) * QPIC_PER_CW_CMD_ELEMENTS * num_cw;
+
+	bam_txn->cmd_sgl = bam_txn_buf;
+	bam_txn_buf +=
+		sizeof(*bam_txn->cmd_sgl) * QPIC_PER_CW_CMD_SGL * num_cw;
+
+	bam_txn->data_sgl = bam_txn_buf;
+
+	init_completion(&bam_txn->txn_done);
+
+	return bam_txn;
+}
+
+/**
+ * qcom_clear_bam_transaction() - Clears the BAM transaction
+ * @nandc: qpic nand controller
+ *
+ * This function will clear the BAM transaction indexes.
+ */
+void qcom_clear_bam_transaction(struct qcom_nand_controller *nandc)
+{
+	struct bam_transaction *bam_txn = nandc->bam_txn;
+
+	if (!nandc->props->is_bam)
+		return;
+
+	bam_txn->bam_ce_pos = 0;
+	bam_txn->bam_ce_start = 0;
+	bam_txn->cmd_sgl_pos = 0;
+	bam_txn->cmd_sgl_start = 0;
+	bam_txn->tx_sgl_pos = 0;
+	bam_txn->tx_sgl_start = 0;
+	bam_txn->rx_sgl_pos = 0;
+	bam_txn->rx_sgl_start = 0;
+	bam_txn->last_data_desc = NULL;
+	bam_txn->wait_second_completion = false;
+
+	sg_init_table(bam_txn->cmd_sgl, nandc->max_cwperpage *
+		      QPIC_PER_CW_CMD_SGL);
+	sg_init_table(bam_txn->data_sgl, nandc->max_cwperpage *
+		      QPIC_PER_CW_DATA_SGL);
+
+	reinit_completion(&bam_txn->txn_done);
+}
+
+/**
+ * qcom_nandc_unalloc() - unallocate qpic nand controller
+ * @nandc: qpic nand controller
+ *
+ * This function will unallocate memory alloacted for qpic nand controller
+ */
+void qcom_nandc_unalloc(struct qcom_nand_controller *nandc)
+{
+	if (nandc->props->is_bam) {
+		if (!dma_mapping_error(nandc->dev, nandc->reg_read_dma))
+			dma_unmap_single(nandc->dev, nandc->reg_read_dma,
+					 MAX_REG_RD *
+					 sizeof(*nandc->reg_read_buf),
+					 DMA_FROM_DEVICE);
+
+		if (nandc->tx_chan)
+			dma_release_channel(nandc->tx_chan);
+
+		if (nandc->rx_chan)
+			dma_release_channel(nandc->rx_chan);
+
+		if (nandc->cmd_chan)
+			dma_release_channel(nandc->cmd_chan);
+	} else {
+		if (nandc->chan)
+			dma_release_channel(nandc->chan);
+	}
+}
+
+/**
+ * qcom_nandc_alloc() - Allocate qpic nand controller
+ * @nandc: qpic nand controller
+ *
+ * This function will allocate memory for qpic nand controller
+ */
+int qcom_nandc_alloc(struct qcom_nand_controller *nandc)
+{
+	int ret;
+
+	ret = dma_set_coherent_mask(nandc->dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(nandc->dev, "failed to set DMA mask\n");
+		return ret;
+	}
+
+	/*
+	 * we use the internal buffer for reading ONFI params, reading small
+	 * data like ID and status, and preforming read-copy-write operations
+	 * when writing to a codeword partially. 532 is the maximum possible
+	 * size of a codeword for our nand controller
+	 */
+	nandc->buf_size = 532;
+
+	nandc->data_buffer = devm_kzalloc(nandc->dev, nandc->buf_size, GFP_KERNEL);
+	if (!nandc->data_buffer)
+		return -ENOMEM;
+
+	nandc->regs = devm_kzalloc(nandc->dev, sizeof(*nandc->regs), GFP_KERNEL);
+	if (!nandc->regs)
+		return -ENOMEM;
+
+	nandc->reg_read_buf = devm_kcalloc(nandc->dev, MAX_REG_RD,
+					   sizeof(*nandc->reg_read_buf),
+					   GFP_KERNEL);
+	if (!nandc->reg_read_buf)
+		return -ENOMEM;
+
+	if (nandc->props->is_bam) {
+		nandc->reg_read_dma =
+			dma_map_single(nandc->dev, nandc->reg_read_buf,
+				       MAX_REG_RD *
+				       sizeof(*nandc->reg_read_buf),
+				       DMA_FROM_DEVICE);
+		if (dma_mapping_error(nandc->dev, nandc->reg_read_dma)) {
+			dev_err(nandc->dev, "failed to DMA MAP reg buffer\n");
+			return -EIO;
+		}
+
+		nandc->tx_chan = dma_request_chan(nandc->dev, "tx");
+		if (IS_ERR(nandc->tx_chan)) {
+			ret = PTR_ERR(nandc->tx_chan);
+			nandc->tx_chan = NULL;
+			dev_err_probe(nandc->dev, ret,
+				      "tx DMA channel request failed\n");
+			goto unalloc;
+		}
+
+		nandc->rx_chan = dma_request_chan(nandc->dev, "rx");
+		if (IS_ERR(nandc->rx_chan)) {
+			ret = PTR_ERR(nandc->rx_chan);
+			nandc->rx_chan = NULL;
+			dev_err_probe(nandc->dev, ret,
+				      "rx DMA channel request failed\n");
+			goto unalloc;
+		}
+
+		nandc->cmd_chan = dma_request_chan(nandc->dev, "cmd");
+		if (IS_ERR(nandc->cmd_chan)) {
+			ret = PTR_ERR(nandc->cmd_chan);
+			nandc->cmd_chan = NULL;
+			dev_err_probe(nandc->dev, ret,
+				      "cmd DMA channel request failed\n");
+			goto unalloc;
+		}
+
+		/*
+		 * Initially allocate BAM transaction to read ONFI param page.
+		 * After detecting all the devices, this BAM transaction will
+		 * be freed and the next BAM transaction will be allocated with
+		 * maximum codeword size
+		 */
+		nandc->max_cwperpage = 1;
+		nandc->bam_txn = qcom_alloc_bam_transaction(nandc);
+		if (!nandc->bam_txn) {
+			dev_err(nandc->dev,
+				"failed to allocate bam transaction\n");
+			ret = -ENOMEM;
+			goto unalloc;
+		}
+	} else {
+		nandc->chan = dma_request_chan(nandc->dev, "rxtx");
+		if (IS_ERR(nandc->chan)) {
+			ret = PTR_ERR(nandc->chan);
+			nandc->chan = NULL;
+			dev_err_probe(nandc->dev, ret,
+				      "rxtx DMA channel request failed\n");
+			return ret;
+		}
+	}
+
+	INIT_LIST_HEAD(&nandc->desc_list);
+	INIT_LIST_HEAD(&nandc->host_list);
+
+	return 0;
+unalloc:
+	qcom_nandc_unalloc(nandc);
+	return ret;
+}
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index cbf8ae85e1ae..3aa000f877a4 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -334,6 +334,7 @@ config MTD_NAND_QCOM
 	tristate "QCOM NAND controller"
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on HAS_IOMEM
+	select QPIC_COMMON
 	help
 	  Enables support for NAND flash chips on SoCs containing the EBI2 NAND
 	  controller. This controller is found on IPQ806x SoC.
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index b079605c84d3..d4faabc8244f 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2,186 +2,7 @@
 /*
  * Copyright (c) 2016, The Linux Foundation. All rights reserved.
  */
-#include <linux/bitops.h>
-#include <linux/clk.h>
-#include <linux/delay.h>
-#include <linux/dmaengine.h>
-#include <linux/dma-mapping.h>
-#include <linux/dma/qcom_adm.h>
-#include <linux/dma/qcom_bam_dma.h>
-#include <linux/module.h>
-#include <linux/mtd/partitions.h>
-#include <linux/mtd/rawnand.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-
-/* NANDc reg offsets */
-#define	NAND_FLASH_CMD			0x00
-#define	NAND_ADDR0			0x04
-#define	NAND_ADDR1			0x08
-#define	NAND_FLASH_CHIP_SELECT		0x0c
-#define	NAND_EXEC_CMD			0x10
-#define	NAND_FLASH_STATUS		0x14
-#define	NAND_BUFFER_STATUS		0x18
-#define	NAND_DEV0_CFG0			0x20
-#define	NAND_DEV0_CFG1			0x24
-#define	NAND_DEV0_ECC_CFG		0x28
-#define	NAND_AUTO_STATUS_EN		0x2c
-#define	NAND_DEV1_CFG0			0x30
-#define	NAND_DEV1_CFG1			0x34
-#define	NAND_READ_ID			0x40
-#define	NAND_READ_STATUS		0x44
-#define	NAND_DEV_CMD0			0xa0
-#define	NAND_DEV_CMD1			0xa4
-#define	NAND_DEV_CMD2			0xa8
-#define	NAND_DEV_CMD_VLD		0xac
-#define	SFLASHC_BURST_CFG		0xe0
-#define	NAND_ERASED_CW_DETECT_CFG	0xe8
-#define	NAND_ERASED_CW_DETECT_STATUS	0xec
-#define	NAND_EBI2_ECC_BUF_CFG		0xf0
-#define	FLASH_BUF_ACC			0x100
-
-#define	NAND_CTRL			0xf00
-#define	NAND_VERSION			0xf08
-#define	NAND_READ_LOCATION_0		0xf20
-#define	NAND_READ_LOCATION_1		0xf24
-#define	NAND_READ_LOCATION_2		0xf28
-#define	NAND_READ_LOCATION_3		0xf2c
-#define	NAND_READ_LOCATION_LAST_CW_0	0xf40
-#define	NAND_READ_LOCATION_LAST_CW_1	0xf44
-#define	NAND_READ_LOCATION_LAST_CW_2	0xf48
-#define	NAND_READ_LOCATION_LAST_CW_3	0xf4c
-
-/* dummy register offsets, used by write_reg_dma */
-#define	NAND_DEV_CMD1_RESTORE		0xdead
-#define	NAND_DEV_CMD_VLD_RESTORE	0xbeef
-
-/* NAND_FLASH_CMD bits */
-#define	PAGE_ACC			BIT(4)
-#define	LAST_PAGE			BIT(5)
-
-/* NAND_FLASH_CHIP_SELECT bits */
-#define	NAND_DEV_SEL			0
-#define	DM_EN				BIT(2)
-
-/* NAND_FLASH_STATUS bits */
-#define	FS_OP_ERR			BIT(4)
-#define	FS_READY_BSY_N			BIT(5)
-#define	FS_MPU_ERR			BIT(8)
-#define	FS_DEVICE_STS_ERR		BIT(16)
-#define	FS_DEVICE_WP			BIT(23)
-
-/* NAND_BUFFER_STATUS bits */
-#define	BS_UNCORRECTABLE_BIT		BIT(8)
-#define	BS_CORRECTABLE_ERR_MSK		0x1f
-
-/* NAND_DEVn_CFG0 bits */
-#define	DISABLE_STATUS_AFTER_WRITE	4
-#define	CW_PER_PAGE			6
-#define	UD_SIZE_BYTES			9
-#define	UD_SIZE_BYTES_MASK		GENMASK(18, 9)
-#define	ECC_PARITY_SIZE_BYTES_RS	19
-#define	SPARE_SIZE_BYTES		23
-#define	SPARE_SIZE_BYTES_MASK		GENMASK(26, 23)
-#define	NUM_ADDR_CYCLES			27
-#define	STATUS_BFR_READ			30
-#define	SET_RD_MODE_AFTER_STATUS	31
-
-/* NAND_DEVn_CFG0 bits */
-#define	DEV0_CFG1_ECC_DISABLE		0
-#define	WIDE_FLASH			1
-#define	NAND_RECOVERY_CYCLES		2
-#define	CS_ACTIVE_BSY			5
-#define	BAD_BLOCK_BYTE_NUM		6
-#define	BAD_BLOCK_IN_SPARE_AREA		16
-#define	WR_RD_BSY_GAP			17
-#define	ENABLE_BCH_ECC			27
-
-/* NAND_DEV0_ECC_CFG bits */
-#define	ECC_CFG_ECC_DISABLE		0
-#define	ECC_SW_RESET			1
-#define	ECC_MODE			4
-#define	ECC_PARITY_SIZE_BYTES_BCH	8
-#define	ECC_NUM_DATA_BYTES		16
-#define	ECC_NUM_DATA_BYTES_MASK		GENMASK(25, 16)
-#define	ECC_FORCE_CLK_OPEN		30
-
-/* NAND_DEV_CMD1 bits */
-#define	READ_ADDR			0
-
-/* NAND_DEV_CMD_VLD bits */
-#define	READ_START_VLD			BIT(0)
-#define	READ_STOP_VLD			BIT(1)
-#define	WRITE_START_VLD			BIT(2)
-#define	ERASE_START_VLD			BIT(3)
-#define	SEQ_READ_START_VLD		BIT(4)
-
-/* NAND_EBI2_ECC_BUF_CFG bits */
-#define	NUM_STEPS			0
-
-/* NAND_ERASED_CW_DETECT_CFG bits */
-#define	ERASED_CW_ECC_MASK		1
-#define	AUTO_DETECT_RES			0
-#define	MASK_ECC			BIT(ERASED_CW_ECC_MASK)
-#define	RESET_ERASED_DET		BIT(AUTO_DETECT_RES)
-#define	ACTIVE_ERASED_DET		(0 << AUTO_DETECT_RES)
-#define	CLR_ERASED_PAGE_DET		(RESET_ERASED_DET | MASK_ECC)
-#define	SET_ERASED_PAGE_DET		(ACTIVE_ERASED_DET | MASK_ECC)
-
-/* NAND_ERASED_CW_DETECT_STATUS bits */
-#define	PAGE_ALL_ERASED			BIT(7)
-#define	CODEWORD_ALL_ERASED		BIT(6)
-#define	PAGE_ERASED			BIT(5)
-#define	CODEWORD_ERASED			BIT(4)
-#define	ERASED_PAGE			(PAGE_ALL_ERASED | PAGE_ERASED)
-#define	ERASED_CW			(CODEWORD_ALL_ERASED | CODEWORD_ERASED)
-
-/* NAND_READ_LOCATION_n bits */
-#define READ_LOCATION_OFFSET		0
-#define READ_LOCATION_SIZE		16
-#define READ_LOCATION_LAST		31
-
-/* Version Mask */
-#define	NAND_VERSION_MAJOR_MASK		0xf0000000
-#define	NAND_VERSION_MAJOR_SHIFT	28
-#define	NAND_VERSION_MINOR_MASK		0x0fff0000
-#define	NAND_VERSION_MINOR_SHIFT	16
-
-/* NAND OP_CMDs */
-#define	OP_PAGE_READ			0x2
-#define	OP_PAGE_READ_WITH_ECC		0x3
-#define	OP_PAGE_READ_WITH_ECC_SPARE	0x4
-#define	OP_PAGE_READ_ONFI_READ		0x5
-#define	OP_PROGRAM_PAGE			0x6
-#define	OP_PAGE_PROGRAM_WITH_ECC	0x7
-#define	OP_PROGRAM_PAGE_SPARE		0x9
-#define	OP_BLOCK_ERASE			0xa
-#define	OP_CHECK_STATUS			0xc
-#define	OP_FETCH_ID			0xb
-#define	OP_RESET_DEVICE			0xd
-
-/* Default Value for NAND_DEV_CMD_VLD */
-#define NAND_DEV_CMD_VLD_VAL		(READ_START_VLD | WRITE_START_VLD | \
-					 ERASE_START_VLD | SEQ_READ_START_VLD)
-
-/* NAND_CTRL bits */
-#define	BAM_MODE_EN			BIT(0)
-
-/*
- * the NAND controller performs reads/writes with ECC in 516 byte chunks.
- * the driver calls the chunks 'step' or 'codeword' interchangeably
- */
-#define	NANDC_STEP_SIZE			512
-
-/*
- * the largest page size we support is 8K, this will have 16 steps/codewords
- * of 512 bytes each
- */
-#define	MAX_NUM_STEPS			(SZ_8K / NANDC_STEP_SIZE)
-
-/* we read at most 3 registers per codeword scan */
-#define	MAX_REG_RD			(3 * MAX_NUM_STEPS)
+#include <linux/mtd/nand-qpic-common.h>
 
 /* ECC modes supported by the controller */
 #define	ECC_NONE	BIT(0)
@@ -200,247 +21,6 @@ nandc_set_reg(chip, reg,			\
 	      ((cw_offset) << READ_LOCATION_OFFSET) |		\
 	      ((read_size) << READ_LOCATION_SIZE) |			\
 	      ((is_last_read_loc) << READ_LOCATION_LAST))
-/*
- * Returns the actual register address for all NAND_DEV_ registers
- * (i.e. NAND_DEV_CMD0, NAND_DEV_CMD1, NAND_DEV_CMD2 and NAND_DEV_CMD_VLD)
- */
-#define dev_cmd_reg_addr(nandc, reg) ((nandc)->props->dev_cmd_reg_start + (reg))
-
-/* Returns the NAND register physical address */
-#define nandc_reg_phys(chip, offset) ((chip)->base_phys + (offset))
-
-/* Returns the dma address for reg read buffer */
-#define reg_buf_dma_addr(chip, vaddr) \
-	((chip)->reg_read_dma + \
-	((u8 *)(vaddr) - (u8 *)(chip)->reg_read_buf))
-
-#define QPIC_PER_CW_CMD_ELEMENTS	32
-#define QPIC_PER_CW_CMD_SGL		32
-#define QPIC_PER_CW_DATA_SGL		8
-
-#define QPIC_NAND_COMPLETION_TIMEOUT	msecs_to_jiffies(2000)
-
-/*
- * Flags used in DMA descriptor preparation helper functions
- * (i.e. read_reg_dma/write_reg_dma/read_data_dma/write_data_dma)
- */
-/* Don't set the EOT in current tx BAM sgl */
-#define NAND_BAM_NO_EOT			BIT(0)
-/* Set the NWD flag in current BAM sgl */
-#define NAND_BAM_NWD			BIT(1)
-/* Finish writing in the current BAM sgl and start writing in another BAM sgl */
-#define NAND_BAM_NEXT_SGL		BIT(2)
-/*
- * Erased codeword status is being used two times in single transfer so this
- * flag will determine the current value of erased codeword status register
- */
-#define NAND_ERASED_CW_SET		BIT(4)
-
-#define MAX_ADDRESS_CYCLE		5
-
-/*
- * This data type corresponds to the BAM transaction which will be used for all
- * NAND transfers.
- * @bam_ce - the array of BAM command elements
- * @cmd_sgl - sgl for NAND BAM command pipe
- * @data_sgl - sgl for NAND BAM consumer/producer pipe
- * @last_data_desc - last DMA desc in data channel (tx/rx).
- * @last_cmd_desc - last DMA desc in command channel.
- * @txn_done - completion for NAND transfer.
- * @bam_ce_pos - the index in bam_ce which is available for next sgl
- * @bam_ce_start - the index in bam_ce which marks the start position ce
- *		   for current sgl. It will be used for size calculation
- *		   for current sgl
- * @cmd_sgl_pos - current index in command sgl.
- * @cmd_sgl_start - start index in command sgl.
- * @tx_sgl_pos - current index in data sgl for tx.
- * @tx_sgl_start - start index in data sgl for tx.
- * @rx_sgl_pos - current index in data sgl for rx.
- * @rx_sgl_start - start index in data sgl for rx.
- * @wait_second_completion - wait for second DMA desc completion before making
- *			     the NAND transfer completion.
- */
-struct bam_transaction {
-	struct bam_cmd_element *bam_ce;
-	struct scatterlist *cmd_sgl;
-	struct scatterlist *data_sgl;
-	struct dma_async_tx_descriptor *last_data_desc;
-	struct dma_async_tx_descriptor *last_cmd_desc;
-	struct completion txn_done;
-	u32 bam_ce_pos;
-	u32 bam_ce_start;
-	u32 cmd_sgl_pos;
-	u32 cmd_sgl_start;
-	u32 tx_sgl_pos;
-	u32 tx_sgl_start;
-	u32 rx_sgl_pos;
-	u32 rx_sgl_start;
-	bool wait_second_completion;
-};
-
-/*
- * This data type corresponds to the nand dma descriptor
- * @dma_desc - low level DMA engine descriptor
- * @list - list for desc_info
- *
- * @adm_sgl - sgl which will be used for single sgl dma descriptor. Only used by
- *	      ADM
- * @bam_sgl - sgl which will be used for dma descriptor. Only used by BAM
- * @sgl_cnt - number of SGL in bam_sgl. Only used by BAM
- * @dir - DMA transfer direction
- */
-struct desc_info {
-	struct dma_async_tx_descriptor *dma_desc;
-	struct list_head node;
-
-	union {
-		struct scatterlist adm_sgl;
-		struct {
-			struct scatterlist *bam_sgl;
-			int sgl_cnt;
-		};
-	};
-	enum dma_data_direction dir;
-};
-
-/*
- * holds the current register values that we want to write. acts as a contiguous
- * chunk of memory which we use to write the controller registers through DMA.
- */
-struct nandc_regs {
-	__le32 cmd;
-	__le32 addr0;
-	__le32 addr1;
-	__le32 chip_sel;
-	__le32 exec;
-
-	__le32 cfg0;
-	__le32 cfg1;
-	__le32 ecc_bch_cfg;
-
-	__le32 clrflashstatus;
-	__le32 clrreadstatus;
-
-	__le32 cmd1;
-	__le32 vld;
-
-	__le32 orig_cmd1;
-	__le32 orig_vld;
-
-	__le32 ecc_buf_cfg;
-	__le32 read_location0;
-	__le32 read_location1;
-	__le32 read_location2;
-	__le32 read_location3;
-	__le32 read_location_last0;
-	__le32 read_location_last1;
-	__le32 read_location_last2;
-	__le32 read_location_last3;
-
-	__le32 erased_cw_detect_cfg_clr;
-	__le32 erased_cw_detect_cfg_set;
-};
-
-/*
- * NAND controller data struct
- *
- * @dev:			parent device
- *
- * @base:			MMIO base
- *
- * @core_clk:			controller clock
- * @aon_clk:			another controller clock
- *
- * @regs:			a contiguous chunk of memory for DMA register
- *				writes. contains the register values to be
- *				written to controller
- *
- * @props:			properties of current NAND controller,
- *				initialized via DT match data
- *
- * @controller:			base controller structure
- * @host_list:			list containing all the chips attached to the
- *				controller
- *
- * @chan:			dma channel
- * @cmd_crci:			ADM DMA CRCI for command flow control
- * @data_crci:			ADM DMA CRCI for data flow control
- *
- * @desc_list:			DMA descriptor list (list of desc_infos)
- *
- * @data_buffer:		our local DMA buffer for page read/writes,
- *				used when we can't use the buffer provided
- *				by upper layers directly
- * @reg_read_buf:		local buffer for reading back registers via DMA
- *
- * @base_phys:			physical base address of controller registers
- * @base_dma:			dma base address of controller registers
- * @reg_read_dma:		contains dma address for register read buffer
- *
- * @buf_size/count/start:	markers for chip->legacy.read_buf/write_buf
- *				functions
- * @max_cwperpage:		maximum QPIC codewords required. calculated
- *				from all connected NAND devices pagesize
- *
- * @reg_read_pos:		marker for data read in reg_read_buf
- *
- * @cmd1/vld:			some fixed controller register values
- *
- * @exec_opwrite:		flag to select correct number of code word
- *				while reading status
- */
-struct qcom_nand_controller {
-	struct device *dev;
-
-	void __iomem *base;
-
-	struct clk *core_clk;
-	struct clk *aon_clk;
-
-	struct nandc_regs *regs;
-	struct bam_transaction *bam_txn;
-
-	const struct qcom_nandc_props *props;
-
-	struct nand_controller controller;
-	struct list_head host_list;
-
-	union {
-		/* will be used only by QPIC for BAM DMA */
-		struct {
-			struct dma_chan *tx_chan;
-			struct dma_chan *rx_chan;
-			struct dma_chan *cmd_chan;
-		};
-
-		/* will be used only by EBI2 for ADM DMA */
-		struct {
-			struct dma_chan *chan;
-			unsigned int cmd_crci;
-			unsigned int data_crci;
-		};
-	};
-
-	struct list_head desc_list;
-
-	u8		*data_buffer;
-	__le32		*reg_read_buf;
-
-	phys_addr_t base_phys;
-	dma_addr_t base_dma;
-	dma_addr_t reg_read_dma;
-
-	int		buf_size;
-	int		buf_count;
-	int		buf_start;
-	unsigned int	max_cwperpage;
-
-	int reg_read_pos;
-
-	u32 cmd1, vld;
-	bool exec_opwrite;
-};
-
 /*
  * NAND special boot partitions
  *
@@ -544,113 +124,24 @@ struct qcom_nand_host {
 	bool bch_enabled;
 };
 
-/*
- * This data type corresponds to the NAND controller properties which varies
- * among different NAND controllers.
- * @ecc_modes - ecc mode for NAND
- * @dev_cmd_reg_start - NAND_DEV_CMD_* registers starting offset
- * @is_bam - whether NAND controller is using BAM
- * @is_qpic - whether NAND CTRL is part of qpic IP
- * @qpic_v2 - flag to indicate QPIC IP version 2
- * @use_codeword_fixup - whether NAND has different layout for boot partitions
- */
-struct qcom_nandc_props {
-	u32 ecc_modes;
-	u32 dev_cmd_reg_start;
-	bool is_bam;
-	bool is_qpic;
-	bool qpic_v2;
-	bool use_codeword_fixup;
-};
-
-/* Frees the BAM transaction memory */
-static void free_bam_transaction(struct qcom_nand_controller *nandc)
-{
-	struct bam_transaction *bam_txn = nandc->bam_txn;
-
-	devm_kfree(nandc->dev, bam_txn);
-}
-
-/* Allocates and Initializes the BAM transaction */
-static struct bam_transaction *
-alloc_bam_transaction(struct qcom_nand_controller *nandc)
+struct qcom_nand_controller *
+get_qcom_nand_controller(struct nand_chip *chip)
 {
-	struct bam_transaction *bam_txn;
-	size_t bam_txn_size;
-	unsigned int num_cw = nandc->max_cwperpage;
-	void *bam_txn_buf;
-
-	bam_txn_size =
-		sizeof(*bam_txn) + num_cw *
-		((sizeof(*bam_txn->bam_ce) * QPIC_PER_CW_CMD_ELEMENTS) +
-		(sizeof(*bam_txn->cmd_sgl) * QPIC_PER_CW_CMD_SGL) +
-		(sizeof(*bam_txn->data_sgl) * QPIC_PER_CW_DATA_SGL));
-
-	bam_txn_buf = devm_kzalloc(nandc->dev, bam_txn_size, GFP_KERNEL);
-	if (!bam_txn_buf)
-		return NULL;
-
-	bam_txn = bam_txn_buf;
-	bam_txn_buf += sizeof(*bam_txn);
-
-	bam_txn->bam_ce = bam_txn_buf;
-	bam_txn_buf +=
-		sizeof(*bam_txn->bam_ce) * QPIC_PER_CW_CMD_ELEMENTS * num_cw;
-
-	bam_txn->cmd_sgl = bam_txn_buf;
-	bam_txn_buf +=
-		sizeof(*bam_txn->cmd_sgl) * QPIC_PER_CW_CMD_SGL * num_cw;
-
-	bam_txn->data_sgl = bam_txn_buf;
-
-	init_completion(&bam_txn->txn_done);
-
-	return bam_txn;
+	return container_of(chip->controller, struct qcom_nand_controller,
+			    controller);
 }
 
-/* Clears the BAM transaction indexes */
-static void clear_bam_transaction(struct qcom_nand_controller *nandc)
+static void nandc_set_reg(struct nand_chip *chip, int offset,
+			  u32 val)
 {
-	struct bam_transaction *bam_txn = nandc->bam_txn;
-
-	if (!nandc->props->is_bam)
-		return;
-
-	bam_txn->bam_ce_pos = 0;
-	bam_txn->bam_ce_start = 0;
-	bam_txn->cmd_sgl_pos = 0;
-	bam_txn->cmd_sgl_start = 0;
-	bam_txn->tx_sgl_pos = 0;
-	bam_txn->tx_sgl_start = 0;
-	bam_txn->rx_sgl_pos = 0;
-	bam_txn->rx_sgl_start = 0;
-	bam_txn->last_data_desc = NULL;
-	bam_txn->wait_second_completion = false;
-
-	sg_init_table(bam_txn->cmd_sgl, nandc->max_cwperpage *
-		      QPIC_PER_CW_CMD_SGL);
-	sg_init_table(bam_txn->data_sgl, nandc->max_cwperpage *
-		      QPIC_PER_CW_DATA_SGL);
-
-	reinit_completion(&bam_txn->txn_done);
-}
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+	struct nandc_regs *regs = nandc->regs;
+	__le32 *reg;
 
-/* Callback for DMA descriptor completion */
-static void qpic_bam_dma_done(void *data)
-{
-	struct bam_transaction *bam_txn = data;
+	reg = qcom_offset_to_nandc_reg(regs, offset);
 
-	/*
-	 * In case of data transfer with NAND, 2 callbacks will be generated.
-	 * One for command channel and another one for data channel.
-	 * If current transaction has data descriptors
-	 * (i.e. wait_second_completion is true), then set this to false
-	 * and wait for second DMA descriptor completion.
-	 */
-	if (bam_txn->wait_second_completion)
-		bam_txn->wait_second_completion = false;
-	else
-		complete(&bam_txn->txn_done);
+	if (reg)
+		*reg = cpu_to_le32(val);
 }
 
 static inline struct qcom_nand_host *to_qcom_nand_host(struct nand_chip *chip)
@@ -658,13 +149,6 @@ static inline struct qcom_nand_host *to_qcom_nand_host(struct nand_chip *chip)
 	return container_of(chip, struct qcom_nand_host, chip);
 }
 
-static inline struct qcom_nand_controller *
-get_qcom_nand_controller(struct nand_chip *chip)
-{
-	return container_of(chip->controller, struct qcom_nand_controller,
-			    controller);
-}
-
 static inline u32 nandc_read(struct qcom_nand_controller *nandc, int offset)
 {
 	return ioread32(nandc->base + offset);
@@ -676,91 +160,6 @@ static inline void nandc_write(struct qcom_nand_controller *nandc, int offset,
 	iowrite32(val, nandc->base + offset);
 }
 
-static inline void nandc_read_buffer_sync(struct qcom_nand_controller *nandc,
-					  bool is_cpu)
-{
-	if (!nandc->props->is_bam)
-		return;
-
-	if (is_cpu)
-		dma_sync_single_for_cpu(nandc->dev, nandc->reg_read_dma,
-					MAX_REG_RD *
-					sizeof(*nandc->reg_read_buf),
-					DMA_FROM_DEVICE);
-	else
-		dma_sync_single_for_device(nandc->dev, nandc->reg_read_dma,
-					   MAX_REG_RD *
-					   sizeof(*nandc->reg_read_buf),
-					   DMA_FROM_DEVICE);
-}
-
-static __le32 *offset_to_nandc_reg(struct nandc_regs *regs, int offset)
-{
-	switch (offset) {
-	case NAND_FLASH_CMD:
-		return &regs->cmd;
-	case NAND_ADDR0:
-		return &regs->addr0;
-	case NAND_ADDR1:
-		return &regs->addr1;
-	case NAND_FLASH_CHIP_SELECT:
-		return &regs->chip_sel;
-	case NAND_EXEC_CMD:
-		return &regs->exec;
-	case NAND_FLASH_STATUS:
-		return &regs->clrflashstatus;
-	case NAND_DEV0_CFG0:
-		return &regs->cfg0;
-	case NAND_DEV0_CFG1:
-		return &regs->cfg1;
-	case NAND_DEV0_ECC_CFG:
-		return &regs->ecc_bch_cfg;
-	case NAND_READ_STATUS:
-		return &regs->clrreadstatus;
-	case NAND_DEV_CMD1:
-		return &regs->cmd1;
-	case NAND_DEV_CMD1_RESTORE:
-		return &regs->orig_cmd1;
-	case NAND_DEV_CMD_VLD:
-		return &regs->vld;
-	case NAND_DEV_CMD_VLD_RESTORE:
-		return &regs->orig_vld;
-	case NAND_EBI2_ECC_BUF_CFG:
-		return &regs->ecc_buf_cfg;
-	case NAND_READ_LOCATION_0:
-		return &regs->read_location0;
-	case NAND_READ_LOCATION_1:
-		return &regs->read_location1;
-	case NAND_READ_LOCATION_2:
-		return &regs->read_location2;
-	case NAND_READ_LOCATION_3:
-		return &regs->read_location3;
-	case NAND_READ_LOCATION_LAST_CW_0:
-		return &regs->read_location_last0;
-	case NAND_READ_LOCATION_LAST_CW_1:
-		return &regs->read_location_last1;
-	case NAND_READ_LOCATION_LAST_CW_2:
-		return &regs->read_location_last2;
-	case NAND_READ_LOCATION_LAST_CW_3:
-		return &regs->read_location_last3;
-	default:
-		return NULL;
-	}
-}
-
-static void nandc_set_reg(struct nand_chip *chip, int offset,
-			  u32 val)
-{
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
-	struct nandc_regs *regs = nandc->regs;
-	__le32 *reg;
-
-	reg = offset_to_nandc_reg(regs, offset);
-
-	if (reg)
-		*reg = cpu_to_le32(val);
-}
-
 /* Helper to check the code word, whether it is last cw or not */
 static bool qcom_nandc_is_last_cw(struct nand_ecc_ctrl *ecc, int cw)
 {
@@ -852,383 +251,6 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read, i
 				   host->cw_data : host->cw_size, 1);
 }
 
-/*
- * Maps the scatter gather list for DMA transfer and forms the DMA descriptor
- * for BAM. This descriptor will be added in the NAND DMA descriptor queue
- * which will be submitted to DMA engine.
- */
-static int prepare_bam_async_desc(struct qcom_nand_controller *nandc,
-				  struct dma_chan *chan,
-				  unsigned long flags)
-{
-	struct desc_info *desc;
-	struct scatterlist *sgl;
-	unsigned int sgl_cnt;
-	int ret;
-	struct bam_transaction *bam_txn = nandc->bam_txn;
-	enum dma_transfer_direction dir_eng;
-	struct dma_async_tx_descriptor *dma_desc;
-
-	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
-	if (!desc)
-		return -ENOMEM;
-
-	if (chan == nandc->cmd_chan) {
-		sgl = &bam_txn->cmd_sgl[bam_txn->cmd_sgl_start];
-		sgl_cnt = bam_txn->cmd_sgl_pos - bam_txn->cmd_sgl_start;
-		bam_txn->cmd_sgl_start = bam_txn->cmd_sgl_pos;
-		dir_eng = DMA_MEM_TO_DEV;
-		desc->dir = DMA_TO_DEVICE;
-	} else if (chan == nandc->tx_chan) {
-		sgl = &bam_txn->data_sgl[bam_txn->tx_sgl_start];
-		sgl_cnt = bam_txn->tx_sgl_pos - bam_txn->tx_sgl_start;
-		bam_txn->tx_sgl_start = bam_txn->tx_sgl_pos;
-		dir_eng = DMA_MEM_TO_DEV;
-		desc->dir = DMA_TO_DEVICE;
-	} else {
-		sgl = &bam_txn->data_sgl[bam_txn->rx_sgl_start];
-		sgl_cnt = bam_txn->rx_sgl_pos - bam_txn->rx_sgl_start;
-		bam_txn->rx_sgl_start = bam_txn->rx_sgl_pos;
-		dir_eng = DMA_DEV_TO_MEM;
-		desc->dir = DMA_FROM_DEVICE;
-	}
-
-	sg_mark_end(sgl + sgl_cnt - 1);
-	ret = dma_map_sg(nandc->dev, sgl, sgl_cnt, desc->dir);
-	if (ret == 0) {
-		dev_err(nandc->dev, "failure in mapping desc\n");
-		kfree(desc);
-		return -ENOMEM;
-	}
-
-	desc->sgl_cnt = sgl_cnt;
-	desc->bam_sgl = sgl;
-
-	dma_desc = dmaengine_prep_slave_sg(chan, sgl, sgl_cnt, dir_eng,
-					   flags);
-
-	if (!dma_desc) {
-		dev_err(nandc->dev, "failure in prep desc\n");
-		dma_unmap_sg(nandc->dev, sgl, sgl_cnt, desc->dir);
-		kfree(desc);
-		return -EINVAL;
-	}
-
-	desc->dma_desc = dma_desc;
-
-	/* update last data/command descriptor */
-	if (chan == nandc->cmd_chan)
-		bam_txn->last_cmd_desc = dma_desc;
-	else
-		bam_txn->last_data_desc = dma_desc;
-
-	list_add_tail(&desc->node, &nandc->desc_list);
-
-	return 0;
-}
-
-/*
- * Prepares the command descriptor for BAM DMA which will be used for NAND
- * register reads and writes. The command descriptor requires the command
- * to be formed in command element type so this function uses the command
- * element from bam transaction ce array and fills the same with required
- * data. A single SGL can contain multiple command elements so
- * NAND_BAM_NEXT_SGL will be used for starting the separate SGL
- * after the current command element.
- */
-static int prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
-				 int reg_off, const void *vaddr,
-				 int size, unsigned int flags)
-{
-	int bam_ce_size;
-	int i, ret;
-	struct bam_cmd_element *bam_ce_buffer;
-	struct bam_transaction *bam_txn = nandc->bam_txn;
-
-	bam_ce_buffer = &bam_txn->bam_ce[bam_txn->bam_ce_pos];
-
-	/* fill the command desc */
-	for (i = 0; i < size; i++) {
-		if (read)
-			bam_prep_ce(&bam_ce_buffer[i],
-				    nandc_reg_phys(nandc, reg_off + 4 * i),
-				    BAM_READ_COMMAND,
-				    reg_buf_dma_addr(nandc,
-						     (__le32 *)vaddr + i));
-		else
-			bam_prep_ce_le32(&bam_ce_buffer[i],
-					 nandc_reg_phys(nandc, reg_off + 4 * i),
-					 BAM_WRITE_COMMAND,
-					 *((__le32 *)vaddr + i));
-	}
-
-	bam_txn->bam_ce_pos += size;
-
-	/* use the separate sgl after this command */
-	if (flags & NAND_BAM_NEXT_SGL) {
-		bam_ce_buffer = &bam_txn->bam_ce[bam_txn->bam_ce_start];
-		bam_ce_size = (bam_txn->bam_ce_pos -
-				bam_txn->bam_ce_start) *
-				sizeof(struct bam_cmd_element);
-		sg_set_buf(&bam_txn->cmd_sgl[bam_txn->cmd_sgl_pos],
-			   bam_ce_buffer, bam_ce_size);
-		bam_txn->cmd_sgl_pos++;
-		bam_txn->bam_ce_start = bam_txn->bam_ce_pos;
-
-		if (flags & NAND_BAM_NWD) {
-			ret = prepare_bam_async_desc(nandc, nandc->cmd_chan,
-						     DMA_PREP_FENCE |
-						     DMA_PREP_CMD);
-			if (ret)
-				return ret;
-		}
-	}
-
-	return 0;
-}
-
-/*
- * Prepares the data descriptor for BAM DMA which will be used for NAND
- * data reads and writes.
- */
-static int prep_bam_dma_desc_data(struct qcom_nand_controller *nandc, bool read,
-				  const void *vaddr,
-				  int size, unsigned int flags)
-{
-	int ret;
-	struct bam_transaction *bam_txn = nandc->bam_txn;
-
-	if (read) {
-		sg_set_buf(&bam_txn->data_sgl[bam_txn->rx_sgl_pos],
-			   vaddr, size);
-		bam_txn->rx_sgl_pos++;
-	} else {
-		sg_set_buf(&bam_txn->data_sgl[bam_txn->tx_sgl_pos],
-			   vaddr, size);
-		bam_txn->tx_sgl_pos++;
-
-		/*
-		 * BAM will only set EOT for DMA_PREP_INTERRUPT so if this flag
-		 * is not set, form the DMA descriptor
-		 */
-		if (!(flags & NAND_BAM_NO_EOT)) {
-			ret = prepare_bam_async_desc(nandc, nandc->tx_chan,
-						     DMA_PREP_INTERRUPT);
-			if (ret)
-				return ret;
-		}
-	}
-
-	return 0;
-}
-
-static int prep_adm_dma_desc(struct qcom_nand_controller *nandc, bool read,
-			     int reg_off, const void *vaddr, int size,
-			     bool flow_control)
-{
-	struct desc_info *desc;
-	struct dma_async_tx_descriptor *dma_desc;
-	struct scatterlist *sgl;
-	struct dma_slave_config slave_conf;
-	struct qcom_adm_peripheral_config periph_conf = {};
-	enum dma_transfer_direction dir_eng;
-	int ret;
-
-	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
-	if (!desc)
-		return -ENOMEM;
-
-	sgl = &desc->adm_sgl;
-
-	sg_init_one(sgl, vaddr, size);
-
-	if (read) {
-		dir_eng = DMA_DEV_TO_MEM;
-		desc->dir = DMA_FROM_DEVICE;
-	} else {
-		dir_eng = DMA_MEM_TO_DEV;
-		desc->dir = DMA_TO_DEVICE;
-	}
-
-	ret = dma_map_sg(nandc->dev, sgl, 1, desc->dir);
-	if (ret == 0) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	memset(&slave_conf, 0x00, sizeof(slave_conf));
-
-	slave_conf.device_fc = flow_control;
-	if (read) {
-		slave_conf.src_maxburst = 16;
-		slave_conf.src_addr = nandc->base_dma + reg_off;
-		if (nandc->data_crci) {
-			periph_conf.crci = nandc->data_crci;
-			slave_conf.peripheral_config = &periph_conf;
-			slave_conf.peripheral_size = sizeof(periph_conf);
-		}
-	} else {
-		slave_conf.dst_maxburst = 16;
-		slave_conf.dst_addr = nandc->base_dma + reg_off;
-		if (nandc->cmd_crci) {
-			periph_conf.crci = nandc->cmd_crci;
-			slave_conf.peripheral_config = &periph_conf;
-			slave_conf.peripheral_size = sizeof(periph_conf);
-		}
-	}
-
-	ret = dmaengine_slave_config(nandc->chan, &slave_conf);
-	if (ret) {
-		dev_err(nandc->dev, "failed to configure dma channel\n");
-		goto err;
-	}
-
-	dma_desc = dmaengine_prep_slave_sg(nandc->chan, sgl, 1, dir_eng, 0);
-	if (!dma_desc) {
-		dev_err(nandc->dev, "failed to prepare desc\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
-	desc->dma_desc = dma_desc;
-
-	list_add_tail(&desc->node, &nandc->desc_list);
-
-	return 0;
-err:
-	kfree(desc);
-
-	return ret;
-}
-
-/*
- * read_reg_dma:	prepares a descriptor to read a given number of
- *			contiguous registers to the reg_read_buf pointer
- *
- * @first:		offset of the first register in the contiguous block
- * @num_regs:		number of registers to read
- * @flags:		flags to control DMA descriptor preparation
- */
-static int read_reg_dma(struct qcom_nand_controller *nandc, int first,
-			int num_regs, unsigned int flags)
-{
-	bool flow_control = false;
-	void *vaddr;
-
-	vaddr = nandc->reg_read_buf + nandc->reg_read_pos;
-	nandc->reg_read_pos += num_regs;
-
-	if (first == NAND_DEV_CMD_VLD || first == NAND_DEV_CMD1)
-		first = dev_cmd_reg_addr(nandc, first);
-
-	if (nandc->props->is_bam)
-		return prep_bam_dma_desc_cmd(nandc, true, first, vaddr,
-					     num_regs, flags);
-
-	if (first == NAND_READ_ID || first == NAND_FLASH_STATUS)
-		flow_control = true;
-
-	return prep_adm_dma_desc(nandc, true, first, vaddr,
-				 num_regs * sizeof(u32), flow_control);
-}
-
-/*
- * write_reg_dma:	prepares a descriptor to write a given number of
- *			contiguous registers
- *
- * @first:		offset of the first register in the contiguous block
- * @num_regs:		number of registers to write
- * @flags:		flags to control DMA descriptor preparation
- */
-static int write_reg_dma(struct qcom_nand_controller *nandc, int first,
-			 int num_regs, unsigned int flags)
-{
-	bool flow_control = false;
-	struct nandc_regs *regs = nandc->regs;
-	void *vaddr;
-
-	vaddr = offset_to_nandc_reg(regs, first);
-
-	if (first == NAND_ERASED_CW_DETECT_CFG) {
-		if (flags & NAND_ERASED_CW_SET)
-			vaddr = &regs->erased_cw_detect_cfg_set;
-		else
-			vaddr = &regs->erased_cw_detect_cfg_clr;
-	}
-
-	if (first == NAND_EXEC_CMD)
-		flags |= NAND_BAM_NWD;
-
-	if (first == NAND_DEV_CMD1_RESTORE || first == NAND_DEV_CMD1)
-		first = dev_cmd_reg_addr(nandc, NAND_DEV_CMD1);
-
-	if (first == NAND_DEV_CMD_VLD_RESTORE || first == NAND_DEV_CMD_VLD)
-		first = dev_cmd_reg_addr(nandc, NAND_DEV_CMD_VLD);
-
-	if (nandc->props->is_bam)
-		return prep_bam_dma_desc_cmd(nandc, false, first, vaddr,
-					     num_regs, flags);
-
-	if (first == NAND_FLASH_CMD)
-		flow_control = true;
-
-	return prep_adm_dma_desc(nandc, false, first, vaddr,
-				 num_regs * sizeof(u32), flow_control);
-}
-
-/*
- * read_data_dma:	prepares a DMA descriptor to transfer data from the
- *			controller's internal buffer to the buffer 'vaddr'
- *
- * @reg_off:		offset within the controller's data buffer
- * @vaddr:		virtual address of the buffer we want to write to
- * @size:		DMA transaction size in bytes
- * @flags:		flags to control DMA descriptor preparation
- */
-static int read_data_dma(struct qcom_nand_controller *nandc, int reg_off,
-			 const u8 *vaddr, int size, unsigned int flags)
-{
-	if (nandc->props->is_bam)
-		return prep_bam_dma_desc_data(nandc, true, vaddr, size, flags);
-
-	return prep_adm_dma_desc(nandc, true, reg_off, vaddr, size, false);
-}
-
-/*
- * write_data_dma:	prepares a DMA descriptor to transfer data from
- *			'vaddr' to the controller's internal buffer
- *
- * @reg_off:		offset within the controller's data buffer
- * @vaddr:		virtual address of the buffer we want to read from
- * @size:		DMA transaction size in bytes
- * @flags:		flags to control DMA descriptor preparation
- */
-static int write_data_dma(struct qcom_nand_controller *nandc, int reg_off,
-			  const u8 *vaddr, int size, unsigned int flags)
-{
-	if (nandc->props->is_bam)
-		return prep_bam_dma_desc_data(nandc, false, vaddr, size, flags);
-
-	return prep_adm_dma_desc(nandc, false, reg_off, vaddr, size, false);
-}
-
-/*
- * Helper to prepare DMA descriptors for configuring registers
- * before reading a NAND page.
- */
-static void config_nand_page_read(struct nand_chip *chip)
-{
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
-
-	write_reg_dma(nandc, NAND_ADDR0, 2, 0);
-	write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
-	if (!nandc->props->qpic_v2)
-		write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1, 0);
-	write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1, 0);
-	write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1,
-		      NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
-}
-
 /*
  * Helper to prepare DMA descriptors for configuring registers
  * before reading each codeword in NAND page.
@@ -1245,20 +267,37 @@ config_nand_cw_read(struct nand_chip *chip, bool use_ecc, int cw)
 		reg = NAND_READ_LOCATION_LAST_CW_0;
 
 	if (nandc->props->is_bam)
-		write_reg_dma(nandc, reg, 4, NAND_BAM_NEXT_SGL);
+		qcom_write_reg_dma(nandc, reg, 4, NAND_BAM_NEXT_SGL);
 
-	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
-	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
 
 	if (use_ecc) {
-		read_reg_dma(nandc, NAND_FLASH_STATUS, 2, 0);
-		read_reg_dma(nandc, NAND_ERASED_CW_DETECT_STATUS, 1,
-			     NAND_BAM_NEXT_SGL);
+		qcom_read_reg_dma(nandc, NAND_FLASH_STATUS, 2, 0);
+		qcom_read_reg_dma(nandc, NAND_ERASED_CW_DETECT_STATUS, 1,
+				  NAND_BAM_NEXT_SGL);
 	} else {
-		read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
+		qcom_read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
 	}
 }
 
+/*
+ * Helper to prepare DMA descriptors for configuring registers
+ * before reading a NAND page.
+ */
+void config_nand_page_read(struct nand_chip *chip)
+{
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+
+	qcom_write_reg_dma(nandc, NAND_ADDR0, 2, 0);
+	qcom_write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
+	if (!nandc->props->qpic_v2)
+		qcom_write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1, 0);
+	qcom_write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1, 0);
+	qcom_write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1,
+			   NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
+}
+
 /*
  * Helper to prepare dma descriptors to configure registers needed for reading a
  * single codeword in page
@@ -1279,11 +318,11 @@ static void config_nand_page_write(struct nand_chip *chip)
 {
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 
-	write_reg_dma(nandc, NAND_ADDR0, 2, 0);
-	write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
+	qcom_write_reg_dma(nandc, NAND_ADDR0, 2, 0);
+	qcom_write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
 	if (!nandc->props->qpic_v2)
-		write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1,
-			      NAND_BAM_NEXT_SGL);
+		qcom_write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1,
+				   NAND_BAM_NEXT_SGL);
 }
 
 /*
@@ -1294,95 +333,13 @@ static void config_nand_cw_write(struct nand_chip *chip)
 {
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 
-	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
-	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
 
-	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
+	qcom_read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
 
-	write_reg_dma(nandc, NAND_FLASH_STATUS, 1, 0);
-	write_reg_dma(nandc, NAND_READ_STATUS, 1, NAND_BAM_NEXT_SGL);
-}
-
-/* helpers to submit/free our list of dma descriptors */
-static int submit_descs(struct qcom_nand_controller *nandc)
-{
-	struct desc_info *desc, *n;
-	dma_cookie_t cookie = 0;
-	struct bam_transaction *bam_txn = nandc->bam_txn;
-	int ret = 0;
-
-	if (nandc->props->is_bam) {
-		if (bam_txn->rx_sgl_pos > bam_txn->rx_sgl_start) {
-			ret = prepare_bam_async_desc(nandc, nandc->rx_chan, 0);
-			if (ret)
-				goto err_unmap_free_desc;
-		}
-
-		if (bam_txn->tx_sgl_pos > bam_txn->tx_sgl_start) {
-			ret = prepare_bam_async_desc(nandc, nandc->tx_chan,
-						   DMA_PREP_INTERRUPT);
-			if (ret)
-				goto err_unmap_free_desc;
-		}
-
-		if (bam_txn->cmd_sgl_pos > bam_txn->cmd_sgl_start) {
-			ret = prepare_bam_async_desc(nandc, nandc->cmd_chan,
-						   DMA_PREP_CMD);
-			if (ret)
-				goto err_unmap_free_desc;
-		}
-	}
-
-	list_for_each_entry(desc, &nandc->desc_list, node)
-		cookie = dmaengine_submit(desc->dma_desc);
-
-	if (nandc->props->is_bam) {
-		bam_txn->last_cmd_desc->callback = qpic_bam_dma_done;
-		bam_txn->last_cmd_desc->callback_param = bam_txn;
-		if (bam_txn->last_data_desc) {
-			bam_txn->last_data_desc->callback = qpic_bam_dma_done;
-			bam_txn->last_data_desc->callback_param = bam_txn;
-			bam_txn->wait_second_completion = true;
-		}
-
-		dma_async_issue_pending(nandc->tx_chan);
-		dma_async_issue_pending(nandc->rx_chan);
-		dma_async_issue_pending(nandc->cmd_chan);
-
-		if (!wait_for_completion_timeout(&bam_txn->txn_done,
-						 QPIC_NAND_COMPLETION_TIMEOUT))
-			ret = -ETIMEDOUT;
-	} else {
-		if (dma_sync_wait(nandc->chan, cookie) != DMA_COMPLETE)
-			ret = -ETIMEDOUT;
-	}
-
-err_unmap_free_desc:
-	/*
-	 * Unmap the dma sg_list and free the desc allocated by both
-	 * prepare_bam_async_desc() and prep_adm_dma_desc() functions.
-	 */
-	list_for_each_entry_safe(desc, n, &nandc->desc_list, node) {
-		list_del(&desc->node);
-
-		if (nandc->props->is_bam)
-			dma_unmap_sg(nandc->dev, desc->bam_sgl,
-				     desc->sgl_cnt, desc->dir);
-		else
-			dma_unmap_sg(nandc->dev, &desc->adm_sgl, 1,
-				     desc->dir);
-
-		kfree(desc);
-	}
-
-	return ret;
-}
-
-/* reset the register read buffer for next NAND operation */
-static void clear_read_regs(struct qcom_nand_controller *nandc)
-{
-	nandc->reg_read_pos = 0;
-	nandc_read_buffer_sync(nandc, false);
+	qcom_write_reg_dma(nandc, NAND_FLASH_STATUS, 1, 0);
+	qcom_write_reg_dma(nandc, NAND_READ_STATUS, 1, NAND_BAM_NEXT_SGL);
 }
 
 /*
@@ -1446,7 +403,7 @@ static int check_flash_errors(struct qcom_nand_host *host, int cw_cnt)
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	int i;
 
-	nandc_read_buffer_sync(nandc, true);
+	qcom_nandc_read_buffer_sync(nandc, true);
 
 	for (i = 0; i < cw_cnt; i++) {
 		u32 flash = le32_to_cpu(nandc->reg_read_buf[i]);
@@ -1473,13 +430,13 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	nand_read_page_op(chip, page, 0, NULL, 0);
 	nandc->buf_count = 0;
 	nandc->buf_start = 0;
-	clear_read_regs(nandc);
+	qcom_clear_read_regs(nandc);
 	host->use_ecc = false;
 
 	if (nandc->props->qpic_v2)
 		raw_cw = ecc->steps - 1;
 
-	clear_bam_transaction(nandc);
+	qcom_clear_bam_transaction(nandc);
 	set_address(host, host->cw_size * cw, page);
 	update_rw_regs(host, 1, true, raw_cw);
 	config_nand_page_read(chip);
@@ -1512,18 +469,18 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
 
 	config_nand_cw_read(chip, false, raw_cw);
 
-	read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
+	qcom_read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
 	reg_off += data_size1;
 
-	read_data_dma(nandc, reg_off, oob_buf, oob_size1, 0);
+	qcom_read_data_dma(nandc, reg_off, oob_buf, oob_size1, 0);
 	reg_off += oob_size1;
 
-	read_data_dma(nandc, reg_off, data_buf + data_size1, data_size2, 0);
+	qcom_read_data_dma(nandc, reg_off, data_buf + data_size1, data_size2, 0);
 	reg_off += data_size2;
 
-	read_data_dma(nandc, reg_off, oob_buf + oob_size1, oob_size2, 0);
+	qcom_read_data_dma(nandc, reg_off, oob_buf + oob_size1, oob_size2, 0);
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure to read raw cw %d\n", cw);
 		return ret;
@@ -1621,7 +578,7 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 	u8 *data_buf_start = data_buf, *oob_buf_start = oob_buf;
 
 	buf = (struct read_stats *)nandc->reg_read_buf;
-	nandc_read_buffer_sync(nandc, true);
+	qcom_nandc_read_buffer_sync(nandc, true);
 
 	for (i = 0; i < ecc->steps; i++, buf++) {
 		u32 flash, buffer, erased_cw;
@@ -1750,8 +707,8 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 		config_nand_cw_read(chip, true, i);
 
 		if (data_buf)
-			read_data_dma(nandc, FLASH_BUF_ACC, data_buf,
-				      data_size, 0);
+			qcom_read_data_dma(nandc, FLASH_BUF_ACC, data_buf,
+					   data_size, 0);
 
 		/*
 		 * when ecc is enabled, the controller doesn't read the real
@@ -1766,8 +723,8 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 			for (j = 0; j < host->bbm_size; j++)
 				*oob_buf++ = 0xff;
 
-			read_data_dma(nandc, FLASH_BUF_ACC + data_size,
-				      oob_buf, oob_size, 0);
+			qcom_read_data_dma(nandc, FLASH_BUF_ACC + data_size,
+					   oob_buf, oob_size, 0);
 		}
 
 		if (data_buf)
@@ -1776,7 +733,7 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 			oob_buf += oob_size;
 	}
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure to read page/oob\n");
 		return ret;
@@ -1797,7 +754,7 @@ static int copy_last_cw(struct qcom_nand_host *host, int page)
 	int size;
 	int ret;
 
-	clear_read_regs(nandc);
+	qcom_clear_read_regs(nandc);
 
 	size = host->use_ecc ? host->cw_data : host->cw_size;
 
@@ -1809,9 +766,9 @@ static int copy_last_cw(struct qcom_nand_host *host, int page)
 
 	config_nand_single_cw_page_read(chip, host->use_ecc, ecc->steps - 1);
 
-	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, size, 0);
+	qcom_read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, size, 0);
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret)
 		dev_err(nandc->dev, "failed to copy last codeword\n");
 
@@ -1897,14 +854,14 @@ static int qcom_nandc_read_page(struct nand_chip *chip, u8 *buf,
 	nandc->buf_count = 0;
 	nandc->buf_start = 0;
 	host->use_ecc = true;
-	clear_read_regs(nandc);
+	qcom_clear_read_regs(nandc);
 	set_address(host, 0, page);
 	update_rw_regs(host, ecc->steps, true, 0);
 
 	data_buf = buf;
 	oob_buf = oob_required ? chip->oob_poi : NULL;
 
-	clear_bam_transaction(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	return read_page_ecc(host, data_buf, oob_buf, page);
 }
@@ -1945,8 +902,8 @@ static int qcom_nandc_read_oob(struct nand_chip *chip, int page)
 	if (host->nr_boot_partitions)
 		qcom_nandc_codeword_fixup(host, page);
 
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	host->use_ecc = true;
 	set_address(host, 0, page);
@@ -1973,8 +930,8 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const u8 *buf,
 	set_address(host, 0, page);
 	nandc->buf_count = 0;
 	nandc->buf_start = 0;
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	data_buf = (u8 *)buf;
 	oob_buf = chip->oob_poi;
@@ -1995,8 +952,8 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const u8 *buf,
 			oob_size = ecc->bytes;
 		}
 
-		write_data_dma(nandc, FLASH_BUF_ACC, data_buf, data_size,
-			       i == (ecc->steps - 1) ? NAND_BAM_NO_EOT : 0);
+		qcom_write_data_dma(nandc, FLASH_BUF_ACC, data_buf, data_size,
+				    i == (ecc->steps - 1) ? NAND_BAM_NO_EOT : 0);
 
 		/*
 		 * when ECC is enabled, we don't really need to write anything
@@ -2008,8 +965,8 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const u8 *buf,
 		if (qcom_nandc_is_last_cw(ecc, i)) {
 			oob_buf += host->bbm_size;
 
-			write_data_dma(nandc, FLASH_BUF_ACC + data_size,
-				       oob_buf, oob_size, 0);
+			qcom_write_data_dma(nandc, FLASH_BUF_ACC + data_size,
+					    oob_buf, oob_size, 0);
 		}
 
 		config_nand_cw_write(chip);
@@ -2018,7 +975,7 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const u8 *buf,
 		oob_buf += oob_size;
 	}
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure to write page\n");
 		return ret;
@@ -2043,8 +1000,8 @@ static int qcom_nandc_write_page_raw(struct nand_chip *chip,
 		qcom_nandc_codeword_fixup(host, page);
 
 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	data_buf = (u8 *)buf;
 	oob_buf = chip->oob_poi;
@@ -2070,28 +1027,28 @@ static int qcom_nandc_write_page_raw(struct nand_chip *chip,
 			oob_size2 = host->ecc_bytes_hw + host->spare_bytes;
 		}
 
-		write_data_dma(nandc, reg_off, data_buf, data_size1,
-			       NAND_BAM_NO_EOT);
+		qcom_write_data_dma(nandc, reg_off, data_buf, data_size1,
+				    NAND_BAM_NO_EOT);
 		reg_off += data_size1;
 		data_buf += data_size1;
 
-		write_data_dma(nandc, reg_off, oob_buf, oob_size1,
-			       NAND_BAM_NO_EOT);
+		qcom_write_data_dma(nandc, reg_off, oob_buf, oob_size1,
+				    NAND_BAM_NO_EOT);
 		reg_off += oob_size1;
 		oob_buf += oob_size1;
 
-		write_data_dma(nandc, reg_off, data_buf, data_size2,
-			       NAND_BAM_NO_EOT);
+		qcom_write_data_dma(nandc, reg_off, data_buf, data_size2,
+				    NAND_BAM_NO_EOT);
 		reg_off += data_size2;
 		data_buf += data_size2;
 
-		write_data_dma(nandc, reg_off, oob_buf, oob_size2, 0);
+		qcom_write_data_dma(nandc, reg_off, oob_buf, oob_size2, 0);
 		oob_buf += oob_size2;
 
 		config_nand_cw_write(chip);
 	}
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure to write raw page\n");
 		return ret;
@@ -2121,7 +1078,7 @@ static int qcom_nandc_write_oob(struct nand_chip *chip, int page)
 		qcom_nandc_codeword_fixup(host, page);
 
 	host->use_ecc = true;
-	clear_bam_transaction(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	/* calculate the data and oob size for the last codeword/step */
 	data_size = ecc->size - ((ecc->steps - 1) << 2);
@@ -2136,11 +1093,11 @@ static int qcom_nandc_write_oob(struct nand_chip *chip, int page)
 	update_rw_regs(host, 1, false, 0);
 
 	config_nand_page_write(chip);
-	write_data_dma(nandc, FLASH_BUF_ACC,
-		       nandc->data_buffer, data_size + oob_size, 0);
+	qcom_write_data_dma(nandc, FLASH_BUF_ACC,
+			    nandc->data_buffer, data_size + oob_size, 0);
 	config_nand_cw_write(chip);
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure to write oob\n");
 		return ret;
@@ -2167,7 +1124,7 @@ static int qcom_nandc_block_bad(struct nand_chip *chip, loff_t ofs)
 	 */
 	host->use_ecc = false;
 
-	clear_bam_transaction(nandc);
+	qcom_clear_bam_transaction(nandc);
 	ret = copy_last_cw(host, page);
 	if (ret)
 		goto err;
@@ -2194,8 +1151,8 @@ static int qcom_nandc_block_markbad(struct nand_chip *chip, loff_t ofs)
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int page, ret;
 
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	/*
 	 * to mark the BBM as bad, we flash the entire last codeword with 0s.
@@ -2212,11 +1169,11 @@ static int qcom_nandc_block_markbad(struct nand_chip *chip, loff_t ofs)
 	update_rw_regs(host, 1, false, ecc->steps - 1);
 
 	config_nand_page_write(chip);
-	write_data_dma(nandc, FLASH_BUF_ACC,
-		       nandc->data_buffer, host->cw_size, 0);
+	qcom_write_data_dma(nandc, FLASH_BUF_ACC,
+			    nandc->data_buffer, host->cw_size, 0);
 	config_nand_cw_write(chip);
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure to update BBM\n");
 		return ret;
@@ -2456,14 +1413,14 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
 	mtd_set_ooblayout(mtd, &qcom_nand_ooblayout_ops);
 	/* Free the initially allocated BAM transaction for reading the ONFI params */
 	if (nandc->props->is_bam)
-		free_bam_transaction(nandc);
+		qcom_free_bam_transaction(nandc);
 
 	nandc->max_cwperpage = max_t(unsigned int, nandc->max_cwperpage,
 				     cwperpage);
 
 	/* Now allocate the BAM transaction based on updated max_cwperpage */
 	if (nandc->props->is_bam) {
-		nandc->bam_txn = alloc_bam_transaction(nandc);
+		nandc->bam_txn = qcom_alloc_bam_transaction(nandc);
 		if (!nandc->bam_txn) {
 			dev_err(nandc->dev,
 				"failed to allocate bam transaction\n");
@@ -2663,7 +1620,7 @@ static int qcom_wait_rdy_poll(struct nand_chip *chip, unsigned int time_ms)
 	unsigned long start = jiffies + msecs_to_jiffies(time_ms);
 	u32 flash;
 
-	nandc_read_buffer_sync(nandc, true);
+	qcom_nandc_read_buffer_sync(nandc, true);
 
 	do {
 		flash = le32_to_cpu(nandc->reg_read_buf[0]);
@@ -2703,23 +1660,23 @@ static int qcom_read_status_exec(struct nand_chip *chip,
 	nandc->buf_start = 0;
 	host->use_ecc = false;
 
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
 	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
 
-	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
-	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
-	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
+	qcom_read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure in submitting status descriptor\n");
 		goto err_out;
 	}
 
-	nandc_read_buffer_sync(nandc, true);
+	qcom_nandc_read_buffer_sync(nandc, true);
 
 	for (i = 0; i < num_cw; i++) {
 		flash_status = le32_to_cpu(nandc->reg_read_buf[i]);
@@ -2760,8 +1717,8 @@ static int qcom_read_id_type_exec(struct nand_chip *chip, const struct nand_subo
 	nandc->buf_start = 0;
 	host->use_ecc = false;
 
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
 	nandc_set_reg(chip, NAND_ADDR0, q_op.addr1_reg);
@@ -2771,12 +1728,12 @@ static int qcom_read_id_type_exec(struct nand_chip *chip, const struct nand_subo
 
 	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
 
-	write_reg_dma(nandc, NAND_FLASH_CMD, 4, NAND_BAM_NEXT_SGL);
-	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(nandc, NAND_FLASH_CMD, 4, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
 
-	read_reg_dma(nandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
+	qcom_read_reg_dma(nandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure in submitting read id descriptor\n");
 		goto err_out;
@@ -2786,7 +1743,7 @@ static int qcom_read_id_type_exec(struct nand_chip *chip, const struct nand_subo
 	op_id = q_op.data_instr_idx;
 	len = nand_subop_get_data_len(subop, op_id);
 
-	nandc_read_buffer_sync(nandc, true);
+	qcom_nandc_read_buffer_sync(nandc, true);
 	memcpy(instr->ctx.data.buf.in, nandc->reg_read_buf, len);
 
 err_out:
@@ -2823,21 +1780,21 @@ static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_sub
 	nandc->buf_start = 0;
 	host->use_ecc = false;
 
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
 	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
 
-	write_reg_dma(nandc, NAND_FLASH_CMD, instrs, NAND_BAM_NEXT_SGL);
-	(q_op.cmd_reg == OP_BLOCK_ERASE) ? write_reg_dma(nandc, NAND_DEV0_CFG0,
-	2, NAND_BAM_NEXT_SGL) : read_reg_dma(nandc,
+	qcom_write_reg_dma(nandc, NAND_FLASH_CMD, instrs, NAND_BAM_NEXT_SGL);
+	(q_op.cmd_reg == OP_BLOCK_ERASE) ? qcom_write_reg_dma(nandc, NAND_DEV0_CFG0,
+	2, NAND_BAM_NEXT_SGL) : qcom_read_reg_dma(nandc,
 	NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
 
-	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
-	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
+	qcom_read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure in submitting misc descriptor\n");
 		goto err_out;
@@ -2870,8 +1827,8 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 	nandc->buf_count = 0;
 	nandc->buf_start = 0;
 	host->use_ecc = false;
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
 
@@ -2914,8 +1871,8 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 	nandc_set_read_loc(chip, 0, 0, 0, len, 1);
 
 	if (!nandc->props->qpic_v2) {
-		write_reg_dma(nandc, NAND_DEV_CMD_VLD, 1, 0);
-		write_reg_dma(nandc, NAND_DEV_CMD1, 1, NAND_BAM_NEXT_SGL);
+		qcom_write_reg_dma(nandc, NAND_DEV_CMD_VLD, 1, 0);
+		qcom_write_reg_dma(nandc, NAND_DEV_CMD1, 1, NAND_BAM_NEXT_SGL);
 	}
 
 	nandc->buf_count = len;
@@ -2923,16 +1880,16 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 
 	config_nand_single_cw_page_read(chip, false, 0);
 
-	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer,
-		      nandc->buf_count, 0);
+	qcom_read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer,
+			   nandc->buf_count, 0);
 
 	/* restore CMD1 and VLD regs */
 	if (!nandc->props->qpic_v2) {
-		write_reg_dma(nandc, NAND_DEV_CMD1_RESTORE, 1, 0);
-		write_reg_dma(nandc, NAND_DEV_CMD_VLD_RESTORE, 1, NAND_BAM_NEXT_SGL);
+		qcom_write_reg_dma(nandc, NAND_DEV_CMD1_RESTORE, 1, 0);
+		qcom_write_reg_dma(nandc, NAND_DEV_CMD_VLD_RESTORE, 1, NAND_BAM_NEXT_SGL);
 	}
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure in submitting param page descriptor\n");
 		goto err_out;
@@ -3016,136 +1973,6 @@ static const struct nand_controller_ops qcom_nandc_ops = {
 	.exec_op = qcom_nand_exec_op,
 };
 
-static void qcom_nandc_unalloc(struct qcom_nand_controller *nandc)
-{
-	if (nandc->props->is_bam) {
-		if (!dma_mapping_error(nandc->dev, nandc->reg_read_dma))
-			dma_unmap_single(nandc->dev, nandc->reg_read_dma,
-					 MAX_REG_RD *
-					 sizeof(*nandc->reg_read_buf),
-					 DMA_FROM_DEVICE);
-
-		if (nandc->tx_chan)
-			dma_release_channel(nandc->tx_chan);
-
-		if (nandc->rx_chan)
-			dma_release_channel(nandc->rx_chan);
-
-		if (nandc->cmd_chan)
-			dma_release_channel(nandc->cmd_chan);
-	} else {
-		if (nandc->chan)
-			dma_release_channel(nandc->chan);
-	}
-}
-
-static int qcom_nandc_alloc(struct qcom_nand_controller *nandc)
-{
-	int ret;
-
-	ret = dma_set_coherent_mask(nandc->dev, DMA_BIT_MASK(32));
-	if (ret) {
-		dev_err(nandc->dev, "failed to set DMA mask\n");
-		return ret;
-	}
-
-	/*
-	 * we use the internal buffer for reading ONFI params, reading small
-	 * data like ID and status, and preforming read-copy-write operations
-	 * when writing to a codeword partially. 532 is the maximum possible
-	 * size of a codeword for our nand controller
-	 */
-	nandc->buf_size = 532;
-
-	nandc->data_buffer = devm_kzalloc(nandc->dev, nandc->buf_size, GFP_KERNEL);
-	if (!nandc->data_buffer)
-		return -ENOMEM;
-
-	nandc->regs = devm_kzalloc(nandc->dev, sizeof(*nandc->regs), GFP_KERNEL);
-	if (!nandc->regs)
-		return -ENOMEM;
-
-	nandc->reg_read_buf = devm_kcalloc(nandc->dev, MAX_REG_RD,
-					   sizeof(*nandc->reg_read_buf),
-					   GFP_KERNEL);
-	if (!nandc->reg_read_buf)
-		return -ENOMEM;
-
-	if (nandc->props->is_bam) {
-		nandc->reg_read_dma =
-			dma_map_single(nandc->dev, nandc->reg_read_buf,
-				       MAX_REG_RD *
-				       sizeof(*nandc->reg_read_buf),
-				       DMA_FROM_DEVICE);
-		if (dma_mapping_error(nandc->dev, nandc->reg_read_dma)) {
-			dev_err(nandc->dev, "failed to DMA MAP reg buffer\n");
-			return -EIO;
-		}
-
-		nandc->tx_chan = dma_request_chan(nandc->dev, "tx");
-		if (IS_ERR(nandc->tx_chan)) {
-			ret = PTR_ERR(nandc->tx_chan);
-			nandc->tx_chan = NULL;
-			dev_err_probe(nandc->dev, ret,
-				      "tx DMA channel request failed\n");
-			goto unalloc;
-		}
-
-		nandc->rx_chan = dma_request_chan(nandc->dev, "rx");
-		if (IS_ERR(nandc->rx_chan)) {
-			ret = PTR_ERR(nandc->rx_chan);
-			nandc->rx_chan = NULL;
-			dev_err_probe(nandc->dev, ret,
-				      "rx DMA channel request failed\n");
-			goto unalloc;
-		}
-
-		nandc->cmd_chan = dma_request_chan(nandc->dev, "cmd");
-		if (IS_ERR(nandc->cmd_chan)) {
-			ret = PTR_ERR(nandc->cmd_chan);
-			nandc->cmd_chan = NULL;
-			dev_err_probe(nandc->dev, ret,
-				      "cmd DMA channel request failed\n");
-			goto unalloc;
-		}
-
-		/*
-		 * Initially allocate BAM transaction to read ONFI param page.
-		 * After detecting all the devices, this BAM transaction will
-		 * be freed and the next BAM transaction will be allocated with
-		 * maximum codeword size
-		 */
-		nandc->max_cwperpage = 1;
-		nandc->bam_txn = alloc_bam_transaction(nandc);
-		if (!nandc->bam_txn) {
-			dev_err(nandc->dev,
-				"failed to allocate bam transaction\n");
-			ret = -ENOMEM;
-			goto unalloc;
-		}
-	} else {
-		nandc->chan = dma_request_chan(nandc->dev, "rxtx");
-		if (IS_ERR(nandc->chan)) {
-			ret = PTR_ERR(nandc->chan);
-			nandc->chan = NULL;
-			dev_err_probe(nandc->dev, ret,
-				      "rxtx DMA channel request failed\n");
-			return ret;
-		}
-	}
-
-	INIT_LIST_HEAD(&nandc->desc_list);
-	INIT_LIST_HEAD(&nandc->host_list);
-
-	nand_controller_init(&nandc->controller);
-	nandc->controller.ops = &qcom_nandc_ops;
-
-	return 0;
-unalloc:
-	qcom_nandc_unalloc(nandc);
-	return ret;
-}
-
 /* one time setup of a few nand controller registers */
 static int qcom_nandc_setup(struct qcom_nand_controller *nandc)
 {
@@ -3427,6 +2254,9 @@ static int qcom_nandc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_nandc_alloc;
 
+	nand_controller_init(&nandc->controller);
+	nandc->controller.ops = &qcom_nandc_ops;
+
 	ret = qcom_nandc_setup(nandc);
 	if (ret)
 		goto err_setup;
@@ -3473,28 +2303,28 @@ static void qcom_nandc_remove(struct platform_device *pdev)
 			   DMA_BIDIRECTIONAL, 0);
 }
 
-static const struct qcom_nandc_props ipq806x_nandc_props = {
+static struct qcom_nandc_props ipq806x_nandc_props = {
 	.ecc_modes = (ECC_RS_4BIT | ECC_BCH_8BIT),
 	.is_bam = false,
 	.use_codeword_fixup = true,
 	.dev_cmd_reg_start = 0x0,
 };
 
-static const struct qcom_nandc_props ipq4019_nandc_props = {
+static struct qcom_nandc_props ipq4019_nandc_props = {
 	.ecc_modes = (ECC_BCH_4BIT | ECC_BCH_8BIT),
 	.is_bam = true,
 	.is_qpic = true,
 	.dev_cmd_reg_start = 0x0,
 };
 
-static const struct qcom_nandc_props ipq8074_nandc_props = {
+static struct qcom_nandc_props ipq8074_nandc_props = {
 	.ecc_modes = (ECC_BCH_4BIT | ECC_BCH_8BIT),
 	.is_bam = true,
 	.is_qpic = true,
 	.dev_cmd_reg_start = 0x7000,
 };
 
-static const struct qcom_nandc_props sdx55_nandc_props = {
+static struct qcom_nandc_props sdx55_nandc_props = {
 	.ecc_modes = (ECC_BCH_4BIT | ECC_BCH_8BIT),
 	.is_bam = true,
 	.is_qpic = true,
diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mtd/nand-qpic-common.h
new file mode 100644
index 000000000000..aced15866627
--- /dev/null
+++ b/include/linux/mtd/nand-qpic-common.h
@@ -0,0 +1,486 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * QCOM QPIC common APIs header file
+ *
+ * Copyright (c) 2023 Qualcomm Inc.
+ * Authors:     Md sadre Alam           <quic_mdalam@quicinc.com>
+ *		Sricharan R             <quic_srichara@quicinc.com>
+ *		Varadarajan Narayanan   <quic_varada@quicinc.com>
+ *
+ */
+#ifndef __MTD_NAND_QPIC_COMMON_H__
+#define __MTD_NAND_QPIC_COMMON_H__
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma/qcom_adm.h>
+#include <linux/dma/qcom_bam_dma.h>
+#include <linux/module.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/rawnand.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+/* NANDc reg offsets */
+#define	NAND_FLASH_CMD			0x00
+#define	NAND_ADDR0			0x04
+#define	NAND_ADDR1			0x08
+#define	NAND_FLASH_CHIP_SELECT		0x0c
+#define	NAND_EXEC_CMD			0x10
+#define	NAND_FLASH_STATUS		0x14
+#define	NAND_BUFFER_STATUS		0x18
+#define	NAND_DEV0_CFG0			0x20
+#define	NAND_DEV0_CFG1			0x24
+#define	NAND_DEV0_ECC_CFG		0x28
+#define	NAND_AUTO_STATUS_EN		0x2c
+#define	NAND_DEV1_CFG0			0x30
+#define	NAND_DEV1_CFG1			0x34
+#define	NAND_READ_ID			0x40
+#define	NAND_READ_STATUS		0x44
+#define	NAND_DEV_CMD0			0xa0
+#define	NAND_DEV_CMD1			0xa4
+#define	NAND_DEV_CMD2			0xa8
+#define	NAND_DEV_CMD_VLD		0xac
+#define	SFLASHC_BURST_CFG		0xe0
+#define	NAND_ERASED_CW_DETECT_CFG	0xe8
+#define	NAND_ERASED_CW_DETECT_STATUS	0xec
+#define	NAND_EBI2_ECC_BUF_CFG		0xf0
+#define	FLASH_BUF_ACC			0x100
+
+#define	NAND_CTRL			0xf00
+#define	NAND_VERSION			0xf08
+#define	NAND_READ_LOCATION_0		0xf20
+#define	NAND_READ_LOCATION_1		0xf24
+#define	NAND_READ_LOCATION_2		0xf28
+#define	NAND_READ_LOCATION_3		0xf2c
+#define	NAND_READ_LOCATION_LAST_CW_0	0xf40
+#define	NAND_READ_LOCATION_LAST_CW_1	0xf44
+#define	NAND_READ_LOCATION_LAST_CW_2	0xf48
+#define	NAND_READ_LOCATION_LAST_CW_3	0xf4c
+
+/* dummy register offsets, used by write_reg_dma */
+#define	NAND_DEV_CMD1_RESTORE		0xdead
+#define	NAND_DEV_CMD_VLD_RESTORE	0xbeef
+
+/* NAND_FLASH_CMD bits */
+#define	PAGE_ACC			BIT(4)
+#define	LAST_PAGE			BIT(5)
+
+/* NAND_FLASH_CHIP_SELECT bits */
+#define	NAND_DEV_SEL			0
+#define	DM_EN				BIT(2)
+
+/* NAND_FLASH_STATUS bits */
+#define	FS_OP_ERR			BIT(4)
+#define	FS_READY_BSY_N			BIT(5)
+#define	FS_MPU_ERR			BIT(8)
+#define	FS_DEVICE_STS_ERR		BIT(16)
+#define	FS_DEVICE_WP			BIT(23)
+
+/* NAND_BUFFER_STATUS bits */
+#define	BS_UNCORRECTABLE_BIT		BIT(8)
+#define	BS_CORRECTABLE_ERR_MSK		0x1f
+
+/* NAND_DEVn_CFG0 bits */
+#define	DISABLE_STATUS_AFTER_WRITE	4
+#define	CW_PER_PAGE			6
+#define	UD_SIZE_BYTES			9
+#define	UD_SIZE_BYTES_MASK		GENMASK(18, 9)
+#define	ECC_PARITY_SIZE_BYTES_RS	19
+#define	SPARE_SIZE_BYTES		23
+#define	SPARE_SIZE_BYTES_MASK		GENMASK(26, 23)
+#define	NUM_ADDR_CYCLES			27
+#define	STATUS_BFR_READ			30
+#define	SET_RD_MODE_AFTER_STATUS	31
+
+/* NAND_DEVn_CFG0 bits */
+#define	DEV0_CFG1_ECC_DISABLE		0
+#define	WIDE_FLASH			1
+#define	NAND_RECOVERY_CYCLES		2
+#define	CS_ACTIVE_BSY			5
+#define	BAD_BLOCK_BYTE_NUM		6
+#define	BAD_BLOCK_IN_SPARE_AREA		16
+#define	WR_RD_BSY_GAP			17
+#define	ENABLE_BCH_ECC			27
+
+/* NAND_DEV0_ECC_CFG bits */
+#define	ECC_CFG_ECC_DISABLE		0
+#define	ECC_SW_RESET			1
+#define	ECC_MODE			4
+#define	ECC_PARITY_SIZE_BYTES_BCH	8
+#define	ECC_NUM_DATA_BYTES		16
+#define	ECC_NUM_DATA_BYTES_MASK		GENMASK(25, 16)
+#define	ECC_FORCE_CLK_OPEN		30
+
+/* NAND_DEV_CMD1 bits */
+#define	READ_ADDR			0
+
+/* NAND_DEV_CMD_VLD bits */
+#define	READ_START_VLD			BIT(0)
+#define	READ_STOP_VLD			BIT(1)
+#define	WRITE_START_VLD			BIT(2)
+#define	ERASE_START_VLD			BIT(3)
+#define	SEQ_READ_START_VLD		BIT(4)
+
+/* NAND_EBI2_ECC_BUF_CFG bits */
+#define	NUM_STEPS			0
+
+/* NAND_ERASED_CW_DETECT_CFG bits */
+#define	ERASED_CW_ECC_MASK		1
+#define	AUTO_DETECT_RES			0
+#define	MASK_ECC			BIT(ERASED_CW_ECC_MASK)
+#define	RESET_ERASED_DET		BIT(AUTO_DETECT_RES)
+#define	ACTIVE_ERASED_DET		(0 << AUTO_DETECT_RES)
+#define	CLR_ERASED_PAGE_DET		(RESET_ERASED_DET | MASK_ECC)
+#define	SET_ERASED_PAGE_DET		(ACTIVE_ERASED_DET | MASK_ECC)
+
+/* NAND_ERASED_CW_DETECT_STATUS bits */
+#define	PAGE_ALL_ERASED			BIT(7)
+#define	CODEWORD_ALL_ERASED		BIT(6)
+#define	PAGE_ERASED			BIT(5)
+#define	CODEWORD_ERASED			BIT(4)
+#define	ERASED_PAGE			(PAGE_ALL_ERASED | PAGE_ERASED)
+#define	ERASED_CW			(CODEWORD_ALL_ERASED | CODEWORD_ERASED)
+
+/* NAND_READ_LOCATION_n bits */
+#define READ_LOCATION_OFFSET		0
+#define READ_LOCATION_SIZE		16
+#define READ_LOCATION_LAST		31
+
+/* Version Mask */
+#define	NAND_VERSION_MAJOR_MASK		0xf0000000
+#define	NAND_VERSION_MAJOR_SHIFT	28
+#define	NAND_VERSION_MINOR_MASK		0x0fff0000
+#define	NAND_VERSION_MINOR_SHIFT	16
+
+/* NAND OP_CMDs */
+#define	OP_PAGE_READ			0x2
+#define	OP_PAGE_READ_WITH_ECC		0x3
+#define	OP_PAGE_READ_WITH_ECC_SPARE	0x4
+#define	OP_PAGE_READ_ONFI_READ		0x5
+#define	OP_PROGRAM_PAGE			0x6
+#define	OP_PAGE_PROGRAM_WITH_ECC	0x7
+#define	OP_PROGRAM_PAGE_SPARE		0x9
+#define	OP_BLOCK_ERASE			0xa
+#define	OP_CHECK_STATUS			0xc
+#define	OP_FETCH_ID			0xb
+#define	OP_RESET_DEVICE			0xd
+
+/* Default Value for NAND_DEV_CMD_VLD */
+#define NAND_DEV_CMD_VLD_VAL		(READ_START_VLD | WRITE_START_VLD | \
+					 ERASE_START_VLD | SEQ_READ_START_VLD)
+
+/* NAND_CTRL bits */
+#define	BAM_MODE_EN			BIT(0)
+
+/*
+ * the NAND controller performs reads/writes with ECC in 516 byte chunks.
+ * the driver calls the chunks 'step' or 'codeword' interchangeably
+ */
+#define	NANDC_STEP_SIZE			512
+
+/*
+ * the largest page size we support is 8K, this will have 16 steps/codewords
+ * of 512 bytes each
+ */
+#define	MAX_NUM_STEPS			(SZ_8K / NANDC_STEP_SIZE)
+
+/* we read at most 3 registers per codeword scan */
+#define	MAX_REG_RD			(3 * MAX_NUM_STEPS)
+
+#define QPIC_PER_CW_CMD_ELEMENTS	32
+#define QPIC_PER_CW_CMD_SGL		32
+#define QPIC_PER_CW_DATA_SGL		8
+
+#define QPIC_NAND_COMPLETION_TIMEOUT	msecs_to_jiffies(2000)
+
+/*
+ * Flags used in DMA descriptor preparation helper functions
+ * (i.e. read_reg_dma/write_reg_dma/read_data_dma/write_data_dma)
+ */
+/* Don't set the EOT in current tx BAM sgl */
+#define NAND_BAM_NO_EOT			BIT(0)
+/* Set the NWD flag in current BAM sgl */
+#define NAND_BAM_NWD			BIT(1)
+/* Finish writing in the current BAM sgl and start writing in another BAM sgl */
+#define NAND_BAM_NEXT_SGL		BIT(2)
+
+/*
+ * Returns the actual register address for all NAND_DEV_ registers
+ * (i.e. NAND_DEV_CMD0, NAND_DEV_CMD1, NAND_DEV_CMD2 and NAND_DEV_CMD_VLD)
+ */
+#define dev_cmd_reg_addr(nandc, reg) ((nandc)->props->dev_cmd_reg_start + (reg))
+
+/* Returns the NAND register physical address */
+#define nandc_reg_phys(chip, offset) ((chip)->base_phys + (offset))
+
+/* Returns the dma address for reg read buffer */
+#define reg_buf_dma_addr(chip, vaddr) \
+	((chip)->reg_read_dma + \
+	((u8 *)(vaddr) - (u8 *)(chip)->reg_read_buf))
+
+/*
+ * Erased codeword status is being used two times in single transfer so this
+ * flag will determine the current value of erased codeword status register
+ */
+#define NAND_ERASED_CW_SET		BIT(4)
+
+#define MAX_ADDRESS_CYCLE		5
+
+/*
+ * This data type corresponds to the BAM transaction which will be used for all
+ * NAND transfers.
+ * @bam_ce - the array of BAM command elements
+ * @cmd_sgl - sgl for NAND BAM command pipe
+ * @data_sgl - sgl for NAND BAM consumer/producer pipe
+ * @last_data_desc - last DMA desc in data channel (tx/rx).
+ * @last_cmd_desc - last DMA desc in command channel.
+ * @txn_done - completion for NAND transfer.
+ * @bam_ce_pos - the index in bam_ce which is available for next sgl
+ * @bam_ce_start - the index in bam_ce which marks the start position ce
+ *		   for current sgl. It will be used for size calculation
+ *		   for current sgl
+ * @cmd_sgl_pos - current index in command sgl.
+ * @cmd_sgl_start - start index in command sgl.
+ * @tx_sgl_pos - current index in data sgl for tx.
+ * @tx_sgl_start - start index in data sgl for tx.
+ * @rx_sgl_pos - current index in data sgl for rx.
+ * @rx_sgl_start - start index in data sgl for rx.
+ * @wait_second_completion - wait for second DMA desc completion before making
+ *			     the NAND transfer completion.
+ */
+struct bam_transaction {
+	struct bam_cmd_element *bam_ce;
+	struct scatterlist *cmd_sgl;
+	struct scatterlist *data_sgl;
+	struct dma_async_tx_descriptor *last_data_desc;
+	struct dma_async_tx_descriptor *last_cmd_desc;
+	struct completion txn_done;
+	u32 bam_ce_pos;
+	u32 bam_ce_start;
+	u32 cmd_sgl_pos;
+	u32 cmd_sgl_start;
+	u32 tx_sgl_pos;
+	u32 tx_sgl_start;
+	u32 rx_sgl_pos;
+	u32 rx_sgl_start;
+	bool wait_second_completion;
+};
+
+/*
+ * This data type corresponds to the nand dma descriptor
+ * @dma_desc - low level DMA engine descriptor
+ * @list - list for desc_info
+ *
+ * @adm_sgl - sgl which will be used for single sgl dma descriptor. Only used by
+ *	      ADM
+ * @bam_sgl - sgl which will be used for dma descriptor. Only used by BAM
+ * @sgl_cnt - number of SGL in bam_sgl. Only used by BAM
+ * @dir - DMA transfer direction
+ */
+struct desc_info {
+	struct dma_async_tx_descriptor *dma_desc;
+	struct list_head node;
+
+	union {
+		struct scatterlist adm_sgl;
+		struct {
+			struct scatterlist *bam_sgl;
+			int sgl_cnt;
+		};
+	};
+	enum dma_data_direction dir;
+};
+
+/*
+ * holds the current register values that we want to write. acts as a contiguous
+ * chunk of memory which we use to write the controller registers through DMA.
+ */
+struct nandc_regs {
+	__le32 cmd;
+	__le32 addr0;
+	__le32 addr1;
+	__le32 chip_sel;
+	__le32 exec;
+
+	__le32 cfg0;
+	__le32 cfg1;
+	__le32 ecc_bch_cfg;
+
+	__le32 clrflashstatus;
+	__le32 clrreadstatus;
+
+	__le32 cmd1;
+	__le32 vld;
+
+	__le32 orig_cmd1;
+	__le32 orig_vld;
+
+	__le32 ecc_buf_cfg;
+	__le32 read_location0;
+	__le32 read_location1;
+	__le32 read_location2;
+	__le32 read_location3;
+	__le32 read_location_last0;
+	__le32 read_location_last1;
+	__le32 read_location_last2;
+	__le32 read_location_last3;
+
+	__le32 erased_cw_detect_cfg_clr;
+	__le32 erased_cw_detect_cfg_set;
+};
+
+/*
+ * NAND controller data struct
+ *
+ * @dev:			parent device
+ *
+ * @base:			MMIO base
+ *
+ * @core_clk:			controller clock
+ * @aon_clk:			another controller clock
+ *
+ * @regs:			a contiguous chunk of memory for DMA register
+ *				writes. contains the register values to be
+ *				written to controller
+ *
+ * @props:			properties of current NAND controller,
+ *				initialized via DT match data
+ *
+ * @controller:			base controller structure
+ * @host_list:			list containing all the chips attached to the
+ *				controller
+ *
+ * @chan:			dma channel
+ * @cmd_crci:			ADM DMA CRCI for command flow control
+ * @data_crci:			ADM DMA CRCI for data flow control
+ *
+ * @desc_list:			DMA descriptor list (list of desc_infos)
+ *
+ * @data_buffer:		our local DMA buffer for page read/writes,
+ *				used when we can't use the buffer provided
+ *				by upper layers directly
+ * @reg_read_buf:		local buffer for reading back registers via DMA
+ *
+ * @base_phys:			physical base address of controller registers
+ * @base_dma:			dma base address of controller registers
+ * @reg_read_dma:		contains dma address for register read buffer
+ *
+ * @buf_size/count/start:	markers for chip->legacy.read_buf/write_buf
+ *				functions
+ * @max_cwperpage:		maximum QPIC codewords required. calculated
+ *				from all connected NAND devices pagesize
+ *
+ * @reg_read_pos:		marker for data read in reg_read_buf
+ *
+ * @cmd1/vld:			some fixed controller register values
+ *
+ * @exec_opwrite:		flag to select correct number of code word
+ *				while reading status
+ */
+struct qcom_nand_controller {
+	struct device *dev;
+
+	void __iomem *base;
+
+	struct clk *core_clk;
+	struct clk *aon_clk;
+
+	struct nandc_regs *regs;
+	struct bam_transaction *bam_txn;
+
+	const struct qcom_nandc_props *props;
+
+	struct nand_controller controller;
+	struct list_head host_list;
+
+	union {
+		/* will be used only by QPIC for BAM DMA */
+		struct {
+			struct dma_chan *tx_chan;
+			struct dma_chan *rx_chan;
+			struct dma_chan *cmd_chan;
+		};
+
+		/* will be used only by EBI2 for ADM DMA */
+		struct {
+			struct dma_chan *chan;
+			unsigned int cmd_crci;
+			unsigned int data_crci;
+		};
+	};
+
+	struct list_head desc_list;
+
+	u8		*data_buffer;
+	__le32		*reg_read_buf;
+
+	phys_addr_t base_phys;
+	dma_addr_t base_dma;
+	dma_addr_t reg_read_dma;
+
+	int		buf_size;
+	int		buf_count;
+	int		buf_start;
+	unsigned int	max_cwperpage;
+
+	int reg_read_pos;
+
+	u32 cmd1, vld;
+	bool exec_opwrite;
+};
+
+/*
+ * This data type corresponds to the NAND controller properties which varies
+ * among different NAND controllers.
+ * @ecc_modes - ecc mode for NAND
+ * @dev_cmd_reg_start - NAND_DEV_CMD_* registers starting offset
+ * @is_bam - whether NAND controller is using BAM
+ * @is_qpic - whether NAND CTRL is part of qpic IP
+ * @qpic_v2 - flag to indicate QPIC IP version 2
+ * @use_codeword_fixup - whether NAND has different layout for boot partitions
+ */
+struct qcom_nandc_props {
+	u32 ecc_modes;
+	u32 dev_cmd_reg_start;
+	bool is_bam;
+	bool is_qpic;
+	bool qpic_v2;
+	bool use_codeword_fixup;
+};
+
+void config_nand_page_read(struct nand_chip *chip);
+void qcom_qpic_bam_dma_done(void *data);
+void qcom_nandc_read_buffer_sync(struct qcom_nand_controller *nandc, bool is_cpu);
+__le32 *qcom_offset_to_nandc_reg(struct nandc_regs *regs, int offset);
+int qcom_prep_adm_dma_desc(struct qcom_nand_controller *nandc, bool read,
+			   int reg_off, const void *vaddr, int size,
+			bool flow_control);
+int qcom_submit_descs(struct qcom_nand_controller *nandc);
+int qcom_prepare_bam_async_desc(struct qcom_nand_controller *nandc,
+				struct dma_chan *chan, unsigned long flags);
+int qcom_prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
+			       int reg_off, const void *vaddr,
+			int size, unsigned int flags);
+int qcom_prep_bam_dma_desc_data(struct qcom_nand_controller *nandc, bool read,
+				const void *vaddr,
+			int size, unsigned int flags);
+int qcom_read_reg_dma(struct qcom_nand_controller *nandc, int first,
+		      int num_regs, unsigned int flags);
+int qcom_write_reg_dma(struct qcom_nand_controller *nandc, int first,
+		       int num_regs, unsigned int flags);
+int qcom_read_data_dma(struct qcom_nand_controller *nandc, int reg_off,
+		       const u8 *vaddr, int size, unsigned int flags);
+int qcom_write_data_dma(struct qcom_nand_controller *nandc, int reg_off,
+			const u8 *vaddr, int size, unsigned int flags);
+struct bam_transaction *qcom_alloc_bam_transaction(struct qcom_nand_controller *nandc);
+void qcom_clear_bam_transaction(struct qcom_nand_controller *nandc);
+void qcom_nandc_unalloc(struct qcom_nand_controller *nandc);
+int qcom_nandc_alloc(struct qcom_nand_controller *nandc);
+void qcom_clear_read_regs(struct qcom_nand_controller *nandc);
+void qcom_free_bam_transaction(struct qcom_nand_controller *nandc);
+#endif
-- 
2.34.1


