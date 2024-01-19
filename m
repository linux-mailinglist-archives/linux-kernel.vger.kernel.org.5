Return-Path: <linux-kernel+bounces-31001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387D1832753
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5EB1C23255
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA403C496;
	Fri, 19 Jan 2024 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i9OjE3KV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683053D0DF;
	Fri, 19 Jan 2024 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705658837; cv=none; b=SUfVGXvFQOVtoC+pxUdn0hBIMjpkpS9nESGZW0e6QgEndFoztpDh9zvPZhmk6zC2E2m/TYY3+oIUJqfAPzVlkUvvKpjvZOZBRJcacjqEYZJ7QswtTtJ9ssHGi4Zowm7oQDMEpshfgd7ZY6n3UCXMtpUPjDYk1UEuBMPK/ufAhZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705658837; c=relaxed/simple;
	bh=qRu0BCBoa3RiRg6ela1IAOHStQr+X8Jf92Hhp4boM8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0i0MzV6m2nbB+t/KdtOuiqJGhUohCQNoStLmL5vaydk/NW00I+7B7DoZMWSL8MAgNbeAvPGBSEuNMYt1qzhQ9QB+p0h1L485F5+J4td5W+SersY1KeHEKYZPsAP24Vc5/1Pq5sjT4jxC9zUEfqcLRbrBMfLHNs6xz29SQrrQWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i9OjE3KV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J8Ep0R020928;
	Fri, 19 Jan 2024 10:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=d7cnyqHCMUinolB4rVhO
	mz123GLEdjCVors2x3PAVfg=; b=i9OjE3KV5KpnrC0RD99H3K4JAv82BRLYvD6N
	Z+81q4MxpGj++kNnCjKvR0fUw3gPpWIC48ruqvmj+YjvhzC/j4oI/3YfCVxuElqg
	c5xbJWEz/hYWsopLY6ZFdVKmMMQw73GRJGjEaXKR+zjiVCUGqNl0mnHlJduJbG1x
	dgvSjtAUxH7brqZRjrBrX9BVxT10ImTxKCPOSUQtXOoLWYEJd/Z4Vry17YBojw7Y
	YIi3jsTH6kdekunSJBb7fQb3XFWqLA+95JNoCNliXbFlAAc7AvPA8myyA7H3pYMJ
	+BXk2OrOof12FkBTC/aPzQcKb9U81JDR2Uv0tUuw90x6r2lBrw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vqndb06sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 10:07:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40JA7CKW025780
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 10:07:12 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 19 Jan 2024 02:07:06 -0800
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Tengfei Fan
	<quic_tengfan@quicinc.com>
Subject: [PATCH v4 4/6] arm64: dts: qcom: qcm8550: introduce qcm8550 dtsi
Date: Fri, 19 Jan 2024 18:06:19 +0800
Message-ID: <20240119100621.11788-5-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240119100621.11788-1-quic_tengfan@quicinc.com>
References: <20240119100621.11788-1-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fU2gb71__H4l_1lLQmNenAYCi9kXB5MN
X-Proofpoint-GUID: fU2gb71__H4l_1lLQmNenAYCi9kXB5MN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=648 impostorscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190044

QCM8550 is derived from SM8550, it is mainly used in IoT scenarions.
QCM8550 and QCS8550 have same memory map and it's different to SM8550.
There are 3 types of reserved memory regions here:
1. Firmware related regions.
    This will be described as: reserved-region@address. Current
reserved-region may have reserved area which was not yet used, release
note of the firmware can have such kind of information.
2. Firmware related which shared with kernel access.
    Each region will have a specific node with specific label name for
later phandle reference from other driver dt node. May overlapping with
above type regions.
3. PIL regions.
    PIL regions are allocated by kernel and assigned to subsystem
firmware later.
Here is a map for this platform:
0x100000000 +------------------+
            |                  |
            | Firmware Related |
            |                  |
 0xd4d00000 +------------------+
            |                  |
            | Kernel Available |
            |                  |
 0xA7000000 +------------------+
            |                  |
            |    PIL Region    |
            |                  |
 0x8A800000 +------------------+
            |                  |
            | Firmware Related |
            |                  |
 0x80000000 +------------------+
Note that:
1. 0xA7000000 to 0xA8000000 was used by bootloader as well, not suggest
for other usage.
2. Kernel start address was start at 0xA8000000.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcm8550.dtsi | 170 ++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qcm8550.dtsi

