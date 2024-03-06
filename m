Return-Path: <linux-kernel+bounces-93328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E59872E10
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6D81F238F3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3420E17BC5;
	Wed,  6 Mar 2024 04:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bJ16IoUx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3203479E4;
	Wed,  6 Mar 2024 04:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709700073; cv=none; b=iK7K7bF9eCfvKFnlIojPrJs/4COCb06GO1o1/EgcDtrbcuVDj73N/jOhr0QR5csCNK0jz0GYiNQj+8ZvK6iNBNurlXQPBPRDmPdPYVHIzasVyks3cPcpQKRc3Oy0OMOq4ysay5jfVFT4uF/5xePd//PvCnaskWmjPB8vRNWlXiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709700073; c=relaxed/simple;
	bh=l1IkUrzW1mx/cl0rRLZCQm8SdUirtVorXIAt/5PbKi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mYvWWLwhT2k2wIT2eEXByT2xhTfyRnSccTv7bKxxzevdTSMHSpUxOr2Hl8ptDqAZ5tCu5wygMaGQPjjN5nB8/lAXI0OvAPUOySksCYVxgdCfnfs7UAVHvKXervNb18zLDuOftoSGP2WhsIsmp8x+8ZEdkNgP5tLVtQamTwLWbLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bJ16IoUx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4263fUZH032054;
	Wed, 6 Mar 2024 04:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=b9uw5W43OlRVR4Cue9hE0vrDZHYom0RR5NRmkjne8MI=; b=bJ
	16IoUxr4tPnyHmlhvxt0VtPN3l8w5cTbSdM23k3hrT8zynb3KgvjuGMBMYVfZ9kC
	4HxxLB5MXVgKNqM0S6sVU+O/IGL5ZiWbGD6zXeNTX7WVkgTHFAucC59FtwhKCv8N
	FLdHSPfupu3TCY7MegnvBr2qZPRmBCPywINumkZnP2yl22V3UHWABsYIBeSWl824
	eAEk3YrX659wKRqQqC6heHbQEM9t0DiJxfeM4Yr2NwbJpvhcmjWWf9XKr+EyjYvi
	eLn15bRJkN/3ie29FA2PvPxCprCppZWSkZ1Ps2y2uwG+2f3DuBrHPzrG9l81UWhP
	uTkLn+EPTBcBD3iHLvgw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wp028adab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 04:41:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4264f6bd023500
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 04:41:06 GMT
Received: from [10.216.40.128] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 20:41:01 -0800
Message-ID: <c82e4053-4cef-4010-a734-4dc537574201@quicinc.com>
Date: Wed, 6 Mar 2024 10:10:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cpufreq: qcom-nvmem: add support for IPQ5321
To: Viresh Kumar <viresh.kumar@linaro.org>
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
Content-Language: en-US
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20240305043503.tgy5ahl243or7lm5@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 90V_eyBGKQmCDXZ03aQ0nE73f1tGH7lZ
X-Proofpoint-ORIG-GUID: 90V_eyBGKQmCDXZ03aQ0nE73f1tGH7lZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_01,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060034



On 3/5/2024 10:05 AM, Viresh Kumar wrote:
> On 04-03-24, 12:42, Viresh Kumar wrote:
>> On 28-02-24, 20:21, Kathiravan Thirumoorthy wrote:
>>> Like all other SoCs in IPQ5332 family, cpufreq for IPQ5321 is also
>>> determined by the eFuse, with the maximum limit of 1.1GHz. Add support
>>> for the same.
>>>
>>> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
>>> ---
>>>   drivers/cpufreq/qcom-cpufreq-nvmem.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>> index ea05d9d67490..0a46b5d49d32 100644
>>> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>> @@ -191,6 +191,7 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>>>   	case QCOM_ID_IPQ5312:
>>>   	case QCOM_ID_IPQ5302:
>>>   	case QCOM_ID_IPQ5300:
>>> +	case QCOM_ID_IPQ5321:
>>>   	case QCOM_ID_IPQ9514:
>>>   	case QCOM_ID_IPQ9550:
>>>   	case QCOM_ID_IPQ9554:
>>
>> Applied. Thanks.
> 
> Dropped since the previous commit it required too. Can we get the
> necessary acks for me to pick those ?
> 

Sorry for not mentioning the dependencies.

patch 1/3 and 2/3 are already has the R-b and A-b tags. But typically 
those patches will go via qcom tree. Do you want to pick it via your 
tree? Sorry, I'm not sure on this...


Thanks,
Kathiravan T.

