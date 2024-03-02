Return-Path: <linux-kernel+bounces-89427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E05686F03B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 12:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A656284952
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 11:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBD017557;
	Sat,  2 Mar 2024 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ITZAyO9M"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E2E15E9C;
	Sat,  2 Mar 2024 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709378633; cv=none; b=Szf5GvlJCYKrixjE7f6VrBPqiyYN8tjcqRsD5FGGPEn6vus3QMqLDxpuB0RvW1uqPLRKSzBMQhjnUZu2B8Buk1wfV+9Fj4PaOWriuq6kTeNvQr8HRehTt1V77GEUgWpVNMisXBzp1Ralf9wMIshU8GeXfTMOMMHyeXZTcI/3HJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709378633; c=relaxed/simple;
	bh=vz0STiFuGpGIPB7MVHeAstWUf1yFWHgemuVe+gtmqWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=czsRsQS0MPzjYJLmaGMkd+wuNivq6/0Qigw8pltkodyyViBevIfr4+JEA7OJ8Sw2eil3kGl3y3nxy8jDlHc/CG1x6iJu0uBxck+g1LaTmE+WxA+LoDkYUx8QpjQ9ZBpr36j50bi43pNG3kKVEMb1MxzLpNqnacMv0F9wRWOlhBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ITZAyO9M; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=txL5b
	BbeQ7LPGE1ean4mj7MJFW+6ma0NRx/geVN9Ohg=; b=ITZAyO9Mi5oRSYWvIU5Cj
	ouxPJsiPzLkYVzJpaNC5ncmbR9bMxeh+e9Lrg9upHMdaxL5SZvrKpb2cqaqROQyZ
	UZkd9luMTsi9zgpKxe1YSSs0HuoX/VDNnm8WsmkwmcAczWGr64yY9+Zn49Sme1Ah
	nXrIlsSfjWo0GUpZ2nlpb0=
Received: from hpl-virtual-machine.. (unknown [117.173.176.146])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3H9nlC+NloshVFA--.24235S2;
	Sat, 02 Mar 2024 19:22:13 +0800 (CST)
From: He Peilin <peilinhe2020@163.com>
To: rostedt@goodmis.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	he.peilin@zte.com.cn,
	jiang.xuexin@zte.com.cn,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	liu.chun2@zte.com.cn,
	mhiramat@kernel.org,
	netdev@vger.kernel.org,
	xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn,
	zhang.yunkai@zte.com.cn
Subject: Re: Re: [PATCH] net/ipv4: add tracepoint for icmp_send
Date: Sat,  2 Mar 2024 06:22:12 -0500
Message-Id: <20240302112212.8962-1-peilinhe2020@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227090705.1ed08b64@gandalf.local.home>
References: <20240227090705.1ed08b64@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H9nlC+NloshVFA--.24235S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw4fWFWUur43WF4kGr43trb_yoW5AF15pF
	1DAFZYgFZ7Jr47uw1Svw1ft3ZIv348uryUKr42ga4jk3Z2yr1xJr4qgr90kF95Ars0kryY
	vF42v3sxG3WYqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jf0ePUUUUU=
X-CM-SenderInfo: xshlzxhqkhjiisq6il2tof0z/1tbiGAuVsWVOBFnVRQAAsR

> >  include/trace/events/icmp.h | 57 +++++++++++++++++++++++++++++++++++++++++++++
> >  net/ipv4/icmp.c             |  4 ++++
> >  2 files changed, 61 insertions(+)
> >  create mode 100644 include/trace/events/icmp.h
> > 
> > diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
> > new file mode 100644
> > index 000000000000..3d9af5769bc3
> > --- /dev/null
> > +++ b/include/trace/events/icmp.h
> > @@ -0,0 +1,57 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM icmp
> > +
> > +#if !defined(_TRACE_ICMP_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_ICMP_H
> > +
> > +#include <linux/icmp.h>
> > +#include <linux/tracepoint.h>
> > +
> > +TRACE_EVENT(icmp_send,
> > +
> > +		TP_PROTO(const struct sk_buff *skb, int type, int code),
> > +
> > +		TP_ARGS(skb, type, code),
> > +
> > +		TP_STRUCT__entry(
> > +				__field(__u16, sport)
> 
> 2 bytes
> 
> > +				__field(__u16, dport)
> 
> 2 bytes
> 
> > +				__field(unsigned short, ulen)
> 
> 2 bytes
> 
> [ 2 byte hole for alignment ]
> 
> > +				__field(const void *, skbaddr)
> 
> 4/8 bytes
> 
> It's best to keep the holes at the end of the TP_STRUCT__entry().
> 
> That is, I would move ulen to the end of the structure. It doesn't affect
> anything else.
> 
> -- Steve
Thank you for pointing that out. The next step is to move __field(unsigned short, ulen) to the end of TP_STRUCT__entry().

> 
> > +				__field(int, type)
> > +				__field(int, code)
> > +				__array(__u8, saddr, 4)
> > +				__array(__u8, daddr, 4)
> > +		),
> > +
> > +		TP_fast_assign(
> > +				// Get UDP header
> > +				struct udphdr *uh = udp_hdr(skb);
> > +				struct iphdr *iph = ip_hdr(skb);
> > +				__be32 *p32;
> > +
> > +				__entry->sport = ntohs(uh->source);
> > +				__entry->dport = ntohs(uh->dest);
> > +				__entry->ulen = ntohs(uh->len);
> > +				__entry->skbaddr = skb;
> > +				__entry->type = type;
> > +				__entry->code = code;
> > +
> > +				p32 = (__be32 *) __entry->saddr;
> > +				*p32 = iph->saddr;
> > +
> > +				p32 = (__be32 *) __entry->daddr;
> > +				*p32 =  iph->daddr;
> > +		),
> > +
> > +		TP_printk("icmp_send: type=%d, code=%d. From %pI4:%u to %pI4:%u ulen=%d skbaddr=%p",
> > +			__entry->type, __entry->code,
> > +			__entry->saddr, __entry->sport, __entry->daddr,
> > +			__entry->dport, __entry->ulen, __entry->skbaddr)
> > +);
> > +
> > +#endif /* _TRACE_ICMP_H */
> > +
> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
> > diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> > index e63a3bf99617..437bdb7e2650 100644
> > --- a/net/ipv4/icmp.c
> > +++ b/net/ipv4/icmp.c
> > @@ -92,6 +92,8 @@
> >  #include <net/inet_common.h>
> >  #include <net/ip_fib.h>
> >  #include <net/l3mdev.h>
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/icmp.h>
> > 
> >  /*
> >   *	Build xmit assembly blocks
> > @@ -599,6 +601,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
> >  	struct net *net;
> >  	struct sock *sk;
> > 
> > +	trace_icmp_send(skb_in, type, code);
> > +
> >  	if (!rt)
> >  		goto out;
> >  


