Return-Path: <linux-kernel+bounces-156162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1528AFEAF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20075B24692
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF333143C69;
	Wed, 24 Apr 2024 02:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K53H4RTC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E38142902;
	Wed, 24 Apr 2024 02:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926808; cv=none; b=e29/cw/LeNE2s9M2fzx2E8AzeEw3NhStvsPLY1mA858st3BX67IYTC6RYTxFR+jYbzh8fOU59nspehzY6lC557Wi0AjAhfSt2cA/Sve09Nejc7ZmT/eWiqlafjRFy6vyU0eUizeBcqHmISDhL1ysX3g1rnu22nurQMhZp8eRoro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926808; c=relaxed/simple;
	bh=qlqjLL23VyMDj1WOAODqetm5Ivoy03njZ+jYFKFJjHw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgJIWZA5LXqAJ6QXKfPmJ5ti8DvBT2Z+LlaS7+BBGaK2DN++jZaOJHi6Tkeucm6XH7SW+qxEGfcUrasK9zgBqKi8/aglfkfnfkBiPudfHbaFAWFIAyzzbm3uDITI/LCPJ/WLxhVV2U58YexpiBlNTd36eUyNjlu5OX9TQY2utEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K53H4RTC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O2fGFM011088;
	Wed, 24 Apr 2024 02:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=bczshZ/+ZN2E6C2aTZcD9h0Eu4d8eG9ITdt2YMJyB5o=; b=K5
	3H4RTCysDnDCBbYvtt7MhpAHUSWqNt0Hg+Szoa3MeQFlh3p7RAqID7OC37nPYUHC
	7h/5w7C00Rgs+lfefzKDLNVbuwReVR+nmLdRP2CuJ/BbaQF4XChZtBnncj3kQ9hS
	Cg/2X3oL7X6JD3aWokc75ibBmax7GoYc8O1CIENslQ8afjW0H/3vUlMOzXdoRYBT
	9z5JnIJ62ff2z94d1ojESlCUvz6Ow5IGK32LJ7xsSDPmzjcavC1I+ZEDLarp2khY
	D5TqITMjywCOcoFsc32wPrKmURn3r2JCmwxxWzBDnn3BDTZQkVJWmcr/uBtt3oer
	wv+Loby0h7Tnt1zHa6+w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xppn5g9mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 02:46:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O2kYkt025023
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 02:46:34 GMT
Received: from tengfan-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Apr 2024 19:46:28 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>
CC: <keescook@chromium.org>, <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <kernel@quicinc.com>, Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v7 2/4] arm64: dts: qcom: qcs8550: introduce qcs8550 dtsi
Date: Wed, 24 Apr 2024 10:45:06 +0800
Message-ID: <20240424024508.3857602-3-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240424024508.3857602-1-quic_tengfan@quicinc.com>
References: <20240424024508.3857602-1-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5GIIRK-XYHRUWGYVIVTxqaUvtP1iEXV0
X-Proofpoint-ORIG-GUID: 5GIIRK-XYHRUWGYVIVTxqaUvtP1iEXV0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_20,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=959 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240011

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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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


