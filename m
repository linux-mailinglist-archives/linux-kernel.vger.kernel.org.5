Return-Path: <linux-kernel+bounces-108958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AB4881284
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58B51C22E8A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6574C631;
	Wed, 20 Mar 2024 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NUfTUR4X"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8F048CCD;
	Wed, 20 Mar 2024 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710942179; cv=none; b=L1H/DSiOIbMOkgFNpeXPw1oZ0bYrEh3cg80xE3VutsjgHoaS7alXDjYBRhTt0o8D6HEz5KSFh4uFpRlcmyvRuK8BiJGuAq6kKiMxjEUhB5aXYKZwPlyyiao5E2lZJQp1k5k07v/ekTR2xSnqeBion2S9TShly0P77u6MNuNWo0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710942179; c=relaxed/simple;
	bh=s2/vULG5iS+dEBSt33YSQwB7/yLX65wOU1yR3yAm0aY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTbcx8ND/eei9koJSjjvYdykAEWGTfQlCcFwPFqn/nwgXFJAeuHrPfW0NFBBAxZ8fYLs0+pjzWR9Jj/P+nUf99/YrkFG3vYGTQ0CToXe8wl65ODXzuTlt/MXWpJuI4EQbei/DZPNGEsgtH7ehy7PEBj4gLH9PPTYFQTQZVJpW4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NUfTUR4X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KCVWOG001873;
	Wed, 20 Mar 2024 13:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=zXa8AY6dgeHMO6qUp4Hm
	rmjqvg1owoNbUEMfj2Pg8i8=; b=NUfTUR4XScYB7mP9188Jt9RKK23AG8UWYJqM
	gtabUuBVp6pr0DdtwGXuRo7YP0AC00FO+0tjMyKvjzxhEQ0HF/v998JAFQzOeACi
	4nQyrhOv11NuuaJB7vgYId6cF+svH2vHtUQvFtrExK83ccNA9zVhvM6BIYEElOlv
	mm/uBvs7hqMiW5f5pLBZBxcPEOkg71bB9EE+/zIok8l1GR2T8tC0Yv5zatoiXzk4
	wlXNIVm8ym9XrapMKdX2krr1/QZiX2LqrRWuxB6BhquXexmvucseXhylTFsFYLjt
	HWjBrTU+X961cPwwwt3pRgrB/RrskFfW0ho0XFjqzgcmGULBtw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyyvdg5r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 13:42:53 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KDgqfM032016
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 13:42:52 GMT
Received: from hu-depengs-sha.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 06:42:50 -0700
From: Depeng Shao <quic_depengs@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <quic_yon@quicinc.com>
CC: <quic_depengs@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v1 2/8] media: qcom: camss: Add subdev notify support
Date: Wed, 20 Mar 2024 19:12:21 +0530
Message-ID: <20240320134227.16587-3-quic_depengs@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240320134227.16587-1-quic_depengs@quicinc.com>
References: <20240320134227.16587-1-quic_depengs@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GOnG9dw7Hk-kn6ge0GTFCmZ1e2wnETsi
X-Proofpoint-ORIG-GUID: GOnG9dw7Hk-kn6ge0GTFCmZ1e2wnETsi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200108

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


