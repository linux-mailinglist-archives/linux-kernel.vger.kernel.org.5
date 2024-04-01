Return-Path: <linux-kernel+bounces-126734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75B1893C11
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E14FB20C10
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403A0481AB;
	Mon,  1 Apr 2024 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D14uOWUE"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AA34206B;
	Mon,  1 Apr 2024 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980721; cv=none; b=ZFT0OC9V46JqkZgjNWJWHlMXvwiOOozhChZA5QQoYvt94xxUzhu5q8+G1BGSp42wcObpdZeSmq4XxuepzM2nVBM5GU4om+Xiggq8F3VQ9RfkEjSipRQyYfsbu2aSwmcLK5yczuXH9Ra8k5J9p76ZP7m/ql+Di7X8VPpEr4kn2Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980721; c=relaxed/simple;
	bh=wbLRWHYfQnGr6cjCI9URVKXrdXoE7cUWFPQivJS4lHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WeUzAwY9xALSWGkQ2xQpzKyBCYRxnOo/ldnvrC76TLsfZxS/esn/8FPFYvjq17CBbHoNiEgRGZpaB4mLtkNwV8GABOkpzrsYOhc8ASAi94U8IW6in36IAAHSlHK99ykGO43WoFmqT52pw6GzQarWv/06BaZxhKWQKnbbhS3RZ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D14uOWUE; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4e0e3ef357so517599066b.2;
        Mon, 01 Apr 2024 07:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711980717; x=1712585517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1HRNapdkHpftQK4zhHUzmes+knNVdNTnVHk+ZLc5oA=;
        b=D14uOWUE3BvYCDk0FGpraRz6ecgQOT1awTDcD3V40zh4BTcgwlMKWp9ZfSzhY1/gV5
         4xypjC7x1GxiftYadU96sCXt7Mo5ZpDkPvTF3M61jNraTx92DfSReGMRCZ++/r2n042S
         2rX9DzodTNTjlUEVP4LN5h+kmhdPfJjbybdCGg0AYZ4x23O1HsC6aCD8nbmM+P9DGj1C
         SoMSyGVr//RK1UemHvMzeUHIetAReEAVP/L8VwN7DZEsgVrr/wcCJE3Dp9I+P0P3WmpJ
         5JeIFL7RyeVTxL3HWWhtroBrBbf37YgKTM7fWPDeSDQmt6/tIqzV3IeIp6YtC8LdITuo
         6J4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711980717; x=1712585517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1HRNapdkHpftQK4zhHUzmes+knNVdNTnVHk+ZLc5oA=;
        b=ejLdlcTGxtpfDqIRIeX7TtZhr8M3ZlLhPEpK/BhIXPwHv6Mr2Yay5AIc9CMFaXf2Cb
         6jH0oo2QKld7ImgmcQXjnWPqqIZasu2RqZqIKhOvmahWa6jzcenTR06T9mCq0LQejFYv
         advTH3fPOIIgVqJJnqYIvIixoe1rfSFoJ6RsEX4p0BiYEoJ3/M/kAGle6DsDyJtqptul
         jsstuRBPjx/eXjaDKCxKqQ7JNPAD3tsvKprdTS8ZKGxfeRttgntFClxBRqEmE2sMOCCA
         9ZHpZ6VJLM59zKU+orkXc2IWcCxDxRLvSsoC5+b3kbOatQO94vcjezg5piBp5X5UZP8Q
         Cb/w==
