Return-Path: <linux-kernel+bounces-138585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 999AC89F40E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC211F2C8B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E1715FA6D;
	Wed, 10 Apr 2024 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKxgYC3O"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE9415E801;
	Wed, 10 Apr 2024 13:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755186; cv=none; b=g5EXhNkDCAq8GJKy7vmRybAIvDZl68s2FfhBRFkEOuHzGh/T3trSwal0mtrrQfcYzchqtop7XzjgIEE7PujXyqaBc5uFmthnLXfGEthb8hZY0KpPkqEu+2wliHP7XL2cepySJZ0K3hNoxTN7ZkafMO+OldO5q58DJyKxVRmnZJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755186; c=relaxed/simple;
	bh=hUaSsgXUDxeeQQYTP4VHvyNe5xTRTHtxE5lST3oP70c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snD3D+X1XaucvwhHwK5nroQB8MHS7Pk74aM8JuBDshBgn60N7FXyBKi8PTwa0i5jOUcx0Ei/LjL0EQjrjfUY5njxPwJg9vhitdvqVii81SWuZW9IRSzNYolRgdkfXMZQhyGHW+u7BdFEpfhixZkURkTXSOXKraKrUCmLV1IkBr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKxgYC3O; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a44ad785a44so787540566b.3;
        Wed, 10 Apr 2024 06:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712755183; x=1713359983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G7eOGUEZTN9uTMLHaCezEFeZGoCqkIFVRR+v77N22tg=;
        b=OKxgYC3OFrspHLZ8HLQBVmaAuyESLoXgx6S3/xYRrxh+pyJZ6ezd4PCq2dra4rs43l
         Dt10lzdOTWCBgDqekRNzMBRhWS6NU/x6ibfCmPMQoiqgER6mbC+Lj2UKkIy59ekmhXaj
         xJl7pgn+AsY5PcfAJOJjru2pkM/Hh7J/4ZpJ2xOUvUBUEVJCUy7q2IAEKCxWvlmJapNA
         fY2vUY1NmLys6i6t6VlaplWiMxnO6BtRWEeQPl1X2KrmckR/LkEkuGTQi+bFKB5AGbSy
         BAf5L+I4i0HprE0mJITXefPZTLAS07shafYhlokEjItoTbyrXYpIlbjn85bcrEtCkof1
         Hx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755183; x=1713359983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7eOGUEZTN9uTMLHaCezEFeZGoCqkIFVRR+v77N22tg=;
        b=jzncwsP/LBSDIJlst3+V/yrucprNC8uH8c6Ih9V8FPqm4WJ9OggtA1ubFphswaf8/2
         HY2uSG40PJ/vgF4AmRlwQEboHHVQiV5ugB0H8Uj42N6XHdnmVK4wIZdq3tNMadbH51wb
         mQBMPa2GC/gDjQFlS7ltfcmHjZ1pJMmNHT3VVis9WJzwDhQhO0zfmMZ2nXSxnklXrt/t
         Fjx35k11HZmRzV09tRzfGOoU8T3ZoC60C3JHqQwWYTOmeo9/wN/n71bCP0T6nafnNRso
         IC9twW8vDlGeEFXj4xXL8cYkGUDLMcjCgpafox5LkJsbn4Q5jPqDq6KOk7CaZu1St/D4
         Qw+g==
X-Forwarded-Encrypted: i=1; AJvYcCWgcaQ3UNPObUMhljWLqCQvugdotbLw7rp4VJfK0MR15lFdvrgh9160f3Vu4GXE/d0EQGZkw+nXgvq1lDgidOdj/xv9RVi2xmHBJ4YeYpaZuvhNq8cRqOA2V7S4omh5e0mAigmpKTneJ9Wg70ybBuO1th8nYKA164J1qlCqvwasAwSfFQVvijHL
X-Gm-Message-State: AOJu0YyJpYhGoMaeujakgHJV285Cjj6HEHM6IrTYRmrRadh1+g84uNc7
	qqFi8y1kE6oc7DQtHvN+oNgwtb4vL+MEt8/Sh6GNUp8mRZAPYolmoJ7Qrv11LnLQ3KCXsCfIIpJ
	92E0w0LYw0OmBexwvO9ubXSb/FT6ju+TwgbY=
