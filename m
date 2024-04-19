Return-Path: <linux-kernel+bounces-151370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA02F8AADB4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AE9DB21E24
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E996F823A6;
	Fri, 19 Apr 2024 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeXA/tNG"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60F83F8F6;
	Fri, 19 Apr 2024 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713526179; cv=none; b=PRIUruAznx6eHP1gljvf43urR7ccZWRmqDHnXEZyir5r2bT3K/pS6ybB6OpcoDrfCnFm36tYzn8fK970ytowXojvFhZRB1KYYT2w7PONFOzBmvlReRvwfLbvFIPLrFAba5AxjdDOqCUnWVPwUEnYhkhSxWF/aWnimM1OuCdFhto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713526179; c=relaxed/simple;
	bh=BZU+jjm3qkAOXxyhJi1fbipx+0JsCWUoGV+Pn30kurI=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=dC2/vWCQEo8Dq8Nw2mTEFz40sVoMLhevaOIo9Jw7u4JzaZOHwwV99KX731MXDr0CF1KAi6WQerh/5CKHfYLyJypjSYHQAju4dNlmyNl0qOVtR4hu54d+I6qK4ZAZy3BWtc0+Zp81QD0NOdneN7yC3pT8sflrqSqCJxmVoma4xmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeXA/tNG; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a526d0b2349so223402166b.3;
        Fri, 19 Apr 2024 04:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713526176; x=1714130976; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n4LcJjORvXYEFla/jgoi0t4zdgiXzjY/KUEduncoJWw=;
        b=LeXA/tNG12CeFJKH/ClsS+6jE/72XJEq+042+YKWlzXeg4xzZ2BewjGlJB1r0QtXrS
         wRIxtD9LwrKX5p4YscEp6M4/LmVFF3g6VnSQGyTTHyV6HLyR8sdw5VHNS+FqnEjDqNF1
         GCbFos/xdeypsh9D4FcTrEKH5fttKB78Ch1n+hy7F0oBc0mfnBeLrcctji8TNOlvranc
         B3NczmgI0zCzBFmN4ZesH2N8RK8+BKQOCQJ4EYz7qEpoMxp1Di6ROxL58yEHoiF4RG5+
         yfCEVUTO9Dqq7nOoRiwBn1hkj9pJjJQ31loouS7L4hMZNyUDhYQ+a90ttOcBWc/WncQz
         m+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526176; x=1714130976;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4LcJjORvXYEFla/jgoi0t4zdgiXzjY/KUEduncoJWw=;
        b=k06wCY6zwV2s9IhDyBMJZpkFabJ5iyNz/aRzxzPCjoZaqFMDU+gRqr1dkaC6gZ9Cmc
         hf3LBfYRcX41u6jwEh9UECb5vSLi2aue1kWWJiBD+F33GvjYN08a+02l0b+nhaqQHsC4
         kKI0TwfV3I6eN+R6A/WyRVd1N8R8UR9c8O0Vx3r6x71HqQTyvCFMVwhwW6o8jq15jdIg
         V4mKBleZpdlkZcn0bjPpenNkVhh0YeFehxovGsiAWnslRubvHy4WMjszxNcRD6ddEl2+
         lJhjFt0h/QDTQepRqksnQeYmBFFILCS6ohxi1NoVxEsoHMkDMwPsZ0QwsWX9Y9J4q1DU
         gnsw==
X-Forwarded-Encrypted: i=1; AJvYcCVNRu/uImCvM5mH86CT9rNBweSRpxoBoaGs/iRXdMI0FI7x0Y1Q8YXA7h72EBGYtn1cQfu6ppMgCPn7lmJVUsn+Isfi7XMzfsPAN6jimObfmZvW1jaBncHbhnlWdcGSthB4fvZnoKRP9+M=
X-Gm-Message-State: AOJu0YxETSh51Fqe5Wa7cgEGCaaqAKo6ChAramigEjeK9c7LHEk9yO87
	0yVtY59boCCqJPFhCxzoqaYo3UL65vQSPG46u4X2lw1/HMDW1W4I
