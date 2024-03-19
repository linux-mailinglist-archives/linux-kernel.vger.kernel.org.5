Return-Path: <linux-kernel+bounces-107926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279958803A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF311C22B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D712C19B;
	Tue, 19 Mar 2024 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Gmx/kJpR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EA825778;
	Tue, 19 Mar 2024 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870019; cv=none; b=WeUh2SAZfMfEbRwonO47rpcp8ewpxrLfQOrNIukp22whZX8TSyVwgl3mvV4Mm1DtPQvgxYaT+BggWPFhVc3IG7qvNPqMsRuKa8F+wi6RPck2VITHi4Qq4rMDP8bwMPXwp73wGiJDVVcLaBFWvWWy4Qekt0aNCaQ6ry4Du5Ox3kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870019; c=relaxed/simple;
	bh=jAnLr4VK8HmF4IgmXn+2LZ1FW3MAACgnwY0TMuT6GmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inEfIeH1O9LUeqpIua5cMbvQx7UciWeJ11MMyQuPflESeY31UGlguiHvLligoqppQZR+C9euvqyC+AwzyDjFniv2KEoOwQRxrGkmDNFL16oath4cZ+39qdR6duE38J4pnInN2I+XohpE9mQnWuUG1LVb18Rv4ZLDoRbMtg3Kriw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Gmx/kJpR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JHGhpF024469;
	Tue, 19 Mar 2024 17:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=YVYPsAkNtRWqfXmZad873rJa4P5QLCZ6pRnhCihEz2U=; b=Gm
	x/kJpRYsCVgkdzt9mUCcjVPPhCK12T0GLkiYQBxusid8EoizxpFfoXJcw+YcL6yh
	V5at0rdNtJPZVOqSkRRU4uV7S95U+wMb8e1GznlqnSgkvQJzmpySZYGkDagWxhxW
	iU7IBzXIN0GnHzpce63+sJkchaK8oPGrt+2HJkgbPdLcK6eTcXRjZBks9n78HrBj
	iwgl7bQYKx37AMYUgUW4wDgEpbXAipFLPfcHXRgE3kOS8DzE9mP/+RL9ZK9awiE7
	sRgn2DHoZEHE4LKfAqDRn7XvDo1i4tUP6vrQxT2j8cLG+mfyiNs9EXwA/AcLz+ZZ
	9Vi75NnNBgsQC94Pvlag==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy9ee90pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 17:40:07 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JHe6B1000768
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 17:40:06 GMT
Received: from grosikop.eu.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 10:40:02 -0700
From: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <hverkuil-cisco@xs4all.nl>, <quic_hariramp@quicinc.com>
Subject: [PATCH v2 1/8] media: qcom: camss: Add per sub-device type resources
Date: Tue, 19 Mar 2024 19:39:28 +0200
Message-ID: <20240319173935.481-2-quic_grosikop@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319173935.481-1-quic_grosikop@quicinc.com>
References: <20240319173935.481-1-quic_grosikop@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FpSgKzYJh6SfqAbsOciUs012V3opRkGM
X-Proofpoint-ORIG-GUID: FpSgKzYJh6SfqAbsOciUs012V3opRkGM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_07,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190133

From: Radoslav Tsvetkov <quic_rtsvetko@quicinc.com>

Currently resources structure grows with additional parameters required for
each sub-deivce. However each sub-device has some specific resources or
configurations which need to be passed during the initialization.

This change adds per sub-device type structure to simplify the things
and removes the magical void pointer to hw_ops.

Signed-off-by: Radoslav Tsvetkov <quic_rtsvetko@quicinc.com>
---
 .../media/platform/qcom/camss/camss-csid.c    |  22 +-
 .../media/platform/qcom/camss/camss-csid.h    |   7 +-
 .../media/platform/qcom/camss/camss-csiphy.c  |  14 +-
 .../media/platform/qcom/camss/camss-csiphy.h  |   6 +-
 .../media/platform/qcom/camss/camss-vfe-17x.c |  10 +-
 .../media/platform/qcom/camss/camss-vfe-4-1.c |   4 +-
 .../media/platform/qcom/camss/camss-vfe-4-7.c |   6 +-
 .../media/platform/qcom/camss/camss-vfe-4-8.c |   6 +-
 .../platform/qcom/camss/camss-vfe-gen1.c      |   8 +-
 drivers/media/platform/qcom/camss/camss-vfe.c |  54 ++-
 drivers/media/platform/qcom/camss/camss-vfe.h |  11 +-
 drivers/media/platform/qcom/camss/camss.c     | 432 +++++++++++++-----
 drivers/media/platform/qcom/camss/camss.h     |  18 +-
 13 files changed, 402 insertions(+), 196 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index eb27d69e89a1..d1a22e07fdb6 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -202,7 +202,7 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
 
 		enable_irq(csid->irq);
 
-		ret = csid->ops->reset(csid);
+		ret = csid->res->hw_ops->reset(csid);
 		if (ret < 0) {
 			disable_irq(csid->irq);
 			camss_disable_clocks(csid->nclocks, csid->clock);
@@ -212,7 +212,7 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
 			return ret;
 		}
 
-		csid->ops->hw_version(csid);
+		csid->res->hw_ops->hw_version(csid);
 	} else {
 		disable_irq(csid->irq);
 		camss_disable_clocks(csid->nclocks, csid->clock);
@@ -253,7 +253,7 @@ static int csid_set_stream(struct v4l2_subdev *sd, int enable)
 	}
 
 	if (csid->phy.need_vc_update) {
-		csid->ops->configure_stream(csid, enable);
+		csid->res->hw_ops->configure_stream(csid, enable);
 		csid->phy.need_vc_update = false;
 	}
 
@@ -325,7 +325,7 @@ static void csid_try_format(struct csid_device *csid,
 
 			*fmt = *__csid_get_format(csid, sd_state,
 						      MSM_CSID_PAD_SINK, which);
-			fmt->code = csid->ops->src_pad_code(csid, fmt->code, 0, code);
+			fmt->code = csid->res->hw_ops->src_pad_code(csid, fmt->code, 0, code);
 		} else {
 			/* Test generator is enabled, set format on source */
 			/* pad to allow test generator usage */
@@ -375,8 +375,8 @@ static int csid_enum_mbus_code(struct v4l2_subdev *sd,
 						     MSM_CSID_PAD_SINK,
 						     code->which);
 
-			code->code = csid->ops->src_pad_code(csid, sink_fmt->code,
-						       code->index, 0);
+			code->code = csid->res->hw_ops->src_pad_code(csid, sink_fmt->code,
+								     code->index, 0);
 			if (!code->code)
 				return -EINVAL;
 		} else {
@@ -529,7 +529,7 @@ static int csid_set_test_pattern(struct csid_device *csid, s32 value)
 
 	tg->enabled = !!value;
 
-	return csid->ops->configure_testgen_pattern(csid, value);
+	return csid->res->hw_ops->configure_testgen_pattern(csid, value);
 }
 
 /*
@@ -575,9 +575,9 @@ int msm_csid_subdev_init(struct camss *camss, struct csid_device *csid,
 
 	csid->camss = camss;
 	csid->id = id;
-	csid->ops = res->ops;
+	csid->res = &res->csid;
 
-	csid->ops->subdev_init(csid);
+	csid->res->hw_ops->subdev_init(csid);
 
 	/* Memory */
 
