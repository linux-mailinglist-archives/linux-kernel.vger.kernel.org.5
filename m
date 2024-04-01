Return-Path: <linux-kernel+bounces-126563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A9A893980
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F36E9B21864
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B468168CD;
	Mon,  1 Apr 2024 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gSjs9vKs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2170101CE;
	Mon,  1 Apr 2024 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964366; cv=none; b=ZYoSOdVcPZ1FKI7K6zjCN4SGXgOVPppYSXl0Ppe5HParB4iA5EGFTu8VfHSfv8+l29e2Xaz3Fu17v2A5m96Yrqans/eNJUxzA/xdTdaCmCZnInlMvaZY0VfJm1xD85TRW30F4zf4et8c0NQoqyKaVGlFDe5m9YQXtHQbJq+d1uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964366; c=relaxed/simple;
	bh=nFS5aguR3NxUn2HFz/r5gE8CIlcYbyUWs2tdtA9r9CU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1vQyXtjf2PU4rfyUoDhlnMzMjYCmfy4re67hIZPaK1lhWlU+uHgH8XbjC1IoIwIoLoUvDVYsfsPWHRrxwdktYmcg7aRZIkXrdQ/av9jTwBdVEvQjpllfo1kQ+rPY+kOOoz0/T6wqSFnyZ36JNg/M3nHVPT0C22KxTaW31hOQuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gSjs9vKs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4316Vtag014493;
	Mon, 1 Apr 2024 09:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=DWS/Q5beZ3umz/Wkz34jDR3nHrGQDCvQuKx6qT0nKMw=; b=gS
	js9vKsLAB/DsPCKEG8OljxKFBVMdVOW/TEVCpYQd/O3audb3jUlRsqWKeiJ65PQJ
	MJ61BCZ4hlTVReG2+qLGsGprN+m6IUq1CcT95N1di4h4W/wM6rQxFWMVL79bkDzg
	q932U3XQPb8sZ+zPM8v5M5ctgQISVUtCyyAogByWOQ62040DR9U3grwfMW4Wuryx
	zV+s+rhEC45B4I0obJTfKG8nnK41vupHquICuq8O9CT1s5AWwS7dZP4Fh3Anm8se
	5OeXTWg9mX21t96SM3zLwTG3HDufEpf5bfZU1OQBRPtIrzRSQ6RV6nwkNrUC93fm
	5mP0CXcbwChRc3rqjCAw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x7qcvgcm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 09:39:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4319dB6d010103
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 09:39:11 GMT
Received: from tengfan-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Apr 2024 02:39:05 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <keescook@chromium.org>, <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <kernel@quicinc.com>, Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v6 RESEND 2/4] arm64: dts: qcom: qcs8550: introduce qcs8550 dtsi
Date: Mon, 1 Apr 2024 17:38:41 +0800
Message-ID: <20240401093843.2591147-3-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240401093843.2591147-1-quic_tengfan@quicinc.com>
References: <20240401093843.2591147-1-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6Yq6CGXVzIIW4Vf-W8wa-Dya0iP8PSRc
X-Proofpoint-GUID: 6Yq6CGXVzIIW4Vf-W8wa-Dya0iP8PSRc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_06,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 mlxlogscore=916 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2404010068

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
2.25.1