diff --git a/arch/arm64/boot/dts/qcom/qcm8550.dtsi b/arch/arm64/boot/dts/qcom/qcm8550.dtsi
new file mode 100644
index 000000000000..62d9c0df0523
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qcm8550.dtsi
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023~2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "sm8550.dtsi"
+
+/delete-node/ &reserved_memory;
+
+/ {
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * There are 3 types of reserved memory regions here:
+		 * 1. Firmware related regions.
+		 *     This will be described as: reserved-region@address. Current
+		 * reserved-region may have reserved area which was not yet used,
+		 * release note of the firmware can have such kind of information.
+		 * 2. Firmware related which shared with kernel access.
+		 *     Each region will have a specific node with specific label
+		 * name for later phandle reference from other driver dt node. May
+		 * overlapping with above type regions.
+		 * 3. PIL regions.
+		 *     PIL regions are allocated by kernel and assigned to subsystem
+		 * firmware later.
+		 * Here is a map for this platform:
+		 * 0x100000000 +------------------+
+		 *             |                  |
+		 *             | Firmware Related |
+		 *             |                  |
+		 *  0xd4d00000 +------------------+
+		 *             |                  |
+		 *             | Kernel Available |
+		 *             |                  |
+		 *  0xA7000000 +------------------+
+		 *             |                  |
+		 *             |    PIL Region    |
+		 *             |                  |
+		 *  0x8A800000 +------------------+
+		 *             |                  |
+		 *             | Firmware Related |
+		 *             |                  |
+		 *  0x80000000 +------------------+
+		 * Note that:
+		 * 1. 0xA7000000 to 0xA8000000 was used by bootloader as well, not
+		 * suggest for other usage.
+		 * 2. Kernel start address was start at 0xA8000000.
+		 */
+
+		/* Firmware related regions */
+		reserved-region@80000000 {
+			reg = <0x0 0x80000000 0x0 0xa800000>;
+			no-map;
+		};
+
+		aop_image_mem: aop-image-region@81c00000 {
+			reg = <0x0 0x81c00000 0x0 0x60000>;
+			no-map;
+		};
+
+		aop_cmd_db_mem: aop-cmd-db-region@81c60000 {
+			compatible = "qcom,cmd-db";
+			reg = <0x0 0x81c60000 0x0 0x20000>;
+			no-map;
+		};
+
+		aop_config_mem: aop-config-region@81c80000 {
+			no-map;
+			reg = <0x0 0x81c80000 0x0 0x20000>;
+		};
+
+		smem_mem: smem-region@81d00000 {
+			compatible = "qcom,smem";
+			reg = <0x0 0x81d00000 0x0 0x200000>;
+			hwlocks = <&tcsr_mutex 3>;
+			no-map;
+		};
+
+		adsp_mhi_mem: adsp-mhi-region@81f00000 {
+			reg = <0x0 0x81f00000 0x0 0x20000>;
+			no-map;
+		};
+
+		/* PIL region */
+		mpss_mem: mpss-region@8a800000 {
+			reg = <0x0 0x8a800000 0x0 0x10800000>;
+			no-map;
+		};
+
+		q6_mpss_dtb_mem: q6-mpss-dtb-region@9b000000 {
+			reg = <0x0 0x9b000000 0x0 0x80000>;
+			no-map;
+		};
+
+		ipa_fw_mem: ipa-fw-region@9b080000 {
+			reg = <0x0 0x9b080000 0x0 0x10000>;
+			no-map;
+		};
+
+		ipa_gsi_mem: ipa-gsi-region@9b090000 {
+			reg = <0x0 0x9b090000 0x0 0xa000>;
+			no-map;
+		};
+
+		gpu_micro_code_mem: gpu-micro-code-region@9b09a000 {
+			reg = <0x0 0x9b09a000 0x0 0x2000>;
+			no-map;
+		};
+
+		spss_region_mem: spss-region@9b100000 {
+			reg = <0x0 0x9b100000 0x0 0x180000>;
+			no-map;
+		};
+
+		spu_secure_shared_memory_mem: spu-secure-shared-memory-region@9b280000 {
+			reg = <0x0 0x9b280000 0x0 0x80000>;
+			no-map;
+		};
+
+		camera_mem: camera-region@9b300000 {
+			reg = <0x0 0x9b300000 0x0 0x800000>;
+			no-map;
+		};
+
+		video_mem: video-region@9bb00000 {
+			reg = <0x0 0x9bb00000 0x0 0x700000>;
+			no-map;
+		};
+
+		cvp_mem: cvp-region@9c200000 {
+			reg = <0x0 0x9c200000 0x0 0x700000>;
+			no-map;
+		};
+
+		cdsp_mem: cdsp-region@9c900000 {
+			reg = <0x0 0x9c900000 0x0 0x2000000>;
+			no-map;
+		};
+
+		q6_cdsp_dtb_mem: q6-cdsp-dtb-region@9e900000 {
+			reg = <0x0 0x9e900000 0x0 0x80000>;
+			no-map;
+		};
+
+		q6_adsp_dtb_mem: q6-adsp-dtb-region@9e980000 {
+			reg = <0x0 0x9e980000 0x0 0x80000>;
+			no-map;
+		};
+
+		adspslpi_mem: adspslpi-region@9ea00000 {
+			reg = <0x0 0x9ea00000 0x0 0x4080000>;
+			no-map;
+		};
+
+		/* Firmware related regions */
+		mpss_dsm_mem: mpss_dsm_region@d4d00000 {
+			reg = <0x0 0xd4d00000 0x0 0x3300000>;
+			no-map;
+		};
+
+		reserved-region@d8000000 {
+			reg = <0x0 0xd8000000 0x0 0x28000000>;
+			no-map;
+		};
+
+	};
+};
-- 
2.17.1