@@ -605,7 +605,7 @@ int msm_csid_subdev_init(struct camss *camss, struct csid_device *csid,
 	csid->irq = ret;
 	snprintf(csid->irq_name, sizeof(csid->irq_name), "%s_%s%d",
 		 dev_name(dev), MSM_CSID_NAME, csid->id);
-	ret = devm_request_irq(dev, csid->irq, csid->ops->isr,
+	ret = devm_request_irq(dev, csid->irq, csid->res->hw_ops->isr,
 			       IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN,
 			       csid->irq_name, csid);
 	if (ret < 0) {
@@ -899,5 +899,5 @@ void msm_csid_unregister_entity(struct csid_device *csid)
 
 inline bool csid_is_lite(struct csid_device *csid)
 {
-	return csid->camss->res->csid_res[csid->id].is_lite;
+	return csid->camss->res->csid_res[csid->id].csid.is_lite;
 }
diff --git a/drivers/media/platform/qcom/camss/camss-csid.h b/drivers/media/platform/qcom/camss/camss-csid.h
index fddccb69da13..8d2971aa9ef8 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.h
+++ b/drivers/media/platform/qcom/camss/camss-csid.h
@@ -149,6 +149,11 @@ struct csid_hw_ops {
 	void (*subdev_init)(struct csid_device *csid);
 };
 
+struct csid_subdev_resources {
+	bool is_lite;
+	const struct csid_hw_ops *hw_ops;
+};
+
 struct csid_device {
 	struct camss *camss;
 	u8 id;
@@ -169,7 +174,7 @@ struct csid_device {
 	struct v4l2_ctrl *testgen_mode;
 	const struct csid_format *formats;
 	unsigned int nformats;
-	const struct csid_hw_ops *ops;
+	const struct csid_subdev_resources *res;
 };
 
 struct camss_subdev_resources;
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index 45b3a8e5dea4..f26ddf1af9d4 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -216,9 +216,9 @@ static int csiphy_set_power(struct v4l2_subdev *sd, int on)
 
 		enable_irq(csiphy->irq);
 
-		csiphy->ops->reset(csiphy);
+		csiphy->res->hw_ops->reset(csiphy);
 
-		csiphy->ops->hw_version_read(csiphy, dev);
+		csiphy->res->hw_ops->hw_version_read(csiphy, dev);
 	} else {
 		disable_irq(csiphy->irq);
 
@@ -243,7 +243,7 @@ static int csiphy_stream_on(struct csiphy_device *csiphy)
 {
 	struct csiphy_config *cfg = &csiphy->cfg;
 	s64 link_freq;
-	u8 lane_mask = csiphy->ops->get_lane_mask(&cfg->csi2->lane_cfg);
+	u8 lane_mask = csiphy->res->hw_ops->get_lane_mask(&cfg->csi2->lane_cfg);
 	u8 bpp = csiphy_get_bpp(csiphy->formats, csiphy->nformats,
 				csiphy->fmt[MSM_CSIPHY_PAD_SINK].code);
 	u8 num_lanes = csiphy->cfg.csi2->lane_cfg.num_data;
@@ -272,7 +272,7 @@ static int csiphy_stream_on(struct csiphy_device *csiphy)
 		wmb();
 	}
 
-	csiphy->ops->lanes_enable(csiphy, cfg, link_freq, lane_mask);
+	csiphy->res->hw_ops->lanes_enable(csiphy, cfg, link_freq, lane_mask);
 
 	return 0;
 }
@@ -285,7 +285,7 @@ static int csiphy_stream_on(struct csiphy_device *csiphy)
  */
 static void csiphy_stream_off(struct csiphy_device *csiphy)
 {
-	csiphy->ops->lanes_disable(csiphy, &csiphy->cfg);
+	csiphy->res->hw_ops->lanes_disable(csiphy, &csiphy->cfg);
 }
 
 
@@ -564,7 +564,7 @@ int msm_csiphy_subdev_init(struct camss *camss,
 	csiphy->camss = camss;
 	csiphy->id = id;
 	csiphy->cfg.combo_mode = 0;
-	csiphy->ops = res->ops;
+	csiphy->res = &res->csiphy;
 
 	switch (camss->res->version) {
 	case CAMSS_8x16:
@@ -610,7 +610,7 @@ int msm_csiphy_subdev_init(struct camss *camss,
 	snprintf(csiphy->irq_name, sizeof(csiphy->irq_name), "%s_%s%d",
 		 dev_name(dev), MSM_CSIPHY_NAME, csiphy->id);
 
-	ret = devm_request_irq(dev, csiphy->irq, csiphy->ops->isr,
+	ret = devm_request_irq(dev, csiphy->irq, csiphy->res->hw_ops->isr,
 			       IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN,
 			       csiphy->irq_name, csiphy);
 	if (ret < 0) {
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.h b/drivers/media/platform/qcom/camss/camss-csiphy.h
index c9b7fe82b1f0..7bd68129ca49 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.h
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.h
@@ -63,6 +63,10 @@ struct csiphy_hw_ops {
 	irqreturn_t (*isr)(int irq, void *dev);
 };
 
+struct csiphy_subdev_resources {
+	const struct csiphy_hw_ops *hw_ops;
+};
+
 struct csiphy_device {
 	struct camss *camss;
 	u8 id;
@@ -78,7 +82,7 @@ struct csiphy_device {
 	u32 timer_clk_rate;
 	struct csiphy_config cfg;
 	struct v4l2_mbus_framefmt fmt[MSM_CSIPHY_PADS_NUM];
-	const struct csiphy_hw_ops *ops;
+	const struct csiphy_subdev_resources *res;
 	const struct csiphy_format *formats;
 	unsigned int nformats;
 };
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-17x.c b/drivers/media/platform/qcom/camss/camss-vfe-17x.c
index 795ac3815339..380c99321030 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-17x.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-17x.c
@@ -353,7 +353,7 @@ static irqreturn_t vfe_isr(int irq, void *dev)
 	writel_relaxed(status0, vfe->base + VFE_IRQ_CLEAR_0);
 	writel_relaxed(status1, vfe->base + VFE_IRQ_CLEAR_1);
 
-	for (i = VFE_LINE_RDI0; i < vfe->line_num; i++) {
+	for (i = VFE_LINE_RDI0; i < vfe->res->line_num; i++) {
 		vfe_bus_status[i] = readl_relaxed(vfe->base + VFE_BUS_IRQ_STATUS(i));
 		writel_relaxed(vfe_bus_status[i], vfe->base + VFE_BUS_IRQ_CLEAR(i));
 	}
@@ -367,11 +367,11 @@ static irqreturn_t vfe_isr(int irq, void *dev)
 	if (status0 & STATUS_0_RESET_ACK)
 		vfe->isr_ops.reset_ack(vfe);
 
-	for (i = VFE_LINE_RDI0; i < vfe->line_num; i++)
+	for (i = VFE_LINE_RDI0; i < vfe->res->line_num; i++)
 		if (status0 & STATUS_0_RDI_REG_UPDATE(i))
 			vfe->isr_ops.reg_update(vfe, i);
 
-	for (i = VFE_LINE_RDI0; i < vfe->line_num; i++)
+	for (i = VFE_LINE_RDI0; i < vfe->res->line_num; i++)
 		if (status0 & STATUS_1_RDI_SOF(i))
 			vfe->isr_ops.sof(vfe, i);
 
@@ -442,7 +442,7 @@ static int vfe_enable_output(struct vfe_line *line)
 {
 	struct vfe_device *vfe = to_vfe(line);
 	struct vfe_output *output = &line->output;
-	const struct vfe_hw_ops *ops = vfe->ops;
+	const struct vfe_hw_ops *ops = vfe->res->hw_ops;
 	struct media_entity *sensor;
 	unsigned long flags;
 	unsigned int frame_skip = 0;
@@ -560,7 +560,7 @@ static void vfe_isr_reg_update(struct vfe_device *vfe, enum vfe_line_id line_id)
 	unsigned long flags;
 
 	spin_lock_irqsave(&vfe->output_lock, flags);
-	vfe->ops->reg_update_clear(vfe, line_id);
+	vfe->res->hw_ops->reg_update_clear(vfe, line_id);
 
 	output = &vfe->line[line_id].output;
 
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
index ef6b34c915df..1bd3a6ef1d04 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
@@ -892,7 +892,7 @@ static irqreturn_t vfe_isr(int irq, void *dev)
 	u32 value0, value1;
 	int i, j;
 
-	vfe->ops->isr_read(vfe, &value0, &value1);
+	vfe->res->hw_ops->isr_read(vfe, &value0, &value1);
 
 	dev_dbg(vfe->camss->dev, "VFE: status0 = 0x%08x, status1 = 0x%08x\n",
 		value0, value1);
@@ -901,7 +901,7 @@ static irqreturn_t vfe_isr(int irq, void *dev)
 		vfe->isr_ops.reset_ack(vfe);
 
 	if (value1 & VFE_0_IRQ_STATUS_1_VIOLATION)
-		vfe->ops->violation_read(vfe);
+		vfe->res->hw_ops->violation_read(vfe);
 
 	if (value1 & VFE_0_IRQ_STATUS_1_BUS_BDG_HALT_ACK)
 		vfe->isr_ops.halt_ack(vfe);
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
index 7655d22a9fda..ce0719106bd3 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
@@ -1050,7 +1050,7 @@ static irqreturn_t vfe_isr(int irq, void *dev)
 	u32 value0, value1;
 	int i, j;
 
-	vfe->ops->isr_read(vfe, &value0, &value1);
+	vfe->res->hw_ops->isr_read(vfe, &value0, &value1);
 
 	dev_dbg(vfe->camss->dev, "VFE: status0 = 0x%08x, status1 = 0x%08x\n",
 		value0, value1);
@@ -1059,12 +1059,12 @@ static irqreturn_t vfe_isr(int irq, void *dev)
 		vfe->isr_ops.reset_ack(vfe);
 
 	if (value1 & VFE_0_IRQ_STATUS_1_VIOLATION)
-		vfe->ops->violation_read(vfe);
+		vfe->res->hw_ops->violation_read(vfe);
 
 	if (value1 & VFE_0_IRQ_STATUS_1_BUS_BDG_HALT_ACK)
 		vfe->isr_ops.halt_ack(vfe);
 
-	for (i = VFE_LINE_RDI0; i < vfe->line_num; i++)
+	for (i = VFE_LINE_RDI0; i < vfe->res->line_num; i++)
 		if (value0 & VFE_0_IRQ_STATUS_0_line_n_REG_UPDATE(i))
 			vfe->isr_ops.reg_update(vfe, i);
 
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
index f52fa30f3853..6b59c8107a3c 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
@@ -980,7 +980,7 @@ static irqreturn_t vfe_isr(int irq, void *dev)
 	u32 value0, value1;
 	int i, j;
 
-	vfe->ops->isr_read(vfe, &value0, &value1);
+	vfe->res->hw_ops->isr_read(vfe, &value0, &value1);
 
 	dev_dbg(vfe->camss->dev, "VFE: status0 = 0x%08x, status1 = 0x%08x\n",
 		value0, value1);
@@ -989,12 +989,12 @@ static irqreturn_t vfe_isr(int irq, void *dev)
 		vfe->isr_ops.reset_ack(vfe);
 
 	if (value1 & VFE_0_IRQ_STATUS_1_VIOLATION)
-		vfe->ops->violation_read(vfe);
+		vfe->res->hw_ops->violation_read(vfe);
 
 	if (value1 & VFE_0_IRQ_STATUS_1_BUS_BDG_HALT_ACK)
 		vfe->isr_ops.halt_ack(vfe);
 
-	for (i = VFE_LINE_RDI0; i < vfe->line_num; i++)
+	for (i = VFE_LINE_RDI0; i < vfe->res->line_num; i++)
 		if (value0 & VFE_0_IRQ_STATUS_0_line_n_REG_UPDATE(i))
 			vfe->isr_ops.reg_update(vfe, i);
 
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-gen1.c b/drivers/media/platform/qcom/camss/camss-vfe-gen1.c
index 239d3d4ac666..eb33c03df27e 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-gen1.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-gen1.c
@@ -37,7 +37,7 @@ static int vfe_disable_output(struct vfe_line *line)
 {
 	struct vfe_device *vfe = to_vfe(line);
 	struct vfe_output *output = &line->output;
-	const struct vfe_hw_ops *ops = vfe->ops;
+	const struct vfe_hw_ops *ops = vfe->res->hw_ops;
 	unsigned long flags;
 	unsigned long time;
 	unsigned int i;
@@ -162,14 +162,14 @@ static void vfe_output_frame_drop(struct vfe_device *vfe,
 		vfe->ops_gen1->wm_set_framedrop_pattern(vfe, output->wm_idx[i], drop_pattern);
 	}
 
-	vfe->ops->reg_update(vfe, container_of(output, struct vfe_line, output)->id);
+	vfe->res->hw_ops->reg_update(vfe, container_of(output, struct vfe_line, output)->id);
 }
 
 static int vfe_enable_output(struct vfe_line *line)
 {
 	struct vfe_device *vfe = to_vfe(line);
 	struct vfe_output *output = &line->output;
-	const struct vfe_hw_ops *ops = vfe->ops;
+	const struct vfe_hw_ops *ops = vfe->res->hw_ops;
 	struct media_entity *sensor;
 	unsigned long flags;
 	unsigned int frame_skip = 0;
@@ -545,7 +545,7 @@ static void vfe_isr_reg_update(struct vfe_device *vfe, enum vfe_line_id line_id)
 	unsigned long flags;
 
 	spin_lock_irqsave(&vfe->output_lock, flags);
-	vfe->ops->reg_update_clear(vfe, line_id);
+	vfe->res->hw_ops->reg_update_clear(vfe, line_id);
 
 	output = &line->output;
 
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index d875237cf244..459c70a4b319 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -296,7 +296,7 @@ int vfe_reset(struct vfe_device *vfe)
 
 	reinit_completion(&vfe->reset_complete);
 
-	vfe->ops->global_reset(vfe);
+	vfe->res->hw_ops->global_reset(vfe);
 
 	time = wait_for_completion_timeout(&vfe->reset_complete,
 		msecs_to_jiffies(VFE_RESET_TIMEOUT_MS));
@@ -312,7 +312,7 @@ static void vfe_init_outputs(struct vfe_device *vfe)
 {
 	int i;
 
-	for (i = 0; i < vfe->line_num; i++) {
+	for (i = 0; i < vfe->res->line_num; i++) {
 		struct vfe_output *output = &vfe->line[i].output;
 
 		output->state = VFE_OUTPUT_OFF;
@@ -421,7 +421,7 @@ static int vfe_disable_output(struct vfe_line *line)
 
 	spin_lock_irqsave(&vfe->output_lock, flags);
 	for (i = 0; i < output->wm_num; i++)
-		vfe->ops->vfe_wm_stop(vfe, output->wm_idx[i]);
+		vfe->res->hw_ops->vfe_wm_stop(vfe, output->wm_idx[i]);
 	output->gen2.active_num = 0;
 	spin_unlock_irqrestore(&vfe->output_lock, flags);
 
@@ -537,7 +537,7 @@ static int vfe_set_clock_rates(struct vfe_device *vfe)
 	int i, j;
 	int ret;
 
-	for (i = VFE_LINE_RDI0; i < vfe->line_num; i++) {
+	for (i = VFE_LINE_RDI0; i < vfe->res->line_num; i++) {
 		ret = camss_get_pixel_clock(&vfe->line[i].subdev.entity,
 					    &pixel_clock[i]);
 		if (ret)
@@ -551,7 +551,7 @@ static int vfe_set_clock_rates(struct vfe_device *vfe)
 			u64 min_rate = 0;
 			long rate;
 
-			for (j = VFE_LINE_RDI0; j < vfe->line_num; j++) {
+			for (j = VFE_LINE_RDI0; j < vfe->res->line_num; j++) {
 				u32 tmp;
 				u8 bpp;
 
@@ -618,7 +618,7 @@ static int vfe_check_clock_rates(struct vfe_device *vfe)
 	int i, j;
 	int ret;
 
-	for (i = VFE_LINE_RDI0; i < vfe->line_num; i++) {
+	for (i = VFE_LINE_RDI0; i < vfe->res->line_num; i++) {
 		ret = camss_get_pixel_clock(&vfe->line[i].subdev.entity,
 					    &pixel_clock[i]);
 		if (ret)
@@ -632,7 +632,7 @@ static int vfe_check_clock_rates(struct vfe_device *vfe)
 			u64 min_rate = 0;
 			unsigned long rate;
 
-			for (j = VFE_LINE_RDI0; j < vfe->line_num; j++) {
+			for (j = VFE_LINE_RDI0; j < vfe->res->line_num; j++) {
 				u32 tmp;
 				u8 bpp;
 
@@ -675,7 +675,7 @@ int vfe_get(struct vfe_device *vfe)
 	mutex_lock(&vfe->power_lock);
 
 	if (vfe->power_count == 0) {
-		ret = vfe->ops->pm_domain_on(vfe);
+		ret = vfe->res->hw_ops->pm_domain_on(vfe);
 		if (ret < 0)
 			goto error_pm_domain;
 
@@ -700,7 +700,7 @@ int vfe_get(struct vfe_device *vfe)
 
 		vfe_init_outputs(vfe);
 
-		vfe->ops->hw_version(vfe);
+		vfe->res->hw_ops->hw_version(vfe);
 	} else {
 		ret = vfe_check_clock_rates(vfe);
 		if (ret < 0)
@@ -718,7 +718,7 @@ int vfe_get(struct vfe_device *vfe)
 error_pm_runtime_get:
 	pm_runtime_put_sync(vfe->camss->dev);
 error_domain_off:
-	vfe->ops->pm_domain_off(vfe);
+	vfe->res->hw_ops->pm_domain_off(vfe);
 
 error_pm_domain:
 	mutex_unlock(&vfe->power_lock);
@@ -740,11 +740,11 @@ void vfe_put(struct vfe_device *vfe)
 	} else if (vfe->power_count == 1) {
 		if (vfe->was_streaming) {
 			vfe->was_streaming = 0;
-			vfe->ops->vfe_halt(vfe);
+			vfe->res->hw_ops->vfe_halt(vfe);
 		}
 		camss_disable_clocks(vfe->nclocks, vfe->clock);
 		pm_runtime_put_sync(vfe->camss->dev);
-		vfe->ops->pm_domain_off(vfe);
+		vfe->res->hw_ops->pm_domain_off(vfe);
 	}
 
 	vfe->power_count--;
@@ -834,12 +834,12 @@ static int vfe_set_stream(struct v4l2_subdev *sd, int enable)
 
 	if (enable) {
 		line->output.state = VFE_OUTPUT_RESERVED;
-		ret = vfe->ops->vfe_enable(line);
+		ret = vfe->res->hw_ops->vfe_enable(line);
 		if (ret < 0)
 			dev_err(vfe->camss->dev,
 				"Failed to enable vfe outputs\n");
 	} else {
-		ret = vfe->ops->vfe_disable(line);
+		ret = vfe->res->hw_ops->vfe_disable(line);
 		if (ret < 0)
 			dev_err(vfe->camss->dev,
 				"Failed to disable vfe outputs\n");
@@ -1376,23 +1376,24 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 	int i, j;
 	int ret;
 
-	vfe->ops = res->ops;
-
-	if (!res->line_num)
+	if (!res->vfe.line_num)
 		return -EINVAL;
 
+	vfe->res = &res->vfe;
+	vfe->res->hw_ops->subdev_init(dev, vfe);
+
 	/* Power domain */
 
-	if (res->pd_name) {
+	if (res->vfe.pd_name) {
 		vfe->genpd = dev_pm_domain_attach_by_name(camss->dev,
-							  res->pd_name);
+							  res->vfe.pd_name);
 		if (IS_ERR(vfe->genpd)) {
 			ret = PTR_ERR(vfe->genpd);
 			return ret;
 		}
 	}
 
-	if (!vfe->genpd && res->has_pd) {
+	if (!vfe->genpd && res->vfe.has_pd) {
 		/*
 		 * Legacy magic index.
 		 * Requires
@@ -1409,9 +1410,6 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 			return PTR_ERR(vfe->genpd);
 	}
 
-	vfe->line_num = res->line_num;
-	vfe->ops->subdev_init(dev, vfe);
-
 	/* Memory */
 
 	vfe->base = devm_platform_ioremap_resource_byname(pdev, res->reg[0]);
@@ -1429,7 +1427,7 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 	vfe->irq = ret;
 	snprintf(vfe->irq_name, sizeof(vfe->irq_name), "%s_%s%d",
 		 dev_name(dev), MSM_VFE_NAME, id);
-	ret = devm_request_irq(dev, vfe->irq, vfe->ops->isr,
+	ret = devm_request_irq(dev, vfe->irq, vfe->res->hw_ops->isr,
 			       IRQF_TRIGGER_RISING, vfe->irq_name, vfe);
 	if (ret < 0) {
 		dev_err(dev, "request_irq failed: %d\n", ret);
@@ -1488,7 +1486,7 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 	vfe->id = id;
 	vfe->reg_update = 0;
 
-	for (i = VFE_LINE_RDI0; i < vfe->line_num; i++) {
+	for (i = VFE_LINE_RDI0; i < vfe->res->line_num; i++) {
 		struct vfe_line *l = &vfe->line[i];
 
 		l->video_out.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
@@ -1636,7 +1634,7 @@ int msm_vfe_register_entities(struct vfe_device *vfe,
 	int ret;
 	int i;
 
-	for (i = 0; i < vfe->line_num; i++) {
+	for (i = 0; i < vfe->res->line_num; i++) {
 		char name[32];
 
 		sd = &vfe->line[i].subdev;
@@ -1743,7 +1741,7 @@ void msm_vfe_unregister_entities(struct vfe_device *vfe)
 	mutex_destroy(&vfe->power_lock);
 	mutex_destroy(&vfe->stream_lock);
 
-	for (i = 0; i < vfe->line_num; i++) {
+	for (i = 0; i < vfe->res->line_num; i++) {
 		struct v4l2_subdev *sd = &vfe->line[i].subdev;
 		struct camss_video *video_out = &vfe->line[i].video_out;
 
@@ -1755,5 +1753,5 @@ void msm_vfe_unregister_entities(struct vfe_device *vfe)
 
 bool vfe_is_lite(struct vfe_device *vfe)
 {
-	return vfe->camss->res->vfe_res[vfe->id].is_lite;
+	return vfe->camss->res->vfe_res[vfe->id].vfe.is_lite;
 }
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.h b/drivers/media/platform/qcom/camss/camss-vfe.h
index 0572c9b08e11..87fc159c48cc 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.h
+++ b/drivers/media/platform/qcom/camss/camss-vfe.h
@@ -126,6 +126,14 @@ struct vfe_isr_ops {
 	void (*wm_done)(struct vfe_device *vfe, u8 wm);
 };
 
+struct vfe_subdev_resources {
+	bool is_lite;
+	u8 line_num;
+	bool has_pd;
+	char *pd_name;
+	const struct vfe_hw_ops *hw_ops;
+};
+
 struct vfe_device {
 	struct camss *camss;
 	u8 id;
@@ -143,10 +151,9 @@ struct vfe_device {
 	spinlock_t output_lock;
 	enum vfe_line_id wm_output_map[MSM_VFE_IMAGE_MASTERS_NUM];
 	struct vfe_line line[VFE_LINE_NUM_MAX];
-	u8 line_num;
 	u32 reg_update;
 	u8 was_streaming;
-	const struct vfe_hw_ops *ops;
+	const struct vfe_subdev_resources *res;
 	const struct vfe_hw_ops_gen1 *ops_gen1;
 	struct vfe_isr_ops isr_ops;
 	struct camss_video_ops video_ops;
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 1923615f0eea..e4ae81dc9a15 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -43,7 +43,10 @@ static const struct camss_subdev_resources csiphy_res_8x16[] = {
 				{ 100000000, 200000000 } },
 		.reg = { "csiphy0", "csiphy0_clk_mux" },
 		.interrupt = { "csiphy0" },
-		.ops = &csiphy_ops_2ph_1_0
+		.type = CAMSS_SUBDEV_TYPE_CSIPHY,
+		.csiphy = {
+			.hw_ops = &csiphy_ops_2ph_1_0
+		}
 	},
 
 	/* CSIPHY1 */
@@ -56,7 +59,10 @@ static const struct camss_subdev_resources csiphy_res_8x16[] = {
 				{ 100000000, 200000000 } },
 		.reg = { "csiphy1", "csiphy1_clk_mux" },
 		.interrupt = { "csiphy1" },
-		.ops = &csiphy_ops_2ph_1_0
+		.type = CAMSS_SUBDEV_TYPE_CSIPHY,
+		.csiphy = {
+			.hw_ops = &csiphy_ops_2ph_1_0
+		}
 	}
 };
 
@@ -76,7 +82,10 @@ static const struct camss_subdev_resources csid_res_8x16[] = {
 				{ 0 } },
 		.reg = { "csid0" },
 		.interrupt = { "csid0" },
-		.ops = &csid_ops_4_1,
+		.type = CAMSS_SUBDEV_TYPE_CSID,
+		.csid = {
+			.hw_ops = &csid_ops_4_1
+		}
 	},
 
 	/* CSID1 */
@@ -94,7 +103,10 @@ static const struct camss_subdev_resources csid_res_8x16[] = {
 				{ 0 } },
 		.reg = { "csid1" },
 		.interrupt = { "csid1" },
-		.ops = &csid_ops_4_1,
+		.type = CAMSS_SUBDEV_TYPE_CSID,
+		.csid = {
+			.hw_ops = &csid_ops_4_1
+		}
 	},
 };
 
@@ -105,8 +117,8 @@ static const struct camss_subdev_resources ispif_res_8x16 = {
 		   "csi1", "csi1_pix", "csi1_rdi" },
 	.clock_for_reset = { "vfe0", "csi_vfe0" },
 	.reg = { "ispif", "csi_clk_mux" },
-	.interrupt = { "ispif" }
-
+	.interrupt = { "ispif" },
+	.type = CAMSS_SUBDEV_TYPE_ISPIF
 };
 
 static const struct camss_subdev_resources vfe_res_8x16[] = {
@@ -128,8 +140,11 @@ static const struct camss_subdev_resources vfe_res_8x16[] = {
 				{ 0 } },
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
-		.line_num = 3,
-		.ops = &vfe_ops_4_1
+		.type = CAMSS_SUBDEV_TYPE_VFE,
+		.vfe = {
+			.line_num = 3,
+			.hw_ops = &vfe_ops_4_1
+		}
 	}
 };
 
@@ -144,7 +159,10 @@ static const struct camss_subdev_resources csiphy_res_8x96[] = {
 				{ 100000000, 200000000, 266666667 } },
 		.reg = { "csiphy0", "csiphy0_clk_mux" },
 		.interrupt = { "csiphy0" },
-		.ops = &csiphy_ops_3ph_1_0
+		.type = CAMSS_SUBDEV_TYPE_CSIPHY,
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0
+		}
 	},
 
 	/* CSIPHY1 */
@@ -157,7 +175,10 @@ static const struct camss_subdev_resources csiphy_res_8x96[] = {
 				{ 100000000, 200000000, 266666667 } },
 		.reg = { "csiphy1", "csiphy1_clk_mux" },
 		.interrupt = { "csiphy1" },
-		.ops = &csiphy_ops_3ph_1_0
+		.type = CAMSS_SUBDEV_TYPE_CSIPHY,
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0
+		}
 	},
 
 	/* CSIPHY2 */
@@ -170,7 +191,10 @@ static const struct camss_subdev_resources csiphy_res_8x96[] = {
 				{ 100000000, 200000000, 266666667 } },
 		.reg = { "csiphy2", "csiphy2_clk_mux" },
 		.interrupt = { "csiphy2" },
-		.ops = &csiphy_ops_3ph_1_0
+		.type = CAMSS_SUBDEV_TYPE_CSIPHY,
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0
+		}
 	}
 };
 
@@ -190,7 +214,10 @@ static const struct camss_subdev_resources csid_res_8x96[] = {
 				{ 0 } },
 		.reg = { "csid0" },
 		.interrupt = { "csid0" },
-		.ops = &csid_ops_4_7,
+		.type = CAMSS_SUBDEV_TYPE_CSID,
+		.csid = {
+			.hw_ops = &csid_ops_4_7
+		}
 	},
 
 	/* CSID1 */
@@ -208,7 +235,10 @@ static const struct camss_subdev_resources csid_res_8x96[] = {
 				{ 0 } },
 		.reg = { "csid1" },
 		.interrupt = { "csid1" },
-		.ops = &csid_ops_4_7,
+		.type = CAMSS_SUBDEV_TYPE_CSID,
+		.csid = {
+			.hw_ops = &csid_ops_4_7
+		}
 	},
 
 	/* CSID2 */
@@ -226,7 +256,10 @@ static const struct camss_subdev_resources csid_res_8x96[] = {
 				{ 0 } },
 		.reg = { "csid2" },
 		.interrupt = { "csid2" },
-		.ops = &csid_ops_4_7,
+		.type = CAMSS_SUBDEV_TYPE_CSID,
+		.csid = {
+			.hw_ops = &csid_ops_4_7
+		}
 	},
 
 	/* CSID3 */
@@ -244,7 +277,10 @@ static const struct camss_subdev_resources csid_res_8x96[] = {
 				{ 0 } },
 		.reg = { "csid3" },
 		.interrupt = { "csid3" },
-		.ops = &csid_ops_4_7,
+		.type = CAMSS_SUBDEV_TYPE_CSID,
+		.csid = {
+			.hw_ops = &csid_ops_4_7
+		}
 	}
 };
 
@@ -257,7 +293,8 @@ static const struct camss_subdev_resources ispif_res_8x96 = {
 		   "csi3", "csi3_pix", "csi3_rdi" },
 	.clock_for_reset = { "vfe0", "csi_vfe0", "vfe1", "csi_vfe1" },
 	.reg = { "ispif", "csi_clk_mux" },
-	.interrupt = { "ispif" }
+	.interrupt = { "ispif" },
+	.type = CAMSS_SUBDEV_TYPE_ISPIF
 };
 
 static const struct camss_subdev_resources vfe_res_8x96[] = {
@@ -277,9 +314,12 @@ static const struct camss_subdev_resources vfe_res_8x96[] = {
 				{ 0 } },
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
-		.line_num = 3,
-		.has_pd = true,
-		.ops = &vfe_ops_4_7
+		.type = CAMSS_SUBDEV_TYPE_VFE,
+		.vfe = {
+			.line_num = 3,
+			.has_pd = true,
+			.hw_ops = &vfe_ops_4_7
+		}
 	},
 
 	/* VFE1 */
@@ -298,9 +338,12 @@ static const struct camss_subdev_resources vfe_res_8x96[] = {
 				{ 0 } },
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
-		.line_num = 3,
-		.has_pd = true,
-		.ops = &vfe_ops_4_7
+		.type = CAMSS_SUBDEV_TYPE_VFE,
+		.vfe = {
+			.line_num = 3,
+			.has_pd = true,
+			.hw_ops = &vfe_ops_4_7
+		}
 	}
 };
 
@@ -317,7 +360,10 @@ static const struct camss_subdev_resources csiphy_res_660[] = {
 				{ 0 } },
 		.reg = { "csiphy0", "csiphy0_clk_mux" },
 		.interrupt = { "csiphy0" },
-		.ops = &csiphy_ops_3ph_1_0
+		.type = CAMSS_SUBDEV_TYPE_CSIPHY,
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0
+		}
 	},
 
 	/* CSIPHY1 */
@@ -332,7 +378,10 @@ static const struct camss_subdev_resources csiphy_res_660[] = {
 				{ 0 } },
 		.reg = { "csiphy1", "csiphy1_clk_mux" },
 		.interrupt = { "csiphy1" },
-		.ops = &csiphy_ops_3ph_1_0
+		.type = CAMSS_SUBDEV_TYPE_CSIPHY,
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0
+		}
 	},
 
 	/* CSIPHY2 */
@@ -347,7 +396,10 @@ static const struct camss_subdev_resources csiphy_res_660[] = {
 				{ 0 } },
 		.reg = { "csiphy2", "csiphy2_clk_mux" },
 		.interrupt = { "csiphy2" },
-		.ops = &csiphy_ops_3ph_1_0
+		.type = CAMSS_SUBDEV_TYPE_CSIPHY,
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0
+		}
 	}
 };
 
@@ -370,7 +422,10 @@ static const struct camss_subdev_resources csid_res_660[] = {
 				{ 0 } },
 		.reg = { "csid0" },
 		.interrupt = { "csid0" },
-		.ops = &csid_ops_4_7,
+		.type = CAMSS_SUBDEV_TYPE_CSID,
+		.csid = {
+			.hw_ops = &csid_ops_4_7
+		}
 	},
 
 	/* CSID1 */
@@ -391,7 +446,10 @@ static const struct camss_subdev_resources csid_res_660[] = {
 				{ 0 } },
 		.reg = { "csid1" },
 		.interrupt = { "csid1" },
-		.ops = &csid_ops_4_7,
+		.type = CAMSS_SUBDEV_TYPE_CSID,
+		.csid = {
+			.hw_ops = &csid_ops_4_7
+		}
 	},
 
 	/* CSID2 */
@@ -412,7 +470,10 @@ static const struct camss_subdev_resources csid_res_660[] = {
 				{ 0 } },
 		.reg = { "csid2" },
 		.interrupt = { "csid2" },
-		.ops = &csid_ops_4_7,
+		.type = CAMSS_SUBDEV_TYPE_CSID,
+		.csid = {
+			.hw_ops = &csid_ops_4_7
+		}
 	},
 
 	/* CSID3 */
@@ -433,7 +494,10 @@ static const struct camss_subdev_resources csid_res_660[] = {
 				{ 0 } },
 		.reg = { "csid3" },
 		.interrupt = { "csid3" },
-		.ops = &csid_ops_4_7,
+		.type = CAMSS_SUBDEV_TYPE_CSID,
+		.csid = {
+			.hw_ops = &csid_ops_4_7
+		}
 	}
 };
 
@@ -446,7 +510,8 @@ static const struct camss_subdev_resources ispif_res_660 = {
 		   "csi3", "csi3_pix", "csi3_rdi" },
 	.clock_for_reset = { "vfe0", "csi_vfe0", "vfe1", "csi_vfe1" },
 	.reg = { "ispif", "csi_clk_mux" },
-	.interrupt = { "ispif" }
+	.interrupt = { "ispif" },
+	.type = CAMSS_SUBDEV_TYPE_ISPIF
 };
 
 static const struct camss_subdev_resources vfe_res_660[] = {
@@ -469,9 +534,12 @@ static const struct camss_subdev_resources vfe_res_660[] = {
 				{ 0 } },
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
-		.line_num = 3,
-		.has_pd = true,
-		.ops = &vfe_ops_4_8
+		.type = CAMSS_SUBDEV_TYPE_VFE,
+		.vfe = {
+			.line_num = 3,
+			.has_pd = true,
+			.hw_ops = &vfe_ops_4_8
+		}
 	},
 
 	/* VFE1 */
@@ -493,9 +561,12 @@ static const struct camss_subdev_resources vfe_res_660[] = {
 				{ 0 } },
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
-		.line_num = 3,
-		.has_pd = true,
-		.ops = &vfe_ops_4_8
+		.type = CAMSS_SUBDEV_TYPE_VFE,
+		.vfe = {
+			.line_num = 3,
+			.has_pd = true,
+			.hw_ops = &vfe_ops_4_8
+		}
 	}
 };
 
