Return-Path: <linux-kernel+bounces-67021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAA78564EB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3014B1C20BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB490131750;
	Thu, 15 Feb 2024 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dFVl807f"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA77131751;
	Thu, 15 Feb 2024 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004979; cv=none; b=eJyrn9Am54ToNKHd2awUXzA1xL2IzgW5Kx7MTF+5l2wxzOxppNkr2mmHJu4SrNl1M7ytMY+L3k+B6GY1kEnXnzAA3JxRq/KQrYlh/iR7sY9rXo//FWQFOl4ztrOX/VsotGDvp11K4F/08BauSTfDhIvbK//bjZwI2gy94TILsNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004979; c=relaxed/simple;
	bh=KDWb68joCLyT3dAE+Fei1dzoVoXPuJvcLvyYbENc0/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hy0deFDjaut2XezaKvon5vePbRmhQ2nZ6g+wJZllSLJEsFKMDFVTkMUwmWKRloFl4D+2d0WyUVG8nNqGvC/4EQ0t0aIUPFGhlfDp5+J0xHbVT+WIZ1yHxUro/o+Lx5iv1FROS9RIS+oGQ+olTrSar0xEg6X5x50mIX56uTYB9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dFVl807f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41F68gEt026197;
	Thu, 15 Feb 2024 13:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=Dtmgmau
	LKygN+HrWTsWU2/j9SDz8nWvhI4tQZlDnlBM=; b=dFVl807fL224JHTPmyOMrAe
	MPvucPn+R/nU3ONx2dVFEUCuWRfsK4WexaWc9ZPzLIGiDNOIdCibhjf+rfu9UAgZ
	efsHbdFSCJWJ2j6l9z3AlQD7y8WO/mCxRvpnqO+2x3RDfpqSkXKceCoeO1qBpE7T
	MQwzTZZrCi/Izq8NtytKnGDDODdoXatT7oYkeyWco/v8PlwXEtrbSSiRclmhLNmo
	SEv6UYZksGS4ipnzsAbDO619jy07vN76ZOZqmvQaWROEoPDM2biYHJaYGi2//vmN
	nx3cp7s15SRLMiIhY9Hm/t2lSrfTaI9K/F1WrGzoAfgYkwnPzGN/dp28avhNSZw=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w974j1hyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 13:49:12 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41FDmhAN009617;
	Thu, 15 Feb 2024 13:49:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3w627mb92c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 13:49:08 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FDn8pH009932;
	Thu, 15 Feb 2024 13:49:08 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 41FDn82I009923
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 13:49:08 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id 653C641385; Thu, 15 Feb 2024 19:19:07 +0530 (+0530)
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org, broonie@kernel.org,
        robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, manivannan.sadhasivam@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com,
        quic_mdalam@quicinc.com
Subject: [PATCH 2/5] drivers: mtd: nand: Add qpic_common API file
Date: Thu, 15 Feb 2024 19:18:53 +0530
Message-Id: <20240215134856.1313239-3-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: GVvtTGvRCqVxJkymvFNssdKmFQtqdndt
X-Proofpoint-ORIG-GUID: GVvtTGvRCqVxJkymvFNssdKmFQtqdndt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_12,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150111

Add qpic_common.c file which hold all the common
qpic APIs which will be used by both qpic raw nand
driver and qpic spi nand driver.

Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 drivers/mtd/nand/Makefile            |    1 +
 drivers/mtd/nand/qpic_common.c       |  786 +++++++++++++++++
 drivers/mtd/nand/raw/qcom_nandc.c    | 1226 +-------------------------
 include/linux/mtd/nand-qpic-common.h |  488 ++++++++++
 4 files changed, 1291 insertions(+), 1210 deletions(-)
 create mode 100644 drivers/mtd/nand/qpic_common.c
 create mode 100644 include/linux/mtd/nand-qpic-common.h

diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 19e1291ac4d5..131707a41293 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -12,3 +12,4 @@ nandcore-$(CONFIG_MTD_NAND_ECC) += ecc.o
 nandcore-$(CONFIG_MTD_NAND_ECC_SW_HAMMING) += ecc-sw-hamming.o
 nandcore-$(CONFIG_MTD_NAND_ECC_SW_BCH) += ecc-sw-bch.o
 nandcore-$(CONFIG_MTD_NAND_ECC_MXIC) += ecc-mxic.o
