Return-Path: <linux-kernel+bounces-33946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 842DD837080
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124B21F2A527
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D6156B6E;
	Mon, 22 Jan 2024 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RdccNVhK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0A755C1C;
	Mon, 22 Jan 2024 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947034; cv=none; b=QFp6lNN6HuhqCtn/q+j9R20nSHVnrUbuHFkfRqRFFTJ22JV25VJcu7pNZzTy9Z4RN+fEJYQKe+C2GLSEabWWtbMO/JNOzw12LRvN2XuWBNCBG6ebexVYFWoAWFOXmIkaykcDyh7qHj4ebIIbJOAKgiEVrDzY0P/GJsnFpBlE0vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947034; c=relaxed/simple;
	bh=Xusyv3mBYFLW+DNBPX8VAqokOl7QRg+X35ewNVGZS6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P7R6vPs5gwo/UQK4KggRW/vWbssgIL/PH5gS1Os9XoCo/5fUx6yz0vYgtbWFZkOqiRVz9sBK7CLCCduHI1bKO+YEDuvLQnqxuwoRuZ5SIbxYYMm68pae8LaOyissY72c0uaD2FlsZjJMx1263o2zTvANBHaT2kOXnIzDupOVYns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RdccNVhK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MFoJnE006867;
	Mon, 22 Jan 2024 18:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=egVvBAlS2e19BKe70ueRMcJh/S6ha3Y7vrwBm+Ktx0s=; b=Rd
	ccNVhKjVZL8P+itVGfIATo6FLe/lnojmalcvpdrBx/BIED/AycRBLgGcm2TH3bVG
	YfTWAiwXKiTEkI/aQJApXj8bGXDUtPEA7R1Fm+W1ICRcdMOK+9i+TxwhrGoR44vb
	vajrRh0Y8Nk0eQVIPpy4ulVnyZaOLIWpfUsGkheKH8j2VR9WqGtzcqdBXROWrCNE
	tKAAosjQNQUFZ25WitEMtyrneo7AjKvz0LVF2dmTYM4r6lRyHzMPSA5iEe7owBWj
	ghPmkuf3nwBqNFVEl0Rhdz7p4d2kZu6PFxHc+hguP1zPShEMwNOZyFrwWOEanfVF
	dUrvUTlFuFUDemMnS5+A==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vst8w8h6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 18:10:27 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MIARYi014026
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 18:10:27 GMT
Received: from [10.110.104.139] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 10:10:23 -0800
Message-ID: <065601d3-92e7-46cc-a7aa-116cd02b3c36@quicinc.com>
Date: Mon, 22 Jan 2024 10:10:22 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: hwinfo: Add Qualcomm's board-id types
Content-Language: en-US
To: Amrit Anand <quic_amrianan@quicinc.com>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
 <1705749649-4708-3-git-send-email-quic_amrianan@quicinc.com>
 <54426665-90c5-4355-a174-f512004e11e5@linaro.org>
 <391f8f48-d1f5-702d-20d4-ae8b8a7ace58@quicinc.com>
From: Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <391f8f48-d1f5-702d-20d4-ae8b8a7ace58@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qOUMnVfP2JRU_numX321G8M85lX_W9GY
X-Proofpoint-ORIG-GUID: qOUMnVfP2JRU_numX321G8M85lX_W9GY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_07,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220127



