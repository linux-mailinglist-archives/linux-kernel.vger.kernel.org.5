Return-Path: <linux-kernel+bounces-105190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D74B87DA53
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 14:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C3A1F219BB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 13:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5E318EA2;
	Sat, 16 Mar 2024 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHgwBOao"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADC128EA;
	Sat, 16 Mar 2024 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710596837; cv=none; b=F1JmaTtJ9Pr6KboG/FgK8IfJANN6dxT2VVZ/tUSx4c9mdHj6LTBMXQWPux1Bpgk4yLka7Km++w8hXDTp4c8FX6J01gJS3r/azbc3fSyIKIA0LX2DfQDYnakzDu3v4vEg+UjWtqP+6oPZdrDvTZiBo+ojW2IJI1ciPbccLpE73i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710596837; c=relaxed/simple;
	bh=napWyiTbWmBdWfPift5N3RnrVqOix92yBUw3KFQ4zVM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=e32reR7Y8+XZ+41z4P7ZCHu853CL+Ku0LKIji+O5F5XKPV3Uv5IKPE7j20SIbhY/Esdc0+455AGW/bhHgfa15bhBhJKn9weZ8/7Xb2VJdxiHbMIDMs+Xb+djHuPFLXl/J/i5njrN0bohIHWjEGKDN/l2XdhKRXZeXPfB6gqNxV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHgwBOao; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-690b100da62so20555526d6.1;
        Sat, 16 Mar 2024 06:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710596835; x=1711201635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HD4PEZvlXMX0Q1WWJJMKYexZ239jcjIn+yqUTQFDVjw=;
        b=IHgwBOao5L2apJKoEap+PSr/W9h5a7k+LcPWciUnsPp89jBLlZp8kmyDsvAtw1hdra
         ZK35fxDoM7BWEAwxDwD2+Ubgr80uYOnH1qorg9PFREMP56xSjin9mau8b7lapaSckmRo
         2qa6C7/CPEUpU8GK3UvkuGjrTG2BszEFHj7AEPQy0OfcM26LxFzSeyV1RR5XsJ8cNw52
         NReNx8truQLQY/hBoma8K7Kz7rNmn6U1gelJ6TuQVG1GxNSbFkIBA6shIaUlqDwdvATa
         W3IOIdpkAAGGBnuzcOCB1gA+LU/igpxK+o7MhNpRgY86R+8qiC3EDSH5a5rrP+IxxtqL
         /wuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710596835; x=1711201635;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HD4PEZvlXMX0Q1WWJJMKYexZ239jcjIn+yqUTQFDVjw=;
        b=jhh4ircR6ychrwbWSx4cjM6TaXp48MorxHYol5zDRWY3qWhtAEpLBJdkUc5B6dSOST
         vyqIV5OT69ppSEOwSMDdXvbswiZVBlyenID56qGMh6nhNwro419X3wPojd/pHei8bxzs
         pU8bYaReSc8ZoGZVhLJrGjmm3q/ACMWnFtyv58bIGrJJAtc3yV1U8rZI28YnLRqWoH+9
         SQM7pKoF6n1lvGWkzRZNZPewZyUWxPJTMcTBmb+rKyV1YR0wABOC6VyRrTXV2/qkRkDA
         VRdg+PtA7gqvmhDBjGI6dkqJOyAb3uyItqdduxoHNB1svjdNYn97lGjQMkafCwLd2/OV
         2exA==
X-Forwarded-Encrypted: i=1; AJvYcCUAF6F5DiMpntk6DoWDhjtdM8TPCe6uPVGGWVc5+K+GqIUCkHGpj/SEV75fNCIRuAdQagncZrfEcJIBmimy2dOmtXfXUhdm4q7BV+lA
X-Gm-Message-State: AOJu0YyjeiiKbgDCqpoPANzfMOV+/MYoqx2HxZ4EXR1sKiEZQEIGYhJE
	Zdxacp8aAmKNxVmNm+I9i0k9VNGHIsdps6ukMwNsRs55NT3UVI9vFQX8KvEgjU4=
X-Google-Smtp-Source: AGHT+IHXPaYt87KqnrNIb37eLSCouerHDzlp7ed2X7VWIRJA6eAIkdr/L71TP5BPF5kGXr1/Akt/nw==
X-Received: by 2002:a05:622a:4e93:b0:430:a7c4:5e64 with SMTP id dj19-20020a05622a4e9300b00430a7c45e64mr6922950qtb.60.1710596834837;
        Sat, 16 Mar 2024 06:47:14 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id bq27-20020a05622a1c1b00b0042f068d3d8asm741853qtb.43.2024.03.16.06.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 06:47:14 -0700 (PDT)