@@ -516,7 +587,10 @@ static const struct camss_subdev_resources csiphy_res_845[] = {
 				{ 19200000, 240000000, 269333333 } },
 		.reg = { "csiphy0" },
 		.interrupt = { "csiphy0" },
-		.ops = &csiphy_ops_3ph_1_0
+		.type = CAMSS_SUBDEV_TYPE_CSIPHY,
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0
+		}
 	},
 
 	/* CSIPHY1 */
@@ -535,7 +609,10 @@ static const struct camss_subdev_resources csiphy_res_845[] = {
 				{ 19200000, 240000000, 269333333 } },
 		.reg = { "csiphy1" },
 		.interrupt = { "csiphy1" },
-		.ops = &csiphy_ops_3ph_1_0
+		.type = CAMSS_SUBDEV_TYPE_CSIPHY,
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0
+		}
 	},
 
 	/* CSIPHY2 */
@@ -554,7 +631,10 @@ static const struct camss_subdev_resources csiphy_res_845[] = {
 				{ 19200000, 240000000, 269333333 } },
 		.reg = { "csiphy2" },
 		.interrupt = { "csiphy2" },
-		.ops = &csiphy_ops_3ph_1_0
+		.type = CAMSS_SUBDEV_TYPE_CSIPHY,
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0
+		}
 	},
 
 	/* CSIPHY3 */
