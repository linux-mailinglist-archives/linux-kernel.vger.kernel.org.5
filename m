Return-Path: <linux-kernel+bounces-108962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795AD881291
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F05E285582
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B565A53E12;
	Wed, 20 Mar 2024 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lwc8MjsH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9794207A;
	Wed, 20 Mar 2024 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710942191; cv=none; b=Ibo3p9nTdDm0EmnWkWtH2uolnG90xnz7isljFo4CS9OLzGWN7mk/FJG86mZ8ijM8UYmQ07Bt6zUnyrg768u7J4c7/+xvpNsZ2Ghu32mW2DM7ieZ7h14vXV+wpRC5MG61vWnUQ1fUVMZdRH8WaoYWETJZCWqD5j+ZaEP/EX8f+bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710942191; c=relaxed/simple;
	bh=2RRMTcXuGJx4uBvk16/f7UPVO87sDAOdJBJOuYLmVII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwgw5lKX46AFXm4CWJG6Jnw+a/Ys5Zj4yzs6hArdUWbizSaYfYps1qYqtZcR0jFynCcN0JIzIzdDpHDUY+TyVBJJfVSpfEggWjCf2LJ/s15xjic0GFgubxpvIHcUOXrSHuvjx5Ve7s/4tSvNJqpzbS+csCMd8mDUZbXplQwSY4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Lwc8MjsH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KCvhjJ004069;
	Wed, 20 Mar 2024 13:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=UGuARnyla0uZvFNLZct/
	w2kQwXXfhyRxBjEFGNcUUN4=; b=Lwc8MjsHgf3DF43yaDVpcEYFIBuqFLdPSFAG
	jcgyaBic7e/JXhYAzD0BYgc/XW0gDmJ0YUUMDzRchzwGIsDwcjbDINLpFZrdS044
	n4N6OQjdmnlKH+GFpjfmbd82MRVfWRTrTGINQRhnKrGDukoi8u5umm1MNZJm8bKY
	jNwsroFgo6WVe0iZP8WfEhwVeynZrY3rPs3DyZI3E99zz3cQwAD1g3ylpRlSInKU
	MZgK9JPu+4jWb2ier+8jGu05OpSFWyzL633IrIm5aDDLJOnLGl/wxwYrsGLYBKTM
	tglARtlTTyn0PzPQMo2HidTMFc/kFuOQbJtDK3QWpxwTByGRfg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyrp7943r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 13:43:04 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KDh4Jr018674
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 13:43:04 GMT
Received: from hu-depengs-sha.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 06:43:01 -0700
From: Depeng Shao <quic_depengs@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <quic_yon@quicinc.com>
CC: <quic_depengs@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v1 6/8] media: qcom: camss: Add new VFE driver for SM8550
Date: Wed, 20 Mar 2024 19:12:25 +0530
Message-ID: <20240320134227.16587-7-quic_depengs@quicinc.com>
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
X-Proofpoint-ORIG-GUID: K5y84erbCAwZ1N6WU8MHeCSlICTOJBna
X-Proofpoint-GUID: K5y84erbCAwZ1N6WU8MHeCSlICTOJBna
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403200108

From: Yongsheng Li <quic_yon@quicinc.com>

Add IFE driver for SM8550, the main difference with
old HW is register offset is different, register
update, reset and buf done is moved to CSID. And
the image address support 36 bits, so need to right
shift the image address when configuring the write
master.

Signed-off-by: Yongsheng Li <quic_yon@quicinc.com>
Co-developed-by: Depeng Shao <quic_depengs@quicinc.com>
---
 drivers/media/platform/qcom/camss/Makefile    |   1 +
 .../media/platform/qcom/camss/camss-vfe-780.c | 455 ++++++++++++++++++
 drivers/media/platform/qcom/camss/camss-vfe.h |   1 +
 3 files changed, 457 insertions(+)
 create mode 100644 drivers/media/platform/qcom/camss/camss-vfe-780.c

