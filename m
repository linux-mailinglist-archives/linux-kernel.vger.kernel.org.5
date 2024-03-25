Return-Path: <linux-kernel+bounces-116677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E3588A27D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C20F1C2D755
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585AB13BAE3;
	Mon, 25 Mar 2024 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YJPR8d88"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9961552F2;
	Mon, 25 Mar 2024 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711353508; cv=none; b=iHb8okMgwTXi77nQj67To8S4jzdc9TeeZh1DAZsV9wPVsID4y2OFnYMmJITW0K3+drNkx+U36BgIK4z9a4hsPwxdL3BehtNHUYtqG0Ejzozu9NgDYedmiBqAGZtQt1BSvjsKMUyBkaHkyQtp9SvqOJ2sAvF7WGUZckqBZZdX+ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711353508; c=relaxed/simple;
	bh=qAMdxk9ji2QCFFg8RS2v2wmwbMlv3YUwfuW6++YvFMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sLEiB6FlmpWTf2bB9AV7pLwKgmOwM14yvle1Av1POxeip/PxzDe1Xp0y1zpEY7TimjtwH1QDQH6CbZdu7VEWSKZSnFAWgn0gaEGXBDT58fZ59IFgiaDvLE9VQ8K3hg9nUfReXmrEOtEVqlrnvYFiDkXd4Pmc8iZHh2Y7F3rVF2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YJPR8d88; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dGjTw
	JPlvMOsZV0qWvG51AfogZ0hB5BsOVHV486tDN4=; b=YJPR8d88hAiP31sTpq8Le
	/sli5Vpp4k4aUGrProrKXLKra7NRVVQFA6wp6ehYDAVrRsRpjeqEtL9ILS8Ac7Ws
	MP/BIhpKugrZrwvOl6i7tPWXapOXVeo0xOhm+wEt70e8I/nWx+Y2iTvKU4hmaotu
	dcF34Bu6mcWytX2CQCtCW0=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wD3X6p5LgFmwnu9Bw--.57921S2;
	Mon, 25 Mar 2024 15:57:47 +0800 (CST)
From: Peilin He <peilinhe2020@163.com>
To: kerneljasonxing@gmail.com
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
	peilinhe2020@163.com,
	rostedt@goodmis.org,
	xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn,
	zhang.yunkai@zte.com.cn
Subject: Re: Re: Re: [PATCH v3 resend] net/ipv4: add tracepoint for icmp_send
Date: Mon, 25 Mar 2024 07:57:45 +0000
Message-Id: <20240325075745.3777528-1-peilinhe2020@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAL+tcoCOywxJ9VFs6PD4Wdsq1HvQ18YVhYX3DA5MfTSXA+Htug@mail.gmail.com>
References: <CAL+tcoCOywxJ9VFs6PD4Wdsq1HvQ18YVhYX3DA5MfTSXA+Htug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X6p5LgFmwnu9Bw--.57921S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtryDJw1DuryUXw48JFy8uFg_yoW7uryrpF
	yDAF1rKw4ktr17Cw1S9w1aqFnIq3yrCryjgr12gw1akrnFqF17tr42qrn8CFykArs8Krya
	vF1jv343GFyYqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRG2NtUUUUU=
X-CM-SenderInfo: xshlzxhqkhjiisq6il2tof0z/1tbiThyssWVOB6CFMgAAs0

