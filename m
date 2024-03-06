Return-Path: <linux-kernel+bounces-93861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3318735F2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA3A1F23533
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660327FBC5;
	Wed,  6 Mar 2024 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFljGz+Z"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B68E2D7B8;
	Wed,  6 Mar 2024 11:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709726232; cv=none; b=Yhz2jCgzqIPL/+g7PAroMeCCvsaXfCMtHWA/4VvM12e26EwU6VTBSL2taLZJiCC2GtsOLfeBPAFtDuvxp6jjTkdgCoBg1cxzwYjdW1r0fQJmLXG8bL2fMHPvufn2mcCKtAMjb4/ie5B0yXuldeZseTmxbLv7xJ9jnzwD+Z4srBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709726232; c=relaxed/simple;
	bh=hlmHhTli9UgDXytybNg1lFQ0imkQVgEKhGeyjOGwQdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHFMnZBMXMtkA0e+0KYVUOsp8inCd/fCeukgV+ElzLIeY/1o1PSfwOkbLuymp7cxqyz4wzXunjUCaeE2cBaHelrm6e9bsobDNDfG2lCwT/Rz9sCdFZkuGM8u8YOS/jAQtxGhjvHVepwQw308z7OlEdmu3KoWUIwCQkyzEOfYAs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFljGz+Z; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4417fa396fso813843866b.1;
        Wed, 06 Mar 2024 03:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709726229; x=1710331029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlmHhTli9UgDXytybNg1lFQ0imkQVgEKhGeyjOGwQdQ=;
        b=eFljGz+ZfYfqljM36lueKzDbg/LQmgSsJ6UDBLXaOmUBmA6mI+bfQLrutWRo348t30
         FNChKqqVgLEgQhA4fE538MlMzEreKfUOy2igYGyTpfio7nvJfMOQlte8UcW+beFc8PrR
         N1I3hKlf5WrzmERDwFlgHH+Vec2elKUJ/osBdTrYyGXkgn/CSYE7JaqpWnYTG+5FS0gY
         +VMzddiG76y4AHwzrEO38NhDSUXsl1K4yuOSQQMong/YCSRQKg/PfEgzpY3dAAcHdkbw
         6dErCOk8LQpqcQ5a0/86M+w2kWWbpeRn0nJifq0O2lQeTK0t1UQ/ccdRgdxEN7D+Qw3k
         JY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709726229; x=1710331029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlmHhTli9UgDXytybNg1lFQ0imkQVgEKhGeyjOGwQdQ=;
        b=fF6tFuexJ3774rWXC78P8xmKSuNDjUJowL94+8ZXLNwXDblmSASElmTkDpqZ56ahST
         /nQ3ydmJzXHH1eJwMlKv7ypvlbzvO01c0MPwjIOTd/0fRYZopz1iwT2nfuUzLO2qTV+3
         fumYb0SUxMhmDhmKbGE+x/wFx9pLOfhuJGA0LzhZIdfeEHOFAlsfHDBypMhTGBGdUH5o
         Ks+I4x46ccWLuyFaV+C1n0EDdFW96v7P0L4HWacwoVAaS6Ay9L2HXt6XaZxUij35UT6n
         lnW/q1Lks/4hZK2VRxLw367CboDj87csSLMIfEutB+xb6lfNUCdBykWkFbGcK+u5eUBP
         sSBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMxsP1Y5gUDTlsHBxpnU7EAWe7fuWpOWvpcBIQno2XMHqfbjTjruiDKDluynPlAvRlncesty2cLto1S0YDaOFe9MKzfqWZZn0OcMdPpMZk0ePP9dSMgX0uup9Lkj3kNwR451E2
X-Gm-Message-State: AOJu0YyR/L7GprCgrB764m6gsEVGuJC6kMCfqHciBGVsqtfrRur6itAO
	z2cZwEdfe63dghP4YfRJxMpht+2xMeACoryd9xw/d24AWbmGv8YBcN96JP5JnIzFzt5f0qDfTDe
	8WiJN6ygcU6eKpjij5rvIqCLKVx8=
X-Google-Smtp-Source: AGHT+IGailb4OIrLvE1WX5ySFLMib5+ATyLrDLu/T3dUqo47Kuy3gf5yns9q1SM68Rb/Rmse/NvV8cluWIWA6/2sJv0=
X-Received: by 2002:a17:906:c20f:b0:a45:a9c2:85d7 with SMTP id
 d15-20020a170906c20f00b00a45a9c285d7mr3372797ejz.44.1709726229206; Wed, 06
 Mar 2024 03:57:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306095430.1782163-1-Ilia.Gavrilov@infotecs.ru> <095ce1d0f2cd6771b30ab1d73ee6aa8e8460c7c8.camel@redhat.com>
In-Reply-To: <095ce1d0f2cd6771b30ab1d73ee6aa8e8460c7c8.camel@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 6 Mar 2024 19:56:32 +0800
Message-ID: <CAL+tcoBSkBG0SDnjDOzjqzpSFphrE-_Qyw_DcdcebHcRCU3xgw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: fix incorrect parameter validation in the
 do_tcp_getsockopt() function
To: Paolo Abeni <pabeni@redhat.com>
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Paolo,

On Wed, Mar 6, 2024 at 7:36=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Wed, 2024-03-06 at 09:57 +0000, Gavrilov Ilia wrote:
> > The 'len' variable can't be negative because all 'min_t' parameters
> > cast to unsigned int, and then the minimum one is chosen.
>
> The above is incorrect, as the 'len' variable is a signed integer

The 'len' variable should be converted to the non-negative value as
this sentence:

len =3D min_t(unsigned int, len, sizeof(int));

See the comments of min_t(): return minimum of two values, using the
specified type.

After executing the above code, it doesn't make sense to test if 'len
< 0', I think.

Thanks,
Jason

>
>
> The same applies to the following patches.
>
> Cheers,
>
> Paolo
>
>