@@ -573,7 +653,10 @@ static const struct camss_subdev_resources csiphy_res_845[] = {
 				{ 19200000, 240000000, 269333333 } },
 		.reg = { "csiphy3" },
 		.interrupt = { "csiphy3" },
-		.ops = &csiphy_ops_3ph_1_0
+		.type = CAMSS_SUBDEV_TYPE_CSIPHY,
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0
+		}
 	}
 };
 
@@ -596,7 +679,10 @@ static const struct camss_subdev_resources csid_res_845[] = {
 				{ 384000000 } },
 		.reg = { "csid0" },
 		.interrupt = { "csid0" },
-		.ops = &csid_ops_gen2
+		.type = CAMSS_SUBDEV_TYPE_CSID,
+		.csid = {
+			.hw_ops = &csid_ops_gen2
+		}
 	},
 
 	/* CSID1 */
@@ -617,7 +703,10 @@ static const struct camss_subdev_resources csid_res_845[] = {
 				{ 384000000 } },
 		.reg = { "csid1" },
 		.interrupt = { "csid1" },
-		.ops = &csid_ops_gen2
+		.type = CAMSS_SUBDEV_TYPE_CSID,
+		.csid = {
+			.hw_ops = &csid_ops_gen2
+		}
 	},
 
 	/* CSID2 */
