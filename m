Return-Path: <linux-kernel+bounces-109600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA41881B46
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1071C215E8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6106FB6;
	Thu, 21 Mar 2024 02:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6Q6UHtS"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31BE17FD;
	Thu, 21 Mar 2024 02:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710989141; cv=none; b=FYFIpJ3T8l6HnGueq1K4FpGkp+j6Hq3QopLcAo8Uae4hFuJPM21QVRzoudlHWEJpHWJPC2XHyF5cvMKVNvxjecHp4EyQVFLAE7eytenFpEDQX4EsY8ZR8NErN6SZXohwxS+jvQHy7Yw0sc+576HBl0tJfnwrMHRRpFKU5YdkDdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710989141; c=relaxed/simple;
	bh=N/5e6Wo2NvNUp6BkAhcewLwS9AaNyGsynBAZFyDdAvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkZ5CvlAL+t2Et+vggLOLc65cjKyON511zxKKnfV3Nu7GpAJo1eLsqpH2ToT89dr/X6Ut2B+RpnVzCtFjUVx2t6NjXcDyKiic/QeoPfVg6msAXDblBtjdEE9zJ2ZxkI33OnFwtxBk6mo/sMUVoGAzZKPNZRBHYPnJBheV/3pg4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6Q6UHtS; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513dc99b709so669389e87.1;
        Wed, 20 Mar 2024 19:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710989138; x=1711593938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/N1nqPevCl9m3t5cemtmMWTvFAKvP6o30UTDsDnLhYY=;
        b=g6Q6UHtSyaPxOe7YD/QcVL7xzOmssXWaGNWtNLL3aCm9t/uPzcwsTVTja2xEdwpK69
         hgtKWmzJZZFI8slESoiU54UlVzapHEURNNrf1XdYgNsWGURbvGKcgDh0n4tsY6egeTnN
         ovcXT9unlo0NRbqoWR9Ycd5eMkZcUkFCme/ys40WpC0WMI5wEGyD9sl2a7x1FJmWTk/l
         vhxiUC8vnOc5fEZg9h7H3i+yV5GON9a2kAX19G5IV8gFvZjyghhCv1xNDY3W9Wi4lugU
         3nCIZb+32WJ8+WkAsE8rEZ8zIfPCkIYclrSObcU8FVWStSQYu36Gycac8cHm+VusoiNl
         snZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710989138; x=1711593938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/N1nqPevCl9m3t5cemtmMWTvFAKvP6o30UTDsDnLhYY=;
        b=POv+4iSoq8qQqBAy/wyBT+tDOi7STW8lIEXqfsnNolZ7Sd33n1Kmv2iamHNUB6gZ4X
         Or1nCVaE16Sd2wf0YXiyBzX6zaC93mIt+D4pDMzM7cvBmNcc7LdtVdp2CiZ9gK6iWEZE
         vkwsPj05cGWOH9tw+TZGuak9E24rnhwPOSy3ocBRMilDolkuqejxHqY5Auw73D5OMk2U
         z5qWcBqhtI73YvUp09oHTzjE+AbX28buw4ONMRWYenS+NWKDvgX8UBhlnL/ixTFOOj2x
         xyhS7+v6iqW1/tu/Gjw9pCY0wlUZJbIB2GaCJXxvw7Dy3GWNH0b8YyKcjx0oFPjCcsNZ
         SQTA==
X-Forwarded-Encrypted: i=1; AJvYcCXFlgPOXsviLzS20dfVnCNJbvQgpWW90icNVA+qVe/x28Evw7EfF7OuUaifu7soWPvzYXsZKNszTAlCGKWYyzCo4BegJJxVWbqXi4OR1bmOQOcNEVC+/GZ05uf+9zhO7Y4oGwXfl0HWQpGU0HBHBvnvCYi+XELsFdOTAPYXYFg3F1bPKnhN/Ke+
X-Gm-Message-State: AOJu0YxQSB/PPK3t8XA3n6JSmFE37niJlvtORu/c5+KdGmFqZ9ZnhLAS
	l1EmqA3tPBEVv9sVHA93GWsnejK+XyW86IKqM7D2cTnPkW3PT4LMTG2/QO2F6/6YBZLyqm0Ckzj
	j54+CcSrsxmBVbo+CnPKlNgxXNXn1ZKft
