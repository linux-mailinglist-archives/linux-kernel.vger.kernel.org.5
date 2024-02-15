Return-Path: <linux-kernel+bounces-67840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5B78571B2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0535DB20C6E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C610145B15;
	Thu, 15 Feb 2024 23:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="qTDaBESc"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C17F145341;
	Thu, 15 Feb 2024 23:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040363; cv=none; b=a/+z2sZGXXw8wBQt69C0qi+Lk4Nvos6+Ww/ERK7QFRQERmZ/CCZl4ITp2umuK06n0sOsjLcjuF8wo6Vb/w/B8uAwNFOdnDDv/fzptRVXy+ThanllgCJTUvvAcW+W0izETdOpKoDMArSpJyts7Q833cNObwHgNs1sASfkPH6GyM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040363; c=relaxed/simple;
	bh=URV7oyByK6o8bPCLQ/8vg7XBUGK01WMkHJBuUllx3Mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DIgXUVD1RK1rA27Rgjmj65qL/3nYqBXSGH4EetU5HFelJAHM5Y8x/RI4poCRfpph/rBjAeWvS5djW5ZBo+4NFPSXfz3jcWQJB9c1b9oVNNgUpZIXcgBsvnJHStnVGtspqEEL1bcMwc5LyAAuKjftTQXlFfsMB8T1Hf1QNBp7s5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=qTDaBESc; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id C1BB7600D4;
	Thu, 15 Feb 2024 23:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1708040357;
	bh=URV7oyByK6o8bPCLQ/8vg7XBUGK01WMkHJBuUllx3Mc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qTDaBESccAS5RH9OS82EZE64QBejkFE6umPmgOE6uNK7mpNJamJ8htJWSR1JnXvFk
	 FuPgAaSuwj5z3N6wvxl7WR3cNQvP5I/ZLD2APaVO88UEvoPB3J9BTHmq0zjBqLxt2J
	 rKC16H1BdXpJHwWM4Fyt0oC1g8D9qXuuzV1ADBV1WE37qc9RtLKzk5r9rHDgDWu/uA
	 7ZzENL3gH0Z6KQ1y7l2MJpYtCTB5D7MBhv1P0DwKSz90SX6DdCWXuhBeDiC0jxx2Al
	 ujV7meHn+TwgMjV7HzyIkjDNiobtIsmQFPBMdD4fsYcVAaQIKu+tJUeL40TZeBEecE
	 h7rUTW5WC3mqA==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 6370C200400;
	Thu, 15 Feb 2024 23:19:27 +0000 (UTC)
Message-ID: <99307ddb-2c4e-4ed3-a5e0-d67bb75e2187@fiberby.net>
Date: Thu, 15 Feb 2024 23:19:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: sched: cls_api: add filter counter
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llu@fiberby.dk
References: <20240215160458.1727237-1-ast@fiberby.net>
 <20240215160458.1727237-3-ast@fiberby.net> <Zc5JFhLI_KZtdy5P@nanopsycho>
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <Zc5JFhLI_KZtdy5P@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jiri,

Thanks for the review.

On 2/15/24 17:25, Jiri Pirko wrote:
> Thu, Feb 15, 2024 at 05:04:43PM CET, ast@fiberby.net wrote:
>> Maintain a count of filters per block.
>>
>> Counter updates are protected by cb_lock, which is
>> also used to protect the offload counters.
>>
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>> ---
>> include/net/sch_generic.h |  2 ++
>> net/sched/cls_api.c       | 20 ++++++++++++++++++++
>> 2 files changed, 22 insertions(+)
>>
>> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
>> index 46a63d1818a0..7af0621db226 100644
>> --- a/include/net/sch_generic.h
>> +++ b/include/net/sch_generic.h
>> @@ -427,6 +427,7 @@ struct tcf_proto {
>> 	 */
>> 	spinlock_t		lock;
>> 	bool			deleting;
>> +	bool			counted;
>> 	refcount_t		refcnt;
>> 	struct rcu_head		rcu;
>> 	struct hlist_node	destroy_ht_node;
>> @@ -476,6 +477,7 @@ struct tcf_block {
>> 	struct flow_block flow_block;
>> 	struct list_head owner_list;
>> 	bool keep_dst;
>> +	atomic_t filtercnt; /* Number of filters */
>> 	atomic_t skipswcnt; /* Number of skip_sw filters */
>> 	atomic_t offloadcnt; /* Number of oddloaded filters */
>> 	unsigned int nooffloaddevcnt; /* Number of devs unable to do offload */
>> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
>> index 397c3d29659c..c750cb662142 100644
>> --- a/net/sched/cls_api.c
>> +++ b/net/sched/cls_api.c
>> @@ -411,11 +411,13 @@ static void tcf_proto_get(struct tcf_proto *tp)
>> }
>>
>> static void tcf_chain_put(struct tcf_chain *chain);
>> +static void tcf_block_filter_cnt_update(struct tcf_block *block, bool *counted, bool add);
>>
>> static void tcf_proto_destroy(struct tcf_proto *tp, bool rtnl_held,
>> 			      bool sig_destroy, struct netlink_ext_ack *extack)
>> {
>> 	tp->ops->destroy(tp, rtnl_held, extack);
>> +	tcf_block_filter_cnt_update(tp->chain->block, &tp->counted, false);
>> 	if (sig_destroy)
>> 		tcf_proto_signal_destroyed(tp->chain, tp);
>> 	tcf_chain_put(tp->chain);
>> @@ -2364,6 +2366,7 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
>> 	err = tp->ops->change(net, skb, tp, cl, t->tcm_handle, tca, &fh,
>> 			      flags, extack);
>> 	if (err == 0) {
>> +		tcf_block_filter_cnt_update(block, &tp->counted, true);
>> 		tfilter_notify(net, skb, n, tp, block, q, parent, fh,
>> 			       RTM_NEWTFILTER, false, rtnl_held, extack);
>> 		tfilter_put(tp, fh);
>> @@ -3478,6 +3481,23 @@ int tcf_exts_dump_stats(struct sk_buff *skb, struct tcf_exts *exts)
>> }
>> EXPORT_SYMBOL(tcf_exts_dump_stats);
>>
>> +static void tcf_block_filter_cnt_update(struct tcf_block *block, bool *counted, bool add)
> 
> Can't you move this up to avoid forward declaration?

Sure, will do that in v2.

I had considered it, but in the end decided to keep it next to the related offloadcnt logic.


>> +{
>> +	lockdep_assert_not_held(&block->cb_lock);
>> +
>> +	down_write(&block->cb_lock);
>> +	if (*counted != add) {
>> +		if (add) {
>> +			atomic_inc(&block->filtercnt);
>> +			*counted = true;
>> +		} else {
>> +			atomic_dec(&block->filtercnt);
>> +			*counted = false;
>> +		}
>> +	}
>> +	up_write(&block->cb_lock);
>> +}
>> +
>> static void tcf_block_offload_inc(struct tcf_block *block, u32 *flags)
>> {
>> 	if (*flags & TCA_CLS_FLAGS_IN_HW)
>> -- 
>> 2.43.0
>>

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

