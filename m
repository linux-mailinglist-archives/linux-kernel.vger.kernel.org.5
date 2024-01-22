Return-Path: <linux-kernel+bounces-33948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F438370A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A889291A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32808405D6;
	Mon, 22 Jan 2024 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bj6i+u0G"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA8E3FE20;
	Mon, 22 Jan 2024 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947140; cv=none; b=RTQkQNxONK68/pR956hwjIuhSneMCwj+vUiG0T3r7P+j+98jpDQf705i+zU6sOcbIFBfVGhOdNt46IAfm+CXri60S1ZAaswsiCKUItGiuoCo3g6i5LN6lBkKlYbBS4/ciJPbXmpDZRfyrp8o6R0PhTLhQUV6+btouTrcPR9lLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947140; c=relaxed/simple;
	bh=LgG1tppyA5POWiHSD5qT9I4ylGVHGTXWC3dKBfVz9Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JkXxGYRif7iUAp+ZDyrPALtk7gfNLhYK88fKhh6OHFQAsHqZnYYuUXINXwi52Ayfar2aErWSsoVBV+Xwx1co3b6jo7Alp2I6p88xW51ln6BL6gbb53l9htrVmxr+tcBlFCE59/E0/JFBAH9UNmWcqV8m58EhkUBgdTmIAQcJMGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Bj6i+u0G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MDuO7B010532;
	Mon, 22 Jan 2024 18:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zFRYWzTLrkU+fTF1GxslDEYA0w8JOChq8KHUrjp/w64=; b=Bj
	6i+u0G7KIkE6s6hpjIFfUoGnQ2/r2n9hdL/kQIwQsx/yaxrskFRaGp8HaBH8QqZn
	buELRGwGP57jK+B3yS4/GSN/jtQmB2je/0XL+JsPKCn8aNSTzQpPA5EXkNhRp6AW
	+J8FrF7WEfGEcmS2Q3SVZcSDih7SECPx4/Zuld93w04UFF/zx2VJmrGG7zMJPIYI
	ndYLHYOtILw28YPx/CbJw3l0p3XaP2dP9xccnKWA6vuX8l6d8atPR0BNhsUambRM
	oP6ht/av6oOcFRLdBY/MVVSAVODEadAUL0tFDGnLecks0ghAGdWO1wYCfMKsPcNT
	7MOL+1fiqHnRefbtUpWQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vsmuahesk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 18:12:14 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MICD9u004590
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 18:12:13 GMT
Received: from [10.110.104.139] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 10:12:09 -0800
Message-ID: <86ae1e20-42a4-4dd8-ab61-3395a9d0c1dc@quicinc.com>
Date: Mon, 22 Jan 2024 10:12:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: hwinfo: Add Qualcomm's board-id types
Content-Language: en-US
To: Amrit Anand <quic_amrianan@quicinc.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
 <1705749649-4708-3-git-send-email-quic_amrianan@quicinc.com>
From: Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <1705749649-4708-3-git-send-email-quic_amrianan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GbdMjHHenITBffuKF8rx3wdskWw6QBqe
X-Proofpoint-ORIG-GUID: GbdMjHHenITBffuKF8rx3wdskWw6QBqe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_07,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401220127



