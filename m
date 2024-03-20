Return-Path: <linux-kernel+bounces-108989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D59881310
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4596B24D85
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17A14C61C;
	Wed, 20 Mar 2024 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oy/UN8qK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55504206A;
	Wed, 20 Mar 2024 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710943934; cv=none; b=U4Ps2CrR8NFBUtP7xqCJvdceT+t0vY4nbs6QGzDGuWje1+qJ3QovZouo7RbxcgHDjpHo29IbY9U7tKA4wgf5zcSBIPMXy18u0oCodwbixejZ/chuFk3y4ExB2AcdQ5/1TGnKHposHEh6JBu4fo/hOT1fn2lPZrLb6AJQkachnfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710943934; c=relaxed/simple;
	bh=mgIABhFPyh2Q4+mTQ5iUl/Q0kzGupPJ9MFho63Go9as=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixI71/57UhFXgZr3KQ2Z2JisMBk0QPYdoQM4b5/PoDXJywCmz3sbjz2e9CCyDr7ExWnGEvBKUTV3hv1FAxHQ6B2pEqUUgWE0z6b6Sx5Bu4sllPK28zLtjtu8+acOl/iaeKb8NrbwUnsi5qto+pZmp2vDrlRYjHQMptZxHBxcjos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oy/UN8qK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KEC6Fl028028;
	Wed, 20 Mar 2024 14:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=yQZ2HRP4l26slpaXqk+9
	ECbf3VaDuJHfU7fjD3xFv30=; b=oy/UN8qKabJ6kNZIQd6LEAndtDcwm49dc0U4
	xcNVTXIQQ71twHRW9HbqRlI9sMNpltfUpFzl60o2hHbYQ4Dqu5a1opbttRN/Zh7Z
	po5eyQuEe32R/sXlT1zrWyRu1K3AvQH7lt9xKXk0BJQkIJRN5xZRODw+XaCfg8RV
	JKjzd7XgwfdGq4Fq0NgzLkBYocNExIXStffqztL2FI9dKFRBut1oROiqG8EK3Hj8
	2Di2rE2cm8cK1x7fnkV7jiRWs34ZMTN+k8HgojwZjLOWIat2E9NiBNr/QuexVCdP
	ZAFeQOctnZ1IyW0f5EDmtlpsyk2zkXqFqNZoWzAOfL9PhfZExA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x01br800u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 14:12:06 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KEC3EA024546
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 14:12:03 GMT
Received: from hu-depengs-sha.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 07:12:01 -0700
From: Depeng Shao <quic_depengs@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <quic_yon@quicinc.com>
CC: <quic_depengs@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 3/8] media: qcom: camss: Add new csiphy driver 2-1-2
Date: Wed, 20 Mar 2024 19:41:31 +0530
Message-ID: <20240320141136.26827-4-quic_depengs@quicinc.com>
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
X-Proofpoint-GUID: hujS_HvwkcVLDJqmpAe6HLy0jfAfnTct
X-Proofpoint-ORIG-GUID: hujS_HvwkcVLDJqmpAe6HLy0jfAfnTct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200112

From: Yongsheng Li <quic_yon@quicinc.com>

The CSIPHY register offset of SM8550 is different with
SM8250, so add a new driver for the SM8550 platform.

Signed-off-by: Yongsheng Li <quic_yon@quicinc.com>
Co-developed-by: Depeng Shao <depengs@qti.qualcomm.com>
Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
---
 drivers/media/platform/qcom/camss/Makefile    |   1 +
 .../platform/qcom/camss/camss-csiphy-2-1-2.c  | 343 ++++++++++++++++++
 .../media/platform/qcom/camss/camss-csiphy.h  |   1 +
 3 files changed, 345 insertions(+)
 create mode 100644 drivers/media/platform/qcom/camss/camss-csiphy-2-1-2.c

diff --git a/drivers/media/platform/qcom/camss/Makefile b/drivers/media/platform/qcom/camss/Makefile
index 0d4389ab312d..28eba4bf3e38 100644
--- a/drivers/media/platform/qcom/camss/Makefile
+++ b/drivers/media/platform/qcom/camss/Makefile
@@ -9,6 +9,7 @@ qcom-camss-objs += \
 		camss-csid-gen2.o \
 		camss-csiphy-2ph-1-0.o \
 		camss-csiphy-3ph-1-0.o \
