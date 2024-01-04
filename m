Return-Path: <linux-kernel+bounces-17158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA5B824908
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941F7284708
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11322C1A3;
	Thu,  4 Jan 2024 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X21ajHt0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C71D2C19E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704396546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzdpbLzRSybGTRpqXk8VlT+P/oN9oKWuUtZZc/JbNL8=;
	b=X21ajHt0QLpTQUcUhD49RnmpfwQmT8mjV2jcXghw0yO8G25lN3OIVaNzMd34syUhKgpsAv
	Yb5qKBOeMxPxUdYYZz4N4yXGyzW60jy4cUc2sPDXcJiGtD9tQuBLHA20i4nEy22zxlLro0
	w1qBuR/l780Vl2i0vmpx0evQtV948Ec=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-_BFIHxMnN3Czx1UcFHeJIw-1; Thu, 04 Jan 2024 14:29:05 -0500
X-MC-Unique: _BFIHxMnN3Czx1UcFHeJIw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a28102bc0f1so42351466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704396544; x=1705001344;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzdpbLzRSybGTRpqXk8VlT+P/oN9oKWuUtZZc/JbNL8=;
        b=i/hrw5gy5fGOobWPikp00tZeCNtUL+1l9GmRTMa6E9FveNeNdNhKK8B7yTwDI+IEx8
         qDxp7xc4BYYZW5HNP6l83RMcwmX6Tk8n6P3hiesWG+f2RIzUNu/90c0U26hLbqJ4JITg
         j3t1RJsO0QZ4v5XEg51UlfvQPKPF8rTfzT1S6pxQ72OsMzqrFVds8NpbQDWHQ3MIFj6K
         w5NeUcGsxZZPqjHfEqkWNjeSjFAr6RlSeIoNZmhHU4HTD8iMfxAOxKa3GiiG1f2fugm/
         upQ1ryDaDWgIzdhobCURYmoxHxYHWAX0LNry33u9reOr38S6FBEU8OmnRFlgO3qIHPcT
         0UzA==
X-Gm-Message-State: AOJu0Yy8mzFG0VY0/3VzkBII9+za3bEslEHLApPf/nv1Lgyoi+ni1iFz
	TTSsPwuLxv9S7emtLlCh0h/ouiopLVWbDVkWkujs3lFNhBJz4uv7MxJ4cdQDXpmIUM68ClD12mM
	hkndB6kphD+mtDhW3NkSy5mFJgydWiugT
X-Received: by 2002:a17:906:5593:b0:a28:c9d3:19e9 with SMTP id y19-20020a170906559300b00a28c9d319e9mr644140ejp.35.1704396543821;
        Thu, 04 Jan 2024 11:29:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfRPAvVjv1Ghy6b/wYmHHEScqTTPe8oRWrCF252uRvj2qDd419LelIZWekiGH82vbbNjuGWg==
X-Received: by 2002:a17:906:5593:b0:a28:c9d3:19e9 with SMTP id y19-20020a170906559300b00a28c9d319e9mr644128ejp.35.1704396543502;
        Thu, 04 Jan 2024 11:29:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id m13-20020a170906160d00b00a27051a9eb6sm9539572ejd.148.2024.01.04.11.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 11:29:03 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8CC92100FC3D; Thu,  4 Jan 2024 20:29:02 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Network Development
 <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Boqun
 Feng <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Eric
 Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, Will
 Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, Hao
 Luo <haoluo@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Jiri
 Pirko <jiri@resnulli.us>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Ronak
 Doshi <doshir@vmware.com>, Song Liu <song@kernel.org>, Stanislav Fomichev
 <sdf@google.com>, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 15/24] net: Use nested-BH locking for XDP
 redirect.
In-Reply-To: <CAADnVQKJBpvfyvmgM29FLv+KpLwBBRggXWzwKzaCT9U-4bgxjA@mail.gmail.com>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
 <20231215171020.687342-16-bigeasy@linutronix.de>
 <CAADnVQKJBpvfyvmgM29FLv+KpLwBBRggXWzwKzaCT9U-4bgxjA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 04 Jan 2024 20:29:02 +0100