X-Google-Smtp-Source: AGHT+IF8BG8VC7B4QycQ5j6G55em6ar8SVHTiw4TNt5ZOoYm+HDKyXzhZWC8seECEPIrTyK8pB1UsUhXbqTXGhfzV2g=
X-Received: by 2002:a05:6512:ba3:b0:513:4705:a4f3 with SMTP id
 b35-20020a0565120ba300b005134705a4f3mr6870348lfv.65.1710989137570; Wed, 20
 Mar 2024 19:45:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403211010443485000@zte.com.cn>
In-Reply-To: <202403211010443485000@zte.com.cn>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 21 Mar 2024 10:45:00 +0800
Message-ID: <CAL+tcoAdZOKnHTbRnmrjtrhJynGfDy4xXvus1hh_UTbh5eSMTA@mail.gmail.com>
Subject: Re:  [PATCH v3] net/ipv4: add tracepoint for icmp_send
To: xu.xin16@zte.com.cn
Cc: edumazet@google.com, davem@davemloft.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, dsahern@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, yang.yang29@zte.com.cn, he.peilin@zte.com.cn, 
	liu.chun2@zte.com.cn, jiang.xuexin@zte.com.cn, zhang.yunkai@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 10:12=E2=80=AFAM <xu.xin16@zte.com.cn> wrote:
>
> From: he peilin <he.peilin@zte.com.cn>
>
>
> Introduce a tracepoint for icmp_send, which can help users to get more
>
> detail information conveniently when icmp abnormal events happen.
>
>
> 1. Giving an usecase example:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> When an application experiences packet loss due to an unreachable UDP
>
> destination port, the kernel will send an exception message through the
>
> icmp_send function. By adding a trace point for icmp_send, developers or
>
> system administrators can obtain detailed information about the UDP
>
> packet loss, including the type, code, source address, destination addres=
s,
>
> source port, and destination port. This facilitates the trouble-shooting
>
> of UDP packet loss issues especially for those network-service
>
> applications.
>
>
> 2. Operation Instructions:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>
> Switch to the tracing directory.
>
>         cd /sys/kernel/tracing
>
> Filter for destination port unreachable.
>
>         echo "type=3D=3D3 && code=3D=3D3" > events/icmp/icmp_send/filter
>
> Enable trace event.
>
>         echo 1 > events/icmp/icmp_send/enable
>
>
> 3. Result View:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  udp_client_erro-11370   [002] ...s.12   124.728002:
>
>  icmp_send: icmp_send: type=3D3, code=3D3.
>
>  From 127.0.0.1:41895 to 127.0.0.1:6666 ulen=3D23
>
>  skbaddr=3D00000000589b167a
>
>
> Changelog
>
> ---------
>
> v2->v3:
>
> Some fixes according to
>
> https://lore.kernel.org/all/20240319102549.7f7f6f53@gandalf.local.home/
>
> 1. Change the tracking directory to/sys/kernel/tracking.
>
> 2. Adjust the layout of the TP-STRUCT_entry parameter structure.
>
>
> v1->v2:
>
> Some fixes according to
>
> https://lore.kernel.org/all/CANn89iL-y9e_VFpdw=3DsZtRnKRu_tnUwqHuFQTJvJsv=
-nz1xPDw@mail.gmail.com/
>
> 1. adjust the trace_icmp_send() to more protocols than UDP.
>
> 2. move the calling of trace_icmp_send after sanity checks
>
> in __icmp_send().
>
>
> Signed-off-by: Peilin He<he.peilin@zte.com.cn>
>
> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
>
> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
>
> Cc: Liu Chun <liu.chun2@zte.com.cn>
>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>

The format of the whole patch looks strange... Did you send this patch
by using 'git send-email' instead of pasting the text and sending?

