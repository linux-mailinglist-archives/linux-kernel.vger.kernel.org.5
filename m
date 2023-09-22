Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEAB7AB994
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjIVSsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjIVSsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:48:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCA2A9;
        Fri, 22 Sep 2023 11:48:38 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MHFfUJ015757;
        Fri, 22 Sep 2023 18:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=X8CGpdwa3ppqNfgHitlkDMyPXoxhuDu4kS1S3lTsdGI=;
 b=IqOjUkpuPwtIRz0Bh7p/Kjx6xOiWtkHoVtNXaH62A8RBGf/4adSWAkQ3CpDbHdPMZ2Ws
 UkeTqqUNk7f02h8D4PEf4JgRwXD6XnUiQVqAgBv6NYRbaYTNRaZ7Rbbj44JE3hWSEEZb
 HgW50Srul+mSk/5LyRI8mbUa9MlT1Y0R4a9GJ+KilCkM9peUfU/rccu0vyVuCMJ8QECN
 UHZ6pmptb8CptBGcEJwDO0yTvATOhS5OJfd4aHWYthnaKON3uJbbG8HrSS07X3jpAtMn
 q/A77t8FUOYX4JJoOPzhZwhZTTcVRUqqJ7YYr2t1hQ9H8gxWNGovul+Y6YhYsZBtiU9t cg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8u6rts02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 18:48:33 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38MImWdU004592
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 18:48:32 GMT
Received: from hu-uchalich-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 22 Sep 2023 11:48:30 -0700
From:   Unnathi Chalicheemala <quic_uchalich@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
Subject: [PATCH] soc: qcom: Switch to EXPORT_SYMBOL_GPL()
Date:   Fri, 22 Sep 2023 11:48:17 -0700
Message-ID: <20230922184817.5183-1-quic_uchalich@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BHX52AUX16ZowBbtvQfwBerY6FDQAOEC
X-Proofpoint-ORIG-GUID: BHX52AUX16ZowBbtvQfwBerY6FDQAOEC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_16,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309220162
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to GPL version of EXPORT_SYMBOL for Qualcomm SoC drivers.

Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
---
 drivers/soc/qcom/cmd-db.c            |  8 +++---
 drivers/soc/qcom/kryo-l2-accessors.c |  4 +--
 drivers/soc/qcom/ocmem.c             |  6 ++---
 drivers/soc/qcom/pdr_interface.c     |  8 +++---
 drivers/soc/qcom/qcom-geni-se.c      | 38 ++++++++++++++--------------
 drivers/soc/qcom/qcom_aoss.c         |  6 ++---
 drivers/soc/qcom/qmi_encdec.c        |  6 ++---
 drivers/soc/qcom/qmi_interface.c     | 20 +++++++--------
 drivers/soc/qcom/rpmh.c              |  8 +++---
 drivers/soc/qcom/smd-rpm.c           |  2 +-
 drivers/soc/qcom/smem.c              |  2 +-
 drivers/soc/qcom/wcnss_ctrl.c        |  2 +-
 12 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index 34c40368d5b5..a5fd68411bed 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -133,7 +133,7 @@ int cmd_db_ready(void)
 
 	return 0;
 }
-EXPORT_SYMBOL(cmd_db_ready);
+EXPORT_SYMBOL_GPL(cmd_db_ready);
 
 static int cmd_db_get_header(const char *id, const struct entry_header **eh,
 			     const struct rsc_hdr **rh)
@@ -193,7 +193,7 @@ u32 cmd_db_read_addr(const char *id)
 
 	return ret < 0 ? 0 : le32_to_cpu(ent->addr);
 }
