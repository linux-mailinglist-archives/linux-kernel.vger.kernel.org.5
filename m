Return-Path: <linux-kernel+bounces-109622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63233881B78
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950802830F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058D779FD;
	Thu, 21 Mar 2024 03:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btUQVGzJ"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500F06FC5;
	Thu, 21 Mar 2024 03:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710991655; cv=none; b=SfuNZtJEtykRN/6iwmsZD27hnzOlwGRqsLOJ1QVwYODG75IdUPqr/gMp7zIczygUUQhrEFE2nwLz2+GU6g3fH0iG1Eis6sppHNOqKhv2ZCwcC+qoKOG1LLwqxUqrwN5k2pRJ0w1G0eiYlfjep4ZmY/5+DBSHYgjo33DukoOnJB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710991655; c=relaxed/simple;
	bh=UO2m/3D7rw7SLxsgtqiomCqlvIRUA/f5yTW9Iera+MA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWT4gMdGZEhsIAZy6VLUAujnE+CSMEPoxYCa7JiKlQzlRHwOHecgzUsg4exwNXGpO57iftpF3eK1uIRMwlguqZ18jWv+0DhAVyGgFo7qmeAjhxepOdPY7iAmw3ZszqwfOaz8awIMJGuAnKx/X7ZxCBgsT1Z35Fl36uLUbqkgCCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btUQVGzJ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a44665605f3so51122166b.2;
        Wed, 20 Mar 2024 20:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710991651; x=1711596451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJDX/rTBi2HV5o3VExpEmtDe3UbdtJSof+acduBhBno=;
        b=btUQVGzJ3FmAi6exQmMjZKC2DOR3SGCSX9b2bpD5x3uGvVMuh2qKaVEWoaJJKBYxQH
         tfPpNl753apJPj2FgUrXHSpE8YfWZaQtkYpfw2iCDoVI6AgS89JGaYBP+1dXacsP4chP
         qm2/GuZKaWq0tIKSAg5xmclyoXJRg3HFoUheV2N+Xyu2s+o4O7naTZzOxrz0Z8fc7aNX
         5yz8P/eqgMcvhxefMcGFO2NlTaC4HTVjbh+X/H6UpCY/GhuGyy+PMOAKbywxLcmBud5n
         prBdt1kiHgkfpv0C4VkpMFzwJ3ujfslUcstAZDEk90WFJXpRLbNxo2mJkpVzbWbug2mY
         HWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710991651; x=1711596451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJDX/rTBi2HV5o3VExpEmtDe3UbdtJSof+acduBhBno=;
        b=wA3IbpZrKgodfmIMglbOaBLn6TsbHbN6ATot/9M6rKyr4xuhKH1POUz6zWFklen51U
         dUEW6D0weEie8MbjB4NkIf/puDLeCX18MLUmLTXdTYmRZdzmOICd3JXAwY/vtqOSWMcw
         X6j/BAwCKKdu4BVTCgmGzxrz3O9q0M3rPmAFnflNYDvS4qW8AoWzPh4oppUWrk75/O3q
         Z4l8GaAQTFBlORvUagLmdA9E7br9W1zE8p4QT8iU5634LUTVQJO0pT0F52uuWhZn5akP
         thPpUYZpegTsOIK+kiNwIlniivjmhzLzju5K4XPc8Zl0ORyHkGXLs7HyvxS+dGJlB0jv
         +KVg==
X-Forwarded-Encrypted: i=1; AJvYcCVGa6DOOP+0fSjZwryKAXCC6d3ygo5X8SowT6oRfuaB22GxQBKOVUPPL7EXQJVQnLOheSp4QlUZZ7kP9RQI+EvY62sL30pkPJRahoPdP4E5QX5orxK/ai1vKgpruR1fYMPmQARuDRv0W3j5xAcDKGxEDE56FxGjm4AF0TYS7/doHtPCyFrXQ7Tk
X-Gm-Message-State: AOJu0Ywc8WhmdRx6jbpQSsKqaTSnCO1Wglba5Qmu/qtxAEPStc+fM3Fx
	n9R0+yOn3HxU8hioAPSKD/krCxBxG4d6yU8S6+D+e9fiKCKGJWq/a2j67V1vZZ6pa64CYSdCFm2
	+JTqAJcZAU5bbWXjoAmcn13bKQ74=
X-Google-Smtp-Source: AGHT+IEdbQNwyWUxzGBK2YoZXvUv2qfh/QtIKfnug3N/YagM3JPUiDnSWZo+IpcGh3v+XyOm2XygJeWDatmJ59HoqL4=
X-Received: by 2002:a17:906:3605:b0:a46:a1f7:156d with SMTP id
 q5-20020a170906360500b00a46a1f7156dmr2834216ejb.2.1710991651429; Wed, 20 Mar
 2024 20:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403211109183894466@zte.com.cn>
In-Reply-To: <202403211109183894466@zte.com.cn>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 21 Mar 2024 11:26:54 +0800
Message-ID: <CAL+tcoDT01EL7g_73Whrz753oEBuRtBrfmo2PHvTdifXKP4fhQ@mail.gmail.com>
Subject: Re: [PATCH v3 resend] net/ipv4: add tracepoint for icmp_send
To: xu.xin16@zte.com.cn
Cc: edumazet@google.com, davem@davemloft.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, dsahern@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, yang.yang29@zte.com.cn, he.peilin@zte.com.cn, 
	liu.chun2@zte.com.cn, jiang.xuexin@zte.com.cn, zhang.yunkai@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 11:09=E2=80=AFAM <xu.xin16@zte.com.cn> wrote:
