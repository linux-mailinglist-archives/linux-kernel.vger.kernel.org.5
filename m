Return-Path: <linux-kernel+bounces-102515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9287987B323
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D2C288675
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6216D53390;
	Wed, 13 Mar 2024 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gK780mYb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC9D51C49;
	Wed, 13 Mar 2024 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710363590; cv=none; b=fLUAJp/qcB2XkkJsgXVHiQDFKSX/CZrohpvUoIxYquyS8rtpUK/kVLRfVtgv2ajmVkAcosIfzktO0k/OMu0STusKJdwhjPt5NVFGJf4EVYF/zSSWUZw8+7E+elpsYC1vMXZKEE8OEhovtfPIqiV2/l/aKBPLcqNsJxQFAk0XbyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710363590; c=relaxed/simple;
	bh=IpBbQz1srVKY5Qm8aYytCrr8UprLvXNWXUTAleoCung=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A+FnrIbBeNxaPW1GGZZDVslZEGAfY/rFdikVlNMghw5HitRbOwCpQ0+6zLZ1jKC1twjv8FDsbrdUrn0OugJXwcvl0XKRSfXwiLaKpbF0j1PKfZ0Y2jbQt9VnvngFeRvxkP1vOE/xifhrEN4FJzJE9m9iZjP339rK8GMGaE5xElQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gK780mYb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42DKZsLh015392;
	Wed, 13 Mar 2024 20:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XV00hGXPiXdSW+Tmcv9hjeCk26huAFHGiu8ghIiwE8I=; b=gK
	780mYbJRLaDctPqpw8vzG/i5ek39sPDQcn/mMgAmWXR6WccdkZSxws/StKCHg1XW
	e+9BNyjWYbOptg87WiaisLQBjxgn0Xuc1tz+WWF8nrI3ZPfbFM8J8EsB36h7dWLr
	4U0PvWHihh+i6J6SbRCVq1PzZaARrh1Tb3/w7veW3I/zCoM5pQ+ablfZdEx6fBqC
	/miLUsnRqODeN8ZmIRvBBd7zFGw/Y2LCIR4NqypqL6yAIYi6Rv0pyZKCkteBPGrW
	amCu4eWaujA5tIwFnyrblOcTHofPowvSFg+7bnjSD1o116yZquz9ewLysCi25hdf
	OQrnd3LJOymeu0lQUmoQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuapehecq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 20:59:10 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42DKx9de028556
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 20:59:09 GMT
Received: from [10.110.34.216] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Mar
 2024 13:59:05 -0700
Message-ID: <02363fef-0b5e-4b6c-bad9-db924db230b9@quicinc.com>
Date: Wed, 13 Mar 2024 13:59:04 -0700
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
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Martin KaFai Lau
	<martin.lau@linux.dev>
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
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <65f2004e65802_3d1e792943e@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cagLZueLiRGKU9NIYl2gUFsOZ91zeEXO
X-Proofpoint-GUID: cagLZueLiRGKU9NIYl2gUFsOZ91zeEXO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130161



On 3/13/2024 12:36 PM, Willem de Bruijn wrote:
> Martin KaFai Lau wrote:
>> On 3/13/24 1:52 AM, Willem de Bruijn wrote:
>>> Martin KaFai Lau wrote:
>>>> On 3/1/24 12:13 PM, Abhishek Chauhan wrote:
>>>>> Bridge driver today has no support to forward the userspace timestamp
>>>>> packets and ends up resetting the timestamp. ETF qdisc checks the
>>>>> packet coming from userspace and encounters to be 0 thereby dropping
>>>>> time sensitive packets. These changes will allow userspace timestamps
>>>>> packets to be forwarded from the bridge to NIC drivers.
>>>>>
>>>>> Setting the same bit (mono_delivery_time) to avoid dropping of
>>>>> userspace tstamp packets in the forwarding path.
>>>>>
>>>>> Existing functionality of mono_delivery_time remains unaltered here,
>>>>> instead just extended with userspace tstamp support for bridge
>>>>> forwarding path.
>>>>
>>>> The patch currently broke the bpf selftest test_tc_dtime:
>>>> https://github.com/kernel-patches/bpf/actions/runs/8242487344/job/22541746675
>>>>
>>>> In particular, there is a uapi field __sk_buff->tstamp_type which currently has
>>>> BPF_SKB_TSTAMP_DELIVERY_MONO to mean skb->tstamp has the MONO "delivery" time.
>>>> BPF_SKB_TSTAMP_UNSPEC means everything else (this could be a rx timestamp at
>>>> ingress or a delivery time set by user space).
>>>>
>>>> __sk_buff->tstamp_type depends on skb->mono_delivery_time which does not
>>>> necessarily mean mono after this patch. I thought about fixing it on the bpf
>>>> side such that reading __sk_buff->tstamp_type only returns
>>>> BPF_SKB_TSTAMP_DELIVERY_MONO when the skb->mono_delivery_time is set and skb->sk
>>>> is IPPROTO_TCP. However, it won't work because of bpf_skb_set_tstamp().
>>>>
>>>> There is a bpf helper, bpf_skb_set_tstamp(skb, tstamp,
>>>> BPF_SKB_TSTAMP_DELIVERY_MONO). This helper changes both the skb->tstamp and the
>>>> skb->mono_delivery_time. The expectation is this could change skb->tstamp in the
>>>> ingress skb and redirect to egress sch_fq. It could also set a mono time to
>>>> skb->tstamp where the udp sk->sk_clockid may not be necessary in mono and then
>>>> bpf_redirect to egress sch_fq. When bpf_skb_set_tstamp(skb, tstamp,
>>>> BPF_SKB_TSTAMP_DELIVERY_MONO) succeeds, reading __sk_buff->tstamp_type expects
>>>> BPF_SKB_TSTAMP_DELIVERY_MONO also.
>>>>
>>>> I ran out of idea to solve this uapi breakage.
>>>>
>>>> I am afraid it may need to go back to v1 idea and use another bit
>>>> (user_delivery_time) in the skb.
>>>
>>> Is the only conflict when bpf_skb_set_tstamp is called for an skb from
>>> a socket with sk_clockid set (and thus SO_TXTIME called)?
>>
>> Right, because skb->mono_delivery_time does not mean skb->tstamp is mono now and 
>> its interpretation depends on skb->sk->sk_clockid.
>>
>>> Interpreting skb->tstamp as mono if skb->mono_delivery_time is set and
>>> skb->sk is NULL is fine. This is the ingress to egress redirect case.
>>
>> skb->sk == NULL is fine. I tried something like this in 
>> bpf_convert_tstamp_type_read() for reading __sk_buff->tstamp_type:
>>
>> __sk_buff->tstamp_type is BPF_SKB_TSTAMP_DELIVERY_MONO when:
>>
>> 	skb->mono_delivery_time == 1 &&
>> 	(!skb->sk ||
>> 	 !sk_fullsock(skb->sk) /* tcp tw or req sk */ ||
>> 	 skb->sk->sk_protocol == IPPROTO_TCP)
>>
>> Not a small bpf instruction addition to bpf_convert_tstamp_type_read() but doable.
>>
>>>
>>> I don't see an immediate use for this BPF function on egress where it
>>> would overwrite an SO_TXTIME timestamp and now skb->tstamp is mono,
>>> but skb->sk != NULL and skb->sk->sk_clockid != CLOCK_MONOTONIC.
>>
>> The bpf prog may act as a traffic shaper that limits the bandwidth usage of all 
>> outgoing packets (tcp/udp/...) by setting the mono EDT in skb->tstamp before 
>> sending to the sch_fq.
>>
>> I currently also don't have a use case for skb->sk->sk_clockid != 
>> CLOCK_MONOTONIC. However, it is something that bpf_skb_set_tstamp() can do now 
>> before queuing to sch_fq.
>>
>> The container (in netns + veth) may use other sk_clockid/qdisc (e.g. sch_etf) 
>> setup and the non mono skb->tstamp is not cleared now during dev_forward_skb() 
>> between the veth pair.
>>
>>>
>>> Perhaps bpf_skb_set_tstamp() can just fail if another delivery time is
>>> already explicitly programmed?
>>
>> This will change the existing bpf_skb_set_tstamp() behavior, so probably not 
>> acceptable.
>>
>>>
>>>      skb->sk &&
>>>      sock_flag(sk, SOCK_TXTIME) &&
>>>      skb->sk->sk_clockid != CLOCK_MONOTONIC
>>
>>> Either that, or unset SOCK_TXTIME to make sk_clockid undefined and
>>> fall back on interpreting as monotonic.
>>
>> Change sk->sk_flags in tc bpf prog? hmm... I am not sure this will work well also.
>>
>> sock_valbool_flag(SOCK_TXTIME) should require a lock_sock() to make changes. The 
>> tc bpf prog cannot take the lock_sock, so bpf_skb_set_tstamp() currently only 
>> changes skb and does not change skb->sk.
>>
>> I think changing sock_valbool_flag(SOCK_TXTIME) will also have a new user space 
>> visible side effect. The sendmsg for cmsg with SCM_TXTIME will start failing 
>> from looking at __sock_cmsg_send().
>>
>> There may be a short period of disconnect between what is in sk->sk_flags and 
>> what is set in skb->tstamp. e.g. what if user space does setsockopt(SO_TXTIME) 
>> again after skb->tstamp is set by bpf. This could be considered a small glitch 
>> for some amount of skb(s) until the user space settled on setsockopt(SO_TXTIME).
>>
>> I think all this is crying for another bit in skb to mean user_delivery_time 
>> (skb->tstamp depends on skb->sk->sk_clockid) while mono_delivery_time is the 
>> mono time either set by kernel-tcp or bpf.
> 
> It does sound like the approach with least side effects.
> 
Martin and Willem , while we are discussing to use seperate bit per skb to check if its 
SO_TXTIME from userspace or (rcv) timestamp . I came across two flags used in skbuff
called in filter framework
@tc_at_ingress: used within tc_classify to distinguish in/egress
@from_ingress: packet was redirected from the ingress path

Since i believe the above testcase is based on redirecting from ingress to egress part
why cant we use these already existing flags ? Please advice 

I am not completely sure if we can use these flags to solve the bpf problem or not. 
but considering the problem statment put forth by Willem stating that we are just adding 
flags for every usecase and not keeping the design scalable for future needs. 

> If we're going to increase to two bits per skb, it's perhaps
> better to just encode the (selected supported) CLOCK_ type, rather
> than only supporting clockid through skb->sk->sk_clockid.
> 
> This BPF function is the analogue to SO_TXTIME. It is clearly
> extensible to additional BPF_SKB_TSTAMP_DELIVERY_.. types. To
> work with sch_etf, say.
> 
>> If we need to revert the 
>> mono_delivery_time reuse patch later, we will need to revert the netdev patch 
>> and the (to-be-made) bpf patch.
> 
> 
>  
> 
> 

