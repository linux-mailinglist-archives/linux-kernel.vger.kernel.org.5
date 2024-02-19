Return-Path: <linux-kernel+bounces-71676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213E485A8E3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16D228550B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4C33D0A6;
	Mon, 19 Feb 2024 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvjBBPtd"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035512D022;
	Mon, 19 Feb 2024 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708360007; cv=none; b=ili1rBeKke1Ggn9JKn0fzBZPtmkutxBdKaYp3ZLwXB/Y7GjDMsEY9r+QphyD7eh9XSf/UevkV4p3UVjWmlwKg9GvTtwtuhJWfOpWMLDARhWMwKE3INZvgQt3A5d8B5dPyt/88UOIRc4cV9JuKJQVQ0N6dXU5aeQ/6mpSpjqtG4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708360007; c=relaxed/simple;
	bh=8dt5ype8OL1dmdJY7mArcqkBLxYdb+zANhqLl+EaYAI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YCQED30k5cHH6NnzYqGLf/3tT+aN2+1Q7z0TX2ANjl8H3kNXM0HShe6SoGF4X3V2YUby6g3RgqZI23jcH6YHe/7BdxmrpwiZ9xH2IbFrvFvTkosaqTAxCsOuN9W1fRnEQanAY59zqHLKgRj8RfS6SEo7yASzvVojHVYXngrWH/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvjBBPtd; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d5bbbe5844so2261430241.0;
        Mon, 19 Feb 2024 08:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708360005; x=1708964805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yEMvviGWzA9iz/1fXccw1ZhHyZkwzRl3qTl7iW/kIA=;
        b=fvjBBPtdv9TaeUQChvOuB5gtLlnUwSiwJSTA070l9xllUIk/o/RB9evuSIc9R0zsym
         qCC4M8mJTD1vRC8iQJlbSAK0lWbIVrKbTaF7VWak/xAWQSrsAN0sDKHIEwFs1hF6/rvs
         JDW9/Lj2FPRP7lHVn1ufFTL0P9VrWN3fMacMdcsJfA39ZZQPyTja+9MOBY+ze+EYdHug
         zm6N6ZleDHh5Kip5kWt2gVPC3BSFd/AvQ8FFSQTxwjzD/i2avbOEJvgSrirDmi5AD1Pk
         fpcQJC/OwuPfBagHhCb6/iBLb7woZZ9lxff9jOfAnG/xaOJavyfxIQ3spdsEzp2UZU0n
         OHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708360005; x=1708964805;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1yEMvviGWzA9iz/1fXccw1ZhHyZkwzRl3qTl7iW/kIA=;
        b=NJ1DdQHHi5kmPHWQHD3+BNANtdzusj1bKJ7cyaX7X6H6m7LZrzehe5LyGCGineYODQ
         Fpz3qnItfi3SwGCcaDGHGXC0wFeb5o7Pr5ph/XspmWIxlvwTIVbMZSKgvkIgjIBHxcPE
         9fzHFWyS5YVkor9sPCqM7Eq3n3W2XYFLNm1Cjxj20FrVmBdtK8LG/5lPrpmo0bljeQTD
         Bo1qtvkJt0iS19ZSQ8CvyWzG7iTHws7D1B3WNfz6C+MkHPWfd+FGgy/XEn79uaql6O6f
         r0Eq6PVJPXLp72hEOAi5er8rgGznEbj/9g3cuWwPpU1nOBUbHQiqSJwCjHgv23cWa7gj
         IJ1A==
X-Forwarded-Encrypted: i=1; AJvYcCVB1OHms26D48zfOiPUhyN7rqrhCNuiNegCV+3pQco3eao9mbFotWfWAfu7DgOKGauR8mstiAG3fxeuFV7TLxrZnSkYi87YD4/v/my6pftxZUI96M6ntZUkHfhK7e9UskBi5yow
X-Gm-Message-State: AOJu0Yxqql/3D27iBJrVqf6U81d2FKZV0Bundn2d6V5Mb/1PZew4J1Ke
	UOjUh7HbpYc63pJkRC088mvvEu68okK+m6Yj/seSK+vMgPFzxkgV
X-Google-Smtp-Source: AGHT+IFuocHd8ZoFskuytdIJKHO9iDxqwnqFCHET3jsQaL+U6fX2LIpZ8vl7/Q4pIZ8BNDoG1TNahw==
X-Received: by 2002:a1f:c406:0:b0:4c8:e5a0:4222 with SMTP id u6-20020a1fc406000000b004c8e5a04222mr2592531vkf.12.1708360004799;
        Mon, 19 Feb 2024 08:26:44 -0800 (PST)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id mf4-20020a0562145d8400b0068f5de5d61csm1893481qvb.96.2024.02.19.08.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 08:26:44 -0800 (PST)
