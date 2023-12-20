Return-Path: <linux-kernel+bounces-6977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BC481A003
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07A61F27821
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CE9364C0;
	Wed, 20 Dec 2023 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VzWxAJ3X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691C36AFE;
	Wed, 20 Dec 2023 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK9XEhB016224;
	Wed, 20 Dec 2023 13:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=uBZryIRzk6NQuGKqkpwinMRaZplCLcVDmu1RUIDKfTk=; b=Vz
	WxAJ3XTjrNdflfzcPGZ/qQHKiMpOb+Yom9mZeck/kMjI5aoxJyw9s+Gqh2405dQN
	80gwz69UeLuybLGYZZWtWVqw9/KHRhHdbuKlluFkhvbAqUzKBgRHd/z3CeviQYzJ
	Jb4NSDQicHIW9C9b6airAjdJWxRyUyvRlQZ7/PfDv5jC1OXFGagQa5Ux34hCqCD0
	ZkDRYMFrOJIGKV/m1dLyjrPO7Xl24cjY0PSBtAINON4JLzkn0gjaGXCMLd1wLYGL
	A+neWiewVvexC+r9agcKcW39TLh/bRTKYuDxkxWUwP3KSnFAkyldfkyiYY08r+MZ
	PUmTfHZx/1P05+HJJrfA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3wr10jjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 13:40:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BKDeZ2e030746
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 13:40:35 GMT
Received: from [10.239.133.49] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 05:40:31 -0800
Message-ID: <98407ed5-5e0c-4bee-be4c-70b3d8972823@quicinc.com>
Date: Wed, 20 Dec 2023 21:40:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: Add coresight nodes for sm8450
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross
	<agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang
	<quic_taozha@quicinc.com>, <coresight@lists.linaro.org>
References: <20231220124009.16816-1-quic_jinlmao@quicinc.com>
 <dfc7fe85-7418-410c-bd82-6e08799e6417@linaro.org>
 <439916dc-8f71-4998-b145-1d183d9e68f5@quicinc.com>
 <77ba0140-5b74-40d7-a923-4b270d661d3a@linaro.org>
From: Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <77ba0140-5b74-40d7-a923-4b270d661d3a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ULhEewe5uUSLkhhTvWJRb1dyW4xG-V0H
X-Proofpoint-GUID: ULhEewe5uUSLkhhTvWJRb1dyW4xG-V0H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 spamscore=0 mlxlogscore=713 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200097



On 12/20/2023 9:21 PM, Krzysztof Kozlowski wrote:
> On 20/12/2023 14:07, Jinlong Mao wrote:
>>
>>
>> On 12/20/2023 8:46 PM, Krzysztof Kozlowski wrote:
>>> On 20/12/2023 13:40, Mao Jinlong wrote:
>>>> Add coresight components on Qualcomm SM8450 Soc. The components include
>>>> TMC ETF/ETR, ETE, STM, TPDM, CTI.
>>>>
>>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/sm8450.dtsi | 742 +++++++++++++++++++++++++++
>>>>    1 file changed, 742 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>> index 1783fa78bdbc..112b5a069c94 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>> @@ -285,6 +285,192 @@ CLUSTER_SLEEP_1: cluster-sleep-1 {
>>>>    		};
>>>>    	};
>>>>    
>>>> +	ete0 {
>>>
>>> ete-0
>> Thanks for the review.
>>
>> In arm,embedded-trace-extension.yaml, the node name pattern is
>> "^ete([0-9a-f]+)$".
> 
> I don't understand why this binding requires ete name. It's not like it
> is a generic name worth preserving. Also, the recommended suffix for
> names is with '-'.
> 
The number in the ete name should be the same as the number of the CPU.
So we can know which CPU this ete belongs to from the name.

I will update the binding in arm,embedded-trace-extension.yaml.

Thanks
Jinlong Mao
> 
> Best regards,
> Krzysztof
> 