Message-ID: <87r0iw524h.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Dec 15, 2023 at 9:10=E2=80=AFAM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 5a0f6da7b3ae5..5ba7509e88752 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -3993,6 +3993,7 @@ sch_handle_ingress(struct sk_buff *skb, struct pac=
ket_type **pt_prev, int *ret,
>>                 *pt_prev =3D NULL;
>>         }
>>
>> +       guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
>>         qdisc_skb_cb(skb)->pkt_len =3D skb->len;
>>         tcx_set_ingress(skb, true);
>>
>> @@ -4045,6 +4046,7 @@ sch_handle_egress(struct sk_buff *skb, int *ret, s=
truct net_device *dev)
>>         if (!entry)
>>                 return skb;
>>
>> +       guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
>>         /* qdisc_skb_cb(skb)->pkt_len & tcx_set_ingress() was
>>          * already set by the caller.
>>          */
>> @@ -5008,6 +5010,7 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, stru=
ct sk_buff *skb)
>>                 u32 act;
>>                 int err;
>>
>> +               guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
>>                 act =3D netif_receive_generic_xdp(skb, &xdp, xdp_prog);
>>                 if (act !=3D XDP_PASS) {
>>                         switch (act) {
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 7c9653734fb60..72a7812f933a1 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -4241,6 +4241,7 @@ static const struct bpf_func_proto bpf_xdp_adjust_=
meta_proto =3D {
>>   */
>>  void xdp_do_flush(void)
>>  {
>> +       guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
>>         __dev_flush();
>>         __cpu_map_flush();
>>         __xsk_map_flush();
>> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
>> index a94943681e5aa..74b88e897a7e3 100644
>> --- a/net/core/lwt_bpf.c
>> +++ b/net/core/lwt_bpf.c
>> @@ -44,6 +44,7 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf=
_lwt_prog *lwt,
>>          * BPF prog and skb_do_redirect().
>>          */
>>         local_bh_disable();
>> +       local_lock_nested_bh(&bpf_run_lock.redirect_lock);
>>         bpf_compute_data_pointers(skb);
>>         ret =3D bpf_prog_run_save_cb(lwt->prog, skb);
>>
>> @@ -76,6 +77,7 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf=
_lwt_prog *lwt,
>>                 break;
>>         }
>>
>> +       local_unlock_nested_bh(&bpf_run_lock.redirect_lock);
>>         local_bh_enable();
>>
>>         return ret;
>> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
>> index 1976bd1639863..da61b99bc558f 100644
>> --- a/net/sched/cls_api.c
>> +++ b/net/sched/cls_api.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/jhash.h>
>>  #include <linux/rculist.h>
>>  #include <linux/rhashtable.h>
>> +#include <linux/bpf.h>
>>  #include <net/net_namespace.h>
>>  #include <net/sock.h>
>>  #include <net/netlink.h>
>> @@ -3925,6 +3926,7 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qeven=
t *qe, struct Qdisc *sch, stru
>>
>>         fl =3D rcu_dereference_bh(qe->filter_chain);
>>
>> +       guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
>>         switch (tcf_classify(skb, NULL, fl, &cl_res, false)) {
>>         case TC_ACT_SHOT:
>>                 qdisc_qstats_drop(sch);
>
> Here and in all other places this patch adds locks that
> will kill performance of XDP, tcx and everything else in networking.
>
> I'm surprised Jesper and other folks are not jumping in with nacks.
> We measure performance in nanoseconds here.
> Extra lock is no go.
> Please find a different way without ruining performance.

I'll add that while all this compiles out as no-ops on !PREEMPT_RT, I do
believe there are people who are using XDP on PREEMPT_RT kernels and
still expect decent performance. And to achieve that it is absolutely
imperative that we can amortise expensive operations (such as locking)
over multiple packets.

I realise there's a fundamental trade-off between the amount of
amortisation and the latency hit that we take from holding locks for
longer, but tuning the batch size (while still keeping some amount of
batching) may be a way forward? I suppose Jakub's suggestion in the
other part of the thread, of putting the locks around napi->poll(), is a
step towards something like this.

-Toke