On 1/20/2024 3:20 AM, Amrit Anand wrote:
> Qualcomm based DT uses two or three different identifiers. The SoC
> based idenfier which signifies chipset and the revision for those
> chipsets. The board based identifier is used to distinguish different
> boards (e.g. IDP, MTP) along with the different types of same boards.
> The PMIC attached to the board can also be used as a identifier for
> device tree.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
> ---
>  .../devicetree/bindings/hwinfo/qcom,board-id.yaml  | 86 ++++++++++++++++++++++
>  include/dt-bindings/arm/qcom,ids.h                 | 68 +++++++++++++++--
>  2 files changed, 146 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml b/Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml
> new file mode 100644
> index 0000000..807f134
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwinfo/qcom,board-id.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QCOM Board Identifier for Devicetree Selection
> +
> +maintainers:
> +  - Amrit Anand <quic_amrianan@quicinc.com>
> +  - Elliot Berman <quic_eberman@quicinc.com>
> +
> +description: |
> +  Qualcomm uses two and sometimes three hardware identifiers to describe
> +  its boards
> +      - a SoC identifier is used to match chipsets (e.g. sm8550 vs sm8450)
> +      - a board identifier is used to match board form factor (e.g. MTP, QRD,
> +        ADP, CRD)
> +      - a PMIC identifier is occasionally used when different PMICs are used
> +        for a given board/SoC combination.
> +  Each field and helper macros are defined at::
> +      - include/dt-bindings/arm/qcom,ids.h
> +
> +  For example,
> +    / {
> +        #board-id-cells = <2>;
> +        board-id = <456 0>, <457 0>, <10 0>;
> +        board-id-types = "qcom,soc-id", "qcom,soc-id", "qcom,board-id";
> +     }
> +
> +allOf:
> +  - $ref: board-id.yaml#
> +

There's nothing to cause this binding to be selected.

Please add a select clause. I guess we can make it based off
whether the board's compatible contains "qcom,".

