Return-Path: <linux-kernel+bounces-39131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE6083CB37
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71BE51F22C10
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C2F77F02;
	Thu, 25 Jan 2024 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j3Za+b+q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CAE8472;
	Thu, 25 Jan 2024 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207590; cv=none; b=fXsroKz+GO8iQwclJDIszhf4NaHsJdnNXfmZ9edhgijPU99iwM3MUucX39pKQ/eCtvCEZYqljkZK++12jRYSwtbZpuQhCuaBAQhcyn9i3/h04lkmD3k6poJ301DeTdhmz6/9c7ia70Diuab8t7eGU9XsXPfz3d9KFzBa+mr4HkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207590; c=relaxed/simple;
	bh=X9g2XA4NppT+YGuEazcfPB3e27C9le9+RqHSEyar0lo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=YeC+c9wP8jjhQ/XDfTrOgMdGh9i2Jz70H5Qk73YxC/kwZ7QUnY/K3N9y/Iq3ZVgwoQlntuDPBU/QVFgVCri2BfV1K47Q0BFTjvtIZVjHdqbYIhoyW/1rApJuJmCyUQIwmv6LffniRxsQZFSAoskd1Vh5pRaCa/r6H26ZOext/ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j3Za+b+q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PHDXfO023662;
	Thu, 25 Jan 2024 18:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=rtduzouzzoSoD527t39zRPaWPzfaEpx6N6wuAqAgPs8=; b=j3
	Za+b+q8t4456lifVUBASJdEz3iCCtBR8P5ySUzru52NhLQgIFR/zOL9MXJXNAwX3
	o+hOUapPxlliV82lrh3J55o6fTzxIZ7hJ+bdbI+F7cXjuX/M8y4AlSP3lPi39698
	HaGI/+UnZJM4HEI7YcUyXLYSWTn3lfhCik3209GgKlPGcuqLRpeXYkxVAxvrr5aD
	tuYCOspsj6jMJrfJ5ZIBdDUS5T93RGVXaVKu9sLuc2scNnvoRXqZJ8FzTli0WWCh
	OhMvAySAOQvgzv9ZzmoRUBDb8COWI1S+g/epRyagkW03Cm1i18LdMpxPJFYd1bcC
	QQF2W80F82Cn0ZhAUqZA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vuqra0wfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 18:32:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PIWsCq006259
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 18:32:54 GMT
Received: from [10.110.0.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 10:32:53 -0800
Message-ID: <d49f69f4-7f5c-498f-bb17-a636256d3245@quicinc.com>
Date: Thu, 25 Jan 2024 10:32:53 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless v2] nl80211/cfg80211: add nla_policy for S1G band
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>, Lin Ma <linma@zju.edu.cn>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kvalo@kernel.org>
References: <20240119151201.8670-1-linma@zju.edu.cn>
 <9e1db7f3-fd18-4b3b-a912-3cf6efd96fed@quicinc.com>
 <590fe2823d934af997c515640733eb8889b0560f.camel@sipsolutions.net>
 <d80ae6ae-e1f2-48ef-b18a-29b5ca62e64c@quicinc.com>
In-Reply-To: <d80ae6ae-e1f2-48ef-b18a-29b5ca62e64c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IyX4pDl-EWRg6uBFMjQ3k44OVVGgWude
X-Proofpoint-ORIG-GUID: IyX4pDl-EWRg6uBFMjQ3k44OVVGgWude
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_11,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250133

On 1/22/2024 10:33 AM, Jeff Johnson wrote:
> On 1/20/2024 12:27 PM, Johannes Berg wrote:
>> On Fri, 2024-01-19 at 15:47 -0800, Jeff Johnson wrote:
>>>> --- a/net/wireless/nl80211.c
>>>> +++ b/net/wireless/nl80211.c
>>>> @@ -911,6 +911,7 @@ nl80211_match_band_rssi_policy[NUM_NL80211_BANDS] = {
>>>>  	[NL80211_BAND_5GHZ] = { .type = NLA_S32 },
>>>>  	[NL80211_BAND_6GHZ] = { .type = NLA_S32 },
>>>>  	[NL80211_BAND_60GHZ] = { .type = NLA_S32 },
>>>> +	[NL80211_BAND_S1GHZ] = { .type = NLA_S32 },
>>>>  	[NL80211_BAND_LC]    = { .type = NLA_S32 },
>>>>  };
>>>>  
>>> something is really suspicious since the NL80211_BAND_* enums are
>>> *value* enums, not attribute ID enums, and hence they should never be
>>> used in an nla_policy.
>>
>> Yeah, that's what it looks like first, but then they do get used
>> anyway...
>>
>>> what is actually using these as attribute IDs, noting that
>>> NL80211_BAND_2GHZ == 0 and hence cannot be used as an attribute ID
>>
>> Ohh. Good catch!
>>
>>> seems the logic that introduced this policy needs to be revisited.
>>>
>>
>> Let's just remove it?
>>
>> commit 1e1b11b6a1111cd9e8af1fd6ccda270a9fa3eacf
>> Author: vamsi krishna <vamsin@codeaurora.org>
>> Date:   Fri Feb 1 18:34:51 2019 +0530
>>
>>     nl80211/cfg80211: Specify band specific min RSSI thresholds with sched scan
>>
>>
>> As far as I can tell nothing is using that in the first place ...
>> Certainly not in the kernel, nor wpa_s, nor anything else I could find
>> really ...
>>
>> We can't completely revert it since we need the attribute number to stay
>> allocated, but that's all we cannot remove.
> 
> I'm investigating this and will report back.

OK, I have investigated this and based upon the investigation this can
be removed (except for keeping the now obsolete uapi bits). This was
done in preparation for supporting a new Android interface in the
out-of-tree Android driver, but that interface was subsequently
withdrawn by Google.

Johannes, do you want to handle this? Or should I?

/jeff




