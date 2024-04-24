Return-Path: <linux-kernel+bounces-156207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 534588AFF7A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1501F22C93
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9912313D886;
	Wed, 24 Apr 2024 03:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FPAem1Gj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6412285C46;
	Wed, 24 Apr 2024 03:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713928927; cv=none; b=VnCEVs9uR98w8CDdQBjk7Wd2xktXuRqQck181r2Dju8QyTBGZzzejq7Lsfw3wwUPcqVqKJCWfyvjnbqUtJPmHXEjChxVXGI3k8WsVIU1h1j1uz2dEMFiDdOB2RZhoXGOIlJMkbBVJwfPt+kMi8zVYGAnCbPRG1jvHtoFPFhI0Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713928927; c=relaxed/simple;
	bh=15Ics9rBeRjslxPH+6s/riknV83YlE2k7okx48Rqd8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ebvQMkgxocaWqxyFhUNCDHgt7fk10L5IB83Kmghb+EHohZJAAGsrjr68kCsFAq7r96o5o9mqq4tWG4usfPhhxxKmKz9Uryykfhb4WxdZ7i9kZ5NI7vVjwjb5mAWm2xxk9rtHcle+DuT9sCuR7Qib7OhwUPtXbOfNzAcfWpnnjrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FPAem1Gj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O1nCTQ023738;
	Wed, 24 Apr 2024 03:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=g+qBXc7qxkRg7xJfqPRUgrpsOaBjjklP9h5veFTBi7A=; b=FP
	Aem1GjMpNXZh0yCCL4u72v2kys+RjKwKZ5u3wcORRcb/Xe7nlQiolTgUeJVzAVfO
	pXJ6trwamm5bwnz2YJUJM9+9O0iYCR13WnUahJZGCeGE22fTXrB01YnF7cVL3XFZ
	fA+0cm6/BfKps4g66qYgNb5komYsuGLbFbzTY7GxzJAxZuxdf761oguF2SIzdWL/
	R88O5oal7PFjk0+ixVWoH9+V6paj261Nq2j5c9PCMjxg2Xa9RTOmWw6TeJx3U50C
	RAuLLRR6Qqh9km4vpS5IFsDOdiLwohI6JFHMnOh7T1LtWv1gXy9n/GG8z6AL0lzA
	0de2ujEj9M99ZLXbMXYA==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xppn5gbjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 03:22:03 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43O3M1jK024093;
	Wed, 24 Apr 2024 03:22:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3xm6skh29q-1;
	Wed, 24 Apr 2024 03:22:01 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43O3M1Q9024087;
	Wed, 24 Apr 2024 03:22:01 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 43O3M10H024082;
	Wed, 24 Apr 2024 03:22:01 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
	id 605745B1E; Wed, 24 Apr 2024 11:22:00 +0800 (CST)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: mani@kernel.org, quic_jhugo@quicinc.com
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v5 2/3] bus: mhi: host: Add a new API for getting channel doorbell address
Date: Wed, 24 Apr 2024 11:21:54 +0800
Message-Id: <1713928915-18229-3-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713928915-18229-1-git-send-email-quic_qianyu@quicinc.com>
References: <1713928915-18229-1-git-send-email-quic_qianyu@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FURHiyRLJfNuAenTDfrslMnwu_cUY42v
X-Proofpoint-ORIG-GUID: FURHiyRLJfNuAenTDfrslMnwu_cUY42v
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

Some controllers may want to know the address of a certain doorbell. Hence
add a new API where we read CHDBOFF register to get the base address of
doorbell, so that the controller can calculate the address of the doorbell
it wants by adding additional offset.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 drivers/bus/mhi/host/init.c |  6 ++----
 drivers/bus/mhi/host/main.c | 16 ++++++++++++++++
 include/linux/mhi.h         |  7 +++++++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 7104c18..6e0fa79 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -541,11 +541,9 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 	dev_dbg(dev, "Initializing MHI registers\n");
 
 	/* Read channel db offset */
-	ret = mhi_read_reg(mhi_cntrl, base, CHDBOFF, &val);
-	if (ret) {
-		dev_err(dev, "Unable to read CHDBOFF register\n");
+	ret = mhi_get_channel_doorbell_offset(mhi_cntrl, &val);
+	if (ret)
 		return -EIO;
-	}
 
 	if (val >= mhi_cntrl->reg_len - (8 * MHI_DEV_WAKE_DB)) {
 		dev_err(dev, "CHDB offset: 0x%x is out of range: 0x%zx\n",
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 15d657a..4de7567 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -1691,3 +1691,19 @@ void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
 	}
 }
 EXPORT_SYMBOL_GPL(mhi_unprepare_from_transfer);
+
+int mhi_get_channel_doorbell_offset(struct mhi_controller *mhi_cntrl, u32 *chdb_offset)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	void __iomem *base = mhi_cntrl->regs;
+	int ret;
+
+	ret = mhi_read_reg(mhi_cntrl, base, CHDBOFF, chdb_offset);
+	if (ret) {
+		dev_err(dev, "Unable to read CHDBOFF register\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mhi_get_channel_doorbell_offset);
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index d968e1a..2cf1b3a 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -816,4 +816,11 @@ int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
  */
 bool mhi_queue_is_full(struct mhi_device *mhi_dev, enum dma_data_direction dir);
 
+/**
+ * mhi_get_channel_doorbell_offset - Get the channel doorbell offset
+ * @mhi_cntrl: MHI controller
+ * @chdb_offset: Channel doorbell offset
+ */
+int mhi_get_channel_doorbell_offset(struct mhi_controller *mhi_cntrl, u32 *chdb_offset);
+
 #endif /* _MHI_H_ */
-- 
2.7.4


