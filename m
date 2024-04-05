Return-Path: <linux-kernel+bounces-133037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D93899DDD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8188A2841C6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9943016D4E5;
	Fri,  5 Apr 2024 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ithwz9jI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78E216D4D2;
	Fri,  5 Apr 2024 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322071; cv=none; b=bKwsJhdUpn8dF6oFp6l4lPnt3svMnMNFK+4/+WSqE0UYwJP65YQhyBta0hYBVvwjrirgOIbyiTh6Y+b+gu8quYhu5xJyVV5skM7DkxP/WJcVwrd1dmXRRZiVKn6myq+xTismxmoW0d4PHQlcblDbynSuIC3y6v3SWH+b4r/2lFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322071; c=relaxed/simple;
	bh=KjLmN2j+z29ejJKgU02Fut0SfGnHPqtDrINp5ViYVus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idFkNDwf+ErN8bvZNLt2WqyW7PfNL/knWotBIyam48ZAIM/tF02FGwT0AAn+Xo5yl8P3S8SbjMmNQXGq6/d9DcHLEbazptLKOROvO1TBEWnjRplZhxpTUzLyA0seQVeYRU24MvFHX7IpHjFbYb+LQ/k0YXOxt38Hp0qgA979LRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ithwz9jI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F06C433C7;
	Fri,  5 Apr 2024 13:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712322071;
	bh=KjLmN2j+z29ejJKgU02Fut0SfGnHPqtDrINp5ViYVus=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ithwz9jIEQF+ZcmXiqmm1y9rQ0NIFn3Do6d0TmS8+NhoM4FP3B4qyai2ruAlf7+c7
	 CtxwyuGOYKub7W/6Q9gK6MFl+GhbcOUKoJYsw7uk0yzFKLUfeucGzv0TvEjs7g+PYC
	 lQYHUb55kR08R+M1yPn7J1URZ6M8K1io5pMseCxLTRxInXHg4uRq6xnxnWR1A9ABDD
	 Cl7Kab53vL6qaav4hC3GTbEY+c/15dP2TeQYloIeLYaZxNF20B5GWw9NCdK57j8sW3
	 Sg/cgjrY3r0FilrmIKu16/E0I8RpdjVlMaFuzQgipe76UD8plp/extISaBcepNv7TC
	 FCebpyobqfdmQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516cdb21b34so2377711e87.1;
        Fri, 05 Apr 2024 06:01:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXdvWjWdWmpxWEXItI7SXVK/wlGCUd0d7nCxhHBCz+OIwuslB4RRLQVM9t+Op1VYj8wR+X5eFiOL40EX+ddg1V2mP6kVXhHgsYAO4CluXNYJmL8M0RzEu4n8zxU0WtTJR6IbTMp2IS84Q==
X-Gm-Message-State: AOJu0YwIbNCGtSNDk9bxE7peXe29kB1dIq+TSKCdmDW4hnAaY84wOL6c
	ziAvFLZcSNzcxewOt9V38yic5tHXE6peYEGOjnr5IKlYTYix7tNNp/ergBNpC2GWBmHt2zc8jSP
	p7xb3n7M+NrO5bvfHLDHviWbOeQ==
X-Google-Smtp-Source: AGHT+IFMWxlQyZ+UCKKvfwWNLRZ8mFFq7fxifr5nlPAIN5MvkVybvEDrjpfPIyo3YxDSk/yxCnJebvbTUQGhMCeZD3k=
X-Received: by 2002:a19:750b:0:b0:516:d471:18a0 with SMTP id
 y11-20020a19750b000000b00516d47118a0mr874385lfe.67.1712322064676; Fri, 05 Apr
 2024 06:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404-dt-cleanup-free-v1-0-c60e6cba8da9@kernel.org>
 <20240404-dt-cleanup-free-v1-3-c60e6cba8da9@kernel.org> <CAGETcx8Wd5OsHWiGSASWkQQtof0D-ScwYsvq9hWizV3DFC27gA@mail.gmail.com>
In-Reply-To: <CAGETcx8Wd5OsHWiGSASWkQQtof0D-ScwYsvq9hWizV3DFC27gA@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 5 Apr 2024 08:00:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK4QpFmLi0WVG0Vpxv82Y1eWxbGS7ESWBhPoKg+WFV5Tw@mail.gmail.com>
Message-ID: <CAL_JsqK4QpFmLi0WVG0Vpxv82Y1eWxbGS7ESWBhPoKg+WFV5Tw@mail.gmail.com>
Subject: Re: [PATCH 3/3] of: Use scope based of_node_put() cleanups
To: Saravana Kannan <saravanak@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 6:22=E2=80=AFPM Saravana Kannan <saravanak@google.co=
m> wrote:
>
> On Thu, Apr 4, 2024 at 7:15=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
> >
> > Use the relatively new scope based of_node_put() cleanup to simplify
> > function exit handling. Doing so reduces the chances of forgetting an
> > of_node_put() and simplifies error paths by avoiding the need for goto
> > statements.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/of/address.c  | 60 ++++++++++++++++---------------------------=
--------
> >  drivers/of/property.c | 22 ++++++-------------
> >  2 files changed, 26 insertions(+), 56 deletions(-)
> >
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index ae46a3605904..f7b2d535a6d1 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -491,7 +491,6 @@ static u64 __of_translate_address(struct device_nod=
e *dev,
> >                                   const __be32 *in_addr, const char *rp=
rop,
> >                                   struct device_node **host)
> >  {
> > -       struct device_node *parent =3D NULL;
> >         struct of_bus *bus, *pbus;
> >         __be32 addr[OF_MAX_ADDR_CELLS];
> >         int na, ns, pna, pns;
> > @@ -504,7 +503,7 @@ static u64 __of_translate_address(struct device_nod=
e *dev,
> >
> >         *host =3D NULL;
> >         /* Get parent & match bus type */
> > -       parent =3D get_parent(dev);
> > +       struct device_node *parent __free(device_node) =3D get_parent(d=
ev);
>
> Can we leave the variable definition where it was? We generally define
> all the variables up top. So, defining the one variable in the middle
> feels weird. I at least get when we do this inside for/if blocks. But
> randomly in the middle feels weird.

There's an 'of_node_get(dev);' before this. Ordering wise, we need to
hold the ref on the child before we get its parent. I suppose I can
also convert that to use the cleanups. I'll have to add another local
ptr to do that though.

>
> Similar comments in other places. Since both kfree() and of_put() can
> both handle NULL pointers, I'd be surprised if we HAVE to combine
> these lines.

https://lore.kernel.org/all/CAHk-=3DwgRHiV5VSxtfXA4S6aLUmcQYEuB67u3BJPJPtuE=
Ss1JyA@mail.gmail.com/