diff --git a/drivers/media/platform/qcom/camss/Makefile b/drivers/media/platform/qcom/camss/Makefile
index c5fcd6eec0f2..ac40bbab18a3 100644
--- a/drivers/media/platform/qcom/camss/Makefile
+++ b/drivers/media/platform/qcom/camss/Makefile
@@ -18,6 +18,7 @@ qcom-camss-objs += \
 		camss-vfe-4-8.o \
 		camss-vfe-17x.o \
 		camss-vfe-480.o \
+		camss-vfe-780.o \
 		camss-vfe-gen1.o \
 		camss-vfe.o \
 		camss-video.o \
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-780.c b/drivers/media/platform/qcom/camss/camss-vfe-780.c
new file mode 100644
index 000000000000..a78647f23c8c
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-vfe-780.c
@@ -0,0 +1,455 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * camss-vfe-780.c
+ *
+ * Qualcomm MSM Camera Subsystem - VFE (Video Front End) Module v780 (SM8550)
+ *
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+
+#include "camss.h"
+#include "camss-vfe.h"
+
+#define VFE_HW_VERSION			(vfe_is_lite(vfe) ? 0x1000 : 0x0)
+
+#define VFE_IRQ_CMD			(vfe_is_lite(vfe) ? 0x1038 : 0x30)
+#define     IRQ_CMD_GLOBAL_CLEAR	BIT(0)
+
+#define VFE_IRQ_MASK(n)			((vfe_is_lite(vfe) ? 0x1024 : 0x34) + (n) * 4)
+#define	    IRQ_MASK_0_BUS_TOP_IRQ	(vfe_is_lite(vfe) ? BIT(0) | BIT(1) | BIT(2) : \
+						BIT(0) | BIT(4) | BIT(18))
+#define	    IRQ_MASK_1_BUS_TOP_IRQ(n)	(vfe_is_lite(vfe) ? BIT(2 * n + 2) | BIT(2 * n + 3) : \
+						BIT(2 * n + 8) | BIT(2 * n + 9))
+#define VFE_IRQ_CLEAR(n)		((vfe_is_lite(vfe) ? 0x102C : 0x3C) + (n) * 4)
+#define VFE_IRQ_STATUS(n)		((vfe_is_lite(vfe) ? 0x101C : 0x44) + (n) * 4)
+
+#define BUS_REG_BASE			(vfe_is_lite(vfe) ? 0x1200 : 0xC00)
+
+#define VFE_BUS_WM_CGC_OVERRIDE		(BUS_REG_BASE + 0x08)
+#define		WM_CGC_OVERRIDE_ALL	(0x7FFFFFF)
+
+#define VFE_BUS_WM_TEST_BUS_CTRL	(BUS_REG_BASE + 0xdc)
+
+#define VFE_BUS_WM_CFG(n)		(BUS_REG_BASE + 0x200 + (n) * 0x100)
+#define		WM_CFG_EN			(0)
+#define		WM_VIR_FRM_EN		(1)
+#define		WM_CFG_MODE			(16)
+#define			MODE_QCOM_PLAIN	(0)
+#define			MODE_MIPI_RAW	(1)
+#define VFE_BUS_WM_IMAGE_ADDR(n)	(BUS_REG_BASE + 0x204 + (n) * 0x100)
+#define VFE_BUS_WM_FRAME_INCR(n)	(BUS_REG_BASE + 0x208 + (n) * 0x100)
+#define VFE_BUS_WM_IMAGE_CFG_0(n)	(BUS_REG_BASE + 0x20c + (n) * 0x100)
+#define                WM_IMAGE_CFG_0_DEFAULT_WIDTH    (0xFFFF)
+#define VFE_BUS_WM_IMAGE_CFG_1(n)	(BUS_REG_BASE + 0x210 + (n) * 0x100)
+#define VFE_BUS_WM_IMAGE_CFG_2(n)	(BUS_REG_BASE + 0x214 + (n) * 0x100)
+#define                WM_IMAGE_CFG_2_DEFAULT_STRIDE    (0xFFFF)
+#define VFE_BUS_WM_PACKER_CFG(n)	(BUS_REG_BASE + 0x218 + (n) * 0x100)
+#define VFE_BUS_WM_HEADER_ADDR(n)	(BUS_REG_BASE + 0x220 + (n) * 0x100)
+#define VFE_BUS_WM_HEADER_INCR(n)	(BUS_REG_BASE + 0x224 + (n) * 0x100)
+#define VFE_BUS_WM_HEADER_CFG(n)	(BUS_REG_BASE + 0x228 + (n) * 0x100)
+
+#define VFE_BUS_WM_IRQ_SUBSAMPLE_PERIOD(n)	(BUS_REG_BASE + 0x230 + (n) * 0x100)
+#define VFE_BUS_WM_IRQ_SUBSAMPLE_PATTERN(n)	(BUS_REG_BASE + 0x234 + (n) * 0x100)
+#define VFE_BUS_WM_FRAMEDROP_PERIOD(n)		(BUS_REG_BASE + 0x238 + (n) * 0x100)
+#define VFE_BUS_WM_FRAMEDROP_PATTERN(n)		(BUS_REG_BASE + 0x23c + (n) * 0x100)
+
+#define VFE_BUS_WM_MMU_PREFETCH_CFG(n)	(BUS_REG_BASE + 0x260 + (n) * 0x100)
+#define VFE_BUS_WM_MMU_PREFETCH_MAX_OFFSET(n)	(BUS_REG_BASE + 0x264 + (n) * 0x100)
+#define VFE_BUS_WM_SYSTEM_CACHE_CFG(n)	(BUS_REG_BASE + 0x268 + (n) * 0x100)
+
+
+/* for titan 780, each bus client is hardcoded to a specific path */
+#define RDI_WM(n)			((vfe_is_lite(vfe) ? 0 : 23) + (n))
+
+#define MAX_VFE_OUTPUT_LINES	4
+#define MAX_VFE_ACT_BUF	1
+
+static u32 vfe_hw_version(struct vfe_device *vfe)
+{
+	u32 hw_version = readl_relaxed(vfe->base + VFE_HW_VERSION);
+
+	u32 gen = (hw_version >> 28) & 0xF;
+	u32 rev = (hw_version >> 16) & 0xFFF;
+	u32 step = hw_version & 0xFFFF;
+
+	dev_info(vfe->camss->dev, "VFE HW Version = %u.%u.%u\n", gen, rev, step);
+
+	return hw_version;
+}
+
+static void vfe_global_reset(struct vfe_device *vfe)
+{
+}
+
+static void vfe_wm_start(struct vfe_device *vfe, u8 wm, struct vfe_line *line)
+{
+	struct v4l2_pix_format_mplane *pix =
+		&line->video_out.active_fmt.fmt.pix_mp;
+
+	wm = RDI_WM(wm); /* map to actual WM used (from wm=RDI index) */
+
+	/* no clock gating at bus input */
+	writel_relaxed(0, vfe->base + VFE_BUS_WM_CGC_OVERRIDE);
+
+	writel_relaxed(0x0, vfe->base + VFE_BUS_WM_TEST_BUS_CTRL);
+
+	writel_relaxed(ALIGN(pix->plane_fmt[0].bytesperline, 16) * pix->height >> 8,
+		       vfe->base + VFE_BUS_WM_FRAME_INCR(wm));
+	writel_relaxed((WM_IMAGE_CFG_0_DEFAULT_WIDTH & 0xFFFF),
+		       vfe->base + VFE_BUS_WM_IMAGE_CFG_0(wm));
+	writel_relaxed(WM_IMAGE_CFG_2_DEFAULT_STRIDE,
+		       vfe->base + VFE_BUS_WM_IMAGE_CFG_2(wm));
+	writel_relaxed(0, vfe->base + VFE_BUS_WM_PACKER_CFG(wm));
+
+	/* no dropped frames, one irq per frame */
+	writel_relaxed(0, vfe->base + VFE_BUS_WM_FRAMEDROP_PERIOD(wm));
+	writel_relaxed(1, vfe->base + VFE_BUS_WM_FRAMEDROP_PATTERN(wm));
+	writel_relaxed(0, vfe->base + VFE_BUS_WM_IRQ_SUBSAMPLE_PERIOD(wm));
+	writel_relaxed(1, vfe->base + VFE_BUS_WM_IRQ_SUBSAMPLE_PATTERN(wm));
+
+	writel_relaxed(1, vfe->base + VFE_BUS_WM_MMU_PREFETCH_CFG(wm));
+	writel_relaxed(0xFFFFFFFF, vfe->base + VFE_BUS_WM_MMU_PREFETCH_MAX_OFFSET(wm));
+
+	writel_relaxed(1 << WM_CFG_EN | MODE_MIPI_RAW << WM_CFG_MODE,
+		       vfe->base + VFE_BUS_WM_CFG(wm));
+}
+
+static void vfe_wm_stop(struct vfe_device *vfe, u8 wm)
+{
+	wm = RDI_WM(wm); /* map to actual WM used (from wm=RDI index) */
+	writel_relaxed(0, vfe->base + VFE_BUS_WM_CFG(wm));
+}
+
+static void vfe_wm_update(struct vfe_device *vfe, u8 wm, u64 addr,
+			  struct vfe_line *line)
+{
+	wm = RDI_WM(wm); /* map to actual WM used (from wm=RDI index) */
+	writel_relaxed((addr >> 8) & 0xFFFFFFFF, vfe->base + VFE_BUS_WM_IMAGE_ADDR(wm));
+
+	dev_dbg(vfe->camss->dev, "wm:%d, image buf addr:0x%llx\n",
+		wm, addr);
+}
+
+static void vfe_reg_update(struct vfe_device *vfe, enum vfe_line_id line_id)
+{
+	int port_id = line_id;
+
+	v4l2_subdev_notify(&vfe->line[line_id].subdev, NOTIFY_RUP, (void *)&port_id);
+}
+
+static inline void vfe_reg_update_clear(struct vfe_device *vfe,
+					enum vfe_line_id line_id)
+{
+	int port_id = line_id;
+
+	v4l2_subdev_notify(&vfe->line[line_id].subdev, NOTIFY_RUP_CLEAR, (void *)&port_id);
+}
+
+static void vfe_enable_irq_common(struct vfe_device *vfe, enum vfe_line_id line_id)
+{
+	int port_id = line_id;
+
+	/* enable top BUS status IRQ */
+	writel_relaxed(IRQ_MASK_0_BUS_TOP_IRQ,
+				vfe->base + VFE_IRQ_MASK(0));
+
+	writel_relaxed(IRQ_MASK_1_BUS_TOP_IRQ(port_id),
+				vfe->base + VFE_IRQ_MASK(1));
+}
+
+/*
+ * vfe_isr - VFE module interrupt handler
+ * @irq: Interrupt line
+ * @dev: VFE device
+ *
+ * Return IRQ_HANDLED on success
+ */
+static irqreturn_t vfe_isr(int irq, void *dev)
+{
+	struct vfe_device *vfe = dev;
+	u32 status;
+
+	status = readl_relaxed(vfe->base + VFE_IRQ_STATUS(0));
+	writel_relaxed(status, vfe->base + VFE_IRQ_CLEAR(0));
+	writel_relaxed(IRQ_CMD_GLOBAL_CLEAR, vfe->base + VFE_IRQ_CMD);
+
+	if (status)
+		dev_dbg(vfe->camss->dev, "Top Status_0:0x%x\n", status);
+
+	status = readl_relaxed(vfe->base + VFE_IRQ_STATUS(1));
+	writel_relaxed(status, vfe->base + VFE_IRQ_CLEAR(1));
+	writel_relaxed(IRQ_CMD_GLOBAL_CLEAR, vfe->base + VFE_IRQ_CMD);
+
+	if (status)
+		dev_dbg(vfe->camss->dev, "Top Status_1:0x%x\n", status);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * vfe_halt - Trigger halt on VFE module and wait to complete
+ * @vfe: VFE device
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int vfe_halt(struct vfe_device *vfe)
+{
+	/* rely on vfe_disable_output() to stop the VFE */
+	return 0;
+}
+
+static int vfe_get_output(struct vfe_line *line)
+{
+	struct vfe_device *vfe = to_vfe(line);
+	struct vfe_output *output;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vfe->output_lock, flags);
+
+	output = &line->output;
+	if (output->state > VFE_OUTPUT_RESERVED) {
+		dev_err(vfe->camss->dev, "Output is running\n");
+		goto error;
+	}
+
+	output->wm_num = 1;
+
+	/* Correspondence between VFE line number and WM number.
+	 * line 0 -> RDI 0, line 1 -> RDI1, line 2 -> RDI2, line 3 -> PIX/RDI3
+	 * Note this 1:1 mapping will not work for PIX streams.
+	 */
+	output->wm_idx[0] = line->id;
+	vfe->wm_output_map[line->id] = line->id;
+
+	output->drop_update_idx = 0;
+
+	spin_unlock_irqrestore(&vfe->output_lock, flags);
+
+	return 0;
+
+error:
+	spin_unlock_irqrestore(&vfe->output_lock, flags);
+	output->state = VFE_OUTPUT_OFF;
+
+	return -EINVAL;
+}
+
+static int vfe_enable_output(struct vfe_line *line)
+{
+	struct vfe_device *vfe = to_vfe(line);
+	struct vfe_output *output = &line->output;
+	unsigned long flags;
+	unsigned int i;
+
+	spin_lock_irqsave(&vfe->output_lock, flags);
+
+	vfe_reg_update_clear(vfe, line->id);
+
+	if (output->state > VFE_OUTPUT_RESERVED) {
+		dev_err(vfe->camss->dev, "Output is not in reserved state %d\n",
+			output->state);
+		spin_unlock_irqrestore(&vfe->output_lock, flags);
+		return -EINVAL;
+	}
+
+	WARN_ON(output->gen2.active_num);
+
+	output->state = VFE_OUTPUT_ON;
+
+	output->sequence = 0;
+
+	vfe_wm_start(vfe, output->wm_idx[0], line);
+
+	for (i = 0; i < MAX_VFE_ACT_BUF; i++) {
+		output->buf[i] = vfe_buf_get_pending(output);
+		if (!output->buf[i])
+			break;
+		output->gen2.active_num++;
+		vfe_wm_update(vfe, output->wm_idx[0], output->buf[i]->addr[0], line);
+
+		vfe_reg_update(vfe, line->id);
+	}
+
+	spin_unlock_irqrestore(&vfe->output_lock, flags);
+
+	return 0;
+}
+
+/*
+ * vfe_enable - Enable streaming on VFE line
+ * @line: VFE line
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int vfe_enable(struct vfe_line *line)
+{
+	struct vfe_device *vfe = to_vfe(line);
+	int ret;
+
+	mutex_lock(&vfe->stream_lock);
+
+	if (!vfe->stream_count)
+		vfe_enable_irq_common(vfe, line->id);
+
+	vfe->stream_count++;
+
+	mutex_unlock(&vfe->stream_lock);
+
+	ret = vfe_get_output(line);
+	if (ret < 0)
+		goto error_get_output;
+
+	ret = vfe_enable_output(line);
+	if (ret < 0)
+		goto error_enable_output;
+
+	vfe->was_streaming = 1;
+
+	return 0;
+
+error_enable_output:
+	vfe_put_output(line);
+
+error_get_output:
+	mutex_lock(&vfe->stream_lock);
+
+	vfe->stream_count--;
+
+	mutex_unlock(&vfe->stream_lock);
+
+	return ret;
+}
+
+/*
+ * vfe_buf_done - Process write master done interrupt
+ * @vfe: VFE Device
+ * @wm: Write master id
+ */
+static void vfe_buf_done(struct vfe_device *vfe, int wm)
+{
+	struct vfe_line *line = &vfe->line[vfe->wm_output_map[wm]];
+	struct camss_buffer *ready_buf;
+	struct vfe_output *output;
+	unsigned long flags;
+	u32 index;
+	u64 ts = ktime_get_ns();
+
+	spin_lock_irqsave(&vfe->output_lock, flags);
+
+	if (vfe->wm_output_map[wm] == VFE_LINE_NONE) {
+		dev_err_ratelimited(vfe->camss->dev,
+			"Received wm done for unmapped index\n");
+		goto out_unlock;
+	}
+	output = &vfe->line[vfe->wm_output_map[wm]].output;
+
+	ready_buf = output->buf[0];
+	if (!ready_buf) {
+		dev_err_ratelimited(vfe->camss->dev,
+			"Missing ready buf %d!\n", output->state);
+		goto out_unlock;
+	}
+
+	ready_buf->vb.vb2_buf.timestamp = ts;
+	ready_buf->vb.sequence = output->sequence++;
+
+	index = 0;
+	output->buf[0] = output->buf[1];
+	if (output->buf[0])
+		index = 1;
+
+	output->buf[index] = vfe_buf_get_pending(output);
+
+	if (output->buf[index]) {
+		vfe_wm_update(vfe, output->wm_idx[0], output->buf[index]->addr[0], line);
+		vfe_reg_update(vfe, line->id);
+	} else
+		output->gen2.active_num--;
+
+	spin_unlock_irqrestore(&vfe->output_lock, flags);
+
+	vb2_buffer_done(&ready_buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
+
+	return;
+
+out_unlock:
+	spin_unlock_irqrestore(&vfe->output_lock, flags);
+}
+
+/*
+ * vfe_queue_buffer - Add empty buffer
+ * @vid: Video device structure
+ * @buf: Buffer to be enqueued
+ *
+ * Add an empty buffer - depending on the current number of buffers it will be
+ * put in pending buffer queue or directly given to the hardware to be filled.
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int vfe_queue_buffer(struct camss_video *vid,
+			    struct camss_buffer *buf)
+{
+	struct vfe_line *line = container_of(vid, struct vfe_line, video_out);
+	struct vfe_device *vfe = to_vfe(line);
+	struct vfe_output *output;
+	unsigned long flags;
+
+	output = &line->output;
+
+	spin_lock_irqsave(&vfe->output_lock, flags);
+
+	if (output->state == VFE_OUTPUT_ON &&
+		output->gen2.active_num < MAX_VFE_ACT_BUF) {
+		output->buf[output->gen2.active_num++] = buf;
+		vfe_wm_update(vfe, output->wm_idx[0], buf->addr[0], line);
+		vfe_reg_update(vfe, line->id);
+	} else {
+		vfe_buf_add_pending(output, buf);
+	}
+
+	spin_unlock_irqrestore(&vfe->output_lock, flags);
+
+	return 0;
+}
+
+static const struct camss_video_ops vfe_video_ops_780 = {
+	.queue_buffer = vfe_queue_buffer,
+	.flush_buffers = vfe_flush_buffers,
+};
+
+static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
+{
+	vfe->video_ops = vfe_video_ops_780;
+}
+
+static void vfe_subdev_event(struct vfe_device *vfe, unsigned int evt_type, void *arg)
+{
+	int port_id = *(int *)arg;
+
+	switch (evt_type) {
+	case NOTIFY_BUF_DONE:
+		vfe_buf_done(vfe, port_id);
+		break;
+
+	default:
+		break;
+	}
+}
+
+const struct vfe_hw_ops vfe_ops_780 = {
+	.global_reset = vfe_global_reset,
+	.hw_version = vfe_hw_version,
+	.isr = vfe_isr,
+	.pm_domain_off = vfe_pm_domain_off,
+	.pm_domain_on = vfe_pm_domain_on,
+	.subdev_init = vfe_subdev_init,
+	.vfe_disable = vfe_disable,
+	.vfe_enable = vfe_enable,
+	.vfe_halt = vfe_halt,
+	.vfe_wm_stop = vfe_wm_stop,
+	.event = vfe_subdev_event,
+};
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.h b/drivers/media/platform/qcom/camss/camss-vfe.h
index 9919fe0ff101..150ea0b31fb1 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.h
+++ b/drivers/media/platform/qcom/camss/camss-vfe.h
@@ -224,6 +224,7 @@ extern const struct vfe_hw_ops vfe_ops_4_7;
 extern const struct vfe_hw_ops vfe_ops_4_8;
 extern const struct vfe_hw_ops vfe_ops_170;
 extern const struct vfe_hw_ops vfe_ops_480;
+extern const struct vfe_hw_ops vfe_ops_780;
 
 int vfe_get(struct vfe_device *vfe);
 void vfe_put(struct vfe_device *vfe);
-- 
2.17.1


