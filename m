Return-Path: <linux-kernel+bounces-155316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350DE8AE8C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4CC71F238F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67402136E38;
	Tue, 23 Apr 2024 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6WV7Nfz"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212CA135414;
	Tue, 23 Apr 2024 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880527; cv=none; b=gX2bR2EIgK8PFqoYZz/cgNiu2dnBAt9U+aLdHdW6PxtQGrKSbOLo9U8bheSuZN9Ry3ramCUkeNiotzoJufR8X8McF2vzAeGvaCgtB+vzFuKwG5UD3ZOa7SJmgRxBancM5vO4IvD/OH2N0Ia7YdE/HfTM5dER9pyUuPDZPhe9MTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880527; c=relaxed/simple;
	bh=OUYTndAoCM+FthM6P5fa9a8YL66q68Ixurc/W9KonDg=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dFQHOBIcM9fRTCz8/d1Fmrr4hN8sxAkZ4QcD3ZAnCjks019lygePePHW92wNjRuSo7HKGaBxePaKc3D86gCO8UGD0BSdNz7NnfJu8Um6VcJKdLFQhS59B1ki/TMjWfKgD11YNrxORXUOfhT+BeTb/BYlM3G5Y6098bYwGAQmKaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6WV7Nfz; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-79068f4da67so252062785a.0;
        Tue, 23 Apr 2024 06:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713880525; x=1714485325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfLsC5CFrZEwWNHHY1U8hjubI6WoeM3RTyfe8vQJAFU=;
        b=O6WV7Nfz4OKYCyLYy+jO3wVAk6BuPnJz4IWjHEYbXth3VYA7YW883kGjkMcXFpRIIr
         kbNNrRqM/lF8oi38Ah63qeKX85ei3HHUmySBUZZa0SeBxfKQrmWoqxxOOkAVBfKp3/Pj
         9djHV3VWOkFqTKRQmbzXe5QNZZFkeGwbUnfseWMkS08m3g9UCIdndjvvrIdKEYJQXEWk
         Lcb3ZLGyaE7XTAjAjo3v02ibaklKBPYoTWM6wNAF0jFsVNOyXapw0pQ9tKLF4pj4g9Vw
         WFMjj5ryIR2skebBE+tQEwYprEUjuCb50MA3AMGXhn5SxT4mKDDuBFheco0Ol6FMM2hm
         p80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713880525; x=1714485325;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfLsC5CFrZEwWNHHY1U8hjubI6WoeM3RTyfe8vQJAFU=;
        b=oOaud3b9R19nk1Zj8quCpD35I6cO6De1box7wqG2LFDYMxJsHe0vFzLiZbLBSjL7dd
         TQPphjmgTbEp83M/ZSIRh4+CE3WkR2IAB1jk2bDU1b0kKMroZYGI2PdDF8MYWMejFr2b
         mG8veRqffKc6IXZBzUaNtYuov7tHXBYuWBPnblSio08drhPz0z394Gvfitv5+pObvMgy
         iDNA9IWC8MF3huobF3G7TJH2H8bJ9ewA6rXq+W9uvNCkMUIIGkvsJ4hBUOEksW9L/jq9
         viOvT6oI0wSQF4p0RJmvtSm/7Vrrdjkxu+GO+ni6r17NEaLGg1P7KgED5BeIaMfr18dQ
         ZljA==
X-Forwarded-Encrypted: i=1; AJvYcCWDE1fqN3tNGk/BS9ZjdHpZPGn78/OPxpL3mJzhuA5mF45np7vH9yDYtCGbnkeSbLDwwySK/SLJCAZ065KMYs/yqyCxv4w1tnz0c0GIkq8/i9U8CXEbRfj7Rifpasbh40b8643N
X-Gm-Message-State: AOJu0YzMmHmMWbHALjjG8gTl+g+NpNIEpLcDxJqh6bHq9htlF/aS/B6Z
	h+MbC8Vuf7B7aG+kaWdrl/zIrq85hLkWSLJHbJGKdz/kC0Fc2nX2
X-Google-Smtp-Source: AGHT+IF6XBI6RMmSIl73BuiVXGvdAGCETRQEC8hIHhZtCBXmBO66NF9sU4vNRnWtxn9E16IeOwwZAg==
X-Received: by 2002:ae9:c204:0:b0:790:675b:8bcf with SMTP id j4-20020ae9c204000000b00790675b8bcfmr9557248qkg.31.1713880524872;
        Tue, 23 Apr 2024 06:55:24 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id c26-20020a05620a135a00b007906e2041absm2535928qkl.1.2024.04.23.06.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 06:55:24 -0700 (PDT)
Date: Tue, 23 Apr 2024 09:55:24 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 alexander.duyck@gmail.com, 
 aleksander.lobakin@intel.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <6627bdcc4b891_102d78294fb@willemb.c.googlers.com.notmuch>
