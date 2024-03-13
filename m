Return-Path: <linux-kernel+bounces-102441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7360587B204
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0AFA1F275A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79C046537;
	Wed, 13 Mar 2024 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqWQ4oy1"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296FF210E9;
	Wed, 13 Mar 2024 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358609; cv=none; b=Btfnga0XEdaR6Jqq8EpHE5aRoZ0LuwL1ssUW+PKLxLjJRJv9bmQYRLqMGiR1yNatRwxsZQCBo9QLiVFTQAkgqonb0nbVQSITKeE7VAqEgSLwtGYgry8BiVJyRftkgLDGKB2GhRRDydd9Ft4DdyfXc96u5y+1wZcjzuleAp8k8to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358609; c=relaxed/simple;
	bh=799tM95udsQ7H+IHk4Yau0GNh2KboPOpDuGINwz7Yjc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mjAQogXa/3tTpl6+xzcW+gJDZIAoyiDjAvGP9Vplo0aByLX9/g/ZL47LMexKjNArk2f3uA8ckErEmu81nVyn00UiGOpKt4iMjKLD58RUXmKwXUI6xOjCNvr40aLFKEHrCFRFcu3y6VaVKo3defrhq8mVDQBF09N4GH6TMxpUPpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqWQ4oy1; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-787edfea5adso8216385a.2;
        Wed, 13 Mar 2024 12:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710358607; x=1710963407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSQ074WaC5hJeQNbrmwBtZbI9ZTWGrNyYsVRhC9muZs=;
        b=MqWQ4oy1mKDDh+i28Xc614FT1TUP5lOemo2+/y6z8yXmG2Jh9EiFcskopZgJJqsrP0
         sVpHKTvwrOzoBbIdyBFzvmwmWColx4BmuIzHEAkVn9Gysvnz2MO6NeSey969sv9wysud
         jCr/iqF1HGi8vIxVNy3J6QCaYqvJGky2y5dA/cLKJIwDFRidgSJyPOMF3LGQx69cPUQs
         MOHc5e80AzfOTB6NDhjdjL3MUNWougdiIxrKLA9AWvHQgJtdeusFys5wPZpIyj9Heuky
         Q6BnGn6ANQNEYYgDrFKSsrhYuYzaq2pJ6enUbJ/6/vs7+1nkz4dCGMoUs3xz84h586Xo
         RHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710358607; x=1710963407;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rSQ074WaC5hJeQNbrmwBtZbI9ZTWGrNyYsVRhC9muZs=;
        b=KFsw7cs5aDdtrcUa6EgW4jJD+T1dLSePqBVWq1Z+2HPZ3u9dxvwPtXs0QsGWSDsvGp
         LGLsMM5xVOGYIc3clOGQBWiFEDy4pwXbL+FIMHK1Gh7uxYicSwm2mJkQKyW9IHA9w9HD
         H3PFw45HxlynEvyg1A/UVG6kOKeUeT6QQMoQemnUXYmCAY2tvkn+5TMezdOfM/4dbKlL
         SwMHXU3zh98avn3IQnKUdiDGSY8azY5mYk1/dy95mWgSyX4laD29o2F3Oi50cYaDmVqD
         nQuuHjL9+211GUmGjKK4kZgHPlgSba+Er4cL4Ra7qrHyKP2RzjCcXDHxKCPTVFQYZmfU
         clRA==
X-Forwarded-Encrypted: i=1; AJvYcCX5Y/w5eW3Q++Xq0tsyzmaocIjF65EDTYB7kIIBcrd3f5dRtwSh4CihEMLr7K/iahzzBGfpduaXG7OyE6a8RqroOtX4UevYUJoP+ChgWcIOJnN7vFtmM20taL1GDJXRVN7GHGPh99CDaXtL6hUeHpEC7Dy0g/zxkaHy
X-Gm-Message-State: AOJu0YxSrCJNJ1EIcaxjSXg6eX7vf2aVAL/44EhOrcjzOnol4xd583yj
	Urc2uapYgML2j6mh7AN1hZhNxySO01LW0PN5tivLe7Jy96+NrBx3
