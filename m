Return-Path: <linux-kernel+bounces-108888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D938588116A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36580B229FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100283FB2A;
	Wed, 20 Mar 2024 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BnyhAii6"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A973D0A3;
	Wed, 20 Mar 2024 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710936004; cv=none; b=B+pJI3FukcA8O9P5p4JCroL30Dx3W1xyVaeOiIpjJjzq7jHPUINbZtTi/gtpdKTnLzZs7QO2pazMai8OcU9M8/tUhnX7Sc0l6dOi44e6YiaNrcx57lxT0oyfL/8fo0vufzEpSjeQjExYwDA1CVVeD/oVZ4NlAUfWQaEhuym8gkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710936004; c=relaxed/simple;
	bh=aCNMI2Ts9LsYP23ZKHhYEPaahd+dgT55EZua9O1LiII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BV7IkD/ZKctk9hjfGra3eYxQXmPXoiCbUhQ2LMqS2mo6WeRJbn496X+YssdmSZeAtZGbUsX2ODIjBkLUfTkCaXVz7NbkfkW8Valh8H4HxBPX43JIC+faYV7eSgVmQ64xOJacNPnJawm2FYUAeh4CTtEuezj+zxjdSKVgsWVrg1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BnyhAii6; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=gnuuJ
	lg8CyOIvFYxU93Jc0OBKTJisjjoUpkozAZz3Oo=; b=BnyhAii6r357MqKZ4AKxq
	C8KLWqo2VAAideDH/7tRynsv0OYS4opFPL8CJE/nt5FHnVt22RE2K0/nUuwNy9/z
	2TLQwfq2Xm6WNy9VTUMFn2Gx4S03CZ2Y3voMJqTRYIfajyCk1b0dD1ZhzLc9V18E
	jz0gIGQu1uGhmkHtuYZv2w=
Received: from hpl-virtual-machine.. (unknown [183.223.134.153])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wD3Pxmjz_plKabBAw--.1525S2;
	Wed, 20 Mar 2024 19:59:32 +0800 (CST)
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
Subject: Re: Re: [PATCH v2] net/ipv4: add tracepoint for icmp_send
Date: Wed, 20 Mar 2024 07:59:30 -0400
Message-Id: <20240320115930.7649-1-peilinhe2020@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319102549.7f7f6f53@gandalf.local.home>
References: <20240319102549.7f7f6f53@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Pxmjz_plKabBAw--.1525S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF1fAr1fCF15uFyrur4fGrg_yoW7AFy5pF
	yDAFyfKrs7trW7C34fu34aqF15u348uryUKryIqw12k3Wvvr1Utr4jgrn0kFyrCrs0k34a
	vF4qv345Gw1YqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jIOJnUUUUU=
X-CM-SenderInfo: xshlzxhqkhjiisq6il2tof0z/1tbiZQWnsWXAkoWOKQAAsj

