Return-Path: <linux-kernel+bounces-138466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E7189F1A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 985B9B249D1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443F415B113;
	Wed, 10 Apr 2024 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oSs/2HU8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E2B1598F2;
	Wed, 10 Apr 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750646; cv=none; b=jG0BK+C3rXv925IOWhNH7XM8ET++2RJOuikuL9ax/dVfIXzUtxXxFK1V4CAzxhEklyHPgN5TN0Ud5IeJAAjhQsH3Fn5S9m9qBaseelnUGiVu6yuYD9T21YgwJaBfIlN7uwpo7hrWAEDYVigdQcCktpQXDh3jy3x4fNfRvBI1RXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750646; c=relaxed/simple;
	bh=tdppY4tgi+O68xVH71ZZoSDz/OuC4sRNlpnC4mWN5pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o5rWY8T2xXC15LBEfNkyf8tPazKk08O6QnXosyqVaMc5JdePxM57jgVR/+EzdRkcz2VW8Fa7zgTGAvCXGc62hIS9A0ehWo5YLFVUQ2vCoEEdnLl+CnhBIvjCzlcy1ngoqzlQFTlV9mE6s49ofrwAOfZejcaX1EvBybOpPNTU3k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oSs/2HU8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43ABZIp6001155;
	Wed, 10 Apr 2024 12:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=uTWaQyaAK8NhCoIO96+/pn6A5LF/VnM/wHGGjKcjQ8w=; b=oS
	s/2HU8bU+Rie6SvJigbM3kjYdhNwbUZmiFZ2uJ+88mWVu3ypGNkgFrzghrPWOjOv
	59sa8sJg92314XGtFQ5kzZK701V3I0zS54MvMi/5mHUJNCSmK9dr0OU7gSdViTyM
	T2Oz6+AIzbDXXJmV2BTF6+zMdPoBcAVnRFMh4XEIm/J5szsSNTp6alf32+z7pYBz
	sO1keyMFuP8Twc6C6g0rmO9xhSfLnjnV+62nDvdN11aSq1GlvmvPPdtfYx5CjKYd
	Z9uMIK8xyunFvwfi/49L666BpgJCAH3CJcWHdOxm0xFLMXC8AEIi5epx5ddmjVs3
	EfbQXrIxc5Ea0G8HL2oQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdpnfsaex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 12:03:48 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43AC3l7W022559
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 12:03:47 GMT
Received: from [10.206.101.41] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 10 Apr
 2024 05:03:42 -0700
Message-ID: <335d1eee-a6f1-6502-7f27-c7362a53b4ba@quicinc.com>
Date: Wed, 10 Apr 2024 17:33:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 03/19] media: venus: pm_helpers: Add kerneldoc to
 venus_clks_get()
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dikshita Agarwal
	<quic_dikshita@quicinc.com>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Philipp
 Zabel" <p.zabel@pengutronix.de>
CC: Marijn Suijten <marijn.suijten@somainline.org>,
        Stanimir Varbanov
	<stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230911-topic-mars-v3-0-79f23b81c261@linaro.org>
 <20230911-topic-mars-v3-3-79f23b81c261@linaro.org>
 <80c0ecb3-1157-1d7a-0829-c3b68b65f17f@quicinc.com>
 <66492657-3649-3bdb-b7df-0f5196418e06@quicinc.com>
 <b4c56cad-0a3c-4b74-b9fa-0931204d1514@linaro.org>
From: Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <b4c56cad-0a3c-4b74-b9fa-0931204d1514@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 92yuKVaf3duzItn5r642t-qWimk1U03P
X-Proofpoint-ORIG-GUID: 92yuKVaf3duzItn5r642t-qWimk1U03P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100087