X-Google-Smtp-Source: AGHT+IFRRw6GxGodexe98NzadGTkJdl/BDeHP2BFlNU5MYnJUuxsEsyyzwRoWmLaIxQAsaarTwPOGkeb3V7EAo+ESho=
X-Received: by 2002:a17:907:38b:b0:a51:df52:5a65 with SMTP id
 ss11-20020a170907038b00b00a51df525a65mr1625501ejb.2.1712755182572; Wed, 10
 Apr 2024 06:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoAcagGKkzJLrgCmFRv52uBbdAN_ufspvmkbG2MaFw2_tQ@mail.gmail.com>
 <20240410121605.132052-1-peilinhe2020@163.com>
In-Reply-To: <20240410121605.132052-1-peilinhe2020@163.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 10 Apr 2024 21:19:05 +0800
Message-ID: <CAL+tcoC0wRbXfFziaXzvP9wuw4Qe6tZj5QRxbUhAcW5Np6kEgw@mail.gmail.com>
Subject: Re: Re: Subject: [PATCH net-next v4] net/ipv4: add tracepoint for icmp_send
To: Peilin He <peilinhe2020@163.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	fan.yu9@zte.com.cn, he.peilin@zte.com.cn, jiang.xuexin@zte.com.cn, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, liu.chun2@zte.com.cn, mhiramat@kernel.org, 
	netdev@vger.kernel.org, qiu.yutan@zte.com.cn, rostedt@goodmis.org, 
	xu.xin16@zte.com.cn, yang.yang29@zte.com.cn, zhang.yunkai@zte.com.cn
Content-Type: text/plain; charset="UTF-8"

[...]
> >I think my understanding based on what Eric depicted differs from you:
> >we're supposed to filter out those many invalid cases and only trace
> >the valid action of sending a icmp, so where to add a new tracepoint
> >is important instead of adding more checks in the tracepoint itself.
> >Please refer to what trace_tcp_retransmit_skb() does :)
> >
> >Thanks,
> >Jason
> Okay, thank you for your suggestion. In order to avoid filtering out
> those many invalid cases and only tracing the valid action of sending
> a icmp, the next patch will add udd_fail_no_port trancepoint to the
> include/trace/events/udp.h. This will solve the problem you mentioned
> very well. At this point, only UDP protocol exceptions will be tracked,
> without the need to track them in icmp_send.

I'm not against what you did (tracing all the icmp_send() for UDP) in
your original patch. I was suggesting that you could put
trace_icmp_send() in the right place, then you don't have to check the
possible error condition (like if the skb->head is valid or not, ...)
in your trace function.

