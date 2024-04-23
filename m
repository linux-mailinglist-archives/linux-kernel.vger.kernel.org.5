Return-Path: <linux-kernel+bounces-154872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9BA8AE23D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3FF1C21AFE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99757633E5;
	Tue, 23 Apr 2024 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mshBm6sk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E15322A;
	Tue, 23 Apr 2024 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868435; cv=none; b=A9Pr/R/HcVuFr3MyBbfO/5vMdLmez2Cw7DCaDEv+puJOSJCvyVZa7by8xQvDNbguHWZSN1dho9VihhqKaNNclD6YAvC57qNI1MOZ4TDZDp0ebF3dYKtOqTrf5dPtUtSlLV5UW4hArkh7QE7BnuEdlKJrC7IGTONAMN6beLFETQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868435; c=relaxed/simple;
	bh=bXqo+Zh46zqPZrck6jl1uquMHLCwuBpnagCno6z+964=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pFtA6dTQHQcmodOIyyBF+5Xh2ImUgK+nesn9FQEiCWGdH4qdU9xx46ioQPaxa3kPYVUQ+DD57OHuwvVRFcBVk/Y4PUj4voKEEpEoXEpsr3Jd2HMH3u15OVd1bKq9ji9jCHQmAOk/To/VwrLeGnRXMs3IfkM4FvmZdZ3IXpQYO1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mshBm6sk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N9nm6q005293;
	Tue, 23 Apr 2024 10:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=fPY8VNbNEa664HwPePTbFwyJ0YDyG1kZh2fUqeuBZws=; b=ms
	hBm6sk/UDgqCXfrFUL04S/z2seloa5H2Hb1DRV8RjsCg30Tsq2jiOPf/euxp0sQl
	lx7jrq3zHCZaWj8PCNB0kT9UEIX8AtkdEPTLSEe4JqkAlLjMsr/c4l+QaHfrWsVI
	cjiFdcngioR7FZLg36xch2bsOv7lClAV7FCXWjuF0huDF0sHtwU5RsXMef/qYcvB
	6RsLFkkCs++OzCOwpRm3d1y9hh6XlsAFsNva4kdkhMQ5j8N6TIct+cjN8EMocvlj
	4gGNqrzIWjtw8OHfmQs7CypIKRCInH5QzufEJ1r7psNYCaB6jKAZ0lecv0uC9Y2m
	WKEmBN6KVYejSQ2j8IIw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpapmg3jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 10:33:43 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43NAXfYD003612;
	Tue, 23 Apr 2024 10:33:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3xm6ske0ba-1;
	Tue, 23 Apr 2024 10:33:41 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43NAXfth003605;
	Tue, 23 Apr 2024 10:33:41 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 43NAXf8t003604;
	Tue, 23 Apr 2024 10:33:41 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
	id 61DC85B10; Tue, 23 Apr 2024 18:33:40 +0800 (CST)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: mani@kernel.org, quic_jhugo@quicinc.com
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v4 3/3] bus: mhi: host: pci_generic: Add edl callback to enter EDL
Date: Tue, 23 Apr 2024 18:33:37 +0800
Message-Id: <1713868417-37856-4-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713868417-37856-1-git-send-email-quic_qianyu@quicinc.com>
References: <1713868417-37856-1-git-send-email-quic_qianyu@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PI4mMDUrlgJ2iEevvVBpKQW_xG_UpIwg
X-Proofpoint-GUID: PI4mMDUrlgJ2iEevvVBpKQW_xG_UpIwg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230028
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Some of the MHI modems like SDX65 based ones are capable of entering the EDL
mode as per the standard triggering mechanism defined in the MHI spec v1.2. So
let's add a common mhi_pci_generic_edl_trigger() function that triggers the EDL
mode in the device when user writes to the /sys/bus/mhi/devices/.../trigger_edl
file.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
 drivers/bus/mhi/host/pci_generic.c | 45 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 51639bf..c65eaa8 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -27,12 +27,16 @@
 #define PCI_VENDOR_ID_THALES	0x1269
 #define PCI_VENDOR_ID_QUECTEL	0x1eac
 
