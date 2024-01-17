Return-Path: <linux-kernel+bounces-28664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10FC830192
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06C17B223FB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E3812B8F;
	Wed, 17 Jan 2024 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dC5FEY8h"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118E011709;
	Wed, 17 Jan 2024 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705481682; cv=none; b=rk487NuZ4h2yk3odtZqR7s5I6lhZ+b+4+ON0iTbYRGw3kct51vIgzoOQc9yswVFCH5QzYbWJ7nBAOdJwMOjROeBuFhzq/B97li/W+kRtU6+CyFcxRmt4fHPNJiwiRhxpLc8INEWTSNi4GcfZeGW9MvpnBxQEjdSYRPQ9JIM0IDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705481682; c=relaxed/simple;
	bh=f4QbGDSJYtuZVmf60ctHTGnbA2n06axYXnhEzMdSF5M=;
	h=Received:DKIM-Signature:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:To:CC:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=u9AXld5i534ygQuAbrWPHgKhH2fF85QQMBNLZoxFX8wTSjMt1W6C1kiu9ad3o1nCR4qZCHvxV8aUBsbN2+HDDCwI9clWWkk0FJTjsYxi/cVk6pjkt2T2eg66hDQL1tZgqoHQm/g4/+Z3v+oN2UKEzP+PghlKZnBsw5h7+kROBZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dC5FEY8h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H8RnEx028955;
	Wed, 17 Jan 2024 08:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=GO+
	73JdFR0409ZwSoh6uI/N0zvTcfdh92fXZFDgQ4BM=; b=dC5FEY8hogpxHkvjTaw
	d02CEN3NHn6cjuYSHHXY56aA98Cm/Fi1usEHBN+hkw/WitTOeVX2CfWC3Nwk69O+
	aEnBmrc93AqtWxXSF0FB6o0AK8QQOUnE24oqHm6A+y8+DFfrXRqIeiW4j5i8bDq9
	A96vyvc2gpAqezjEvatlP5+3+UJhKpR8W8c94CZSYrDgDPpDy8ZWpB4TyC8NHRRT
	KgKuqM2Ah7AMHL75BuTCLSupI8sE2lMgMcKGB8FZj9MH6hhwTOMC/qgN48rWv/0W
	dcQPCp8rFbiTV9OAcAZ5C+AopLmB9xy6CxaYiVXfOEpmouGBdGUMFjMYYlSVnUdN
	oMw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnymj1jj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 08:54:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40H8sZvG025178
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 08:54:35 GMT
Received: from hu-mkshah-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 00:54:33 -0800
From: Maulik Shah <quic_mkshah@quicinc.com>
Date: Wed, 17 Jan 2024 14:24:10 +0530
Subject: [PATCH] soc: qcom: rpmh-rsc: Enhance check for VREG in-flight
 request
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240117-rpmh-rsc-fixes-v1-1-71ee4f8f72a4@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALGVp2UC/x3LMQqAMAxA0atIZgNtrVq8ijhIjZpBLQmIIL27x
 fHx+S8oCZPCUL0gdLPydRbYuoK4z+dGyEsxOOO8sbZHSceOohFXfkixi76JvWltcAHKlIT+UJ5
 xyvkDuEg4YWAAAAA=
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_eberman@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_lsrao@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>
X-Mailer: b4 0.12.5-dev-2aabd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705481672; l=2651;
 i=quic_mkshah@quicinc.com; s=20240109; h=from:subject:message-id;
 bh=f4QbGDSJYtuZVmf60ctHTGnbA2n06axYXnhEzMdSF5M=;
 b=JYjLs6VzoY8/b5HkHEbGgRvYsC+dns8hpv6nILFHEAwmheir4wkPqvHb6FGPjDbu3ppgzjf1V
 XzaTRBl4sBtAJpe0U1Wc8gkP5vd2NEX4b6mAnZkWwlk2Bk/nzx836JI
X-Developer-Key: i=quic_mkshah@quicinc.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: atof4BzC85dow443VpXvLReZllkH1U0w
X-Proofpoint-GUID: atof4BzC85dow443VpXvLReZllkH1U0w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_04,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401170060

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
 drivers/soc/qcom/rpmh-rsc.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index a021dc71807b..5371d7e3090a 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #define pr_fmt(fmt) "%s " fmt, KBUILD_MODNAME
@@ -91,6 +92,15 @@ enum {
 #define CMD_STATUS_ISSUED		BIT(8)
 #define CMD_STATUS_COMPL		BIT(16)
 
+#define ACCL_TYPE(addr)			((addr >> 16) & 0xF)
+#define VREG_ADDR(addr)			(addr & ~0xF)
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
@@ -557,7 +567,15 @@ static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
 		for_each_set_bit(j, &curr_enabled, MAX_CMDS_PER_TCS) {
 			addr = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], i, j);
 			for (k = 0; k < msg->num_cmds; k++) {
-				if (addr == msg->cmds[k].addr)
+				/*
+				 * Each RPMh VREG accelerator resource has 3 or 4 contiguous 4-byte
+				 * aligned addresses associated with it. Ignore the offset to check
+				 * for in-flight VREG requests.
+				 */
+				if (HW_ACCL_VREG == ACCL_TYPE(msg->cmds[k].addr) &&
+				    VREG_ADDR(addr) == VREG_ADDR(msg->cmds[k].addr))
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


