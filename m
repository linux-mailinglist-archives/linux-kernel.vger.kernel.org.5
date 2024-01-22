Return-Path: <linux-kernel+bounces-33988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26206837180
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D5E29421D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B255102B;
	Mon, 22 Jan 2024 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L+07vhj+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B168750A9E;
	Mon, 22 Jan 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948430; cv=none; b=apaUxJs8yTzjkLvVtWQ2EiE5lDwnUXwHueQ9+4etdsz38bOjpp+bLFj3jfplhkE7a2hlx7EOKypOj1IlW3aR8q4dX7RehrdFwakM5Ru6WNo9t+DmuCt1tLh43GV0LLHdmX1u2HmCExrBgDNt+Yklq4fFqPPXhfUgRKfqsc9pYN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948430; c=relaxed/simple;
	bh=zLoxhO1/k4AtBY/I4JrebYuKqycpixTXGsVOVS4/gBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dWalReB3mZQ+jOp6i5F0lIwx/bYnXlZc8A4uPTQ4yB5pwmXPrnI0DuO++1gsarBWmynWM7vtIGqnB1LHTmnPdhBSBJiDxmgx3CYEXWts5D0/JX4J0lOZUh6OKKIGuzIADDCAkm2K4ozlXRmnYydT12H8hWrOjTP3FKf40BOxIq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L+07vhj+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MIKinF021689;
	Mon, 22 Jan 2024 18:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GB0o6GF3v4B74TnutKUaWjeNsUhfFJCRGR/moEVEhGo=; b=L+
	07vhj+ZaFp15Lvd6vMBhHyFT0cimsOo/0tGss+AP3uUqoQts6piJfD40ntpsnoDj
	GeXti1v72FyNv+9agmlsQwRU9PMoCnk3awGdDhz83ehdFi0/2V8lr7ar/xVwkUmk
	plHVK748pw5se2Y3f0LNVz4Lao5UIm+gW41Ybvq6J0hfeLKubhVm8fCyNh2v6avE
	+ePmvbFzyIGlgVQLJ7pnDmSuecRxQn2VzdLPjFZGB5AXm9m492FedSGshkXmganw
	xm5t9d+WmiONuA/fR5SX9soamDDH74ToHgSAOn5ji8Tnx5beg63dbX/h44IK0SDU
	FWsZEwHG9TilO778qEOQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vst8w8jud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 18:33:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MIXUs1014880
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 18:33:30 GMT
Received: from [10.110.26.199] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 10:33:29 -0800
Message-ID: <d80ae6ae-e1f2-48ef-b18a-29b5ca62e64c@quicinc.com>
Date: Mon, 22 Jan 2024 10:33:28 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless v2] nl80211/cfg80211: add nla_policy for S1G band
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, Lin Ma <linma@zju.edu.cn>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kvalo@kernel.org>
References: <20240119151201.8670-1-linma@zju.edu.cn>
 <9e1db7f3-fd18-4b3b-a912-3cf6efd96fed@quicinc.com>
 <590fe2823d934af997c515640733eb8889b0560f.camel@sipsolutions.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <590fe2823d934af997c515640733eb8889b0560f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Yae4dbBKdj0cZ4XrGHH4egyT1fEyNCYT
X-Proofpoint-ORIG-GUID: Yae4dbBKdj0cZ4XrGHH4egyT1fEyNCYT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_07,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220130

On 1/20/2024 12:27 PM, Johannes Berg wrote:
> On Fri, 2024-01-19 at 15:47 -0800, Jeff Johnson wrote:
>>> --- a/net/wireless/nl80211.c
>>> +++ b/net/wireless/nl80211.c
>>> @@ -911,6 +911,7 @@ nl80211_match_band_rssi_policy[NUM_NL80211_BANDS] = {
>>>  	[NL80211_BAND_5GHZ] = { .type = NLA_S32 },
>>>  	[NL80211_BAND_6GHZ] = { .type = NLA_S32 },
>>>  	[NL80211_BAND_60GHZ] = { .type = NLA_S32 },
>>> +	[NL80211_BAND_S1GHZ] = { .type = NLA_S32 },
>>>  	[NL80211_BAND_LC]    = { .type = NLA_S32 },
>>>  };
>>>  
>> something is really suspicious since the NL80211_BAND_* enums are
>> *value* enums, not attribute ID enums, and hence they should never be
>> used in an nla_policy.
> 
> Yeah, that's what it looks like first, but then they do get used
> anyway...
> 
>> what is actually using these as attribute IDs, noting that
>> NL80211_BAND_2GHZ == 0 and hence cannot be used as an attribute ID
> 
> Ohh. Good catch!
> 
>> seems the logic that introduced this policy needs to be revisited.
>>
> 
> Let's just remove it?
> 
> commit 1e1b11b6a1111cd9e8af1fd6ccda270a9fa3eacf
> Author: vamsi krishna <vamsin@codeaurora.org>
> Date:   Fri Feb 1 18:34:51 2019 +0530
> 
>     nl80211/cfg80211: Specify band specific min RSSI thresholds with sched scan
> 
> 
> As far as I can tell nothing is using that in the first place ...
> Certainly not in the kernel, nor wpa_s, nor anything else I could find
> really ...
> 
> We can't completely revert it since we need the attribute number to stay
> allocated, but that's all we cannot remove.

I'm investigating this and will report back.


