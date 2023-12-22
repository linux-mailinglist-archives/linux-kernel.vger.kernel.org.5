Return-Path: <linux-kernel+bounces-9746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E0F81CAA3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72BFA1C21F84
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB5F199CE;
	Fri, 22 Dec 2023 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dlnSZaKg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157F718B00;
	Fri, 22 Dec 2023 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BMDMKQ5016120;
	Fri, 22 Dec 2023 13:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6TPncqO6Duso2oWrroEP6CTyYy49aXdVwwWn4631rfI=; b=dl
	nSZaKg2mO375Co3qcM4Z62dJJMPEsNex5UGEMVcW2251elIgGaRijAHIpGx70Aku
	cjNqxTN/YzsmOIfhKN1A48nitj7VAu6NjWIarO2JOpLLb0Cj7l9fgZji258+NH1l
	j1JARDkd/Xn7dZUvwHeh+GcyBOIrceVOp4BhF5Vm8ChfMpQTjlOcsHj0tcUBMXU0
	KJY7L/oWyXDYQWembKlF5pIRwi/MnKiAS15RQ48WGSrQiTPT2iFTi+wghGI6QAdj
	5JaGe/Z/q1qkjeFtMilQ/s/jMUgLn+39hjc9WZr3tJMaShGgcu9ufT4XASX4RWtk
	/XdyXoYA1C2gKvtQAmRw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v57vg8n4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 13:25:42 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BMDPfnU012701
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 13:25:41 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 22 Dec
 2023 05:25:38 -0800
Message-ID: <a93867af-80e6-ab91-6a13-cdf94aa7f80c@quicinc.com>
Date: Fri, 22 Dec 2023 18:54:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] arm64: dts: qcom: qcm6490-idp: Enable various
 remoteprocs
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231220114225.26567-1-quic_kbajaj@quicinc.com>
 <20231220114225.26567-2-quic_kbajaj@quicinc.com>
 <d7ae374a-7269-4992-ad44-18b2516cad42@linaro.org>
 <CAA8EJppYuXpqKpTcUda1LBFfBmm40-VpC+3heJqoL82kS=+erA@mail.gmail.com>
 <519138d9-2434-4357-abec-f400b87755c6@linaro.org>
 <CAA8EJpoEwU_S05EdO+sXekE355d5vAQCO+Vt3iH9yibhqOhH_A@mail.gmail.com>
From: Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <CAA8EJpoEwU_S05EdO+sXekE355d5vAQCO+Vt3iH9yibhqOhH_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -qaP_QFJsBw26DbghkFSIXJMZ2GwhVrV
X-Proofpoint-ORIG-GUID: -qaP_QFJsBw26DbghkFSIXJMZ2GwhVrV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312220098



On 12/20/2023 6:04 PM, Dmitry Baryshkov wrote:
> On Wed, 20 Dec 2023 at 14:29, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> On 20.12.2023 13:18, Dmitry Baryshkov wrote:
>>> On Wed, 20 Dec 2023 at 13:46, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 20/12/2023 12:42, Komal Bajaj wrote:
>>>>> Enable the ADSP, CDSP, MPSS and WPSS that are found on the SoC.
>>>>>
>>>>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>>>>> ---
>>>>>   arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 20 ++++++++++++++++++++
>>>>>   1 file changed, 20 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>>>>> index 03e97e27d16d..ad78efa9197d 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>>>>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>>>>> @@ -419,6 +419,26 @@ &qupv3_id_0 {
>>>>>        status = "okay";
>>>>>   };
>>>>>
>>>>> +&remoteproc_adsp {
>>>>> +     firmware-name = "qcom/qcm6490/adsp.mdt";
>>>>
>>>> Why MDT not MBN?
>>>
>>> I agree here. NAK until this is .mbn. Please follow the example of
>>> other boards when you write patches.
>>>
>>>>
>>>> I don't see these files in linux-firmware and your cover letter did not
>>>> explain anything around their submission. What's the status on that part?
>>>
>>> This isn't usually required, is it? I mean, the firmware can come from
>>> linux-firmware, from the device partition or in any other way. With
>>> the FW_LOADER_USER_HELPER this becomes just the key string used to
>>> identify firmware to be loaded.
>> I think Krzysztof referenced the fact that the Qualcomm-made boards
>> usually came with redistributable firmware.
>>
>> As far as my 5 cents go, not submitting the files to linux-firmware.git
>> only harms the user experience, so I'd always advocate for it, whenever
>> that is actually possible.
> 
> Me too. I think this is work in progress on the Qualcomm side, see the
> discussion at https://github.com/Linaro/meta-qcom/pull/551 .
> 

I was searching for MBN files pushed for SM8550 at 
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/, 
but could not find it. Am I missing something?

Are we maintaining it somewhere else asking just out of curiosity and 
learning and do similar for QCM/QCS6490.

Thanks
Komal