X-Forwarded-Encrypted: i=1; AJvYcCWv8+5J//PhjqylZk+DwhrPWIvEhTq8xRt+Q+btzO5A9M9r7VUkzqJKoT0eOPEF+nIzD91lFQKZMOKgO/EF/RVpGUsGBz+DCj34xY5RI+EZuBtBS7328kIvT97zV8duSGbWtO6ayNx0Uf4jglQLfWZfbSZYCTjDjt4Nf9gteBKxmVki/7Vxhpjb
X-Gm-Message-State: AOJu0Yw6Q0A5zppNtb1lsMAx8qdXgbrs8nyF4jiP68B+d9VhbmmEnofD
	UZrVEyK1JXo3tVk6eGkQQ4rmvujps7h7/LmQ37lPiRqZUGQF4cZE3nC3ZSUBCkX1tpj9pdLTWoX
	GGNu4jfQbmuQGcSt7rBcikgCudwvqAIKOPmA=
X-Google-Smtp-Source: AGHT+IFhaBfoLulHyPCvFMoXzVD2HBKCHi9KQJhsA+oZVNtABXHKgGzHNQmu/oUnXP45pSmFQNJMg9r5Hi8LwRtFifI=
X-Received: by 2002:a17:906:274f:b0:a4e:2178:d91a with SMTP id
 a15-20020a170906274f00b00a4e2178d91amr6158738ejd.59.1711980716764; Mon, 01
 Apr 2024 07:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401203414179VCKI9yTVfrOp_Yjpupf90@zte.com.cn>
In-Reply-To: <20240401203414179VCKI9yTVfrOp_Yjpupf90@zte.com.cn>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 1 Apr 2024 22:11:20 +0800
Message-ID: <CAL+tcoAcagGKkzJLrgCmFRv52uBbdAN_ufspvmkbG2MaFw2_tQ@mail.gmail.com>
Subject: Re: Subject: [PATCH net-next v4] net/ipv4: add tracepoint for icmp_send
To: xu.xin16@zte.com.cn
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, dsahern@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, yang.yang29@zte.com.cn, he.peilin@zte.com.cn, 
	liu.chun2@zte.com.cn, jiang.xuexin@zte.com.cn, zhang.yunkai@zte.com.cn, 
	fan.yu9@zte.com.cn, qiu.yutan@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 8:34=E2=80=AFPM <xu.xin16@zte.com.cn> wrote:
>
> From: hepeilin <he.peilin@zte.com.cn>
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
> v3->v4:
> Some fixes according to
> https://lore.kernel.org/all/CANn89i+EFEr7VHXNdOi59Ba_R1nFKSBJzBzkJFVgCTdX=
Bx=3DYBg@mail.gmail.com/
> 1.Add legality check for UDP header in SKB.

I think my understanding based on what Eric depicted differs from you:
we're supposed to filter out those many invalid cases and only trace
the valid action of sending a icmp, so where to add a new tracepoint
is important instead of adding more checks in the tracepoint itself.
Please refer to what trace_tcp_retransmit_skb() does :)

Thanks,
Jason

> 2.Target this patch for net-next.
>
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
> ---
>  include/trace/events/icmp.h | 65 +++++++++++++++++++++++++++++++++++++
>  net/ipv4/icmp.c             |  4 +++
>  2 files changed, 69 insertions(+)
>  create mode 100644 include/trace/events/icmp.h
>
> diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
> new file mode 100644
> index 000000000000..7d5190f48a28
> --- /dev/null
> +++ b/include/trace/events/icmp.h
> @@ -0,0 +1,65 @@
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
> +                       struct udphdr *uh =3D udp_hdr(skb);
> +                       if (proto_4 !=3D IPPROTO_UDP || (u8 *)uh < skb->h=
ead ||
> +                               (u8 *)uh + sizeof(struct udphdr) > skb_ta=
il_pointer(skb)) {
> +                               __entry->sport =3D 0;
> +                               __entry->dport =3D 0;
> +                               __entry->ulen =3D 0;
> +                       } else {
> +                               __entry->sport =3D ntohs(uh->source);
> +                               __entry->dport =3D ntohs(uh->dest);
> +                               __entry->ulen =3D ntohs(uh->len);
> +                       }
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
> index 8cebb476b3ab..224551d75c02 100644
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
> 2.25.1

