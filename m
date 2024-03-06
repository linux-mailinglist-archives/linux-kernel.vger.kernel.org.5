Return-Path: <linux-kernel+bounces-93679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D757087332D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14AE41C2301E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD2B5F543;
	Wed,  6 Mar 2024 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GZgRO7tK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98385F554;
	Wed,  6 Mar 2024 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718891; cv=none; b=FfOztFctKJ34pXZQvBSpG3YZS7mTJhYthM3UmLUKjg9Z963k5n8ySFq3tkMM1nzFq/4p7ES1gtYLb8Sxl9x5ggxFVJoRWsSvO1ZO07YSAFSVyTI36gPO2H69etjW0dys7boTKdKjPRgSoc1JJSrglFBObxSXYi39SFdBVy18WPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718891; c=relaxed/simple;
	bh=QN3XzJAj1R3sWj03mZ3aXIu5s0TqDPotRLyYDLKw+lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mMTuAEQNCtikDt19418BxEk+/8jA4b188LhHGYyChabxIODM/MKFbwyIjw6gcgGLkeBmuvQWgXYThsvnb/cusTEez4KeCHqsk/F9EO6T7ApfE35FV7km+lagu/p5Vy0LH/ZZ0skjW72hv6dVYxg/bIW3Dp+aVEdgprJ6LdoHTjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GZgRO7tK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4266g62k009792;
	Wed, 6 Mar 2024 09:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Jpg/tAei9KK0CIcihk4hp7iGus5b+h9Ir7FkA6Ntb4A=; b=GZ
	gRO7tKVmKbiRaCl8o/+xO7mxb4LLOSkPb2r1GKFBN5vijdW6ySPE8uU2likHivNZ
	5IGsPr4SEpfvGgsMukIzYUTVSgY1euGESWR70S4sEi9g/svwX/VP3u9ZAwmN7HcA
	6AMJsufucRhIepwoeUCilnoGg8gTq8BR6mpzObsyd2AOUphtI9nvVKRSEKCdb+Tc
	U12nFTDLOk6S4oAEabfVv94oq/M6SEshxtXZagv8YAXYfzlKf0ETzlPuDqyuZKgI
	nIVva2KR0KLyacs7KvltnHihDIK4p876m8qUrqfP0uOiW5wvgyHhTVRxSbrB81wW
	R9j3Yl+xyHk1tXJXDXXA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpke38d58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 09:54:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4269saeD022499
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 09:54:36 GMT
Received: from [10.204.65.104] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Mar
 2024 01:54:31 -0800
Message-ID: <84970313-4ca4-4195-6a06-fd7a0d925648@quicinc.com>
Date: Wed, 6 Mar 2024 15:24:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 14/20] media: venus: pm_helpers: Remove
 pm_ops->core_put
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross
	<agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Mauro Carvalho
 Chehab" <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: Marijn Suijten <marijn.suijten@somainline.org>,
        Stanimir Varbanov
	<stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
 <20230911-topic-mars-v2-14-3dac84b88c4b@linaro.org>
 <ec239f69-6ace-c4a4-409c-771f1d24ce81@quicinc.com>
 <d19bd56c-dc85-46ee-831d-e67768ccf6ed@linaro.org>
Content-Language: en-US
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <d19bd56c-dc85-46ee-831d-e67768ccf6ed@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WoknJ7hswKpRMlBqHGd4GwLD_I1bTXsJ
X-Proofpoint-GUID: WoknJ7hswKpRMlBqHGd4GwLD_I1bTXsJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_05,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060078



On 3/5/2024 4:22 AM, Konrad Dybcio wrote:
> 
> 
> On 3/4/24 07:57, Dikshita Agarwal wrote:
>>
>>
>> On 2/10/2024 2:39 AM, Konrad Dybcio wrote:
>>> Without an OPP table and with vcodec_pmdomains_num (so, v1, v3 and
>>> sdm845_legacy targets), core_put_v4 is a NOP, jut like core_put_v1.
>>> Unify them!
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
> 
> [...]
> 
> 
>>> -static void vcodec_domains_put(struct venus_core *core)
>>> +void vcodec_domains_put(struct venus_core *core)
>>>   {
>>>       dev_pm_domain_detach_list(core->pmdomains);
>>>   
>> what is the base of this change?
>> I don't see dev_pm_domain_detach_list in mainline code.
>> Am I missing anything here?
> 
> The base is specified in the cover letter.
> 
> The code in question is indeed here since January, perhaps
> you're looking at something older than -next.
> 
Thanks for the clarification, I was looking at media tree which
surprisingly doesn't have the base change.
> Konrad
> 