@@ -638,8 +727,11 @@ static const struct camss_subdev_resources csid_res_845[] = {
 				{ 384000000 } },
 		.reg = { "csid2" },
 		.interrupt = { "csid2" },
-		.is_lite = true,
-		.ops = &csid_ops_gen2
+		.type = CAMSS_SUBDEV_TYPE_CSID,
+		.csid = {
+			.is_lite = true,
+			.hw_ops = &csid_ops_gen2
+		}
 	}
 };
 
@@ -662,9 +754,12 @@ static const struct camss_subdev_resources vfe_res_845[] = {
 				{ 384000000 } },
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
-		.line_num = 4,
-		.has_pd = true,
-		.ops = &vfe_ops_170
+		.type = CAMSS_SUBDEV_TYPE_VFE,
+		.vfe = {
+			.line_num = 4,
+			.has_pd = true,
+			.hw_ops = &vfe_ops_170
+		}
 	},
 
 	/* VFE1 */
@@ -685,9 +780,12 @@ static const struct camss_subdev_resources vfe_res_845[] = {
 				{ 384000000 } },
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
-		.line_num = 4,
-		.has_pd = true,
-		.ops = &vfe_ops_170
+		.type = CAMSS_SUBDEV_TYPE_VFE,
+		.vfe = {
+			.line_num = 4,
+			.has_pd = true,
+			.hw_ops = &vfe_ops_170
+		}
 	},
 
 	/* VFE-lite */
