Return-Path: <linux-kernel+bounces-108990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83283881313
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11361288991
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB4B53E0A;
	Wed, 20 Mar 2024 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JV4RS1Mo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4EA4D9E8;
	Wed, 20 Mar 2024 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710943937; cv=none; b=kpRGusFOSeALtqpmf1zNYmfyRknRLBrCAHj2aCL/+j+N7jiIkIq5DfM0g6gSXYU0SW/7vXmGs11zIMF8nJhaftb+W2iVnKWWbVDdOajArH8bijhA5nrl6N+rs6Q5f/olWk+4VdaYncq7wdwAPpu9ZrKNMOF/tgrC7i00zi6+T0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710943937; c=relaxed/simple;
	bh=16UKphKCBibHFk2xpQBb7f+/ci0Du5EDbth8q5I0Zh4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inrzpzlkWHTrbNEWsyQZDfso77tTM2oLDb3e9/rsAC4NVkyuxoxHSP8F5WPIPr2jKWYseN2OWiQEFsttJvsXCFB8DOjjxWUofW37Qvkh7d6oO8g0A6nOyOM+c/aJN5qrNjyn7NrRJKlCVt6oDtrw7K6TsOAdk8gsyhVpOMAauMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JV4RS1Mo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KCRbYl007731;
	Wed, 20 Mar 2024 14:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=jzvt4hKl5bJ6ejlhfxh6
	mH0hkSQY2ho4WRRwwSsNw7k=; b=JV4RS1MoStRj2IiFTbTYhrtLunUyNMpjxZzm
	GTzTM01FTFd1jK09pubNc5n6ymOKx3TquuhfXd7hNkCiFPJx6M+1+uALWMlOnPTA
	6P835jS6jKvYkZiz2TkxFJ00BCusQqzmqFg8ec4evOGq7CZqUj+z6qLyauvRHpzC
	P0RchrrWiJolHBGc+CNjVgkmqt96yaBOfYk4neEFHy8+7yDf2hMZK98OTy4uqfYX
	yzfpJmS5SwjvW5KmEvUxhGbcYFO5tQHw0klCsLTIBLuZXO6bwS3CSyDk8tRiMGgF
	BZ6nJDVQBPmTdK3yUQwaK2bSzjn8kvSzq65SxuYPEAPlM8kcfg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyvrmrnfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 14:12:10 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KEC9Cn024687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 14:12:09 GMT
Received: from hu-depengs-sha.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 07:12:06 -0700
From: Depeng Shao <quic_depengs@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <quic_yon@quicinc.com>
CC: <quic_depengs@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 5/8] media: qcom: camss: Add CSID gen3 driver
Date: Wed, 20 Mar 2024 19:41:33 +0530
Message-ID: <20240320141136.26827-6-quic_depengs@quicinc.com>
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
X-Proofpoint-ORIG-GUID: sDF1C8RsNAKN9glIP5VRpxIepXqIMtf2
X-Proofpoint-GUID: sDF1C8RsNAKN9glIP5VRpxIepXqIMtf2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403200112

The CSID in SM8550 is gen3, it has new register
offset and new functionality, the buf done irq,
register update and reset is moved to CSID gen3.

Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
Co-developed-by: Yongsheng Li <quic_yon@quicinc.com>
Signed-off-by: Yongsheng Li <quic_yon@quicinc.com>
---
 drivers/media/platform/qcom/camss/Makefile    |   1 +
 .../platform/qcom/camss/camss-csid-gen3.c     | 639 ++++++++++++++++++
 .../platform/qcom/camss/camss-csid-gen3.h     |  26 +
 .../media/platform/qcom/camss/camss-csid.h    |   1 +
 4 files changed, 667 insertions(+)
 create mode 100644 drivers/media/platform/qcom/camss/camss-csid-gen3.c
 create mode 100644 drivers/media/platform/qcom/camss/camss-csid-gen3.h

diff --git a/drivers/media/platform/qcom/camss/Makefile b/drivers/media/platform/qcom/camss/Makefile
index 28eba4bf3e38..c5fcd6eec0f2 100644
--- a/drivers/media/platform/qcom/camss/Makefile
+++ b/drivers/media/platform/qcom/camss/Makefile
@@ -7,6 +7,7 @@ qcom-camss-objs += \
 		camss-csid-4-1.o \
 		camss-csid-4-7.o \
 		camss-csid-gen2.o \
