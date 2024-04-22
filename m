Return-Path: <linux-kernel+bounces-153759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034898AD2CF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2721C1C2145E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C8515383D;
	Mon, 22 Apr 2024 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuArZazZ"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9A9152197;
	Mon, 22 Apr 2024 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804986; cv=none; b=j14faVxe/edwTDqOKfR81noYWutEcBbq7yLUc9T7B7PxGKDRA4Fkdq02o+NwasKQmM1+JkBuGUKHAkbpVTz9S6RaYAvQUckGuBS64b7w1S2fnkxILoVLG1zEKNEeKCXpvT+EW5+6c+0sC30JcpRR1WdX5y5RrprirLYhq1xYocc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804986; c=relaxed/simple;
	bh=epyq96Q/BEQILWBmybkdBBkT6+BvOaud2QIeKDhtbak=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FrvKBLIi+EGzy0qF/P7tFOYpvlrG2QCgA5EEsJErej6d25lVGDxp0u9vUwz6F3MwdRPdAEhBqUiwGYdTnQM4wDO1e16+gfCCYauSyfx4866orUhmPyExUprq1HU7JExm+DM5CXrZ0eJBf6tg5WL+aZRH1OwnL4sCKe0r8vWwQvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuArZazZ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-790605809cbso210943785a.3;
        Mon, 22 Apr 2024 09:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713804984; x=1714409784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYGnqB6cLZlaQwsHWZl+iTgeW0O4NVhhWrlNqA0+Fpc=;
        b=HuArZazZyPisN75wzamw6TTgWdWe7ddW7rF6lDZuNHLKuhJSzlj0fsV7BlzzOWKWhJ
         Eg45vk5i8BCUNmnOtIeGEniGtm1754xgD/Uapfo6D71pqOVzFKnvRR42RsxaoI5lr4d8
         Zukb2TDYqXqKtQZuKRh5a18gzj5ga0GF1q3nq1v6QpKf+QuEP5mGweWn271XUG9mtr7y
         f0ZEGbU3uGJ0GVzAtAlkuCZDLonux9pqtewR6gh4ioaRrdJkJ2w4C3vwSwEOc9Pi0X8N
         NNZZhXZTNIVs3dg3nwNSnb0aCdE15HkfoJ3JNodYP8m49ghiZFTlJumMsIfrhjscFVkk
         je0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713804984; x=1714409784;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYGnqB6cLZlaQwsHWZl+iTgeW0O4NVhhWrlNqA0+Fpc=;
        b=OPgKa7xiNZIM6nEh2DPemkOZ30gqltPSiVYgJeFF0EoqVg79RQohrS5fVqnVugE5Ug
         8hqaUehyjytAIEKP+eEoFsI/0u4Oc5cYX0sLgHV/AE6yArMHfLFM65dZLZpkcqIuEkhW
         no8HWL1bZHOXKGA8rkrFqcUESj59c7ygbqgM9kCsL8QOPDRJmu8vQMPvhh6AoA+NaBVD
         YOS2QugEjc+/kcCikYKA7CdbItKBBMGSFgxII+lxawqGeq7BDgCO6+WpH+NcwIoQpZBU
         I/bQL1LroFvG6QGFydUaUP+NeU8WsTgPlJzonmEkOqgZYHRiGRu9/DPTxkoQN+BGVYdQ
         ZbSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO7zTkllMyVI0HhqosAwt9WHgaPyzXMyq/Fs0D49mbyOzhPI7yP6MhsZOCOqo/vXz/uO1xu+uH1bcNl4Jtzf85E7TOl/r8qs7JrmtjbPcknprsao3K+J3fxMGOzX6vwpbLS8Nf
X-Gm-Message-State: AOJu0Yw2RX8n4LoKFQi0jRL4aMKWRT0y+vm61paCyB00r2lUzJlo92tM
	98Z8r3dg3xX29d/HomYm+/mJIL8rfh97q3/w51fxd2cy5brhiRe8txcR+3lZ
X-Google-Smtp-Source: AGHT+IHHhEKyCvaDtIqtpp9aqlubXMkT2nu6x0/tEHLDk0WG4A9N5hQwNDzjDYpkWuIxUOPphCw0dQ==
X-Received: by 2002:ad4:4485:0:b0:6a0:412f:8496 with SMTP id m5-20020ad44485000000b006a0412f8496mr11314151qvt.52.1713804983800;
        Mon, 22 Apr 2024 09:56:23 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id z12-20020a0cf00c000000b006a0441c4d15sm4377553qvk.38.2024.04.22.09.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:56:23 -0700 (PDT)
Date: Mon, 22 Apr 2024 12:56:23 -0400
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
Message-ID: <662696b7c257_7539294ba@willemb.c.googlers.com.notmuch>
In-Reply-To: <ae7af8b6-0952-434d-8178-8042a2db6bc9@gmail.com>
References: <20240419153542.121087-1-richardbgobert@gmail.com>
 <20240419153542.121087-2-richardbgobert@gmail.com>
 <6622bd416e567_1241e229425@willemb.c.googlers.com.notmuch>
 <ae7af8b6-0952-434d-8178-8042a2db6bc9@gmail.com>
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
> >> This patch adds network_offset and inner_network_offset to napi_gro_cb, and
> >> makes sure both are set correctly. In the common path there's only one
> >> write (skb_gro_reset_offset, which replaces skb_set_network_header).
> >>
> >> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> >> ---
> >>  drivers/net/geneve.c           |  1 +
> >>  drivers/net/vxlan/vxlan_core.c |  1 +
> >>  include/net/gro.h              | 18 ++++++++++++++++--
> >>  net/8021q/vlan_core.c          |  2 ++
> >>  net/core/gro.c                 |  1 +
> >>  net/ethernet/eth.c             |  1 +
> >>  net/ipv4/af_inet.c             |  5 +----
> >>  net/ipv4/gre_offload.c         |  1 +
> >>  net/ipv6/ip6_offload.c         |  8 ++++----
> >>  9 files changed, 28 insertions(+), 10 deletions(-)
> >>
> > 
> >> +static inline int skb_gro_network_offset(const struct sk_buff *skb)
> >> +{
> >> +	return NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark];
> >> +}
> >> +
> > 
> > 
> >> @@ -236,8 +236,6 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
> >>  	if (unlikely(!iph))
> >>  		goto out;
> >>  
> >> -	skb_set_network_header(skb, off);
> >> -
> > 
> > Especially for net, this is still a large patch.
> > 
> > Can we avoid touching all those tunnel callbacks and just set the
> > offsets in inet_gro_receive and ipv6_gro_receive themselves, just
> > as skb_set_network_header now:
> > 
> > @@ -236,7 +236,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
> >         if (unlikely(!iph))
> >                 goto out;
> >  
> > -       skb_set_network_header(skb, off);
> > +       NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = off;
> > 
> 
> Thanks for the reply!
> 
> Setting network_offset on dev_gro_receive and inner_network_offset only
> in the tunnel callbacks is the best option IMO. I agree that
> we want a small patch to net that solves the problem, although I 
> think always using ->encap_mark in the common path is not ideal. 
>
> We can avoid changing all the tunnel callbacks by always setting
> inner_network_offset in {ipv6,inet}_gro_receive and initialize
> network_offset to 0 in dev_gro_receive. It will result in a small
> change, without using ->encap_mark.
> 
> What are your thoughts?

That works. It's a bit ugly that inner_network_offset will always be
set, even if a packet only traverses inet_gro_receive once. What is
your concern with testing encap_mark?

How do you want to detect in udp[46]_lib_lookup_skb which of the two
offsets to use? That would still be encap_mark based?