On 4/9/2024 11:52 PM, Konrad Dybcio wrote:
> 
> 
> On 4/5/24 14:44, Vikash Garodia wrote:
>> Hi Konrad,
>>
>> On 4/5/2024 1:56 PM, Dikshita Agarwal wrote:
>>>
>>>
>>> On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
>>>> To make it easier to understand the various clock requirements within
>>>> this driver, add kerneldoc to venus_clk_get() explaining the fluff.
>>>>
>>>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>   drivers/media/platform/qcom/venus/pm_helpers.c | 28
>>>> ++++++++++++++++++++++++++
>>>>   1 file changed, 28 insertions(+)
>>>>
>>>> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c
>>>> b/drivers/media/platform/qcom/venus/pm_helpers.c
>>>> index ac7c83404c6e..cf91f50a33aa 100644
>>>> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
>>>> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
>>>> @@ -23,6 +23,34 @@
>>>>     static bool legacy_binding;
>>>>   +/**
>>>> + * venus_clks_get() - Get Venus clocks that are not bound to a vcodec
>>>> + * @core: A pointer to the venus core resource
>>>> + *
>>>> + * The Venus block (depending on the generation) can be split into a couple
>>>> + * of clock domains: one for main logic and one for each video core (0-2
>>>> instances).
>> s/main logic/controller. Applies to below places as well.
> 
> Ok - so "controller" is the cortex-m3 (m5?) that power-sequences
> the DSP etc.?
Thats correct. The firmware runs on the controller and takes care of many
aspects of hardware (dsp or core) programming.

>>
>>>> + *
>>>> + * MSM8916 (and possibly other HFIv1 users) only feature the "main logic"
>>>> + * domain, so this function is the only kind if clk_get necessary there.
>> To be checked, unable to get the clock document to see why only core clocks
>> (VENUS0_VCODEC0_CLK). Will update.
> 
> FWIW 8916 only has GCC_VENUS0_VCODEC0_CLK (and _SRC) and AHB/AXI/TBU clocks,
> no (currently registered) clock for the entire block.
> 
>>
>>>> + *
>>>> + * MSM8996 (and other HFIv3 users) feature two video cores, with core0 being
>>>> + * statically defined a decoder and core1 an encoder, with both having
>>>> + * their own clock domains.
>>>> + *
>>>> + * SDM845 features two video cores, each one of which may or may not be
>> s/two video cores/two identical video cores
>>>> + * subdivided into two encoder/decoder threads.
>> decoder cannot be split into core threads. you can keep it like "each of which
>> is capable to do any encode or decode"
> 
> So it's not about any splitting, but rather the ability to do both encode
> and decode, sort of like how the displayport controller can nowadays do both
> eDP and DP, depending on what init data you send to it?
It is precisely that way, just that there are cases of cores with dedicated
codec support, hence identical implies that each of them can do same processing.

>>
>>>> + *
>>>> + * Other SoCs either feature a single video core (with its own clock domain)
>>>> + * or one video core and one CVP (Computer Vision Processor) core. In both
>>>> cases
>>>> + * we treat it the same way (CVP only happens to live near-by Venus on the
>>>> SoC).
>>>> + *
>>>> + * Due to unfortunate developments in the past, we need to support legacy
>>> why unfortunate? please re-phrase this.
>>>> + * bindings (MSM8996, SDM660, SDM845) that require specifying the clocks and
>>>> + * power-domains associated with a video core domain in a bogus sub-node,
>>>> + * which means that additional fluff is necessary.
>> Some background:
>> It was done that way to support decoder core with specific clocks and similarly
>> for encoder. Earlier architectures use to have different clock source for these
>> specific decoder/encoder core clocks, now there is a common clock source for
>> both the cores. Hence if any one is enabled, others gets enabled as it is
>> derived from same source.
>> So if we see the later bindings, the clocks were moved out of sub node to main
>> venus node.
> 
> Yeah and I don't really see the reason why the binding needed to be changed
> for this, you can simply get the clocks by name and poke at the specific clk*
> (or an array of them), no matter where they were _get()-ed from.
I think the reason for not doing a name based clock as it might be possible that
the clock is not available or applicable to subsequent SOC.

Regards,
Vikash

