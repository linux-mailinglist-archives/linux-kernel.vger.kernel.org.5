Return-Path: <linux-kernel+bounces-139696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 969598A0694
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D82D28AA4F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216C213BAEA;
	Thu, 11 Apr 2024 03:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nh+2sw2a"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F7913B5A7;
	Thu, 11 Apr 2024 03:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712805340; cv=none; b=DuzqFUmlsfJHL9nU2s00Mg3ZaIeBcucu7v3xc69+DzFFO5UBc3iqMnq8AYJNJ4agRHqf5YTascwMLf3dEA0jQrBMcgES6dzxE0KLMlCcfFgmzw5qN4SzxAWM/6Zskw1vXPnpcWgSG0sD5iTaVhQ4/fUvY4hZNZrmabvreVXpCZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712805340; c=relaxed/simple;
	bh=UhrmxbLnfXHYPjjyjBDtmKfg0+L6GRj7KS/GFBOG0C4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=K752nqXWnryFC3tWXIkCifPafeoRJZ7mT4yQ6AS+PH4M2feJdKLNTyD6873/NE0LY3rrIORe2hoS7taIQEzrikyKmNv6KqQ1qjRxZysD7LcZ+avPt4ekL5X7e198NQoBc6QHiI8H2j0LppoL4otsVff6fSGkoAoZSJESjx2GYmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nh+2sw2a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43B20LbD022416;
	Thu, 11 Apr 2024 03:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=nX/eaZ/9G2NjvCLl9zou8QMkTQTTEPy9jJMuIbEYc30=; b=nh
	+2sw2aHMZV8/rPsCoHLMjXbrc7OSHfNudyF9jmwBbjD+5r4VaatMejRBBIh+nYZb
	0PCgxueRBG3IxE2lqXWh5VOdLi5MOAkEcgQg2/2oqIb7rDsfaoslCcHEOtBqr5Dq
	ablIhruMLG5ZwtfPUtzF+jKBatlpF+rEoD99fc1U5bg6NFJ3x8HbfQ5EptoB4pz3
	tnxHqz/ScpBnhfoO50hZ7HzHmlg5Or1C07JPI/TvYVcFAq6P4+JhKbCzCEa+zEs1
	+/Cff9/s9SCF+ssLKzhRmJeDavq2rZBIdSkROXym5fNuIxMrK/ocJdUGv4edQI3r
	kvogx6PMpNc6KUqYAkCg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xe0hu96g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 03:15:35 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43B3CTaF014807;
	Thu, 11 Apr 2024 03:15:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3xayfkm162-1;
	Thu, 11 Apr 2024 03:15:33 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43B3CTd7014815;
	Thu, 11 Apr 2024 03:15:33 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 43B3FXHg018373;
	Thu, 11 Apr 2024 03:15:33 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
	id 9646A5AE0; Thu, 11 Apr 2024 11:15:32 +0800 (CST)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: mani@kernel.org, quic_jhugo@quicinc.com
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v2 2/2] bus: mhi: host: pci_generic: Add edl callback to enter EDL
Date: Thu, 11 Apr 2024 11:15:29 +0800
Message-Id: <1712805329-46158-3-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1712805329-46158-1-git-send-email-quic_qianyu@quicinc.com>
References: <1712805329-46158-1-git-send-email-quic_qianyu@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: py8FgYC7qQbIn29SJxS1v7i43OVGz0DC
X-Proofpoint-ORIG-GUID: py8FgYC7qQbIn29SJxS1v7i43OVGz0DC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404110022
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add mhi_pci_generic_edl_trigger as edl_trigger for some devices (eg. SDX65)
to enter EDL mode by writing the 0xEDEDEDED cookie to the channel 91
doorbell register and forcing an SOC reset afterwards.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
 drivers/bus/mhi/host/pci_generic.c | 50 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 51639bf..a529815 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -27,12 +27,23 @@
 #define PCI_VENDOR_ID_THALES	0x1269
 #define PCI_VENDOR_ID_QUECTEL	0x1eac
 
