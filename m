Return-Path: <linux-kernel+bounces-30904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1508325BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566DA1F226E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E17428694;
	Fri, 19 Jan 2024 08:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gqGN/RTY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0F124B2C;
	Fri, 19 Jan 2024 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652833; cv=none; b=WJMCRaCrVMSysIEkO8UwM+kXlmjj8oeugk0yuvnvVY599bFRopArnjKLjt6ZghnfryAN0mm7N8vRzaRacYkHsHt64BQGLdjda3PR4Eu2upSsqpLGKbQycEOgtJdlfwmMijccmZ5yH9AeQLI3kMFNzdDzhlBHcRb7N5QXPDG6tTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652833; c=relaxed/simple;
	bh=+FOihNrOosZdp1tCvq1a3qbL37vxph33JQlJkukPYVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=I0GQtCEJA9S0vcMG4/3nUvoq+OCVHKdIxxsIGj81LCaczQThiJC2a7wqVAel1B50Yrxb70r95YiWUHCFFCGZhhoH4DJQzVi9LWCJPIZLJ8yr01ULS5RDv9Zivr6doPDfHtuuNlgo/KDMGY1CIWVCBcf3QkaEz/sQpoUnbrHl0NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gqGN/RTY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J47D73027020;
	Fri, 19 Jan 2024 08:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=3M5
	6Dj3GSMYxGpt9ZWmuVrjJFtZtzWljDNbou+qC98o=; b=gqGN/RTYMb+n6ZR/pyR
	bFigrk27hGUoysZiPcw5pmXYcR/yGOAiz0N7M22tIS+7OScJ4QjaFFAj5K9md3Xd
	BkLTIITEbeA6pOx3ZqE7YHxx4Ve8NBqW+h0rIrDuTU793UFLDU64kfhnHIU/cWdT
	ArfGeW00EEV2OXqgrdhvTGtQ8utW2MuQi5Vqx7X6U4rMfuk1HS6d08O2sgadmrS5
	imFnMpjpg2N+T0Tq7S4yxMhNP2ZDg/3pyys49gRIIqtzqbuueso2CPed1nFumbVr
	HC59yGlRcn/jqRgoEObZSKsxDUY7vFVLsHPahP0xV7XYxKJyicBJ77q2iygyCp8o
	BPg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vqhs9gegd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 08:27:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40J8R04i015174
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 08:27:00 GMT
Received: from hu-mkshah-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 19 Jan 2024 00:26:57 -0800
From: Maulik Shah <quic_mkshah@quicinc.com>
Date: Fri, 19 Jan 2024 13:56:54 +0530
Subject: [PATCH v2] soc: qcom: rpmh-rsc: Enhance check for VREG in-flight
 request
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240119-rpmh-rsc-fixes-v2-1-e42c0a9e36f0@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAE0yqmUC/3WMMQ7CMAxFr1J5xigOgURM3AN1qIxLPLQpCVSgq
 ncndGd8/+u9BYpklQLnZoEssxZNYwW7a4BjN94F9VYZrLHOEHnM0xAxF8Ze31LwxO7A3hwp2AB
 VmrJsR3WubeWo5ZnyZ+vP9Fv/pmZCQk8irg+9t527PF7KOvKe0wDtuq5fZHUFVa4AAAA=
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_eberman@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_lsrao@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>
X-Mailer: b4 0.12.5-dev-2aabd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705652817; l=2980;
 i=quic_mkshah@quicinc.com; s=20240109; h=from:subject:message-id;
 bh=+FOihNrOosZdp1tCvq1a3qbL37vxph33JQlJkukPYVQ=;
 b=alY8OpsiE8fKNnNipPdw3Pc/qnK57zC4iKb973Z4z6bRwXyviyswZ3k6RMGde9vfCz49eQdmJ
 aFZLQ5NwmyrCfKuIZShmWZgmPUkVNOj42DIz8hq0rZUrvknhZKKoECP
X-Developer-Key: i=quic_mkshah@quicinc.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kRD7uAHuSIb4qyowqQ5zuXvSzMYTlocN
X-Proofpoint-ORIG-GUID: kRD7uAHuSIb4qyowqQ5zuXvSzMYTlocN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_04,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190031

Each RPMh VREG accelerator resource has 3 or 4 contiguous 4-byte aligned
addresses associated with it. These control voltage, enable state, mode,
and in legacy targets, voltage headroom. The current in-flight request
checking logic looks for exact address matches. Requests for different
addresses of the same RPMh resource as thus not detected as in-flight.

Enhance the in-flight request check for VREG requests by ignoring the
address offset. This ensures that only one request is allowed to be
in-flight for a given VREG resource. This is needed to avoid scenarios
where request commands are carried out by RPMh hardware out-of-order
leading to LDO regulator over-current protection triggering.

Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
Changes in v2:
- Use GENMASK() and FIELD_GET()
- Link to v1: https://lore.kernel.org/r/20240117-rpmh-rsc-fixes-v1-1-71ee4f8f72a4@quicinc.com
---
 drivers/soc/qcom/rpmh-rsc.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index a021dc71807b..e480cde783fe 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -1,11 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #define pr_fmt(fmt) "%s " fmt, KBUILD_MODNAME
 
 #include <linux/atomic.h>
+#include <linux/bitfield.h>
 #include <linux/cpu_pm.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -91,6 +93,15 @@ enum {
 #define CMD_STATUS_ISSUED		BIT(8)
 #define CMD_STATUS_COMPL		BIT(16)
 
+#define ACCL_TYPE(addr)			FIELD_GET(GENMASK(19, 16), addr)
+#define VREG_ADDR(addr)			FIELD_GET(GENMASK(19, 4), addr)
+
+enum {
+	HW_ACCL_CLK = 0x3,
+	HW_ACCL_VREG,
+	HW_ACCL_BUS,
+};
+
 /*
  * Here's a high level overview of how all the registers in RPMH work
  * together:
@@ -557,7 +568,15 @@ static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
 		for_each_set_bit(j, &curr_enabled, MAX_CMDS_PER_TCS) {
 			addr = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], i, j);
 			for (k = 0; k < msg->num_cmds; k++) {
-				if (addr == msg->cmds[k].addr)
+				/*
+				 * Each RPMh VREG accelerator resource has 3 or 4 contiguous 4-byte
+				 * aligned addresses associated with it. Ignore the offset to check
+				 * for in-flight VREG requests.
+				 */
+				if (ACCL_TYPE(msg->cmds[k].addr) == HW_ACCL_VREG &&
+				    VREG_ADDR(msg->cmds[k].addr) == VREG_ADDR(addr))
+					return -EBUSY;
+				else if (addr == msg->cmds[k].addr)
 					return -EBUSY;
 			}
 		}

---
base-commit: 943b9f0ab2cfbaea148dd6ac279957eb08b96904
change-id: 20240117-rpmh-rsc-fixes-6c43c7051828

Best regards,
-- 
Maulik Shah <quic_mkshah@quicinc.com>


