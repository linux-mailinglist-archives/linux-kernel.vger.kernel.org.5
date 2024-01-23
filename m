Return-Path: <linux-kernel+bounces-34834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3206C83881B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65B261C22258
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878B952F73;
	Tue, 23 Jan 2024 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="moWrO3nP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596B255E6C;
	Tue, 23 Jan 2024 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705995665; cv=none; b=SobFmT2eADhqnwLEm0+xJEKqHk8UPVCHBRuwQZuIhqtw4EgFun+dBBi3g/ZPto2nwEK+BkFA9ELajBANMtXkPEE6bXJ1VOZPXVAvIvaFIiBnD7IKWipfnJj2Vnf8I3IvTeHA0MUJnid+Z64qMEphIjXcC2pQvPf/iC9xwSkYkQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705995665; c=relaxed/simple;
	bh=/Nj6Ph18ng8jZRZ3LBRkgzpbuV/nCr07jTP0oi3cSvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UV5JPqiXLbFI/BJ4iiZ62MCIKxLAOo3jE0MUtKHbb8vRRjsvvlrUNey9lF8HjBKfPGdgK9pPq3N684M/FhzC+5VRFPFJrhbwQ/LcaNszQslCeJbzdtjrlLadWj6AN+dGEgF3+FBySxgk9yq9vkB+I7VtEJDpYNRVTDO9ckemmDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=moWrO3nP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N7Mm0E005591;
	Tue, 23 Jan 2024 07:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jL8XLZCLgn5P6ZASj4WFD/DFDJQlaY/Mg8ngb9CqzhI=; b=mo
	WrO3nP9yDomJuTFb9V7sKFG3eC5yN/NwcxGMgIEKS433amUHIi9z8687WqqqBWQ4
	iCJZwQGBcV4VTQCKvvfuiCC4YK+0BmzpK6cO3ri0wWU+rPHhTfv2Ohr6p92LdDT6
	x/yEJNr2dv/Tn9wdMDBpBQyP/++pdJ7W9JAYg2A2gofkY40S4Jf8qg8IA4/zdvC1
	epABJhKjQqBXO3xtQUCoqgbh6HQF3IRwZ5/62WujA5bcfy2szw1sHlRhnBv4fD4O
	/YoHx9qO2mZmCjKIduEZXqg25bZp6uXXyxVx99xOI6AZx+sqlC5QwRI8VbqCfJwn
	Q4fnlpk00sIL6KB8Xz2w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vspw8tqak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 07:40:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40N7em5c009560
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 07:40:48 GMT
Received: from [10.216.24.76] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 23:40:44 -0800
Message-ID: <6fab57f0-13b5-455a-9109-1f9d475b7c3a@quicinc.com>
Date: Tue, 23 Jan 2024 13:10:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: ipq5018-rdp432-c2: correct board name
Content-Language: en-US
To: Ziyang Huang <hzyitc@outlook.com>, <agross@kernel.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <TYZPR01MB55564BE24CE8718DBD4644A2C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <ac35936e-2fc0-4ca5-b746-25fa0e31afac@quicinc.com>
 <TYZPR01MB55569715C43B7B1EBE613B86C9752@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <TYZPR01MB55569715C43B7B1EBE613B86C9752@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qogMIMhHGYxe0Ztr-CuEH76k2_h1wH39
X-Proofpoint-ORIG-GUID: qogMIMhHGYxe0Ztr-CuEH76k2_h1wH39
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_02,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 mlxlogscore=697
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230053



On 1/22/2024 10:27 PM, Ziyang Huang wrote:
> 在 2024/1/23 0:03, Kathiravan Thirumoorthy 写道:
>>
>>
>> On 1/21/2024 6:22 PM, Ziyang Huang wrote:
>>> According to Qualcomm document:
>>>    MP03.1 is RDP404
>>>    RDP432 is MP03.5
>>>
>>> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts 
>>> b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
>>> index 074b78d7939c..f7e8b5af6b44 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
>>> +++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
>>> @@ -1,6 +1,6 @@
>>>   // SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
>>>   /*
>>> - * IPQ5018 MP03.1-C2 board device tree source
>>> + * IPQ5018 MP03.5-C2 board device tree source
>>
>>
>> I suggest to use the RDP number itself here...
> 
> Here is an embarrassing thing. AP/MPxx.x name is more common in the 
> entire QSDK while RDP number is almost never appeared.


That was the case but not anymore. We decided to switch to RDP number 
instead of AP/XXXX.. So it would better if we stick with RDP number for 
consistency.

> 
>>
>>
>>>    *
>>>    * Copyright (c) 2023 The Linux Foundation. All rights reserved.
>>>    */
> 

