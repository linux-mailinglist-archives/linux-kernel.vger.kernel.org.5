Return-Path: <linux-kernel+bounces-139957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 906D98A0998
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45270282402
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F33B13E03B;
	Thu, 11 Apr 2024 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VgLA5OMt"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89932032C;
	Thu, 11 Apr 2024 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820195; cv=none; b=uw8+Y9hc47K0O6npdT6uYcmfDT2WOvhNIonA4c8ubjQMJe/N5gtlCwNEPv1tUSAf/IjA9BxzZbz/JoYcAerwZ4R9TwBIM242RigMAM2oZxHATBfFmHIi+luaBEzJNMxJkIkUeBL3huB1AgXKo+KItx8DFQ2GWb/Zp3RBpXlzsdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820195; c=relaxed/simple;
	bh=WSFjSWgl5KqDN5ZgZyPgBqGx2lcCJ9WviU1dVscXejs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B6XDUvMd5E8RznCvJLLDxjo0+ILnsPY5KnFI3YVWJ2OvQLYTQQdUU1mM+/3VRCSrZjNGFZ82ihVDU2Yr8f7N2moHYDbX3fhNh7N1sNURlvQwmItZb16uI0F+Og/K1et5UvafUw72xhd4V+lcN2ydBpTgjov17Vzuz2S7THa+V4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VgLA5OMt; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fDUwX
	lrxdpRdpXHmYA1WyCLe3YE4/+fYtphjBIyd0ik=; b=VgLA5OMt4ItPCxhBuZfmX
	OBpKROPpgs8l2iqSg8B5l6lr+z0hXRtO9xf0G2c56aXtJiK0Hjb5CP78Hps3w/4j
	tfuyzOKXy40Gqztle9CbsuQVsh/i6D53pvUjhHXp6LBuP8ll5bg+7wmxs7dZQvmr
	t5WmvZQUnQcSFaqxkw74aw=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wD3fzKujxdmbtAdAw--.22897S2;
	Thu, 11 Apr 2024 15:22:24 +0800 (CST)
From: Peilin He <peilinhe2020@163.com>
To: kerneljasonxing@gmail.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	fan.yu9@zte.com.cn,
	he.peilin@zte.com.cn,
	jiang.xuexin@zte.com.cn,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	liu.chun2@zte.com.cn,
	mhiramat@kernel.org,
	netdev@vger.kernel.org,
	peilinhe2020@163.com,
	qiu.yutan@zte.com.cn,
	rostedt@goodmis.org,
	xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn,
	zhang.yunkai@zte.com.cn
Subject: Re: Re: Re: Subject: [PATCH net-next v4] net/ipv4: add tracepoint for icmp_send
Date: Thu, 11 Apr 2024 07:22:22 +0000
Message-Id: <20240411072222.140326-1-peilinhe2020@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAL+tcoDeXXh+zcRk4PHnUk8ELnx=CE2pcCqs7sFm0y9aK-Eehg@mail.gmail.com>
References: <CAL+tcoDeXXh+zcRk4PHnUk8ELnx=CE2pcCqs7sFm0y9aK-Eehg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3fzKujxdmbtAdAw--.22897S2
X-Coremail-Antispam: 1Uf129KBjvJXoWfGFWDJw13Jr1fKrWrJFW8WFg_yoWDXw15pF
	yUAF1UCr1DJr4UAr1I9w1YqFnFqry8JryUWr1UXw13Cw1Dtr17JFyxtr15Cry8Ar45Krya
	qF1Ut343Gr15JrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR7rcsUUUUU=
X-CM-SenderInfo: xshlzxhqkhjiisq6il2tof0z/1tbiYxG9sWV4Hr8W7gAAs6