-EXPORT_SYMBOL(cmd_db_read_addr);
+EXPORT_SYMBOL_GPL(cmd_db_read_addr);
 
 /**
  * cmd_db_read_aux_data() - Query command db for aux data.
@@ -218,7 +218,7 @@ const void *cmd_db_read_aux_data(const char *id, size_t *len)
 
 	return rsc_offset(rsc_hdr, ent);
 }
-EXPORT_SYMBOL(cmd_db_read_aux_data);
+EXPORT_SYMBOL_GPL(cmd_db_read_aux_data);
 
 /**
  * cmd_db_read_slave_id - Get the slave ID for a given resource address
@@ -240,7 +240,7 @@ enum cmd_db_hw_type cmd_db_read_slave_id(const char *id)
 	addr = le32_to_cpu(ent->addr);
 	return (addr >> SLAVE_ID_SHIFT) & SLAVE_ID_MASK;
 }
-EXPORT_SYMBOL(cmd_db_read_slave_id);
+EXPORT_SYMBOL_GPL(cmd_db_read_slave_id);
 
 #ifdef CONFIG_DEBUG_FS
 static int cmd_db_debugfs_dump(struct seq_file *seq, void *p)
diff --git a/drivers/soc/qcom/kryo-l2-accessors.c b/drivers/soc/qcom/kryo-l2-accessors.c
index 7886af4fd726..50cd710c5e82 100644
--- a/drivers/soc/qcom/kryo-l2-accessors.c
+++ b/drivers/soc/qcom/kryo-l2-accessors.c
@@ -32,7 +32,7 @@ void kryo_l2_set_indirect_reg(u64 reg, u64 val)
 	isb();
 	raw_spin_unlock_irqrestore(&l2_access_lock, flags);
 }
-EXPORT_SYMBOL(kryo_l2_set_indirect_reg);
+EXPORT_SYMBOL_GPL(kryo_l2_set_indirect_reg);
 
 /**
  * kryo_l2_get_indirect_reg() - read an L2 register value
@@ -54,4 +54,4 @@ u64 kryo_l2_get_indirect_reg(u64 reg)
 
 	return val;
 }
-EXPORT_SYMBOL(kryo_l2_get_indirect_reg);
+EXPORT_SYMBOL_GPL(kryo_l2_get_indirect_reg);
diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
index 20f5461d46b9..3cf8ab892a70 100644
--- a/drivers/soc/qcom/ocmem.c
+++ b/drivers/soc/qcom/ocmem.c
@@ -211,7 +211,7 @@ struct ocmem *of_get_ocmem(struct device *dev)
 	}
 	return ocmem;
 }
-EXPORT_SYMBOL(of_get_ocmem);
+EXPORT_SYMBOL_GPL(of_get_ocmem);
 
 struct ocmem_buf *ocmem_allocate(struct ocmem *ocmem, enum ocmem_client client,
 				 unsigned long size)
@@ -267,7 +267,7 @@ struct ocmem_buf *ocmem_allocate(struct ocmem *ocmem, enum ocmem_client client,
 
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL(ocmem_allocate);
+EXPORT_SYMBOL_GPL(ocmem_allocate);
 
 void ocmem_free(struct ocmem *ocmem, enum ocmem_client client,
 		struct ocmem_buf *buf)
@@ -294,7 +294,7 @@ void ocmem_free(struct ocmem *ocmem, enum ocmem_client client,
 
 	clear_bit_unlock(BIT(client), &ocmem->active_allocations);
 }
-EXPORT_SYMBOL(ocmem_free);
+EXPORT_SYMBOL_GPL(ocmem_free);
 
 static int ocmem_dev_probe(struct platform_device *pdev)
 {
diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
index 0034af927b48..a1b6a4081dea 100644
--- a/drivers/soc/qcom/pdr_interface.c
+++ b/drivers/soc/qcom/pdr_interface.c
@@ -554,7 +554,7 @@ struct pdr_service *pdr_add_lookup(struct pdr_handle *pdr,
 	kfree(pds);
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL(pdr_add_lookup);
+EXPORT_SYMBOL_GPL(pdr_add_lookup);
 
 /**
  * pdr_restart_pd() - restart PD
@@ -634,7 +634,7 @@ int pdr_restart_pd(struct pdr_handle *pdr, struct pdr_service *pds)
 
 	return 0;
 }
-EXPORT_SYMBOL(pdr_restart_pd);
+EXPORT_SYMBOL_GPL(pdr_restart_pd);
 
 /**
  * pdr_handle_alloc() - initialize the PDR client handle
@@ -715,7 +715,7 @@ struct pdr_handle *pdr_handle_alloc(void (*status)(int state,
 
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL(pdr_handle_alloc);
+EXPORT_SYMBOL_GPL(pdr_handle_alloc);
 
 /**
  * pdr_handle_release() - release the PDR client handle
@@ -749,7 +749,7 @@ void pdr_handle_release(struct pdr_handle *pdr)
 
 	kfree(pdr);
 }
-EXPORT_SYMBOL(pdr_handle_release);
+EXPORT_SYMBOL_GPL(pdr_handle_release);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Qualcomm Protection Domain Restart helpers");
diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index ba788762835f..bdcf44b85b2f 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -199,7 +199,7 @@ u32 geni_se_get_qup_hw_version(struct geni_se *se)
 
 	return readl_relaxed(wrapper->base + QUP_HW_VER_REG);
 }
-EXPORT_SYMBOL(geni_se_get_qup_hw_version);
+EXPORT_SYMBOL_GPL(geni_se_get_qup_hw_version);
 
 static void geni_se_io_set_mode(void __iomem *base)
 {
@@ -272,7 +272,7 @@ void geni_se_init(struct geni_se *se, u32 rx_wm, u32 rx_rfr)
 	val |= S_COMMON_GENI_S_IRQ_EN;
 	writel_relaxed(val, se->base + SE_GENI_S_IRQ_EN);
 }
-EXPORT_SYMBOL(geni_se_init);
+EXPORT_SYMBOL_GPL(geni_se_init);
 
 static void geni_se_select_fifo_mode(struct geni_se *se)
 {
@@ -364,7 +364,7 @@ void geni_se_select_mode(struct geni_se *se, enum geni_se_xfer_mode mode)
 		break;
 	}
 }
-EXPORT_SYMBOL(geni_se_select_mode);
+EXPORT_SYMBOL_GPL(geni_se_select_mode);
 
 /**
  * DOC: Overview
@@ -481,7 +481,7 @@ void geni_se_config_packing(struct geni_se *se, int bpw, int pack_words,
 	if (pack_words || bpw == 32)
 		writel_relaxed(bpw / 16, se->base + SE_GENI_BYTE_GRAN);
 }
-EXPORT_SYMBOL(geni_se_config_packing);
+EXPORT_SYMBOL_GPL(geni_se_config_packing);
 
 static void geni_se_clks_off(struct geni_se *se)
 {
@@ -512,7 +512,7 @@ int geni_se_resources_off(struct geni_se *se)
 	geni_se_clks_off(se);
 	return 0;
 }
-EXPORT_SYMBOL(geni_se_resources_off);
+EXPORT_SYMBOL_GPL(geni_se_resources_off);
 
 static int geni_se_clks_on(struct geni_se *se)
 {
@@ -553,7 +553,7 @@ int geni_se_resources_on(struct geni_se *se)
 
 	return ret;
 }
-EXPORT_SYMBOL(geni_se_resources_on);
+EXPORT_SYMBOL_GPL(geni_se_resources_on);
 
 /**
  * geni_se_clk_tbl_get() - Get the clock table to program DFS
@@ -594,7 +594,7 @@ int geni_se_clk_tbl_get(struct geni_se *se, unsigned long **tbl)
 	*tbl = se->clk_perf_tbl;
 	return se->num_clk_levels;
 }
-EXPORT_SYMBOL(geni_se_clk_tbl_get);
+EXPORT_SYMBOL_GPL(geni_se_clk_tbl_get);
 
 /**
  * geni_se_clk_freq_match() - Get the matching or closest SE clock frequency
@@ -656,7 +656,7 @@ int geni_se_clk_freq_match(struct geni_se *se, unsigned long req_freq,
 
 	return 0;
 }
-EXPORT_SYMBOL(geni_se_clk_freq_match);
+EXPORT_SYMBOL_GPL(geni_se_clk_freq_match);
 
 #define GENI_SE_DMA_DONE_EN BIT(0)
 #define GENI_SE_DMA_EOT_EN BIT(1)
@@ -684,7 +684,7 @@ void geni_se_tx_init_dma(struct geni_se *se, dma_addr_t iova, size_t len)
 	writel_relaxed(GENI_SE_DMA_EOT_BUF, se->base + SE_DMA_TX_ATTR);
 	writel(len, se->base + SE_DMA_TX_LEN);
 }
-EXPORT_SYMBOL(geni_se_tx_init_dma);
+EXPORT_SYMBOL_GPL(geni_se_tx_init_dma);
 
 /**
  * geni_se_tx_dma_prep() - Prepare the serial engine for TX DMA transfer
@@ -712,7 +712,7 @@ int geni_se_tx_dma_prep(struct geni_se *se, void *buf, size_t len,
 	geni_se_tx_init_dma(se, *iova, len);
 	return 0;
 }
-EXPORT_SYMBOL(geni_se_tx_dma_prep);
+EXPORT_SYMBOL_GPL(geni_se_tx_dma_prep);
 
 /**
  * geni_se_rx_init_dma() - Initiate RX DMA transfer on the serial engine
@@ -736,7 +736,7 @@ void geni_se_rx_init_dma(struct geni_se *se, dma_addr_t iova, size_t len)
 	writel_relaxed(0, se->base + SE_DMA_RX_ATTR);
 	writel(len, se->base + SE_DMA_RX_LEN);
 }
-EXPORT_SYMBOL(geni_se_rx_init_dma);
+EXPORT_SYMBOL_GPL(geni_se_rx_init_dma);
 
 /**
  * geni_se_rx_dma_prep() - Prepare the serial engine for RX DMA transfer
@@ -764,7 +764,7 @@ int geni_se_rx_dma_prep(struct geni_se *se, void *buf, size_t len,
 	geni_se_rx_init_dma(se, *iova, len);
 	return 0;
 }
-EXPORT_SYMBOL(geni_se_rx_dma_prep);
+EXPORT_SYMBOL_GPL(geni_se_rx_dma_prep);
 
 /**
  * geni_se_tx_dma_unprep() - Unprepare the serial engine after TX DMA transfer
@@ -781,7 +781,7 @@ void geni_se_tx_dma_unprep(struct geni_se *se, dma_addr_t iova, size_t len)
 	if (!dma_mapping_error(wrapper->dev, iova))
 		dma_unmap_single(wrapper->dev, iova, len, DMA_TO_DEVICE);
 }
-EXPORT_SYMBOL(geni_se_tx_dma_unprep);
+EXPORT_SYMBOL_GPL(geni_se_tx_dma_unprep);
 
 /**
  * geni_se_rx_dma_unprep() - Unprepare the serial engine after RX DMA transfer
@@ -798,7 +798,7 @@ void geni_se_rx_dma_unprep(struct geni_se *se, dma_addr_t iova, size_t len)
 	if (!dma_mapping_error(wrapper->dev, iova))
 		dma_unmap_single(wrapper->dev, iova, len, DMA_FROM_DEVICE);
 }
-EXPORT_SYMBOL(geni_se_rx_dma_unprep);
+EXPORT_SYMBOL_GPL(geni_se_rx_dma_unprep);
 
 int geni_icc_get(struct geni_se *se, const char *icc_ddr)
 {
@@ -827,7 +827,7 @@ int geni_icc_get(struct geni_se *se, const char *icc_ddr)
 	return err;
 
 }
-EXPORT_SYMBOL(geni_icc_get);
+EXPORT_SYMBOL_GPL(geni_icc_get);
 
 int geni_icc_set_bw(struct geni_se *se)
 {
@@ -845,7 +845,7 @@ int geni_icc_set_bw(struct geni_se *se)
 
 	return 0;
 }
-EXPORT_SYMBOL(geni_icc_set_bw);
+EXPORT_SYMBOL_GPL(geni_icc_set_bw);
 
 void geni_icc_set_tag(struct geni_se *se, u32 tag)
 {
@@ -854,7 +854,7 @@ void geni_icc_set_tag(struct geni_se *se, u32 tag)
 	for (i = 0; i < ARRAY_SIZE(se->icc_paths); i++)
 		icc_set_tag(se->icc_paths[i].path, tag);
 }
-EXPORT_SYMBOL(geni_icc_set_tag);
+EXPORT_SYMBOL_GPL(geni_icc_set_tag);
 
 /* To do: Replace this by icc_bulk_enable once it's implemented in ICC core */
 int geni_icc_enable(struct geni_se *se)