X-Google-Smtp-Source: AGHT+IEEpTuJaeyUoYMxU098Zc7iPktQRRlq5d+/M0Bslhapib+5W7stE9v60zOFyaPonDvY3aXMHw==
X-Received: by 2002:a05:620a:a85:b0:788:1b28:b977 with SMTP id v5-20020a05620a0a8500b007881b28b977mr895655qkg.39.1710358606948;
        Wed, 13 Mar 2024 12:36:46 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id bq10-20020a05620a468a00b0078813c3b1fdsm5050976qkb.19.2024.03.13.12.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 12:36:46 -0700 (PDT)
Date: Wed, 13 Mar 2024 15:36:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: kernel@quicinc.com, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 bpf <bpf@vger.kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>
Message-ID: <65f2004e65802_3d1e792943e@willemb.c.googlers.com.notmuch>
In-Reply-To: <28282905-065a-4233-a0a2-53aa9b85f381@linux.dev>
References: <20240301201348.2815102-1-quic_abchauha@quicinc.com>
 <2a4cb416-5d95-459d-8c1c-3fb225240363@linux.dev>
 <65f16946cd33e_344ff1294fc@willemb.c.googlers.com.notmuch>
 <28282905-065a-4233-a0a2-53aa9b85f381@linux.dev>
Subject: Re: [PATCH net-next v4] net: Re-use and set mono_delivery_time bit
 for userspace tstamp packets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Martin KaFai Lau wrote:
