Return-Path: <linux-kernel+bounces-85875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC1586BC93
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EAAC1C2135D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49CF4C63;
	Thu, 29 Feb 2024 00:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ey8AOCwF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4D87472;
	Thu, 29 Feb 2024 00:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165636; cv=none; b=ANs1eFBMo9596b5SpFkb5pZsffZM+5aLBP0b2zeIvs8ANLlu3ImjFT7qYoJ58hM7gadomN+Hc7D4Wv14XM0XxoILRgPD1nfY6BBMfHeiVrSccseCU5eJf+vAy+UvQ5RpVfHuR21SyZ/qn4ha5EMtNs7bhdmT51sB8CLgMeIYXu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165636; c=relaxed/simple;
	bh=vz861hPxpNYZFTTUORtcsl551DegJCUBY8gClBSCovI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BGl2j6Z8IymCU2p+EdCi2WbLPM/OYSz8QA3uR2z639cXQsOhdc5ZxoA7XZ+iWqJykVh1QDOEDr1xdbN5jmx+LGNLH3H/fpnNJBGm9sUIYdZN7u54TI2A8dfztboPeS8jm90oKWQUjjHQ8zqtegz6CyD/tWZhgmsuUYNU4NXvrI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ey8AOCwF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SMvdOd004650;
	Thu, 29 Feb 2024 00:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VhI+OggJ54GzEZCiIO6hCM/IzyW+IEc+74E31fOEAdk=; b=ey
	8AOCwFxCm/LHKm4DQrgV1HIrattxWUBkWt/9XzY+KQth9WguqrJd+p6W97cNfzro
	Nj7TZTM+7M7Qk5VxbnnK4dQcSIB6ZXXte8+6vg62s6vS7+OmkO3jjQ83Wx0THRNY
	VFsFsZngoYa9+6aDKFMMDW93r0ueBtlcHDaT4pb3ALqDXGbne6tOx0t/bfd3GOJX
	6n6stZhdCV1gIhJ/lmNPgmEQNsZlkvTJx6hmeTo6LoS9zyJKqTG2I/PY9WY0pt2k
	Hwv/PoR9ATDOL8ocEiR4UBRDwpjl0nNWYlyZso/q8VZ0sL3RKGm4QkkcXw7tUAmF
	1LJGVAQHoOpwGsaanJtw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wj5wc9fee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 00:13:44 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41T0Dh5b003324
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 00:13:43 GMT
Received: from [10.110.100.241] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 16:13:40 -0800
Message-ID: <7b4c84ce-6cb1-4791-8821-fd0022238e48@quicinc.com>
Date: Wed, 28 Feb 2024 16:13:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: Modify mono_delivery_time with
 clockid_delivery_time
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
        "Martin
 KaFai Lau" <martin.lau@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>
CC: <kernel@quicinc.com>
References: <20240228011219.1119105-1-quic_abchauha@quicinc.com>
 <65df56f6ba002_7162829435@willemb.c.googlers.com.notmuch>
 <f38efc6d-20af-4cc1-9b8a-5fcb676b2845@quicinc.com>
 <65df94185a2c1_b2ad829442@willemb.c.googlers.com.notmuch>
 <8a5d15aa-96e2-4d9c-9479-bf2ba8fb2a79@quicinc.com>
 <65dfcb37844e0_ba1f8294b7@willemb.c.googlers.com.notmuch>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <65dfcb37844e0_ba1f8294b7@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: B72xc6Hx5Q_ZQW1AHoc6gGwT_HxKOWqA
X-Proofpoint-ORIG-GUID: B72xc6Hx5Q_ZQW1AHoc6gGwT_HxKOWqA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=743 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280190



