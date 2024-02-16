Return-Path: <linux-kernel+bounces-68650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F55C857DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1629F289980
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD53412AAFB;
	Fri, 16 Feb 2024 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="QBNyrtkG"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF8912A16C;
	Fri, 16 Feb 2024 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090734; cv=none; b=kB2+d6uqN/u99klaxNKxCPDcYrOvbIpsiM3uYkeh78LvxJKY4GW6819DoTBEauOi3bzXY9Ufq+NIn0Q4DY9hna7PDgqbhI7ZaMt/AfYXQXOii5fHI3a+46pft+1F0fyWi+HyqxkT3RMZAnyv8cJ6NK8BkCUIKUshSwtXprvTYT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090734; c=relaxed/simple;
	bh=5N3X7lp87ZiHhf4Mvpp9zVNBKPXjjavdVv2neQg8O1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hitUnGstj3zABHmoSqa03UQRK+LB0KUYeB+nKjiUdemmqsnxlL3giaQRfVg+smgGzuXaqKRISrEfYI6KzrlFW6w5qYgI5UgHIMPF7OdovGiNO9Z3bS8JQ8v663Ii/agX7ZZBXq9Aw+R4CzCJLnrroeoneLshTlO/4rlKwd/PEyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=QBNyrtkG; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 97F1E600D4;
	Fri, 16 Feb 2024 13:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1708090727;
	bh=5N3X7lp87ZiHhf4Mvpp9zVNBKPXjjavdVv2neQg8O1A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QBNyrtkGfchK5k290FeKAGyMxNYN3m4UxvXRnyc/0lBGIEh8nwkHZ3pifFmy3Sv/G
	 gEYnUHqysQzgUVMv6TJQx32+DvgGsLXu+Go3d27vUj4WWpqIpftll8h6JjQdFVTM22
	 BbqOA6E47/cwzO+tHqp3NMqI5hlEIDXfVLR5j94AACQ7XZXorXwLF00hPjQmjVZ/l1
	 PB5XAxI9vLMGTrCSHf83MobQ2Jld1hrMbzWol3FsqTegF1Z/jMYeGwDIiwDTN5fX1d
	 WNhz1zPl1YXFJCqez/5bLiQJxZj4Vjm/AlXrmRFE5nx6WqlIWRUeoeds/CR5PkhoDw
	 EkYY/1f0ME4Sg==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 94BDD2004F9;
	Fri, 16 Feb 2024 13:38:27 +0000 (UTC)
Message-ID: <901babe8-71dc-41c7-931a-e450a12d7e1f@fiberby.net>
Date: Fri, 16 Feb 2024 13:38:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: sched: make skip_sw actually skip
 software
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, llu@fiberby.dk, Vlad Buslov
 <vladbu@nvidia.com>, Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240215160458.1727237-1-ast@fiberby.net>
 <20240215160458.1727237-4-ast@fiberby.net>
 <CAM0EoMmyGwA9Q=RibR+Fc41_dPZyhBRWiBEejSbPsS9NhaUFVQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <CAM0EoMmyGwA9Q=RibR+Fc41_dPZyhBRWiBEejSbPsS9NhaUFVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jamal,

On 2/15/24 17:49, Jamal Hadi Salim wrote:
> On Thu, Feb 15, 2024 at 11:06 AM Asbjørn Sloth Tønnesen <ast@fiberby.net> wrote:
>>
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
> 
> The concept makes sense - but i am wondering when you have a mix of
> skip_sw and skip_hw if it makes more sense to just avoid looking up
> skip_sw at all in the s/w datapath? Potentially by separating the
> hashes for skip_sw/hw. I know it's a deeper surgery - but would be
> more general purpose....unless i am missing something
 >
>> Test setup:
>>   DUT: Intel Xeon D-1518 (2.20GHz) w/ Nvidia/Mellanox ConnectX-6 Dx 2x100G
>>   Data rate measured on switch (Extreme X690), and DUT connected as
>>   a router on a stick, with pktgen and pktsink as VLANs.
>>   Pktgen was in range 12.79 - 12.95 Mpps across all tests.
>>
> 
> Hrm. Those are "tiny" numbers (25G @64B is about 3x that). What are
> the packet sizes?
> Perhaps the traffic generator is a limitation here?
> Also feels like you are doing exact matches? A sample flower rule
> would have helped.

Yeah, I would also have liked those number to be higher. Sorry forgot to mention it is 64B packets.

Sadly, I used two machine to compensate for my lack of pktgen skills.
I know that there are faster packet generators, but I just used the in-kernel one,
and haven't invested much time into it, but the normal ethtool params mentioned in
the doc didn't change much, and since it was still more than enough packets that DUT
would go to 100% CPU, I didn't pursue it further.

pktgen A: Xeon E5-1620 v2 @ 3.70GHz w/ ConnectX-6 Dx and 100G link.
pktgen B: Xeon(R) D-2123IT @ 2.20GHz w/ Intel X722 and 10G link.

Both pktgen boxes are running stock Debian bullseye kernel (v6.1)

I found this to work best:
/pktgen_sample05_flow_per_thread.sh -i enp8s0f0np0 -s 64 -d 10.53.22.3 -m 2a:11:22:33:21:11 -p 1024-65000 -t 8 -n 0

Datarates monitored through SNMP using:
   snmpdelta -Cp 10 -c public -v 2c -Cs $hostname IF-MIB::ifInUcastPkts.1057 IF-MIB::ifOutUcastPkts.1057

VLAN config, MAC and IP addressing:
   v21:
     2a:11:22:33:21:11 - 10.53.21.1/27 - dut v21      (tagged VLAN)
     2a:11:22:33:21:12 - 10.53.21.2/27 - pktgen-a     (untagged)
     2a:11:22:33:21:13 - 10.53.21.3/27 - pktgen-b     (untagged)

   v22:
     2a:11:22:33:22:21 - 10.53.22.2/31 - dut v22      (tagged VLAN)
     2a:11:22:33:22:22 - 10.53.22.3/31 - packet drop  (untagged)


Switch MAC address table config:
   # static entry
   create fdb 2a:11:22:33:21:11 vlan "v21" port 57

   # blackhole pktsink
   create fdb 2a:11:22:33:22:22 vlan "v22" blackhole

flow control are disabled on all links:
   ethtool -A $dev rx off tx off

I have uploaded the script used for the flower rules in the tests here:
   https://files.fiberby.net/ast/2024/tc_skip_sw/flower_placement_tests.sh


> cheers,
> jamal
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
>>          return block && block->index;
>>   }
>>
>> +static inline bool tcf_block_has_skip_sw_only(struct tcf_block *block)
>> +{
>> +       return block && atomic_read(&block->filtercnt) == atomic_read(&block->skipswcnt);
>> +}
>> +
>>   static inline struct Qdisc *tcf_block_q(struct tcf_block *block)
>>   {
>>          WARN_ON(tcf_block_shared(block));
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index d8dd293a7a27..7cd014e5066e 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -3910,6 +3910,9 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
>>          if (!miniq)
>>                  return ret;
>>
>> +       if (tcf_block_has_skip_sw_only(miniq->block))
>> +               return ret;
>> +
>>          tc_skb_cb(skb)->mru = 0;
>>          tc_skb_cb(skb)->post_ct = false;
>>          tcf_set_drop_reason(skb, *drop_reason);
>> --
>> 2.43.0
>>

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