On 1/22/2024 2:07 AM, Amrit Anand wrote:
> 
> On 1/20/2024 7:02 PM, Konrad Dybcio wrote:
>> On 20.01.2024 12:20, Amrit Anand wrote:
>>> Qualcomm based DT uses two or three different identifiers. The SoC
>>> based idenfier which signifies chipset and the revision for those
>>> chipsets. The board based identifier is used to distinguish different
>>> boards (e.g. IDP, MTP) along with the different types of same boards.
>>> The PMIC attached to the board can also be used as a identifier for
>>> device tree.
>>>
>>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>>> Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
>>> ---
>>>   .../devicetree/bindings/hwinfo/qcom,board-id.yaml  | 86 ++++++++++++++++++++++
>>>   include/dt-bindings/arm/qcom,ids.h                 | 68 +++++++++++++++--
>>>   2 files changed, 146 insertions(+), 8 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml b/Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml
>>> new file mode 100644
>>> index 0000000..807f134
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml
>>> @@ -0,0 +1,86 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/hwinfo/qcom,board-id.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: QCOM Board Identifier for Devicetree Selection
>>> +
>>> +maintainers:
>>> +  - Amrit Anand <quic_amrianan@quicinc.com>
>>> +  - Elliot Berman <quic_eberman@quicinc.com>
>>> +
>>> +description: |
>> The '|'s are unnecessary in both commits, IIRC they're used for
>> preserving formatting which we don't really need for non-styled
>> plaintext
> Sure, will do.
>>> +  Qualcomm uses two and sometimes three hardware identifiers to describe
>>> +  its boards
>>> +      - a SoC identifier is used to match chipsets (e.g. sm8550 vs sm8450)
>>> +      - a board identifier is used to match board form factor (e.g. MTP, QRD,
>>> +        ADP, CRD)
>>> +      - a PMIC identifier is occasionally used when different PMICs are used
>>> +        for a given board/SoC combination.
>>> +  Each field and helper macros are defined at::
>>> +      - include/dt-bindings/arm/qcom,ids.h
>>> +
>>> +  For example,
>>> +    / {
>>> +        #board-id-cells = <2>;
>>> +        board-id = <456 0>, <457 0>, <10 0>;
>>> +        board-id-types = "qcom,soc-id", "qcom,soc-id", "qcom,board-id";
>>> +     }
>>> +
>>> +allOf:
>>> +  - $ref: board-id.yaml#
>>> +
>>> +properties:
>>> +  board-id:
>>> +    minItems: 2
>> I believe some older platforms match exclusively based on socid, so
>> perhaps 1 would be okay as well.
>>
>> [...]
> 
> Ok, considering legacy targets we can make it 1.
> 
> But i think ideally it should always be recommended to have a board ID associated with a SoC ID, correct me if my understanding is wrong.
> 

There is no "legacy" support needed here: Qualcomm's bootloaders
need to be updated to adhere to the new proposed spec. I suppose
we need to consider whether we have targets that only need SoC to
differentiate?

>>> +examples:
>>> +   - |
>>> +     #include <dt-bindings/arm/qcom,ids.h>
>>> +     / {
>>> +         model = "Qualcomm Technologies, Inc. sc7280 IDP SKU1 platform";
>>> +         compatible = "qcom,sc7280-idp", "google,senor", "qcom,sc7280";
>>> +
>>> +         #board-id-cells = <2>;
>>> +         board-id = <QCOM_SOC_ID(SC7280) QCOM_SOC_REVISION(1)>,
>>> +                    <QCOM_SOC_ID(SC7280) QCOM_SOC_REVISION(2)>,
>>> +                    <QCOM_BOARD_ID(IDP, 1, 0) QCOM_BOARD_SUBTYPE(UFS, ANY, 1)>;
>>> +         board-id-types = "qcom,soc-id",
>>> +                          "qcom,soc-id",
>>> +                          "qcom,board-id";
>> So, would the matching here would be:
>>
>> loop over disctinct board-id-types
>>     check if there's at least 1 match for all of them
>>         use this dtb if that's the case
>>
>> stop booting / "best guess match"
>>
>> ?
>>
>> [...]
> 
> Yes, But the "if" checking would have preference in place.
> The preference logic would look something like this,
> 
> First will check for SoC-ID, if we have an exact match for SoC-ID then will proceed for board-ID match. Otherwise the DT would be discarded.
> Once (exact) board-ID found, will proceed for subtype , pmic and so on.
> Exact match and best match logic is used. Parameters like SoC-ID, board-ID are required to be best matched. Other few fields follow best match logic and best of the DT can be picked.
> 
>>> +#define QCOM_BOARD_ID_MTP        0x8
>>> +#define QCOM_BOARD_ID_DRAGONBOARD    0x10
>>> +#define QCOM_BOARD_ID_QRD        0x11
>>> +#define QCOM_BOARD_ID_HDK        0x1F
>>> +#define QCOM_BOARD_ID_ATP        0x21
>>> +#define QCOM_BOARD_ID_IDP        0x22
>>> +#define QCOM_BOARD_ID_SBC        0x24
>>> +#define QCOM_BOARD_ID_QXR        0x26
>>> +#define QCOM_BOARD_ID_CRD        0x28
>> Missing ADP/QCP/Ride (if they're separate)
> 
> Sure, will update. Would need to work with teams.

There are probably more boards that we aren't aware of.

Amrit, please add board IDs for all the boards that are
in kernel.org.

