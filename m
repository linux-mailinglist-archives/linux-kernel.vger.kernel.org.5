Return-Path: <linux-kernel+bounces-108986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4AF881306
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1061DB241D5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB759482C4;
	Wed, 20 Mar 2024 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E2VJrVZZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD503EA98;
	Wed, 20 Mar 2024 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710943927; cv=none; b=OFfTMw4NQ+NcZlgSxYg/q6joMjd8KYAS1CojYoMo9AP8AM18AJMebC+ivpTKCzUa3xYOqO/DGJl65b+qVb/mcc3uNu4I1YpRs1vOfKOlGKXHceQz6WdGMbPLII3c+P+vXaS0Nnfvdsdzmd0ZjG/J5rR/K8uOgGwwC6bbea1xHiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710943927; c=relaxed/simple;
	bh=s2/vULG5iS+dEBSt33YSQwB7/yLX65wOU1yR3yAm0aY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mn+Jtup6+SjJ8rl1rBseS2n1z8KztQtlbBxHPRqa3+36JSozrswm/05UT0MVCXCzSvFSfD4BIAm5dMtKegBwXJKY+LYbeImNjc7kT//8DyDsBKP7Ahp9hQOpi/arMnBkw3x/VU2/iYRMz+LH8ZFtD6Id97AtfFwXL1wN+oy+K3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E2VJrVZZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42K7ek7m000798;
	Wed, 20 Mar 2024 14:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=zXa8AY6dgeHMO6qUp4Hm
	rmjqvg1owoNbUEMfj2Pg8i8=; b=E2VJrVZZjFdFjUR7bPVr1knm4OgfJHvfQSFb
	ik9CK5VTCennEbPjiemn354+q4HzKdonHswGJ7RV8PXteXgbmH8JPkHjy8ef62PI
	goCTi6oHy6X0zn2qtnDiAeDNn/tK91sghpekjI9jdoro1GV1yv0MKV0ZUSFoZfGM
	D3OFbCQ3Dsf89ApoHrho2UsSiaXXP94PXBIpeBOb5OEu4JmM15ws2U2qB+jNtICV
	l8+7AY7nvI3OstsZY+cuFhjf9uET/Ynu9HjpygvF4l5VruVeXtA5eEaCwktX9OgM
	gxu92WN3pRCCbYs71G+U99iVcIr4WNHg56GRFtA5JLorwqSw6g==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyqh61ar9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 14:12:01 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KEC0F7022290
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 14:12:00 GMT
Received: from hu-depengs-sha.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 07:11:58 -0700
From: Depeng Shao <quic_depengs@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <quic_yon@quicinc.com>
CC: <quic_depengs@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 2/8] media: qcom: camss: Add subdev notify support
Date: Wed, 20 Mar 2024 19:41:30 +0530
Message-ID: <20240320141136.26827-3-quic_depengs@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240320141136.26827-1-quic_depengs@quicinc.com>
References: <20240320141136.26827-1-quic_depengs@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SEN65laiMssUQ5vPcjKMc2e2YwEBeBXx
X-Proofpoint-GUID: SEN65laiMssUQ5vPcjKMc2e2YwEBeBXx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200112

From: Yongsheng Li <quic_yon@quicinc.com>

The buf done irq and register update register are moved
to CSID in SM8550, so but the write master configuration
in VFE, in case adapt existing code logic. So add buf
done and register related subdev event, and use the notify
interface in the v4l2_device structure to communicate
between CSID and VFE driver.

Signed-off-by: Yongsheng Li <quic_yon@quicinc.com>
---
 .../media/platform/qcom/camss/camss-csid.h    |  7 +++
 .../media/platform/qcom/camss/camss-csiphy.h  |  2 +
 drivers/media/platform/qcom/camss/camss-vfe.h |  2 +
 drivers/media/platform/qcom/camss/camss.c     | 50 +++++++++++++++++++
 drivers/media/platform/qcom/camss/camss.h     |  7 +++
 5 files changed, 68 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.h b/drivers/media/platform/qcom/camss/camss-csid.h
