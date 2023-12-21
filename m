Return-Path: <linux-kernel+bounces-7809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C89C81AD82
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3977B22A17
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5B58F5C;
	Thu, 21 Dec 2023 03:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KeMUfv2r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57378BED;
	Thu, 21 Dec 2023 03:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL3Mm9p002224;
	Thu, 21 Dec 2023 03:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ptFIPM1CW1CWOKLq9bwEV8p6w0+7bVuEzH3rN9cUK8Y=; b=Ke
	MUfv2ruDpf97bEHbIc6uLJ4yiKbaF+aviplKAm9aM5ew1HOa01vxMxoi32u7MDgI
	1LBluX+ybfxmLbFkuqV/aNQaBWNKHDBImCsjazSo5h3UqUTswffa6KSb4cFHc5YP
	tU0JaKBsM8jDcNsSLzv1rlcOf081lpQGmDTO59ykQ7QcKCA5ekC/x3DoNGLEXm40
	PTEGuYt6dopDUwtXGI+3vKXT2OC80/Z0jwyI80SKrw354QXD0zNYx7apgjO8038H
	yl6+qexI8YM0sxF6PAOGHuJY4A4fYL5M7OicSjJR/zM/NecVLjPv7OJGfX4mINEx
	TYusw+srSlXgG00URgiQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4d89g1cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 03:28:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BL3SRNF004471
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 03:28:27 GMT
Received: from [10.239.133.49] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 19:28:22 -0800
Message-ID: <8e5e9603-456b-4956-be03-b866feeeafb4@quicinc.com>
Date: Thu, 21 Dec 2023 11:28:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: coresight: Update the pattern of
 ete node name
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Mike Leach" <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>, Leo
 Yan <leo.yan@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang
	<quic_taozha@quicinc.com>, <coresight@lists.linaro.org>
References: <20231220140538.13136-1-quic_jinlmao@quicinc.com>
 <20231220140538.13136-2-quic_jinlmao@quicinc.com>
 <79f88d35-17cc-43b0-bb22-3c854f89d961@linaro.org>
From: Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <79f88d35-17cc-43b0-bb22-3c854f89d961@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mT7ntKNZG1VD1l8KAksTUPmAU4eV8W-n
X-Proofpoint-ORIG-GUID: mT7ntKNZG1VD1l8KAksTUPmAU4eV8W-n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312210023



On 12/20/2023 11:50 PM, Krzysztof Kozlowski wrote:
> On 20/12/2023 15:05, Mao Jinlong wrote:
>> Update the suffix for ete node name to be with "-".
>>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   .../bindings/arm/arm,embedded-trace-extension.yaml          | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
>> index f725e6940993..cbf583d34029 100644
>> --- a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
>> +++ b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
>> @@ -23,7 +23,7 @@ description: |
>>   
>>   properties:
>>     $nodename:
>> -    pattern: "^ete([0-9a-f]+)$"
>> +    pattern: "^ete-([0-9a-f]+)$"
> 
> My concerns are not resolved. Why is it here in the first place?

Hi Krzysztof,

ETE is acronym of embedded trace extension. The number of the name is 
the same as the number of the CPU it belongs to.

Hi Suzuki,

Please help to comment on this.

Thanks
Jinlong Mao

> 
> Best regards,
> Krzysztof
> 

