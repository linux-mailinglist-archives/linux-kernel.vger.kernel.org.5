Return-Path: <linux-kernel+bounces-160158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFE88B39FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2EE5B21035
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA4D14EC5F;
	Fri, 26 Apr 2024 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OWiQs0Y+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B700814884C;
	Fri, 26 Apr 2024 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141637; cv=none; b=ScKtHM3QuutDxfo+JrGByBYRtPh9U9+GHBRureHarDRFwhy/ZpBp/2knP7UiiKcAtNxqnOWm4Ep9X69VX3YBGKr67s9fUru0EmOnulghLuQkYIX5X4xXxrsLwB4tGlQuJRfVkB69kwNdhY9BcK3s0O68CVbEciJg1HjMTiX31xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141637; c=relaxed/simple;
	bh=kBeI3sp3mXMadZ7jRTDexEqrXzzu7Lpzk7zR5WSE3ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D+DkJTYsnSxX2PmDv+oYaEq3yLfrzRi1YFLUXK3ZC5c8y9bu7e4vDYqgy2BLTXohCvjf1MvVE27VkMeTvFbTqT97KdiDCNWNRU+s5bFQxhfd4YT7DGYgJ1xxuowfml6MNyuz7jhTo2RC3lFSppDnVqMACVWVAmamWfEkST6qBlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OWiQs0Y+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43QApoFI012994;
	Fri, 26 Apr 2024 14:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Fb2vf9mu0Wt2OchcXVnA335lXG9jz+XpRSg+ZnSNp1Y=; b=OW
	iQs0Y+/m3ZBYdHkp62LZTzuFLNmTc2zzziuUvarrcEVf593pNXO1IvhqUtmGiwEI
	Hch7KadMk1bqnT798NSLB02UX2lwF4WoyVa1RRYV53AIaTUQUMOV1luF++sCcpP1
	zfg3ah/Vld1fGzpUikHovS0uCEp1nHeWsN+eeeg336Ze91yEuVZVhnAgSuM1AqKR
	46qrQhOWMbaxpFmO1GBGlastq9utYBZq+ZkFcu4GzG+JbQ+KYjo9Qkn+EpsToxdU
	SHOoXFK83ZkuwLV0PAzVGACF2aXDpe3/kEwFJmUJulqX7jI10s3yxVs1PKMOFcvx
	Ag/qHyTyiQ1TX4njnnsg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xr35922pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 14:27:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43QER9Ap014540
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 14:27:09 GMT
Received: from [10.216.28.217] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 26 Apr
 2024 07:27:03 -0700
Message-ID: <dfcaa665-512a-4c7c-8f5d-2ba819797ddb@quicinc.com>
Date: Fri, 26 Apr 2024 19:56:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 RESEND 1/6] dt-bindings: clock: qcom: Add SM8650 video
 clock controller
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        "Satya
 Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
References: <20240321092529.13362-1-quic_jkona@quicinc.com>
 <20240321092529.13362-2-quic_jkona@quicinc.com>
 <CAA8EJppsMchthssctEgUf9q45j84cSLQ78Ur+vaA0Z7GEQi8+g@mail.gmail.com>
 <725471b1-46a9-43b0-bede-33f01c953d51@quicinc.com>
 <c3ea22ed-5750-438f-89d5-e56f908ba835@linaro.org>
 <73c5ffca-9275-437c-a49e-ef3251c8d313@quicinc.com>
 <d160289a-d0c7-498e-88b2-89861ab9fa50@linaro.org>
Content-Language: en-US
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <d160289a-d0c7-498e-88b2-89861ab9fa50@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p8vmHFzwkM4WbaO-Qnc-QZK4YkA2fYTx
X-Proofpoint-ORIG-GUID: p8vmHFzwkM4WbaO-Qnc-QZK4YkA2fYTx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404260096