> > From: Peilin He<he.peilin@zte.com.cn>
> > 
> > Introduce a tracepoint for icmp_send, which can help users to get more
> > detail information conveniently when icmp abnormal events happen.
> > 
> > 1. Giving an usecase example:
> > =============================
> > When an application experiences packet loss due to an unreachable UDP
> > destination port, the kernel will send an exception message through the
> > icmp_send function. By adding a trace point for icmp_send, developers or
> > system administrators can obtain detailed information about the UDP
> > packet loss, including the type, code, source address, destination address,
> > source port, and destination port. This facilitates the trouble-shooting
> > of UDP packet loss issues especially for those network-service
> > applications.
> > 
> > 2. Operation Instructions:
> > ==========================
> > Switch to the tracing directory.
> >         cd /sys/kernel/debug/tracing
> 
> FYI, that directory is obsolete. Please always reference /sys/kernel/tracing.
OK. 
> > Filter for destination port unreachable.
> >         echo "type==3 && code==3" > events/icmp/icmp_send/filter
> > Enable trace event.
> >         echo 1 > events/icmp/icmp_send/enable
> > 
> > 3. Result View:
> > ================
> >  udp_client_erro-11370   [002] ...s.12   124.728002:
> >  icmp_send: icmp_send: type=3, code=3.
> >  From 127.0.0.1:41895 to 127.0.0.1:6666 ulen=23
> >  skbaddr=00000000589b167a
> > 
> > v1->v2:
> > Some fixes according to
> > https://lore.kernel.org/all/CANn89iL-y9e_VFpdw=sZtRnKRu_tnUwqHuFQTJvJsv-nz1xPDw@mail.gmail.com/
> > 	1. adjust the trace_icmp_send() to more protocols than UDP.
> > 	2. move the calling of trace_icmp_send after sanity checks
> > 	   in __icmp_send().
> > 
> > Signed-off-by: Peilin He<he.peilin@zte.com.cn>
> > Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> > Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
> > Cc: Yang Yang <yang.yang29@zte.com.cn>
> > Cc: Liu Chun <liu.chun2@zte.com.cn>
> > Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> > ---
> >  include/trace/events/icmp.h | 64 +++++++++++++++++++++++++++++++++++++++++++++
> >  net/ipv4/icmp.c             |  4 +++
> >  2 files changed, 68 insertions(+)
> >  create mode 100644 include/trace/events/icmp.h
> > 
> > diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
> > new file mode 100644
> > index 000000000000..c3dc337be7bc
> > --- /dev/null
> > +++ b/include/trace/events/icmp.h
> > @@ -0,0 +1,64 @@
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
> > +			__field(__u16, sport)
> > +			__field(__u16, dport)
> > +			__field(int, type)
> > +			__field(int, code)
> > +			__array(__u8, saddr, 4)
> > +			__array(__u8, daddr, 4)
> > +                	__field(const void *, skbaddr)
> > +			__field(unsigned short, ulen)
> 
> Note, to prevent holes, I usually suggest pointers and longs go first,
> followed by ints, and then end with char.
> 
>                 	__field(const void *, skbaddr)
> 			__field(int, type)
> 			__field(int, code)
> 			__array(__u8, saddr, 4)
> 			__array(__u8, daddr, 4)
> 			__field(__u16, sport)
> 			__field(__u16, dport)
> 			__field(unsigned short, ulen)
> 
> -- Steve
Thank you very much for your suggestion. We will rearrange the parameters in TP_STRUCT_entry, prioritizing pointers and longs, followed by ints, and ending with char. This will be reflected in Patch v3.
> 
> 
> > +		),
> > +
> > +		TP_fast_assign(
> > +			struct iphdr *iph = ip_hdr(skb);
> > +			int proto_4 = iph->protocol;
> > +			__be32 *p32;
> > +
> > +			__entry->skbaddr = skb;
> > +			__entry->type = type;
> > +			__entry->code = code;
> > +
> > +			if (proto_4 == IPPROTO_UDP) {
> > +				struct udphdr *uh = udp_hdr(skb);
> > +				__entry->sport = ntohs(uh->source);
> > +				__entry->dport = ntohs(uh->dest);
> > +				__entry->ulen = ntohs(uh->len);
> > +			} else {
> > +				__entry->sport = 0;
> > +				__entry->dport = 0;
> > +				__entry->ulen = 0;
> > +			}
> > +
> > +			p32 = (__be32 *) __entry->saddr;
> > +			*p32 = iph->saddr;
> > +
> > +			p32 = (__be32 *) __entry->daddr;
> > +			*p32 = iph->daddr;
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
> > \ No newline at end of file
> > diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> > index e63a3bf99617..21fb41257fe9 100644
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
> > @@ -672,6 +674,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
> >  		}
> >  	}
> > 
> > +	trace_icmp_send(skb_in, type, code);
> > +
> >  	/* Needed by both icmp_global_allow and icmp_xmit_lock */
> >  	local_bh_disable();
> > 