> +properties:
> +  board-id:
> +    minItems: 2
> +
> +  board-id-types:
> +    minItems: 2
> +    items:
> +      oneOf:
> +        - const: qcom,soc-id
> +          description: |
> +            Matches Qualcomm Technologies, Inc. boards with the specified SoC.
> +            2 integers are needed to describe a soc-id. The first integer is the
> +            SoC ID and the second integer is the SoC revision.
> +            qcom,soc-id = <soc-id  soc-revision>
> +        - const: qcom,board-id
> +          description: |
> +            Matches Qualcomm Technologies, Inc. boards with the specified board.
> +            2 integers are needed to describe a board-id. The first integer is the
> +            board ID. The second integer is the board-subtype.
> +            qcom,board-id = <board-id  board-subtype>
> +        - const: qcom,pmic-id
> +          description: |
> +            QUALCOMM boards can be atached to mutliple PMICs where slave-id (SID)
> +            indicates the address of the bus on which the PMIC is attached. It can be
> +            any number. The model for a PMIC indicates the PMIC name attached to bus
> +            described by SID along with  major and minor version. 2 integers are needed
> +            to describe qcom,pmic-id. The first integer is the slave-id and the second integer
> +            is the pmic model.
> +            qcom,pmic-id = <pmic-sid pmic-model>
> +
> +  '#board-id-cells':
> +    minimum: 2
> +
> +additionalProperties: true
> +
> +examples:
> +   - |
> +     #include <dt-bindings/arm/qcom,ids.h>
> +     / {
> +         model = "Qualcomm Technologies, Inc. sc7280 IDP SKU1 platform";
> +         compatible = "qcom,sc7280-idp", "google,senor", "qcom,sc7280";
> +
> +         #board-id-cells = <2>;
> +         board-id = <QCOM_SOC_ID(SC7280) QCOM_SOC_REVISION(1)>,
> +                    <QCOM_SOC_ID(SC7280) QCOM_SOC_REVISION(2)>,
> +                    <QCOM_BOARD_ID(IDP, 1, 0) QCOM_BOARD_SUBTYPE(UFS, ANY, 1)>;
> +         board-id-types = "qcom,soc-id",
> +                          "qcom,soc-id",
> +                          "qcom,board-id";
> +
> +         #address-cells = <2>;
> +         #size-cells = <2>;
> +      };
> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
> index f724834..c4cd440 100644
> --- a/include/dt-bindings/arm/qcom,ids.h
> +++ b/include/dt-bindings/arm/qcom,ids.h
> @@ -8,9 +8,12 @@
>  #define _DT_BINDINGS_ARM_QCOM_IDS_H
>  
>  /*
> - * The MSM chipset and hardware revision used by Qualcomm bootloaders, DTS for
> - * older chipsets (qcom,msm-id) and in socinfo driver:
> + * The MSM chipset ID used by Qualcomm bootloaders, DTS for
> + * older chipsets (soc-id) and in socinfo driver:
>   */
> +
> +#define QCOM_SOC_ID(a)  ((QCOM_ID_##a) && 0xffff)
> +
>  #define QCOM_ID_MSM8260			70
>  #define QCOM_ID_MSM8660			71
>  #define QCOM_ID_APQ8060			86
> @@ -266,16 +269,65 @@
>  #define QCOM_ID_IPQ5302			595
>  #define QCOM_ID_IPQ5300			624
>  
> + /* The SOC revision used by Qualcomm bootloaders (soc-revision) */
> +
> +#define QCOM_SOC_REVISION(a)		(a & 0xff)
> +
>  /*
>   * The board type and revision information, used by Qualcomm bootloaders and
> - * DTS for older chipsets (qcom,board-id):
> + * DTS for older chipsets (board-id)
>   */
> +
>  #define QCOM_BOARD_ID(a, major, minor) \
> -	(((major & 0xff) << 16) | ((minor & 0xff) << 8) | QCOM_BOARD_ID_##a)
> +	(((major & 0xff) << 16) | ((minor & 0xff) << 8) | ((QCOM_BOARD_ID_##a) & 0xff))
> +
> +#define QCOM_BOARD_ID_MTP		0x8
> +#define QCOM_BOARD_ID_DRAGONBOARD	0x10
> +#define QCOM_BOARD_ID_QRD		0x11
> +#define QCOM_BOARD_ID_HDK		0x1F
> +#define QCOM_BOARD_ID_ATP		0x21
> +#define QCOM_BOARD_ID_IDP		0x22
> +#define QCOM_BOARD_ID_SBC		0x24
> +#define QCOM_BOARD_ID_QXR		0x26
> +#define QCOM_BOARD_ID_CRD		0x28
> +
> +/*
> + * The platform subtype is used by Qualcomm bootloaders and
> + * DTS (board-subtype)
> + */
> +#define QCOM_BOARD_SUBTYPE(a, b, SUBTYPE) \
> +	(((QCOM_BOARD_BOOT_##a & 0xf) << 16) | ((QCOM_BOARD_DDRTYPE_##b & 0x7) << 8) | \
> +	(SUBTYPE & 0xff))
> +
> +/* Board DDR Type where each value indicates higher limit */
> +#define QCOM_BOARD_DDRTYPE_ANY		0x0
> +#define QCOM_BOARD_DDRTYPE_128M		0x1
> +#define QCOM_BOARD_DDRTYPE_256M		0x2
> +#define QCOM_BOARD_DDRTYPE_512M		0x3
> +#define QCOM_BOARD_DDRTYPE_1024M	0x4
> +#define QCOM_BOARD_DDRTYPE_2048M	0x5
> +#define QCOM_BOARD_DDRTYPE_3072M	0x6
> +#define QCOM_BOARD_DDRTYPE_4096M	0x7
> +
> +/* Board Boot Device Type */
> +#define QCOM_BOARD_BOOT_EMMC		0x0
> +#define QCOM_BOARD_BOOT_UFS		0x1
> +#define QCOM_BOARD_BOOT_NAND		0x2
> +#define QCOM_BOARD_BOOT_OTHER		0x3
> +
> +/*
> + * The PMIC slave id is used by Qualcomm bootloaders to
> + * indicates which PMIC is attached (pmic-sid)
> + */
> +
> +#define QCOM_PMIC_SID(a)		(a & 0xff)
> +
> +/*
> + * The PMIC ID is used by Qualcomm bootloaders to describe the ID
> + * of PMIC attached to bus described by SID (pmic-model)
> + */
>  
> -#define QCOM_BOARD_ID_MTP			8
> -#define QCOM_BOARD_ID_DRAGONBOARD		10
> -#define QCOM_BOARD_ID_QRD			11
> -#define QCOM_BOARD_ID_SBC			24
> +#define QCOM_PMIC_MODEL(ID, major, minor) \
> +	(((major & 0xff) << 16) | ((minor & 0xff) << 8) | (ID & 0xff))
>  
>  #endif /* _DT_BINDINGS_ARM_QCOM_IDS_H */

