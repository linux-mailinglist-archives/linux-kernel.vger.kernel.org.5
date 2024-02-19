Return-Path: <linux-kernel+bounces-70669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B7A859AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 450DFB212E4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E10F3FD4;
	Mon, 19 Feb 2024 03:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EcvGLg8g"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A53220F1;
	Mon, 19 Feb 2024 03:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708312039; cv=none; b=l1Z1SDGBvUp8G7OZZc8Q69yFfhEd5YIlK36Ez/a94ugxCe97c40Ie0Bfnz8qcvUDQYkLJqNGL6L8uV7GT5gGtuPF64yfabVTWAbwtvpqlXTQbHRFcq2izW5/69mrUHn0V8tNiZMCL5Qv+ozDnlkTfyMBSGQYEeUvOerMzt1eSfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708312039; c=relaxed/simple;
	bh=XQeH4obCzIwDVNOBuxCqI+SricNPqRL82HPK4fc4/jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Rnhrv8l82mRBk7VE8raXDeyYOLpC7r9z7uh0Za/P0JUq15XW6CmVfyaef0q6ZDtnk+/OCb8VMOXCdqlOtYuqGbeWTMN+AqeHFKauzMkQ3GKeAzeP0Yg1+huF7QnyP0N1BIJLwaVc3UPcUkhyDSgSGmvMQ29H7xUGrsDlCuCIx40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EcvGLg8g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41J36RFj023496;
	Mon, 19 Feb 2024 03:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=n5FtCz25BpyroYipWCCkQfOwY+crHF/X3CqywesI5qs=; b=Ec
	vGLg8ggIXW+MJIiT2R2IXhKEkgD/b1VrkHDl2PQnisyr1xKFerAa3n9tfouJZcf5
	6hm7sDkLgDmiInOi32qfafC5FDCq8XpQ7t+xx7D2UqWMjhfe8GAuLN9y+/ifKaOW
	N1Wi0z0H1i38Yb+ocrWlwNRA5wlbkLSaG77iQHMARFzYtwELlor2Kg/5tJtEAKin
	nfnbTvv5PeOLuhAE6GJWLEd235RobDhZTwE8OYOe6aSZ0GAyNdMhaCNXZRsArlkk
	M1iT2eGYBWqW6x5AlNAe03VshgxA3y5/B8KbrHFJXReQ8A5nnH9iUMF+PEqwylRT
	FUbR8ytwdopio5mI+Tdw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wan17jkqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 03:07:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41J37A1v000567
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 03:07:10 GMT
Received: from [10.253.36.30] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 18 Feb
 2024 19:07:08 -0800
Message-ID: <6f6dfaa2-f529-c9fe-7dde-402c92f0daf6@quicinc.com>
Date: Mon, 19 Feb 2024 11:06:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] regulator: qcom-rpmh: Fix pm8010 pmic5_pldo502ln minimum
 voltage
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mark Brown
	<broonie@kernel.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <quic_collinsd@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240214121614.2723085-1-bryan.odonoghue@linaro.org>
 <13baed68-1014-4a48-874a-94027a6dd061@sirena.org.uk>
 <f38468b4-8b16-4180-9738-0a2b557651a1@linaro.org>
 <dcce3fa9-ecf3-42be-adf6-ca653a79ba2e@sirena.org.uk>
 <3851e21f-f8cb-487b-9ed4-9975949ff922@linaro.org>
 <a09d6450-95e7-4ed6-a0ad-5e7bb661533a@sirena.org.uk>
 <df6a49f3-88e9-46b4-b7c3-e5419fd01eca@linaro.org>
From: Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <df6a49f3-88e9-46b4-b7c3-e5419fd01eca@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: N25RXN6fofJ8BOE08JqpWMFUfdZivI6e
X-Proofpoint-GUID: N25RXN6fofJ8BOE08JqpWMFUfdZivI6e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-18_21,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=687 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402190024



On 2024/2/15 6:47, Bryan O'Donoghue wrote:
> On 14/02/2024 14:52, Mark Brown wrote:
>> On Wed, Feb 14, 2024 at 02:44:56PM +0000, Bryan O'Donoghue wrote:
>>> On 14/02/2024 14:13, Mark Brown wrote:
>>
>>>> Not just that but also note that every voltage step in the range will
>>>> have the 8mV offset added.
>>
>>> The documents I have just show sensors attached to ldo3, ldo4 and 
>>> ldo6 fixed
>>> at 1.808.
>>
>>> I don't think there's any better or different information than a 
>>> +200000uV
>>> increment TBH.
>>
>> This seems like a very surprising and unusual hardware design, the
>> 1.808V voltage is already unusual.  Note that this may break systems
>> that are trying to set a range of say 1.8-2.0V if they actually need to
>> set 2V.
> 
> Hmm. I'm sure the rail value should be 1.808 its all over the 
> documentation for example when we get to index 3 we hit 2608000
> 
> REGULATOR_LINEAR_RANGE(1808000, 0,  2,  200000),
> 1808000 0
> 2008000 1
> 2208000 2
> 2408000 x
> REGULATOR_LINEAR_RANGE(2608000, 3,  28, 16000),
> 
> And there are other rails @ 1v8 if 1v8
> 
> The one thing I can't easily verify is index 0 = 1808000 and not say 
> 1800000 or indeed that the increment is 200000 and not say 8000.
> 
> I'll see if I can ask around with the hw people and get a more complete 
> answer.
> 
> Similarly now that you've gotten me digging into this problem, it's not 
> clear to me why this regulator isn't just a linear regulator with an 8mv 
> increment over a range of indexes.
> 
> At least the documentation I'm looking at doesn't elucidate.
> 
> I'll dig some more.
Please see the voltage steps for LDO3/4/6 described in the PM8010 TDOS 
document which is the most authoritative that we used internally for 
PMIC driver development:

Index	Vset (mV)
0	1800
1	2000
2	2200
3	2608
4	2624
5	2640
6	2656
7	2672
8	2688
9	2704
10	2720
11	2736
12	2752
13	2768
14	2784
15	2800
16	2816
17	2832
18	2848
19	2864
20	2880
21	2896
22	2912
23	2928
24	2944
25	2960
26	2976
27	2992
28	3008
29	3104
30	3200
31	3312

And I do see from the document change history that step 0 was changed 
from 1808mV and step 2 was changed from 2512mV, I don't know the reason 
of the change though.

Fenglin

> 
> ---
> bod
> 

