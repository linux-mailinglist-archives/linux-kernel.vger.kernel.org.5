Return-Path: <linux-kernel+bounces-102531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD6D87B370
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CD9286E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FE554756;
	Wed, 13 Mar 2024 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NpIntYJk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1D42570;
	Wed, 13 Mar 2024 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710365246; cv=none; b=DpQ6WqLJ0j8zLPLELt2iQ/97hfyr6ixTJtUBrDC2rRuV7V4CmKtKT+kyPprN2Ed79azLyuA9Qx/reR+JaELTvuytNFclggaEFzD9qgJFGvLUxOq7lAUaXh5p+s8c+tdz+Gnzl5sVUGVlBbqHkKZNSHxMqQmP50J+FmFq3VgIHg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710365246; c=relaxed/simple;
	bh=ot3esw+CZKcE015U6qnW5vlDC5VqYsQQQxSQ7NPbAa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sV6SeOlx4GGtDVjbtHusaK/BuR+icd02mID44I3kwSdTeOjSCgf4nXj7/7guiBS1wJgg3EVodO8UdM5RaSsQ+rgrAdfMwZ/rVWPE+b1cFNxVpiD8mF6BjNLQOnsCKPjrOWgZs7MEZEr+kKA+qR7hs45b0N9KH7UnnvCbgWZPIPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NpIntYJk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42DJb6lT012871;
	Wed, 13 Mar 2024 21:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1WXjF9gdw1yBrj1ie58W7up2JiG+1awEeF+/x8odAQM=; b=Np
	IntYJkR8t6v7CDUN9yR4EhBnERAKNCzOCg0gHTThkDpt5oyJ9AgGjBSY3OiUuzAD
	URqGeknaeorP1k2MYzAIdTRN6AV8eOqvw60tMSWS3bh3tcQ9Gu+ElmDahPDgd0v0
	J0WLYOZAAOLwVl4KhamHDl/Kexvfhz0Ha527YMYyeq5cnYD7UDwMj1v/Vfk/6m+8
	RM4wRE6s5qe5h10TBtmXPb1st3r5Pe3bXOhz7WGphASW3JuWlop9jKcUClfPQn1j
	iVRQ1anZDNCXNRu9GCqmg9JQs5mv5FeJc1clKvz8lMNbyuW9z4qud52LvhB/N/sH
	z3txB4lMvvyNYukj0E9A==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuam5hf29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 21:27:03 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42DLR2Nr023199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 21:27:02 GMT
Received: from [10.110.34.216] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Mar
 2024 14:26:58 -0700
Message-ID: <e5da91bc-5827-4347-ab38-36c92ae2dfa2@quicinc.com>
Date: Wed, 13 Mar 2024 14:26:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net: Re-use and set mono_delivery_time bit
 for userspace tstamp packets
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>,
        Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
CC: <kernel@quicinc.com>, "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        "Martin
 KaFai Lau" <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii
 Nakryiko <andrii@kernel.org>
References: <20240301201348.2815102-1-quic_abchauha@quicinc.com>
 <2a4cb416-5d95-459d-8c1c-3fb225240363@linux.dev>
 <65f16946cd33e_344ff1294fc@willemb.c.googlers.com.notmuch>
 <28282905-065a-4233-a0a2-53aa9b85f381@linux.dev>
 <65f2004e65802_3d1e792943e@willemb.c.googlers.com.notmuch>
 <0dff8f05-e18d-47c8-9f19-351c44ea8624@linux.dev>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <0dff8f05-e18d-47c8-9f19-351c44ea8624@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hGO3LT33jvoGvEpPwVTnmRx2zl7WJ7gW
X-Proofpoint-ORIG-GUID: hGO3LT33jvoGvEpPwVTnmRx2zl7WJ7gW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130164



