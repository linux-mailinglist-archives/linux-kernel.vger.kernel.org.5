Return-Path: <linux-kernel+bounces-3414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE91F816BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CAB728257A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DE81A588;
	Mon, 18 Dec 2023 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kaRcdsjr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807A118E1B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so15543a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 03:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702897684; x=1703502484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AQLJNbHXm9bw9mH1g4ChmY8Tt43IgcTpCwr8V+S95I=;
        b=kaRcdsjr/daU9csfk49B6e7YkDEeXe+8daoUSl4stDbgvAq4TgAR3sOUDvc/CUxE5S
         ur65bsf/zjpu243JziAXJ47BqFENyXH5LIqSmodfPRUIkNdYlwQdpKi6qoEOV12feCZ2
         A9yKaHjw+6aPlwlH8KvMWJz8czYH3h7ofYXBEy96YX3NpLRZJUa59GVW30Pl1/+InOrR
         1WNaEDuCyMi7p/smItqL/TBPlZJwriR85LaYuQ/dxZ/XSVPq2szfczY4rWMXS/3Y2ZKJ
         b2mhH0X6Qa7RBxkx4ttWijfMego3zCFRVuP9tlMRyWVTkcmM2RTNma6RLMUWI1X3axtQ
         cHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702897684; x=1703502484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AQLJNbHXm9bw9mH1g4ChmY8Tt43IgcTpCwr8V+S95I=;
        b=jgTJbZTlh22Sx5qkA+eaWJW8a4oqmQgb8Or95h4RH/4rJnFdYAAm2BZzuHv9TMSAkm
         5fEvCHr1mzxeXZ3U/dYrMXyQKUR3Cf/yOuy4y62InQhoLLblU6r3q6BfV0NmuFZkqh3E
         jCPB+U2koZcbQp8/BWiJVqGBm9vSKRthqaLWCaRvKWVTzjFSuBqJdrrD6UlHniHyx1oB
         H407S5ZcMUSEwTWWCEhgT/YsFYz1yzL/iXoeSTsDoOvSeySlhpIhsSEvF0fY4WMXbopC
         b/Xru7eD1UHgusWUJ2vgg0x4Biof2fXI6hEb/ip4tVzIYrgtuXThTIlfy3ecdO6yHXL4
         6z6A==
X-Gm-Message-State: AOJu0YyxR4NZEURqnx0fd6eYc6+g+B4c3Cx/t/KCxz/iH9EOStAz3pFo
	pm0DznLWSis7EMs6mbfJqUJQ6U2KdYHnvcENcazncl0hbj5GP9Pnl0CPNuNQqw==
X-Google-Smtp-Source: AGHT+IEElFawCpdohsL5MlKQosR21DHdivzVWO+EAMLouO2OGxC74cDSKlU+SWU7Lu+8gFsLHiYjz5ELdJGXwdzmfag=
X-Received: by 2002:a50:cdc6:0:b0:551:9870:472 with SMTP id
 h6-20020a50cdc6000000b0055198700472mr275515edj.1.1702897684321; Mon, 18 Dec
 2023 03:08:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218084252.7644-1-zhangyiqun@phytium.com.cn>
In-Reply-To: <20231218084252.7644-1-zhangyiqun@phytium.com.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Dec 2023 12:07:50 +0100
Message-ID: <CANn89i+t9t5ca=r6ZKw7s-HrxzgJjCB6hmWLccKmmxg8H=HUUA@mail.gmail.com>
Subject: Re: [PATCH] xfrm: Use spin_lock_bh() in xfrm_input()
To: Zhang Yiqun <zhangyiqun@phytium.com.cn>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 9:43=E2=80=AFAM Zhang Yiqun <zhangyiqun@phytium.com=
.cn> wrote:
>
> This patch is to change spin_lock() into spin_lock_bh(), which can
> disable bottem half in calling. If we leave this as spin_lock(),
> it may stuck in a deadlock, because the callback in bottem half in
> crypto driver will also call xfrm_input() again.
>
> Signed-off-by: Zhang Yiqun <zhangyiqun@phytium.com.cn>

When was the bug added ?
We need a FIxes: tag.

Also a stack trace to show the deadlock (or lockdep complaint ) would
be needed as well.

> ---
>  net/xfrm/xfrm_input.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index bd4ce21d76d7..f4cd46d73b1e 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -581,7 +581,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be=
32 spi, int encap_type)
>                 }
>
>  lock:
> -               spin_lock(&x->lock);
> +               spin_lock_bh(&x->lock);
>
>                 if (unlikely(x->km.state !=3D XFRM_STATE_VALID)) {
>                         if (x->km.state =3D=3D XFRM_STATE_ACQ)
> @@ -607,7 +607,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be=
32 spi, int encap_type)
>                         goto drop_unlock;
>                 }
>
> -               spin_unlock(&x->lock);
> +               spin_unlock_bh(&x->lock);
>
>                 if (xfrm_tunnel_check(skb, x, family)) {
>                         XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEMODEERRO=
R);

This patch is not correct anyway.
There are five places in xfrm_input() where x->lock is either locked
or unlocked.

Please tell us how this was tested.
Thanks.