Date: Mon, 19 Feb 2024 11:26:44 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 martin.lau@linux.dev
Cc: kernel@quicinc.com
Message-ID: <65d381443c737_1f6b72294cd@willemb.c.googlers.com.notmuch>
In-Reply-To: <05998dfc-e7ec-420a-a0a8-c9284368b13c@quicinc.com>
References: <20240215215632.2899370-1-quic_abchauha@quicinc.com>
 <65cfa53c89e52_e53c9294ce@willemb.c.googlers.com.notmuch>
 <05998dfc-e7ec-420a-a0a8-c9284368b13c@quicinc.com>
Subject: Re: [PATCH net-next v1] net: Add skb user timestamp flag to
 distinguish between timestamps
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Abhishek Chauhan (ABC) wrote:
> 
> 
> On 2/16/2024 10:11 AM, Willem de Bruijn wrote:
> > Abhishek Chauhan wrote:
> >> Bridge driver today has no support to forward the userspace timestamp
> >> packets and ends up resetting the timestamp. ETF qdisc checks the
> >> packet coming from userspace and encounters to be 0 thereby dropping
> >> time sensitive packets. These changes will allow userspace timestamps
> >> packets to be forwarded from the bridge to NIC drivers.
> >>
> >> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> >> ---
> >> Note:- I am a little skeptical of using bool inside the skbuff
> >> structure as no one today has used bool so far in the struct.
> >> (Expecting some comments from upstream for sure) 
> >>
> >> I am also touching the heart of sk buff so i hope this is reviewed
> >> thoroughly. I have crossed checked multiple times on all the ipv4
> >> /ipv6 paths where userspace timestamp is populated. I tried as much
> >> as possible to cover all the references and made sure i put my changes
> >> in place.  
> >>
> >> Bug description:- If the physical network interface is bridged the 
> >> etf packets are dropped since bridge driver before forwarding the packet
> >> is setting the userspace timestamp to 0.
> >>
> >> Bridge driver call stack 
> >>
> >> [  157.120189] now is set to 1706054553072734733
> >> [  157.120194] tx time from SKB is 0 <== SKB when reaches the etf qdisc is 0 
> >> [  157.120195] q->last time is 0
> >> [  157.120197] CPU: 3 PID: 9206 Comm: a.out Tainted: G        W  OE  X  -------  ---  5.14.0-999.323ES.test.el9.aarch64 #1
> >> [  157.120201] Hardware name: Qualcomm SA8775P Ride (DT)
> >> [  157.120202] Call trace:
> >> [  157.120203]  dump_backtrace+0xb0/0x130
> >> [  157.120212]  show_stack+0x1c/0x30
> >> [  157.120215]  dump_stack_lvl+0x74/0x8c
> >> [  157.120220]  dump_stack+0x14/0x24
> >> [  157.120223]  etf_enqueue_timesortedlist+0x114/0x20c [sch_etf]
> >> [  157.120230]  dev_qdisc_enqueue+0x2c/0x110
> >> [  157.120234]  __dev_xmit_skb+0x114/0x644
> >> [  157.120236]  __dev_queue_xmit+0x31c/0x774
> >> [  157.120238]  br_dev_queue_push_xmit+0xd4/0x120 [bridge]
> >> [  157.120253]  br_forward_finish+0xdc/0xec [bridge]  <== This function is culprit as its making the tstamp as 0
> >> [root@ecbldauto-lvarm04-lnx ~]# [  157.120263]  __br_forward+0xd8/0x210 [bridge]
> >> [  157.120272]  br_forward+0x12c/0x150 [bridge]
> >> [  157.120281]  br_dev_xmit+0x288/0x49c [bridge]
> >> [  157.120290]  dev_hard_start_xmit+0xe4/0x2b4
> >> [  157.120292]  __dev_queue_xmit+0x6ac/0x774
> >> [  157.120294]  neigh_resolve_output+0x128/0x1ec
> >> [  157.120297]  ip_finish_output2+0x184/0x54c
> >> [  157.120300]  __ip_finish_output+0xa4/0x19c
> >> [  157.120302]  ip_finish_output+0x38/0xf0
> >> [  157.120303]  ip_output+0x13c/0x1f4
> >> [  157.120305]  ip_send_skb+0x54/0x10c
> >> [  157.120307]  udp_send_skb+0x128/0x394
> >> [  157.120310]  udp_sendmsg+0x7e8/0xa6c
> >> [  157.120311]  inet_sendmsg+0x48/0x70
> >> [  157.120313]  sock_sendmsg+0x54/0x60
> >> [  157.120315]  ____sys_sendmsg+0x1f8/0x254
> >> [  157.120316]  ___sys_sendmsg+0x84/0xcc
> >> [  157.120318]  __sys_sendmsg+0x60/0xb0
> >> [  157.120319]  __arm64_sys_sendmsg+0x28/0x30
> >> [  157.120320]  invoke_syscall.constprop.0+0x7c/0xd0
> >> [  157.120323]  el0_svc_common.constprop.0+0x140/0x150
> >> [  157.120325]  do_el0_svc+0x38/0xa0
> >> [  157.120327]  el0_svc+0x38/0x1d0
> >> [  157.120329]  el0t_64_sync_handler+0xb4/0x130
> >> [  157.120330]  el0t_64_sync+0x17c/0x180
> >>
> >> After my changes:- 
> >> [ 2215.130148] now is set to 1706056610952501031 
> >> [ 2215.130154] tx time from SKB is 1706056610953467393 <== Time is forwarded to etf correctly
> >> [ 2215.130155] q->last time is 1706056591423364609
> >> [ 2215.130158] CPU: 1 PID: 108166 Comm: a.out Tainted: G        W  OE  X  -------  ---  5.14.0-999.323ES.test.el9.aarch64 #1
> >> [ 2215.130162] Hardware name: Qualcomm SA8775P Ride (DT) [ 2215.130163] Call trace:
> >> [ 2215.130164]  dump_backtrace+0xb0/0x130 
> >> [ 2215.130172]  show_stack+0x1c/0x30 [root@ecbldauto-lvarm04-lnx ~]# 
> >> [ 2215.130175]  dump_stack_lvl+0x74/0x8c [ 2215.130181]  dump_stack+0x14/0x24 
> >> [ 2215.130184]  etf_enqueue_timesortedlist+0x114/0x20c [sch_etf] 
> >> [ 2215.130191]  dev_qdisc_enqueue+0x2c/0x110 
> >> [ 2215.130197]  __dev_xmit_skb+0x114/0x644 
> >> [ 2215.130200]  __dev_queue_xmit+0x31c/0x774 
> >> [ 2215.130202]  br_dev_queue_push_xmit+0xd4/0x120 [bridge] 
> >> [ 2215.130217]  br_forward_finish+0xe4/0xf0 [bridge] 
> >> [ 2215.130226]  __br_forward+0xd8/0x20c [bridge] 
> >> [ 2215.130235]  br_forward+0x12c/0x150 [bridge] 
> >> [ 2215.130243]  br_dev_xmit+0x288/0x49c [bridge] 
> >> [ 2215.130252]  dev_hard_start_xmit+0xe4/0x2b4 
> >> [ 2215.130254]  __dev_queue_xmit+0x6ac/0x774 
> >> [ 2215.130257]  neigh_hh_output+0xcc/0x140 
> >> [ 2215.130260]  ip_finish_output2+0x300/0x54c 
> >> [ 2215.130262]  __ip_finish_output+0xa4/0x19c 
> >> [ 2215.130263]  ip_finish_output+0x38/0xf0 
> >> [ 2215.130265]  ip_output+0x13c/0x1f4 
> >> [ 2215.130267]  ip_send_skb+0x54/0x110 
> >> [ 2215.130269]  udp_send_skb+0x128/0x394 
> >> [ 2215.130271]  udp_sendmsg+0x7e8/0xa6c 
> >> [ 2215.130272]  inet_sendmsg+0x48/0x70 
> >> [ 2215.130275]  sock_sendmsg+0x54/0x60 
> >> [ 2215.130277]  ____sys_sendmsg+0x1f8/0x254 
> >> [ 2215.130278]  ___sys_sendmsg+0x84/0xcc 
> >> [ 2215.130279]  __sys_sendmsg+0x60/0xb0 
> >> [ 2215.130281]  __arm64_sys_sendmsg+0x28/0x30 
> >> [ 2215.130282]  invoke_syscall.constprop.0+0x7c/0xd0
> >> [ 2215.130285]  el0_svc_common.constprop.0+0x140/0x150
> >> [ 2215.130287]  do_el0_svc+0x38/0xa0
> >> [ 2215.130289]  el0_svc+0x38/0x1d0
> >> [ 2215.130291]  el0t_64_sync_handler+0xb4/0x130 
> >> [ 2215.130292]  el0t_64_sync+0x17c/0x180
> >>
> >>
> >>  include/linux/skbuff.h  | 13 +++++++++++++
> >>  include/net/inet_sock.h |  1 +
> >>  include/net/sock.h      |  1 +
> >>  net/core/sock.c         |  1 +
> >>  net/ipv4/ip_output.c    |  3 +++
> >>  net/ipv4/raw.c          |  1 +
> >>  net/ipv6/ip6_output.c   |  2 ++
> >>  net/ipv6/raw.c          |  1 +
> >>  net/packet/af_packet.c  |  3 +++
> >>  9 files changed, 26 insertions(+)
> >>
> >> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> >> index 2dde34c29203..b098b7d30b56 100644
> >> --- a/include/linux/skbuff.h
> >> +++ b/include/linux/skbuff.h
> >> @@ -744,6 +744,7 @@ typedef unsigned char *sk_buff_data_t;
> >>   *	@tstamp: Time we arrived/left
> >>   *	@skb_mstamp_ns: (aka @tstamp) earliest departure time; start point
> >>   *		for retransmit timer
> >> + *	@user_delivery_time: states that timestamp was populated from userspace
> >>   *	@rbnode: RB tree node, alternative to next/prev for netem/tcp
> >>   *	@list: queue head
> >>   *	@ll_node: anchor in an llist (eg socket defer_list)
> >> @@ -879,6 +880,8 @@ struct sk_buff {
> >>  		ktime_t		tstamp;
> >>  		u64		skb_mstamp_ns; /* earliest departure time */
> >>  	};
> >> +	/* States that time is from userspace */
> >> +	bool            user_delivery_time;
> >>  	/*
> >>  	 * This is the control buffer. It is free to use for every
> >>  	 * layer. Please put your private variables there. If you
> >> @@ -4208,6 +4211,16 @@ static inline void skb_clear_tstamp(struct sk_buff *skb)
> >>  	if (skb->mono_delivery_time)
> >>  		return;
> >>  
> >> +	/* When userspace timestamp packets are forwarded via bridge
> >> +	 * the br_forward_finish clears the tstamp and the tstamp
> >> +	 * from the userspace is lost. Hence the check for user
> >> +	 * delivery time. With the below check now tc-etf qdisc will
> >> +	 * not end up dropping the packets if the packet is forwarded via
> >> +	 * bridge interface.
> >> +	 */
> >> +	if (skb->user_delivery_time)
> >> +		return;
> >> +
> >>  	skb->tstamp = 0;
> >>  }
> >>  
> >> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> >> index d94c242eb3ed..e7523545a493 100644
> >> --- a/include/net/inet_sock.h
> >> +++ b/include/net/inet_sock.h
> >> @@ -175,6 +175,7 @@ struct inet_cork {
> >>  	__u16			gso_size;
> >>  	u64			transmit_time;
> >>  	u32			mark;
> >> +	bool			user_delivery_time;
> >>  };
> > 
> > There's no need for a cork member, as by definition the fields in this
> > struct are coming from userspace.
> > 
> > There is a very high bar to adding new fields to sk_buff, because it
> > is used by many paths and would be enormous if stuck with fields for
> > every intersection between a pair of features.
> > 
> > The goal here is for the bridge to disambiguate earliest delivery time
> > timestamps from which? From those looped through ip forwarding? Why
> > does the bridge zero the tstamp field at all? That might help finding
> > a reasonable implementation.
> > 
> > We have run in the issue of labeling the value of skb->tstamp before.
> > With redirect and looping it is definitely subtle.
> 
> Thanks for your comments Willem,
> 
> There is a clear explanation of why this is needed as part of the below link 
> https://patchwork.kernel.org/project/netdevbpf/patch/20220302195525.3480280-1-kafai@fb.com/
>
> From the above link Martin KaFai Lau has mentioned and i quote. 
> 
> "In the future, another bit (e.g. skb->user_delivery_time) can be added
> for the SCM_TXTIME where the clock base is tracked by sk->sk_clockid."

Let's CC: Martin on this thread extending his work.

In some cases SO_TXTIME sets timestamps for in monotonic, for FQ.

The issue here is that it may set in against other clocks, such as
CLOCK_TAI for the ETF qdisc.

Instead of adding yet another rarely used bit to sk_buff, could we
modify the existing bit to be clockid_delivery_time, and default
sk_clockid to CLOCK_MONOTONIC for TCP?

There is no conflict between SCM_TXTIME and TCP, because the explicit
cmsg makes no sense for TCP and indeed only RAW and DGRAM sockets
interpret it.

