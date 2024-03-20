Return-Path: <linux-kernel+bounces-108490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2E6880B2B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82B91F232C8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAC01B592;
	Wed, 20 Mar 2024 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lQdBdNWD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F49E1DDDB;
	Wed, 20 Mar 2024 06:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710915796; cv=none; b=cdwLC0f3of4uFasdUDeFHzTefPm6k8Nn1lLBFC+WFv81AJRPuwLtMiBqm808rQz2mgDgS0T3Q81FMT8DbuRhkOxIE4sr4mIX//fT5RqxonNzJUk/RokEIX+tgrOGLEvPPySye+6Uaf07zDw7Nmlp+MkLzZg35g+TISFDEG03KGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710915796; c=relaxed/simple;
	bh=JepxoVn/y92Zm8LSWzg0iAPKkXS0xVOaDszLYrBRltk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=ewHl250FmRDJHEKMvyJ14yprOwamHynkoVW1GpqbApxFyXSiAKuLkEmjNFLZ6C6W24BcCgNmKo17cbVobcVY0A8LdjuODu6s9bqWujrO9+gaNdafIGtHq5SzzMPu89P3cnR4q2OfZLsailLJSBGvFe4D3/TVOP5r6KRajO6kdNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lQdBdNWD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42K585e5025111;
	Wed, 20 Mar 2024 06:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=OMPXI3u8TkCfqqrW7UKeDyKVc2JyB9/Mz90//A5Weeo=; b=lQ
	dBdNWDRiSduSQ8MKPf7UDbwEaZYbYRAF0DNdVpRFqQVfIEjei3V8ZujgI+bs4Wlr
	nmqRVmwXlQZ/MCNdJfjyfE6zvUgJPxlQWmD8LDzR41JRN0QAQLbi1jrfu77hrQ/n
	WAVP9mh9vNwQSdXeZYOZwbzRZOjCp63SaZtC+4A+pI8lyTtrCLWSAvKf2ndDcoSL
	ezCLeiptKcsdOlss97JnfKBGsyTheNO8ojw6FllFwjw2hbb9+zS+gyC/5VEArD6i
	PjveUx34Y2cZu8cmrkQYcbkK+4Pxt95zTLkMvqYscsLW0ntMET2HUUuRQNeJ/2IU
	65VpnWwdIIme1a8X2sgg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyqpe09ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 06:22:47 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42K6MkqO030140
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 06:22:46 GMT
Received: from [10.110.44.107] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 23:22:42 -0700
Message-ID: <ac03f67c-604a-4fb8-a0ca-c187e27855be@quicinc.com>
Date: Tue, 19 Mar 2024 23:22:41 -0700
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
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, <kernel@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Halaney
	<ahalaney@redhat.com>,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf
	<bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Alexei
 Starovoitov" <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
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
 <e270b646-dae0-41cf-9ef8-e991738b9c57@quicinc.com>
 <8d245f5a-0c75-4634-9513-3d420eb2c88f@linux.dev>
 <d10254cc-a908-4d81-98d2-2eed715e521f@quicinc.com>
 <66ad9e5b-0126-476e-bf0f-6a33f446c976@quicinc.com>
In-Reply-To: <66ad9e5b-0126-476e-bf0f-6a33f446c976@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: spoDDDnBw54sPQ9lWY3jvni3HkwhnNgA
X-Proofpoint-ORIG-GUID: spoDDDnBw54sPQ9lWY3jvni3HkwhnNgA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_03,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403200048



