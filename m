Return-Path: <linux-kernel+bounces-144797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583598A4AD1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B611F25EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7EF3BBEF;
	Mon, 15 Apr 2024 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Uo80+cG/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A07740868;
	Mon, 15 Apr 2024 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170976; cv=none; b=FaGb7bDViGYjO+K78C3UlQLVZ42vlpnDt0Wswi84CfecrJLJMtObdlTqkspxaSNlOBM4JX4ah3mdBwBnsh3mzPXWhxQ245UOEQEzPYV9FZ2zrO1qWix+6KipCI8CCdbKXVDJ2vQn9LdTTNcyk6OnLcWZR2fgAy2U0bCZ5LQ4I2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170976; c=relaxed/simple;
	bh=MGgz9Cor2IBmN0/AQFwN26ChUvw8hSaMBL6F+iIJGC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DA5AtD5s1WwXxK9LmJK+JAoA+3x3R6B8EcTOjTL7hoXt2g9dOEwRn0Wpy7ooJMw3z63o1u5wb2r0SAwT1nd6ky96SDYFB9QSSpCzgq9CnTTYH+QN5iaSTjBpyDNM19/9/2CZeJJclYE0v6PgkyZTc1PiMXHayofpy77A553AA3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Uo80+cG/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43F4oYET003834;
	Mon, 15 Apr 2024 08:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=TzseajAnHwOdobaM5+KXAw1GO5mBXJ23A9dbPs893hk=; b=Uo
	80+cG/4kujnLJdstoys86RRP8xXhhGkpGfmuBF14FVn2InrJNK2rZ5pIrhn4Vkta
	5d6XF4Qq+jCbrLiXpPAcr2SCzUxWzCnz2yFmDm7++IasBtkic23NIhx04FYM6tzU
	OgGuOEsgNMFMwdOXy/swcgldDyw789ZgspYhPaW4QsBSy+0dDz10wTU2EAHxZiMz
	EXZrlLs6X+PRFL3LWsD88uGrjQdhzLy4RGY0NfUh3qcoTjPdKO3r5WkmuOB5o3HO
	vRo5/B9z+OZFz3wdwZY1vS+LhlHI5CE1s9GfCpGUGXiUscmZ1qgjXvHNmmUAslJf
	k3yxIezA6b95htgCm8ww==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xgwhq0fc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 08:49:33 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43F8n9ad008775;
	Mon, 15 Apr 2024 08:49:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3xfk4khayq-1;
	Mon, 15 Apr 2024 08:49:09 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43F8n94F008770;
	Mon, 15 Apr 2024 08:49:09 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 43F8n8ee008769;
	Mon, 15 Apr 2024 08:49:09 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
	id 2E8F85AF9; Mon, 15 Apr 2024 16:49:08 +0800 (CST)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: mani@kernel.org, quic_jhugo@quicinc.com
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v3 3/3] bus: mhi: host: pci_generic: Add edl callback to enter EDL
Date: Mon, 15 Apr 2024 16:49:05 +0800
Message-Id: <1713170945-44640-4-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713170945-44640-1-git-send-email-quic_qianyu@quicinc.com>
References: <1713170945-44640-1-git-send-email-quic_qianyu@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: f1Ocg_qiIW6s1uksEf8pN7du_erWEfMu
X-Proofpoint-GUID: f1Ocg_qiIW6s1uksEf8pN7du_erWEfMu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999 adultscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404150058
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
 drivers/bus/mhi/host/pci_generic.c | 47 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 51639bf..cbf8a58 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -27,12 +27,19 @@
 #define PCI_VENDOR_ID_THALES	0x1269
 #define PCI_VENDOR_ID_QUECTEL	0x1eac
 
+#define MHI_EDL_DB			91
+#define MHI_EDL_COOKIE			0xEDEDEDED
+
+/* Device can enter EDL by first setting edl cookie then issuing inband reset*/
+#define MHI_PCI_GENERIC_EDL_TRIGGER	BIT(0)
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
@@ -44,6 +51,7 @@ struct mhi_pci_dev_info {
 	const char *name;
 	const char *fw;
 	const char *edl;
+	unsigned int edl_trigger;
 	unsigned int bar_num;
 	unsigned int dma_data_width;
 	unsigned int mru_default;
@@ -292,6 +300,7 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx75_info = {
 	.name = "qcom-sdx75m",
 	.fw = "qcom/sdx75m/xbl.elf",
 	.edl = "qcom/sdx75m/edl.mbn",
+	.edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
 	.config = &modem_qcom_v2_mhiv_config,
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
 	.dma_data_width = 32,
@@ -302,6 +311,7 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx65_info = {
 	.name = "qcom-sdx65m",
 	.fw = "qcom/sdx65m/xbl.elf",
 	.edl = "qcom/sdx65m/edl.mbn",
+	.edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
 	.config = &modem_qcom_v1_mhiv_config,
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
 	.dma_data_width = 32,
@@ -312,6 +322,7 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx55_info = {
 	.name = "qcom-sdx55m",
 	.fw = "qcom/sdx55m/sbl1.mbn",
 	.edl = "qcom/sdx55m/edl.mbn",
+	.edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
 	.config = &modem_qcom_v1_mhiv_config,
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
 	.dma_data_width = 32,
@@ -928,6 +939,39 @@ static void health_check(struct timer_list *t)
 	mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
 }
 
+static int mhi_pci_generic_edl_trigger(struct mhi_controller *mhi_cntrl)
+{
+	void __iomem *base = mhi_cntrl->regs;
+	void __iomem *edl_db;
+	int ret;
+	u32 val;
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
+	ret = mhi_get_channel_doorbell(mhi_cntrl, &val);
+	if (ret)
+		return ret;
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
@@ -962,6 +1006,9 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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