@@ -707,9 +805,12 @@ static const struct camss_subdev_resources vfe_res_845[] = {
 				{ 384000000 } },
 		.reg = { "vfe_lite" },
 		.interrupt = { "vfe_lite" },
-		.is_lite = true,
-		.line_num = 4,
-		.ops = &vfe_ops_170
+		.type = CAMSS_SUBDEV_TYPE_VFE,
+		.vfe = {
+			.is_lite = true,
+			.line_num = 4,
+			.hw_ops = &vfe_ops_170
+		}
 	}
 };
 
@@ -722,7 +823,10 @@ static const struct camss_subdev_resources csiphy_res_8250[] = {
 				{ 300000000 } },
 		.reg = { "csiphy0" },
 		.interrupt = { "csiphy0" },
-		.ops = &csiphy_ops_3ph_1_0
+		.type = CAMSS_SUBDEV_TYPE_CSIPHY,
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0
+		}
 	},
 	/* CSIPHY1 */
 	{
@@ -732,7 +836,10 @@ static const struct camss_subdev_resources csiphy_res_8250[] = {
 				{ 300000000 } },
 		.reg = { "csiphy1" },
 		.interrupt = { "csiphy1" },
-		.ops = &csiphy_ops_3ph_1_0
+		.type = CAMSS_SUBDEV_TYPE_CSIPHY,
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0
+		}
 	},
 	/* CSIPHY2 */
 	{
@@ -742,7 +849,10 @@ static const struct camss_subdev_resources csiphy_res_8250[] = {
 				{ 300000000 } },
 		.reg = { "csiphy2" },
 		.interrupt = { "csiphy2" },
-		.ops = &csiphy_ops_3ph_1_0
+		.type = CAMSS_SUBDEV_TYPE_CSIPHY,
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0
+		}
 	},
 	/* CSIPHY3 */
 	{
@@ -752,7 +862,10 @@ static const struct camss_subdev_resources csiphy_res_8250[] = {
 				{ 300000000 } },
 		.reg = { "csiphy3" },
 		.interrupt = { "csiphy3" },
-		.ops = &csiphy_ops_3ph_1_0
+		.type = CAMSS_SUBDEV_TYPE_CSIPHY,
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0
+		}
 	},
 	/* CSIPHY4 */
 	{
@@ -762,7 +875,10 @@ static const struct camss_subdev_resources csiphy_res_8250[] = {
 				{ 300000000 } },
 		.reg = { "csiphy4" },
 		.interrupt = { "csiphy4" },
-		.ops = &csiphy_ops_3ph_1_0
+		.type = CAMSS_SUBDEV_TYPE_CSIPHY,
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0
+		}
 	},
 	/* CSIPHY5 */
 	{
@@ -772,7 +888,10 @@ static const struct camss_subdev_resources csiphy_res_8250[] = {
 				{ 300000000 } },
 		.reg = { "csiphy5" },
 		.interrupt = { "csiphy5" },
-		.ops = &csiphy_ops_3ph_1_0
+		.type = CAMSS_SUBDEV_TYPE_CSIPHY,
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0
+		}
 	}
 };
 
