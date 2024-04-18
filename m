Return-Path: <linux-kernel+bounces-149581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4B18A9312
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D79281801
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4226FE06;
	Thu, 18 Apr 2024 06:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i/Kw3dy2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0228C11;
	Thu, 18 Apr 2024 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421654; cv=none; b=h72GvjAxidnBSnsMFiPmdRfTeDCXNv/S3Vj1l/6E3QDkRq9xRx9ztdDSmXCFYpcf57TlU8NvLSqEvhUjVb2qYyXZ7QKZbvLdR5+OXHnqkvMaqRCfoAk10HcdjGAWWuc2Hf0RZRFhVnddG94gp6hhg0hKPNJZKI4Kb+pa4amOk+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421654; c=relaxed/simple;
	bh=ck6D+u1yHGSMSsvI+farJRo08q/q17J/RdpWxcYLUzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V88VafIgtlU15OJ66JDzEFgI59Sct4BCBnK9odoIOZJql1WM+LLB3OorkxQgEV6VRAlWYWbdh06gJbh4kjmFRCSjP1wSRNAGv2I2dSdc03fgJ/8d3kIIH39jrCm/Vq0mSPzS1A/u5203NJZee3GKQO9DXRc/X2hHer9g6h0rLvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i/Kw3dy2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HNrE0P018338;
	Thu, 18 Apr 2024 06:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tbWp83ngc6+C04lMqJmQF5eKNNcGbKVIZblsmEVEZDk=; b=i/
	Kw3dy2+SLlBMkynWa4ccWUpbylndODYMvO/yknuuebbdm/N5JASvLAjc1ZzkXaXy
	wwCVNdDoIDPSNX+b8vabYIT22lK/OUo8tflP6MZsqbXJdJjZwCioaOPDzqImcSPh
	TUUlM7CjVsWUfyMPQxWum54UwUzelmXQlJnq0vWK2z0Z2ojeohNH3SSdXXAufciX
	n9n2zFx+OhJs1G3/KCeWjvE7XgGqIQoDI4FCgswnYU371iMF+B4RzmA5mIRra/tS
	Q4Tz1+RZxtpwMS9BQLs7Kx9Jz57Owz4fGr22nUDl+2l4XY6u0n3lkW25egFxsA+Y
	1Bed6WS9/govow426Gqg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjrfxgv25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 06:27:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43I6RNZO027974
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 06:27:23 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Apr
 2024 23:27:18 -0700
Message-ID: <1e334bd5-6d90-8ac7-084f-8b7928072c17@quicinc.com>
Date: Thu, 18 Apr 2024 11:57:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V3 1/5] dt-bindings: mailbox: qcom: Add CPUCP mailbox
 controller bindings
Content-Language: en-US
To: Bjorn Andersson <quic_bjorande@quicinc.com>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <conor+dt@kernel.org>, <quic_gkohli@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_psodagud@quicinc.com>,
        Rob Herring <robh@kernel.org>
References: <20240417132856.1106250-1-quic_sibis@quicinc.com>
 <20240417132856.1106250-2-quic_sibis@quicinc.com>
 <ZiA0hOkpGVlVFp5u@hu-bjorande-lv.qualcomm.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <ZiA0hOkpGVlVFp5u@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CBqy4x_L3vRJwV6AY0rDmH2Iand2eEA2
X-Proofpoint-GUID: CBqy4x_L3vRJwV6AY0rDmH2Iand2eEA2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_04,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=908 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180042



On 4/18/24 02:13, Bjorn Andersson wrote:
> On Wed, Apr 17, 2024 at 06:58:52PM +0530, Sibi Sankar wrote:
>> Add devicetree binding for CPUSS Control Processor (CPUCP) mailbox
>> controller.
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>
>> v2:
>> * Pickup Rb from Dimitry.
>>
>>   .../bindings/mailbox/qcom,cpucp-mbox.yaml     | 49 +++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
>> new file mode 100644
>> index 000000000000..491b0a05e630
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
>> @@ -0,0 +1,49 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mailbox/qcom,cpucp-mbox.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies, Inc. CPUCP Mailbox Controller
>> +
>> +maintainers:
>> +  - Sibi Sankar <quic_sibis@qti.qualcomm.com>
> 
> That doesn't look like the correct domain.

Thanks, I don't know how I even constructed this chimera of an email-id
lol.

-Sibi

> 
> Regards,
> Bjorn

