Return-Path: <linux-kernel+bounces-68684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBC1857E60
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CEC91F22E99
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188B112C534;
	Fri, 16 Feb 2024 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="cZ9dnzPn"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E461BDD8;
	Fri, 16 Feb 2024 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092081; cv=none; b=IcdNu54ThYw05RMrVQ4rxxk/VD3b1p0X8r3ARYomWXoCMniQCL0m2nVCcyanbHhDSKoz7jvS2kY021+jQnprVnZtX1WUsGU6QIBR18vh6Yc0Je73y0SoG7VklVeB0bYY7ADc+6gn3jJOF4SiQq6TvJHQD0b5XYaNrnNc6jQWblc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092081; c=relaxed/simple;
	bh=5x71ZGn9eERzODLmiS9usSdv9M+F4w7Rdht/BFSRVGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2INoQdNLiD4NNhWljd9mKDQdp2q/xy8re+oBOvpqb45K6PhLo02Kz8f5Ko4DOVeYrbtF72lLk+6SM9GUdTaeU1hDKwzzO/kCw491snjIsNkSDKqsvWCk6GNmVpce9g2xY1nYEmkeEkBmFAXIe6AvJVBqBrg6t4fvGSUiYC3kVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=cZ9dnzPn; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 4C219600D4;
	Fri, 16 Feb 2024 14:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1708092074;
	bh=5x71ZGn9eERzODLmiS9usSdv9M+F4w7Rdht/BFSRVGg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cZ9dnzPnX34nlCraw6AoRN8PlG5pr/ifB1VcDbL9L+8Fo/hWihXuViuFsOuT+2IPa
	 k9GTHMc52z0wDq+2jhCDpWaB5weAI3xtiy0X4hQMk5qhGm7HjI8rwfmySdgysaouvy
	 ovhiseL79cIukaRHVCagQ0/cx6DKJUxbSuwCBwKbUca1QHcsVIuV1Bjko1fCbCWkdY
	 UHSERolsOWWdIM5IMko+0kcT33tXHfkrsbFq0gktkk9ULguqP6VLaSzLwH75JjMcfS
	 U+v60dPfGaEYNpX1g9ICXTrboj6lBTMnshYIbU9u/kj3gF0wiOwqcCB2cgvRkaFoT4
	 YOlGgr0s2AXbA==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 165CD2004F9;
	Fri, 16 Feb 2024 14:01:07 +0000 (UTC)
Message-ID: <28bf1467-b7ce-4e36-a4ef-5445f65edd97@fiberby.net>
Date: Fri, 16 Feb 2024 14:01:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: sched: make skip_sw actually skip
 software
Content-Language: en-US
To: Vlad Buslov <vladbu@nvidia.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, llu@fiberby.dk
References: <20240215160458.1727237-1-ast@fiberby.net>
 <20240215160458.1727237-4-ast@fiberby.net> <871q9cdbyl.fsf@nvidia.com>
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <871q9cdbyl.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vlad,