X-Google-Smtp-Source: AGHT+IEf9iXqPnduTXPuilXEaX9Z9lFHFjpO71vLglogWZ7GVIaRLlo4wqApk1YpwFvQyDAgpeF8NQ==
X-Received: by 2002:a17:906:2b51:b0:a55:7ab9:57e6 with SMTP id b17-20020a1709062b5100b00a557ab957e6mr1202714ejg.47.1713526175713;
        Fri, 19 Apr 2024 04:29:35 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id g10-20020a1709067c4a00b00a4e5866448bsm2071756ejp.155.2024.04.19.04.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 04:29:35 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=4631f6a9b2d371b5a1490d95dc7549b23a9b87b8b54b5e8e1f77dbc0f933;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 13:29:34 +0200
Message-Id: <D0O2C1JJOF90.3MOQH6PE1M2SL@gmail.com>
Subject: Re: [PATCH 3/4] gpu: host1x: Convert to platform remove callback
 returning void
From: "Thierry Reding" <thierry.reding@gmail.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "David Airlie" <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>
Cc: "Mikko Perttunen" <mperttunen@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <linux-tegra@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <cover.1712681770.git.u.kleine-koenig@pengutronix.de>
 <7e31909b1e536f0ddbb060b1aaa0a9e943687c8a.1712681770.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <7e31909b1e536f0ddbb060b1aaa0a9e943687c8a.1712681770.git.u.kleine-koenig@pengutronix.de>

--4631f6a9b2d371b5a1490d95dc7549b23a9b87b8b54b5e8e1f77dbc0f933
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Apr 9, 2024 at 7:02 PM CEST, Uwe Kleine-K=C3=B6nig wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/gpu/host1x/dev.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--4631f6a9b2d371b5a1490d95dc7549b23a9b87b8b54b5e8e1f77dbc0f933
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYiVZ8ACgkQ3SOs138+
s6ED0BAApayQb5R8tzI25oRF9vE4dD7fgryHQ6lE8bDFua62RK1xuC0+16Fi323n
5eHdLgQSC/zdAUB+E0OeRpqWg7JGTJqfbfbn9hE5HT3qQu9MxDzI9btpGAHowNlv
SOzzsMOjICuAhZ/92iZ0jp1EtsyU7QdhQ6jOMeFHqQFNggvpzXjLzeh+E+BoRvNK
1SAGI1x+Eo7PHrFAOHgoZn/grnlyuSlGelszK5hwx3Rsr8LQ4qbYtMzTNKkdtDxv
OSgiDSEuTQaqbROckvB5IOK8TZKwMMukSYkpJg/omb0y8dDjfWvqX38VTl2+NfIs
jGa97Fi0/N2Ny9weM3jk7Rx64HCW/FxcCAcj0Wk9fVZAkh8aFUXYUxjigLFncDVr
0p3BWfYeBebl8RSCQ4u0omoo9Ar5+yoBXs8+WhAm5QPdoqseCruj1JPFqiZl3KLt
FYgRGmAIIMIh0R7089+8oT8wPc2t+HN/Wsoif8z+B/RqIERQBCfKV4GXd6I3nkKN
2wl8TZUIWMGvy4VsXG8r4iufoHgW15AoWMOuI0gCgZt8ukVhyRdZGyX0Y1a0eFmP
EHdY2XHmvOSEFlQE71pXm1kvocBHzChg0eEvBkb5s9m9VPp0LnKbiyQty4bYuCN+
x5bLRkc13YsDn5sdB61L1qKLgDXWLMpn7zjelxT+M0aoJdAgDqU=
=suAC
-----END PGP SIGNATURE-----

--4631f6a9b2d371b5a1490d95dc7549b23a9b87b8b54b5e8e1f77dbc0f933--