@@ -788,7 +907,10 @@ static const struct camss_subdev_resources csid_res_8250[] = {
 				{ 0 } },
 		.reg = { "csid0" },
 		.interrupt = { "csid0" },
-		.ops = &csid_ops_gen2
+		.type = CAMSS_SUBDEV_TYPE_CSID,
+		.csid = {
+			.hw_ops = &csid_ops_gen2
+		}
 	},
 	/* CSID1 */
 	{
@@ -801,7 +923,10 @@ static const struct camss_subdev_resources csid_res_8250[] = {
 				{ 0 } },
 		.reg = { "csid1" },
 		.interrupt = { "csid1" },
-		.ops = &csid_ops_gen2
+		.type = CAMSS_SUBDEV_TYPE_CSID,
+		.csid = {
+			.hw_ops = &csid_ops_gen2
+		}
 	},
 	/* CSID2 */
 	{
@@ -813,8 +938,11 @@ static const struct camss_subdev_resources csid_res_8250[] = {
 				{ 0 } },
 		.reg = { "csid2" },
 		.interrupt = { "csid2" },
-		.is_lite = true,
-		.ops = &csid_ops_gen2
+		.type = CAMSS_SUBDEV_TYPE_CSID,
+		.csid = {
+			.is_lite = true,
+			.hw_ops = &csid_ops_gen2
+		}
 	},
 	/* CSID3 */
 	{
@@ -826,8 +954,11 @@ static const struct camss_subdev_resources csid_res_8250[] = {
 				{ 0 } },
 		.reg = { "csid3" },
 		.interrupt = { "csid3" },
-		.is_lite = true,
-		.ops = &csid_ops_gen2
+		.type = CAMSS_SUBDEV_TYPE_CSID,
+		.csid = {
+			.is_lite = true,
+			.hw_ops = &csid_ops_gen2
+		}
 	}
 };
 
@@ -849,10 +980,13 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 				{ 0 } },
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
-		.pd_name = "ife0",
-		.line_num = 3,
-		.has_pd = true,
-		.ops = &vfe_ops_480
+		.type = CAMSS_SUBDEV_TYPE_VFE,
+		.vfe = {
+			.line_num = 3,
+			.has_pd = true,
+			.pd_name = "ife0",
+			.hw_ops = &vfe_ops_480
+		}
 	},
 	/* VFE1 */
 	{
@@ -871,10 +1005,13 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 				{ 0 } },
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
-		.pd_name = "ife1",
-		.line_num = 3,
-		.has_pd = true,
-		.ops = &vfe_ops_480
+		.type = CAMSS_SUBDEV_TYPE_VFE,
+		.vfe = {
+			.line_num = 3,
+			.has_pd = true,
+			.pd_name = "ife1",
+			.hw_ops = &vfe_ops_480
+		}
 	},
 	/* VFE2 (lite) */
 	{
@@ -892,9 +1029,12 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 				{ 0 } },
 		.reg = { "vfe_lite0" },
 		.interrupt = { "vfe_lite0" },
-		.is_lite = true,
-		.line_num = 4,
-		.ops = &vfe_ops_480
+		.type = CAMSS_SUBDEV_TYPE_VFE,
+		.vfe = {
+			.is_lite = true,
+			.line_num = 4,
+			.hw_ops = &vfe_ops_480
+		}
 	},
 	/* VFE3 (lite) */
 	{
@@ -912,9 +1052,12 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 				{ 0 } },
 		.reg = { "vfe_lite1" },
 		.interrupt = { "vfe_lite1" },
-		.is_lite = true,
-		.line_num = 4,
-		.ops = &vfe_ops_480
+		.type = CAMSS_SUBDEV_TYPE_VFE,
+		.vfe = {
+			.is_lite = true,
+			.line_num = 4,
+			.hw_ops = &vfe_ops_480
+		}
 	},
 };
 
@@ -950,7 +1093,10 @@ static const struct camss_subdev_resources csiphy_res_sc8280xp[] = {
 				{ 300000000 } },
 		.reg = { "csiphy0" },
 		.interrupt = { "csiphy0" },
-		.ops = &csiphy_ops_3ph_1_0
+		.type = CAMSS_SUBDEV_TYPE_CSIPHY,
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0
+		}
 	},
 	/* CSIPHY1 */
 	{
@@ -960,7 +1106,9 @@ static const struct camss_subdev_resources csiphy_res_sc8280xp[] = {
 				{ 300000000 } },
 		.reg = { "csiphy1" },
 		.interrupt = { "csiphy1" },
-		.ops = &csiphy_ops_3ph_1_0
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0
+		}
 	},
 	/* CSIPHY2 */
 	{
@@ -970,7 +1118,9 @@ static const struct camss_subdev_resources csiphy_res_sc8280xp[] = {
 				{ 300000000 } },
 		.reg = { "csiphy2" },
 		.interrupt = { "csiphy2" },
-		.ops = &csiphy_ops_3ph_1_0
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0
+		}
 	},
 	/* CSIPHY3 */
 	{
@@ -980,7 +1130,9 @@ static const struct camss_subdev_resources csiphy_res_sc8280xp[] = {
 				{ 300000000 } },
 		.reg = { "csiphy3" },
 		.interrupt = { "csiphy3" },
-		.ops = &csiphy_ops_3ph_1_0
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0
+		}
 	},
 };
 
@@ -995,7 +1147,9 @@ static const struct camss_subdev_resources csid_res_sc8280xp[] = {
 				{ 0 } },
 		.reg = { "csid0" },
 		.interrupt = { "csid0" },
-		.ops = &csid_ops_gen2
+		.csid = {
+			.hw_ops = &csid_ops_gen2
+		}
 	},
 	/* CSID1 */
 	{
@@ -1007,7 +1161,9 @@ static const struct camss_subdev_resources csid_res_sc8280xp[] = {
 				{ 0 } },
 		.reg = { "csid1" },
 		.interrupt = { "csid1" },
-		.ops = &csid_ops_gen2
+		.csid = {
+			.hw_ops = &csid_ops_gen2
+		}
 	},
 	/* CSID2 */
 	{
@@ -1019,7 +1175,9 @@ static const struct camss_subdev_resources csid_res_sc8280xp[] = {
 				{ 0 } },
 		.reg = { "csid2" },
 		.interrupt = { "csid2" },
-		.ops = &csid_ops_gen2
+		.csid = {
+			.hw_ops = &csid_ops_gen2
+		}
 	},
 	/* CSID3 */
 	{
@@ -1031,7 +1189,9 @@ static const struct camss_subdev_resources csid_res_sc8280xp[] = {
 				{ 0 } },
 		.reg = { "csid3" },
 		.interrupt = { "csid3" },
-		.ops = &csid_ops_gen2
+		.csid = {
+			.hw_ops = &csid_ops_gen2
+		}
 	},
 	/* CSID_LITE0 */
 	{
@@ -1042,8 +1202,10 @@ static const struct camss_subdev_resources csid_res_sc8280xp[] = {
 				{ 0 }, },
 		.reg = { "csid0_lite" },
 		.interrupt = { "csid0_lite" },
-		.is_lite = true,
-		.ops = &csid_ops_gen2
+		.csid = {
+			.is_lite = true,
+			.hw_ops = &csid_ops_gen2
+		}
 	},
 	/* CSID_LITE1 */
 	{
@@ -1054,8 +1216,10 @@ static const struct camss_subdev_resources csid_res_sc8280xp[] = {
 				{ 0 }, },
 		.reg = { "csid1_lite" },
 		.interrupt = { "csid1_lite" },
-		.is_lite = true,
-		.ops = &csid_ops_gen2
+		.csid = {
+			.is_lite = true,
+			.hw_ops = &csid_ops_gen2
+		}
 	},
 	/* CSID_LITE2 */
 	{
@@ -1066,8 +1230,10 @@ static const struct camss_subdev_resources csid_res_sc8280xp[] = {
 				{ 0 }, },
 		.reg = { "csid2_lite" },
 		.interrupt = { "csid2_lite" },
-		.is_lite = true,
-		.ops = &csid_ops_gen2
+		.csid = {
+			.is_lite = true,
+			.hw_ops = &csid_ops_gen2
+		}
 	},
 	/* CSID_LITE3 */
 	{
@@ -1078,8 +1244,10 @@ static const struct camss_subdev_resources csid_res_sc8280xp[] = {
 				{ 0 }, },
 		.reg = { "csid3_lite" },
 		.interrupt = { "csid3_lite" },
-		.is_lite = true,
-		.ops = &csid_ops_gen2
+		.csid = {
+			.is_lite = true,
+			.hw_ops = &csid_ops_gen2
+		}
 	}
 };
 
