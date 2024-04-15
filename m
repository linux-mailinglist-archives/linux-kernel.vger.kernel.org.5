Return-Path: <linux-kernel+bounces-144796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CA38A4ACF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C6C281408
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115B53A29A;
	Mon, 15 Apr 2024 08:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AkGhhbXB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE2F3B18D;
	Mon, 15 Apr 2024 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170968; cv=none; b=HwKJa8cyYONmD2FSiB44+tzZe/V9XowwuIefKR1qfUXm8JfW35MBdU0K6OmutEHjTUxHM+lIIXNEe96qd5VhWpW/WYpm1VFR8XKMh9N06pMVtC9mF6FkjM46nQKR1frlsoMwoH3qXbDZ8SMP1/ATiT6woLYCl5fPoVDnehJPTE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170968; c=relaxed/simple;
	bh=tPEj1U8mgX4MMKk2uVJ7kvNLx8AFH0FwwLNIzRdjkXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TN6gafXdmwKYJmFFgzgfFgMU5LP9r2KEXficebuO2q6nT1c9nteBGSBFQqu4IYLwYiWue47QXcHSsmST8zzwTwQyL2sk38zAkgx3IYrQvYKCLnwys7Re3umcXxBB5A+Z5MBoU9tm1zgPEYHXx1CUOAOAU0VuZ88tXqs733NaSek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AkGhhbXB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43F50sN2006805;
	Mon, 15 Apr 2024 08:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=SliihC7IXqCZ9E9dZE4rotX9EE7PGk3ukmR1Fhd5b68=; b=Ak
	GhhbXBnPJfvHlldZOrL4ALWpMBHtep/30ltiIw80eN3BHv8vRKZpeR9Cy8sazJ4t
	5ORRakEoYtGiCfRN35IexXZTDb8G9MFxXIt4+7M35mu2t2hT8o/S8w211j4pZk0U
	r+vZ9gPVTOJhTWLqrWZXoTa0iZkYNec3bPa4LJpVsi4ZqiJi3vScTqLpkRs8CzDI
	T6Myr6hObKFvmMNeWjmS3nbEEjkAEyR7U2RmqR7VFgXcpxz7/P2lCDv4rzr9fY9z
	kdfEuNZBiF8OaXAKFY1mih1URwH6i5hsx747XgEfYxiD+/x0iw6CwV9DaA3O96fI
	JPywOBMHmjzweVqLzW2Q==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xgwqfgeyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 08:49:23 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43F8n8d3005856;
	Mon, 15 Apr 2024 08:49:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3xfk4kh5pu-1;
	Mon, 15 Apr 2024 08:49:08 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43F8n8cK005850;
	Mon, 15 Apr 2024 08:49:08 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 43F8n8Ru005849;
	Mon, 15 Apr 2024 08:49:08 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
	id B8A045AFB; Mon, 15 Apr 2024 16:49:07 +0800 (CST)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: mani@kernel.org, quic_jhugo@quicinc.com
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v3 2/3] bus: mhi: host: Add a new API for getting channel doorbell address
Date: Mon, 15 Apr 2024 16:49:04 +0800
Message-Id: <1713170945-44640-3-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713170945-44640-1-git-send-email-quic_qianyu@quicinc.com>
References: <1713170945-44640-1-git-send-email-quic_qianyu@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p1E_W71EjPcYSDw0kMXYkBwusE1O5LUX
X-Proofpoint-ORIG-GUID: p1E_W71EjPcYSDw0kMXYkBwusE1O5LUX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404150058
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
---
 drivers/bus/mhi/host/main.c | 17 +++++++++++++++++
 include/linux/mhi.h         |  7 +++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 15d657a..947b5ec 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -1691,3 +1691,20 @@ void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
 	}
 }
 EXPORT_SYMBOL_GPL(mhi_unprepare_from_transfer);
+
+int mhi_get_channel_doorbell(struct mhi_controller *mhi_cntrl, u32 *chdb_offset)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	void __iomem *base = mhi_cntrl->regs;
+	int ret;
+
+	/* Read channel db offset */
+	ret = mhi_read_reg(mhi_cntrl, base, CHDBOFF, chdb_offset);
+	if (ret) {
+		dev_err(dev, "Unable to read CHDBOFF register\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mhi_get_channel_doorbell);
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 8280545..1135142 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -816,4 +816,11 @@ int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
  */
 bool mhi_queue_is_full(struct mhi_device *mhi_dev, enum dma_data_direction dir);
 
+/**
+ * mhi_get_channel_doorbell - read channel doorbell offset register to get
+ *                            channel doorbell address
+ * @mhi_cntrl: MHI controller
+ * @chdb_offset: channel doorbell address
+ */
+int mhi_get_channel_doorbell(struct mhi_controller *mhi_cntrl, u32 *chdb_offset);
 #endif /* _MHI_H_ */
-- 
2.7.4


