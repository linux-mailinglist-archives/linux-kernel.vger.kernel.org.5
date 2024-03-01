Return-Path: <linux-kernel+bounces-88503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F5186E278
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56241B23D58
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B1F6F530;
	Fri,  1 Mar 2024 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B1ard/aY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8506F061;
	Fri,  1 Mar 2024 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300526; cv=none; b=bQ10ROfi0VVW3PVyR8DPlyTVQYdNFpfB0mhaXGA7E9ByiW7k4q0wfflDBWvKpPxKAKoF6suq8GaFziS7ykUqY8DPS346MH4O+9JUCRPs7igJwWE/wYBuEm1li+g7ofYMsIcGv6dSXyaTNLOwv5fShChgyJ8lyaFoW+MrcSI6ocA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300526; c=relaxed/simple;
	bh=V8mgPZdBnsipy23cZHuJhwTUXO5sg7e4FQBeqM8eRZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3WeTZD0gCR/16AyV2EMm9bBHlcB2k6QofIu7DouADXzVQYLoJcAieVufPD3XmG7lemJIrFWJzdUeP1kcFdH86ZW6U0wriXFkUtfLS/Hq/oMKz+YlSquQRBRan7Z3nUw2TH15LLzjidHujuTQ3FZffUDARw9B8zeFFSAjaOjs8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B1ard/aY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4216I3K8024542;
	Fri, 1 Mar 2024 13:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=1Vsz3tqInhENQH4MLYQM
	PbrizSmz2Hw928qw7phVLY0=; b=B1ard/aY9/RMYoC9TCaL/pnAd74pa1IbWiuV
	xjQkpaTcedcuFssdIABg8/k/ZZvTyrFmr4C5JAIV/B++SRrIBcTZwrJrswrNBWJk
	bpui5NQn8ObYA0aIsKrRplC4wY5KGhWPuLrDkyePIIXwO/BL/f212XBt8JAOCfCH
	+i4YOsJ6K6pis+sFeCeXwcCdBLAKR4+v5p9Wt72oGVKAe4UYtjShRO5dXUTSpE6l
	TY2/baZ7d7jInjTiYj2jsI8e4N+h28VQAKTQoMdzQWEspKbGBGMVa2ZkaR9jhm+A
	lpa/dcgQM5w8mvILYEfgNV67HV/Vu+Rys/IHP3Xxcf6pARyG+g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wk9hp114r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 13:42:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 421Dg0Dg002288
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Mar 2024 13:42:00 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Mar 2024 05:41:54 -0800
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>
CC: <keescook@chromium.org>, <tony.luck@intel.com>, <gpiccoli@igalia.co>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <kernel@quicinc.com>, Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v5 2/4] arm64: dts: qcom: qcs8550: introduce qcs8550 dtsi
Date: Fri, 1 Mar 2024 21:41:11 +0800
Message-ID: <20240301134113.14423-3-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240301134113.14423-1-quic_tengfan@quicinc.com>
References: <20240301134113.14423-1-quic_tengfan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: k31XFZ2CgO78C_58T7axbP7KR8Rt5vtg
X-Proofpoint-GUID: k31XFZ2CgO78C_58T7axbP7KR8Rt5vtg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_13,2024-03-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 mlxlogscore=932 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403010114

QCS8550 is derived from SM8550. The differnece between SM8550 and
QCS8550 is QCS8550 doesn't have modem RF system. QCS8550 is mainly used
in IoT scenarios.
QCS8550 firmware has different memory map with SM8550 firmware. The
memory map will be runtime added through bootloader.
There are 3 types of reserved memory regions here:
1. Firmware related regions which aren't shared with kernel.
    The device tree source in kernel doesn't need to have node to indicate
the firmware related reserved information. OS bootloader conveys the
information by update device tree in runtime.
    This will be described as: UEFI saves the physical address of the
UEFI System Table to dts file's chosen node. Kernel read this table and
add reserved memory regions to efi config table. Current reserved memory
region may have reserved region which was not yet used, release note of
the firmware have such kind of information.
2. Firmware related memory regions which are shared with Kernel
    Each region has a specific node with specific label name for later
phandle reference from other driver dt node.
3. PIL regions.
    PIL regions will be reserved and then assigned to subsystem firmware
later.
Here is a reserved memory map for this platform:
0x100000000 +------------------+
            |                  |
            | Firmware Related |
            |                  |
 0xd4d00000 +------------------+
            |                  |
            | Kernel Available |
            |                  |
 0xa7000000 +------------------+
            |                  |
            |    PIL Region    |
            |                  |
 0x8a800000 +------------------+
            |                  |
            | Firmware Related |
            |                  |
 0x80000000 +------------------+
Note that:
0xa7000000..0xA8000000 is used by bootloader, when kernel boot up,
it is available for kernel usage. This region is not suggested to be
used by kernel features like ramoops, suspend resume etc.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs8550.dtsi | 169 ++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550.dtsi

diff --git a/arch/arm64/boot/dts/qcom/qcs8550.dtsi b/arch/arm64/boot/dts/qcom/qcs8550.dtsi
new file mode 100644
index 000000000000..a3ebf3d4e16d
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qcs8550.dtsi
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
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
+
+		/* These are 3 types of reserved memory regions here:
+		 * 1. Firmware related regions which aren't shared with kernel.
+		 *     The device tree source in kernel doesn't need to have node to
+		 * indicate the firmware related reserved information. OS bootloader
+		 * conveys the information by update device tree in runtime.
+		 *     This will be described as: UEFI saves the physical address of
+		 * the UEFI System Table to dts file's chosen node. Kernel read this
+		 * table and add reserved memory regions to efi config table. Current
+		 * reserved memory region may have reserved region which was not yet
+		 * used, release note of the firmware have such kind of information.
+		 * 2. Firmware related memory regions which are shared with Kernel.
+		 *     Each region has a specific node with specific label name for
+		 * later phandle reference from other driver dt node.
+		 * 3. PIL regions.
+		 *     PIL regions will be reserved and then assigned to subsystem
+		 * firmware later.
+		 * Here is a reserved memory map for this platform:
+		 * 0x100000000 +------------------+
+		 *             |                  |
+		 *             | Firmware Related |
+		 *             |                  |
+		 *  0xd4d00000 +------------------+
+		 *             |                  |
+		 *             | Kernel Available |
+		 *             |                  |
+		 *  0xa7000000 +------------------+
+		 *             |                  |
+		 *             |    PIL Region    |
+		 *             |                  |
+		 *  0x8a800000 +------------------+
+		 *             |                  |
+		 *             | Firmware Related |
+		 *             |                  |
+		 *  0x80000000 +------------------+
+		 * Note that:
+		 * 0xa7000000..0xA8000000 is used by bootloader, when kernel boot up,
+		 * it is available for kernel usage. This region is not suggested to
+		 * be used by kernel features like ramoops, suspend resume etc.
+		 */
+
+		/*
+		 * Firmware related regions, bootlader will possible reserve parts of
+		 * region from 0x80000000..0x8a800000.
+		 */
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
+		/*
+		 * Firmware related regions, bootlader will possible reserve parts of
+		 * region from 0xd8000000..0x100000000.
+		 */
+		mpss_dsm_mem: mpss_dsm_region@d4d00000 {
+			reg = <0x0 0xd4d00000 0x0 0x3300000>;
+			no-map;
+		};
+	};
+};
-- 
2.17.1