One example that can avoid various checks existing in the
__icmp_send() function:
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index e63a3bf99617..2c9f7364de45 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -767,6 +767,7 @@ void __icmp_send(struct sk_buff *skb_in, int type,
int code, __be32 info,
        if (!fl4.saddr)
                fl4.saddr = htonl(INADDR_DUMMY);

+       trace_icmp_send(skb_in, type, code);
        icmp_push_reply(sk, &icmp_param, &fl4, &ipc, &rt);
 ende:
        ip_rt_put(rt);

If we go here, it means we are ready to send the ICMP skb because
we're done extracting the right information in the 'struct sk_buff
skb_in'. Simpler and easier, right?

Thanks,
Jason

>
> >> 2.Target this patch for net-next.
> >>
> >> v2->v3:
> >> Some fixes according to
> >> https://lore.kernel.org/all/20240319102549.7f7f6f53@gandalf.local.home/
> >> 1. Change the tracking directory to/sys/kernel/tracking.
> >> 2. Adjust the layout of the TP-STRUCT_entry parameter structure.
> >>
> >> v1->v2:
> >> Some fixes according to
> >> https://lore.kernel.org/all/CANn89iL-y9e_VFpdw=3DsZtRnKRu_tnUwqHuFQTJvJsv=
> >-nz1xPDw@mail.gmail.com/
> >> 1. adjust the trace_icmp_send() to more protocols than UDP.
> >> 2. move the calling of trace_icmp_send after sanity checks
> >> in __icmp_send().
> >>
> >> Signed-off-by: Peilin He<he.peilin@zte.com.cn>
> >> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> >> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
> >> Cc: Yang Yang <yang.yang29@zte.com.cn>
> >> Cc: Liu Chun <liu.chun2@zte.com.cn>
> >> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> >> ---
> >>  include/trace/events/icmp.h | 65 +++++++++++++++++++++++++++++++++++++
> >>  net/ipv4/icmp.c             |  4 +++
> >>  2 files changed, 69 insertions(+)
> >>  create mode 100644 include/trace/events/icmp.h
> >>
> >> diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
> >> new file mode 100644
> >> index 000000000000..7d5190f48a28
> >> --- /dev/null
> >> +++ b/include/trace/events/icmp.h
> >> @@ -0,0 +1,65 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +#undef TRACE_SYSTEM
> >> +#define TRACE_SYSTEM icmp
> >> +
> >> +#if !defined(_TRACE_ICMP_H) || defined(TRACE_HEADER_MULTI_READ)
> >> +#define _TRACE_ICMP_H
> >> +
> >> +#include <linux/icmp.h>
> >> +#include <linux/tracepoint.h>
> >> +
> >> +TRACE_EVENT(icmp_send,
> >> +
> >> +               TP_PROTO(const struct sk_buff *skb, int type, int code),
> >> +
> >> +               TP_ARGS(skb, type, code),
> >> +
> >> +               TP_STRUCT__entry(
> >> +                       __field(const void *, skbaddr)
> >> +                       __field(int, type)
> >> +                       __field(int, code)
> >> +                       __array(__u8, saddr, 4)
> >> +                       __array(__u8, daddr, 4)
> >> +                       __field(__u16, sport)
> >> +                       __field(__u16, dport)
> >> +                       __field(unsigned short, ulen)
> >> +               ),
> >> +
> >> +               TP_fast_assign(
> >> +                       struct iphdr *iph =3D ip_hdr(skb);
> >> +                       int proto_4 =3D iph->protocol;
> >> +                       __be32 *p32;
> >> +
> >> +                       __entry->skbaddr =3D skb;
> >> +                       __entry->type =3D type;
> >> +                       __entry->code =3D code;
> >> +
> >> +                       struct udphdr *uh =3D udp_hdr(skb);
> >> +                       if (proto_4 !=3D IPPROTO_UDP || (u8 *)uh < skb->h=
> >ead ||
> >> +                               (u8 *)uh + sizeof(struct udphdr) > skb_ta=
> >il_pointer(skb)) {
> >> +                               __entry->sport =3D 0;
> >> +                               __entry->dport =3D 0;
> >> +                               __entry->ulen =3D 0;
> >> +                       } else {
> >> +                               __entry->sport =3D ntohs(uh->source);
> >> +                               __entry->dport =3D ntohs(uh->dest);
> >> +                               __entry->ulen =3D ntohs(uh->len);
> >> +                       }
> >> +
> >> +                       p32 =3D (__be32 *) __entry->saddr;
> >> +                       *p32 =3D iph->saddr;
> >> +
> >> +                       p32 =3D (__be32 *) __entry->daddr;
> >> +                       *p32 =3D iph->daddr;
> >> +               ),
> >> +
> >> +               TP_printk("icmp_send: type=3D%d, code=3D%d. From %pI4:%u =
> >to %pI4:%u ulen=3D%d skbaddr=3D%p",
> >> +                       __entry->type, __entry->code,
> >> +                       __entry->saddr, __entry->sport, __entry->daddr,
> >> +                       __entry->dport, __entry->ulen, __entry->skbaddr)
> >> +);
> >> +
> >> +#endif /* _TRACE_ICMP_H */
> >> +
> >> +/* This part must be outside protection */
> >> +#include <trace/define_trace.h>
> >> \ No newline at end of file
> >> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> >> index 8cebb476b3ab..224551d75c02 100644
> >> --- a/net/ipv4/icmp.c
> >> +++ b/net/ipv4/icmp.c
> >> @@ -92,6 +92,8 @@
> >>  #include <net/inet_common.h>
> >>  #include <net/ip_fib.h>
> >>  #include <net/l3mdev.h>
> >> +#define CREATE_TRACE_POINTS
> >> +#include <trace/events/icmp.h>
> >>
> >>  /*
> >>   *     Build xmit assembly blocks
> >> @@ -672,6 +674,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, in=
> >t code, __be32 info,
> >>                 }
> >>         }
> >>
> >> +       trace_icmp_send(skb_in, type, code);
> >> +
> >>         /* Needed by both icmp_global_allow and icmp_xmit_lock */
> >>         local_bh_disable();
> >>
> >> --
> >> 2.25.1
>
>

