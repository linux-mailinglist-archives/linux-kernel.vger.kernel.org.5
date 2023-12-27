Return-Path: <linux-kernel+bounces-11779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE9E81EB97
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 03:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2BA1F22C07
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BA923B9;
	Wed, 27 Dec 2023 02:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pFSjxleU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4D420E3;
	Wed, 27 Dec 2023 02:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BR2Ukph012628;
	Wed, 27 Dec 2023 02:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=AcAInoG8b8g5OZ+A50u4ffOyj6Q+VZY/3o1pYojAozk=; b=pF
	SjxleU9KhfDO+hr6wCaN/+gqiFT748QgXDgYm3qSWCCr1TbfNRje+/aPNEJ5roGd
	7ko7biXK6C8vqzR6tMElitjnxAhG8cdlGJIfUXZSQZvnzj8UgqPyLYqrgmo/5K2q
	bTi7KfeDOm28xvdgY+sYUkUeuvV41md+HDEtRiCgNKaMIe8GDM9MbqSKGPATrBJn
	h1JKPIs1dxx0PKCQ4c3RlcG3fkhobMoNITkbdoi80/2vu8JwZS81L0Ymg3Jex1sm
	tLePBCwFCdd+j9XwMD9C4oOmEaK//SJAyNNPaZF9c9Dbvz+nG9zvgc3LVdIzqsG+
	xbMloeVSQs3cNtnhc9nQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v7gd9atpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 02:45:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BR2jJFo024139
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 02:45:19 GMT
Received: from [10.253.9.140] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Dec
 2023 18:45:15 -0800
Message-ID: <c2a181b6-089b-44c9-839d-d15b03f1f209@quicinc.com>
Date: Wed, 27 Dec 2023 10:44:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: Increase supported MSI
 interrupts.
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>
References: <1703578131-14747-1-git-send-email-quic_qianyu@quicinc.com>
 <3e3c58e0-6501-42c2-874b-1d9a00abb6c7@linaro.org>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <3e3c58e0-6501-42c2-874b-1d9a00abb6c7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Y_LpMF9_tyIm532UW4dzML5H8Ks4ohzZ
X-Proofpoint-GUID: Y_LpMF9_tyIm532UW4dzML5H8Ks4ohzZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 phishscore=0 mlxscore=0 mlxlogscore=776 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312270019


On 12/27/2023 8:26 AM, Konrad Dybcio wrote:
> On 26.12.2023 09:08, Qiang Yu wrote:
>> On sm8550, synopsys MSI controller supports 256 MSI interrupts. Hence,
>> enable all GIC interrupts required by MSI controller for PCIe0 and PCIe1.
>>
>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> ---
> Thanks for digging this up, could you check the same for other platforms
> too? Particularly for the compute ones which heavily depend on PCIe..
In theory, synopsys MSI controller on all Qualcomm platforms supports 256
MSI interrupts. But my current task is to eable them on sm8550. I will
check the same for other platforms and upstream them when I have time.
>
>>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 24 ++++++++++++++++++++----
>>   1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> index ee1ba5a..80e31fb 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> @@ -1713,8 +1713,16 @@
>>   			linux,pci-domain = <0>;
>>   			num-lanes = <2>;
>>   
>> -			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
>> -			interrupt-names = "msi";
>> +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "msi0", "msi1", "msi2", "msi3",
>> +					  "msi4", "msi5", "msi6", "msi7";
> Please make it one per line, like the interrupts entries.
OK, will modify this part as suggested in next patch. Thanks for your 
review.
>
> Konrad

