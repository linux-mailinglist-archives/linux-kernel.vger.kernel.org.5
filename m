Return-Path: <linux-kernel+bounces-116568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 063F388A0C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBC128D8BB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1105B5B3;
	Mon, 25 Mar 2024 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="McD66DBg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E627F152191;
	Mon, 25 Mar 2024 06:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711346916; cv=none; b=u98omzRprvgdqw6x7/fUHQXA9ljbXoISihov298B0Ihwy/iFOICMAPKaxkcl5tlvNJgzN2iyrBtIKwfn0fupeLusN2gdzregMeoHbrb5v6ewKU9JPju4GD0MbNubkO6ocguppSABORtsxIdy7OK8/BY204YoBWmziO7WxBHCGkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711346916; c=relaxed/simple;
	bh=Yag/GmL+iks+hAEilxwHzv1y/IG9X+DScY72ID0EE5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=USlWvsbF59CLiq3RA0Rpd9/dR2BpQSIqpf8Afgf7l8SGloqYJNyqoRUYDgP1TnNuTTSA4VEKwxCY9ku3sfd7xusE65sLjUFvbtZoWSs5exQy28yhknZoPElRZ+v6rgO4IG1xpJzy849Ohte7EEfpW81S6onFPQb3jYcb8LpTG2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=McD66DBg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P62fuZ010813;
	Mon, 25 Mar 2024 06:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=OhPCQYg2/myYUoLSKnbrt/7cFvjxXml/wAWhy8l/zCE=; b=Mc
	D66DBgtx7Ihe8Bhquf+oNb37UqxDBwAQHt0vwjY63RAUyw8Pa+4DewssBpsPLzzt
	oOL3hPoNFM9JMXCeUiIxF3KEMOWMHrhjQtHR3B1dPmUlj/1XThP6zzV7G4DvbqRz
	Nq6E/AKhXoREdTChi3Hmi9oTRmIJo2hznNOV+gZOrk0kdB6RiMniu42kXo9+kQpp
	7SrirlGfnrwSZXUqQVW8abUWFAkve2HCBu0fMXp99X00DqDdZAZbcv9JIAUDJhlD
	b6f1wuXSr0YG6ADKXsaCE/0Hju0zPLO+mU9Cnz29KHntJagsA0VYsQWICq3bGuB2
	zfP50m0BzZNiafEOivEw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x1pdpx8yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 06:08:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42P68SQX018068
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 06:08:28 GMT
Received: from [10.216.57.55] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 24 Mar
 2024 23:08:22 -0700
Message-ID: <725471b1-46a9-43b0-bede-33f01c953d51@quicinc.com>
Date: Mon, 25 Mar 2024 11:37:51 +0530
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
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <CAA8EJppsMchthssctEgUf9q45j84cSLQ78Ur+vaA0Z7GEQi8+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZPKEMIv6Og3jftBAbkOP7KbfC7NKGCb_
X-Proofpoint-ORIG-GUID: ZPKEMIv6Og3jftBAbkOP7KbfC7NKGCb_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_03,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403250031



On 3/21/2024 6:42 PM, Dmitry Baryshkov wrote:
> On Thu, 21 Mar 2024 at 11:26, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>>
>> Extend device tree bindings of SM8450 videocc to add support
>> for SM8650 videocc. While it at, fix the incorrect header
>> include in sm8450 videocc yaml documentation.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   .../devicetree/bindings/clock/qcom,sm8450-videocc.yaml    | 4 +++-
>>   include/dt-bindings/clock/qcom,sm8450-videocc.h           | 8 +++++++-
>>   2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>> index bad8f019a8d3..79f55620eb70 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>> @@ -8,18 +8,20 @@ title: Qualcomm Video Clock & Reset Controller on SM8450
>>
>>   maintainers:
>>     - Taniya Das <quic_tdas@quicinc.com>
>> +  - Jagadeesh Kona <quic_jkona@quicinc.com>
>>
>>   description: |
>>     Qualcomm video clock control module provides the clocks, resets and power
>>     domains on SM8450.
>>
>> -  See also:: include/dt-bindings/clock/qcom,videocc-sm8450.h
>> +  See also:: include/dt-bindings/clock/qcom,sm8450-videocc.h
> 
> This almost pleads to go to a separate patch. Fixes generally should
> be separated from the rest of the changes.
> 

Thanks Dmitry for your review.

Sure, will separate this into a separate patch in next series.

>>
>>   properties:
>>     compatible:
>>       enum:
>>         - qcom,sm8450-videocc
>>         - qcom,sm8550-videocc
>> +      - qcom,sm8650-videocc
>>
>>     reg:
>>       maxItems: 1
>> diff --git a/include/dt-bindings/clock/qcom,sm8450-videocc.h b/include/dt-bindings/clock/qcom,sm8450-videocc.h
>> index 9d795adfe4eb..ecfebe52e4bb 100644
>> --- a/include/dt-bindings/clock/qcom,sm8450-videocc.h
>> +++ b/include/dt-bindings/clock/qcom,sm8450-videocc.h
>> @@ -1,6 +1,6 @@
>>   /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>   /*
>> - * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
>>    */
>>
>>   #ifndef _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM8450_H
>> @@ -19,6 +19,11 @@
>>   #define VIDEO_CC_MVS1C_DIV2_DIV_CLK_SRC                                9
>>   #define VIDEO_CC_PLL0                                          10
>>   #define VIDEO_CC_PLL1                                          11
>> +#define VIDEO_CC_MVS0_SHIFT_CLK                                        12
>> +#define VIDEO_CC_MVS0C_SHIFT_CLK                               13
>> +#define VIDEO_CC_MVS1_SHIFT_CLK                                        14
>> +#define VIDEO_CC_MVS1C_SHIFT_CLK                               15
>> +#define VIDEO_CC_XO_CLK_SRC                                    16
> 
> Are these values applicable to sm8450?
> 

No, the shift clocks above are part of SM8650 only. To reuse the 
existing SM8550 videocc driver for SM8650 and to register these shift 
clocks for SM8650, I added them here.

Thanks,
Jagadeesh

>>
>>   /* VIDEO_CC power domains */
>>   #define VIDEO_CC_MVS0C_GDSC                                    0
>> @@ -34,5 +39,6 @@
>>   #define CVP_VIDEO_CC_MVS1C_BCR                                 4
>>   #define VIDEO_CC_MVS0C_CLK_ARES                                        5
>>   #define VIDEO_CC_MVS1C_CLK_ARES                                        6
>> +#define VIDEO_CC_XO_CLK_ARES                                   7
>>
>>   #endif
>> --
>> 2.43.0
>>
>>
> 
> 