@@ -1096,9 +1264,11 @@ static const struct camss_subdev_resources vfe_res_sc8280xp[] = {
 				{ 0 }, },
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
-		.pd_name = "ife0",
-		.line_num = 4,
-		.ops = &vfe_ops_170
+		.vfe = {
+			.line_num = 4,
+			.pd_name = "ife0",
+			.hw_ops = &vfe_ops_170
+		}
 	},
 	/* VFE1 */
 	{
@@ -1112,9 +1282,11 @@ static const struct camss_subdev_resources vfe_res_sc8280xp[] = {
 				{ 0 }, },
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
-		.pd_name = "ife1",
-		.line_num = 4,
-		.ops = &vfe_ops_170
+		.vfe = {
+			.line_num = 4,
+			.pd_name = "ife1",
+			.hw_ops = &vfe_ops_170
+		}
 	},
 	/* VFE2 */
 	{
@@ -1128,9 +1300,11 @@ static const struct camss_subdev_resources vfe_res_sc8280xp[] = {
 				{ 0 }, },
 		.reg = { "vfe2" },
 		.interrupt = { "vfe2" },
-		.pd_name = "ife2",
-		.line_num = 4,
-		.ops = &vfe_ops_170
+		.vfe = {
+			.line_num = 4,
+			.pd_name = "ife2",
+			.hw_ops = &vfe_ops_170
+		}
 	},
 	/* VFE3 */
 	{
@@ -1144,9 +1318,11 @@ static const struct camss_subdev_resources vfe_res_sc8280xp[] = {
 				{ 0 }, },
 		.reg = { "vfe3" },
 		.interrupt = { "vfe3" },
-		.pd_name = "ife3",
-		.line_num = 4,
-		.ops = &vfe_ops_170
+		.vfe = {
+			.line_num = 4,
+			.pd_name = "ife3",
+			.hw_ops = &vfe_ops_170
+		}
 	},
 	/* VFE_LITE_0 */
 	{
@@ -1159,9 +1335,11 @@ static const struct camss_subdev_resources vfe_res_sc8280xp[] = {
 				{ 320000000, 400000000, 480000000, 600000000 }, },
 		.reg = { "vfe_lite0" },
 		.interrupt = { "vfe_lite0" },
-		.is_lite = true,
-		.line_num = 4,
-		.ops = &vfe_ops_170
+		.vfe = {
+			.is_lite = true,
+			.line_num = 4,
+			.hw_ops = &vfe_ops_170
+		}
 	},
 	/* VFE_LITE_1 */
 	{
@@ -1174,9 +1352,11 @@ static const struct camss_subdev_resources vfe_res_sc8280xp[] = {
 				{ 320000000, 400000000, 480000000, 600000000 }, },
 		.reg = { "vfe_lite1" },
 		.interrupt = { "vfe_lite1" },
-		.is_lite = true,
-		.line_num = 4,
-		.ops = &vfe_ops_170
+		.vfe = {
+			.is_lite = true,
+			.line_num = 4,
+			.hw_ops = &vfe_ops_170
+		}
 	},
 	/* VFE_LITE_2 */
 	{
@@ -1189,9 +1369,11 @@ static const struct camss_subdev_resources vfe_res_sc8280xp[] = {
 				{ 320000000, 400000000, 480000000, 600000000, }, },
 		.reg = { "vfe_lite2" },
 		.interrupt = { "vfe_lite2" },
-		.is_lite = true,
-		.line_num = 4,
-		.ops = &vfe_ops_170
+		.vfe = {
+			.is_lite = true,
+			.line_num = 4,
+			.hw_ops = &vfe_ops_170
+		}
 	},
 	/* VFE_LITE_3 */
 	{
@@ -1204,9 +1386,11 @@ static const struct camss_subdev_resources vfe_res_sc8280xp[] = {
 				{ 320000000, 400000000, 480000000, 600000000 }, },
 		.reg = { "vfe_lite3" },
 		.interrupt = { "vfe_lite3" },
-		.is_lite = true,
-		.line_num = 4,
-		.ops = &vfe_ops_170
+		.vfe = {
+			.is_lite = true,
+			.line_num = 4,
+			.hw_ops = &vfe_ops_170
+		}
 	},
 };
 
@@ -1375,7 +1559,7 @@ int camss_pm_domain_on(struct camss *camss, int id)
 	if (id < camss->res->vfe_num) {
 		struct vfe_device *vfe = &camss->vfe[id];
 
-		ret = vfe->ops->pm_domain_on(vfe);
+		ret = vfe->res->hw_ops->pm_domain_on(vfe);
 	}
 
 	return ret;
@@ -1386,7 +1570,7 @@ void camss_pm_domain_off(struct camss *camss, int id)
 	if (id < camss->res->vfe_num) {
 		struct vfe_device *vfe = &camss->vfe[id];
 
-		vfe->ops->pm_domain_off(vfe);
+		vfe->res->hw_ops->pm_domain_off(vfe);
 	}
 }
 
@@ -1628,7 +1812,7 @@ static int camss_register_entities(struct camss *camss)
 
 		for (i = 0; i < camss->ispif->line_num; i++)
 			for (k = 0; k < camss->res->vfe_num; k++)
-				for (j = 0; j < camss->vfe[k].line_num; j++) {
+				for (j = 0; j < camss->vfe[k].res->line_num; j++) {
 					struct v4l2_subdev *ispif = &camss->ispif->line[i].subdev;
 					struct v4l2_subdev *vfe = &camss->vfe[k].line[j].subdev;
 
@@ -1649,7 +1833,7 @@ static int camss_register_entities(struct camss *camss)
 	} else {
 		for (i = 0; i < camss->res->csid_num; i++)
 			for (k = 0; k < camss->res->vfe_num; k++)
-				for (j = 0; j < camss->vfe[k].line_num; j++) {
+				for (j = 0; j < camss->vfe[k].res->line_num; j++) {
 					struct v4l2_subdev *csid = &camss->csid[i].subdev;
 					struct v4l2_subdev *vfe = &camss->vfe[k].line[j].subdev;
 
@@ -1810,7 +1994,7 @@ static int camss_configure_pd(struct camss *camss)
 
 	/* count the # of VFEs which have flagged power-domain */
 	for (vfepd_num = i = 0; i < camss->res->vfe_num; i++) {
-		if (res->vfe_res[i].has_pd)
+		if (res->vfe_res[i].vfe.has_pd)
 			vfepd_num++;
 	}
 
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index ac15fe23a702..2477821dfd85 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -41,6 +41,13 @@
 
 #define CAMSS_RES_MAX 17
 
+enum camss_subdev_type {
+	CAMSS_SUBDEV_TYPE_CSIPHY,
+	CAMSS_SUBDEV_TYPE_CSID,
+	CAMSS_SUBDEV_TYPE_ISPIF,
+	CAMSS_SUBDEV_TYPE_VFE,
+};
+
 struct camss_subdev_resources {
 	char *regulators[CAMSS_RES_MAX];
 	char *clock[CAMSS_RES_MAX];
@@ -48,11 +55,12 @@ struct camss_subdev_resources {
 	u32 clock_rate[CAMSS_RES_MAX][CAMSS_RES_MAX];
 	char *reg[CAMSS_RES_MAX];
 	char *interrupt[CAMSS_RES_MAX];
-	char *pd_name;
-	u8 line_num;
-	bool has_pd;
-	bool is_lite;
-	const void *ops;
+	enum camss_subdev_type type;
+	union {
+		struct csiphy_subdev_resources csiphy;
+		struct csid_subdev_resources csid;
+		struct vfe_subdev_resources vfe;
+	};
 };
 
 struct icc_bw_tbl {
-- 
2.17.1


