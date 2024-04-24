Return-Path: <linux-kernel+bounces-156208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E74A8AFF7C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8106C1C21C51
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E3E140363;
	Wed, 24 Apr 2024 03:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iEOTLR6Q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CB086254;
	Wed, 24 Apr 2024 03:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713928931; cv=none; b=VY5NXC+9WrtnAFGv/KoxNfKK+f9VwpzmPlr3/4ktmHKIQk022O6BSY61WPfir6XQLd/U4dr2YdheE1l+sr8dQ/m3STU4kyuYQMkAZvF9rtWjE+cF6QmhOnAEsZckHmV82+mQQFsHimwun/YrWoNqqnxC0ndb42AtIIZ8g0F23CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713928931; c=relaxed/simple;
	bh=9R7FIcQFKBEQQx5QXYjeUT1GVFuSq72auzeXMoCNvHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mYUxXXIGeCajkRB1B3fEHEiEHYXVY560rJ2Dkxh0WmtW79qbGBTx3pXpAmvgjED9bEFl2oI1bNoEPzvGv4vjHNaFpwCQCyvlYGrygaNV2QyDRLsHQLjHoRAf/Xo/YbNQDA9kyMH8GL9smoEbGZSNbVurJ4DNRSWmffTe7DalccM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iEOTLR6Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O2tinR012807;
	Wed, 24 Apr 2024 03:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=brzh2YeNdUZBh+5oiJjhUjNiEloHl8YjISKgrD0j3MI=; b=iE
	OTLR6Q9DGXmG+5pgn++NZx9fqUgPdNX1QpKbGhPQA157EoUg2yFGrUk+39GZ6x23
	p/FZq4M0QA5nBDpBBd0IybTzCvBw3yUKjQHN2HXritpYMc696RyA3HErbhnDfCvP
	wDYe2WAURhxxrnhZEto0106WDHzwDxhoh47USQy3WlpPK2DEjDY1ON5zFdVjRCdv
	BVYLvmtPbUV4mkn5qCAd/oihCH4ClLejXd4LSXGxp/DyYPEl38uCDUSkQ4z1Kv/2
	ECC/rASQ0UWInEn7pUhRadzT1Is7fvtoUm2t1SVGmxTYTQHNbCJvJTidPmLVMZoB
	V4WRqQaja7xks6wUi9DA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xppn5gbjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 03:22:03 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43O3M17U017025;
	Wed, 24 Apr 2024 03:22:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3xm6skgtj3-1;
	Wed, 24 Apr 2024 03:22:01 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43O3M07U017001;
	Wed, 24 Apr 2024 03:22:01 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 43O3M10E017012;
	Wed, 24 Apr 2024 03:22:01 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
	id C4D485B1C; Wed, 24 Apr 2024 11:22:00 +0800 (CST)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: mani@kernel.org, quic_jhugo@quicinc.com
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v5 3/3] bus: mhi: host: pci_generic: Add edl callback to enter EDL
Date: Wed, 24 Apr 2024 11:21:55 +0800
Message-Id: <1713928915-18229-4-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713928915-18229-1-git-send-email-quic_qianyu@quicinc.com>
References: <1713928915-18229-1-git-send-email-quic_qianyu@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6307CEO8vJo6-1KKTXF_LYsnHkAwqg15
X-Proofpoint-ORIG-GUID: 6307CEO8vJo6-1KKTXF_LYsnHkAwqg15
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_20,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240014
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
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
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