@@ -872,7 +872,7 @@ int geni_icc_enable(struct geni_se *se)
 
 	return 0;
 }
-EXPORT_SYMBOL(geni_icc_enable);
+EXPORT_SYMBOL_GPL(geni_icc_enable);
 
 int geni_icc_disable(struct geni_se *se)
 {
@@ -889,7 +889,7 @@ int geni_icc_disable(struct geni_se *se)
 
 	return 0;
 }
-EXPORT_SYMBOL(geni_icc_disable);
+EXPORT_SYMBOL_GPL(geni_icc_disable);
 
 static int geni_se_probe(struct platform_device *pdev)
 {
diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index 77f0cf126629..35d35f763eb2 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -260,7 +260,7 @@ int qmp_send(struct qmp *qmp, const char *fmt, ...)
 
 	return ret;
 }
-EXPORT_SYMBOL(qmp_send);
+EXPORT_SYMBOL_GPL(qmp_send);
 
 static int qmp_qdss_clk_prepare(struct clk_hw *hw)
 {
@@ -458,7 +458,7 @@ struct qmp *qmp_get(struct device *dev)
 	}
 	return qmp;
 }
-EXPORT_SYMBOL(qmp_get);
+EXPORT_SYMBOL_GPL(qmp_get);
 
 /**
  * qmp_put() - release a qmp handle
@@ -473,7 +473,7 @@ void qmp_put(struct qmp *qmp)
 	if (!IS_ERR_OR_NULL(qmp))
 		put_device(qmp->dev);
 }
-EXPORT_SYMBOL(qmp_put);
+EXPORT_SYMBOL_GPL(qmp_put);
 
 static int qmp_probe(struct platform_device *pdev)
 {
diff --git a/drivers/soc/qcom/qmi_encdec.c b/drivers/soc/qcom/qmi_encdec.c
index 5c7161b18b72..bb09eff85cff 100644
--- a/drivers/soc/qcom/qmi_encdec.c
+++ b/drivers/soc/qcom/qmi_encdec.c
@@ -754,7 +754,7 @@ void *qmi_encode_message(int type, unsigned int msg_id, size_t *len,
 
 	return msg;
 }
-EXPORT_SYMBOL(qmi_encode_message);
+EXPORT_SYMBOL_GPL(qmi_encode_message);
 
 /**
  * qmi_decode_message() - Decode QMI encoded message to C structure
@@ -778,7 +778,7 @@ int qmi_decode_message(const void *buf, size_t len,
 	return qmi_decode(ei, c_struct, buf + sizeof(struct qmi_header),
 			  len - sizeof(struct qmi_header), 1);
 }
-EXPORT_SYMBOL(qmi_decode_message);
+EXPORT_SYMBOL_GPL(qmi_decode_message);
 
 /* Common header in all QMI responses */
 const struct qmi_elem_info qmi_response_type_v01_ei[] = {
@@ -810,7 +810,7 @@ const struct qmi_elem_info qmi_response_type_v01_ei[] = {
 		.ei_array	= NULL,
 	},
 };
