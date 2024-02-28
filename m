Return-Path: <linux-kernel+bounces-85305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948D886B3C8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB68282B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D55A15D5AB;
	Wed, 28 Feb 2024 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHI9iAWs"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C55612FC;
	Wed, 28 Feb 2024 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135611; cv=none; b=kdB0A8AO/1/3EXF8IIuFPGfZISL2OOuFGj0nF2B4mz2sbpFqxsM6KHzNFB25CfAdtuFMir2ljj7josw42slw9gT4hIgUxs4BmonRkEPZ2/H67rN2sdgRGNgWcYvUhO9Fh4YnSlQd1vIiD5NbnmlQaGGKa8HBUWuzqaKMalghBUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135611; c=relaxed/simple;
	bh=7KRysvBxgCtixASyX0up0iH1o9fFCUrHXO7fvDQMEFk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=guerV9As3g0CL6C3DcQFcdgTevn3RJ42n64jRzmpR0wp1S6yD69nupDVhWHyXbG5yuGVOp/seAqrS36TOyUhYqt9N4nW1IxkSNCJ2X/1SO/4szn1N4gQpUhFGztW9iYniONaboRluloBOY5UbRR7QBTDA0RGD1SMkxwDlbAX+q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHI9iAWs; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-787c0f5eaa2so277639585a.2;
        Wed, 28 Feb 2024 07:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709135608; x=1709740408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIDnf1PHJx3sTXqk87lHy0TgMcK6QOT3xFVusv97ZYU=;
        b=aHI9iAWsbfbx8Wjavdemvbn7+4VToAVU/bGiLpi8Xst3xuPIYQ8eaXdWhdDs2tSM2n
         weEuIxWuL8yWyWwq6uIt645Xx56iM5hfRYbKARryO21WAU6acWsWjuVsVDmMshQUjh16
         fGTPcttrs4K21wxBtCXXA0IDmj6Gd0Sp9FYomjF1cM/wCx+FXVXpJ3HYRGbhDAOJWd/I
         p6onj7FIa3f7Z0AKLKO7y8uJXWiYAQXvx/WK5OJvSnfywVicFL5mJoiktLeNU0s0U7Aw
         8vBEkHE2t5t059f09fqoVRhGI1+87ai2ePS+reTz1SEJmdIZtTc+WPV9YepBWFkuTx1Q
         oEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709135608; x=1709740408;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZIDnf1PHJx3sTXqk87lHy0TgMcK6QOT3xFVusv97ZYU=;
        b=vpwStlvX+SyPtqZJJodZNXxN7bOlUO6iDfrjM7E3Erjl8uilhkmvJQL6/u9mnEASLb
         wpPjzw0qlY44QV/lfVQj4qaFzBMy2UVT02kCBmh/qpPcNp90UsdWa+XNnrqchTxAgWHs
         hN/Bzs2Bvw4drx+5IVVVOFjLAQv8Ma8d3o73EQNHmSEl09p6vzTzu5lBKub+3Us1WdNx
         f0fCkTwirAP6P7eRYJl2FCxSRwOs5fnAAwzwadXuzuT0mkN5naN99OcGS+BToBU8knqW
         /3h5MM0MymQBNWH3tyIWy96fCaL80x5VzxbdbntS+UuO43r1CtU/ZkpVcmGV7OMc8O+b
         D+pA==
X-Forwarded-Encrypted: i=1; AJvYcCUEBWkf7EXmmxP12Rf0dhOZUVm4Ac7R5Sm5QjzGhtvlOB+0Wj7jU0BFsriqNL1bnBwcoSALlA8jWuaCQSQfh7YTr7m9lgE/0bt4nltl+32sDDaYwetEO7co7/sRN5UBnv37YZXt
X-Gm-Message-State: AOJu0YyTJilI+EOhPuClVHFLjbzJFh36Nv7QKvI9jp+Cs9Ad9AX7Ct6V
	AgSNQ6XXAmZdafST+hc2OLvzKDic7WR/I/+1EdOYkr+vD2V+H8O+
