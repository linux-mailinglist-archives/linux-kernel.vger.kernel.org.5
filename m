Return-Path: <linux-kernel+bounces-11542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F3781E7E8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7921C21DF8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 15:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847404F207;
	Tue, 26 Dec 2023 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MnnfRdyU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C454CB4D;
	Tue, 26 Dec 2023 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BQEunsf009063;
	Tue, 26 Dec 2023 15:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TOu5l67OHZpaaNzV5lQq5MTBuTMA/WAQA8Frk7a1TQU=; b=Mn
	nfRdyUx0N9m6Y7Ciitz0CwNMJe+eddanL61N7Fnr803KjIhLYlZFElkQjjqKHR6E
	VZvLA0zxZ9UCCm2I6JKZSpVc1MyM90I3xmlFMz3ocNVkkl2aajG9cLJ0WD6WYiZE
	uGtyzoD1J5/P2u26o+Db1fNnTUc5BWc49Rv1I/X2JktzhrgSneDY5wickc+fWGOY
	yqEoenqVfvrAqkClFJ3fpeaEfj6yTdVhIHvaSZ4XYHirbUZjcQRDyERqOz8Wxh/S
	kWqmL1kSimTnmG2mv7y67RJ3Y8OHtPmqaaPBVrNiMyPCUQ8lShsQLAjz8eJQDUuO
	kx0OGPJNg+OYNx8GIr/Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v80kfr2rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 15:04:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BQF3xBO030523
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 15:03:59 GMT
Received: from [10.216.22.80] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Dec
 2023 07:03:53 -0800
Message-ID: <a284c13d-b55a-467d-8756-c41b0f913df3@quicinc.com>
Date: Tue, 26 Dec 2023 20:33:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: usb: dwc3: Clean up hs_phy_irq in
 binding
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Bjorn Andersson
	<quic_bjorande@quicinc.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, Andy Gross <agross@kernel.org>
References: <20231222063648.11193-1-quic_kriskura@quicinc.com>
 <20231222063648.11193-2-quic_kriskura@quicinc.com>
 <e6419898-0d77-4286-a04b-7240eb90d8df@linaro.org>
 <268f9f54-8b2a-42bb-9a5d-10bd930cb282@quicinc.com>
 <55c478c7-abcc-4487-b81c-479df47d5666@linaro.org>
 <67c7c84c-c631-468e-ae67-1c31d41a605b@quicinc.com>
 <efdf2923-4669-409f-b5c4-d5b95009309f@linaro.org>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <efdf2923-4669-409f-b5c4-d5b95009309f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kymk9fiVJgoZRPm7WR5bS12xF5mUxhap
X-Proofpoint-GUID: kymk9fiVJgoZRPm7WR5bS12xF5mUxhap
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxlogscore=573 malwarescore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312260114



On 12/26/2023 5:52 PM, Krzysztof Kozlowski wrote:

>>>
>>> This does not answer why, you sc8280xp and x1e80100 not get one optional
>>> interrupt. I asked "why" you are doing this change. Why do you need it?
>>> What is the rationale?
>>>
>>> Then I grunted about unmanageable commit, because all my troubles to
>>> review it are the effect of it: it is very difficult to read. It is also
>>> difficult for you, because you keep making here mistakes. So if you
>>> cannot write this commit properly and I cannot review it, then it is way
>>> over-complicated, don't you think? But this is still second problem
>>> here, don't ignore the fist - "why?"
>>
>> HI Krzysztof,
>>
>>    Thanks for the review.
>>    To answer the question,
>>
>> "why ?" : The interrupts have been mis-interpreted on many platforms or
>> many interrupts are missing.
> 
> I asked about these two specific platforms. Please explain these
> changes. Above is so generic that tells me nothing.
> 

Is the question, "Why do x1e80100 and sc8280 don't have hs_phy_irq ?"
If so, I checked the SC8280 HW specifics and I see one small error. The 
name was printed wrong. I got it from another source. Will move sc8280 
to list having 5 interrupts. As per x1e80100, I wasn't able to get my 
hands on the hw specifics and I followed the following link by Abel Vesa:

https://lore.kernel.org/r/20231214-x1e80100-usb-v1-1-c22be5c0109e@linaro.org

As per the above patch, x1e80100 had only 4 interrupts.
For ipq5332, it has no hs_phy_irq and so I kept it under this section.

>>
>> Now, if I am adding the missing interrupts, I need to segregate targets
>> also into respective buckets in the same patch and that is what making
>> this patch a little complicated. Is it possible / acceptable to split
>> this into two patches if this is the case. Can you help with suggestions
>> from your end ? Or may be I am understanding your question wrong ? 😅
> 
> Split the patch into manageable chunks.
> 

I will try to split it up, but not sure if it is a good idea. I say so 
because all permutations should be added in single patch and I can't 
split that.

Regards,
Krishna,