+		camss-csiphy-2-1-2.o \
 		camss-csiphy.o \
 		camss-ispif.o \
 		camss-vfe-4-1.o \
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-2-1-2.c b/drivers/media/platform/qcom/camss/camss-csiphy-2-1-2.c
new file mode 100644
index 000000000000..df7860d7a4f4
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-csiphy-2-1-2.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * camss-csiphy-2-1-2.c
+ *
+ * Qualcomm MSM Camera Subsystem - CSIPHY Module 3phase v2.0
+ *
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "camss.h"
+#include "camss-csiphy.h"
+
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+
+
+#define CSIPHY_CMN_CSI_COMMON_CTRLn(n)	(0x1000 + 0x4 * (n))
+#define CSIPHY_CMN_CSI_COMMON_CTRL5_CLK_ENABLE	BIT(7)
+#define CSIPHY_CMN_CSI_COMMON_CTRL6_COMMON_PWRDN_B	BIT(0)
+#define CSIPHY_CMN_CSI_COMMON_CTRL6_SHOW_REV_ID	BIT(1)
+#define CSIPHY_CMN_CSI_COMMON_CTRL7_CONTROL	0x7A
+#define CSIPHY_CMN_CSI_COMMON_CTRL0_PHY_SW_RESET	BIT(0)
+#define CSIPHY_CMN_CSI_COMMON_CTRL0_SWI_ENABLE_LANESYNC	BIT(1)
+#define CSIPHY_CMN_CSI_COMMON_STATUSn(n)	(0x10B0 + 0x4 * (n))
+
+#define CSIPHY_DEFAULT_PARAMS            0
+#define CSIPHY_LANE_ENABLE               1
+#define CSIPHY_SETTLE_CNT_LOWER_BYTE     2
+#define CSIPHY_SETTLE_CNT_HIGHER_BYTE    3
+#define CSIPHY_DNP_PARAMS                4
+#define CSIPHY_2PH_REGS                  5
+#define CSIPHY_3PH_REGS                  6
+
+struct csiphy_reg_t {
+	s32 reg_addr;
+	s32 reg_data;
+	s32 delay;
+	u32 csiphy_param_type;
+};
+
+/* 2.1.2 2PH */
+static const struct
+csiphy_reg_t lane_regs_sm8550[5][20] = {
+	{
+		{0x0E90, 0x0f, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0E98, 0x08, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0E94, 0x07, 0x01, CSIPHY_DEFAULT_PARAMS},
+		{0x00A0, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0090, 0x0f, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0098, 0x08, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0094, 0x07, 0x01, CSIPHY_DEFAULT_PARAMS},
+		{0x0494, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x04A0, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0490, 0x0f, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0498, 0x08, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0494, 0x07, 0x01, CSIPHY_DEFAULT_PARAMS},
+		{0x0894, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x08A0, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0890, 0x0f, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0898, 0x08, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0894, 0x07, 0x01, CSIPHY_DEFAULT_PARAMS},
+		{0x0C94, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0CA0, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0C90, 0x0f, 0x00, CSIPHY_DEFAULT_PARAMS},
+	},
+	{
+		{0x0C98, 0x08, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0C94, 0x07, 0x01, CSIPHY_DEFAULT_PARAMS},
+		{0x0E30, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0E28, 0x04, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0E00, 0x80, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0E0C, 0xFF, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0E38, 0x1F, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0E2C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0E34, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0E1C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0E14, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0E3C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0E04, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0E20, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0E08, 0x10, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
+		{0x0E10, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0030, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0000, 0x8E, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0038, 0xFE, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x002C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
+	},
+	{
+		{0x0034, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x001C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0014, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x003C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0004, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0020, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0008, 0x10, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
+		{0x0010, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0430, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0400, 0x8E, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0438, 0xFE, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x042C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0434, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x041C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0414, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x043C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0404, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0420, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0408, 0x10, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
+		{0x0410, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
+	},
+	{
+		{0x0830, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0800, 0x8E, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0838, 0xFE, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x082C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0834, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x081C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0814, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x083C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0804, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0820, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0808, 0x10, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
+		{0x0810, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0C30, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0C00, 0x8E, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0C38, 0xFE, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0C2C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0C34, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0C1C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0C14, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0C3C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
+	},
+	{
+		{0x0C04, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0C20, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0C08, 0x10, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
+		{0x0C10, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0094, 0xD7, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x005C, 0x04, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0060, 0xBD, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0064, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0494, 0xD7, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x045C, 0x04, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0460, 0xBD, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0464, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0894, 0xD7, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x085C, 0x04, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0860, 0xBD, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0864, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0C94, 0xD7, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0C5C, 0x04, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0C60, 0xBD, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0C64, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
+	}
+};
+
+static void csiphy_hw_version_read(struct csiphy_device *csiphy,
+				   struct device *dev)
+{
+	u32 hw_version;
+
+	writel(CSIPHY_CMN_CSI_COMMON_CTRL6_SHOW_REV_ID,
+	       csiphy->base + CSIPHY_CMN_CSI_COMMON_CTRLn(6));
+
+	hw_version = readl_relaxed(csiphy->base +
+				   CSIPHY_CMN_CSI_COMMON_STATUSn(12));
+	hw_version |= readl_relaxed(csiphy->base +
+				   CSIPHY_CMN_CSI_COMMON_STATUSn(13)) << 8;
+	hw_version |= readl_relaxed(csiphy->base +
+				   CSIPHY_CMN_CSI_COMMON_STATUSn(14)) << 16;
+	hw_version |= readl_relaxed(csiphy->base +
+				   CSIPHY_CMN_CSI_COMMON_STATUSn(15)) << 24;
+
+	dev_info(dev, "CSIPHY 3PH HW Version = 0x%08x\n", hw_version);
+}
+
+/*
+ * csiphy_reset - Perform software reset on CSIPHY module
+ * @csiphy: CSIPHY device
+ */
+static void csiphy_reset(struct csiphy_device *csiphy)
+{
+	writel_relaxed(0x1, csiphy->base + CSIPHY_CMN_CSI_COMMON_CTRLn(0));
+	usleep_range(5000, 8000);
+	writel_relaxed(0x0, csiphy->base + CSIPHY_CMN_CSI_COMMON_CTRLn(0));
+}
+
+static irqreturn_t csiphy_isr(int irq, void *dev)
+{
+	struct csiphy_device *csiphy = dev;
+	int i;
+
+	for (i = 0; i < 11; i++) {
+		int c = i + 22;
+		u8 val = readl_relaxed(csiphy->base +
+				       CSIPHY_CMN_CSI_COMMON_STATUSn(i));
+
+		writel_relaxed(val, csiphy->base +
+				    CSIPHY_CMN_CSI_COMMON_CTRLn(c));
+	}
+
+	writel_relaxed(0x1, csiphy->base + CSIPHY_CMN_CSI_COMMON_CTRLn(10));
+	writel_relaxed(0x0, csiphy->base + CSIPHY_CMN_CSI_COMMON_CTRLn(10));
+
+	for (i = 22; i < 33; i++)
+		writel_relaxed(0x0, csiphy->base +
+				    CSIPHY_CMN_CSI_COMMON_CTRLn(i));
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * csiphy_settle_cnt_calc - Calculate settle count value
+ *
+ * Helper function to calculate settle count value. This is
+ * based on the CSI2 T_hs_settle parameter which in turn
+ * is calculated based on the CSI2 transmitter link frequency.
+ *
+ * Return settle count value or 0 if the CSI2 link frequency
+ * is not available
+ */
+static u8 csiphy_settle_cnt_calc(s64 link_freq, u32 timer_clk_rate)
+{
+	u32 ui; /* ps */
+	u32 timer_period; /* ps */
+	u32 t_hs_prepare_max; /* ps */
+	u32 t_hs_settle; /* ps */
+	u8 settle_cnt;
+
+	if (link_freq <= 0)
+		return 0;
+
+	ui = div_u64(1000000000000LL, link_freq);
+	ui /= 2;
+	t_hs_prepare_max = 85000 + 6 * ui;
+	t_hs_settle = t_hs_prepare_max;
+
+	timer_period = div_u64(1000000000000LL, timer_clk_rate);
+	settle_cnt = t_hs_settle / timer_period - 6;
+
+	return settle_cnt;
+}
+
+static void csiphy_config_lanes(struct csiphy_device *csiphy,
+				     u8 settle_cnt)
+{
+	const struct csiphy_reg_t *r;
+	int i, l, array_size;
+	u32 val;
+
+	switch (csiphy->camss->res->version) {
+	case CAMSS_8550:
+		r = &lane_regs_sm8550[0][0];
+		array_size = ARRAY_SIZE(lane_regs_sm8550[0]);
+		break;
+	default:
+		WARN(1, "unknown csi version\n");
+		return;
+	}
+
+	for (l = 0; l < 5; l++) {
+		for (i = 0; i < array_size; i++, r++) {
+			switch (r->csiphy_param_type) {
+			case CSIPHY_SETTLE_CNT_LOWER_BYTE:
+				val = settle_cnt & 0xff;
+				break;
+			case CSIPHY_DNP_PARAMS:
+				continue;
+			default:
+				val = r->reg_data;
+				break;
+			}
+			writel_relaxed(val, csiphy->base + r->reg_addr);
+
+			if (r->delay > 0)
+				udelay(r->delay);
+		}
+	}
+}
+
+static u8 csiphy_get_lane_mask(struct csiphy_lanes_cfg *lane_cfg)
+{
+	u8 lane_mask;
+	int i;
+
+	for (i = 0; i < lane_cfg->num_data; i++)
+		lane_mask |= 1 << lane_cfg->data[i].pos;
+
+	return lane_mask;
+}
+
+static void csiphy_lanes_enable(struct csiphy_device *csiphy,
+				struct csiphy_config *cfg,
+				s64 link_freq, u8 lane_mask)
+{
+	struct csiphy_lanes_cfg *c = &cfg->csi2->lane_cfg;
+	u8 settle_cnt;
+	u8 val = 0;
+	int i;
+
+	settle_cnt = csiphy_settle_cnt_calc(link_freq, csiphy->timer_clk_rate);
+
+	val = CSIPHY_CMN_CSI_COMMON_CTRL5_CLK_ENABLE;
+	for (i = 0; i < c->num_data; i++)
+		val |= BIT(c->data[i].pos * 2);
+
+	writel_relaxed(val, csiphy->base + CSIPHY_CMN_CSI_COMMON_CTRLn(5));
+
+	val = CSIPHY_CMN_CSI_COMMON_CTRL6_COMMON_PWRDN_B;
+	writel_relaxed(val, csiphy->base + CSIPHY_CMN_CSI_COMMON_CTRLn(6));
+
+	val = 0x2;
+	writel_relaxed(val, csiphy->base + CSIPHY_CMN_CSI_COMMON_CTRLn(7));
+
+	val = 0x0;
+	writel_relaxed(val, csiphy->base + CSIPHY_CMN_CSI_COMMON_CTRLn(0));
+
+	csiphy_config_lanes(csiphy, settle_cnt);
+
+	/* IRQ_MASK registers - disable all interrupts */
+	for (i = 11; i < 22; i++)
+		writel_relaxed(0, csiphy->base + CSIPHY_CMN_CSI_COMMON_CTRLn(i));
+}
+
+static void csiphy_lanes_disable(struct csiphy_device *csiphy,
+				 struct csiphy_config *cfg)
+{
+	writel_relaxed(0, csiphy->base +
+		CSIPHY_CMN_CSI_COMMON_CTRLn(5));
+
+	writel_relaxed(0, csiphy->base +
+		CSIPHY_CMN_CSI_COMMON_CTRLn(6));
+}
+
+const struct csiphy_hw_ops csiphy_ops_2_1_2 = {
+	.get_lane_mask = csiphy_get_lane_mask,
+	.hw_version_read = csiphy_hw_version_read,
+	.reset = csiphy_reset,
+	.lanes_enable = csiphy_lanes_enable,
+	.lanes_disable = csiphy_lanes_disable,
+	.isr = csiphy_isr,
+	.event = NULL,
+};
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.h b/drivers/media/platform/qcom/camss/camss-csiphy.h
index ffe1b95eea98..286fdb9f4fdf 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.h
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.h
@@ -98,5 +98,6 @@ void msm_csiphy_unregister_entity(struct csiphy_device *csiphy);
 
 extern const struct csiphy_hw_ops csiphy_ops_2ph_1_0;
 extern const struct csiphy_hw_ops csiphy_ops_3ph_1_0;
+extern const struct csiphy_hw_ops csiphy_ops_2_1_2;
 
 #endif /* QC_MSM_CAMSS_CSIPHY_H */
-- 
2.17.1


