Return-Path: <linux-kernel+bounces-139683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6C48A0673
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259B01C23BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FAB13B5BF;
	Thu, 11 Apr 2024 03:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGIPT99o"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261866215F;
	Thu, 11 Apr 2024 03:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804566; cv=none; b=Yt4pE0439Anj++NG81LZ00v9wLgIM15MJouM60VaqhXR0VIehpU7bbtaO/9nb0lvRHhgoSg4Zf7Dkx/fbSWUZPHMHVQsMkHofMSOQj3JdcslqOFua2p8HYAnKBTsoe5hj87WBICN2uMcdysXt49Q+STRlPbBCAOuTRQfAnBBIh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804566; c=relaxed/simple;
	bh=uf0UxxzaxwfPygGpy1/6L66WB+5xFpGE0UtHzOk97J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eyr7eLggKIIdUvW8T1IEazKyCm43WYjU9l7P1vNKt9yDe8OTFwHv/yg3EOghzLQcWgtW98JTLtSsirwdaRkUxgi00LUxgTIyqdw0xYVxhqGedquh+iCK2tLbQSu8uYE7hP6+9uTP7ZIkYzGtWBZmh+YmF+FAJjBpYQRwj4lng8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGIPT99o; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516dd07d373so3755308e87.3;
        Wed, 10 Apr 2024 20:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712804562; x=1713409362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23k+0ul/LQsBcOETnyrxnDyWLX/i2RS+Anx3RNRM2nE=;
        b=JGIPT99ooH05ilinkuFf9Q+PrxZ+wYsK/OFX/MjgSAE3mIL6nGI4ImVeUjDoh8oDCe
         7q29cC77VQZx5GZ8OyreZk1YnW1VIxw04Q4FvCEnokYEOGkW6Tm23mnGw0LMkiEFMkWW
         U8uNcT8Cd85wJybNYhSslHGZF6t6V6MB+kPQn0uNyJqImWMpSY5aKsrOoeIjoALc200p
         EkmySsmPpX8ZVtpqXGqT1NSmMaHPbxdilo6xY9C8tCaIhwdl8C8PvyrLs9Re32nCLNKB
         6caLUJJt4+L7Q0NxKxfshpP+9T0u/bkimAn4Qm2nNiXNxWO4wFEhwYEYoIIr0yAotJOz
         GutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712804562; x=1713409362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23k+0ul/LQsBcOETnyrxnDyWLX/i2RS+Anx3RNRM2nE=;
        b=Utbs5DKDZ/mw6cKPLfxQ/yCyt2yU1mca/ZoTMauJrzbAzt0Dei7l80YGIRgO3DbhpD
         DdsO1IufF1gHybLhKi8UyEM7R2Ol/2kXyI5so/MwH8HMNB1eUNqxqL7N0QFcNbvQyuNe
         L22Dm9vo3/p81pvE0xurxOyqa3HIRRgf0r5kygWBb4ZZj/idf2RmQafzWqCpCHlZC3MW
         1M35G/AJL62z3A8Rw9hPEjXaite8rSNYYugI/aXWSOPBTS9LoA9+kYUYHoyX8O8teqrf
         hR9koARetFXuHaFCjvZObA97DzxBMIuJZ4DrjVI1kz7NiiB9Sl3cJ1Zb+9XmUb3i83JU
         IPow==
X-Forwarded-Encrypted: i=1; AJvYcCXkbmeVVFu0CHl/dXJgkYz+Of5/UtiCoP8gK5fbINurFOpX8Mq8QYDHQyb09YCxYKl5JfANH22G5ELhI6jfgqRpuA7cGW9AUf6HOT2JpYJLlo9GbKqHQAts7uALZj4yi6wC4S2t64TUrQFjGCMs3FeNu6mk0We4BnMTGUc4vozMZZLByrPU+aUB
X-Gm-Message-State: AOJu0YyQVm4hnQjGyfQNjJN0u716PAWygmg89YWdb1xRdLrzFIOBRLYW
	N3jiBrUlyQ8tTsOizXxt+E1vxJC9u1+jqQvXP5D6pmdGd4dxlFtvI2XfNGhCnFAJdVKPPLpbsf9
	K2tXaQWDpjn5Y33IX3IznvEsTfC0=
X-Google-Smtp-Source: AGHT+IGnpNyOeDM/Irajhzo3fENwd3PDZXJ//iOTmn0GKdYrsUu4IHsIC95k1OFsfc4+LcYrlCmXIL8PjnmUPbh9u0A=
X-Received: by 2002:a05:6512:31cb:b0:515:d60d:bbb with SMTP id
 j11-20020a05651231cb00b00515d60d0bbbmr3560726lfe.0.1712804561937; Wed, 10 Apr
 2024 20:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoC0wRbXfFziaXzvP9wuw4Qe6tZj5QRxbUhAcW5Np6kEgw@mail.gmail.com>
 <20240411023316.137800-1-peilinhe2020@163.com>
