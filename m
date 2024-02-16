Return-Path: <linux-kernel+bounces-67966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D568573B5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 03:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBAE61C22384
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A94DF6B;
	Fri, 16 Feb 2024 02:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdgD0fT/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E45DCA64;
	Fri, 16 Feb 2024 02:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708049651; cv=none; b=LbP/DiFgzK6AJc7o72SLgoxJ+0xEBwRxXZrud2M+3cT9XwqxnRGt4xtEUB3HVgu4qvpKg1VSoY1ScyDDOi/cIlUv8ejkTStBvRIiW9cV/3PEMsjIK2OD3AFHN6FPc8GzC60iMH1Gtt4TCmy9q/DhQAJRwlocBh1iPNLGU2Ygr5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708049651; c=relaxed/simple;
	bh=Xs+KwBCxxa2dxK/i2c+IzQOw3xnuZCpzqdNklhKY8wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+NP3QYxJ02yLKVTpAihhF6dhBnohCslmECtx81qsOusZw/RQJ5tjIEw6cjEOe/KuWgD3SJlXceYQfeiNgpxC7MXJlTn/nApvG4kOhkBIVXAUqbUuBsDxrH+UCU63NpvWSce0Ckl/Gn6R5Qv1n4qRMrd8tyj1SueKwkpvdhrY4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdgD0fT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCABC433F1;
	Fri, 16 Feb 2024 02:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708049650;
	bh=Xs+KwBCxxa2dxK/i2c+IzQOw3xnuZCpzqdNklhKY8wA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CdgD0fT/8Elo/0QBTbSaXKIbBoIAHzfbtUqHQbLk+xhT6qE8HL50fQkgpLNnLRNA+
	 y6q4WXV/r7ZRf4Yp7dQZt8kB46577AqDRV3RJ1e4ATgrN2lYF9KDBOcm5hMB6yfx0n
	 cqFDBox+Xmob6E9qgbqPEXwze6zkNTaHkibbMZMJjhXJwC3BFv1B07x5BhtxjFdKxD
	 U5g3hogyPuO6P7aVXQLQUh9LJ33IVY7JQ7Y4Mp1S7FWbIofKHl2E8EnfK9QoIzML4B
	 H3dXImEn8IIZtgxU/K8jTfhPj16jZCjcIPo00XOSMNMW6LlQ981cZdPz+BEVxv12Ql
	 oCWXwvuLcMQSw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5114b2b3b73so1830768e87.0;
        Thu, 15 Feb 2024 18:14:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXpwgmpaUXroeQeBymVPlYWEgfV/nAbATmCnjramfMO1kKD+1suVB4QFP+F1c9Rcj8ViYf6seUSIrTJouGeikL2ClU0VgoTPvRtf+uG5n2w15T4vLVi5kXECj9bjxJ2f/wcXEnjZJzbPfc=
X-Gm-Message-State: AOJu0YyoTiCEhik+ORGwiOvKEcH6tiDypUMa1YVdpcIPya4JHJa8CSee
	hP0D+VV1W5RA3bNSmY4N1Y2697iP0EIEHSn3RDNjTvOO3h3QmnLPAv89S5q/JYm/mVUUcGk+bnH
	lEyre67IUSNYj/FSZqCgRLkARyqk=
X-Google-Smtp-Source: AGHT+IGutHLSmiOj51bLbZJ7zsRAV6SmERdy79oZb3KgBPn8mNLPxrc6eCgASf2BSQzcx+vVzl8OTE9MFFPngxn4ayI=
X-Received: by 2002:a05:6512:3087:b0:511:48aa:d621 with SMTP id
 z7-20020a056512308700b0051148aad621mr3151192lfd.66.1708049649270; Thu, 15 Feb
 2024 18:14:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215141120.1911369-1-masahiroy@kernel.org>
 <20240215141120.1911369-2-masahiroy@kernel.org> <b3f86324-afa2-49b7-9565-28f41aaf3334@infradead.org>
In-Reply-To: <b3f86324-afa2-49b7-9565-28f41aaf3334@infradead.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 16 Feb 2024 11:13:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR-tnzFvsrXnqa0jWMeZ63Ss1oSwnnNJzrQ32Md9U+Mtg@mail.gmail.com>
Message-ID: <CAK7LNAR-tnzFvsrXnqa0jWMeZ63Ss1oSwnnNJzrQ32Md9U+Mtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] alpha: merge two entries for CONFIG_ALPHA_GAMMA
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kbuild@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 8:28=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi,
>
> On 2/15/24 06:11, Masahiro Yamada wrote:
> > There are two entries for CONFIG_ALPHA_GAMMA, with the second one
> > 7 lines below. Merge them together.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  arch/alpha/Kconfig | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> > index 70e8343d00ba..581ca8c73d67 100644
> > --- a/arch/alpha/Kconfig
> > +++ b/arch/alpha/Kconfig
> > @@ -390,16 +390,12 @@ config ALPHA_PRIMO
> >         Say Y if you have an AS 1000 5/xxx or an AS 1000A 5/xxx.
> >
> >  config ALPHA_GAMMA
> > -     bool "EV5 CPU(s) (model 5/xxx)?"
> > -     depends on ALPHA_SABLE
> > +     bool "EV5 CPU(s) (model 5/xxx)?" if ALPHA_SABLE
> > +     depends on ALPHA_SABLE || ALPHA_GAMMA
>
>         depends on ALPHA_SABLE || ALPHA_LYNX
> ??


Oops.

You are right. I will fix it in v2.





>
> > +     default ALPHA_LYNX
> >       help
> >         Say Y if you have an AS 2000 5/xxx or an AS 2100 5/xxx.
> >
> > -config ALPHA_GAMMA
> > -     bool
> > -     depends on ALPHA_LYNX
> > -     default y
> > -
> >  config ALPHA_T2
> >       bool
> >       depends on ALPHA_SABLE || ALPHA_LYNX
>
> --
> #Randy



--=20
Best Regards
Masahiro Yamada