X-Google-Smtp-Source: AGHT+IFcEbvcpP91r/stBplTZethfI8XHdi4ITQFqgC3QA0aLhTDZCJgnn1/FTBIOyyPFfyhOdCl7g==
X-Received: by 2002:a05:620a:1595:b0:785:c9d1:547d with SMTP id d21-20020a05620a159500b00785c9d1547dmr5451333qkk.78.1709135607586;
        Wed, 28 Feb 2024 07:53:27 -0800 (PST)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id z8-20020ae9c108000000b00787d46d606csm3054496qki.128.2024.02.28.07.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 07:53:27 -0800 (PST)
Date: Wed, 28 Feb 2024 10:53:26 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: kernel@quicinc.com
Message-ID: <65df56f6ba002_7162829435@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240228011219.1119105-1-quic_abchauha@quicinc.com>
References: <20240228011219.1119105-1-quic_abchauha@quicinc.com>
Subject: Re: [PATCH net-next v2] net: Modify mono_delivery_time with
 clockid_delivery_time
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Abhishek Chauhan wrote:
> Bridge driver today has no support to forward the userspace timestamp
> packets and ends up resetting the timestamp. ETF qdisc checks the
> packet coming from userspace and encounters to be 0 thereby dropping
> time sensitive packets. These changes will allow userspace timestamps
> packets to be forwarded from the bridge to NIC drivers.
> 
> Existing functionality of mono_delivery_time is not altered here
> instead just extended with userspace tstamp support for bridge
> forwarding path.
> 
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---
> Changes since v1 
> - Changed the commit subject as i am modifying the mono_delivery_time 
>   bit with clockid_delivery_time.
> - Took care of suggestion mentioned by Willem to use the same bit for 
>   userspace delivery time as there are no conflicts between TCP and 
>   SCM_TXTIME, because explicit cmsg makes no sense for TCP and only
>   RAW and DGRAM sockets interprets it.

The variable rename churn makes it hard to spot the functional
changes. Perhaps it makes sense just keep the variable name as is,
even though the "mono" is not always technically correct anymore.

Or else to split into two patches. One that renames the field.
And one that adds the new behavior of setting the bit for SO_TXTIME.

Sidenote: with sk_clockid, FQ could detect when skb->tstamp is not
set in monotonic (i.e., set by SO_TXTIME) and drop the packet or
ignore the embedded timestamp, warn, etc.

> - Clear explaination of why this is needed mentioned below and this 
>   is extending the work done by Martin for mono_delivery_time 
>   https://patchwork.kernel.org/project/netdevbpf/patch/20220302195525.3480280-1-kafai@fb.com/
> - Version 1 patch can be referenced with below link which states 
>   the exact problem with tc-etf and discussions which took place
>   https://lore.kernel.org/all/20240215215632.2899370-1-quic_abchauha@quicinc.com/
> 
>  include/linux/skbuff.h                     | 22 +++++++++++++---------
>  net/bridge/netfilter/nf_conntrack_bridge.c |  2 +-
>  net/core/dev.c                             |  2 +-
>  net/core/filter.c                          |  6 +++---
>  net/ieee802154/6lowpan/reassembly.c        |  2 +-
>  net/ipv4/inet_fragment.c                   |  2 +-
>  net/ipv4/ip_fragment.c                     |  2 +-
>  net/ipv4/ip_output.c                       | 13 +++++++++++--
>  net/ipv4/raw.c                             |  9 +++++++++
>  net/ipv6/ip6_output.c                      | 12 ++++++++++--
>  net/ipv6/netfilter.c                       |  2 +-
>  net/ipv6/netfilter/nf_conntrack_reasm.c    |  2 +-
>  net/ipv6/raw.c                             | 10 +++++++++-
>  net/ipv6/reassembly.c                      |  2 +-
>  net/sched/act_bpf.c                        |  4 ++--
>  net/sched/cls_bpf.c                        |  4 ++--
>  16 files changed, 67 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 2dde34c29203..24a34d56cfa3 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -816,10 +816,14 @@ typedef unsigned char *sk_buff_data_t;
>   *	@dst_pending_confirm: need to confirm neighbour
>   *	@decrypted: Decrypted SKB
>   *	@slow_gro: state present at GRO time, slower prepare step required
> - *	@mono_delivery_time: When set, skb->tstamp has the
> + *	@clockid_delivery_time: When set, skb->tstamp has the
>   *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the

This is not true anymore. Perhaps "delivery_time in sk_clockid clock base"