>
> From: he peilin <he.peilin@zte.com.cn>
>
> Introduce a tracepoint for icmp_send, which can help users to get more
> detail information conveniently when icmp abnormal events happen.
>
> 1. Giving an usecase example:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> When an application experiences packet loss due to an unreachable UDP
> destination port, the kernel will send an exception message through the
> icmp_send function. By adding a trace point for icmp_send, developers or
> system administrators can obtain detailed information about the UDP
> packet loss, including the type, code, source address, destination addres=
s,
> source port, and destination port. This facilitates the trouble-shooting
> of UDP packet loss issues especially for those network-service
> applications.
>
> 2. Operation Instructions:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> Switch to the tracing directory.
>         cd /sys/kernel/tracing
> Filter for destination port unreachable.
>         echo "type=3D=3D3 && code=3D=3D3" > events/icmp/icmp_send/filter
> Enable trace event.
>         echo 1 > events/icmp/icmp_send/enable
>
> 3. Result View:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  udp_client_erro-11370   [002] ...s.12   124.728002:
>  icmp_send: icmp_send: type=3D3, code=3D3.
>  From 127.0.0.1:41895 to 127.0.0.1:6666 ulen=3D23
>  skbaddr=3D00000000589b167a
>
> Changelog
> ---------
> v2->v3:
> Some fixes according to
> https://lore.kernel.org/all/20240319102549.7f7f6f53@gandalf.local.home/
> 1. Change the tracking directory to/sys/kernel/tracking.
> 2. Adjust the layout of the TP-STRUCT_entry parameter structure.
>
> v1->v2:
> Some fixes according to
> https://lore.kernel.org/all/CANn89iL-y9e_VFpdw=3DsZtRnKRu_tnUwqHuFQTJvJsv=
-nz1xPDw@mail.gmail.com/
> 1. adjust the trace_icmp_send() to more protocols than UDP.
> 2. move the calling of trace_icmp_send after sanity checks
> in __icmp_send().
>
> Signed-off-by: Peilin He<he.peilin@zte.com.cn>
> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Liu Chun <liu.chun2@zte.com.cn>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>

I think it would be better to target net-next tree since it's not a
fix or something else important.

> ---
>  include/trace/events/icmp.h | 64 +++++++++++++++++++++++++++++++++++++
>  net/ipv4/icmp.c             |  4 +++
>  2 files changed, 68 insertions(+)
>  create mode 100644 include/trace/events/icmp.h
>
> diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
> new file mode 100644
> index 000000000000..2098d4b1b12e
> --- /dev/null
> +++ b/include/trace/events/icmp.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM icmp
> +
> +#if !defined(_TRACE_ICMP_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_ICMP_H
> +
> +#include <linux/icmp.h>
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(icmp_send,
> +
> +               TP_PROTO(const struct sk_buff *skb, int type, int code),
> +
> +               TP_ARGS(skb, type, code),
> +
> +               TP_STRUCT__entry(
> +                       __field(const void *, skbaddr)
> +                       __field(int, type)
> +                       __field(int, code)
> +                       __array(__u8, saddr, 4)
> +                       __array(__u8, daddr, 4)
> +                       __field(__u16, sport)
> +                       __field(__u16, dport)
> +                       __field(unsigned short, ulen)
> +               ),
> +
> +               TP_fast_assign(
> +                       struct iphdr *iph =3D ip_hdr(skb);
> +                       int proto_4 =3D iph->protocol;
> +                       __be32 *p32;
> +
> +                       __entry->skbaddr =3D skb;
> +                       __entry->type =3D type;
> +                       __entry->code =3D code;
> +
> +                       if (proto_4 =3D=3D IPPROTO_UDP) {
> +                               struct udphdr *uh =3D udp_hdr(skb);
> +                               __entry->sport =3D ntohs(uh->source);
> +                               __entry->dport =3D ntohs(uh->dest);
> +                               __entry->ulen =3D ntohs(uh->len);
> +                       } else {
> +                               __entry->sport =3D 0;
> +                               __entry->dport =3D 0;
> +                               __entry->ulen =3D 0;
> +                       }

What about using the TP_STORE_ADDR_PORTS_SKB macro to record the sport
and dport like the patch[1] did through extending the use of header
for TCP and UDP?

And, I wonder what the use of tracing ulen of that skb?

[1]: https://lore.kernel.org/all/1c7156a3f164eb33ef3a25b8432e359f0bb60a8e.1=
710866188.git.balazs.scheidler@axoflow.com/

Thanks,
Jason

> +
> +                       p32 =3D (__be32 *) __entry->saddr;
> +                       *p32 =3D iph->saddr;
> +
> +                       p32 =3D (__be32 *) __entry->daddr;
> +                       *p32 =3D iph->daddr;
> +               ),
> +
> +               TP_printk("icmp_send: type=3D%d, code=3D%d. From %pI4:%u =
to %pI4:%u ulen=3D%d skbaddr=3D%p",
> +                       __entry->type, __entry->code,
> +                       __entry->saddr, __entry->sport, __entry->daddr,
> +                       __entry->dport, __entry->ulen, __entry->skbaddr)
> +);
> +
> +#endif /* _TRACE_ICMP_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> \ No newline at end of file
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index e63a3bf99617..21fb41257fe9 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -92,6 +92,8 @@
>  #include <net/inet_common.h>
>  #include <net/ip_fib.h>
>  #include <net/l3mdev.h>
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/icmp.h>
>
>  /*
>   *     Build xmit assembly blocks
> @@ -672,6 +674,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, in=
t code, __be32 info,
>                 }
>         }
>
> +       trace_icmp_send(skb_in, type, code);
> +
>         /* Needed by both icmp_global_allow and icmp_xmit_lock */
>         local_bh_disable();
>
> --
> 2.44.0
>