Date: Sat, 16 Mar 2024 09:47:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 =?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <65f5a2e1ed02e_6ef3e29463@willemb.c.googlers.com.notmuch>
In-Reply-To: <ee5fb4ca84598f302f44ca9d4182d6f5b796232f.camel@mediatek.com>
References: <20240313133402.9027-1-shiming.cheng@mediatek.com>
 <e826f337c3db612852c5f543d123ee53adc885bb.camel@redhat.com>
 <ee5fb4ca84598f302f44ca9d4182d6f5b796232f.camel@mediatek.com>
Subject: Re: [PATCH net] udp: fix segmentation crash for untrusted source
 packet
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lena Wang (=E7=8E=8B=E5=A8=9C) wrote:
> On Wed, 2024-03-13 at 16:41 +0100, Paolo Abeni wrote:
> >  	 =

> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Wed, 2024-03-13 at 21:34 +0800, Shiming Cheng wrote:
> > > Kernel exception is reported when making udp frag list
> > segmentation.
> > > Backtrace is as below:
> > >     at out/android15-6.6/kernel-6.6/kernel-
> > 6.6/net/ipv4/udp_offload.c:229
> > >     at out/android15-6.6/kernel-6.6/kernel-
> > 6.6/net/ipv4/udp_offload.c:262
> > > features=3Dfeatures@entry=3D19, is_ipv6=3Dfalse)
> > >     at out/android15-6.6/kernel-6.6/kernel-
> > 6.6/net/ipv4/udp_offload.c:289
> > > features=3D19)
> > >     at out/android15-6.6/kernel-6.6/kernel-
> > 6.6/net/ipv4/udp_offload.c:399
> > > features=3D19)
> > >     at out/android15-6.6/kernel-6.6/kernel-
> > 6.6/net/ipv4/af_inet.c:1418
> > > skb@entry=3D0x0, features=3D19, features@entry=3D0)
> > >     at out/android15-6.6/kernel-6.6/kernel-6.6/net/core/gso.c:53
> > > tx_path=3D<optimized out>)
> > >     at out/android15-6.6/kernel-6.6/kernel-6.6/net/core/gso.c:124
> > =

> > A full backtrace would help better understanding the issue.
> =

> Below is full backtrace:
>  [ 1100.812205][    C3] CPU: 3 PID: 0 Comm: swapper/3 Tainted:
> G        W  OE      6.6.17-android15-0-g380371ea9bf1 #1
>  [ 1100.812211][    C3] Hardware name: MT6991(ENG) (DT)
>  [ 1100.812215][    C3] Call trace:
>  [ 1100.812218][    C3]  dump_backtrace+0xec/0x138
>  [ 1100.812222][    C3]  show_stack+0x18/0x24
>  [ 1100.812226][    C3]  dump_stack_lvl+0x50/0x6c
>  [ 1100.812232][    C3]  dump_stack+0x18/0x24
>  [ 1100.812237][    C3]  mrdump_common_die+0x24c/0x388 [mrdump]
>  [ 1100.812259][    C3]  ipanic_die+0x20/0x34 [mrdump]
>  [ 1100.812269][    C3]  notifier_call_chain+0x90/0x174
>  [ 1100.812275][    C3]  notify_die+0x50/0x8c
>  [ 1100.812279][    C3]  die+0x94/0x308
>  [ 1100.812283][    C3]  __do_kernel_fault+0x240/0x26c
>  [ 1100.812288][    C3]  do_page_fault+0xa0/0x48c
>  [ 1100.812293][    C3]  do_translation_fault+0x38/0x54
>  [ 1100.812297][    C3]  do_mem_abort+0x58/0x104
>  [ 1100.812302][    C3]  el1_abort+0x3c/0x5c
>  [ 1100.812307][    C3]  el1h_64_sync_handler+0x54/0x90
>  [ 1100.812313][    C3]  el1h_64_sync+0x68/0x6c
>  [ 1100.812317][    C3]  __udp_gso_segment+0x298/0x4d4
>  [ 1100.812322][    C3]  udp4_ufo_fragment+0x130/0x174
>  [ 1100.812326][    C3]  inet_gso_segment+0x164/0x330
>  [ 1100.812330][    C3]  skb_mac_gso_segment+0xc4/0x13c
>  [ 1100.812335][    C3]  __skb_gso_segment+0xc4/0x120
>  [ 1100.812339][    C3]  udp_rcv_segment+0x50/0x134
>  [ 1100.812344][    C3]  udp_queue_rcv_skb+0x74/0x114
>  [ 1100.812348][    C3]  udp_unicast_rcv_skb+0x94/0xac
>  [ 1100.812353][    C3]  __udp4_lib_rcv+0x3e0/0x818
>  [ 1100.812358][    C3]  udp_rcv+0x20/0x30
>  [ 1100.812362][    C3]  ip_protocol_deliver_rcu+0x194/0x368
>  [ 1100.812368][    C3]  ip_local_deliver+0xe4/0x184
>  [ 1100.812373][    C3]  ip_rcv+0x90/0x118
>  [ 1100.812378][    C3]  __netif_receive_skb+0x74/0x124
>  [ 1100.812383][    C3]  process_backlog+0xd8/0x18c
>  [ 1100.812388][    C3]  __napi_poll+0x5c/0x1fc
>  [ 1100.812392][    C3]  net_rx_action+0x150/0x334
>  [ 1100.812397][    C3]  __do_softirq+0x120/0x3f4
>  [ 1100.812401][    C3]  ____do_softirq+0x10/0x20
>  [ 1100.812405][    C3]  call_on_irq_stack+0x3c/0x74
>  [ 1100.812410][    C3]  do_softirq_own_stack+0x1c/0x2c
>  [ 1100.812414][    C3]  __irq_exit_rcu+0x5c/0xd4
>  [ 1100.812418][    C3]  irq_exit_rcu+0x10/0x1c
>  [ 1100.812422][    C3]  el1_interrupt+0x38/0x58
>  [ 1100.812428][    C3]  el1h_64_irq_handler+0x18/0x24
>  [ 1100.812434][    C3]  el1h_64_irq+0x68/0x6c
>  [ 1100.812437][    C3]  arch_local_irq_enable+0x4/0x8
>  [ 1100.812443][    C3]  cpuidle_enter+0x38/0x54
>  [ 1100.812449][    C3]  do_idle+0x198/0x294
>  [ 1100.812454][    C3]  cpu_startup_entry+0x34/0x3c
>  [ 1100.812459][    C3]  secondary_start_kernel+0x138/0x158
>  [ 1100.812465][    C3]  __secondary_switched+0xc0/0xc4
> =

