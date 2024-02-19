Return-Path: <linux-kernel+bounces-71060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AAC85A029
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DCB6281C10
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B0D2560B;
	Mon, 19 Feb 2024 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HJ7n9Uip"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E7C2560C;
	Mon, 19 Feb 2024 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336146; cv=none; b=EMzI/D7EpSOK+O0WPQav9WZU61ff3O+cYE1GZd4l59GwPirqCVNnw+XJFsmYvzSPVhOpPa8GQsCBTXFXZLVBnNp52AKEBLg4S+SCnhlZyVQCQsgs8u/0gzyP0aMqkijQL+TIdvyQ+5NuZ+Cx1DptW4uGPk643XDQMxRowytkOc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336146; c=relaxed/simple;
	bh=/eCKRkVRj7kxqwcWVvNqhiFlyUIOOWqO9I4aj7/YHfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LVm/OpfEEtemTIm7or1D8+E/6ydTF9gglkf5EgEL5jPU4wyoH5UQdl6ak5EyUtAShPlc8LDsSuiGDRQJFy8jAnXKacRu+K4QZq+WQM9AQWwIEwUstlHuC1eVqHMzJOubRmPWvBECxlIixNxz9AWOFgteW4OL0x9y95dksWQCho4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HJ7n9Uip; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41J8fPrF014557;
	Mon, 19 Feb 2024 09:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6o2e94fPw47nGwPn62EgcEzG4EtOWh5DScFrQ8Ht47s=; b=HJ
	7n9Uip9+bqyev3z32V8c+EzdDMWRg+D3sQvWZWAgKM6/cQCMLuD4Khpt47TNq9D9
	Z51OYZ9OVIEVvPYTUJCmACsy55BLZm81IRPwyRjsCc8EDYXwmpTt2QUjVtjMsk/u
	1rgo6jkw/rd7hBSM3D9tLUwFuDrwuuxqUm/mbn+cTf8XSd7AhZhECVqccNFxl7xH
	yF/gfrwmcIbR2fL8P9WTHL2NIiRR7sbX6OIzKRe45/l4kK+m6Yzpif3PfdomLzIb
	YVbVQ0TD3ZwQOE2+Lq53iinUb8WcEDBR+YagenvKVANFWfQyv0jJX+fux+4/84g8
	2vTQa3YWDSfeTzKWkXGQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wc3pr849w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 09:48:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41J9mvXf012255
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 09:48:57 GMT
Received: from [10.214.82.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 19 Feb
 2024 01:48:53 -0800
Message-ID: <fce70468-05fb-4f51-a653-7921dd27bc6b@quicinc.com>
Date: Mon, 19 Feb 2024 15:18:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SM7150 DT
 bindings
Content-Language: en-US
To: Danila Tikhonov <danila@jiaxyga.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240218183239.85319-1-danila@jiaxyga.com>
 <20240218183239.85319-2-danila@jiaxyga.com>
From: Naman Jain <quic_namajain@quicinc.com>
In-Reply-To: <20240218183239.85319-2-danila@jiaxyga.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BGjAMdod1Y68q8xhSstLNGyPnl0bSz3V
X-Proofpoint-GUID: BGjAMdod1Y68q8xhSstLNGyPnl0bSz3V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_06,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402190073

On 2/19/2024 12:02 AM, Danila Tikhonov wrote:
> The Qualcomm SM7150 platform has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.

Please add what you are trying to do with this patch.

Ref: 
https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

Regards,
Naman Jain

> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>   .../interconnect/qcom,sm7150-rpmh.yaml        |  88 ++++++++++
>   .../interconnect/qcom,sm7150-rpmh.h           | 150 ++++++++++++++++++
>   2 files changed, 238 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
>   create mode 100644 include/dt-bindings/interconnect/qcom,sm7150-rpmh.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
> new file mode 100644
> index 000000000000..604822ed4adc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,sm7150-rpmh.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm RPMh Network-On-Chip Interconnect on SM7150
> +
> +maintainers:
> +  - Danila Tikhonov <danila@jiaxyga.com>
> +
> +description: |
> +  RPMh interconnect providers support system bandwidth requirements through
> +  RPMh hardware accelerators known as Bus Clock Manager (BCM).
> +
> +  See also:: include/dt-bindings/interconnect/qcom,sm7150-rpmh.h
> +
> +allOf:
> +  - $ref: qcom,rpmh-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sm7150-aggre1-noc
> +      - qcom,sm7150-aggre2-noc
> +      - qcom,sm7150-compute-noc
> +      - qcom,sm7150-config-noc
> +      - qcom,sm7150-dc-noc
> +      - qcom,sm7150-gem-noc
> +      - qcom,sm7150-mc-virt
> +      - qcom,sm7150-mmss-noc
> +      - qcom,sm7150-system-noc
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#interconnect-cells': true
> +
> +# Child node's properties
> +patternProperties:
> +  '^interconnect-[0-9]+$':
> +    type: object
> +    description:
> +      The interconnect providers do not have a separate QoS register space,
> +      but share parent's space.
> +
> +    allOf:
> +      - $ref: qcom,rpmh-common.yaml#
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - qcom,sm7150-camnoc-virt
> +
> +      '#interconnect-cells': true
> +
> +    required:
> +      - compatible
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mc_virt: interconnect@1380000 {
> +        compatible = "qcom,sm7150-mc-virt";
> +        reg = <0x01380000 0x40000>;
> +        #interconnect-cells = <2>;
> +        qcom,bcm-voters = <&apps_bcm_voter>;
> +    };
> +
> +    system_noc: interconnect@1620000 {
> +        compatible = "qcom,sm7150-system-noc";
> +        reg = <0x01620000 0x40000>;
> +        #interconnect-cells = <2>;
> +        qcom,bcm-voters = <&apps_bcm_voter>;
> +
> +        camnoc_virt: interconnect-0 {
> +            compatible = "qcom,sm7150-camnoc-virt";
> +            #interconnect-cells = <2>;
> +            qcom,bcm-voters = <&apps_bcm_voter>;
> +        };
> +    };
> diff --git a/include/dt-bindings/interconnect/qcom,sm7150-rpmh.h b/include/dt-bindings/interconnect/qcom,sm7150-rpmh.h
> new file mode 100644
> index 000000000000..1f610eb832aa
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,sm7150-rpmh.h
> @@ -0,0 +1,150 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
> +/*
> + * Qualcomm SM7150 interconnect IDs
> + *
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2024, Danila Tikhonov <danila@jiaxyga.com>
> + */
> +
> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM7150_H
> +#define __DT_BINDINGS_INTERCONNECT_QCOM_SM7150_H
> +
> +#define MASTER_A1NOC_CFG		0
> +#define MASTER_QUP_0			1
> +#define MASTER_TSIF			2
> +#define MASTER_EMMC			3
> +#define MASTER_SDCC_2			4
> +#define MASTER_SDCC_4			5
> +#define MASTER_UFS_MEM			6
> +#define A1NOC_SNOC_SLV			7
> +#define SLAVE_SERVICE_A1NOC		8
> +
> +#define MASTER_A2NOC_CFG		0
> +#define MASTER_QDSS_BAM			1
> +#define MASTER_QUP_1			2
> +#define MASTER_CNOC_A2NOC		3
> +#define MASTER_CRYPTO_CORE_0		4
> +#define MASTER_IPA			5
> +#define MASTER_PCIE			6
> +#define MASTER_QDSS_ETR			7
> +#define MASTER_USB3			8
> +#define A2NOC_SNOC_SLV			9
> +#define SLAVE_ANOC_PCIE_GEM_NOC		10
> +#define SLAVE_SERVICE_A2NOC		11
> +
> +#define MASTER_CAMNOC_HF0_UNCOMP	0
> +#define MASTER_CAMNOC_RT_UNCOMP		1
> +#define MASTER_CAMNOC_SF_UNCOMP		2
> +#define MASTER_CAMNOC_NRT_UNCOMP	3
> +#define SLAVE_CAMNOC_UNCOMP		4
> +
> +#define MASTER_NPU			0
> +#define SLAVE_CDSP_GEM_NOC		1
> +
> +#define MASTER_SPDM			0
> +#define SNOC_CNOC_MAS			1
> +#define MASTER_QDSS_DAP			2
> +#define SLAVE_A1NOC_CFG			3
> +#define SLAVE_A2NOC_CFG			4
> +#define SLAVE_AHB2PHY_NORTH		5
> +#define SLAVE_AHB2PHY_SOUTH		6
> +#define SLAVE_AHB2PHY_WEST		7
> +#define SLAVE_AOP			8
> +#define SLAVE_AOSS			9
> +#define SLAVE_CAMERA_CFG		10
> +#define SLAVE_CAMERA_NRT_THROTTLE_CFG	11
> +#define SLAVE_CAMERA_RT_THROTTLE_CFG	12
> +#define SLAVE_CLK_CTL			13
> +#define SLAVE_CDSP_CFG			14
> +#define SLAVE_RBCPR_CX_CFG		15
> +#define SLAVE_RBCPR_MX_CFG		16
> +#define SLAVE_CRYPTO_0_CFG		17
> +#define SLAVE_CNOC_DDRSS		18
> +#define SLAVE_DISPLAY_CFG		19
> +#define SLAVE_DISPLAY_THROTTLE_CFG	20
> +#define SLAVE_EMMC_CFG			21
> +#define SLAVE_GLM			22
> +#define SLAVE_GRAPHICS_3D_CFG		23
> +#define SLAVE_IMEM_CFG			24
> +#define SLAVE_IPA_CFG			25
> +#define SLAVE_CNOC_MNOC_CFG		26
> +#define SLAVE_PCIE_CFG			27
> +#define SLAVE_PDM			28
> +#define SLAVE_PIMEM_CFG			29
> +#define SLAVE_PRNG			30
> +#define SLAVE_QDSS_CFG			31
> +#define SLAVE_QUP_0			32
> +#define SLAVE_QUP_1			33
> +#define SLAVE_SDCC_2			34
> +#define SLAVE_SDCC_4			35
> +#define SLAVE_SNOC_CFG			36
> +#define SLAVE_SPDM_WRAPPER		37
> +#define SLAVE_TCSR			38
> +#define SLAVE_TLMM_NORTH		39
> +#define SLAVE_TLMM_SOUTH		40
> +#define SLAVE_TLMM_WEST			41
> +#define SLAVE_TSIF			42
> +#define SLAVE_UFS_MEM_CFG		43
> +#define SLAVE_USB3			44
> +#define SLAVE_VENUS_CFG			45
> +#define SLAVE_VENUS_CVP_THROTTLE_CFG	46
> +#define SLAVE_VENUS_THROTTLE_CFG	47
> +#define SLAVE_VSENSE_CTRL_CFG		48
> +#define SLAVE_CNOC_A2NOC		49
> +#define SLAVE_SERVICE_CNOC		50
> +
> +#define MASTER_CNOC_DC_NOC		0
> +#define SLAVE_GEM_NOC_CFG		1
> +#define SLAVE_LLCC_CFG			2
> +
> +#define MASTER_AMPSS_M0			0
> +#define MASTER_SYS_TCU			1
> +#define MASTER_GEM_NOC_CFG		2
> +#define MASTER_COMPUTE_NOC		3
> +#define MASTER_MNOC_HF_MEM_NOC		4
> +#define MASTER_MNOC_SF_MEM_NOC		5
> +#define MASTER_GEM_NOC_PCIE_SNOC	6
> +#define MASTER_SNOC_GC_MEM_NOC		7
> +#define MASTER_SNOC_SF_MEM_NOC		8
> +#define MASTER_GRAPHICS_3D		9
> +#define SLAVE_MSS_PROC_MS_MPU_CFG	10
> +#define SLAVE_GEM_NOC_SNOC		11
> +#define SLAVE_LLCC			12
> +#define SLAVE_SERVICE_GEM_NOC		13
> +
> +
> +#define MASTER_LLCC			0
> +#define SLAVE_EBI_CH0			1
> +
> +#define MASTER_CNOC_MNOC_CFG		0
> +#define MASTER_CAMNOC_HF0		1
> +#define MASTER_CAMNOC_NRT		2
> +#define MASTER_CAMNOC_RT		3
> +#define MASTER_CAMNOC_SF		4
> +#define MASTER_MDP_PORT0		5
> +#define MASTER_MDP_PORT1		6
> +#define MASTER_ROTATOR			7
> +#define MASTER_VIDEO_P0			8
> +#define MASTER_VIDEO_P1			9
> +#define MASTER_VIDEO_PROC		10
> +#define SLAVE_MNOC_SF_MEM_NOC		11
> +#define SLAVE_MNOC_HF_MEM_NOC		12
> +#define SLAVE_SERVICE_MNOC		13
> +
> +#define MASTER_SNOC_CFG			0
> +#define A1NOC_SNOC_MAS			1
> +#define A2NOC_SNOC_MAS			2
> +#define MASTER_GEM_NOC_SNOC		3
> +#define MASTER_PIMEM			4
> +#define MASTER_GIC			5
> +#define SLAVE_APPSS			6
> +#define SNOC_CNOC_SLV			7
> +#define SLAVE_SNOC_GEM_NOC_GC		8
> +#define SLAVE_SNOC_GEM_NOC_SF		9
> +#define SLAVE_OCIMEM			10
> +#define SLAVE_PIMEM			11
> +#define SLAVE_SERVICE_SNOC		12
> +#define SLAVE_QDSS_STM			13
> +#define SLAVE_TCU			14
> +
> +#endif