+#define MHI_EDL_DB			91
+#define MHI_EDL_COOKIE			0xEDEDEDED
+
 /**
  * struct mhi_pci_dev_info - MHI PCI device specific information
  * @config: MHI controller configuration
  * @name: name of the PCI module
  * @fw: firmware path (if any)
  * @edl: emergency download mode firmware path (if any)
+ * @edl_trigger: capable of triggering EDL mode in the device (if supported)
  * @bar_num: PCI base address register to use for MHI MMIO register space
  * @dma_data_width: DMA transfer word size (32 or 64 bits)
  * @mru_default: default MRU size for MBIM network packets
@@ -44,6 +48,7 @@ struct mhi_pci_dev_info {
 	const char *name;
 	const char *fw;
 	const char *edl;
+	bool edl_trigger;
 	unsigned int bar_num;
 	unsigned int dma_data_width;
 	unsigned int mru_default;
@@ -292,6 +297,7 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx75_info = {
 	.name = "qcom-sdx75m",
 	.fw = "qcom/sdx75m/xbl.elf",
 	.edl = "qcom/sdx75m/edl.mbn",
+	.edl_trigger = true,
 	.config = &modem_qcom_v2_mhiv_config,
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
 	.dma_data_width = 32,
@@ -302,6 +308,7 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx65_info = {
 	.name = "qcom-sdx65m",
 	.fw = "qcom/sdx65m/xbl.elf",
 	.edl = "qcom/sdx65m/edl.mbn",
+	.edl_trigger = true,
 	.config = &modem_qcom_v1_mhiv_config,
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
 	.dma_data_width = 32,
@@ -312,6 +319,7 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx55_info = {
 	.name = "qcom-sdx55m",
 	.fw = "qcom/sdx55m/sbl1.mbn",
 	.edl = "qcom/sdx55m/edl.mbn",
+	.edl_trigger = true,
 	.config = &modem_qcom_v1_mhiv_config,
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
 	.dma_data_width = 32,
@@ -928,6 +936,40 @@ static void health_check(struct timer_list *t)
 	mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
 }
 
+static int mhi_pci_generic_edl_trigger(struct mhi_controller *mhi_cntrl)
+{
+	void __iomem *base = mhi_cntrl->regs;
+	void __iomem *edl_db;
+	int ret = 0;
+	u32 val;
+
+	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
+	if (ret) {
+		dev_err(mhi_cntrl->cntrl_dev, "Failed to wakeup the device\n");
+		return ret;
+	}
+
+	pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
+	mhi_cntrl->runtime_get(mhi_cntrl);
+
+	ret = mhi_get_channel_doorbell_offset(mhi_cntrl, &val);
+	if (ret)
+		goto err_get_chdb;
+
+	edl_db = base + val + (8 * MHI_EDL_DB);
+
+	mhi_cntrl->write_reg(mhi_cntrl, edl_db + 4, upper_32_bits(MHI_EDL_COOKIE));
+	mhi_cntrl->write_reg(mhi_cntrl, edl_db, lower_32_bits(MHI_EDL_COOKIE));
+
+	mhi_soc_reset(mhi_cntrl);
+
+err_get_chdb:
+	mhi_cntrl->runtime_put(mhi_cntrl);
+	mhi_device_put(mhi_cntrl->mhi_dev);
+
+	return ret;
+}
+
 static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	const struct mhi_pci_dev_info *info = (struct mhi_pci_dev_info *) id->driver_data;
@@ -962,6 +1004,9 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mhi_cntrl->runtime_put = mhi_pci_runtime_put;
 	mhi_cntrl->mru = info->mru_default;
 
+	if (info->edl_trigger)
+		mhi_cntrl->edl_trigger = mhi_pci_generic_edl_trigger;
+
 	if (info->sideband_wake) {
 		mhi_cntrl->wake_get = mhi_pci_wake_get_nop;
 		mhi_cntrl->wake_put = mhi_pci_wake_put_nop;
-- 
2.7.4