On 2/16/24 08:47, Vlad Buslov wrote:
> On Thu 15 Feb 2024 at 16:04, Asbjørn Sloth Tønnesen <ast@fiberby.net> wrote:
>> TC filters come in 3 variants:
>> - no flag (no opinion, process wherever possible)
>> - skip_hw (do not process filter by hardware)
>> - skip_sw (do not process filter by software)
>>
>> However skip_sw is implemented so that the skip_sw
>> flag can first be checked, after it has been matched.
>>
>> IMHO it's common when using skip_sw, to use it on all rules.
>>
>> So if all filters in a block is skip_sw filters, then
>> we can bail early, we can thus avoid having to match
>> the filters, just to check for the skip_sw flag.
>>
>>   +----------------------------+--------+--------+--------+
>>   | Test description           | Pre    | Post   | Rel.   |
>>   |                            | kpps   | kpps   | chg.   |
>>   +----------------------------+--------+--------+--------+
>>   | basic forwarding + notrack | 1264.9 | 1277.7 |  1.01x |
>>   | switch to eswitch mode     | 1067.1 | 1071.0 |  1.00x |
>>   | add ingress qdisc          | 1056.0 | 1059.1 |  1.00x |
>>   +----------------------------+--------+--------+--------+
>>   | 1 non-matching rule        |  927.9 | 1057.1 |  1.14x |
>>   | 10 non-matching rules      |  495.8 | 1055.6 |  2.13x |
>>   | 25 non-matching rules      |  280.6 | 1053.5 |  3.75x |
>>   | 50 non-matching rules      |  162.0 | 1055.7 |  6.52x |
>>   | 100 non-matching rules     |   87.7 | 1019.0 | 11.62x |
>>   +----------------------------+--------+--------+--------+
>>
>> perf top (100 n-m skip_sw rules - pre patch):
>>    25.57%  [kernel]  [k] __skb_flow_dissect
>>    20.77%  [kernel]  [k] rhashtable_jhash2
>>    14.26%  [kernel]  [k] fl_classify
>>    13.28%  [kernel]  [k] fl_mask_lookup
>>     6.38%  [kernel]  [k] memset_orig
>>     3.22%  [kernel]  [k] tcf_classify
>>
>> perf top (100 n-m skip_sw rules - post patch):
>>     4.28%  [kernel]  [k] __dev_queue_xmit
>>     3.80%  [kernel]  [k] check_preemption_disabled
>>     3.68%  [kernel]  [k] nft_do_chain
>>     3.08%  [kernel]  [k] __netif_receive_skb_core.constprop.0
>>     2.59%  [kernel]  [k] mlx5e_xmit
>>     2.48%  [kernel]  [k] mlx5e_skb_from_cqe_mpwrq_nonlinear
>>
>> Test setup:
>>   DUT: Intel Xeon D-1518 (2.20GHz) w/ Nvidia/Mellanox ConnectX-6 Dx 2x100G
>>   Data rate measured on switch (Extreme X690), and DUT connected as
>>   a router on a stick, with pktgen and pktsink as VLANs.
>>   Pktgen was in range 12.79 - 12.95 Mpps across all tests.
>>
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>> ---
>>   include/net/pkt_cls.h | 5 +++++
>>   net/core/dev.c        | 3 +++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
>> index a4ee43f493bb..a065da4df7ff 100644
>> --- a/include/net/pkt_cls.h
>> +++ b/include/net/pkt_cls.h
>> @@ -74,6 +74,11 @@ static inline bool tcf_block_non_null_shared(struct tcf_block *block)
>>   	return block && block->index;
>>   }
>>   
>> +static inline bool tcf_block_has_skip_sw_only(struct tcf_block *block)
>> +{
>> +	return block && atomic_read(&block->filtercnt) == atomic_read(&block->skipswcnt);
>> +}
> 
> Note that this introduces a read from heavily contended cache-line on
> data path for all classifiers, including the ones that don't support
> offloads. Wonder if this a concern for users running purely software tc.

Unfortunately, I don't have access to any multi-CPU machines, so I haven't been
able to test the impact of that.

Alternatively I guess I could also maintain a static key in the counter update logic.


>> +
>>   static inline struct Qdisc *tcf_block_q(struct tcf_block *block)
>>   {
>>   	WARN_ON(tcf_block_shared(block));
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index d8dd293a7a27..7cd014e5066e 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -3910,6 +3910,9 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
>>   	if (!miniq)
>>   		return ret;
>>   
>> +	if (tcf_block_has_skip_sw_only(miniq->block))
>> +		return ret;
>> +
>>   	tc_skb_cb(skb)->mru = 0;
>>   	tc_skb_cb(skb)->post_ct = false;
>>   	tcf_set_drop_reason(skb, *drop_reason);
> 

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

