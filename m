Return-Path: <linux-kernel+bounces-116608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BD788A51A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7DE7BC6A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5574216F8FB;
	Mon, 25 Mar 2024 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UzhQSQUm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0E213D259;
	Mon, 25 Mar 2024 07:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350082; cv=none; b=oxdC5dY++djNaVreIgBKeUd5/8nCyihGwcmqQlZxVwjRUvgDKLheQpVuMK32CLdTPciIiOrB0WAtPWoLW3/nsWq0+VgZcwA0mb91+HIo8qP4I/m+jLlUlVIU72Qmu1RBEgxB4/x1IwFI1x2p3JRA4RDhBQr4MEltvv8kLEZQZEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350082; c=relaxed/simple;
	bh=39aT+AQRfWjWTtHAwtOtgnUXvgvAKFQoJVQ0iAI6BW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Yzk2har6tleXsVZXN91/kSU/VsgRLFiflnQEEo2VsPSryPou7D1iAZHBdqFb2iAMvA3ia8+2Q1iKx+ordgOZYavCE6IulqRFZKZR3z74ky0hXfjAiMUyvFFFND64QZ5zs4lhPsLPAdqdwYz1bKNWV/SHyhQyETvmsVIo4F/H9Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UzhQSQUm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P5PGRb001591;
	Mon, 25 Mar 2024 07:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TupEAa9JYXyHgfSua78cY31i0WdEXTbECXZFhdn+lPU=; b=Uz
	hQSQUmr0OP99B9rsh8gp7HXHDcBCDDfXI6FpwfxTVaRryF0wQI4tAHjaXpx3BAhr
	m718vJHr3hRygL9+HKmNr1XfhgVL1iWy2ywDQDFobuOeXasUPyn5SHqxMFxd2c1Y
	MwfdpkEZx6lhGyHb5cjBsmexp/Q79WKVJYcG1a87VEwoh5drJQw42lClVzUabcqC
	5+6hNbSYa9vINM0DTWIRI1UvB58XtK5Zc2baiXBJqNUXnnJIcIXXzsIIAl4OVnHq
	wUcAXNBT0ETzOcGW3LIqXNUlijxpWzo+PDkH0xMQGRWKydvdcvJLIfLyY2QzSktG
	ePH72+Q8X7isH62Dr8Gg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x319j8arn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 07:01:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42P71EqO001013
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 07:01:14 GMT
Received: from [10.216.57.55] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Mar
 2024 00:01:07 -0700
Message-ID: <10f46c19-4d02-4af6-a6b0-1549371d7be6@quicinc.com>
Date: Mon, 25 Mar 2024 12:30:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 RESEND 1/6] dt-bindings: clock: qcom: Add SM8650 video
 clock controller
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
References: <20240321092529.13362-1-quic_jkona@quicinc.com>
 <20240321092529.13362-2-quic_jkona@quicinc.com>
 <CAA8EJppsMchthssctEgUf9q45j84cSLQ78Ur+vaA0Z7GEQi8+g@mail.gmail.com>
 <725471b1-46a9-43b0-bede-33f01c953d51@quicinc.com>
 <CAA8EJpqUdEXYFaqH3HZKsx0iucq3pLe3HoMNRLWhsBs27W16PA@mail.gmail.com>
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <CAA8EJpqUdEXYFaqH3HZKsx0iucq3pLe3HoMNRLWhsBs27W16PA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fe2XdN_i5YtJxtzsJjYa7kAgPZ8cv9X8
X-Proofpoint-GUID: fe2XdN_i5YtJxtzsJjYa7kAgPZ8cv9X8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403250036



