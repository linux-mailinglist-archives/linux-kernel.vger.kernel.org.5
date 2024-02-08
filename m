Return-Path: <linux-kernel+bounces-57859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D7C84DE49
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9BC21F26B85
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310466DD0A;
	Thu,  8 Feb 2024 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N/B4beZ7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C735D6BB55;
	Thu,  8 Feb 2024 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388109; cv=none; b=aLX9JfhpVpK5vwQmC2ltJ4A6nHH5T1qs1XCwMTOXrZXmho/Fh3PumeWcbw8wU+a7/3DVymATQHRMaO9w7LB7EI5KKkkrZfYNOLll1KUpfKcofhM4U/JJ0+TDNxp+AXtH/ayWVRRLzUBUgrxOwLqpW6PL5yklubjUAXUNs2AUQRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388109; c=relaxed/simple;
	bh=l/6z8zK2IS7zyAUd8a/Untl7omwPafidqebEY7WGgNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OaXAUPvWxwsobOGg/DFBF/ScpKUyQ/KhNFeF97MrFo+xfC9NzNp637AfLBgIggkq4l7LtcpsyaZY/+AoTI3XcvYmxm/7sXmsCZF1/psN5uLMfwVBTOm9SyT2UNa6qhAAgcq0NyUGs/DUgfJB4YdF1bizoSHwycVbgx/I0yt0fvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N/B4beZ7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4185BZWT031868;
	Thu, 8 Feb 2024 10:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7WuYR+XM2jbtN/gjtJ1Q++kZXg7Ncs2M5o4BsfpaSZk=; b=N/
	B4beZ7xcM6MSAtPQe4UmX90pYmfD8SoJ7QTDO89YHfdTjDlhylWvj3oSWFYBCbq/
	x8juRs5aW9zJ/IvfIoyCbdo0wmd7GwAc7e8CRl2023preGAXAEAXBpdRxhFDrIp2
	9atS5UXbfBXi49+/djBvGnuv84HAY4M03pw5rEuco5N+/pkz1ngbOA76p8589Xfb
	80asuk4M9oP49DEYl3I6OVeF6Je59lDoH8ZXHeQ6UmaQYfMc+2Rm21d5etUq5ths
	SCI8iXG/z/rfHjkGG7OMlZoOx/zWpHLJDnuHbWV9ODpnVJ4e8KwhWAOsLZ50hTnN
	G9iCW9X4UTh0rQptWXhQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4rk80vq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 10:28:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 418ASICa005723
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 10:28:18 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 8 Feb
 2024 02:28:13 -0800
Message-ID: <8865b33b-8dd6-73bf-1d34-919c6bcff65c@quicinc.com>
Date: Thu, 8 Feb 2024 15:58:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 1/7] dt-bindings: mailbox: qcom: Add CPUCP mailbox
 controller bindings
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <conor+dt@kernel.org>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-2-quic_sibis@quicinc.com>
 <20240130171240.GA1929440-robh@kernel.org>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20240130171240.GA1929440-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5K9c9CHb6iX1dl5E6IlpWatLuFKLv803
X-Proofpoint-ORIG-GUID: 5K9c9CHb6iX1dl5E6IlpWatLuFKLv803
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=857 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402080054



On 1/30/24 22:42, Rob Herring wrote:
> On Wed, Jan 17, 2024 at 11:04:52PM +0530, Sibi Sankar wrote:
>> Add devicetree binding for CPUSS Control Processor (CPUCP) mailbox
>> controller.

Hey Rob,

Thanks for taking time to review the series.

>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   .../bindings/mailbox/qcom,cpucp-mbox.yaml     | 51 +++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
>> new file mode 100644
>> index 000000000000..2617e5555acb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
>> @@ -0,0 +1,51 @@
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
>> +
>> +description:
>> +  The CPUSS Control Processor (CPUCP) mailbox controller enables communication
>> +  between AP and CPUCP by acting as a doorbell between them.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - qcom,x1e80100-cpucp-mbox
>> +      - const: qcom,cpucp-mbox
> 
> A generic fallback implies multiple devices use the same unchanged
> block. That seems doubtful given you have not defined any others and
> given Konrad's comments.

This mbox is expected to be used as is on a number of future SoCs,
that's the only reason I added the generic fallback. I can drop it
in the next re-spin if you want.

-Sibi

> 
> Rob