+obj-y += qpic_common.o
diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_common.c
new file mode 100644
index 000000000000..4d74ba888028
--- /dev/null
+++ b/drivers/mtd/nand/qpic_common.c
@@ -0,0 +1,786 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * QPIC Controller common API file.
+ * Copyright (C) 2023  Qualcomm Inc.
+ * Authors:	Md sadre Alam           <quic_mdalam@quicinc.com>
+ *		Sricharan R             <quic_srichara@quicinc.com>
+ *		Varadarajan Narayanan	<quic_varada@quicinc.com>
+ *
+ */
+
+#include <linux/mtd/nand-qpic-common.h>
+
+struct qcom_nand_controller *
+get_qcom_nand_controller(struct nand_chip *chip)
+{
+	return container_of(chip->controller, struct qcom_nand_controller,
+			    controller);
+}
+EXPORT_SYMBOL(get_qcom_nand_controller);
+
+/*
+ * Helper to prepare DMA descriptors for configuring registers
+ * before reading a NAND page.
+ */
+void config_nand_page_read(struct nand_chip *chip)
+{
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+
+	write_reg_dma(nandc, NAND_ADDR0, 2, 0);
+	write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
+	if (!nandc->props->qpic_v2)
+		write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1, 0);
+	write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1, 0);
+	write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1,
+		      NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
+}
+EXPORT_SYMBOL(config_nand_page_read);
+
+/* Frees the BAM transaction memory */
+void free_bam_transaction(struct qcom_nand_controller *nandc)
+{
+	struct bam_transaction *bam_txn = nandc->bam_txn;
+
+	devm_kfree(nandc->dev, bam_txn);
+}
+EXPORT_SYMBOL(free_bam_transaction);
+
+/* Callback for DMA descriptor completion */
+void qpic_bam_dma_done(void *data)
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
+EXPORT_SYMBOL(qpic_bam_dma_done);
+
+void nandc_read_buffer_sync(struct qcom_nand_controller *nandc,
+			    bool is_cpu)
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
+EXPORT_SYMBOL(nandc_read_buffer_sync);
+
+__le32 *offset_to_nandc_reg(struct nandc_regs *regs, int offset)
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
+EXPORT_SYMBOL(offset_to_nandc_reg);
+
+/* reset the register read buffer for next NAND operation */
+void clear_read_regs(struct qcom_nand_controller *nandc)
+{
+	nandc->reg_read_pos = 0;
+	nandc_read_buffer_sync(nandc, false);
+}
+EXPORT_SYMBOL(clear_read_regs);
+
+int prep_adm_dma_desc(struct qcom_nand_controller *nandc, bool read,
+		      int reg_off, const void *vaddr, int size,
+			     bool flow_control)
+{
+	struct desc_info *desc;
+	struct dma_async_tx_descriptor *dma_desc;
+	struct scatterlist *sgl;
+	struct dma_slave_config slave_conf;
+	struct qcom_adm_peripheral_config periph_conf = {};
+	enum dma_transfer_direction dir_eng;
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
+	if (ret == 0) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	memset(&slave_conf, 0x00, sizeof(slave_conf));
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
+EXPORT_SYMBOL(prep_adm_dma_desc);
+
+/* helpers to submit/free our list of dma descriptors */
+int submit_descs(struct qcom_nand_controller *nandc)
+{
+	struct desc_info *desc, *n;
+	dma_cookie_t cookie = 0;
+	struct bam_transaction *bam_txn = nandc->bam_txn;
+	int ret = 0;
+
+	if (nandc->props->is_bam) {
+		if (bam_txn->rx_sgl_pos > bam_txn->rx_sgl_start) {
+			ret = prepare_bam_async_desc(nandc, nandc->rx_chan, 0);
+			if (ret)
+				goto err_unmap_free_desc;
+		}
+
+		if (bam_txn->tx_sgl_pos > bam_txn->tx_sgl_start) {
+			ret = prepare_bam_async_desc(nandc, nandc->tx_chan,
+						     DMA_PREP_INTERRUPT);
+			if (ret)
+				goto err_unmap_free_desc;
+		}
+
+		if (bam_txn->cmd_sgl_pos > bam_txn->cmd_sgl_start) {
+			ret = prepare_bam_async_desc(nandc, nandc->cmd_chan,
+						     DMA_PREP_CMD);
+			if (ret)
+				goto err_unmap_free_desc;
+		}
+	}
+
+	list_for_each_entry(desc, &nandc->desc_list, node)
+		cookie = dmaengine_submit(desc->dma_desc);
+
+	if (nandc->props->is_bam) {
+		bam_txn->last_cmd_desc->callback = qpic_bam_dma_done;
+		bam_txn->last_cmd_desc->callback_param = bam_txn;
+		if (bam_txn->last_data_desc) {
+			bam_txn->last_data_desc->callback = qpic_bam_dma_done;
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
+EXPORT_SYMBOL(submit_descs);
+
+/*
+ * Maps the scatter gather list for DMA transfer and forms the DMA descriptor
+ * for BAM. This descriptor will be added in the NAND DMA descriptor queue
+ * which will be submitted to DMA engine.
+ */
+int prepare_bam_async_desc(struct qcom_nand_controller *nandc,
+			   struct dma_chan *chan,
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
+EXPORT_SYMBOL(prepare_bam_async_desc);
+
+/*
+ * Prepares the command descriptor for BAM DMA which will be used for NAND
+ * register reads and writes. The command descriptor requires the command
+ * to be formed in command element type so this function uses the command
+ * element from bam transaction ce array and fills the same with required
+ * data. A single SGL can contain multiple command elements so
+ * NAND_BAM_NEXT_SGL will be used for starting the separate SGL
+ * after the current command element.
+ */
+int prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
+			  int reg_off, const void *vaddr,
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
+			ret = prepare_bam_async_desc(nandc, nandc->cmd_chan,
+						     DMA_PREP_FENCE |
+						     DMA_PREP_CMD);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(prep_bam_dma_desc_cmd);
+
+/*
+ * Prepares the data descriptor for BAM DMA which will be used for NAND
+ * data reads and writes.
+ */
+int prep_bam_dma_desc_data(struct qcom_nand_controller *nandc, bool read,
+			   const void *vaddr,
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
+			ret = prepare_bam_async_desc(nandc, nandc->tx_chan,
+						     DMA_PREP_INTERRUPT);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(prep_bam_dma_desc_data);
+
+/*
+ * read_reg_dma:	prepares a descriptor to read a given number of
+ *			contiguous registers to the reg_read_buf pointer
+ *
+ * @first:		offset of the first register in the contiguous block
+ * @num_regs:		number of registers to read
+ * @flags:		flags to control DMA descriptor preparation
+ */
+int read_reg_dma(struct qcom_nand_controller *nandc, int first,
+		 int num_regs, unsigned int flags)
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
+		return prep_bam_dma_desc_cmd(nandc, true, first, vaddr,
+					     num_regs, flags);
+
+	if (first == NAND_READ_ID || first == NAND_FLASH_STATUS)
+		flow_control = true;
+
+	return prep_adm_dma_desc(nandc, true, first, vaddr,
+				 num_regs * sizeof(u32), flow_control);
+}
+EXPORT_SYMBOL(read_reg_dma);
+
+/*
+ * write_reg_dma:	prepares a descriptor to write a given number of
+ *			contiguous registers
+ *
+ * @first:		offset of the first register in the contiguous block
+ * @num_regs:		number of registers to write
+ * @flags:		flags to control DMA descriptor preparation
+ */
+int write_reg_dma(struct qcom_nand_controller *nandc, int first,
+		  int num_regs, unsigned int flags)
+{
+	bool flow_control = false;
+	struct nandc_regs *regs = nandc->regs;
+	void *vaddr;
+
+	vaddr = offset_to_nandc_reg(regs, first);
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
+		return prep_bam_dma_desc_cmd(nandc, false, first, vaddr,
+					     num_regs, flags);
+
+	if (first == NAND_FLASH_CMD)
+		flow_control = true;
+
+	return prep_adm_dma_desc(nandc, false, first, vaddr,
+				 num_regs * sizeof(u32), flow_control);
+}
+EXPORT_SYMBOL(write_reg_dma);
+
+/*
+ * read_data_dma:	prepares a DMA descriptor to transfer data from the
+ *			controller's internal buffer to the buffer 'vaddr'
+ *
+ * @reg_off:		offset within the controller's data buffer
+ * @vaddr:		virtual address of the buffer we want to write to
+ * @size:		DMA transaction size in bytes
+ * @flags:		flags to control DMA descriptor preparation
+ */
+int read_data_dma(struct qcom_nand_controller *nandc, int reg_off,
+		  const u8 *vaddr, int size, unsigned int flags)
+{
+	if (nandc->props->is_bam)
+		return prep_bam_dma_desc_data(nandc, true, vaddr, size, flags);
+
+	return prep_adm_dma_desc(nandc, true, reg_off, vaddr, size, false);
+}
+EXPORT_SYMBOL(read_data_dma);
+
+/*
+ * write_data_dma:	prepares a DMA descriptor to transfer data from
+ *			'vaddr' to the controller's internal buffer
+ *
+ * @reg_off:		offset within the controller's data buffer
+ * @vaddr:		virtual address of the buffer we want to read from
+ * @size:		DMA transaction size in bytes
+ * @flags:		flags to control DMA descriptor preparation
+ */
+int write_data_dma(struct qcom_nand_controller *nandc, int reg_off,
+		   const u8 *vaddr, int size, unsigned int flags)
+{
+	if (nandc->props->is_bam)
+		return prep_bam_dma_desc_data(nandc, false, vaddr, size, flags);
+
+	return prep_adm_dma_desc(nandc, false, reg_off, vaddr, size, false);
+}
+EXPORT_SYMBOL(write_data_dma);
+
+/* Allocates and Initializes the BAM transaction */
+struct bam_transaction *
+alloc_bam_transaction(struct qcom_nand_controller *nandc)
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
+	bam_txn_buf = devm_kzalloc(nandc->dev, bam_txn_size, GFP_KERNEL);
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
+EXPORT_SYMBOL(alloc_bam_transaction);
+
+/* Clears the BAM transaction indexes */
+void clear_bam_transaction(struct qcom_nand_controller *nandc)
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
+EXPORT_SYMBOL(clear_bam_transaction);
+
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
+EXPORT_SYMBOL(qcom_nandc_unalloc);
+
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
+		nandc->bam_txn = alloc_bam_transaction(nandc);
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
+EXPORT_SYMBOL(qcom_nandc_alloc);
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index b079605c84d3..75c6ca698c85 100644
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
@@ -544,113 +124,17 @@ struct qcom_nand_host {
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
-{
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
-}
-
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
+	reg = offset_to_nandc_reg(regs, offset);
 
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
@@ -658,13 +142,6 @@ static inline struct qcom_nand_host *to_qcom_nand_host(struct nand_chip *chip)
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
@@ -676,91 +153,6 @@ static inline void nandc_write(struct qcom_nand_controller *nandc, int offset,
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
@@ -852,383 +244,6 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read, i
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
@@ -1303,88 +318,6 @@ static void config_nand_cw_write(struct nand_chip *chip)
 	write_reg_dma(nandc, NAND_READ_STATUS, 1, NAND_BAM_NEXT_SGL);
 }
 
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
-}
-
 /*
  * when using BCH ECC, the HW flags an error in NAND_FLASH_STATUS if it read
  * an erased CW, and reports an erased CW in NAND_ERASED_CW_DETECT_STATUS.
@@ -3016,136 +1949,6 @@ static const struct nand_controller_ops qcom_nandc_ops = {
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
@@ -3427,6 +2230,9 @@ static int qcom_nandc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_nandc_alloc;
 
+	nand_controller_init(&nandc->controller);
+	nandc->controller.ops = &qcom_nandc_ops;
+
 	ret = qcom_nandc_setup(nandc);
 	if (ret)
 		goto err_setup;
@@ -3473,28 +2279,28 @@ static void qcom_nandc_remove(struct platform_device *pdev)
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
index 000000000000..891f975ca173
--- /dev/null
+++ b/include/linux/mtd/nand-qpic-common.h
@@ -0,0 +1,488 @@
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
+void free_bam_transaction(struct qcom_nand_controller *nandc);
+void qpic_bam_dma_done(void *data);
+void nandc_read_buffer_sync(struct qcom_nand_controller *nandc, bool is_cpu);
+__le32 *offset_to_nandc_reg(struct nandc_regs *regs, int offset);
+void clear_read_regs(struct qcom_nand_controller *nandc);
+int prep_adm_dma_desc(struct qcom_nand_controller *nandc, bool read,
+		      int reg_off, const void *vaddr, int size,
+			bool flow_control);
+int submit_descs(struct qcom_nand_controller *nandc);
+int prepare_bam_async_desc(struct qcom_nand_controller *nandc,
+			   struct dma_chan *chan, unsigned long flags);
+int prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
+			  int reg_off, const void *vaddr,
+			int size, unsigned int flags);
+int prep_bam_dma_desc_data(struct qcom_nand_controller *nandc, bool read,
+			   const void *vaddr,
+			int size, unsigned int flags);
+int read_reg_dma(struct qcom_nand_controller *nandc, int first,
+		 int num_regs, unsigned int flags);
+int write_reg_dma(struct qcom_nand_controller *nandc, int first,
+		  int num_regs, unsigned int flags);
+int read_data_dma(struct qcom_nand_controller *nandc, int reg_off,
+		  const u8 *vaddr, int size, unsigned int flags);
+int write_data_dma(struct qcom_nand_controller *nandc, int reg_off,
+		   const u8 *vaddr, int size, unsigned int flags);
+struct bam_transaction *alloc_bam_transaction(struct qcom_nand_controller *nandc);
+void clear_bam_transaction(struct qcom_nand_controller *nandc);
+void qcom_nandc_unalloc(struct qcom_nand_controller *nandc);
+int qcom_nandc_alloc(struct qcom_nand_controller *nandc);
+struct qcom_nand_controller *get_qcom_nand_controller(struct nand_chip *chip);
+
+#endif
-- 
2.34.1


