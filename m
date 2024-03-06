Return-Path: <linux-kernel+bounces-94213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D08B1873B6D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86EB31F2AB7C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF99313790F;
	Wed,  6 Mar 2024 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MYRvAxGF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BE413540D;
	Wed,  6 Mar 2024 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740831; cv=none; b=ObW0/syCcfVQA6uFBfr4yaJXGpd2XvHDWxgFS8Deolr/593BWytYGidNIEVVc4AtyAjSEbOAzPVjNCo1yXxo1SmXd6pdBuEHREBwHeQOiyXs1sDGd3A1mtpWQmZyIY2Vtm1Kv4zu8TnJiOcQmE7HWXgj7iXU9SoZSfECnJr99xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740831; c=relaxed/simple;
	bh=auRJfm3sylNx6NPfCCOdu20oXEWiMOJz6R6dHLB8vKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j9QVCSch+suhjNAQC8kUM87Ico4Cz0InQMKsRwXHzjC2o2XfaTmD+tim+jG0HcDOmr8vL4maMDcdhoyCEvz/Ms4vUXW+mUn5FGwZKqiTVuh/sXmJuI2o7b1MP8hIsY13XihbrW4pDCYroR3tKFK5iSIKxhJWnLz66CcIeLem75c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MYRvAxGF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426BdF6I001288;
	Wed, 6 Mar 2024 16:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nZyllbOU13xl9EltbQjE41mNzT9p5phP/uuPsYOcmgU=; b=MY
	RvAxGFbwDxynPtTh2jcxgC0KcArobFe5Hx0Xh/uyehvLxb5YW873GsfCJOmu8roA
	tDfmcpt9nv5rAX6vh3Zy9sN+K0eqKThPHxMaNgiGLrOAHl90NwvW+N5LGAjoEKA7
	IjSuMiPKh4ayBcQFH1faswOK41sOqeVqaW0vxySUVAiQYktzja4H0N6jrcK/ZJCs
	zdgx8uz2DLFR9avDueRZjE6SeBgZHg7LVIIqIZRcNxQXon5JnAb0tYX3XRRVIzBb
	fensyt9nhhveSrWxidYfVqwps+OQXEllm2CEMpqbFmq5e1gfgrRmJ76/cdmovsn6
	dtBKuNo26x4U0yaWufyw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpnfvgur7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 16:00:13 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 426G0CZb022707
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 16:00:12 GMT
Received: from [10.216.51.173] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Mar
 2024 08:00:05 -0800
Message-ID: <0d0a2ed6-92f0-440e-b241-8036a4e0ebdc@quicinc.com>
Date: Wed, 6 Mar 2024 21:30:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] Enable firmware-managed USB resources on Qcom targets
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <quic_wcheng@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_nkela@quicinc.com>, <manivannan.sadhasivam@linaro.org>,
        <ulf.hansson@linaro.org>, <sudeep.holla@arm.com>,
        <quic_shazhuss@quicinc.com>
References: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
 <4d2501a7-d56d-4736-95d7-41556166859b@linaro.org>
 <1a47c20a-abda-4493-a8f0-ff7b4e144d9c@quicinc.com>
 <f2b9a9f1-0ede-4c01-9bef-ee497b3191a6@linaro.org>
From: Sriram Dash <quic_sriramd@quicinc.com>
In-Reply-To: <f2b9a9f1-0ede-4c01-9bef-ee497b3191a6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ePNhhWULXCCmaqtzp7iI0p56VZqK-gbe
X-Proofpoint-GUID: ePNhhWULXCCmaqtzp7iI0p56VZqK-gbe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_10,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060128

On 3/6/2024 12:34 PM, Krzysztof Kozlowski wrote:
> On 05/03/2024 19:04, Sriram Dash wrote:
>> On 3/5/2024 10:42 PM, Krzysztof Kozlowski wrote:
>>> On 05/03/2024 17:57, Sriram Dash wrote:
>>>> Some target systems allow multiple resources to be managed by firmware.
>>>
>>> Which? Why this is so vague...
>>>
>>
>> SA8775 will be using it as pilot. Will include the target name.
>>
>>>> On these targets, tasks related to clocks, regulators, resets, and
>>>> interconnects can be delegated to the firmware, while the remaining
>>>> responsibilities are handled by Linux.
>>>>
>>>> To support the management of partial resources in Linux and leave the rest
>>>> to firmware, multiple power domains are introduced. Each power domain can
>>>> manage one or more resources, depending on the specific use case.
>>>>
>>>> These power domains handle SCMI calls to the firmware, enabling the
>>>> activation and deactivation of firmware-managed resources.
>>>>
>>>> The driver is responsible for managing multiple power domains and
>>>> linking them to consumers as needed. Incase there is only single
>>>> power domain, it is considered to be a standard GDSC hooked on to
>>>> the qcom dt node which is read and assigned to device structure
>>>> (by genpd framework) before the driver probe even begins.
>>>
>>> This will break the ABI. Sorry, come with an ABI stable solution.
>>>
>>
>> The plan is to include multiple power-domains and fw-managed
>> property or similar in the device tree and fw-managed property
>> will be deciding if we need some resource management offloaded
>> to firmware. So, OS is always in control here. The decision
>> making will be done in the drivers. Also, there will be no
>> separate vendor hooks.
> 
> This does not answer ABI breakage. Also, I don't have a clue what are
> "vendor hooks".
> 

Apologies for the confusion, Krysztof.
The bindings will depict whether the compatible will use
clocks/ regulators, etc or not. Will take care in the
next version on top of the scmi based dt solution.

> Best regards,
> Krzysztof
> 