On 3/18/2024 12:02 PM, Abhishek Chauhan (ABC) wrote:
> 
> 
> On 3/14/2024 3:29 PM, Abhishek Chauhan (ABC) wrote:
>>
>>
>> On 3/14/2024 2:48 PM, Martin KaFai Lau wrote:
>>> On 3/14/24 1:53 PM, Abhishek Chauhan (ABC) wrote:
>>>>>> The bpf_convert_tstamp_{read,write} and the helper bpf_skb_set_tstamp need to be
>>>>>> changed to handle the new "user_delivery_time" bit anyway, e.g.
>>>>>> bpf_skb_set_tstamp(BPF_SKB_TSTAMP_DELIVERY_MONO) needs to clear the
>>>>>> "user_delivery_time" bit.
>>>>>>
>>>>>> I think the "struct inet_frag_queue" also needs a new "user_delivery_time"
>>>>>> field. "mono_delivery_time" is already in there.
>>>
>>> [ ... ]
>>>
> 
> Martin, Do we really need to add user_delivery_time as part of inet_frag_queue struct? I was wondering why is this required since we are using tstamp_type:2 to 
> distinguish between timestamp anyway .
> 
> Let me know what you think ? 
> 
>>> I would think the first step is to revert this patch. I don't think much of the current patch can be reused.
>>>
>>>> 1. I will raise one patch to introduce rename mono_delivery_time to
>>>> tstamp_type
>>>
>>> Right, I expect something like this:
>>>
>>> struct sk_buff {
>>>         /* ... */
>>> -            __u8                    mono_delivery_time:1;
>>> +        __u8            tstamp_type:1;
>>>         /* ... */
>>> };
>>>
>>
>> Okay ,This should be straight-forward. 
>>
>>>> 2. I will introduce setting of userspace timestamp type as the second bit
>>>> whem transmit_time is set.
>>>
>>> I expect the second patch should be introducing the enum first
>>>
>>> enum skb_tstamp_type {
>>>     SKB_TSTAMP_TYPE_RX_REAL = 0, /* A RX (receive) time in real */
>>>     SKB_TSTAMP_TYPE_TX_MONO = 1, /* A TX (delivery) time in mono */
>>> };
>>>
>>> and start doing "skb->tstamp_type = SKB_TSTAMP_TYPE_TX_MONO;" instead of
>>> "skb->tstamp_type = 1;"
>>>
>>> and the same for "skb->tstamp_type = SKB_TSTAMP_TYPE_RX_REAL;" instead of
>>> "skb->tstamp_type = 0;"
>>>
>>>
>>> This one I am not sure but probably need to change the skb_set_delivery_time() function signature also:
>>>
>>> static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
>>> -                                        bool mono)
>>> +                     enum skb_tstamp_type tstamp_type)
>>>
>> This should be straight-forward as well 
>>
>>> The third patch is to change tstamp_type from 1 bit to 2 bits and add SKB_TSTAMP_TYPE_TX_USER.
>>>
>>> struct sk_buff {
>>>         /* ... */
>>> -        __u8            tstamp_type:1;
>>> +        __u8            tstamp_type:2;
>>>         /* ... */
>>> };
>>>
>>> enum skb_tstamp_type {
>>>     SKB_TSTAMP_TYPE_RX_REAL = 0,    /* A RX (receive) time in real */
>>>     SKB_TSTAMP_TYPE_TX_MONO = 1,    /* A TX (delivery) time in mono */
>>> +    SKB_TSTAMP_TYPE_TX_USER = 2,    /* A TX (delivery) time and its clock
>>>                      * is in skb->sk->sk_clockid.
>>>                      */
>>>                
>>> };
>>>
>>> This will shift a bit out of the byte where tstamp_type lives. It should be the "inner_protocol_type" bit by my hand count. Please check if it is directly used in bpf instruction (filter.c). As far as I look, it is not, so should be fine. Some details about bpf instruction accessible skb bit field here: https://lore.kernel.org/all/20230321014115.997841-1-kuba@kernel.org/
>> This is where i would need thorough reviews from you and Willem as my area of expertise is limited to part of network stack and BPF is not one of them. 
>> But i have plan on this and i know how to do it. 
>>
>> Expect patches to be arriving to your inboxes next week, as we have a long weekend in Qualcomm 
>> Fingers crossed :) 
>>
>>>
>>>
>>>> 3. This will be a first step to make the design scalable.
>>>> 4. Tomorrow if we have more timestamp to support, upstream community has to do is
>>>> update the enum and increase the bitfield from 2=>3 and so on.
>>>>
>>>> I need help from Martin to test the patch which renames the mono_delivery_time
>>>> to tstamp_type (Which i feel should be straight forward as the value of the bit is 1)
>>>
>>> The bpf change is not a no-op rename of mono_delivery_time. It needs to take care of the new bit added to the tstamp_type. Please see the previous email (and I also left it in the beginning of this email).
>>>
>>> Thus, you need to compile the selftests/bpf/ and run it to verify the changes when handling the new bit. The Documentation/bpf/bpf_devel_QA.rst has the howto details. You probably only need the newer llvm (newer gcc should work also as bpf CI has been using it) and the newer pahole. I can definitely help if there is issue in running the test_progs in selftests/bpf or you have question on making the changes in filter.c. To run the test: "./test_progs -t tc_redirect/tc_redirect_dtime"
>>>

Martin,
I was able to compile test_progs and execute the above command mentioned by you . Does the output look okay for you ? 

[ 3076.040766] IPv6: ADDRCONF(NETDEV_CHANGE): veth_src_fwd: link becomes ready
[ 3076.040809] IPv6: ADDRCONF(NETDEV_CHANGE): veth_src: link becomes ready
[ 3076.072844] IPv6: ADDRCONF(NETDEV_CHANGE): veth_dst: link becomes ready
[ 3076.072880] IPv6: ADDRCONF(NETDEV_CHANGE): veth_dst_fwd: link becomes ready
#214/5   tc_redirect/tc_redirect_dtime:OK
#214     tc_redirect:OK
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED




