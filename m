Return-Path: <linux-kernel+bounces-163736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5676C8B6EFD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F792B21850
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1033B1292F2;
	Tue, 30 Apr 2024 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WjKg3xSv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3393A8CB;
	Tue, 30 Apr 2024 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471295; cv=none; b=CJZB7N8eVgK9ff1pdZYUkbBpHxPNUV4ngcbsC4qGZYqdCvVM8t7jgcsnPq3SugJG5lzXfQm8TIars3TmN12pEWn2utJ6e8vl8BDKo1ie26uHWp4SD4Zh21/Zu3sNiIid5C39wUVguysSXhfG/X3nmEgBVK4uFZ0Jg5aPDzOwcH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471295; c=relaxed/simple;
	bh=HRtbQSiUJHkdJKMMUh1+vHOl/scgu9Hv+aza5ULZaUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WD7PI7B6HcdprNVlXR6wXWUuwSaYbr2PxI3LhWK4wh4PxoeT1qAzv9gZ9EGTA+iphIv3j/mzr5RYXo8sDE7kZLIHwf70fpm7DQkiCcw2NEzDlFnmLrUWfkYQ9zgTi4eGE05Rd7Y2ahObWDYzHqkDBLs5iixNRAteIppm9vPcDzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WjKg3xSv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U506dM028710;
	Tue, 30 Apr 2024 10:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7T6rIF6M/ss3/DSb2FFEFh9GP9HIOHUQ0xVyL/y3hbE=; b=Wj
	Kg3xSvVgekZrNGXIHbwFWIdquphlTa1FhPqCN/icSFJ9WQbq5K3S0ICO1J/6WMSw
	K1cUNbGrY9o1uDb1w2xzJle5irbyhlhaSNstlR0+HChvA5vBZY25OlySIAIB2onN
	/b/zmW+YcJx9U8R5G1wGkmechYhF3c7/9DkUi3YS/p2IYWXE824N8npzzjKocbGG
	jqwEF7OPkE+InE/8bqllUqx60eWQ4ywgtYz9rILGfIwTOYftSATtGzlhaBL7UHfR
	hUKiOD/TzEIbbjhNpc5wo/BU2M5Cc6Gsx9vxolYaXWqbxZM9EUOnMDZpJDYoBQ6Q
	8u/QRsxs1sNNsrswStqw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtb6052w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 10:01:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UA1Ljm020901
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 10:01:21 GMT
Received: from [10.216.61.95] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 03:01:16 -0700
Message-ID: <be6ce8b8-ce4f-7018-a46b-fa5780050847@quicinc.com>
Date: Tue, 30 Apr 2024 15:31:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: qcom: Update SM8150 videocc
 bindings
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Taniya
 Das" <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20240401-videocc-sm8150-dt-node-v2-0-3b87cd2add96@quicinc.com>
 <20240401-videocc-sm8150-dt-node-v2-1-3b87cd2add96@quicinc.com>
 <20240402160545.GA223060-robh@kernel.org>
From: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
In-Reply-To: <20240402160545.GA223060-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lauzhnSf67ErVCSXtUOenRiBNTikamAY
X-Proofpoint-ORIG-GUID: lauzhnSf67ErVCSXtUOenRiBNTikamAY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_04,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300072


On 4/2/2024 9:35 PM, Rob Herring wrote:
> On Mon, Apr 01, 2024 at 04:44:23PM +0530, Satya Priya Kakitapalli wrote:
>> Update the clocks list for SM8150 to add both AHB and XO clocks,
>> as it needs both of them.
> I read this as you are adding 2 clocks, but it is really just 1 you are
> adding (iface).


Yes, I am adding AHB (iface) as its needed for SM8150, which is not 
present in the current bindings.


> This should have more detail on why breaking the ABI is okay here.


Sure, I'll update the commit text accordingly.


>> Fixes: 35d26e9292e2 ("dt-bindings: clock: Add YAML schemas for the QCOM VIDEOCC clock bindings")
>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>> ---
>>   .../devicetree/bindings/clock/qcom,videocc.yaml         | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
>> index 6999e36ace1b..68bac801adb0 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
>> @@ -75,7 +75,6 @@ allOf:
>>             enum:
>>               - qcom,sc7180-videocc
>>               - qcom,sdm845-videocc
>> -            - qcom,sm8150-videocc
>>       then:
>>         properties:
>>           clocks:
>> @@ -101,6 +100,22 @@ allOf:
>>               - const: bi_tcxo
>>               - const: bi_tcxo_ao
>>   
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - qcom,sm8150-videocc
>> +    then:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: AHB
>> +            - description: Board XO source
>> +        clock-names:
>> +          items:
>> +            - const: iface
>> +            - const: bi_tcxo
>> +
>>     - if:
>>         properties:
>>           compatible:
>>
>> -- 
>> 2.25.1
>>