In-Reply-To: <20240411023316.137800-1-peilinhe2020@163.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 11 Apr 2024 11:02:05 +0800
Message-ID: <CAL+tcoDS6yGAP0UqN9YCSzB2zSUz5b7Vmh+M7Gk-k3SZdmfj1Q@mail.gmail.com>
Subject: Re: Re: Re: Subject: [PATCH net-next v4] net/ipv4: add tracepoint for icmp_send
To: Peilin He <peilinhe2020@163.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	fan.yu9@zte.com.cn, he.peilin@zte.com.cn, jiang.xuexin@zte.com.cn, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, liu.chun2@zte.com.cn, mhiramat@kernel.org, 
	netdev@vger.kernel.org, qiu.yutan@zte.com.cn, rostedt@goodmis.org, 
	xu.xin16@zte.com.cn, yang.yang29@zte.com.cn, zhang.yunkai@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:34=E2=80=AFAM Peilin He <peilinhe2020@163.com> w=
rote:
>
> >[...]
> >> >I think my understanding based on what Eric depicted differs from you=
:
> >> >we're supposed to filter out those many invalid cases and only trace
> >> >the valid action of sending a icmp, so where to add a new tracepoint
> >> >is important instead of adding more checks in the tracepoint itself.
> >> >Please refer to what trace_tcp_retransmit_skb() does :)
> >> >
> >> >Thanks,
> >> >Jason
> >> Okay, thank you for your suggestion. In order to avoid filtering out
> >> those many invalid cases and only tracing the valid action of sending
> >> a icmp, the next patch will add udd_fail_no_port trancepoint to the
> >> include/trace/events/udp.h. This will solve the problem you mentioned
> >> very well. At this point, only UDP protocol exceptions will be tracked=
,
> >> without the need to track them in icmp_send.
> >
> >I'm not against what you did (tracing all the icmp_send() for UDP) in
> >your original patch. I was suggesting that you could put
> >trace_icmp_send() in the right place, then you don't have to check the
> >possible error condition (like if the skb->head is valid or not, ...)
> >in your trace function.
> >
> >One example that can avoid various checks existing in the
> >__icmp_send() function:
> >diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> >index e63a3bf99617..2c9f7364de45 100644
> >--- a/net/ipv4/icmp.c
> >+++ b/net/ipv4/icmp.c
> >@@ -767,6 +767,7 @@ void __icmp_send(struct sk_buff *skb_in, int type,
> >int code, __be32 info,
> >        if (!fl4.saddr)
> >                fl4.saddr =3D htonl(INADDR_DUMMY);
> >
> >+       trace_icmp_send(skb_in, type, code);
> >        icmp_push_reply(sk, &icmp_param, &fl4, &ipc, &rt);
> > ende
> >        ip_rt_put(rt);
> >
> >If we go here, it means we are ready to send the ICMP skb because
> >we're done extracting the right information in the 'struct sk_buff
> >skb_in'. Simpler and easier, right?
> >
> >Thanks,
> >Jason
>
> I may not fully agree with this viewpoint. When trace_icmp_send is placed
> in this position, it cannot guarantee that all skbs in icmp are UDP proto=
cols
> (UDP needs to be distinguished based on the proto_4!=3DIPPROTO_UDP condit=
ion),
> nor can it guarantee the legitimacy of udphdr (*uh legitimacy check is re=
quired).

Of course, the UDP test statement is absolutely needed! Eric
previously pointed this out in the V1 patch thread. I'm not referring
to this one but like skb->head check something like this which exists
in __icmp_send() function. You can see there are so many checks in it
before sending.

So only keeping the UDP check is enough, I think.

Thanks,
Jason

>
> With best wishes
> Peilin He
>
> >>
> >> >> 2.Target this patch for net-next.
> >> >>
> >> >> v2->v3:
> >> >> Some fixes according to
> >> >> https://lore.kernel.org/all/20240319102549.7f7f6f53@gandalf.local.h=
ome/
> >> >> 1. Change the tracking directory to/sys/kernel/tracking.
> >> >> 2. Adjust the layout of the TP-STRUCT_entry parameter structure.
> >> >>
> >> >> v1->v2:
> >> >> Some fixes according to
> >> >> https://lore.kernel.org/all/CANn89iL-y9e_VFpdw=3D3DsZtRnKRu_tnUwqHu=
FQTJvJsv=3D
> >> >-nz1xPDw@mail.gmail.com/
> >> >> 1. adjust the trace_icmp_send() to more protocols than UDP.
> >> >> 2. move the calling of trace_icmp_send after sanity checks
> >> >> in __icmp_send().
> >> >>
> >> >> Signed-off-by: Peilin He<he.peilin@zte.com.cn>
> >> >> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> >> >> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
> >> >> Cc: Yang Yang <yang.yang29@zte.com.cn>
> >> >> Cc: Liu Chun <liu.chun2@zte.com.cn>
> >> >> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> >> >> ---
> >> >>  include/trace/events/icmp.h | 65 +++++++++++++++++++++++++++++++++=
++++
> >> >>  net/ipv4/icmp.c             |  4 +++
> >> >>  2 files changed, 69 insertions(+)
> >> >>  create mode 100644 include/trace/events/icmp.h
> >> >>
> >> >> diff --git a/include/trace/events/icmp.h b/include/trace/events/icm=
p.h
> >> >> new file mode 100644
> >> >> index 000000000000..7d5190f48a28
> >> >> --- /dev/null
> >> >> +++ b/include/trace/events/icmp.h
> >> >> @@ -0,0 +1,65 @@
> >> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> >> +#undef TRACE_SYSTEM
> >> >> +#define TRACE_SYSTEM icmp
> >> >> +
> >> >> +#if !defined(_TRACE_ICMP_H) || defined(TRACE_HEADER_MULTI_READ)
> >> >> +#define _TRACE_ICMP_H
> >> >> +
> >> >> +#include <linux/icmp.h>
> >> >> +#include <linux/tracepoint.h>
> >> >> +
> >> >> +TRACE_EVENT(icmp_send,
> >> >> +
> >> >> +               TP_PROTO(const struct sk_buff *skb, int type, int c=
ode),
> >> >> +
> >> >> +               TP_ARGS(skb, type, code),
> >> >> +
> >> >> +               TP_STRUCT__entry(
> >> >> +                       __field(const void *, skbaddr)
> >> >> +                       __field(int, type)
> >> >> +                       __field(int, code)
> >> >> +                       __array(__u8, saddr, 4)
> >> >> +                       __array(__u8, daddr, 4)
> >> >> +                       __field(__u16, sport)
> >> >> +                       __field(__u16, dport)
> >> >> +                       __field(unsigned short, ulen)
> >> >> +               ),
> >> >> +
> >> >> +               TP_fast_assign(
> >> >> +                       struct iphdr *iph =3D3D ip_hdr(skb);
> >> >> +                       int proto_4 =3D3D iph->protocol;
> >> >> +                       __be32 *p32;
> >> >> +
> >> >> +                       __entry->skbaddr =3D3D skb;
> >> >> +                       __entry->type =3D3D type;
> >> >> +                       __entry->code =3D3D code;
> >> >> +
> >> >> +                       struct udphdr *uh =3D3D udp_hdr(skb);
> >> >> +                       if (proto_4 !=3D3D IPPROTO_UDP || (u8 *)uh =
< skb->h=3D
> >> >ead ||
> >> >> +                               (u8 *)uh + sizeof(struct udphdr) > =
skb_ta=3D
> >> >il_pointer(skb)) {
> >> >> +                               __entry->sport =3D3D 0;
> >> >> +                               __entry->dport =3D3D 0;
> >> >> +                               __entry->ulen =3D3D 0;
> >> >> +                       } else {
> >> >> +                               __entry->sport =3D3D ntohs(uh->sour=
ce);
> >> >> +                               __entry->dport =3D3D ntohs(uh->dest=
);
> >> >> +                               __entry->ulen =3D3D ntohs(uh->len);
> >> >> +                       }
> >> >> +
> >> >> +                       p32 =3D3D (__be32 *) __entry->saddr;
> >> >> +                       *p32 =3D3D iph->saddr;
> >> >> +
> >> >> +                       p32 =3D3D (__be32 *) __entry->daddr;
> >> >> +                       *p32 =3D3D iph->daddr;
> >> >> +               ),
> >> >> +
> >> >> +               TP_printk("icmp_send: type=3D3D%d, code=3D3D%d. Fro=
m %pI4:%u =3D
> >> >to %pI4:%u ulen=3D3D%d skbaddr=3D3D%p",
> >> >> +                       __entry->type, __entry->code,
> >> >> +                       __entry->saddr, __entry->sport, __entry->da=
ddr,
> >> >> +                       __entry->dport, __entry->ulen, __entry->skb=
addr)
> >> >> +);
> >> >> +
> >> >> +#endif /* _TRACE_ICMP_H */
> >> >> +
> >> >> +/* This part must be outside protection */
> >> >> +#include <trace/define_trace.h>
> >> >> \ No newline at end of file
> >> >> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> >> >> index 8cebb476b3ab..224551d75c02 100644
> >> >> --- a/net/ipv4/icmp.c
> >> >> +++ b/net/ipv4/icmp.c
> >> >> @@ -92,6 +92,8 @@
> >> >>  #include <net/inet_common.h>
> >> >>  #include <net/ip_fib.h>
> >> >>  #include <net/l3mdev.h>
> >> >> +#define CREATE_TRACE_POINTS
> >> >> +#include <trace/events/icmp.h>
> >> >>
> >> >>  /*
> >> >>   *     Build xmit assembly blocks
> >> >> @@ -672,6 +674,8 @@ void __icmp_send(struct sk_buff *skb_in, int ty=
pe, in=3D
> >> >t code, __be32 info,
> >> >>                 }
> >> >>         }
> >> >>
> >> >> +       trace_icmp_send(skb_in, type, code);
> >> >> +
> >> >>         /* Needed by both icmp_global_allow and icmp_xmit_lock */
> >> >>         local_bh_disable();
> >> >>
> >> >> --
> >> >> 2.25.1
>
>