> > > This packet's frag list is null while gso_type is not 0. Then it is=

> > treated
> > > as a GRO-ed packet and sent to segment frag list. Function call
> > path is
> > > udp_rcv_segment =3D> config features value
> > >     __udpv4_gso_segment  =3D> skb_gso_ok returns false. Here it
> > should be
> > >                             true. =

> > =

> > Why? If I read correctly the above, this is GSO packet landing in an
> > UDP socket with no UDP_GRO sockopt. The packet is expected to be
> > segmented again.
> > =

> Yes, it is GSO packet, however the fragment list of this GSO packet
> becomes NULL. As the occurrence rate is very low, we really don=E2=80=99=
t know
> why and when it becomes to be NULL. It happens both in cellular and
> wlan network and seems an unknown kernel issue.
>
> To avoid crash the packet should skip to be segmented when fraglist is
> null.
> =

> > >Failed reason is features doesn't
> > match
> > >                             gso_type.
> > >         __udp_gso_segment_list
> > >             skb_segment_list =3D> packet is linear with skb->next =3D=

> > NULL
> > >             __udpv4_gso_segment_list_csum =3D> use skb->next direct=
ly
> > and
> > >                                              crash happens
> > > =

> > > In rx-gro-list GRO-ed packet is set gso type as
> > > NETIF_F_GSO_UDP_L4 | NETIF_F_GSO_FRAGLIST in napi_gro_complete. In
> > gso
> > > flow the features should also set them to match with gso_type. Or
> > else it
> > > will always return false in skb_gso_ok. Then it can't discover the
> > > untrusted source packet and result crash in following function.
> > =

> > What is the 'untrusted source' here? I read the above as the packet
> > aggregation happened in the GRO engine???
> > =

> > Could you please give a complete description of the relevant
> > scenario?
> > =

> =

> According to the backtrace info, we infer it is a rx-frag_list GRO

It would be helpful to see an skb_dump. But if this happens rarely in
production, understood if that is not feasible.

The packet arrives on process_backlog, so still not sure how it is
produced.

> packet. Before sending into the UDP socket with no UDP_GRO sockopt, it
> seems enter "skb_condense" to trim it and loose his frag list. However
> it still keeps gso_type and gso_size. Then it continues to do
> skb_segment_list.
> =

> First crash happens in skb_segment_list. =

> This patch resolves the crash and lets the packet becomes a skb without=

> skb->next:
> https://lore.kernel.org/all/Y9gt5EUizK1UImEP@debian/
> Then crash moves to __udp_gso_sement_list -> skb_segment_list(finish)
> -> __udpv4_gso_segment_list_csum, it uses skb->next without check then
> crash.
> =

> =

> What we want to do is to drop this abnormal packet.

I think we want to deliver this packet if possible.

Thanks for the added context. So this is assumed to be a GSO skb with
SKB_GSO_FRAGLIST that somewhere lots its fraglist? That is the bug
if true.

You are suggesting that this happens in the skb_condense in
__udp_enqueue_schedule_skb?

If generated by GRO then on a device that has NETIF_F_GRO_FRAGLIST set.
So one workaround (not fix) is to disable that.

> So we set features
> NETIF_F_GSO_UDP_L4 |NETIF_F_GSO_FRAGLIST to match fixes: f2696099c6c6
> condation then drop it. =