On 4/25/2024 7:02 PM, Vladimir Zapolskiy wrote:
> Hi Jagadeesh,
> 
> On 4/22/24 14:00, Jagadeesh Kona wrote:
>>
>> On 4/19/2024 2:31 AM, Vladimir Zapolskiy wrote:
>>> Hello Jagadeesh,
>>>
>>> On 3/25/24 08:07, Jagadeesh Kona wrote:
>>>>
>>>>
>>>> On 3/21/2024 6:42 PM, Dmitry Baryshkov wrote:
>>>>> On Thu, 21 Mar 2024 at 11:26, Jagadeesh Kona <quic_jkona@quicinc.com>
>>>>> wrote:
>>>>>>
>>>>>> Extend device tree bindings of SM8450 videocc to add support
>>>>>> for SM8650 videocc. While it at, fix the incorrect header
>>>>>> include in sm8450 videocc yaml documentation.
>>>>>>
>>>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>> ---
>>>>>>     .../devicetree/bindings/clock/qcom,sm8450-videocc.yaml    | 4 
>>>>>> +++-
>>>>>>     include/dt-bindings/clock/qcom,sm8450-videocc.h           | 8
>>>>>> +++++++-
>>>>>>     2 files changed, 10 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git
>>>>>> a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>>>>>> b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>>>>>> index bad8f019a8d3..79f55620eb70 100644
>>>>>> --- 
>>>>>> a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>>>>>> +++ 
>>>>>> b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>>>>>> @@ -8,18 +8,20 @@ title: Qualcomm Video Clock & Reset Controller on
>>>>>> SM8450
>>>>>>
>>>>>>     maintainers:
>>>>>>       - Taniya Das <quic_tdas@quicinc.com>
>>>>>> +  - Jagadeesh Kona <quic_jkona@quicinc.com>
>>>>>>
>>>>>>     description: |
>>>>>>       Qualcomm video clock control module provides the clocks, resets
>>>>>> and power
>>>>>>       domains on SM8450.
>>>>>>
>>>>>> -  See also:: include/dt-bindings/clock/qcom,videocc-sm8450.h
>>>>>> +  See also:: include/dt-bindings/clock/qcom,sm8450-videocc.h
>>>>>
>>>>> This almost pleads to go to a separate patch. Fixes generally should
>>>>> be separated from the rest of the changes.
>>>>>
>>>>
>>>> Thanks Dmitry for your review.
>>>>
>>>> Sure, will separate this into a separate patch in next series.
>>>>
>>>>>>
>>>>>>     properties:
>>>>>>       compatible:
>>>>>>         enum:
>>>>>>           - qcom,sm8450-videocc
>>>>>>           - qcom,sm8550-videocc
>>>>>> +      - qcom,sm8650-videocc
>>>>>>
>>>>>>       reg:
>>>>>>         maxItems: 1
>>>>>> diff --git a/include/dt-bindings/clock/qcom,sm8450-videocc.h
>>>>>> b/include/dt-bindings/clock/qcom,sm8450-videocc.h
>>>>>> index 9d795adfe4eb..ecfebe52e4bb 100644
>>>>>> --- a/include/dt-bindings/clock/qcom,sm8450-videocc.h
>>>>>> +++ b/include/dt-bindings/clock/qcom,sm8450-videocc.h
>>>>>> @@ -1,6 +1,6 @@
>>>>>>     /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>>>>>     /*
>>>>>> - * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights
>>>>>> reserved.
>>>>>> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All
>>>>>> rights reserved.
>>>>>>      */
>>>>>>
>>>>>>     #ifndef _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM8450_H
>>>>>> @@ -19,6 +19,11 @@
>>>>>>     #define
>>>>>> VIDEO_CC_MVS1C_DIV2_DIV_CLK_SRC                                9
>>>>>>     #define VIDEO_CC_PLL0                                          10
>>>>>>     #define VIDEO_CC_PLL1                                          11
>>>>>> +#define
>>>>>> VIDEO_CC_MVS0_SHIFT_CLK                                        12
>>>>>> +#define VIDEO_CC_MVS0C_SHIFT_CLK                               13
>>>>>> +#define
>>>>>> VIDEO_CC_MVS1_SHIFT_CLK                                        14
>>>>>> +#define VIDEO_CC_MVS1C_SHIFT_CLK                               15
>>>>>> +#define VIDEO_CC_XO_CLK_SRC                                    16
>>>>>
>>>>> Are these values applicable to sm8450?
>>>>>
>>>>
>>>> No, the shift clocks above are part of SM8650 only. To reuse the
>>>> existing SM8550 videocc driver for SM8650 and to register these shift
>>>> clocks for SM8650, I added them here.
>>>>
>>>
>>> In such case I'd strongly suggest to add a new qcom,sm8650-videocc.h 
>>> file,
>>> and do #include qcom,sm8450-videocc.h in it, thus the new header will be
>>> really a short one.
>>>
>>> This will add pristine clarity.
>>>
>>
>> Thanks Vladimir for your suggestion. I believe adding a comment for
>> these set of clocks should be sufficient to indicate these clocks are
>> applicable only for SM8650, I can add the required comment and post the
>> next series. Please let me know if this works?
> 
> Well, I didn't get any new information to abandon my suggestion, what is
> wrong with it or why is it less preferable?
> 
> Even if you add a comment in the header file, it means that for SM8450
> platforms you'll begin to define inapplicable/unrelated macro for the
> platform, which opens a small risk of the misusage, and which can be
> easily avoided. I believe that the clarity is better for maintenance.
> 

Yes, I agree. Will check and move these new clocks to a separate header 
file in next series. Thanks!

Thanks,
Jagadeesh