+		camss-csid-gen3.o \
 		camss-csiphy-2ph-1-0.o \
 		camss-csiphy-3ph-1-0.o \
 		camss-csiphy-2-1-2.o \
diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen3.c b/drivers/media/platform/qcom/camss/camss-csid-gen3.c
new file mode 100644
index 000000000000..b97005f7065d
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-csid-gen3.c
@@ -0,0 +1,639 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * camss-csid-gen3.c
+ *
+ * Qualcomm MSM Camera Subsystem - CSID (CSI Decoder) Module
+ *
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/delay.h>
+
+
+#include "camss-csid.h"
+#include "camss-csid-gen3.h"
+#include "camss.h"
+
+
+#define CSID_TOP_IO_PATH_CFG0(csid)	(0x4 * (csid))
+#define		OUTPUT_IFE_EN 0x100
+#define		INTERNAL_CSID 1
+
+#define CSID_HW_VERSION		0x0
+#define		HW_VERSION_STEPPING	0
+#define		HW_VERSION_REVISION	16
+#define		HW_VERSION_GENERATION	28
+
+#define CSID_RST_CFG	0xC
+#define		RST_MODE		0
+#define		RST_LOCATION	4
+
+#define CSID_RST_CMD	0x10
+#define		SELECT_HW_RST	0
+#define		SELECT_SW_RST	1
+#define		SELECT_IRQ_RST	2
+
+#define CSID_CSI2_RX_IRQ_STATUS	0x9C
+#define CSID_CSI2_RX_IRQ_MASK	0xA0
+#define CSID_CSI2_RX_IRQ_CLEAR	0xA4
+#define CSID_CSI2_RX_IRQ_SET	0xA8
+
+#define CSID_CSI2_RDIN_IRQ_STATUS(rdi)		(0xEC + 0x10 * (rdi))
+#define CSID_CSI2_RDIN_IRQ_MASK(rdi)		(0xF0 + 0x10 * (rdi))
+#define		CSID_CSI2_RDIN_INFO_FIFO_FULL 2
+#define		CSID_CSI2_RDIN_INFO_CAMIF_EOF 3
+#define		CSID_CSI2_RDIN_INFO_CAMIF_SOF 4
+#define		CSID_CSI2_RDIN_INFO_INPUT_EOF 9
+#define		CSID_CSI2_RDIN_INFO_INPUT_SOF 12
+#define		CSID_CSI2_RDIN_ERROR_REC_FRAME_DROP 18
+#define		CSID_CSI2_RDIN_ERROR_REC_OVERFLOW_IRQ 19
+#define		CSID_CSI2_RDIN_ERROR_REC_CCIF_VIOLATION 20
+#define		CSID_CSI2_RDIN_EPOCH0 21
+#define		CSID_CSI2_RDIN_EPOCH1 22
+#define		CSID_CSI2_RDIN_RUP_DONE 23
+#define		CSID_CSI2_RDIN_CCIF_VIOLATION 29
+
+#define CSID_CSI2_RDIN_IRQ_CLEAR(rdi)		(0xF4 + 0x10 * (rdi))
+#define CSID_CSI2_RDIN_IRQ_SET(rdi)			(0xF8 + 0x10 * (rdi))
+
+#define CSID_TOP_IRQ_STATUS	0x7C
+#define		TOP_IRQ_STATUS_RESET_DONE 0
+#define CSID_TOP_IRQ_MASK	0x80
+#define CSID_TOP_IRQ_CLEAR	0x84
+#define CSID_TOP_IRQ_SET	0x88
+#define CSID_IRQ_CMD		0x14
+#define		IRQ_CMD_CLEAR	0
+#define		IRQ_CMD_SET	4
+
+#define CSID_BUF_DONE_IRQ_STATUS	0x8C
+#define		BUF_DONE_IRQ_STATUS_RDI_OFFSET (csid_is_lite(csid) ? 1 : 14)
+#define CSID_BUF_DONE_IRQ_MASK	0x90
+#define CSID_BUF_DONE_IRQ_CLEAR	0x94
+#define CSID_BUF_DONE_IRQ_SET	0x98
+
+#define CSID_CSI2_RX_CFG0	0x200
+#define		CSI2_RX_CFG0_NUM_ACTIVE_LANES	0
+#define		CSI2_RX_CFG0_DL0_INPUT_SEL	4
+#define		CSI2_RX_CFG0_DL1_INPUT_SEL	8
+#define		CSI2_RX_CFG0_DL2_INPUT_SEL	12
+#define		CSI2_RX_CFG0_DL3_INPUT_SEL	16
+#define		CSI2_RX_CFG0_PHY_NUM_SEL	20
+#define			CSI2_RX_CFG0_PHY_SEL_BASE_IDX 1
+#define		CSI2_RX_CFG0_PHY_TYPE_SEL	24
+#define		CSI2_RX_CFG0_TPG_MUX_EN		27
+#define		CSI2_RX_CFG0_TPG_NUM_SEL	28
+
+#define CSID_CSI2_RX_CFG1	0x204
+#define		CSI2_RX_CFG1_PACKET_ECC_CORRECTION_EN		0
+#define		CSI2_RX_CFG1_DE_SCRAMBLE_EN			1
+#define		CSI2_RX_CFG1_VC_MODE				2
+#define		CSI2_RX_CFG1_COMPLETE_STREAM_EN			4
+#define		CSI2_RX_CFG1_COMPLETE_STREAM_FRAME_TIMING	5
+#define		CSI2_RX_CFG1_MISR_EN				6
+#define		CSI2_RX_CFG1_PHY_BIST_EN			7
+#define		CSI2_RX_CFG1_EPD_MODE				8
+#define		CSI2_RX_CFG1_EOTP_EN				9
+#define		CSI2_RX_CFG1_DYN_SWITCH_EN			10
+#define		CSI2_RX_CFG1_RUP_AUP_LATCH_DIS		11
+
+#define CSID_CSI2_RX_CAPTURE_CTRL	0x208
+#define		CSI2_RX_CAPTURE_CTRL_LONG_PKT_CAPTURE_EN	0
+#define		CSI2_RX_CAPTURE_CTRL_SHORT_PKT_CAPTURE_EN	1
+#define		CSI2_RX_CAPTURE_CTRL_CPHY_PKT_CAPTURE_EN	3
+#define		CSI2_RX_CAPTURE_CTRL_LONG_PKT_CAPTURE_DT		4
+#define		CSI2_RX_CAPTURE_CTRL_LONG_PKT_CAPTURE_VC		10
+#define		CSI2_RX_CAPTURE_CTRL_SHORT_PKT_CAPTURE_VC	15
+#define		CSI2_RX_CAPTURE_CTRL_CPHY_PKT_CAPTURE_DT		20
+#define		CSI2_RX_CAPTURE_CTRL_CPHY_PKT_CAPTURE_VC		26
+
+#define CSID_RDI_CFG0(rdi)			(0x500 + 0x100 * (rdi))
+#define		RDI_CFG0_VFR_EN				0
+#define		RDI_CFG0_FRAME_ID_DEC_EN	1
+#define		RDI_CFG0_RETIME_DIS			5
+#define		RDI_CFG0_TIMESTAMP_EN		6
+#define		RDI_CFG0_TIMESTAMP_STB_SEL	8
+#define		RDI_CFG0_DECODE_FORMAT		12
+#define		RDI_CFG0_DT					16
+#define		RDI_CFG0_VC					22
+#define		RDI_CFG0_DT_ID				27
+#define		RDI_CFG0_EN					31
+
+#define CSID_RDI_CFG1(rdi)			(0x510 + 0x100 * (rdi))
+#define		RDI_CFG1_BYTE_CNTR_EN	2
+#define		RDI_CFG1_DROP_H_EN	5
+#define		RDI_CFG1_DROP_V_EN	6
+#define		RDI_CFG1_CROP_H_EN	7
+#define		RDI_CFG1_CROP_V_EN	8
+#define		RDI_CFG1_MISR_EN	9
+#define		RDI_CFG1_PIX_STORE  10
+#define		RDI_CFG1_PLAIN_ALIGNMENT	11
+#define		RDI_CFG1_PLAIN_FORMAT	12
+#define		RDI_CFG1_EARLY_EOF_EN	14
+#define		RDI_CFG1_PACKING_FORMAT	15
+
+#define CSID_RDI_CTRL(rdi)			(0x504 + 0x100 * (rdi))
+#define		RDI_CTRL_START_CMD		0
+#define		RDI_CTRL_START_MODE		2
+
+#define CSID_RDI_EPOCH_IRQ_CFG(rdi) (0x52C + 0x100 * (rdi))
+
+#define CSID_RDI_FRM_DROP_PATTERN(rdi)			(0x540 + 0x100 * (rdi))
+#define CSID_RDI_FRM_DROP_PERIOD(rdi)			(0x544 + 0x100 * (rdi))
+#define CSID_RDI_IRQ_SUBSAMPLE_PATTERN(rdi)		(0x548 + 0x100 * (rdi))
+#define CSID_RDI_IRQ_SUBSAMPLE_PERIOD(rdi)		(0x54C + 0x100 * (rdi))
+#define CSID_RDI_RPP_PIX_DROP_PATTERN(rdi)		(0x558 + 0x100 * (rdi))
+#define CSID_RDI_RPP_PIX_DROP_PERIOD(rdi)		(0x55C + 0x100 * (rdi))
+#define CSID_RDI_RPP_LINE_DROP_PATTERN(rdi)		(0x560 + 0x100 * (rdi))
+#define CSID_RDI_RPP_LINE_DROP_PERIOD(rdi)		(0x564 + 0x100 * (rdi))
+
+#define CSID_RDI_RPP_HCROP(rdi)                 (0x550 + 0x100 * (rdi))
+#define CSID_RDI_RPP_VCROP(rdi)                 (0x554 + 0x100 * (rdi))
+
+#define CSID_RDI_ERROR_RECOVERY_CFG0(rdi)       (0x514 + 0x100 * (rdi))
+
+#define CSID_DISCARD_FRAMES 4
+
+#define CSID_REG_UPDATE_CMD		0x18
+static inline int reg_update_rdi(struct csid_device *csid, int n)
+{
+	return BIT(n + 4) + BIT(20 + n);
+}
+
+#define	    REG_UPDATE_RDI		reg_update_rdi
+
+static const struct csid_format csid_formats[] = {
+	{
+		MEDIA_BUS_FMT_UYVY8_1X16,
+		DATA_TYPE_YUV422_8BIT,
+		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
+		8,
+		2,
+	},
+	{
+		MEDIA_BUS_FMT_VYUY8_1X16,
+		DATA_TYPE_YUV422_8BIT,
+		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
+		8,
+		2,
+	},
+	{
+		MEDIA_BUS_FMT_YUYV8_1X16,
+		DATA_TYPE_YUV422_8BIT,
+		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
+		8,
+		2,
+	},
+	{
+		MEDIA_BUS_FMT_YVYU8_1X16,
+		DATA_TYPE_YUV422_8BIT,
+		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
+		8,
+		2,
+	},
+	{
+		MEDIA_BUS_FMT_SBGGR8_1X8,
+		DATA_TYPE_RAW_8BIT,
+		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
+		8,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SGBRG8_1X8,
+		DATA_TYPE_RAW_8BIT,
+		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
+		8,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SGRBG8_1X8,
+		DATA_TYPE_RAW_8BIT,
+		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
+		8,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SRGGB8_1X8,
+		DATA_TYPE_RAW_8BIT,
+		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
+		8,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SBGGR10_1X10,
+		DATA_TYPE_RAW_10BIT,
+		DECODE_FORMAT_UNCOMPRESSED_10_BIT,
+		10,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SGBRG10_1X10,
+		DATA_TYPE_RAW_10BIT,
+		DECODE_FORMAT_UNCOMPRESSED_10_BIT,
+		10,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SGRBG10_1X10,
+		DATA_TYPE_RAW_10BIT,
+		DECODE_FORMAT_UNCOMPRESSED_10_BIT,
+		10,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SRGGB10_1X10,
+		DATA_TYPE_RAW_10BIT,
+		DECODE_FORMAT_UNCOMPRESSED_10_BIT,
+		10,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_Y8_1X8,
+		DATA_TYPE_RAW_8BIT,
+		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
+		8,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_Y10_1X10,
+		DATA_TYPE_RAW_10BIT,
+		DECODE_FORMAT_UNCOMPRESSED_10_BIT,
+		10,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SBGGR12_1X12,
+		DATA_TYPE_RAW_12BIT,
+		DECODE_FORMAT_UNCOMPRESSED_12_BIT,
+		12,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SGBRG12_1X12,
+		DATA_TYPE_RAW_12BIT,
+		DECODE_FORMAT_UNCOMPRESSED_12_BIT,
+		12,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SGRBG12_1X12,
+		DATA_TYPE_RAW_12BIT,
+		DECODE_FORMAT_UNCOMPRESSED_12_BIT,
+		12,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SRGGB12_1X12,
+		DATA_TYPE_RAW_12BIT,
+		DECODE_FORMAT_UNCOMPRESSED_12_BIT,
+		12,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SBGGR14_1X14,
+		DATA_TYPE_RAW_14BIT,
+		DECODE_FORMAT_UNCOMPRESSED_14_BIT,
+		14,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SGBRG14_1X14,
+		DATA_TYPE_RAW_14BIT,
+		DECODE_FORMAT_UNCOMPRESSED_14_BIT,
+		14,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SGRBG14_1X14,
+		DATA_TYPE_RAW_14BIT,
+		DECODE_FORMAT_UNCOMPRESSED_14_BIT,
+		14,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SRGGB14_1X14,
+		DATA_TYPE_RAW_14BIT,
+		DECODE_FORMAT_UNCOMPRESSED_14_BIT,
+		14,
+		1,
+	},
+};
+
+static void __csid_configure_rx(struct csid_device *csid,
+				struct csid_phy_config *phy, int vc)
+{
+	int val;
+
+	val = (phy->lane_cnt - 1) << CSI2_RX_CFG0_NUM_ACTIVE_LANES;
+	val |= phy->lane_assign << CSI2_RX_CFG0_DL0_INPUT_SEL;
+	val |= (phy->csiphy_id + CSI2_RX_CFG0_PHY_SEL_BASE_IDX) << CSI2_RX_CFG0_PHY_NUM_SEL;
+
+	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG0);
+
+	val = 1 << CSI2_RX_CFG1_PACKET_ECC_CORRECTION_EN;
+	if (vc > 3)
+		val |= 1 << CSI2_RX_CFG1_VC_MODE;
+	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG1);
+}
+
+static void __csid_ctrl_rdi(struct csid_device *csid, int enable, u8 rdi)
+{
+	int val;
+
+	if (enable)
+		val = 1 << RDI_CTRL_START_CMD;
+	else
+		val = 0 << RDI_CTRL_START_CMD;
+	writel_relaxed(val, csid->base + CSID_RDI_CTRL(rdi));
+}
+
+static void __csid_configure_top(struct csid_device *csid)
+{
+	u32 val;
+
+	if (csid->top_base) {
+		val = OUTPUT_IFE_EN | INTERNAL_CSID;
+		writel_relaxed(val, csid->top_base + CSID_TOP_IO_PATH_CFG0(csid->id));
+	}
+}
+
+static void __csid_configure_rdi_stream(struct csid_device *csid, u8 enable, u8 vc)
+{
+	u32 val;
+	u8 lane_cnt = csid->phy.lane_cnt;
+	/* Source pads matching RDI channels on hardware. Pad 1 -> RDI0, Pad 2 -> RDI1, etc. */
+	struct v4l2_mbus_framefmt *input_format = &csid->fmt[MSM_CSID_PAD_FIRST_SRC + vc];
+	const struct csid_format *format = csid_get_fmt_entry(csid->formats, csid->nformats,
+							      input_format->code);
+
+	if (!lane_cnt)
+		lane_cnt = 4;
+
+	val = 0;
+	writel_relaxed(val, csid->base + CSID_RDI_FRM_DROP_PERIOD(vc));
+
+	/*
+	 * DT_ID is a two bit bitfield that is concatenated with
+	 * the four least significant bits of the five bit VC
+	 * bitfield to generate an internal CID value.
+	 *
+	 * CSID_RDI_CFG0(vc)
+	 * DT_ID : 28:27
+	 * VC    : 26:22
+	 * DT    : 21:16
+	 *
+	 * CID   : VC 3:0 << 2 | DT_ID 1:0
+	 */
+	u8 dt_id = vc & 0x03;
+
+	val = 1 << RDI_CFG0_TIMESTAMP_EN;
+	val |= 2 << RDI_CFG0_TIMESTAMP_STB_SEL;
+	/* note: for non-RDI path, this should be format->decode_format */
+	val |= DECODE_FORMAT_PAYLOAD_ONLY << RDI_CFG0_DECODE_FORMAT;
+	val |= vc << RDI_CFG0_VC;
+	val |= format->data_type << RDI_CFG0_DT;
+	val |= dt_id << RDI_CFG0_DT_ID;
+
+	writel_relaxed(val, csid->base + CSID_RDI_CFG0(vc));
+
+	val = 1 << RDI_CFG1_PACKING_FORMAT;
+	val |= 1 << RDI_CFG1_PIX_STORE;
+	val |= 1 << RDI_CFG1_DROP_H_EN;
+	val |= 1 << RDI_CFG1_DROP_V_EN;
+	val |= 1 << RDI_CFG1_CROP_H_EN;
+	val |= 1 << RDI_CFG1_CROP_V_EN;
+	val |= RDI_CFG1_EARLY_EOF_EN;
+
+	writel_relaxed(val, csid->base + CSID_RDI_CFG1(vc));
+
+	val = 0;
+	writel_relaxed(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PERIOD(vc));
+
+	val = 1;
+	writel_relaxed(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PATTERN(vc));
+
+	val = 0;
+	writel_relaxed(val, csid->base + CSID_RDI_CTRL(vc));
+
+	val = readl_relaxed(csid->base + CSID_RDI_CFG0(vc));
+	val |=  enable << RDI_CFG0_EN;
+	writel_relaxed(val, csid->base + CSID_RDI_CFG0(vc));
+}
+
+static void csid_configure_stream(struct csid_device *csid, u8 enable)
+{
+	u8 i;
+
+	/* Loop through all enabled VCs and configure stream for each */
+	for (i = 0; i < MSM_CSID_MAX_SRC_STREAMS; i++)
+		if (csid->phy.en_vc & BIT(i)) {
+			__csid_configure_top(csid);
+			__csid_configure_rdi_stream(csid, enable, i);
+			__csid_configure_rx(csid, &csid->phy, i);
+			__csid_ctrl_rdi(csid, enable, i);
+		}
+}
+
+static int csid_configure_testgen_pattern(struct csid_device *csid, s32 val)
+{
+	if (val > 0 && val <= csid->testgen.nmodes)
+		csid->testgen.mode = val;
+
+	return 0;
+}
+
+/*
+ * csid_hw_version - CSID hardware version query
+ * @csid: CSID device
+ *
+ * Return HW version or error
+ */
+static u32 csid_hw_version(struct csid_device *csid)
+{
+	u32 hw_version;
+	u32 hw_gen;
+	u32 hw_rev;
+	u32 hw_step;
+
+	hw_version = readl_relaxed(csid->base + CSID_HW_VERSION);
+	hw_gen = (hw_version >> HW_VERSION_GENERATION) & 0xF;
+	hw_rev = (hw_version >> HW_VERSION_REVISION) & 0xFFF;
+	hw_step = (hw_version >> HW_VERSION_STEPPING) & 0xFFFF;
+	dev_info(csid->camss->dev, "CSID HW Version = %u.%u.%u\n",
+		hw_gen, hw_rev, hw_step);
+
+	return hw_version;
+}
+
+static void csid_reg_update(struct csid_device *csid, int port_id)
+{
+	csid->reg_update |= REG_UPDATE_RDI(csid, port_id);
+	writel_relaxed(csid->reg_update, csid->base + CSID_REG_UPDATE_CMD);
+}
+
+static inline void csid_reg_update_clear(struct csid_device *csid,
+					int port_id)
+{
+	csid->reg_update &= ~REG_UPDATE_RDI(csid, port_id);
+}
+
+
+/*
+ * csid_isr - CSID module interrupt service routine
+ * @irq: Interrupt line
+ * @dev: CSID device
+ *
+ * Return IRQ_HANDLED on success
+ */
+static irqreturn_t csid_isr(int irq, void *dev)
+{
+	struct csid_device *csid = dev;
+	u32 val, buf_done_val;
+	u8 reset_done;
+	int i;
+
+	val = readl_relaxed(csid->base + CSID_TOP_IRQ_STATUS);
+	writel_relaxed(val, csid->base + CSID_TOP_IRQ_CLEAR);
+	reset_done = val & BIT(TOP_IRQ_STATUS_RESET_DONE);
+
+	val = readl_relaxed(csid->base + CSID_CSI2_RX_IRQ_STATUS);
+	writel_relaxed(val, csid->base + CSID_CSI2_RX_IRQ_CLEAR);
+
+	buf_done_val = readl_relaxed(csid->base + CSID_BUF_DONE_IRQ_STATUS);
+	writel_relaxed(buf_done_val, csid->base + CSID_BUF_DONE_IRQ_CLEAR);
+
+	/* Read and clear IRQ status for each enabled RDI channel */
+	for (i = 0; i < MSM_CSID_MAX_SRC_STREAMS; i++)
+		if (csid->phy.en_vc & BIT(i)) {
+			val = readl_relaxed(csid->base + CSID_CSI2_RDIN_IRQ_STATUS(i));
+			writel_relaxed(val, csid->base + CSID_CSI2_RDIN_IRQ_CLEAR(i));
+
+			if (buf_done_val & BIT(BUF_DONE_IRQ_STATUS_RDI_OFFSET + i)) {
+				dev_dbg(csid->camss->dev, "RDI%d BUF DONE", i);
+				v4l2_subdev_notify(&csid->subdev, NOTIFY_BUF_DONE, (void *)&i);
+			}
+		}
+
+	val = 1 << IRQ_CMD_CLEAR;
+	writel_relaxed(val, csid->base + CSID_IRQ_CMD);
+
+	if (reset_done)
+		complete(&csid->reset_complete);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * csid_reset - Trigger reset on CSID module and wait to complete
+ * @csid: CSID device
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int csid_reset(struct csid_device *csid)
+{
+	unsigned long time;
+	u32 val;
+	int i;
+
+	reinit_completion(&csid->reset_complete);
+
+	writel_relaxed(1, csid->base + CSID_TOP_IRQ_CLEAR);
+	writel_relaxed(1, csid->base + CSID_IRQ_CMD);
+	writel_relaxed(1, csid->base + CSID_TOP_IRQ_MASK);
+
+	for (i = 0; i < MSM_CSID_MAX_SRC_STREAMS; i++)
+		if (csid->phy.en_vc & BIT(i)) {
+			writel_relaxed(BIT(BUF_DONE_IRQ_STATUS_RDI_OFFSET + i),
+						csid->base + CSID_BUF_DONE_IRQ_CLEAR);
+			writel_relaxed(0x1 << IRQ_CMD_CLEAR, csid->base + CSID_IRQ_CMD);
+			writel_relaxed(BIT(BUF_DONE_IRQ_STATUS_RDI_OFFSET + i),
+						csid->base + CSID_BUF_DONE_IRQ_MASK);
+		}
+
+	/* preserve registers */
+	val = (0x1 << RST_LOCATION) | (0x1 << RST_MODE);
+	writel_relaxed(val, csid->base + CSID_RST_CFG);
+
+	val = (0x1 << SELECT_HW_RST) | (0x1 << SELECT_IRQ_RST);
+	writel_relaxed(val, csid->base + CSID_RST_CMD);
+
+	time = wait_for_completion_timeout(&csid->reset_complete,
+					   msecs_to_jiffies(CSID_RESET_TIMEOUT_MS));
+	if (!time) {
+		dev_err(csid->camss->dev, "CSID reset timeout\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static u32 csid_src_pad_code(struct csid_device *csid, u32 sink_code,
+			     unsigned int match_format_idx, u32 match_code)
+{
+	switch (sink_code) {
+	case MEDIA_BUS_FMT_SBGGR10_1X10:
+	{
+		u32 src_code[] = {
+			MEDIA_BUS_FMT_SBGGR10_1X10,
+			MEDIA_BUS_FMT_SBGGR10_2X8_PADHI_LE,
+		};
+
+		return csid_find_code(src_code, ARRAY_SIZE(src_code),
+				      match_format_idx, match_code);
+	}
+	case MEDIA_BUS_FMT_Y10_1X10:
+	{
+		u32 src_code[] = {
+			MEDIA_BUS_FMT_Y10_1X10,
+			MEDIA_BUS_FMT_Y10_2X8_PADHI_LE,
+		};
+
+		return csid_find_code(src_code, ARRAY_SIZE(src_code),
+				      match_format_idx, match_code);
+	}
+	default:
+		if (match_format_idx > 0)
+			return 0;
+
+		return sink_code;
+	}
+}
+
+static void csid_subdev_init(struct csid_device *csid)
+{
+	csid->formats = csid_formats;
+	csid->nformats = ARRAY_SIZE(csid_formats);
+	csid->testgen.modes = csid_testgen_modes;
+	csid->testgen.nmodes = CSID_PAYLOAD_MODE_NUM_SUPPORTED_GEN2;
+}
+
+static void csid_subdev_event(struct csid_device *csid, unsigned int evt_type, void *arg)
+{
+	int evt_data = *(int *)arg;
+
+	switch (evt_type) {
+	case NOTIFY_RUP:
+		csid_reg_update(csid, evt_data);
+		break;
+	case NOTIFY_RUP_CLEAR:
+		csid_reg_update_clear(csid, evt_data);
+		break;
+	default:
+		dev_err(csid->camss->dev, "NOT Supported EVT Type\n");
+		break;
+	}
+}
+
+const struct csid_hw_ops csid_ops_gen3 = {
+	.configure_stream = csid_configure_stream,
+	.configure_testgen_pattern = csid_configure_testgen_pattern,
+	.hw_version = csid_hw_version,
+	.isr = csid_isr,
+	.reset = csid_reset,
+	.src_pad_code = csid_src_pad_code,
+	.subdev_init = csid_subdev_init,
+	.event = csid_subdev_event,
+};
diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen3.h b/drivers/media/platform/qcom/camss/camss-csid-gen3.h
new file mode 100644
index 000000000000..aa5bd5f2fec5
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-csid-gen3.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * camss-csid-gen3.h
+ *
+ * Qualcomm MSM Camera Subsystem - CSID (CSI Decoder) Module Generation 1
+ *
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef QC_MSM_CAMSS_CSID_GEN3_H
+#define QC_MSM_CAMSS_CSID_GEN3_H
+
+#define DECODE_FORMAT_UNCOMPRESSED_8_BIT	0x1
+#define DECODE_FORMAT_UNCOMPRESSED_10_BIT	0x2
+#define DECODE_FORMAT_UNCOMPRESSED_12_BIT	0x3
+#define DECODE_FORMAT_UNCOMPRESSED_14_BIT	0x4
+#define DECODE_FORMAT_UNCOMPRESSED_16_BIT	0x5
+#define DECODE_FORMAT_UNCOMPRESSED_20_BIT	0x6
+#define DECODE_FORMAT_UNCOMPRESSED_24_BIT	0x7
+#define DECODE_FORMAT_PAYLOAD_ONLY		0xf
+
+
+#define PLAIN_FORMAT_PLAIN8	0x0 /* supports DPCM, UNCOMPRESSED_6/8_BIT */
+#define PLAIN_FORMAT_PLAIN16	0x1 /* supports DPCM, UNCOMPRESSED_10/16_BIT */
+#define PLAIN_FORMAT_PLAIN32	0x2 /* supports UNCOMPRESSED_20_BIT */
+
+#endif /* QC_MSM_CAMSS_CSID_GEN3_H */
diff --git a/drivers/media/platform/qcom/camss/camss-csid.h b/drivers/media/platform/qcom/camss/camss-csid.h
index ca654b007441..c1d061f91b78 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.h
+++ b/drivers/media/platform/qcom/camss/camss-csid.h
@@ -223,6 +223,7 @@ extern const char * const csid_testgen_modes[];
 extern const struct csid_hw_ops csid_ops_4_1;
 extern const struct csid_hw_ops csid_ops_4_7;
 extern const struct csid_hw_ops csid_ops_gen2;
+extern const struct csid_hw_ops csid_ops_gen3;
 
 /*
  * csid_is_lite - Check if CSID is CSID lite.
-- 
2.17.1


