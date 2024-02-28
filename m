Return-Path: <linux-kernel+bounces-84813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F7E86ABE7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014F9286D41
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D0E36AEC;
	Wed, 28 Feb 2024 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A/Yt6XK8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A27E3613E;
	Wed, 28 Feb 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115016; cv=none; b=fsQ1apoOtLZnc17sMXeQ+D7bEnZV1yMVbjM6aOz73MkPURJJ26aDbviHoyAWY5lbi+B2jCj/B9wWqDuancLCbSlt6lUhVKK8be0ZbL7n5xZ60h9XjPw43sLF6Wih2D7BOb17aai+G/xDw9aHSq04V/5eXPXPE6YGgDCcrvBQJ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115016; c=relaxed/simple;
	bh=gDrqe1TCdETutZDRLxWC3iPRvaMUjmZdXz4Pg6I6EyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VEonGOu6lz38hqwrokmXSiABa7Yvm8desQymJdzlfPawnT4Tju4u5s614EwkNCusoy35m06CdxbTWuvJTrkS1sWgEhD59vJ3mE7jZG2uLW/TyBjJlXpEm8B7RtU9jAf0MVc5V9KUsMeoy21oTB4VVJOUjRRsCTEAsra2XdiLxdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A/Yt6XK8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S6VSf8009700;
	Wed, 28 Feb 2024 10:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=F/s+thCeoDRDTCkLO/eC1Mvzb84PqPQpXoHEQ1eWBiA=; b=A/
	Yt6XK8AhRgCQbjBtMjCSZqzDYrSnINWozkr0vnVTGqqJSVGHymK9ivj/k0x0o1uN
	WYGtIoILPxfjc78PTJA2OvnoML0+UUsGUo585Mz1fSiPpVKaYw2klS+rrwXdCLCT
	NOLUfZMGA963L5jPhQhT5QgIjm4N2uS2kmjpxTrQj63Y06y3+BDuTehFIK2+3y4O
	5pb84JAY8o+RLBsmvEr/e2GS2g+5g4FFXlOGTMNsVqffYyYS0Fj8/f0QOlXMkGTH
	zAjFwwNcdU00wbbm8hT+H/ChkIni/GoHbS5kvBpqw3VrFXSkj4+lGzbX84rg/B7y
	zwz8ukycaCKE09OmzmFw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whp65sgwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 10:09:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SA9gv8015023
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 10:09:42 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 02:09:37 -0800
Message-ID: <9cc4e465-9979-e4cc-3d2d-84cca307f19e@quicinc.com>
Date: Wed, 28 Feb 2024 15:39:34 +0530
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
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: <dietmar.eggemann@arm.com>, <marcan@marcan.st>, <sven@svenpeter.dev>,
        <alyssa@rosenzweig.io>, <rafael@kernel.org>, <xuwei5@hisilicon.com>,
        <zhanjie9@hisilicon.com>, <sudeep.holla@arm.com>,
        <cristian.marussi@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>, <asahi@lists.linux.dev>,
        <linux-pm@vger.kernel.org>
References: <20240227165309.620422-1-quic_sibis@quicinc.com>
 <20240228050703.lixqywrtxravegc6@vireshk-i7>
 <c165dd32-1e51-2fac-38ae-dd7300d36372@quicinc.com>
 <20240228063511.rcntpb3dhbbhf7fb@vireshk-i7>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20240228063511.rcntpb3dhbbhf7fb@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 56b7fyYeCFjEwNtiQNInKEoxnAAVmICM
X-Proofpoint-ORIG-GUID: 56b7fyYeCFjEwNtiQNInKEoxnAAVmICM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280080



On 2/28/24 12:05, Viresh Kumar wrote:
> On 28-02-24, 10:44, Sibi Sankar wrote:
>> In the existing code, per-policy flags doesn't have any impact i.e.
>> if cpufreq_driver boost is enabled and one or more of the per-policy
>> boost is disabled, the cpufreq driver will behave as if boost is
>> enabled.
> 
> I see. Good catch. The first patch is fine, just explain the problem
> properly and mention that no one is checking the policy->boost_enabled
> field. It is never read.
> 
>> I had to update the policy->boost_enabled value because we seem
>> to allow enabling cpufreq_driver.boost_enabled from the driver, but I
>> can drop that because it was just for book keeping.
> 
> So with cpufreq_driver->boost_enabled at init time, policy's
> boost_enabled must be set too. Do that in the core during
> initialization of the policy instead.
> 
>> I didn't want
>> to include redundant info from another mail thread that I referenced in
>> the cover letter, but will add more info in the re-spin.
> 
> You don't have to, but you need to explain the exact problem in a bit
> more detail since it wasn't obvious here.

ack, will make these changes in the next re-spin.

-Sibi

> 