>
> ---
>
>  include/trace/events/icmp.h | 64 +++++++++++++++++++++++++++++++++++++
>
>  net/ipv4/icmp.c             |  4 +++
>
>  2 files changed, 68 insertions(+)
>
>  create mode 100644 include/trace/events/icmp.h
>
>
> diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
>
> new file mode 100644
>
> index 000000000000..2098d4b1b12e
>
> --- /dev/null
>
> +++ b/include/trace/events/icmp.h
>
> @@ -0,0 +1,64 @@
>
> +/* SPDX-License-Identifier: GPL-2.0 */
>
> +#undef TRACE_SYSTEM
>
> +#define TRACE_SYSTEM icmp
>
> +
>
> +#if !defined(_TRACE_ICMP_H) || defined(TRACE_HEADER_MULTI_READ)
>
> +#define _TRACE_ICMP_H
>
> +
>
> +#include <linux/icmp.h>
>
> +#include <linux/tracepoint.h>
>
> +
>
> +TRACE_EVENT(icmp_send,
>
> +
>
> + TP_PROTO(const struct sk_buff *skb, int type, int code),
>
> +
>
> + TP_ARGS(skb, type, code),
>
> +
>
> + TP_STRUCT__entry(
>
> + __field(const void *, skbaddr)
>
> + __field(int, type)
>
> + __field(int, code)
>
> + __array(__u8, saddr, 4)
>
> + __array(__u8, daddr, 4)
>
> + __field(__u16, sport)
>
> + __field(__u16, dport)
>
> + __field(unsigned short, ulen)
>
> + ),
>
> +
>
> + TP_fast_assign(
>
> + struct iphdr *iph =3D ip_hdr(skb);
>
> + int proto_4 =3D iph->protocol;
>
> + __be32 *p32;
>
> +
>
> + __entry->skbaddr =3D skb;
>
> + __entry->type =3D type;
>
> + __entry->code =3D code;
>
> +
>
> + if (proto_4 =3D=3D IPPROTO_UDP) {
>
> + struct udphdr *uh =3D udp_hdr(skb);
>
> + __entry->sport =3D ntohs(uh->source);
>
> + __entry->dport =3D ntohs(uh->dest);
>
> + __entry->ulen =3D ntohs(uh->len);
>
> + } else {
>
> + __entry->sport =3D 0;
>
> + __entry->dport =3D 0;
>
> + __entry->ulen =3D 0;
>
> + }
>
> +
>
> + p32 =3D (__be32 *) __entry->saddr;
>
> + *p32 =3D iph->saddr;
>
> +
>
> + p32 =3D (__be32 *) __entry->daddr;
>
> + *p32 =3D iph->daddr;
>
> + ),
>
> +
>
> + TP_printk("icmp_send: type=3D%d, code=3D%d. From %pI4:%u to %pI4:%u ule=
n=3D%d skbaddr=3D%p",
>
> + __entry->type, __entry->code,
>
> + __entry->saddr, __entry->sport, __entry->daddr,
>
> + __entry->dport, __entry->ulen, __entry->skbaddr)
>
> +);
>
> +
>
> +#endif /* _TRACE_ICMP_H */
>
> +
>
> +/* This part must be outside protection */
>
> +#include <trace/define_trace.h>
>
> \ No newline at end of file
>
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
>
> index e63a3bf99617..21fb41257fe9 100644
>
> --- a/net/ipv4/icmp.c
>
> +++ b/net/ipv4/icmp.c
>
> @@ -92,6 +92,8 @@
>
>  #include <net/inet_common.h>
>
>  #include <net/ip_fib.h>
>
>  #include <net/l3mdev.h>
>
> +#define CREATE_TRACE_POINTS
>
> +#include <trace/events/icmp.h>
>
>
>
>  /*
>
>   * Build xmit assembly blocks
>
> @@ -672,6 +674,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, in=
t code, __be32 info,
>
>   }
>
>   }
>
>
>
> + trace_icmp_send(skb_in, type, code);
>
> +
>
>   /* Needed by both icmp_global_allow and icmp_xmit_lock */
>
>   local_bh_disable();
>
>
>
> --
>
> 2.44.0
>
>
>
>
>

