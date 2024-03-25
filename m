Return-Path: <linux-kernel+bounces-116540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFB988A07E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F8B1C33886
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CEE12DDAE;
	Mon, 25 Mar 2024 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYP5UeCC"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A55D13A87A;
	Mon, 25 Mar 2024 05:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711344914; cv=none; b=UTJQPjYDRY0UeericIzce0K7uGNf0ba6Z/ukdfs7CID/e1Ec8l2koFLV+0aUkQqOCkD7nT0enhBxFEt+oDbpbsHT/rEpJrjjURXtch5dqSIYy1OGKLJ+tifFjfjgU4YwfDrR7xyu0gZ43VBr69+VX5OAa54eedPP3W7LjBz4pv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711344914; c=relaxed/simple;
	bh=d20QRH5X333Ju5AHBuEMTEphX1Q4Il84/pqrEPWZ1kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPzgziFiV+HnnQ8y2XdOV9mBtNPVOwkYCgGdWuvIOfuCOwURL4VLFQcsB8TpT3/J5uJWL0NcLwRg7hPiaNKWtp3RcGVaUe82+pYQvBdWayyG8CpMotqLFoOZGdkckGDPuswcwFX/P8DzYdxKdNiIxl1pANiyz2537EobSuTc2Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYP5UeCC; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so8372568a12.1;
        Sun, 24 Mar 2024 22:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711344911; x=1711949711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sH8vPR15P7qwD/m3ELQLf1JLZG3KOt7s+huVlKMdA8g=;
        b=NYP5UeCCridAZs5E2G6aUszOpEOF9mqhW6+gzyD1y0xEcRNLOU+MHWBonI0OEHalRQ
         d9iT1M4oqABvF55Gn4OnTofn3ZlGi3zdTCsr1mfFHljMpFLaC93D7syqHCfbrjTXQne6
         NrfSsFfy7ecy0M7u2uFPB8chzLj72uC3iRV4lLuIsWGdADNciN/FswO9Gxut/XieBUjY
         TvEQj54xRw09nRZk83zCPxirvo3Hvt2MPVW2AVijyewylKM+44dxNxOuUKgrKCPT8PXu
         +rP/n50Qpjj0sdoaCP/uROoV1zkZWKEyRTQMxCpwzIGMNW/wSG5WVQG14kKDEd01c/Zu
         MKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711344911; x=1711949711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sH8vPR15P7qwD/m3ELQLf1JLZG3KOt7s+huVlKMdA8g=;
        b=Qmb2ktaf9pzfRPWcWnYdU9nRemKTxbReBhp+F3JTmQ8XabS8N/UZD1acZO1F2UfE/B
         M49Ug7LXrurGRSE/pn6vydW7zRMFyJXUAL7pB6GEvcInx50ujpLdY15qEBxlfvx3uhXp
         j7WLpG8IQPSpnvU3tAsSYBt4qnXggPyI4WcXKZL78F4lEEWiFOu+24jP9vz7FSM/xmxH
         O0dEWbaeCkX0OMoktCIW5oN/AmuFRizPboM84LgkIYMqHcIqC7+xK0eFPA4kA40bzZtq
         l45rto18ZPt8OwRKUFso1LUNqs9xRYvcKYVVLRdBP0/T+2ubkPY/Gm6zypa0Fk1kkrtU
         0diA==
X-Forwarded-Encrypted: i=1; AJvYcCWU1sL3fzYjMPw+/RzIMa8jLC1Pi3l5ntQTA2YdD6QpFxV83UEbw/hM1q+n9ywm46C8jZqTtarA3Lne232t0RH4lJWqZIahEXIt4UQcMqqsh5ss9VbQDXzZvQLnnJGUHr+ZhTuKXDfc2xzymHlcNLiolhZ7rs+FpuDGAWF6pNrnvqMoJgvcNnY7
X-Gm-Message-State: AOJu0YyyVEHM1VoxsquhJul+rheTxmFXhXoRqKaT+lkYzXNlyPod+caL
	Es5bl2P3+pcJmu+vfe4ErLag1IsjIImENETvxPrue1TlH8EMNWZggBUcQu2SwuFTUgPs3K1EAOC
	eCxmF1ijXLaF3pfFj+YfeFR/xvW8=
X-Google-Smtp-Source: AGHT+IH8yPUp7KEvIkr1REaPMEi0t5/gJin+soOYLrY/41sGJnFaQSeZQqkOGhAogYw1sh91jBlnACRj52naZ7LfhWs=
X-Received: by 2002:a17:907:7e92:b0:a47:5182:557b with SMTP id
 qb18-20020a1709077e9200b00a475182557bmr3416059ejc.7.1711344910479; Sun, 24
 Mar 2024 22:35:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoDT01EL7g_73Whrz753oEBuRtBrfmo2PHvTdifXKP4fhQ@mail.gmail.com>
 <20240325040429.3776225-1-peilinhe2020@163.com>