>> >> ---------
>> >> v2->v3:
>> >> Some fixes according to
>> >> https://lore.kernel.org/all/20240319102549.7f7f6f53@gandalf.local.home=
>/
>> >> 1. Change the tracking directory to/sys/kernel/tracking.
>> >> 2. Adjust the layout of the TP-STRUCT_entry parameter structure.
>> >>
>> >> v1->v2:
>> >> Some fixes according to
>> >> https://lore.kernel.org/all/CANn89iL-y9e_VFpdw=3D3DsZtRnKRu_tnUwqHuFQT=
>JvJsv=3D
>> >-nz1xPDw@mail.gmail.com/
>> >> 1. adjust the trace_icmp_send() to more protocols than UDP.
>> >> 2. move the calling of trace_icmp_send after sanity checks
>> >> in __icmp_send().
>> >>
>> >> Signed-off-by: Peilin He<he.peilin@zte.com.cn>
>> >> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
>> >> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
>> >> Cc: Yang Yang <yang.yang29@zte.com.cn>
>> >> Cc: Liu Chun <liu.chun2@zte.com.cn>
>> >> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
>> >
>> >I think it would be better to target net-next tree since it's not a
>> >fix or something else important.
>> >
>> OK. I would target it for net-next.
>> >> ---
>> >>  include/trace/events/icmp.h | 64 ++++++++++++++++++++++++++++++++++++=
>+
>> >>  net/ipv4/icmp.c             |  4 +++
>> >>  2 files changed, 68 insertions(+)
>> >>  create mode 100644 include/trace/events/icmp.h
>> >>
>> >> diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
>> >> new file mode 100644
>> >> index 000000000000..2098d4b1b12e
>> >> --- /dev/null
>> >> +++ b/include/trace/events/icmp.h
>> >> @@ -0,0 +1,64 @@
>> >> +/* SPDX-License-Identifier: GPL-2.0 */
>> >> +#undef TRACE_SYSTEM
>> >> +#define TRACE_SYSTEM icmp
>> >> +
>> >> +#if !defined(_TRACE_ICMP_H) || defined(TRACE_HEADER_MULTI_READ)
>> >> +#define _TRACE_ICMP_H
>> >> +
>> >> +#include <linux/icmp.h>
>> >> +#include <linux/tracepoint.h>
>> >> +
>> >> +TRACE_EVENT(icmp_send,
>> >> +
>> >> +               TP_PROTO(const struct sk_buff *skb, int type, int code=
>),
>> >> +
>> >> +               TP_ARGS(skb, type, code),
>> >> +
>> >> +               TP_STRUCT__entry(
>> >> +                       __field(const void *, skbaddr)
>> >> +                       __field(int, type)
>> >> +                       __field(int, code)
>> >> +                       __array(__u8, saddr, 4)
>> >> +                       __array(__u8, daddr, 4)
>> >> +                       __field(__u16, sport)
>> >> +                       __field(__u16, dport)
>> >> +                       __field(unsigned short, ulen)
>> >> +               ),
>> >> +
>> >> +               TP_fast_assign(
>> >> +                       struct iphdr *iph =3D3D ip_hdr(skb);
>> >> +                       int proto_4 =3D3D iph->protocol;
>> >> +                       __be32 *p32;
>> >> +
>> >> +                       __entry->skbaddr =3D3D skb;
>> >> +                       __entry->type =3D3D type;
>> >> +                       __entry->code =3D3D code;
>> >> +
>> >> +                       if (proto_4 =3D3D=3D3D IPPROTO_UDP) {
>> >> +                               struct udphdr *uh =3D3D udp_hdr(skb);
>> >> +                               __entry->sport =3D3D ntohs(uh->source)=
>;
>> >> +                               __entry->dport =3D3D ntohs(uh->dest);
>> >> +                               __entry->ulen =3D3D ntohs(uh->len);
>> >> +                       } else {
>> >> +                               __entry->sport =3D3D 0;
>> >> +                               __entry->dport =3D3D 0;
>> >> +                               __entry->ulen =3D3D 0;
>> >> +                       }
>> >
>> >What about using the TP_STORE_ADDR_PORTS_SKB macro to record the sport
>> >and dport like the patch[1] did through extending the use of header
>> >for TCP and UDP?
>> >
>> I believe patch[1] is a good idea as it moves the TCP protocol parsing
>> previously done inside the TP_STORE_ADDR_PORTS_SKB macro to TP_fast_assig=
>n,
>> and extracts the TP_STORE_ADDR_PORTS_SKB macro into a common file,
>> enabling support for both UDP and TCP protocol parsing simultaneously.
>>
>> However, patch[1] only extracts the source and destination addresses of
>> the packet, but does not extract the source port and destination port,
>> which limits the significance of my submitted patch.
>
>No, please take a look at TP_STORE_ADDR_PORTS_SKB() macro again. It
>records 4-tuples of the flow.
>
>Thanks,
>Jason
>
Okay, after patch [1] is merged, we will propose an optimization patch based on it.
>>
>> Perhaps the patch[1] could be referenced for integration after it is merg=
>ed.
>> >And, I wonder what the use of tracing ulen of that skb?
>> >
>> The tracking of ulen is primarily aimed at ensuring the legality of recei=
>ved
>> UDP packets and providing developers with more detailed information
>> on exceptions. See net/ipv4/udp.c:2494-2501.
>> >[1]: https://lore.kernel.org/all/1c7156a3f164eb33ef3a25b8432e359f0bb60a8=
>e.1=3D
>> >710866188.git.balazs.scheidler@axoflow.com/
>> >
>> >Thanks,
>> >Jason
>> >
>> >> +
>> >> +                       p32 =3D3D (__be32 *) __entry->saddr;
>> >> +                       *p32 =3D3D iph->saddr;
>> >> +
>> >> +                       p32 =3D3D (__be32 *) __entry->daddr;
>> >> +                       *p32 =3D3D iph->daddr;
>> >> +               ),
>> >> +
>> >> +               TP_printk("icmp_send: type=3D3D%d, code=3D3D%d. From %=
>pI4:%u =3D
>> >to %pI4:%u ulen=3D3D%d skbaddr=3D3D%p",
>> >> +                       __entry->type, __entry->code,
>> >> +                       __entry->saddr, __entry->sport, __entry->daddr=
>,
>> >> +                       __entry->dport, __entry->ulen, __entry->skbadd=
>r)
>> >> +);
>> >> +
>> >> +#endif /* _TRACE_ICMP_H */
>> >> +
>> >> +/* This part must be outside protection */
>> >> +#include <trace/define_trace.h>
>> >> \ No newline at end of file
>> >> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
>> >> index e63a3bf99617..21fb41257fe9 100644
>> >> --- a/net/ipv4/icmp.c
>> >> +++ b/net/ipv4/icmp.c
>> >> @@ -92,6 +92,8 @@
>> >>  #include <net/inet_common.h>
>> >>  #include <net/ip_fib.h>
>> >>  #include <net/l3mdev.h>
>> >> +#define CREATE_TRACE_POINTS
>> >> +#include <trace/events/icmp.h>
>> >>
>> >>  /*
>> >>   *     Build xmit assembly blocks
>> >> @@ -672,6 +674,8 @@ void __icmp_send(struct sk_buff *skb_in, int type,=
> in=3D
>> >t code, __be32 info,
>> >>                 }
>> >>         }
>> >>
>> >> +       trace_icmp_send(skb_in, type, code);
>> >> +
>> >>         /* Needed by both icmp_global_allow and icmp_xmit_lock */
>> >>         local_bh_disable();
>> >>
>> >> --
>> >> 2.44.0


