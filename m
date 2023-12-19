Return-Path: <linux-kernel+bounces-4527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF08817EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FEC51F24751
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7741915AB;
	Tue, 19 Dec 2023 00:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g/ITpJOC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822DF7E5;
	Tue, 19 Dec 2023 00:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIMSimk021817;
	Tue, 19 Dec 2023 00:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HPJ1/XXq0WbYT6CcNMr853jLJ6QLat6VOjsjdmg3ZTI=; b=g/
	ITpJOCWQfkKu8Cq0aJ78v89YHGnXz4Mw5jRo0jckKy209/j6gtWMcbJkZW3kw2A9
	1mggpJBRDSOX8BN8dEk2S/EceluQTsCW5FpCxe6BTT62SgMagyAGV3ClE0HHfoXu
	JB826gyL262hH36cAEuS+qRHJaGn068ho57LwKyn25Njxsb7Kza9VWDoRXLjDOmW
	W++ps3Lj8BfmPRQmCGrNG0PRqZoPKUKUlMqKkCrSZhv80wiy1NfVBcLt4EMpoJfA
	lHqKLaSY9lpH0gKs1gC+B7w6iem3VMf3r74gqhaUu8n7iyg0cmJwADrgBpxZmkoF
	5XbrT7Q4wq2TdMnmFO/w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2md2swum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 00:40:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJ0eb9G012093
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 00:40:37 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Dec
 2023 16:40:32 -0800
Message-ID: <28496d0b-87db-4bab-9853-2073d9ad4c8a@quicinc.com>
Date: Tue, 19 Dec 2023 08:40:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] arm64: dts: qcom: sm8550: remove
 address/size-cells from mdss_dsi1
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20231207092801.7506-1-quic_tengfan@quicinc.com>
 <20231207092801.7506-4-quic_tengfan@quicinc.com>
 <9cf61b7b-199a-4535-a701-10851959b940@linaro.org>
 <e00b2c5a-cd79-40ed-b78b-0aa8c5b33fa0@quicinc.com>
 <c1d4f636-d068-48e0-9013-b5a586fff99f@linaro.org>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <c1d4f636-d068-48e0-9013-b5a586fff99f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: G5-xXE1LLjDcHBiaoCatr1EoI5Sk8vVp
X-Proofpoint-GUID: G5-xXE1LLjDcHBiaoCatr1EoI5Sk8vVp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=858 suspectscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312190002



在 12/18/2023 6:13 PM, Krzysztof Kozlowski 写道:
> On 18/12/2023 10:59, Tengfei Fan wrote:
>>
>>
>> 在 12/11/2023 6:25 PM, Krzysztof Kozlowski 写道:
>>> On 07/12/2023 10:27, Tengfei Fan wrote:
>>>> Address/size-cells will cause dtbs check warning, because mdss_dsi1 node
>>>> have not ranges and child also have not reg, so remove address/size-cells.
>>>
>>> Paste the excerpt of warning.
>> Sure, I will paste the excerpt of warning.
>>>
>>>>
>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>> ---
>>>
>>> I am not sure if this is correct. The address/size cells are there for
>>> panels. We have multiple of such warnings, so I would like to have here
>>> consensus for all of them.
>> Currently these address/size cells lead to dtc W=1 warning, so these
> 
> I know.
> 
>> should be dropped.
> 
> Why? They are correct.
> 
>> These can be re-added if needed at a later date.
> 
> Added where? These are rather properties of SoC.
> 
> This does not solve any of my concerns.
Hi Krzysztof,
Sorry, a new patch has been submitted to upstream before seeing your reply.
I will do more sync with internal teams, please ignore new patch series 
before we cannot solve your concerns.

> 
> Best regards,
> Krzysztof
> 

-- 
Thx and BRs,
Tengfei Fan