-EXPORT_SYMBOL(qmi_response_type_v01_ei);
+EXPORT_SYMBOL_GPL(qmi_response_type_v01_ei);
 
 MODULE_DESCRIPTION("QMI encoder/decoder helper");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/soc/qcom/qmi_interface.c b/drivers/soc/qcom/qmi_interface.c
index 78d7361fdcf2..bb98b06e87f8 100644
--- a/drivers/soc/qcom/qmi_interface.c
+++ b/drivers/soc/qcom/qmi_interface.c
@@ -223,7 +223,7 @@ int qmi_add_lookup(struct qmi_handle *qmi, unsigned int service,
 
 	return 0;
 }
-EXPORT_SYMBOL(qmi_add_lookup);
+EXPORT_SYMBOL_GPL(qmi_add_lookup);
 
 static void qmi_send_new_server(struct qmi_handle *qmi, struct qmi_service *svc)
 {
@@ -287,7 +287,7 @@ int qmi_add_server(struct qmi_handle *qmi, unsigned int service,
 
 	return 0;
 }
-EXPORT_SYMBOL(qmi_add_server);
+EXPORT_SYMBOL_GPL(qmi_add_server);
 
 /**
  * qmi_txn_init() - allocate transaction id within the given QMI handle
@@ -328,7 +328,7 @@ int qmi_txn_init(struct qmi_handle *qmi, struct qmi_txn *txn,
 
 	return ret;
 }
-EXPORT_SYMBOL(qmi_txn_init);
+EXPORT_SYMBOL_GPL(qmi_txn_init);
 
 /**
  * qmi_txn_wait() - wait for a response on a transaction
@@ -359,7 +359,7 @@ int qmi_txn_wait(struct qmi_txn *txn, unsigned long timeout)
 	else
 		return txn->result;
 }
-EXPORT_SYMBOL(qmi_txn_wait);
+EXPORT_SYMBOL_GPL(qmi_txn_wait);
 
 /**
  * qmi_txn_cancel() - cancel an ongoing transaction
@@ -375,7 +375,7 @@ void qmi_txn_cancel(struct qmi_txn *txn)
 	mutex_unlock(&txn->lock);
 	mutex_unlock(&qmi->txn_lock);
 }
-EXPORT_SYMBOL(qmi_txn_cancel);
+EXPORT_SYMBOL_GPL(qmi_txn_cancel);
 
 /**
  * qmi_invoke_handler() - find and invoke a handler for a message
@@ -676,7 +676,7 @@ int qmi_handle_init(struct qmi_handle *qmi, size_t recv_buf_size,
 
 	return ret;
 }
-EXPORT_SYMBOL(qmi_handle_init);
+EXPORT_SYMBOL_GPL(qmi_handle_init);
 
 /**
  * qmi_handle_release() - release the QMI client handle
@@ -717,7 +717,7 @@ void qmi_handle_release(struct qmi_handle *qmi)
 		kfree(svc);
 	}
 }
-EXPORT_SYMBOL(qmi_handle_release);
+EXPORT_SYMBOL_GPL(qmi_handle_release);
 
 /**
  * qmi_send_message() - send a QMI message
@@ -796,7 +796,7 @@ ssize_t qmi_send_request(struct qmi_handle *qmi, struct sockaddr_qrtr *sq,
 	return qmi_send_message(qmi, sq, txn, QMI_REQUEST, msg_id, len, ei,
 				c_struct);
 }
-EXPORT_SYMBOL(qmi_send_request);
+EXPORT_SYMBOL_GPL(qmi_send_request);
 
 /**
  * qmi_send_response() - send a response QMI message
@@ -817,7 +817,7 @@ ssize_t qmi_send_response(struct qmi_handle *qmi, struct sockaddr_qrtr *sq,
 	return qmi_send_message(qmi, sq, txn, QMI_RESPONSE, msg_id, len, ei,
 				c_struct);
 }
-EXPORT_SYMBOL(qmi_send_response);
+EXPORT_SYMBOL_GPL(qmi_send_response);
 
 /**
  * qmi_send_indication() - send an indication QMI message
@@ -851,4 +851,4 @@ ssize_t qmi_send_indication(struct qmi_handle *qmi, struct sockaddr_qrtr *sq,
 
 	return rval;
 }
-EXPORT_SYMBOL(qmi_send_indication);
+EXPORT_SYMBOL_GPL(qmi_send_indication);
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 08e09642d7f5..9f26d7f9b9dc 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -239,7 +239,7 @@ int rpmh_write_async(const struct device *dev, enum rpmh_state state,
 
 	return __rpmh_write(dev, state, rpm_msg);
 }
-EXPORT_SYMBOL(rpmh_write_async);
+EXPORT_SYMBOL_GPL(rpmh_write_async);
 
 /**
  * rpmh_write: Write a set of RPMH commands and block until response
@@ -270,7 +270,7 @@ int rpmh_write(const struct device *dev, enum rpmh_state state,
 	WARN_ON(!ret);
 	return (ret > 0) ? 0 : -ETIMEDOUT;
 }
-EXPORT_SYMBOL(rpmh_write);
+EXPORT_SYMBOL_GPL(rpmh_write);
 
 static void cache_batch(struct rpmh_ctrlr *ctrlr, struct batch_cache_req *req)
 {
@@ -395,7 +395,7 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 
 	return ret;
 }
-EXPORT_SYMBOL(rpmh_write_batch);
+EXPORT_SYMBOL_GPL(rpmh_write_batch);
 
 static int is_req_valid(struct cache_req *req)
 {
@@ -500,4 +500,4 @@ void rpmh_invalidate(const struct device *dev)
 	ctrlr->dirty = true;
 	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
 }
-EXPORT_SYMBOL(rpmh_invalidate);
+EXPORT_SYMBOL_GPL(rpmh_invalidate);
diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
index f9fd6177118c..b7056aed4c7d 100644
--- a/drivers/soc/qcom/smd-rpm.c
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -142,7 +142,7 @@ int qcom_rpm_smd_write(struct qcom_smd_rpm *rpm,
 	mutex_unlock(&rpm->lock);
 	return ret;
 }
-EXPORT_SYMBOL(qcom_rpm_smd_write);
+EXPORT_SYMBOL_GPL(qcom_rpm_smd_write);
 
 static int qcom_smd_rpm_callback(struct rpmsg_device *rpdev,
 				 void *data,
diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index d4a89d2bb43b..b45f276a662f 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -368,7 +368,7 @@ bool qcom_smem_is_available(void)
 {
 	return !!__smem;
 }
-EXPORT_SYMBOL(qcom_smem_is_available);
+EXPORT_SYMBOL_GPL(qcom_smem_is_available);
 
 static int qcom_smem_alloc_private(struct qcom_smem *smem,
 				   struct smem_partition *part,
diff --git a/drivers/soc/qcom/wcnss_ctrl.c b/drivers/soc/qcom/wcnss_ctrl.c
index ad9942412c58..847160492db8 100644
--- a/drivers/soc/qcom/wcnss_ctrl.c
+++ b/drivers/soc/qcom/wcnss_ctrl.c
@@ -287,7 +287,7 @@ struct rpmsg_endpoint *qcom_wcnss_open_channel(void *wcnss, const char *name, rp
 
 	return rpmsg_create_ept(_wcnss->channel->rpdev, cb, priv, chinfo);
 }
-EXPORT_SYMBOL(qcom_wcnss_open_channel);
+EXPORT_SYMBOL_GPL(qcom_wcnss_open_channel);
 
 static void wcnss_async_probe(struct work_struct *work)
 {
-- 
2.17.1

