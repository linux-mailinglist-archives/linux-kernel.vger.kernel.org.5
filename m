Return-Path: <linux-kernel+bounces-153257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F108ACB95
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858FA1C220BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41A314601A;
	Mon, 22 Apr 2024 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n0pOiHkI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F2F145FF1;
	Mon, 22 Apr 2024 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783644; cv=none; b=nvNbo7EVnW3lHhjCcpVAuPUOjT39kTsV5iTm+xnv3nHTIYPi1rnA+fsqIUQGL4t44Fwoof/kWD6RacB7FpP51g9ax70QjvhR80CfBky94kgkklcYEZ/pXBjg3B6NyqmzGvAg06kLtPiBcJavAnaIP7aXZaZebEoKiRtWNVEB8iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783644; c=relaxed/simple;
	bh=ZZ8QMbqRyZqN/oUEY8U6N/CLMdV0E5Cb9XS5lvcKh20=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=msNh8Q0TG+3D7/maXUlt8sF3KU+3oNIKI5rNTRuZCcGSD0v8seMWu1doDOvPjcGF/N3sVNqnkayMp3KCYbi3oke1ZE25jNDKx0gkfQjYLkDYU+I/cG5vgQeXQslNzsRbWtFV/4bWkopGFWgtDoTGcmJJvDCmupPWiQP+7PNmMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n0pOiHkI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M82cWF004075;
	Mon, 22 Apr 2024 11:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=oTZmNqFjasu6mkWngjJYwcaE1l2w78Wmxb36VACwtRQ=; b=n0
	pOiHkIH5bpvFZnwBAP51bGMd4RnyNAcyfZba87wQes4554eQgdKPN4O3jjkXbqEK
	RljCKTeiLdzA7BdFR0Q4E18HzO5cFGMY9ihiJu8ZQn8vYic0tgh1oRa8aHo7FhGP
	jud9CHhpYHcbnpRZgbntLtQaXa/QKQ7DCzrMMXvuLpw7sEmBGkhum1pBFlMn4ZK2
	YWayDf2iCjceZGrC8bsQsRI0EVlOfjqhsepVn6Q2MZ3CaHYH1TjX7/bVr2Jc3mED
	W0s+5/Zngbg54XWN+0ycw4S7g0QyaFMQXXzti425QiAkUPEkD/XYDHrD7Y2aJ98o
	9cWhTTxR4eIEyYMF+wsA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnm1bgex5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 11:00:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MB0ZaI015083
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 11:00:35 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 04:00:29 -0700
Message-ID: <73c5ffca-9275-437c-a49e-ef3251c8d313@quicinc.com>
Date: Mon, 22 Apr 2024 16:30:26 +0530
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
Content-Language: en-US
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <c3ea22ed-5750-438f-89d5-e56f908ba835@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OMj_lSeiBz4lQRj4pSeQCMMgsc6dOx33
X-Proofpoint-ORIG-GUID: OMj_lSeiBz4lQRj4pSeQCMMgsc6dOx33
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220049



On 4/19/2024 2:31 AM, Vladimir Zapolskiy wrote:
> Hello Jagadeesh,
> 
> On 3/25/24 08:07, Jagadeesh Kona wrote:
>>
>>
>> On 3/21/2024 6:42 PM, Dmitry Baryshkov wrote:
>>> On Thu, 21 Mar 2024 at 11:26, Jagadeesh Kona <quic_jkona@quicinc.com> 
>>> wrote:
>>>>
>>>> Extend device tree bindings of SM8450 videocc to add support
>>>> for SM8650 videocc. While it at, fix the incorrect header
>>>> include in sm8450 videocc yaml documentation.
>>>>
>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>    .../devicetree/bindings/clock/qcom,sm8450-videocc.yaml    | 4 +++-
>>>>    include/dt-bindings/clock/qcom,sm8450-videocc.h           | 8 
>>>> +++++++-
>>>>    2 files changed, 10 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git 
>>>> a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml 
>>>> b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>>>> index bad8f019a8d3..79f55620eb70 100644
>>>> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>>>> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>>>> @@ -8,18 +8,20 @@ title: Qualcomm Video Clock & Reset Controller on 
>>>> SM8450
>>>>
>>>>    maintainers:
>>>>      - Taniya Das <quic_tdas@quicinc.com>
>>>> +  - Jagadeesh Kona <quic_jkona@quicinc.com>
>>>>
>>>>    description: |
>>>>      Qualcomm video clock control module provides the clocks, resets 
>>>> and power
>>>>      domains on SM8450.
>>>>
>>>> -  See also:: include/dt-bindings/clock/qcom,videocc-sm8450.h
>>>> +  See also:: include/dt-bindings/clock/qcom,sm8450-videocc.h
>>>
>>> This almost pleads to go to a separate patch. Fixes generally should
>>> be separated from the rest of the changes.
>>>
>>
>> Thanks Dmitry for your review.
>>
>> Sure, will separate this into a separate patch in next series.
>>
>>>>
>>>>    properties:
>>>>      compatible:
>>>>        enum:
>>>>          - qcom,sm8450-videocc
>>>>          - qcom,sm8550-videocc
>>>> +      - qcom,sm8650-videocc
>>>>
>>>>      reg:
>>>>        maxItems: 1
>>>> diff --git a/include/dt-bindings/clock/qcom,sm8450-videocc.h 
>>>> b/include/dt-bindings/clock/qcom,sm8450-videocc.h
>>>> index 9d795adfe4eb..ecfebe52e4bb 100644
>>>> --- a/include/dt-bindings/clock/qcom,sm8450-videocc.h
>>>> +++ b/include/dt-bindings/clock/qcom,sm8450-videocc.h
>>>> @@ -1,6 +1,6 @@
>>>>    /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>>>    /*
>>>> - * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights 
>>>> reserved.
>>>> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All 
>>>> rights reserved.
>>>>     */
>>>>
>>>>    #ifndef _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM8450_H
>>>> @@ -19,6 +19,11 @@
>>>>    #define 
>>>> VIDEO_CC_MVS1C_DIV2_DIV_CLK_SRC                                9
>>>>    #define VIDEO_CC_PLL0                                          10
>>>>    #define VIDEO_CC_PLL1                                          11
>>>> +#define 
>>>> VIDEO_CC_MVS0_SHIFT_CLK                                        12
>>>> +#define VIDEO_CC_MVS0C_SHIFT_CLK                               13
>>>> +#define 
>>>> VIDEO_CC_MVS1_SHIFT_CLK                                        14
>>>> +#define VIDEO_CC_MVS1C_SHIFT_CLK                               15
>>>> +#define VIDEO_CC_XO_CLK_SRC                                    16
>>>
>>> Are these values applicable to sm8450?
>>>
>>
>> No, the shift clocks above are part of SM8650 only. To reuse the
>> existing SM8550 videocc driver for SM8650 and to register these shift
>> clocks for SM8650, I added them here.
>>
> 
> In such case I'd strongly suggest to add a new qcom,sm8650-videocc.h file,
> and do #include qcom,sm8450-videocc.h in it, thus the new header will be
> really a short one.
> 
> This will add pristine clarity.
> 

Thanks Vladimir for your suggestion. I believe adding a comment for 
these set of clocks should be sufficient to indicate these clocks are 
applicable only for SM8650, I can add the required comment and post the 
next series. Please let me know if this works?

Thanks,
Jagadeesh