In-Reply-To: <fc6d9631-ad88-43dc-b587-7742fe47ab1e@gmail.com>
References: <20240419153542.121087-1-richardbgobert@gmail.com>
 <20240419153542.121087-2-richardbgobert@gmail.com>
 <6622bd416e567_1241e229425@willemb.c.googlers.com.notmuch>
 <ae7af8b6-0952-434d-8178-8042a2db6bc9@gmail.com>
 <662696b7c257_7539294ba@willemb.c.googlers.com.notmuch>
 <fc6d9631-ad88-43dc-b587-7742fe47ab1e@gmail.com>
Subject: Re: [PATCH net v2 1/3] net: gro: add {inner_}network_offset to
 napi_gro_cb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Willem de Bruijn wrote:
> > Richard Gobert wrote:
> >> Willem de Bruijn wrote:
> >>> Richard Gobert wrote:
> >>>> This patch adds network_offset and inner_network_offset to napi_gro_cb, and
> >>>> makes sure both are set correctly. In the common path there's only one
> >>>> write (skb_gro_reset_offset, which replaces skb_set_network_header).
> >>>>
> >>>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> >>>> ---
> >>>>  drivers/net/geneve.c           |  1 +
> >>>>  drivers/net/vxlan/vxlan_core.c |  1 +
> >>>>  include/net/gro.h              | 18 ++++++++++++++++--
> >>>>  net/8021q/vlan_core.c          |  2 ++
> >>>>  net/core/gro.c                 |  1 +
> >>>>  net/ethernet/eth.c             |  1 +
> >>>>  net/ipv4/af_inet.c             |  5 +----
> >>>>  net/ipv4/gre_offload.c         |  1 +
> >>>>  net/ipv6/ip6_offload.c         |  8 ++++----
> >>>>  9 files changed, 28 insertions(+), 10 deletions(-)
> >>>>
> >>>
> >>>> +static inline int skb_gro_network_offset(const struct sk_buff *skb)
> >>>> +{
> >>>> +	return NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark];
> >>>> +}
> >>>> +
> >>>
> >>>
> >>>> @@ -236,8 +236,6 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
> >>>>  	if (unlikely(!iph))
> >>>>  		goto out;
> >>>>  
> >>>> -	skb_set_network_header(skb, off);
> >>>> -
> >>>
> >>> Especially for net, this is still a large patch.
> >>>
> >>> Can we avoid touching all those tunnel callbacks and just set the
> >>> offsets in inet_gro_receive and ipv6_gro_receive themselves, just
> >>> as skb_set_network_header now:
> >>>
> >>> @@ -236,7 +236,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
> >>>         if (unlikely(!iph))
> >>>                 goto out;
> >>>  
> >>> -       skb_set_network_header(skb, off);
> >>> +       NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = off;
> >>>
> >>
> >> Thanks for the reply!
> >>
> >> Setting network_offset on dev_gro_receive and inner_network_offset only
> >> in the tunnel callbacks is the best option IMO. I agree that
> >> we want a small patch to net that solves the problem, although I 
> >> think always using ->encap_mark in the common path is not ideal. 
> >>
> >> We can avoid changing all the tunnel callbacks by always setting
> >> inner_network_offset in {ipv6,inet}_gro_receive and initialize
> >> network_offset to 0 in dev_gro_receive. It will result in a small
> >> change, without using ->encap_mark.
> >>
> >> What are your thoughts?
> > 
> > That works. It's a bit ugly that inner_network_offset will always be
> > set, even if a packet only traverses inet_gro_receive once. What is
> > your concern with testing encap_mark?
> > 
> > How do you want to detect in udp[46]_lib_lookup_skb which of the two
> > offsets to use? That would still be encap_mark based?
> > 
> 
> I'd like to minimize any potential overhead, even a small one, and this way
> we do not need to access encap_mark at all in the common path.
> 
> NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = off;
> 
> compiles to:
> 
> 	movzx   eax, byte ptr [rbx+46h]
> 	shr     al, 1
> 	and     eax, 1
> 	mov     [rbx+rax*2+4Ch], r14w
> 
> while
> 
> NAPI_GRO_CB(skb)->inner_network_offset = off;
> 
> compiles to:
> 
> 	mov     [rbx+4Eh], r14w
> 
> I do plan to add a patch to net-next after this to remove the access
> entirely from inet gro callbacks, in the meantime, it looks to me like a
> reasonable patch and small enough to not raise concerns.
> 
> For udp_lib_lookup I don't see a way around it so yes, it would still be
> dependent on encap_mark. Since this runs in the complete phase it's less
> concerning.
> 
> Let me know that you're ok with that and I'll post a v3.

Yes, looks fine.

Main cost is memory access, and that encap_mark will be
accessed soon after in udp4_lib_lookup.

I don't expect two arithmetic instructions to matter. But this code
does now have one more store: the one in dev_gro_receive.

Either way, in the noise. Both approaches look fine to me: very
concise and essentially equivalent. Choose your preferred option.

