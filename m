Return-Path: <linux-kernel+bounces-5007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D32818532
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41658B2402A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF6614A94;
	Tue, 19 Dec 2023 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BJi8VpRz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FC514A87;
	Tue, 19 Dec 2023 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJ7NKL2001808;
	Tue, 19 Dec 2023 10:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1SLkwKsxGvngtX8EoaTWVYJBcj1k3lIqDzT9XfxdYcU=; b=BJ
	i8VpRzMP1wwhSYxxwj/nJA+e8Ikuecp4PSfR9kjIk9bDcZfYu71ZAJbK09nJ79QV
	Sr+7spGr39t2Ft/xChVhxURJkH9ZLvo7PVwweh4HNyVskgz1Bz+GN+0RQFGH/06U
	hJ7M3+48cAkBk1xfj2NOMT4AtspZyT9KYdFKixqbso6KTFSaTWUuAarOtXsgVTw/
	dFXCxqOqsBjuYXfdVZPwrieuiVMafhAHThBmG6wQvZxBDR412nR6xUDSUFMS94rF
	Q3rs8Cm+2AIFNTplVzEsjSWYljgemOTP63Z16dnYL093AzGKtpxW7z/hzQPdf1yD
	cagrtIFBLJxZAE5ejD+Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v35tm8kqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 10:19:56 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJAJtpX018865
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 10:19:55 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Dec
 2023 02:19:52 -0800
Message-ID: <d955f3bb-c73e-4777-b268-a8abc70788ef@quicinc.com>
Date: Tue, 19 Dec 2023 18:19:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] arm64: dts: qcom: qcs8550: introduce qcs8550 dtsi
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tengfei Fan
	<quic_tengfan@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231219005007.11644-1-quic_tengfan@quicinc.com>
 <20231219005007.11644-5-quic_tengfan@quicinc.com>
 <ec730ce7-2021-4cad-97e6-0a86c6063533@linaro.org>
 <cd5a0140-295a-4f48-a378-3c2b8be0f499@quicinc.com>
 <f0f707c0-dd96-4409-bfc5-118d885933e8@linaro.org>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <f0f707c0-dd96-4409-bfc5-118d885933e8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -ZtrUU6EXTV5XxUlWjMI9IWrvh2AzJ3Y
X-Proofpoint-ORIG-GUID: -ZtrUU6EXTV5XxUlWjMI9IWrvh2AzJ3Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=244
 impostorscore=0 phishscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190076



On 12/19/2023 6:01 PM, Krzysztof Kozlowski wrote:
> On 19/12/2023 10:57, Aiqun Yu (Maria) wrote:
>>
>>
>> On 12/19/2023 3:02 PM, Krzysztof Kozlowski wrote:
>>> On 19/12/2023 01:50, Tengfei Fan wrote:
>>>> QCS8550 is derived from SM8550, it is mainly used in IoT scenarios.
>>>
>>> What are the differences? You need to describe the hardware, you have
>>> entire commit msg for something useful which will avoid such comments
>>> from reviewers.
>>>
>>>>
>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/qcs8550.dtsi | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>    create mode 100644 arch/arm64/boot/dts/qcom/qcs8550.dtsi
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/qcs8550.dtsi b/arch/arm64/boot/dts/qcom/qcs8550.dtsi
>>>> new file mode 100644
>>>> index 000000000000..254657f46c5e
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/qcom/qcs8550.dtsi
>>>> @@ -0,0 +1,6 @@
>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>> +/*
>>>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + */
>>>> +
>>>> +#include "sm8550.dtsi"
>>>
>>> This is a weird file. I thought qcs8550 has differences from sm8550,
>>> e.g. lack of modem, so why do you claim you have here MPSS?
>> MPSS here in qcs8550 is a GPS only MPSS.
> 
> Is it different or the same? Is the interface the same? So many
> questions and so little information. You have entire commit msg to
> explain this.
we can add all current email information into the commit message in next 
patchset.
> 
>>
>> QCS8550 will have a different firmware release with sm8550, and it will
>> have different memory reserved for the firmware to be used.
>> While firmware release along with memory map was not settled down yet.
>> That's why currently qcs8550.dtsi is an "empty file" and only include
>> sm8550.dtsi. As long as the firmware release is settled down, we will
>> have more detailed different node here.
> 
> So the DTS is not really usable now?
curent qcs8550.dtsi is an "empty file" which is identical to "sm8550.dtsi".
While qcs8550-aim300-itot.dts is currently used with a "temporary 
reserved memory" for those engineer qcs8550 firmware for boot up and 
limited function verify.

So the idea here is to postpone only the firmware related reserved 
memory part. And open an "empty file" qcs8550.dtsi for common which can 
be used for other board like qcs8550-rb5-gen2.
>>
>> By the way, RB5 gen2 will also relies on the current qcs8550.dtsi, since
>> it is using the same qcs8550 soc, and will use the same firmware release.
>>
>> We have patch version2 remove the qcs8550.dtsi, and have SOM dtsi
>> qcs8550-aim300.dtsi include the sm8550.dtsi. While after discussion, our
>> understanding is that we can have an qcs8550.dtsi like this. Feel free
>> to let us know if it is not right understanding.
>>
>>>
>>> It's really confusing now.
>>
>> We can have a syncup to clear the confusing point if needed. :)
>>>
> 
> The code and commit msg are confusing. I need to keep asking you to get
> any information.
> 
> Best regards,
> Krzysztof
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

