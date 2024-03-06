Return-Path: <linux-kernel+bounces-93458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3053D873028
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622551C22940
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0395B5D469;
	Wed,  6 Mar 2024 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Re0hK8ek"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18065BAFD;
	Wed,  6 Mar 2024 08:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712019; cv=none; b=hdstks46I7o0KHf7Hu2dqlS2TpSVwTk2JTWGheRJ4UFUJlNZbI0O6iav02GWl5mhQGZEJPu9EnmM04OrIkF2OghUcfYEncWUEtZrEoiO5pjOcgia8kL2jwkKB+eaFo/TEqp7stdy7Jn0urtgf7inOYn2Nzk3lYkq/OuiYzgp+gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712019; c=relaxed/simple;
	bh=HElGcLHEHp4emzZmxDRo6iAECLg7ba1o1U0dZwSc2H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uj2MOnpgXJ/Bau2IrBLLO9CMxOMtUzzfJVAVKi1qgmym/5swClFLv4IhCVCtmFljyJ36i+Y4llllGENIEUK/0ePMKr5U6jsThajYwkHqRA4yhGpITWFSFqnSl9AW/2dN0G7UcB7kuotmyf74Kl8ssuMNKAMsYUQRkwKUXXo8tzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Re0hK8ek; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4266l7Nj001513;
	Wed, 6 Mar 2024 08:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9hGGdIZDRPYpQ51Vqfi3qcIUoqbqMZ4LFqy+LyC/LFI=; b=Re
	0hK8ek0B+UpW8W/647OGS10Cy3PjCRELhH7CAz7oziNqMkGXGq5w/jqCKJIQPCu4
	Vj/fwjsuxWsXMbdXe6SdqbiEMv+Ip4t1OhLoiep2WcC0OKGCv5smj+hg1KbGB4Iu
	s26ngOWLVQazdjzUSRli+KBZn3WsWp0tlkwHuuASmGquO21B4+V3Ni74ifUoAggc
	nHY/MHatYyPCFM1hy5wMHiyvTnsQx4h6+V6zFGl20NedC7Xf3AY1TK69/kb4jri4
	xAI32bjceX6cT6oweqU9BSPBaWtHJkCb2Sxku2TcgeFwe3LWdeQBnhpzk6EP+O1G
	JxOKRR8Juhqz18ewDKqA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpjy3r782-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 08:00:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42680BBp030811
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 08:00:11 GMT
Received: from [10.216.40.128] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Mar
 2024 00:00:06 -0800
Message-ID: <d20c9b08-4f9a-43d0-91ad-b971fdd19422@quicinc.com>
Date: Wed, 6 Mar 2024 13:30:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cpufreq: qcom-nvmem: add support for IPQ5321
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20240228-ipq5321-sku-support-v1-0-14e4d4715f4b@quicinc.com>
 <20240228-ipq5321-sku-support-v1-3-14e4d4715f4b@quicinc.com>
 <20240304071222.cx3s37mphddk23bv@vireshk-i7>
 <20240305043503.tgy5ahl243or7lm5@vireshk-i7>
 <c82e4053-4cef-4010-a734-4dc537574201@quicinc.com>
 <87e0aa08-9176-495d-b799-c2ddb53c8a23@linaro.org>
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <87e0aa08-9176-495d-b799-c2ddb53c8a23@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ImTypgyjNnk-rApP2iuZX1daci22E_CK
X-Proofpoint-ORIG-GUID: ImTypgyjNnk-rApP2iuZX1daci22E_CK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_04,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=960
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060062



On 3/6/2024 12:52 PM, Krzysztof Kozlowski wrote:
> On 06/03/2024 05:40, Kathiravan Thirumoorthy wrote:
>>>>
>>>> Applied. Thanks.
>>>
>>> Dropped since the previous commit it required too. Can we get the
>>> necessary acks for me to pick those ?
>>>
>>
>> Sorry for not mentioning the dependencies.
>>
>> patch 1/3 and 2/3 are already has the R-b and A-b tags. But typically
> 
>  From whom? Not from Qualcomm SoC maintainers.


Does the "necessary acks" refers for to the acks from Qualcomm SoC 
maintainers? Sorry, I wasn't aware of that. That's why I mentioned 
"Sorry, I'm not sure on this..." couple of lines below.


> 
>> those patches will go via qcom tree. Do you want to pick it via your
>> tree? Sorry, I'm not sure on this...
> 
> Your cover letter or patch changelog should clearly document
> dependencies, so maintainers could understand what to do with this patch.


Understood. Will take care in future.


> 
> Best regards,
> Krzysztof
> 

