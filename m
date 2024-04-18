Return-Path: <linux-kernel+bounces-150205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB368A9BA6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7617F1F226AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65AC161B58;
	Thu, 18 Apr 2024 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXJI8z3w"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E38EAD2;
	Thu, 18 Apr 2024 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448354; cv=none; b=U6TNRrL6G1MnZEgbDT2QPLYPRYbVhkS1IT35dCfFPP9imBNq1vNwPQ5j+g8iNbIGyk5aOiGpViFxFH9/ncFLaLENX99jl486B7xWKBCSV2ZAZ04LChsYoE7Fd4VX6kmsCbXjw0TJ/kBN8nGYHPQf/fAn61sVOyhNJJmqLb7DmXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448354; c=relaxed/simple;
	bh=Je31ci+eyD97RXiVi+9JjGy6yYzwIgH+zf+ojiy2P8U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=n0PyD9gXoKwy7NrF5S3wKrU/yaQBZABboI9hvzrj/BBjvUK3MnmorAIq3Xr9H6XxodI2mkCJDa1ErSu6iw+HGxjgdxd99YyszfWsMS3gB3eM6efIPWgMqQpFkkVC0pFE+c8d6JsH77zSuzdJfGTV/Vwq7UKK62oEKXy76GbHdUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXJI8z3w; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61500da846fso6349287b3.1;
        Thu, 18 Apr 2024 06:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713448352; x=1714053152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWDkD4GBnwBQNPancuw8naTRgpzqp6wkxrmNfvesCMc=;
        b=nXJI8z3wGOsRB73GfOuJT9zurZ6Ji06lBZbCd1QoSnzm+Eij+0qE5Mgw6GCoZZNw++
         GIDSSx7zG1V9hA7160zKDQ2eG1i8qXN8XthIKoBEZeEBcBOKS1gdtktmrub4q23YyLao
         jVXmUe/5Xk1ANbzxKkF8M085EZr4MEGO2/5OE053f9f2tF3IjtJIvXJjxo1vi2VR3fOs
         zZEQ0BqBHOtlQt2bPZEsQF4ibr1vPovxdtToo7y3bxJK8+JspKtDQ2CIjdeFaL7zJP4s
         bQAAYVWLY9+9ZREBgicg0Fe4VD/+KerJsW+Sn58f5ZzT6rvcmEIP0eEUy+O892fkdS3r
         8EcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713448352; x=1714053152;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KWDkD4GBnwBQNPancuw8naTRgpzqp6wkxrmNfvesCMc=;
        b=bdGcOPoqnRHME90qUZhnytR2jULGST+Wm3+3qHMLrLMkR+FlW2YABuiFVZzmBswqpT
         41zOD+mgm7drcMrIyXn3zi4piM/VU75J0LKHwVShRSC6sAakTpU04/MYTviiYVzKncqe
         uNmFzySzAgJ/IcPJS114X2CBkdLSftUq9ihtmytg30euu6nXxLayBqh3qfmmBt43BfCu
         nsr4/dxPDMRttU7HzxbTxLLNVzJNqIXr1VWg6+o+6RiE/THJbgt95AlslRX48u6jIMVz
         lLM9CGIFjQsrbOQNIhvGs8eN0cP8krNV6TJNbWIDWJKpsqbPe96+OxAtrvzrJ3W/PDs+
         n5BA==
X-Forwarded-Encrypted: i=1; AJvYcCUPwEMPyCOuJeqi987XZTW5Wxt77OIY110nswniCiPK+790FS9fuPTi7eEmkVpz+N8DgN3uiv1YXDdzL7MWFKKGXN7vKFb4ZxxnQA9MvMlIUDBQ1Sc09I/4njVE93PrCqBbN1kk
X-Gm-Message-State: AOJu0Yxvqf6bgiOrc0J1spWBs0NuYODBndRFMm/Lu6L12FLGPJkvn7lo
	0Z2Yh/OH4n34bwflpj9L6x1lMxDgpm7dKmpSBuTL3IIHp24Y6oaY3+aKsA==
X-Google-Smtp-Source: AGHT+IHcC/d5g/vrVO8yq6W/ye3vmtyJcu0gh/Sfv4UXpVtFtmjp0tOz0EvRUuueXnSjUeruqSxwbw==
X-Received: by 2002:a05:690c:25c7:b0:61b:2:6c36 with SMTP id dv7-20020a05690c25c700b0061b00026c36mr2640195ywb.24.1713448350174;
        Thu, 18 Apr 2024 06:52:30 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id ku20-20020a05622a0a9400b00437add246c2sm240951qtb.7.2024.04.18.06.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:52:29 -0700 (PDT)
Date: Thu, 18 Apr 2024 09:52:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Yick Xie <yick.xie@gmail.com>, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 kuba@kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <6621259d66d0f_ec9b929478@willemb.c.googlers.com.notmuch>
In-Reply-To: <0a17d6745d5c6d4bb635cfac1029e90c1ac2c676.camel@redhat.com>
References: <20240416190330.492972-1-yick.xie@gmail.com>
 <0a17d6745d5c6d4bb635cfac1029e90c1ac2c676.camel@redhat.com>
Subject: Re: [PATCH net v2] udp: don't be set unconnected if only UDP cmsg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> Hi,
> 
> On Wed, 2024-04-17 at 03:03 +0800, Yick Xie wrote:
> > If "udp_cmsg_send()" returned 0 (i.e. only UDP cmsg),
> > "connected" should not be set to 0. Otherwise it stops
> > the connected socket from using the cached route.
> > 
> > Fixes: 2e8de8576343 ("udp: add gso segment cmsg")
> > Signed-off-by: Yick Xie <yick.xie@gmail.com>
> > Cc: stable@vger.kernel.org
> 
> Minor: the patch subj is IMHO a bit confusing, what about removing the
> double negation?
> 
> preserve connect status with UDP-only cmsg
> 
> > ---
> > v2: Add Fixes tag
> > v1: https://lore.kernel.org/netdev/20240414195213.106209-1-yick.xie@gmail.com/
> > ---
> >  net/ipv4/udp.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index c02bf011d4a6..420905be5f30 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> 
> What about ipv6? why this fix does not apply there, too?

Oops. Thanks Paolo. Yes, this definitely also applies to ipv6.