>> >> >[...]
>> >> >> >I think my understanding based on what Eric depicted differs from =
>you:
>> >> >> >we're supposed to filter out those many invalid cases and only tra=
>ce
>> >> >> >the valid action of sending a icmp, so where to add a new tracepoi=
>nt
>> >> >> >is important instead of adding more checks in the tracepoint itsel=
>f.
>> >> >> >Please refer to what trace_tcp_retransmit_skb() does :)
>> >> >> >
>> >> >> >Thanks,
>> >> >> >Jason
>> >> >> Okay, thank you for your suggestion. In order to avoid filtering ou=
>t
>> >> >> those many invalid cases and only tracing the valid action of sendi=
>ng
>> >> >> a icmp, the next patch will add udd_fail_no_port trancepoint to the
>> >> >> include/trace/events/udp.h. This will solve the problem you mention=
>ed
>> >> >> very well. At this point, only UDP protocol exceptions will be trac=
>ked,
>> >> >> without the need to track them in icmp_send.
>> >> >
>> >> >I'm not against what you did (tracing all the icmp_send() for UDP) in
>> >> >your original patch. I was suggesting that you could put
>> >> >trace_icmp_send() in the right place, then you don't have to check th=
>e
>> >> >possible error condition (like if the skb->head is valid or not, ...)
>> >> >in your trace function.
>> >> >
>> >> >One example that can avoid various checks existing in the
>> >> >__icmp_send() function:
>> >> >diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
>> >> >index e63a3bf99617..2c9f7364de45 100644
>> >> >--- a/net/ipv4/icmp.c
>> >> >+++ b/net/ipv4/icmp.c
>> >> >@@ -767,6 +767,7 @@ void __icmp_send(struct sk_buff *skb_in, int type=
>,
>> >> >int code, __be32 info,
>> >> >        if (!fl4.saddr)
>> >> >                fl4.saddr =3D htonl(INADDR_DUMMY);
>> >> >
>> >> >+       trace_icmp_send(skb_in, type, code);
>> >> >        icmp_push_reply(sk, &icmp_param, &fl4, &ipc, &rt);
>> >> > ende
>> >> >        ip_rt_put(rt);
>> >> >
>> >> >If we go here, it means we are ready to send the ICMP skb because
>> >> >we're done extracting the right information in the 'struct sk_buff
>> >> >skb_in'. Simpler and easier, right?
>> >> >
>> >> >Thanks,
>> >> >Jason
>> >>
>> >> I may not fully agree with this viewpoint. When trace_icmp_send is pla=
>ced
>> >> in this position, it cannot guarantee that all skbs in icmp are UDP pr=
>otocols
>> >> (UDP needs to be distinguished based on the proto_4!=3DIPPROTO_UDP con=
>dition),
>> >> nor can it guarantee the legitimacy of udphdr (*uh legitimacy check is=
> required).
>> >
>> >Of course, the UDP test statement is absolutely needed! Eric
>> >previously pointed this out in the V1 patch thread. I'm not referring
>> >to this one but like skb->head check something like this which exists
>> >in __icmp_send() function. You can see there are so many checks in it
>> >before sending.
>> >
>> >So only keeping the UDP check is enough, I think.
>>
>> The __icmp_send function only checks the IP header, but does not check
>> the UDP header, as shown in the following code snippet:
>>
>> if ((u8 *)iph < skb_in->head ||
>>             (skb_network_header(skb_in) + sizeof(*iph)) >
>>             skb_tail_pointer(skb_in))
>>                 goto out;
>>
>> There is no problem with the IP header check, which does not mean that
>> the UDP header is correct. Therefore, I believe that it is essential to
>> include a legitimacy judgment for the UDP header.
>>
>> Here is an explanation of this code:
>> Firstly, the UDP header (*uh) is extracted from the skb.
>> Then, if the current protocol of the skb is not UDP, or if the address of
>> uh is outside the range of the skb, the source port and destination port
>> will not be resolved, and 0 will be filled in directly.Otherwise,
>> the source port and destination port of the UDP header will be resolved.
>>
>> +       struct udphdr *uh =3D udp_hdr(skb);
>> +       if (proto_4 !=3D IPPROTO_UDP || (u8 *)uh < skb->head ||
>> +           (u8 *)uh + sizeof(struct udphdr) > skb_tail_pointer(skb)) {
>
>>From the beginning, I always agree with the UDP check. I was saying if
>you can put the trace_icmp_send() just before icmp_push_reply()[1],
>you could avoid those kinds of checks.
>As I said in the previous email, "only keeping the UDP check is
>enough". So you are right.
>
>[1]
>diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
>index e63a3bf99617..2c9f7364de45 100644
>--- a/net/ipv4/icmp.c
>+++ b/net/ipv4/icmp.c
>@@ -767,6 +767,7 @@ void __icmp_send(struct sk_buff *skb_in, int type,
>int code, __be32 info,
>        if (!fl4.saddr)
>                fl4.saddr =3D htonl(INADDR_DUMMY);
>
>+       trace_icmp_send(skb_in, type, code);
>        icmp_push_reply(sk, &icmp_param, &fl4, &ipc, &rt);
> ende:
>        ip_rt_put(rt);
>
>If we're doing this, trace_icmp_send() can reflect the real action of
>sending an ICMP like trace_tcp_retransmit_skb(). Or else, the trace
>could print some messages but no real ICMP is sent (see those error
>checks). WDYT?
>
>Thanks,
>Jasoin

Yeah, placing trace_icmp_send() before icmp_push_reply() will ensure
that tracking starts when ICMP messages are sent. The next patch will
adjust the position of trace_icmp_send() to before icmp_push_reply().

With best wishes
Peilin He
>
>>
>> With best wishes
>> Peilin He
>>
>> >Thanks,
>> >Jason
>> >
>> >>
>> >> With best wishes
>> >> Peilin He
>> >>
>> >> >>
>> >> >> >> 2.Target this patch for net-next.
>> >> >> >>
>> >> >> >> v2->v3:
>> >> >> >> Some fixes according to
>> >> >> >> https://lore.kernel.org/all/20240319102549.7f7f6f53@gandalf.loca=
>l.home/
>> >> >> >> 1. Change the tracking directory to/sys/kernel/tracking.
>> >> >> >> 2. Adjust the layout of the TP-STRUCT_entry parameter structure.
>> >> >> >>
>> >> >> >> v1->v2:
>> >> >> >> Some fixes according to
>> >> >> >> https://lore.kernel.org/all/CANn89iL-y9e_VFpdw=3D3DsZtRnKRu_tnUw=
>qHuFQTJvJsv=3D
>> >> >> >-nz1xPDw@mail.gmail.com/
>> >> >> >> 1. adjust the trace_icmp_send() to more protocols than UDP.
>> >> >> >> 2. move the calling of trace_icmp_send after sanity checks
>> >> >> >> in __icmp_send().
>> >> >> >>
>> >> >> >> Signed-off-by: Peilin He<he.peilin@zte.com.cn>
>> >> >> >> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
>> >> >> >> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
>> >> >> >> Cc: Yang Yang <yang.yang29@zte.com.cn>
>> >> >> >> Cc: Liu Chun <liu.chun2@zte.com.cn>
>> >> >> >> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
>> >> >> >> ---
>> >> >> >>  include/trace/events/icmp.h | 65 ++++++++++++++++++++++++++++++=
>+++++++
>> >> >> >>  net/ipv4/icmp.c             |  4 +++
>> >> >> >>  2 files changed, 69 insertions(+)
>> >> >> >>  create mode 100644 include/trace/events/icmp.h
>> >> >> >>
>> >> >> >> diff --git a/include/trace/events/icmp.h b/include/trace/events/=
>icmp.h
>> >> >> >> new file mode 100644
>> >> >> >> index 000000000000..7d5190f48a28
>> >> >> >> --- /dev/null
>> >> >> >> +++ b/include/trace/events/icmp.h
>> >> >> >> @@ -0,0 +1,65 @@
>> >> >> >> +/* SPDX-License-Identifier: GPL-2.0 */
>> >> >> >> +#undef TRACE_SYSTEM
>> >> >> >> +#define TRACE_SYSTEM icmp
>> >> >> >> +
>> >> >> >> +#if !defined(_TRACE_ICMP_H) || defined(TRACE_HEADER_MULTI_READ)
>> >> >> >> +#define _TRACE_ICMP_H
>> >> >> >> +
>> >> >> >> +#include <linux/icmp.h>
>> >> >> >> +#include <linux/tracepoint.h>
>> >> >> >> +
>> >> >> >> +TRACE_EVENT(icmp_send,
>> >> >> >> +
>> >> >> >> +               TP_PROTO(const struct sk_buff *skb, int type, in=
>t code),
>> >> >> >> +
>> >> >> >> +               TP_ARGS(skb, type, code),
>> >> >> >> +
>> >> >> >> +               TP_STRUCT__entry(
>> >> >> >> +                       __field(const void *, skbaddr)
>> >> >> >> +                       __field(int, type)
>> >> >> >> +                       __field(int, code)
>> >> >> >> +                       __array(__u8, saddr, 4)
>> >> >> >> +                       __array(__u8, daddr, 4)
>> >> >> >> +                       __field(__u16, sport)
>> >> >> >> +                       __field(__u16, dport)
>> >> >> >> +                       __field(unsigned short, ulen)
>> >> >> >> +               ),
>> >> >> >> +
>> >> >> >> +               TP_fast_assign(
>> >> >> >> +                       struct iphdr *iph =3D3D ip_hdr(skb);
>> >> >> >> +                       int proto_4 =3D3D iph->protocol;
>> >> >> >> +                       __be32 *p32;
>> >> >> >> +
>> >> >> >> +                       __entry->skbaddr =3D3D skb;
>> >> >> >> +                       __entry->type =3D3D type;
>> >> >> >> +                       __entry->code =3D3D code;
>> >> >> >> +
>> >> >> >> +                       struct udphdr *uh =3D3D udp_hdr(skb);
>> >> >> >> +                       if (proto_4 !=3D3D IPPROTO_UDP || (u8 *)=
>uh < skb->h=3D
>> >> >> >ead ||
>> >> >> >> +                               (u8 *)uh + sizeof(struct udphdr)=
> > skb_ta=3D
>> >> >> >il_pointer(skb)) {
>> >> >> >> +                               __entry->sport =3D3D 0;
>> >> >> >> +                               __entry->dport =3D3D 0;
>> >> >> >> +                               __entry->ulen =3D3D 0;
>> >> >> >> +                       } else {
>> >> >> >> +                               __entry->sport =3D3D ntohs(uh->s=
>ource);
>> >> >> >> +                               __entry->dport =3D3D ntohs(uh->d=
>est);
>> >> >> >> +                               __entry->ulen =3D3D ntohs(uh->le=
>n);
>> >> >> >> +                       }
>> >> >> >> +
>> >> >> >> +                       p32 =3D3D (__be32 *) __entry->saddr;
>> >> >> >> +                       *p32 =3D3D iph->saddr;
>> >> >> >> +
>> >> >> >> +                       p32 =3D3D (__be32 *) __entry->daddr;
>> >> >> >> +                       *p32 =3D3D iph->daddr;
>> >> >> >> +               ),
>> >> >> >> +
>> >> >> >> +               TP_printk("icmp_send: type=3D3D%d, code=3D3D%d. =
>>From %pI4:%u =3D
>> >> >> >to %pI4:%u ulen=3D3D%d skbaddr=3D3D%p",
>> >> >> >> +                       __entry->type, __entry->code,
>> >> >> >> +                       __entry->saddr, __entry->sport, __entry-=
>>daddr,
>> >> >> >> +                       __entry->dport, __entry->ulen, __entry->=
>skbaddr)
>> >> >> >> +);
>> >> >> >> +
>> >> >> >> +#endif /* _TRACE_ICMP_H */
>> >> >> >> +
>> >> >> >> +/* This part must be outside protection */
>> >> >> >> +#include <trace/define_trace.h>
>> >> >> >> \ No newline at end of file
>> >> >> >> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
>> >> >> >> index 8cebb476b3ab..224551d75c02 100644
>> >> >> >> --- a/net/ipv4/icmp.c
>> >> >> >> +++ b/net/ipv4/icmp.c
>> >> >> >> @@ -92,6 +92,8 @@
>> >> >> >>  #include <net/inet_common.h>
>> >> >> >>  #include <net/ip_fib.h>
>> >> >> >>  #include <net/l3mdev.h>
>> >> >> >> +#define CREATE_TRACE_POINTS
>> >> >> >> +#include <trace/events/icmp.h>
>> >> >> >>
>> >> >> >>  /*
>> >> >> >>   *     Build xmit assembly blocks
>> >> >> >> @@ -672,6 +674,8 @@ void __icmp_send(struct sk_buff *skb_in, int=
> type, in=3D
>> >> >> >t code, __be32 info,
>> >> >> >>                 }
>> >> >> >>         }
>> >> >> >>
>> >> >> >> +       trace_icmp_send(skb_in, type, code);
>> >> >> >> +
>> >> >> >>         /* Needed by both icmp_global_allow and icmp_xmit_lock *=
>/
>> >> >> >>         local_bh_disable();
>> >> >> >>
>> >> >> >> --
>> >> >> >> 2.25.1