>   *		skb->tstamp has the (rcv) timestamp at ingress and
>   *		delivery_time at egress.
> + *		This bit is also set if the tstamp is set from userspace which
> + *		acts as an information in the bridge forwarding path to net
> + *		reset the tstamp value when user sets the timestamp using
> + *		SO_TXTIME sockopts
>   *	@napi_id: id of the NAPI struct this skb came from
>   *	@sender_cpu: (aka @napi_id) source CPU in XPS
>   *	@alloc_cpu: CPU which did the skb allocation.
> @@ -950,7 +954,7 @@ struct sk_buff {
>  	/* private: */
>  	__u8			__mono_tc_offset[0];
>  	/* public: */
> -	__u8			mono_delivery_time:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
> +	__u8			clockid_delivery_time:1; /* See SKB_MONO_DELIVERY_TIME_MASK */
>  #ifdef CONFIG_NET_XGRESS
>  	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
>  	__u8			tc_skip_classify:1;
> @@ -4172,7 +4176,7 @@ static inline void skb_get_new_timestampns(const struct sk_buff *skb,
>  static inline void __net_timestamp(struct sk_buff *skb)
>  {
>  	skb->tstamp = ktime_get_real();
> -	skb->mono_delivery_time = 0;
> +	skb->clockid_delivery_time = 0;
>  }
>  
>  static inline ktime_t net_timedelta(ktime_t t)
> @@ -4184,7 +4188,7 @@ static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
>  					 bool mono)
>  {
>  	skb->tstamp = kt;
> -	skb->mono_delivery_time = kt && mono;
> +	skb->clockid_delivery_time = kt && mono;
>  }
>  
>  DECLARE_STATIC_KEY_FALSE(netstamp_needed_key);
> @@ -4194,8 +4198,8 @@ DECLARE_STATIC_KEY_FALSE(netstamp_needed_key);
>   */
>  static inline void skb_clear_delivery_time(struct sk_buff *skb)
>  {
> -	if (skb->mono_delivery_time) {
> -		skb->mono_delivery_time = 0;
> +	if (skb->clockid_delivery_time) {
> +		skb->clockid_delivery_time = 0;
>  		if (static_branch_unlikely(&netstamp_needed_key))
>  			skb->tstamp = ktime_get_real();
>  		else
> @@ -4205,7 +4209,7 @@ static inline void skb_clear_delivery_time(struct sk_buff *skb)
>  
>  static inline void skb_clear_tstamp(struct sk_buff *skb)
>  {
> -	if (skb->mono_delivery_time)
> +	if (skb->clockid_delivery_time)
>  		return;
>  
>  	skb->tstamp = 0;
> @@ -4213,7 +4217,7 @@ static inline void skb_clear_tstamp(struct sk_buff *skb)
>  
>  static inline ktime_t skb_tstamp(const struct sk_buff *skb)
>  {
> -	if (skb->mono_delivery_time)
> +	if (skb->clockid_delivery_time)
>  		return 0;
>  
>  	return skb->tstamp;
> @@ -4221,7 +4225,7 @@ static inline ktime_t skb_tstamp(const struct sk_buff *skb)
>  
>  static inline ktime_t skb_tstamp_cond(const struct sk_buff *skb, bool cond)
>  {
> -	if (!skb->mono_delivery_time && skb->tstamp)
> +	if (!skb->clockid_delivery_time && skb->tstamp)
>  		return skb->tstamp;
>  
>  	if (static_branch_unlikely(&netstamp_needed_key) || cond)
> diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
> index abb090f94ed2..cfc9eeaf23fb 100644
> --- a/net/bridge/netfilter/nf_conntrack_bridge.c
> +++ b/net/bridge/netfilter/nf_conntrack_bridge.c
> @@ -32,7 +32,7 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
>  					   struct sk_buff *))
>  {
>  	int frag_max_size = BR_INPUT_SKB_CB(skb)->frag_max_size;
> -	bool mono_delivery_time = skb->mono_delivery_time;
> +	bool mono_delivery_time = skb->clockid_delivery_time;
>  	unsigned int hlen, ll_rs, mtu;
>  	ktime_t tstamp = skb->tstamp;
>  	struct ip_frag_state state;
> diff --git a/net/core/dev.c b/net/core/dev.c
> index bd230ce8fa79..2d6556444f55 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -2137,7 +2137,7 @@ EXPORT_SYMBOL(net_disable_timestamp);
>  static inline void net_timestamp_set(struct sk_buff *skb)
>  {
>  	skb->tstamp = 0;
> -	skb->mono_delivery_time = 0;
> +	skb->clockid_delivery_time = 0;
>  	if (static_branch_unlikely(&netstamp_needed_key))
>  		skb->tstamp = ktime_get_real();
>  }
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 524adf1fa6d0..c653cff185cb 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7698,13 +7698,13 @@ BPF_CALL_3(bpf_skb_set_tstamp, struct sk_buff *, skb,
>  		if (!tstamp)
>  			return -EINVAL;
>  		skb->tstamp = tstamp;
> -		skb->mono_delivery_time = 1;
> +		skb->clockid_delivery_time = 1;
>  		break;
>  	case BPF_SKB_TSTAMP_UNSPEC:
>  		if (tstamp)
>  			return -EINVAL;
>  		skb->tstamp = 0;
> -		skb->mono_delivery_time = 0;
> +		skb->clockid_delivery_time = 0;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -9413,7 +9413,7 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
>  					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK);
>  		*insn++ = BPF_JMP32_IMM(BPF_JNE, tmp_reg,
>  					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 2);
> -		/* skb->tc_at_ingress && skb->mono_delivery_time,
> +		/* skb->tc_at_ingress && skb->clockid_delivery_time,
>  		 * read 0 as the (rcv) timestamp.
>  		 */
>  		*insn++ = BPF_MOV64_IMM(value_reg, 0);
> diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
> index 6dd960ec558c..651ca0a81e61 100644
> --- a/net/ieee802154/6lowpan/reassembly.c
> +++ b/net/ieee802154/6lowpan/reassembly.c
> @@ -130,7 +130,7 @@ static int lowpan_frag_queue(struct lowpan_frag_queue *fq,
>  		goto err;
>  
>  	fq->q.stamp = skb->tstamp;
> -	fq->q.mono_delivery_time = skb->mono_delivery_time;
> +	fq->q.mono_delivery_time = skb->clockid_delivery_time;
>  	if (frag_type == LOWPAN_DISPATCH_FRAG1)
>  		fq->q.flags |= INET_FRAG_FIRST_IN;
>  
> diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
> index 7072fc0783ef..71958ea6ffd6 100644
> --- a/net/ipv4/inet_fragment.c
> +++ b/net/ipv4/inet_fragment.c
> @@ -578,7 +578,7 @@ void inet_frag_reasm_finish(struct inet_frag_queue *q, struct sk_buff *head,
>  	skb_mark_not_on_list(head);
>  	head->prev = NULL;
>  	head->tstamp = q->stamp;
> -	head->mono_delivery_time = q->mono_delivery_time;
> +	head->clockid_delivery_time = q->mono_delivery_time;
>  }
>  EXPORT_SYMBOL(inet_frag_reasm_finish);
>  
> diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
> index a4941f53b523..6f41fdfda84e 100644
> --- a/net/ipv4/ip_fragment.c
> +++ b/net/ipv4/ip_fragment.c
> @@ -355,7 +355,7 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
>  		qp->iif = dev->ifindex;
>  
>  	qp->q.stamp = skb->tstamp;
> -	qp->q.mono_delivery_time = skb->mono_delivery_time;
> +	qp->q.mono_delivery_time = skb->clockid_delivery_time;
>  	qp->q.meat += skb->len;
>  	qp->ecn |= ecn;
>  	add_frag_mem_limit(qp->q.fqdir, skb->truesize);
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 5b5a0adb927f..1b31171b58a4 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -764,7 +764,7 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>  {
>  	struct iphdr *iph;
>  	struct sk_buff *skb2;
> -	bool mono_delivery_time = skb->mono_delivery_time;
> +	bool mono_delivery_time = skb->clockid_delivery_time;
>  	struct rtable *rt = skb_rtable(skb);
>  	unsigned int mtu, hlen, ll_rs;
>  	struct ip_fraglist_iter iter;
> @@ -1455,6 +1455,15 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
>  	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
>  	skb->mark = cork->mark;
>  	skb->tstamp = cork->transmit_time;
> +	/* TX timestamp from userspace can be set by setting SO_TXTIME flag
> +	 * Once userspace sets the SO_TXTIME flag internally SOCK_TXTIME is set
> +	 * So we are setting the clockid_delivery_time based on if SOCK_TXTIME is
> +	 * set or not.
> +	 * Note:- the reason why we cannot use clockid to set the bool flag
> +	 * is because if userspace sets Monotonic clocks the macro value for
> +	 * monotonic clocks is 0 and !!clockid will return 0 for monotonic.
> +	 */

Let's avoid such long comments duplicated across multiple locations.

> +	skb->clockid_delivery_time = sock_flag(sk, SOCK_TXTIME);

	skb->clockid_delivery_time = !!cork->transmit_time;

>  	/*
>  	 * Steal rt from cork.dst to avoid a pair of atomic_inc/atomic_dec
>  	 * on dst refcount
> @@ -1646,7 +1655,7 @@ void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
>  			  arg->csumoffset) = csum_fold(csum_add(nskb->csum,
>  								arg->csum));
>  		nskb->ip_summed = CHECKSUM_NONE;
> -		nskb->mono_delivery_time = !!transmit_time;
> +		nskb->clockid_delivery_time = !!transmit_time;
>  		if (txhash)
>  			skb_set_hash(nskb, txhash, PKT_HASH_TYPE_L4);
>  		ip_push_pending_frames(sk, &fl4);
> diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
> index aea89326c697..6ade217c4251 100644
> --- a/net/ipv4/raw.c
> +++ b/net/ipv4/raw.c
> @@ -353,6 +353,15 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
>  	skb->priority = READ_ONCE(sk->sk_priority);
>  	skb->mark = sockc->mark;
>  	skb->tstamp = sockc->transmit_time;
> +	/* TX timestamp from userspace can be set by setting SO_TXTIME flag
> +	 * Once userspace sets the SO_TXTIME flag internally SOCK_TXTIME is set
> +	 * So we are setting the clockid_delivery_time based on if SOCK_TXTIME is
> +	 * set or not.
> +	 * Note:- the reason why we cannot use clockid to set the bool flag
> +	 * is because if userspace sets Monotonic clocks the macro value for
> +	 * monotonic clocks is 0 and !!clockid will return 0 for monotonic.
> +	 */
> +	skb->clockid_delivery_time = sock_flag(sk, SOCK_TXTIME);
>  	skb_dst_set(skb, &rt->dst);
>  	*rtp = NULL;
>  
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index a722a43dd668..e4548e395c3d 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -859,7 +859,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>  	struct rt6_info *rt = (struct rt6_info *)skb_dst(skb);
>  	struct ipv6_pinfo *np = skb->sk && !dev_recursion_level() ?
>  				inet6_sk(skb->sk) : NULL;
> -	bool mono_delivery_time = skb->mono_delivery_time;
> +	bool mono_delivery_time = skb->clockid_delivery_time;
>  	struct ip6_frag_state state;
>  	unsigned int mtu, hlen, nexthdr_offset;
>  	ktime_t tstamp = skb->tstamp;
> @@ -1922,7 +1922,15 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
>  	skb->priority = READ_ONCE(sk->sk_priority);
>  	skb->mark = cork->base.mark;
>  	skb->tstamp = cork->base.transmit_time;
> -
> +	/* TX timestamp from userspace can be set by setting SO_TXTIME flag
> +	 * Once userspace sets the SO_TXTIME flag internally SOCK_TXTIME is set
> +	 * So we are setting the clockid_delivery_time based on if SOCK_TXTIME is
> +	 * set or not.
> +	 * Note:- the reason why we cannot use clockid to set the bool flag
> +	 * is because if userspace sets Monotonic clocks the macro value for
> +	 *  monotonic clocks is 0 and !!clockid will return 0 for monotonic.
> +	 */
> +	skb->clockid_delivery_time = sock_flag(sk, SOCK_TXTIME);
>  	ip6_cork_steal_dst(skb, cork);
>  	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTREQUESTS);
>  	if (proto == IPPROTO_ICMPV6) {
> diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
> index 53d255838e6a..33bc6b0f3b13 100644
> --- a/net/ipv6/netfilter.c
> +++ b/net/ipv6/netfilter.c
> @@ -126,7 +126,7 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>  				  struct sk_buff *))
>  {
>  	int frag_max_size = BR_INPUT_SKB_CB(skb)->frag_max_size;
> -	bool mono_delivery_time = skb->mono_delivery_time;
> +	bool mono_delivery_time = skb->clockid_delivery_time;
>  	ktime_t tstamp = skb->tstamp;
>  	struct ip6_frag_state state;
>  	u8 *prevhdr, nexthdr = 0;
> diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
> index b2dd48911c8d..65cdc41c2bba 100644
> --- a/net/ipv6/netfilter/nf_conntrack_reasm.c
> +++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
> @@ -264,7 +264,7 @@ static int nf_ct_frag6_queue(struct frag_queue *fq, struct sk_buff *skb,
>  		fq->iif = dev->ifindex;
>  
>  	fq->q.stamp = skb->tstamp;
> -	fq->q.mono_delivery_time = skb->mono_delivery_time;
> +	fq->q.mono_delivery_time = skb->clockid_delivery_time;
>  	fq->q.meat += skb->len;
>  	fq->ecn |= ecn;
>  	if (payload_len > fq->q.max_size)
> diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
> index 03dbb874c363..1b95ccb50066 100644
> --- a/net/ipv6/raw.c
> +++ b/net/ipv6/raw.c
> @@ -616,7 +616,15 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
>  	skb->priority = READ_ONCE(sk->sk_priority);
>  	skb->mark = sockc->mark;
>  	skb->tstamp = sockc->transmit_time;
> -
> +	/* TX timestamp from userspace can be set by setting SO_TXTIME flag
> +	 * Once userspace sets the SO_TXTIME flag internally SOCK_TXTIME is set
> +	 * So we are setting the clockid_delivery_time based on if SOCK_TXTIME is
> +	 * set or not.
> +	 * Note:- the reason why we cannot use clockid to set the bool flag
> +	 * is because if userspace sets Monotonic clocks the macro value for
> +	 * monotonic clocks is 0 and !!clockid will return 0 for monotonic.
> +	 */
> +	skb->clockid_delivery_time = sock_flag(sk, SOCK_TXTIME);
>  	skb_put(skb, length);
>  	skb_reset_network_header(skb);
>  	iph = ipv6_hdr(skb);
> diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
> index 5ebc47da1000..ad0e6832b199 100644
> --- a/net/ipv6/reassembly.c
> +++ b/net/ipv6/reassembly.c
> @@ -198,7 +198,7 @@ static int ip6_frag_queue(struct frag_queue *fq, struct sk_buff *skb,
>  		fq->iif = dev->ifindex;
>  
>  	fq->q.stamp = skb->tstamp;
> -	fq->q.mono_delivery_time = skb->mono_delivery_time;
> +	fq->q.mono_delivery_time = skb->clockid_delivery_time;
>  	fq->q.meat += skb->len;
>  	fq->ecn |= ecn;
>  	add_frag_mem_limit(fq->q.fqdir, skb->truesize);
> diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
> index 0e3cf11ae5fc..47f46fcb1827 100644
> --- a/net/sched/act_bpf.c
> +++ b/net/sched/act_bpf.c
> @@ -54,8 +54,8 @@ TC_INDIRECT_SCOPE int tcf_bpf_act(struct sk_buff *skb,
>  		bpf_compute_data_pointers(skb);
>  		filter_res = bpf_prog_run(filter, skb);
>  	}
> -	if (unlikely(!skb->tstamp && skb->mono_delivery_time))
> -		skb->mono_delivery_time = 0;
> +	if (unlikely(!skb->tstamp && skb->clockid_delivery_time))
> +		skb->clockid_delivery_time = 0;
>  	if (skb_sk_is_prefetched(skb) && filter_res != TC_ACT_OK)
>  		skb_orphan(skb);
>  
> diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
> index 5e83e890f6a4..fc85a7619f07 100644
> --- a/net/sched/cls_bpf.c
> +++ b/net/sched/cls_bpf.c
> @@ -104,8 +104,8 @@ TC_INDIRECT_SCOPE int cls_bpf_classify(struct sk_buff *skb,
>  			bpf_compute_data_pointers(skb);
>  			filter_res = bpf_prog_run(prog->filter, skb);
>  		}
> -		if (unlikely(!skb->tstamp && skb->mono_delivery_time))
> -			skb->mono_delivery_time = 0;
> +		if (unlikely(!skb->tstamp && skb->clockid_delivery_time))
> +			skb->clockid_delivery_time = 0;
>  
>  		if (prog->exts_integrated) {
>  			res->class   = 0;
> -- 
> 2.25.1
> 