+#define MHI_EDL_DB			91
+#define MHI_EDL_COOKIE			0xEDEDEDED
+
+/* Device can enter EDL by first setting edl cookie then issuing inband reset*/
+#define MHI_PCI_GENERIC_EDL_TRIGGER	BIT(0)
+
+#define CHDBOFF			0x18
+#define CHDBOFF_CHDBOFF_MASK	0xFFFFFFFF
+#define CHDBOFF_CHDBOFF_SHIFT	0
+
 /**
  * struct mhi_pci_dev_info - MHI PCI device specific information
  * @config: MHI controller configuration
  * @name: name of the PCI module
  * @fw: firmware path (if any)
  * @edl: emergency download mode firmware path (if any)
+ * @edl_trigger: each bit represents a different way to enter EDL
  * @bar_num: PCI base address register to use for MHI MMIO register space
  * @dma_data_width: DMA transfer word size (32 or 64 bits)
  * @mru_default: default MRU size for MBIM network packets
@@ -44,6 +55,7 @@ struct mhi_pci_dev_info {
 	const char *name;
 	const char *fw;
 	const char *edl;
+	unsigned int edl_trigger;
 	unsigned int bar_num;
 	unsigned int dma_data_width;
 	unsigned int mru_default;
@@ -292,6 +304,7 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx75_info = {
 	.name = "qcom-sdx75m",
 	.fw = "qcom/sdx75m/xbl.elf",
 	.edl = "qcom/sdx75m/edl.mbn",
+	.edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
 	.config = &modem_qcom_v2_mhiv_config,
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
 	.dma_data_width = 32,
@@ -302,6 +315,7 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx65_info = {
 	.name = "qcom-sdx65m",
 	.fw = "qcom/sdx65m/xbl.elf",
 	.edl = "qcom/sdx65m/edl.mbn",
+	.edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
 	.config = &modem_qcom_v1_mhiv_config,
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
 	.dma_data_width = 32,
@@ -312,6 +326,7 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx55_info = {
 	.name = "qcom-sdx55m",
 	.fw = "qcom/sdx55m/sbl1.mbn",
 	.edl = "qcom/sdx55m/edl.mbn",
+	.edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
 	.config = &modem_qcom_v1_mhiv_config,
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
 	.dma_data_width = 32,
@@ -928,6 +943,38 @@ static void health_check(struct timer_list *t)
 	mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
 }
 
+static int mhi_pci_generic_edl_trigger(struct mhi_controller *mhi_cntrl)
+{
+	int ret;
+	u32 val;
+	void __iomem *edl_db;
+	void __iomem *base = mhi_cntrl->regs;
+
+	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
+	if (ret) {
+		dev_err(mhi_cntrl->cntrl_dev, "Wake up device fail before trigger EDL\n");
+		return ret;
+	}
+
+	pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
+	mhi_cntrl->runtime_get(mhi_cntrl);
+
+	mhi_cntrl->read_reg(mhi_cntrl, base + CHDBOFF, &val);
+	val = (val & CHDBOFF_CHDBOFF_MASK) >> CHDBOFF_CHDBOFF_SHIFT;
+
+	edl_db = base + val + (8 * MHI_EDL_DB);
+
+	mhi_cntrl->write_reg(mhi_cntrl, edl_db + 4, upper_32_bits(MHI_EDL_COOKIE));
+	mhi_cntrl->write_reg(mhi_cntrl, edl_db, lower_32_bits(MHI_EDL_COOKIE));
+
+	mhi_soc_reset(mhi_cntrl);
+
+	mhi_cntrl->runtime_put(mhi_cntrl);
+	mhi_device_put(mhi_cntrl->mhi_dev);
+
+	return 0;
+}
+
 static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	const struct mhi_pci_dev_info *info = (struct mhi_pci_dev_info *) id->driver_data;
@@ -962,6 +1009,9 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mhi_cntrl->runtime_put = mhi_pci_runtime_put;
 	mhi_cntrl->mru = info->mru_default;
 
+	if (info->edl_trigger & MHI_PCI_GENERIC_EDL_TRIGGER)
+		mhi_cntrl->edl_trigger = mhi_pci_generic_edl_trigger;
+
 	if (info->sideband_wake) {
 		mhi_cntrl->wake_get = mhi_pci_wake_get_nop;
 		mhi_cntrl->wake_put = mhi_pci_wake_put_nop;
-- 
2.7.4