In-Reply-To: <20240325040429.3776225-1-peilinhe2020@163.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 25 Mar 2024 13:34:33 +0800
Message-ID: <CAL+tcoCOywxJ9VFs6PD4Wdsq1HvQ18YVhYX3DA5MfTSXA+Htug@mail.gmail.com>
Subject: Re: Re: [PATCH v3 resend] net/ipv4: add tracepoint for icmp_send
To: Peilin He <peilinhe2020@163.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	he.peilin@zte.com.cn, jiang.xuexin@zte.com.cn, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	liu.chun2@zte.com.cn, mhiramat@kernel.org, netdev@vger.kernel.org, 
	rostedt@goodmis.org, xu.xin16@zte.com.cn, yang.yang29@zte.com.cn, 
	zhang.yunkai@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 12:05=E2=80=AFPM Peilin He <peilinhe2020@163.com> w=
rote:
>
> >> ---------
> >> v2->v3:
> >> Some fixes according to
> >> https://lore.kernel.org/all/20240319102549.7f7f6f53@gandalf.local.home=
/
> >> 1. Change the tracking directory to/sys/kernel/tracking.
> >> 2. Adjust the layout of the TP-STRUCT_entry parameter structure.
> >>
> >> v1->v2:
> >> Some fixes according to
> >> https://lore.kernel.org/all/CANn89iL-y9e_VFpdw=3D3DsZtRnKRu_tnUwqHuFQT=
JvJsv=3D
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
> >
> >I think it would be better to target net-next tree since it's not a
> >fix or something else important.
> >
> OK. I would target it for net-next.
> >> ---
> >>  include/trace/events/icmp.h | 64 ++++++++++++++++++++++++++++++++++++=
+
> >>  net/ipv4/icmp.c             |  4 +++
> >>  2 files changed, 68 insertions(+)
> >>  create mode 100644 include/trace/events/icmp.h
> >>
> >> diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
> >> new file mode 100644
> >> index 000000000000..2098d4b1b12e
> >> --- /dev/null
> >> +++ b/include/trace/events/icmp.h
> >> @@ -0,0 +1,64 @@
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
> >> +               TP_PROTO(const struct sk_buff *skb, int type, int code=
),
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
> >> +                       struct iphdr *iph =3D3D ip_hdr(skb);
> >> +                       int proto_4 =3D3D iph->protocol;
> >> +                       __be32 *p32;
> >> +
> >> +                       __entry->skbaddr =3D3D skb;
> >> +                       __entry->type =3D3D type;
> >> +                       __entry->code =3D3D code;
> >> +
> >> +                       if (proto_4 =3D3D=3D3D IPPROTO_UDP) {
> >> +                               struct udphdr *uh =3D3D udp_hdr(skb);
> >> +                               __entry->sport =3D3D ntohs(uh->source)=
;
> >> +                               __entry->dport =3D3D ntohs(uh->dest);
> >> +                               __entry->ulen =3D3D ntohs(uh->len);
> >> +                       } else {
> >> +                               __entry->sport =3D3D 0;
> >> +                               __entry->dport =3D3D 0;
> >> +                               __entry->ulen =3D3D 0;
> >> +                       }
> >
> >What about using the TP_STORE_ADDR_PORTS_SKB macro to record the sport
> >and dport like the patch[1] did through extending the use of header
> >for TCP and UDP?
> >
> I believe patch[1] is a good idea as it moves the TCP protocol parsing
> previously done inside the TP_STORE_ADDR_PORTS_SKB macro to TP_fast_assig=
n,
> and extracts the TP_STORE_ADDR_PORTS_SKB macro into a common file,
> enabling support for both UDP and TCP protocol parsing simultaneously.
>
> However, patch[1] only extracts the source and destination addresses of
> the packet, but does not extract the source port and destination port,
> which limits the significance of my submitted patch.

No, please take a look at TP_STORE_ADDR_PORTS_SKB() macro again. It
records 4-tuples of the flow.

Thanks,
Jason

>
> Perhaps the patch[1] could be referenced for integration after it is merg=
ed.
> >And, I wonder what the use of tracing ulen of that skb?
> >
> The tracking of ulen is primarily aimed at ensuring the legality of recei=
ved
> UDP packets and providing developers with more detailed information
> on exceptions. See net/ipv4/udp.c:2494-2501.
> >[1]: https://lore.kernel.org/all/1c7156a3f164eb33ef3a25b8432e359f0bb60a8=
e.1=3D
> >710866188.git.balazs.scheidler@axoflow.com/
> >
> >Thanks,
> >Jason
> >
> >> +
> >> +                       p32 =3D3D (__be32 *) __entry->saddr;
> >> +                       *p32 =3D3D iph->saddr;
> >> +
> >> +                       p32 =3D3D (__be32 *) __entry->daddr;
> >> +                       *p32 =3D3D iph->daddr;
> >> +               ),
> >> +
> >> +               TP_printk("icmp_send: type=3D3D%d, code=3D3D%d. From %=
pI4:%u =3D
> >to %pI4:%u ulen=3D3D%d skbaddr=3D3D%p",
> >> +                       __entry->type, __entry->code,
> >> +                       __entry->saddr, __entry->sport, __entry->daddr=
,
> >> +                       __entry->dport, __entry->ulen, __entry->skbadd=
r)
> >> +);
> >> +
> >> +#endif /* _TRACE_ICMP_H */
> >> +
> >> +/* This part must be outside protection */
> >> +#include <trace/define_trace.h>
> >> \ No newline at end of file
> >> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> >> index e63a3bf99617..21fb41257fe9 100644
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
> >> @@ -672,6 +674,8 @@ void __icmp_send(struct sk_buff *skb_in, int type,=
 in=3D
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
> >> 2.44.0
> >>
>

