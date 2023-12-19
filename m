Return-Path: <linux-kernel+bounces-4988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC5D8184E3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0630028660F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B50414271;
	Tue, 19 Dec 2023 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oFSPdkjR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E7714A8F;
	Tue, 19 Dec 2023 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJ5wsF7007613;
	Tue, 19 Dec 2023 09:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5V9e9YuBtSIeRBWVdttH6UA7saaTLbl9Nvsa7laPmNE=; b=oF
	SPdkjRWoEk2Kq+zp3+9lWU05C5g86YxLGqGQ6aq+XlMm6mpUl6ZK60fTlEzY6kUO
	NyXm+Le/TlD6DmngxHSvoWDKzY0lzTFnrhAjHsjkZ3cw+N+cdsm4qFbgI6kLAAA9
	4IDu3VBT4VWQmr8HOZjmKZ5nePE5HZ6o26USw95a5ZpFUvXziBx0pIyb0x3rCsVT
	1DWWN+puXICx1WwrdCseOFxWwcT8O/yk1NtG9V27sOtqO2HseLHcHjyKkyjFIKEG
	+ZBCtTugapqDU98y1e6ytwj/jlsme7uz6MPotaLpucZlyPhXj8Yw+M1W5fkaE2kT
	oZaKeL48gdxBVtBAIrbQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v34bj8r8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 09:57:19 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJ9vIVg021838
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 09:57:18 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Dec
 2023 01:57:15 -0800
Message-ID: <cd5a0140-295a-4f48-a378-3c2b8be0f499@quicinc.com>
Date: Tue, 19 Dec 2023 17:57:13 +0800
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
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <ec730ce7-2021-4cad-97e6-0a86c6063533@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3YDMuxre7V57zdFvIKiIjde8dtpwbsbU
X-Proofpoint-ORIG-GUID: 3YDMuxre7V57zdFvIKiIjde8dtpwbsbU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxlogscore=541 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190074



On 12/19/2023 3:02 PM, Krzysztof Kozlowski wrote:
> On 19/12/2023 01:50, Tengfei Fan wrote:
>> QCS8550 is derived from SM8550, it is mainly used in IoT scenarios.
> 
> What are the differences? You need to describe the hardware, you have
> entire commit msg for something useful which will avoid such comments
> from reviewers.
> 
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qcs8550.dtsi | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/qcs8550.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs8550.dtsi b/arch/arm64/boot/dts/qcom/qcs8550.dtsi
>> new file mode 100644
>> index 000000000000..254657f46c5e
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qcs8550.dtsi
>> @@ -0,0 +1,6 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include "sm8550.dtsi"
> 
> This is a weird file. I thought qcs8550 has differences from sm8550,
> e.g. lack of modem, so why do you claim you have here MPSS?
MPSS here in qcs8550 is a GPS only MPSS.

QCS8550 will have a different firmware release with sm8550, and it will 
have different memory reserved for the firmware to be used.
While firmware release along with memory map was not settled down yet.
That's why currently qcs8550.dtsi is an "empty file" and only include 
sm8550.dtsi. As long as the firmware release is settled down, we will 
have more detailed different node here.

By the way, RB5 gen2 will also relies on the current qcs8550.dtsi, since 
it is using the same qcs8550 soc, and will use the same firmware release.

We have patch version2 remove the qcs8550.dtsi, and have SOM dtsi 
qcs8550-aim300.dtsi include the sm8550.dtsi. While after discussion, our 
understanding is that we can have an qcs8550.dtsi like this. Feel free 
to let us know if it is not right understanding.

> 
> It's really confusing now.

We can have a syncup to clear the confusing point if needed. :)
> 
> Best regards,
> Krzysztof
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

