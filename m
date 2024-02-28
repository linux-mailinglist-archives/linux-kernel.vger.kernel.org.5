Return-Path: <linux-kernel+bounces-84521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E2286A7C3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E431C225AD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E845920DF4;
	Wed, 28 Feb 2024 05:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a6Nx1GOP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C010F4400;
	Wed, 28 Feb 2024 05:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709096908; cv=none; b=fVT3fw8g+f/TZQSn92UrPxy0vLz6ZaB3JiG9i6NdA4e7+O53CfhuPzUai+Dj25zLbYTGIAfgTwWBgCCmtQnwJvnDr5pYnFLUrbPYKED7Y/MzFsBONf2Io8UXir+GUyw3gBf+gvAd5JJPRBIydt1aQaGz5qwHf3ZwO8NswGeO9oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709096908; c=relaxed/simple;
	bh=Xz8Fbm+En7VKrGzgfQfCUIEnQZXECWKt4BXo/LBqdbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=awxfjliYdkIb81gyCOyiZhxJlhL1VNY06tJrTGk2Nlbn+3NwtZ09psDt3rwHipZtP9u9iYNmbXJeuvne5fnFSDJVW+hDCoHx6q4Onyf2LE6HGAQh4EWaK4Eyod+++bOwuDLSE4oCw6AmEwj2Y/Ot4IoRZF6+dtO/UFtHwIdAyRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a6Nx1GOP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S4H5VP005737;
	Wed, 28 Feb 2024 05:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ADs/g9aCTtyhr3ZcZu770+VJGPQMhuNNrBigWTZW0bs=; b=a6
	Nx1GOPgV8J6AznFtu1ar1mP0Je4eGk8RYDsd0mMCMkwE/ENoCvFJI8RFFLZOBqUf
	gQ2TDUk/jvXV1C2XhqvAZ6Z8OUZy0rB4mDeArXjUz+dXuiuaV8GujtVulPfgrnBL
	9rF9Pr5jh/KIn+bD+x61/8TeW8IoV83eRRfeh774xpXpmscARukHaEKs8VAgh6Yl
	p2C/yZB7kWnxgERI4IDyMoDPS1tPJ+a6duWcTUHDvGiuffvc5n6sIrADI5UgZxHF
	nmlxAcQD2qPmckubznQPFyO7AVGNbMcGv1WVeEXfWA3Cp6/MIlWkHARLuTWQdSYc
	I0YGwlPDSw+F49UlkoxA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whp65rxug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 05:07:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41S57iVo005663
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 05:07:44 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 21:07:39 -0800
Message-ID: <feb78f0d-1759-9478-f945-1f48107f6992@quicinc.com>
Date: Wed, 28 Feb 2024 10:37:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] Fix per-policy boost behavior
Content-Language: en-US
To: Jie Zhan <zhanjie9@hisilicon.com>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <linux-arm-kernel@lists.infradead.org>,
        <asahi@lists.linux.dev>, <linux-pm@vger.kernel.org>,
        <dietmar.eggemann@arm.com>, <marcan@marcan.st>, <sven@svenpeter.dev>,
        <alyssa@rosenzweig.io>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <xuwei5@hisilicon.com>
References: <20240227165309.620422-1-quic_sibis@quicinc.com>
 <91118802-eb8c-6225-3610-05e16270b3c4@hisilicon.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <91118802-eb8c-6225-3610-05e16270b3c4@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _nKpWWVZNxaO1gkA06UCXFH0lmoiA9zm
X-Proofpoint-ORIG-GUID: _nKpWWVZNxaO1gkA06UCXFH0lmoiA9zm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280038



On 2/28/24 07:36, Jie Zhan wrote:
> Hi Sibi,
> 
> Thanks for pointing this issue out.
> 
> However, I can't clearly see how the existing code fails.
> 
> cpufreq_frequency_table_cpuinfo() checks cpufreq_boost_enabled(),
> and that should be already set in cpufreq_boost_trigger_state() before
> calling cpufreq_boost_set_sw(), so presumably cpufreq_boost_set_sw()
> is supposed to work as expected.
> 
> Can you explain this a bit further?

In the existing code, per-policy flags doesn't have any impact i.e.
if cpufreq_driver boost is enabled and one or more of the per-policy
boost is disabled, the cpufreq driver will behave as if boost is
enabled. The second issue was just book keeping, meaning some drivers
enable boost by default, however the per-policy boost flags are set
as disabled during boot.

-Sibi

> 
> Cheers,
> Jie
> 
> On 28/02/2024 00:53, Sibi Sankar wrote:
>> Fix per-policy boost behavior by incorporating per-policy boost flag
>> in the policy->max calculation and setting the correct per-policy
>> boost_enabled value on devices that use cpufreq_enable_boost_support().
>>
>> Logs reported-by Dietmar Eggemann [1]:
>>
>> [1] 
>> https://lore.kernel.org/lkml/265e5f2c-9b45-420f-89b1-44369aeb8418@arm.com/

you can also have a look at ^^ thread for more info.

>>
>> Sibi Sankar (2):
>>    cpufreq: Fix per-policy boost behavior on SoCs using
>>      cpufreq_boost_set_sw
>>    cpufreq: apple-soc: Align per-policy and global boost flags
>>
>>   drivers/cpufreq/apple-soc-cpufreq.c |  1 +
>>   drivers/cpufreq/cpufreq.c           | 15 +++++++++------
>>   drivers/cpufreq/freq_table.c        |  2 +-
>>   3 files changed, 11 insertions(+), 7 deletions(-)
>>
> 