On 2/28/2024 4:09 PM, Willem de Bruijn wrote:
> Abhishek Chauhan (ABC) wrote:
>>
>>
>> On 2/28/2024 12:14 PM, Willem de Bruijn wrote:
>>> Abhishek Chauhan (ABC) wrote:
>>>>
>>>>
>>>> On 2/28/2024 7:53 AM, Willem de Bruijn wrote:
>>>>> Abhishek Chauhan wrote:
>>>>>> Bridge driver today has no support to forward the userspace timestamp
>>>>>> packets and ends up resetting the timestamp. ETF qdisc checks the
>>>>>> packet coming from userspace and encounters to be 0 thereby dropping
>>>>>> time sensitive packets. These changes will allow userspace timestamps
>>>>>> packets to be forwarded from the bridge to NIC drivers.
>>>>>>
>>>>>> Existing functionality of mono_delivery_time is not altered here
>>>>>> instead just extended with userspace tstamp support for bridge
>>>>>> forwarding path.
>>>>>>
>>>>>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>>>>>> ---
>>>>>> Changes since v1 
>>>>>> - Changed the commit subject as i am modifying the mono_delivery_time 
>>>>>>   bit with clockid_delivery_time.
>>>>>> - Took care of suggestion mentioned by Willem to use the same bit for 
>>>>>>   userspace delivery time as there are no conflicts between TCP and 
>>>>>>   SCM_TXTIME, because explicit cmsg makes no sense for TCP and only
>>>>>>   RAW and DGRAM sockets interprets it.
>>>>>
>>>>> The variable rename churn makes it hard to spot the functional
>>>>> changes. Perhaps it makes sense just keep the variable name as is,
>>>>> even though the "mono" is not always technically correct anymore.
>>>>>
>>>>   
>>>>
>>>> I think a better approach would be to keep the variable as ease and add
>>>> comments and documentation in the header file of skbuff.h like 
>>>> how i have done in this patch. The reason why i say this is
>>>> a. We can avoid alot of code churn just to solve this basic problem of 
>>>> propagating timestamp through forwarding bridge path 
>>>> b. Re-use the same variable name and have better documentation 
>>>> c. Complexity will be as minimal as possible.
>>>>
>>>> Let me know what you think. 
>>>
>>> Agreed
>>>
>>
>> Okay i will make the changes accordingly. 
>>>>> Or else to split into two patches. One that renames the field.
>>>>> And one that adds the new behavior of setting the bit for SO_TXTIME.
>>>>>
>>>>
>>>> Regarding the sidenote. I dont see how they are using clock_id to determine 
>>>> if the skb->tstamp is set in monotonic. Please correct me or point me to 
>>>> the piece of code which is doing so.
>>>
>>> That's really out of scope of this series anyway
>>>
>>
>> Sounds good. Really appreciate your review and discussion on this topic. 
>>  
>>>>
>>>> I hope the check against sock_flag is a better implementation as 
>>>> it clearly stats and is inline with the implementation that the tstamp is 
>>>> coming from userspace. 
>>>> skb->mono_delivery_time = sock_flag(sk, SOCK_TXTIME);
>>>
>>> Enabling the socket flag is not sufficient to configure a delivery
>>> time on a packet. A transmit time must be communicated per packet
>>> with cork->transmit_time. And on top of that, it is cheaper to test.
>>
>>
>> So to re-use the same bit of mono_delivery_time. I want to set this bit 
>> when user-space sets the timestamps using SCM_TXTIME. 
>> Is it okay if i do the below when we make skb in ipv4/ipv6 and raw packets
>> to ensure that bridge doesn't reset the packet tstamp or do you have a better 
>> suggestion to set the bit so br_forward_finish does not reset the timestamp. 
>>
>> skb->mono_delivery_time = sock_flag(sk, SOCK_TXTIME);
> 
> I already gave my suggestion.
> 
> The timestamp is passed using sockcm_cookie field transmit_time, which
> is set from a control message of type SCM_TXTIME passed to sendmsg.
> 
> Right above where you wanted to add this check is where skb->tstamp is
> initialized from cork->transmit_time, which got it from this field. So
> clearly that is the indication that a transmit time is set. And the
> field is hot in the cache.

Oh i see what you are saying. I got it . I will make the changes accordingly. 
Let me post patch set v3 after testing it internally. 
Thanks again for all the review comments.


