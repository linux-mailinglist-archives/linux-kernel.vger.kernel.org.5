Return-Path: <linux-kernel+bounces-4999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A07818508
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234F91C23CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6847514297;
	Tue, 19 Dec 2023 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gsWgQZtP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E9A14271;
	Tue, 19 Dec 2023 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJ9fZLO006262;
	Tue, 19 Dec 2023 10:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=RnRLvqjZt6MuGnqJKM1p3NgdyFDJky3EeJ1A+41J22Y=; b=gs
	WgQZtPfhyJE+QTTX65/ks0S9swzby2c8R35sX1FlEI7s+r3BtyIo8uDWXz2KjE+1
	9GU3uSc9ig0W+1xu6Mrys4ifEGl7YQeMrPmCOImwjgHGxIPEIJid5NvwS0ovdPkq
	xmsxHTm4+SCIXJLB0n3Lz/UwettzDL2527dl5aQ3qa6+xXA7jllNPItBtptqopi1
	3XrfYFpSKbRulU3SHdpbu5rPSHTJ8iE/rOe0UT0dXjlYhenAO/N9ptSfp2XsXh5Z
	kgZvsHDfIVB/ZPP68rhMrX0nAswVx8KTG15D/iizydqDN+UBnuK0N4KdLc91cJ1N
	b0rdoltxI4VrFnrKRnkw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v38qsr2e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 10:09:28 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJA9RoY027322
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 10:09:27 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Dec
 2023 02:09:21 -0800
Message-ID: <38604415-b410-4995-9c4f-525536435699@quicinc.com>
Date: Tue, 19 Dec 2023 18:09:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] arm64: dts: qcom: sm8550: remove
 address/size-cells from mdss_dsi1
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tengfei Fan
	<quic_tengfan@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20231219003106.8663-1-quic_tengfan@quicinc.com>
 <20231219003106.8663-2-quic_tengfan@quicinc.com>
 <457e336e-004c-4721-b58d-e9ada16dc04b@linaro.org>
 <a8f168da-14f7-4377-8dea-f282a3eac0a4@quicinc.com>
 <13b61d41-6045-499e-864b-51c6cb6eacf9@linaro.org>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <13b61d41-6045-499e-864b-51c6cb6eacf9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RxcrOaUghPkOwbVPiABImMty2koh5QW9
X-Proofpoint-ORIG-GUID: RxcrOaUghPkOwbVPiABImMty2koh5QW9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=776 impostorscore=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190075



On 12/19/2023 5:41 PM, Krzysztof Kozlowski wrote:
> On 19/12/2023 10:36, Aiqun Yu (Maria) wrote:
>>
>>
>> On 12/19/2023 3:17 PM, Krzysztof Kozlowski wrote:
>>> On 19/12/2023 01:31, Tengfei Fan wrote:
>>>> The address/size-cells in mdss_dsi1 node have not ranges and child also
>>>> have not reg, then this leads to dtc W=1 warnings:
>>>
>> Comments can be more readable:
>> "mdss_dsi1" node don't have "ranges" or child "reg" property, while it
>> have address/size-cells properties. This caused
>> "avoid_unnecessary_addr_size" warning from dtb check.
>> Remove address/size-cells properties for "mdss_dsi1" node.
>>
>>> I cannot parse it. Address/size cells never have ranges or children.
>>> They cannot have. These are uint32 properties.
>> Pls help to comment on the revised commit message. Every time I write a
>> commit message, also takes a while for me to double confirm whether
>> others can understand me correctly as well. Feel free to let us know if
>> it is not readable to you. It will help us as non-English native developers.
>>>
>>>>
>>>>     sm8550.dtsi:2937.27-2992.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae96000:
>>>>       unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>>>>
>>>>
>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>> ---
>>>
>>> I disagreed with the patch before. You resubmit it without really
>>> addressing my concerns.
>>>
>>> I am not sure if this is correct fix and I want to fix all of such
>>> errors (there are multiple of them) in the same way. Feel free to
>>> propose common solution based on arguments.
>> Per my understanding, "qcom,mdss-dsi-ctrl" driver node like "mdss_dsi1"
>> don't need to have address/size-cells properties.
> 
> Just because dtc says so? And what about bindings?
I don't find any reason why "qcom,mdss-dsi-ctrl" driver node need to 
have address/size-cells properties. Document Bindings should also be fixed.
> 
>> Feel free to let us know whether there is different idea of
>> "address/size-cells" needed for the "qcom,mdss-dsi-ctrl" driver node.
> 
> The bindings expressed that idea. If the binding is incorrect, fix the
> binding and the DTS. If the binding is correct, provide rationale why it
> somehow does not apply here etc.
Our plan is to fix the bindings as well.

In case you have missed the question, I just re-place it here:
While there are about 22 different soc dtsi and it's document binding 
files needed to be fixed. Shall we fix it for all qcom related soc usage 
in one patch, or we'd better to split into different patches according 
to soc specifically?

> 
> 
> Best regards,
> Krzysztof
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