> On 3/13/24 1:52 AM, Willem de Bruijn wrote:
> > Martin KaFai Lau wrote:
> >> On 3/1/24 12:13 PM, Abhishek Chauhan wrote:
> >>> Bridge driver today has no support to forward the userspace timestamp
> >>> packets and ends up resetting the timestamp. ETF qdisc checks the
> >>> packet coming from userspace and encounters to be 0 thereby dropping
> >>> time sensitive packets. These changes will allow userspace timestamps
> >>> packets to be forwarded from the bridge to NIC drivers.
> >>>
> >>> Setting the same bit (mono_delivery_time) to avoid dropping of
> >>> userspace tstamp packets in the forwarding path.
> >>>
> >>> Existing functionality of mono_delivery_time remains unaltered here,
> >>> instead just extended with userspace tstamp support for bridge
> >>> forwarding path.
> >>
> >> The patch currently broke the bpf selftest test_tc_dtime:
> >> https://github.com/kernel-patches/bpf/actions/runs/8242487344/job/22541746675
> >>
> >> In particular, there is a uapi field __sk_buff->tstamp_type which currently has
> >> BPF_SKB_TSTAMP_DELIVERY_MONO to mean skb->tstamp has the MONO "delivery" time.
> >> BPF_SKB_TSTAMP_UNSPEC means everything else (this could be a rx timestamp at
> >> ingress or a delivery time set by user space).
> >>
> >> __sk_buff->tstamp_type depends on skb->mono_delivery_time which does not
> >> necessarily mean mono after this patch. I thought about fixing it on the bpf
> >> side such that reading __sk_buff->tstamp_type only returns
> >> BPF_SKB_TSTAMP_DELIVERY_MONO when the skb->mono_delivery_time is set and skb->sk
> >> is IPPROTO_TCP. However, it won't work because of bpf_skb_set_tstamp().
> >>
> >> There is a bpf helper, bpf_skb_set_tstamp(skb, tstamp,
> >> BPF_SKB_TSTAMP_DELIVERY_MONO). This helper changes both the skb->tstamp and the
> >> skb->mono_delivery_time. The expectation is this could change skb->tstamp in the
> >> ingress skb and redirect to egress sch_fq. It could also set a mono time to
> >> skb->tstamp where the udp sk->sk_clockid may not be necessary in mono and then
> >> bpf_redirect to egress sch_fq. When bpf_skb_set_tstamp(skb, tstamp,
> >> BPF_SKB_TSTAMP_DELIVERY_MONO) succeeds, reading __sk_buff->tstamp_type expects
> >> BPF_SKB_TSTAMP_DELIVERY_MONO also.
> >>
> >> I ran out of idea to solve this uapi breakage.
> >>
> >> I am afraid it may need to go back to v1 idea and use another bit
> >> (user_delivery_time) in the skb.
> > 
> > Is the only conflict when bpf_skb_set_tstamp is called for an skb from
> > a socket with sk_clockid set (and thus SO_TXTIME called)?
> 
> Right, because skb->mono_delivery_time does not mean skb->tstamp is mono now and 
> its interpretation depends on skb->sk->sk_clockid.
> 
> > Interpreting skb->tstamp as mono if skb->mono_delivery_time is set and
> > skb->sk is NULL is fine. This is the ingress to egress redirect case.
> 
> skb->sk == NULL is fine. I tried something like this in 
> bpf_convert_tstamp_type_read() for reading __sk_buff->tstamp_type:
> 
> __sk_buff->tstamp_type is BPF_SKB_TSTAMP_DELIVERY_MONO when:
> 
> 	skb->mono_delivery_time == 1 &&
> 	(!skb->sk ||
> 	 !sk_fullsock(skb->sk) /* tcp tw or req sk */ ||
> 	 skb->sk->sk_protocol == IPPROTO_TCP)
> 
> Not a small bpf instruction addition to bpf_convert_tstamp_type_read() but doable.
> 
> > 
> > I don't see an immediate use for this BPF function on egress where it
> > would overwrite an SO_TXTIME timestamp and now skb->tstamp is mono,
> > but skb->sk != NULL and skb->sk->sk_clockid != CLOCK_MONOTONIC.
> 
> The bpf prog may act as a traffic shaper that limits the bandwidth usage of all 
> outgoing packets (tcp/udp/...) by setting the mono EDT in skb->tstamp before 
> sending to the sch_fq.
> 
> I currently also don't have a use case for skb->sk->sk_clockid != 
> CLOCK_MONOTONIC. However, it is something that bpf_skb_set_tstamp() can do now 
> before queuing to sch_fq.
> 
> The container (in netns + veth) may use other sk_clockid/qdisc (e.g. sch_etf) 
> setup and the non mono skb->tstamp is not cleared now during dev_forward_skb() 
> between the veth pair.
> 
> > 
> > Perhaps bpf_skb_set_tstamp() can just fail if another delivery time is
> > already explicitly programmed?
> 
> This will change the existing bpf_skb_set_tstamp() behavior, so probably not 
> acceptable.
>
> > 
> >      skb->sk &&
> >      sock_flag(sk, SOCK_TXTIME) &&
> >      skb->sk->sk_clockid != CLOCK_MONOTONIC
> 
> > Either that, or unset SOCK_TXTIME to make sk_clockid undefined and
> > fall back on interpreting as monotonic.
> 
> Change sk->sk_flags in tc bpf prog? hmm... I am not sure this will work well also.
> 
> sock_valbool_flag(SOCK_TXTIME) should require a lock_sock() to make changes. The 
> tc bpf prog cannot take the lock_sock, so bpf_skb_set_tstamp() currently only 
> changes skb and does not change skb->sk.
> 
> I think changing sock_valbool_flag(SOCK_TXTIME) will also have a new user space 
> visible side effect. The sendmsg for cmsg with SCM_TXTIME will start failing 
> from looking at __sock_cmsg_send().
> 
> There may be a short period of disconnect between what is in sk->sk_flags and 
> what is set in skb->tstamp. e.g. what if user space does setsockopt(SO_TXTIME) 
> again after skb->tstamp is set by bpf. This could be considered a small glitch 
> for some amount of skb(s) until the user space settled on setsockopt(SO_TXTIME).
> 
> I think all this is crying for another bit in skb to mean user_delivery_time 
> (skb->tstamp depends on skb->sk->sk_clockid) while mono_delivery_time is the 
> mono time either set by kernel-tcp or bpf.

It does sound like the approach with least side effects.

If we're going to increase to two bits per skb, it's perhaps
better to just encode the (selected supported) CLOCK_ type, rather
than only supporting clockid through skb->sk->sk_clockid.

This BPF function is the analogue to SO_TXTIME. It is clearly
extensible to additional BPF_SKB_TSTAMP_DELIVERY_.. types. To
work with sch_etf, say.

> If we need to revert the 
> mono_delivery_time reuse patch later, we will need to revert the netdev patch 
> and the (to-be-made) bpf patch.


 