On 3/25/2024 12:08 PM, Dmitry Baryshkov wrote:
> On Mon, 25 Mar 2024 at 08:08, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>>
>>
>>
>> On 3/21/2024 6:42 PM, Dmitry Baryshkov wrote:
>>> On Thu, 21 Mar 2024 at 11:26, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>>>>
>>>> Extend device tree bindings of SM8450 videocc to add support
>>>> for SM8650 videocc. While it at, fix the incorrect header
>>>> include in sm8450 videocc yaml documentation.
>>>>
>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>    .../devicetree/bindings/clock/qcom,sm8450-videocc.yaml    | 4 +++-
>>>>    include/dt-bindings/clock/qcom,sm8450-videocc.h           | 8 +++++++-
>>>>    2 files changed, 10 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>>>> index bad8f019a8d3..79f55620eb70 100644
>>>> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>>>> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>>>> @@ -8,18 +8,20 @@ title: Qualcomm Video Clock & Reset Controller on SM8450
>>>>
>>>>    maintainers:
>>>>      - Taniya Das <quic_tdas@quicinc.com>
>>>> +  - Jagadeesh Kona <quic_jkona@quicinc.com>
>>>>
>>>>    description: |
>>>>      Qualcomm video clock control module provides the clocks, resets and power
>>>>      domains on SM8450.
>>>>
>>>> -  See also:: include/dt-bindings/clock/qcom,videocc-sm8450.h
>>>> +  See also:: include/dt-bindings/clock/qcom,sm8450-videocc.h
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
>>>>    properties:
>>>>      compatible:
>>>>        enum:
>>>>          - qcom,sm8450-videocc
>>>>          - qcom,sm8550-videocc
>>>> +      - qcom,sm8650-videocc
>>>>
>>>>      reg:
>>>>        maxItems: 1
>>>> diff --git a/include/dt-bindings/clock/qcom,sm8450-videocc.h b/include/dt-bindings/clock/qcom,sm8450-videocc.h
>>>> index 9d795adfe4eb..ecfebe52e4bb 100644
>>>> --- a/include/dt-bindings/clock/qcom,sm8450-videocc.h
>>>> +++ b/include/dt-bindings/clock/qcom,sm8450-videocc.h
>>>> @@ -1,6 +1,6 @@
>>>>    /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>>>    /*
>>>> - * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
>>>>     */
>>>>
>>>>    #ifndef _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM8450_H
>>>> @@ -19,6 +19,11 @@
>>>>    #define VIDEO_CC_MVS1C_DIV2_DIV_CLK_SRC                                9
>>>>    #define VIDEO_CC_PLL0                                          10
>>>>    #define VIDEO_CC_PLL1                                          11
>>>> +#define VIDEO_CC_MVS0_SHIFT_CLK                                        12
>>>> +#define VIDEO_CC_MVS0C_SHIFT_CLK                               13
>>>> +#define VIDEO_CC_MVS1_SHIFT_CLK                                        14
>>>> +#define VIDEO_CC_MVS1C_SHIFT_CLK                               15
>>>> +#define VIDEO_CC_XO_CLK_SRC                                    16
>>>
>>> Are these values applicable to sm8450?
>>>
>>
>> No, the shift clocks above are part of SM8650 only. To reuse the
>> existing SM8550 videocc driver for SM8650 and to register these shift
>> clocks for SM8650, I added them here.
> 
> At least it deserves a comment.
> 

Yes, will add the comment in next series.

Thanks,
Jagadeesh

>>
>>>>
>>>>    /* VIDEO_CC power domains */
>>>>    #define VIDEO_CC_MVS0C_GDSC                                    0
>>>> @@ -34,5 +39,6 @@
>>>>    #define CVP_VIDEO_CC_MVS1C_BCR                                 4
>>>>    #define VIDEO_CC_MVS0C_CLK_ARES                                        5
>>>>    #define VIDEO_CC_MVS1C_CLK_ARES                                        6
>>>> +#define VIDEO_CC_XO_CLK_ARES                                   7
>>>>
>>>>    #endif
>>>> --
>>>> 2.43.0
>>>>
>>>>
>>>
>>>
> 
> 
> 