On 3/13/2024 2:01 PM, Martin KaFai Lau wrote:
> On 3/13/24 12:36 PM, Willem de Bruijn wrote:
>> Martin KaFai Lau wrote:
>>> On 3/13/24 1:52 AM, Willem de Bruijn wrote:
>>>> Martin KaFai Lau wrote:
>>>>> On 3/1/24 12:13 PM, Abhishek Chauhan wrote:
>>>>>> Bridge driver today has no support to forward the userspace timestamp
>>>>>> packets and ends up resetting the timestamp. ETF qdisc checks the
>>>>>> packet coming from userspace and encounters to be 0 thereby dropping
>>>>>> time sensitive packets. These changes will allow userspace timestamps
>>>>>> packets to be forwarded from the bridge to NIC drivers.
>>>>>>
>>>>>> Setting the same bit (mono_delivery_time) to avoid dropping of
>>>>>> userspace tstamp packets in the forwarding path.
>>>>>>
>>>>>> Existing functionality of mono_delivery_time remains unaltered here,
>>>>>> instead just extended with userspace tstamp support for bridge
>>>>>> forwarding path.
>>>>>
>>>>> The patch currently broke the bpf selftest test_tc_dtime:
>>>>> https://github.com/kernel-patches/bpf/actions/runs/8242487344/job/22541746675
>>>>>
>>>>> In particular, there is a uapi field __sk_buff->tstamp_type which currently has
>>>>> BPF_SKB_TSTAMP_DELIVERY_MONO to mean skb->tstamp has the MONO "delivery" time.
>>>>> BPF_SKB_TSTAMP_UNSPEC means everything else (this could be a rx timestamp at
>>>>> ingress or a delivery time set by user space).
>>>>>
>>>>> __sk_buff->tstamp_type depends on skb->mono_delivery_time which does not
>>>>> necessarily mean mono after this patch. I thought about fixing it on the bpf
>>>>> side such that reading __sk_buff->tstamp_type only returns
>>>>> BPF_SKB_TSTAMP_DELIVERY_MONO when the skb->mono_delivery_time is set and skb->sk
>>>>> is IPPROTO_TCP. However, it won't work because of bpf_skb_set_tstamp().
>>>>>
>>>>> There is a bpf helper, bpf_skb_set_tstamp(skb, tstamp,
>>>>> BPF_SKB_TSTAMP_DELIVERY_MONO). This helper changes both the skb->tstamp and the
>>>>> skb->mono_delivery_time. The expectation is this could change skb->tstamp in the
>>>>> ingress skb and redirect to egress sch_fq. It could also set a mono time to
>>>>> skb->tstamp where the udp sk->sk_clockid may not be necessary in mono and then
>>>>> bpf_redirect to egress sch_fq. When bpf_skb_set_tstamp(skb, tstamp,
>>>>> BPF_SKB_TSTAMP_DELIVERY_MONO) succeeds, reading __sk_buff->tstamp_type expects
>>>>> BPF_SKB_TSTAMP_DELIVERY_MONO also.
>>>>>
>>>>> I ran out of idea to solve this uapi breakage.
>>>>>
>>>>> I am afraid it may need to go back to v1 idea and use another bit
>>>>> (user_delivery_time) in the skb.
>>>>
>>>> Is the only conflict when bpf_skb_set_tstamp is called for an skb from
>>>> a socket with sk_clockid set (and thus SO_TXTIME called)?
>>>
>>> Right, because skb->mono_delivery_time does not mean skb->tstamp is mono now and
>>> its interpretation depends on skb->sk->sk_clockid.
>>>
>>>> Interpreting skb->tstamp as mono if skb->mono_delivery_time is set and
>>>> skb->sk is NULL is fine. This is the ingress to egress redirect case.
>>>
>>> skb->sk == NULL is fine. I tried something like this in
>>> bpf_convert_tstamp_type_read() for reading __sk_buff->tstamp_type:
>>>
>>> __sk_buff->tstamp_type is BPF_SKB_TSTAMP_DELIVERY_MONO when:
>>>
>>>     skb->mono_delivery_time == 1 &&
>>>     (!skb->sk ||
>>>      !sk_fullsock(skb->sk) /* tcp tw or req sk */ ||
>>>      skb->sk->sk_protocol == IPPROTO_TCP)
>>>
>>> Not a small bpf instruction addition to bpf_convert_tstamp_type_read() but doable.
>>>
>>>>
>>>> I don't see an immediate use for this BPF function on egress where it
>>>> would overwrite an SO_TXTIME timestamp and now skb->tstamp is mono,
>>>> but skb->sk != NULL and skb->sk->sk_clockid != CLOCK_MONOTONIC.
>>>
>>> The bpf prog may act as a traffic shaper that limits the bandwidth usage of all
>>> outgoing packets (tcp/udp/...) by setting the mono EDT in skb->tstamp before
>>> sending to the sch_fq.
>>>
>>> I currently also don't have a use case for skb->sk->sk_clockid !=
>>> CLOCK_MONOTONIC. However, it is something that bpf_skb_set_tstamp() can do now
>>> before queuing to sch_fq.
>>>
>>> The container (in netns + veth) may use other sk_clockid/qdisc (e.g. sch_etf)
>>> setup and the non mono skb->tstamp is not cleared now during dev_forward_skb()
>>> between the veth pair.
>>>
>>>>
>>>> Perhaps bpf_skb_set_tstamp() can just fail if another delivery time is
>>>> already explicitly programmed?
>>>
>>> This will change the existing bpf_skb_set_tstamp() behavior, so probably not
>>> acceptable.
>>>
>>>>
>>>>       skb->sk &&
>>>>       sock_flag(sk, SOCK_TXTIME) &&
>>>>       skb->sk->sk_clockid != CLOCK_MONOTONIC
>>>
>>>> Either that, or unset SOCK_TXTIME to make sk_clockid undefined and
>>>> fall back on interpreting as monotonic.
>>>
>>> Change sk->sk_flags in tc bpf prog? hmm... I am not sure this will work well also.
>>>
>>> sock_valbool_flag(SOCK_TXTIME) should require a lock_sock() to make changes. The
>>> tc bpf prog cannot take the lock_sock, so bpf_skb_set_tstamp() currently only
>>> changes skb and does not change skb->sk.
>>>
>>> I think changing sock_valbool_flag(SOCK_TXTIME) will also have a new user space
>>> visible side effect. The sendmsg for cmsg with SCM_TXTIME will start failing
>>> from looking at __sock_cmsg_send().
>>>
>>> There may be a short period of disconnect between what is in sk->sk_flags and
>>> what is set in skb->tstamp. e.g. what if user space does setsockopt(SO_TXTIME)
>>> again after skb->tstamp is set by bpf. This could be considered a small glitch
>>> for some amount of skb(s) until the user space settled on setsockopt(SO_TXTIME).
>>>
>>> I think all this is crying for another bit in skb to mean user_delivery_time
>>> (skb->tstamp depends on skb->sk->sk_clockid) while mono_delivery_time is the
>>> mono time either set by kernel-tcp or bpf.
>>
>> It does sound like the approach with least side effects.
>>
>> If we're going to increase to two bits per skb, it's perhaps
>> better to just encode the (selected supported) CLOCK_ type, rather
>> than only supporting clockid through skb->sk->sk_clockid.
> 
> Good idea. May be starting with mono and tai (Abishek's use case?), only forward these two clocks and reset the skb->tstamp for others.
> 
>>
>> This BPF function is the analogue to SO_TXTIME. It is clearly
>> extensible to additional BPF_SKB_TSTAMP_DELIVERY_.. types. To
>> work with sch_etf, say.
> 
> Yes, if there are bits in skb to describe the clock in the skb->tstamp, BPF_SKB_TSTAMP_DELIVERY_ can be extended to match it. It will be easier if the values in the skb bits is the same as the BPF_SKB_TSTAMP_DELIVERY_*.
> 
> The bpf_convert_tstamp_*() and the bpf_skb_set_tstamp helper will need changes to include the consideration of these two bits. I think we have mostly settled with the approach (thanks for the discussion!). Abhishek, not sure how much can be reused from this patch for the two bits apporach, do you want to revert the current patch first and then start from clean?
> 
Yes , I think since we have concluded the two bit .(Thanks for discussion again, Martin and Willem)

Here is what i will do from myside
1. Revert the v4 patch :-  net: Re-use and set mono_delivery_time bit for userspace tstamp packets 
2. Keep mono_delivery_time as ease 
3. Add user_delivery_time as a new bitfield 
4. Add BPF_SKB_TSTAMP_DELIVERY_TAI in the bpf.h for etf support
5. do not reset the time if either mono_delivery_time or user_delivery_time is set. 

Let me know if i have covered all the design details or add if i missed anything. 

>>
>>> If we need to revert the
>>> mono_delivery_time reuse patch later, we will need to revert the netdev patch
>>> and the (to-be-made) bpf patch.
>>
>>
>>  
>>
> 

