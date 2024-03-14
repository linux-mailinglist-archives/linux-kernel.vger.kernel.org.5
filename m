Return-Path: <linux-kernel+bounces-103834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2963587C523
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 779EAB21C0E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED22D76914;
	Thu, 14 Mar 2024 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mSRzgc5U"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9BF768F3;
	Thu, 14 Mar 2024 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710455378; cv=none; b=nsPgmcQxV6l7P7zLCpkDV/NcYyFZ/Ws6yLjFhZJvIze6Px6gdoylHtp9SQ4vAr06I2D7/OopukKBl/qk90qodmliHg5rlX1ACDVHfNLPJdc+7fo65J74/IAVyTa67SdJjq2Dlw26FAZ3gxr2XcWgt0TUtgKvb3iMcmSFi0QovIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710455378; c=relaxed/simple;
	bh=mVfthxu8tHVEct71hEtyT2aI9z9fT34A0nFsHzLlNOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AmHmnLP1d6j4DUOuCDY1HPlZn731jqVFqlU28Bly2fKwIR4RIPq6oejH+A2MFwI2iR+znLlQ4UdtO+ejQF/YeO1YZ6J09ol6kHC0eKHkQhVp11Pjj1ZkpWQ340d9tPTs8eYpVhHLqUfzjg/T2cn8HeF586R8zHyvpR/yPX3f5yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mSRzgc5U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42EMNYQQ020001;
	Thu, 14 Mar 2024 22:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=KojSjym7u6QhZhv9Z7jGq3n3K1D2+++zSehhP0d95Pw=; b=mS
	Rzgc5Uzfgi/8/flB9EtZrys/ZidZPUABRnFuYBBK4wSpMUGqoY0K2Gyw6VIPZbGW
	gIODgfDayGKMOhe0jU8tFB2UiBHp3VVKKA/CkYaWWGV22IVnL1+yjrpOmSm61wlF
	di9BcxLDQTTybW0i5+06SfqHwyE6ctr/8RidcLfwuYacrXB1XJmpf0kauIIysHMa
	EotQzAUo0Gi1/6pxqoePOjPtc++lgJi/KXCtK8u8Dsuz6vNR/xSyx1UrxhZPAjv7
	9VIGYKxZVhvYLDgdnAUsKm4/tlq8urHnZGY3CiJlH4WhUmvElJv0VHJFU2enBeZ6
	4kkZC8LLpiTLCPNTkoaQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wva09008a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 22:29:10 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EMT9lx014532
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 22:29:09 GMT
Received: from [10.110.112.81] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 15:29:04 -0700
Message-ID: <d10254cc-a908-4d81-98d2-2eed715e521f@quicinc.com>
Date: Thu, 14 Mar 2024 15:29:04 -0700
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
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <8d245f5a-0c75-4634-9513-3d420eb2c88f@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RPmOXb7udbsKUzQltMBLnmHPtYnQ-3Ml
X-Proofpoint-ORIG-GUID: RPmOXb7udbsKUzQltMBLnmHPtYnQ-3Ml
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 mlxscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403140172



On 3/14/2024 2:48 PM, Martin KaFai Lau wrote:
> On 3/14/24 1:53 PM, Abhishek Chauhan (ABC) wrote:
>>>> The bpf_convert_tstamp_{read,write} and the helper bpf_skb_set_tstamp need to be
>>>> changed to handle the new "user_delivery_time" bit anyway, e.g.
>>>> bpf_skb_set_tstamp(BPF_SKB_TSTAMP_DELIVERY_MONO) needs to clear the
>>>> "user_delivery_time" bit.
>>>>
>>>> I think the "struct inet_frag_queue" also needs a new "user_delivery_time"
>>>> field. "mono_delivery_time" is already in there.
> 
> [ ... ]
> 
> I would think the first step is to revert this patch. I don't think much of the current patch can be reused.
> 
>> 1. I will raise one patch to introduce rename mono_delivery_time to
>> tstamp_type
> 
> Right, I expect something like this:
> 
> struct sk_buff {
>         /* ... */
> -            __u8                    mono_delivery_time:1;
> +        __u8            tstamp_type:1;
>         /* ... */
> };
> 

Okay ,This should be straight-forward. 

>> 2. I will introduce setting of userspace timestamp type as the second bit
>> whem transmit_time is set.
> 
> I expect the second patch should be introducing the enum first
> 
> enum skb_tstamp_type {
>     SKB_TSTAMP_TYPE_RX_REAL = 0, /* A RX (receive) time in real */
>     SKB_TSTAMP_TYPE_TX_MONO = 1, /* A TX (delivery) time in mono */
> };
> 
> and start doing "skb->tstamp_type = SKB_TSTAMP_TYPE_TX_MONO;" instead of
> "skb->tstamp_type = 1;"
> 
> and the same for "skb->tstamp_type = SKB_TSTAMP_TYPE_RX_REAL;" instead of
> "skb->tstamp_type = 0;"
> 
> 
> This one I am not sure but probably need to change the skb_set_delivery_time() function signature also:
> 
> static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
> -                                        bool mono)
> +                     enum skb_tstamp_type tstamp_type)
> 
This should be straight-forward as well 

> The third patch is to change tstamp_type from 1 bit to 2 bits and add SKB_TSTAMP_TYPE_TX_USER.
> 
> struct sk_buff {
>         /* ... */
> -        __u8            tstamp_type:1;
> +        __u8            tstamp_type:2;
>         /* ... */
> };
> 
> enum skb_tstamp_type {
>     SKB_TSTAMP_TYPE_RX_REAL = 0,    /* A RX (receive) time in real */
>     SKB_TSTAMP_TYPE_TX_MONO = 1,    /* A TX (delivery) time in mono */
> +    SKB_TSTAMP_TYPE_TX_USER = 2,    /* A TX (delivery) time and its clock
>                      * is in skb->sk->sk_clockid.
>                      */
>                
> };
> 
> This will shift a bit out of the byte where tstamp_type lives. It should be the "inner_protocol_type" bit by my hand count. Please check if it is directly used in bpf instruction (filter.c). As far as I look, it is not, so should be fine. Some details about bpf instruction accessible skb bit field here: https://lore.kernel.org/all/20230321014115.997841-1-kuba@kernel.org/
This is where i would need thorough reviews from you and Willem as my area of expertise is limited to part of network stack and BPF is not one of them. 
But i have plan on this and i know how to do it. 

Expect patches to be arriving to your inboxes next week, as we have a long weekend in Qualcomm 
Fingers crossed :) 

> 
> 
>> 3. This will be a first step to make the design scalable.
>> 4. Tomorrow if we have more timestamp to support, upstream community has to do is
>> update the enum and increase the bitfield from 2=>3 and so on.
>>
>> I need help from Martin to test the patch which renames the mono_delivery_time
>> to tstamp_type (Which i feel should be straight forward as the value of the bit is 1)
> 
> The bpf change is not a no-op rename of mono_delivery_time. It needs to take care of the new bit added to the tstamp_type. Please see the previous email (and I also left it in the beginning of this email).
> 
> Thus, you need to compile the selftests/bpf/ and run it to verify the changes when handling the new bit. The Documentation/bpf/bpf_devel_QA.rst has the howto details. You probably only need the newer llvm (newer gcc should work also as bpf CI has been using it) and the newer pahole. I can definitely help if there is issue in running the test_progs in selftests/bpf or you have question on making the changes in filter.c. To run the test: "./test_progs -t tc_redirect/tc_redirect_dtime"
> 

