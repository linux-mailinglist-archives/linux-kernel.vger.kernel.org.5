Return-Path: <linux-kernel+bounces-103786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EF587C47B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64BFF28365B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E4176413;
	Thu, 14 Mar 2024 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ltQ1PJEu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F58C73196;
	Thu, 14 Mar 2024 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710449638; cv=none; b=EBpObwfNiDMuFJ8Vc2ofrIsOV1pLQVrNh7z5IrWPnFkJkXz/JCIC5AjE95p65ecJ09Sp3+XamIv0IBI/CxQFhk+HlV5ObUBahcaGtMte2Vrfqd76o26bHr/yWSKnvMu5/gn2NmwfuzdlZ05h8Zek8qXHWnezM3Uei5DXh99vsQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710449638; c=relaxed/simple;
	bh=TEv+H1bswr+8vY7p2gyL5HKVtFfDNA9XfV+rdVizc8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t2vYT2K+iLpRW/aejUjacyTVSJPR0K7KbWvpnielqrFIXWHVz3OsaZMrqy85qlmIOX0TwlLBZKI2qdpvaRLlaUMNPRA87z8UjMAUbYeihhDUzlCshpQP8SjCsdhzOl2Q5UMtAoXxFz48nrAPU7N50u6/pJUyUvwm4sS0PDqijyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ltQ1PJEu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42EKAKCk005987;
	Thu, 14 Mar 2024 20:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=cLtKCF62FF0vkKniVeV99Hv10VrsPYHKdhsl6X8KqBg=; b=lt
	Q1PJEu+qHouKYePSaPfiw5tRUy5pispF+t8CH8o+a175JkiCO/9vU7FMofOFNHHb
	Atw11HQ6R7haugmyRUXLS8Haa1Ikbah2QPHhGZqPGGsRzb+cSxHWHaAD7UYAtmlE
	sU9URTtboIQ8bAJ+9pD7vl3g+H/19yFUhoprRzQt5svfz7kq29RFmtFByaH9UX0l
	VlMwtKF0lnnb1rjOBNoKXj3+ys2pNyjBDvbWTH3N9Dv/cKcWI2h2e+ZwSmSA9dAd
	ipHeweQOI79pC4mlICBfPs/4ZIFV651JGWyvgicdsrFHGXCBP1ig2Yh+1f751tyS
	WVNwBal8JcVdEC8c3gXA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wv81bg2ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 20:53:34 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EKrXPk026027
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 20:53:33 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 13:53:29 -0700
Message-ID: <e270b646-dae0-41cf-9ef8-e991738b9c57@quicinc.com>
Date: Thu, 14 Mar 2024 13:53:29 -0700
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
 <0dff8f05-e18d-47c8-9f19-351c44ea8624@linux.dev>
 <e5da91bc-5827-4347-ab38-36c92ae2dfa2@quicinc.com>
 <65f21d65820fc_3d934129463@willemb.c.googlers.com.notmuch>
 <bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev>
 <65f2c81fc7988_3ee61729465@willemb.c.googlers.com.notmuch>
 <5692ddb3-9558-4440-a7bf-47fcc47401ed@linux.dev>
 <65f35e00a83c0_2132294f5@willemb.c.googlers.com.notmuch>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <65f35e00a83c0_2132294f5@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k2qdVf5ZFH5s58IQjYO03QyOVUycO3zR
X-Proofpoint-ORIG-GUID: k2qdVf5ZFH5s58IQjYO03QyOVUycO3zR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=978
 mlxscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403140161



On 3/14/2024 1:28 PM, Willem de Bruijn wrote:
> Martin KaFai Lau wrote:
>> On 3/14/24 2:49 AM, Willem de Bruijn wrote:
>>>> The two bits could potentially only encode the delivery time that is allowed to
>>>> be forwarded without reset. 0 could mean refering back to sk_clockid and don't
>>>> forward. The final consumer of the forwarded skb->tstamp is the qdisc which
>>>> currently only has mono and tai.
>>>
>>> So the followinng meaning of bit pair
>>> { skb->mono_delivery_time, skb->user_delivery_time } ?
>>>   
>>> - { 0, 0 } legacy skb->tstamp: realtime on rx
>>> - { 1, 0 } skb->tstamp is mono: existing behavior of mono_delivery_time bit
>>> - { 0, 1 } skb->tstamp is tai: analogous to mono case
>>> - { 1, 1 } skb->tstamp defined by skb->sk->sk_clockid
>>
>> I was thinking only forward mono and tai until it is clearer how other clocks 
>> will be useful for forwarding between e/ingress. By resetting all skb->tstamp 
>> other than mono and tai, { 0, 0 } at ingress will mean realtime on rx and { 0, 0 
>> } at egress will mean go look skb->sk->sk_clockid.
>>
>> I do like your scheme such that it is much clearer what is in skb->tstamp 
>> without depending on other bits like tc_at_ingress or not.
>>
>> "{ 0, 1 } skb->tstamp is tai: analogous to mono case" can probably be dropped 
>> for now until bpf_skb_set_tstamp(BPF_SKB_TSTAMP_DELIVERY_TAI) is needed.
>> Otherwise, it is mostly a duplicate of "{ 1, 1 } skb->tstamp defined by 
>> skb->sk->sk_clockid".
>>
>> The bpf_convert_tstamp_{read,write} and the helper bpf_skb_set_tstamp need to be 
>> changed to handle the new "user_delivery_time" bit anyway, e.g. 
>> bpf_skb_set_tstamp(BPF_SKB_TSTAMP_DELIVERY_MONO) needs to clear the 
>> "user_delivery_time" bit.
>>
>> I think the "struct inet_frag_queue" also needs a new "user_delivery_time" 
>> field. "mono_delivery_time" is already in there.
>>
>> It may as well be cleaner to combine mono_delivery_time and user_delivery_time 
>> into a 2 bits field like:
>>
>> struct sk_buff {
>> 	__u8 tstamp_type:2;
>> };
>>
>> enum {
>> 	SKB_TSTAMP_TYPE_RX_REAL = 0, /* A RX (receive) time in real */
>> 	SKB_TSTAMP_TYPE_TX_MONO = 1, /* A TX (delivery) time in mono */
>>
>> 	/* A TX (delivery) time and its clock is in skb->sk->sk_clockid.
>> 	 *
>> 	 * BPF_SKB_TSTAMP_DELIVERY_USER should be added
>> 	 * such that reading __sk_buff->tstamp_type will match the
>> 	 * SKB_TSTAMP_TYPE_TX_USER.
>> 	 *
>> 	 * The bpf program can learn the clockid by
>> 	 * reading skb->sk->sk_clockid.
>> 	 *
>> 	 * bpf_skb_set_tstamp(BPF_SKB_TSTAMP_DELIVERY_USER)
>> 	 * should be disallowed for now until the use case
>> 	 * is more clear. Potentially, we could allow it
>> 	 * in the future as long as
>> 	 * the sock_flag(sk, SOCK_TXTIME) is true at that moment.
>> 	 */
>> 	SKB_TSTAMP_TYPE_TX_USER = 2,
>>
>> 	/* UNUSED_FOR_FUTURE = 3, */
>> };
>>
>> It will have more code churns in the first patch to rename 
>> s/mono_delivery_time/tstamp_type/.
>>
>> wdyt?
> 
> I asked for such code churn in the original patch. We then decided to
> leave the variable name as is, as the churn was significant.
> 
> Long term, it is obviously cleaner.
> 
> I don't have a strong opinion. If doing this, let's at least make it
> two separate patches, one that is a NOOP rename only.
> Martin and Willem.
Lets do the cleaner approach. I feel its now or never. 

1. I will raise one patch to introduce rename mono_delivery_time to 
tstamp_type 
2. I will introduce setting of userspace timestamp type as the second bit 
whem transmit_time is set. 
3. This will be a first step to make the design scalable. 
4. Tomorrow if we have more timestamp to support, upstream community has to do is 
update the enum and increase the bitfield from 2=>3 and so on. 

I need help from Martin to test the patch which renames the mono_delivery_time 
to tstamp_type (Which i feel should be straight forward as the value of the bit is 1)

Sounds like a plan ? 

> 