index fddccb69da13..4a9e5a2d1f92 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.h
+++ b/drivers/media/platform/qcom/camss/camss-csid.h
@@ -147,6 +147,13 @@ struct csid_hw_ops {
 	 * @csid: CSID device
 	 */
 	void (*subdev_init)(struct csid_device *csid);
+
+	/*
+	 * event - receive event from parent v4l2 device
+	 * @csid: CSID device
+	 */
+	void (*event)(struct csid_device *csid,
+			unsigned int evt_type, void *arg);
 };
 
 struct csid_device {
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.h b/drivers/media/platform/qcom/camss/camss-csiphy.h
index c9b7fe82b1f0..ffe1b95eea98 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.h
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.h
@@ -61,6 +61,8 @@ struct csiphy_hw_ops {
 	void (*lanes_disable)(struct csiphy_device *csiphy,
 			      struct csiphy_config *cfg);
 	irqreturn_t (*isr)(int irq, void *dev);
+	void (*event)(struct csiphy_device *csiphy,
+			unsigned int evt_type, void *arg);
 };
 
 struct csiphy_device {
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.h b/drivers/media/platform/qcom/camss/camss-vfe.h
index 0572c9b08e11..9919fe0ff101 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.h
+++ b/drivers/media/platform/qcom/camss/camss-vfe.h
@@ -115,6 +115,8 @@ struct vfe_hw_ops {
 	int (*vfe_halt)(struct vfe_device *vfe);
 	void (*violation_read)(struct vfe_device *vfe);
 	void (*vfe_wm_stop)(struct vfe_device *vfe, u8 wm);
+	void (*event)(struct vfe_device *vfe,
+			unsigned int evt_type, void *arg);
 };
 
 struct vfe_isr_ops {
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 1923615f0eea..b57cd25bf6c7 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1904,6 +1904,55 @@ static void camss_genpd_cleanup(struct camss *camss)
 	dev_pm_domain_detach(camss->genpd, true);
 }
 
+static void camss_v4l2_subdev_notify(struct v4l2_subdev *sd,
+			unsigned int cmd, void *arg)
+{
+	struct v4l2_device *v4l2_dev = sd->v4l2_dev;
+	struct camss *camss = to_camss(v4l2_dev);
+	struct vfe_device *vfe;
+	struct vfe_line *vfe_line;
+	struct csid_device *csid;
+	int evt_data = *(int *)arg;
+
+	if (camss->res->version != CAMSS_8550)
+		return;
+
+	switch (cmd) {
+	case NOTIFY_BUF_DONE:
+		csid = v4l2_get_subdevdata(sd);
+		vfe = &(camss->vfe[csid->id]);
+		if (vfe->ops->event)
+			vfe->ops->event(vfe,
+				NOTIFY_BUF_DONE, (void *)&evt_data);
+		break;
+
+	case NOTIFY_RUP:
+		vfe_line = v4l2_get_subdevdata(sd);
+		vfe = to_vfe(vfe_line);
+		csid = &(camss->csid[vfe->id]);
+
+		if (csid->ops->event)
+			csid->ops->event(csid,
+				NOTIFY_RUP, (void *)&evt_data);
+		break;
+
+	case NOTIFY_RUP_CLEAR:
+		vfe_line = v4l2_get_subdevdata(sd);
+		vfe = to_vfe(vfe_line);
+		csid = &(camss->csid[vfe->id]);
+
+		if (csid->ops->event)
+			csid->ops->event(csid,
+				NOTIFY_RUP_CLEAR, (void *)&evt_data);
+
+		break;
+
+	default:
+		dev_err(camss->dev, "Not supported evt type\n");
+		break;
+	}
+}
+
 /*
  * camss_probe - Probe CAMSS platform device
  * @pdev: Pointer to CAMSS platform device
@@ -1974,6 +2023,7 @@ static int camss_probe(struct platform_device *pdev)
 	media_device_init(&camss->media_dev);
 
 	camss->v4l2_dev.mdev = &camss->media_dev;
+	camss->v4l2_dev.notify = camss_v4l2_subdev_notify;
 	ret = v4l2_device_register(camss->dev, &camss->v4l2_dev);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register V4L2 device: %d\n", ret);
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index 2f63206a8463..f1fe68dedd9e 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -86,6 +86,13 @@ enum icc_count {
 	ICC_SM8250_COUNT = 4,
 };
 
+enum subdev_notify_evt {
+	NOTIFY_BUF_DONE = 0,
+	NOTIFY_RUP,
+	NOTIFY_RUP_CLEAR,
+	NOTIFY_MAX,
+};
+
 struct camss_resources {
 	enum camss_version version;
 	const char *pd_name;
-- 
2.17.1


