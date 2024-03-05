Return-Path: <linux-kernel+bounces-92794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82664872610
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44121C253B0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E3117BAF;
	Tue,  5 Mar 2024 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhGrdjr3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E97BE4D;
	Tue,  5 Mar 2024 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661380; cv=none; b=J1rz4sZjd7iGXr6VlAIkzUo1QIpJsWSn5lPFMB1xuN1mz1oJlsDxwLHnvYng1KDaYk3k6Gq2YdzNpnXLxUOXf9uPF1Bd1lIlc+1y0YWYPOADWp2P24U+ztdJb3UbqKCwoLrfBS1QxnbNO5p+KpiZXPle8/JDj1kJdDYe+NuSKzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661380; c=relaxed/simple;
	bh=2bQynvk86aY7tc8jimbDs5P3dMauTJFDjIC5JF3c/tU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWXbbDAQLECvrA2e1ey2XmQOnCRc7gUqShP5RZAhVTS050md5juVvWjG2vjIZJJNpfWgVdt/s75yXig9PMQxqYZBDX6HFbXBowxba2CYgZc3ZPoqZO8+h2oojagfoOLInY/tZdJ3oaNvgST8s0BpJQFLaoVKCQQSzQLPORE5r9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhGrdjr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F4DC433C7;
	Tue,  5 Mar 2024 17:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709661380;
	bh=2bQynvk86aY7tc8jimbDs5P3dMauTJFDjIC5JF3c/tU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GhGrdjr31yTnSPEOKXTJqZjjZWLkuTUkn80SdQpOfQ1E65gl7jCO6O8AA5gOwYD+7
	 +Glftl3+g702P0WksUK+yCK+1mr2rIzYSjN3yDXi0WmWAoMdz2g6Q8piM5zIym0eoI
	 AaTmSZVHcualb1zcLIPH883CqoEQPtYzAB3GsZ07Joo6HIhF/BKy+gD1V9VszSFY7S
	 VbaNNdmtfvpMubriE5+V/6+X36VNcS0vj65RGSCN2uOgcJeSLgvdmMJpQKfOkAKu5p
	 2gzVqL9KZDgLP7/Hrc2jaiQDKv1lN3R665GIdfi9WWon1tQenYIqIs+Y8f+97bxXrI
	 ECeUegWPOezWw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so72960281fa.3;
        Tue, 05 Mar 2024 09:56:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjqdP2vIbjOt9RSNIJCwTVIxJ4bXLiTHpy+yu+NM7MaGUBziznpW5Mw72CU4jkObn/IYdgTVDFT1vbiIMMxqoZLvgLcLRe+Jg9hOr2oS589lpJVHTQ4vyxVwDMmE+fDvfCq940uOE7NA==
X-Gm-Message-State: AOJu0Yw8GGkZef1l7oohNGBVOSide/aZ7BWu38872Tlj1fs7VJ1QtvQZ
	r3cn80HFCcaK1nB35sN9fzuO7b/H6sIlfZhLLruYdQ0wiG5aal7U4R69MXlnxX1bHy4b8SW/ExK
	vGQczH9L7d9NqvTVOCLMNmZf8VQ==
X-Google-Smtp-Source: AGHT+IEyW1wSrSKm5chVIYsh/l5ojiLw2rZ0VNvCV17RBMeCXB6ztTFTEwceFfiD+qDhy0HNdtNIqZFJjAH169VThYU=
X-Received: by 2002:a2e:bc23:0:b0:2d2:3392:8c0b with SMTP id
 b35-20020a2ebc23000000b002d233928c0bmr1959443ljf.51.1709661378081; Tue, 05
 Mar 2024 09:56:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303104853.31511-1-brgl@bgdev.pl> <CAMuHMdXWdKZjjZc39iXfa6Nohtn+Xm9YvcF+YoRpNzCgeWD8tA@mail.gmail.com>
In-Reply-To: <CAMuHMdXWdKZjjZc39iXfa6Nohtn+Xm9YvcF+YoRpNzCgeWD8tA@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 5 Mar 2024 11:56:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJjo1SBcf=ZLi=iunaHiX6Mt5H6wkoPcecnZmiAcAyihw@mail.gmail.com>
Message-ID: <CAL_JsqJjo1SBcf=ZLi=iunaHiX6Mt5H6wkoPcecnZmiAcAyihw@mail.gmail.com>
Subject: Re: [PATCH] of: make for_each_property_of_node() available to to !OF
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 2:32=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68k=
org> wrote:
>
> Hi Bartosz,
>
> On Sun, Mar 3, 2024 at 11:49=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > for_each_property_of_node() is a macro and so doesn't have a stub inlin=
e
> > function for !OF. Move it out of the relevant #ifdef to make it availab=
le
> > to all users.
>
> Thanks for your patch, which is now commit ad8ee969d7e34dd3 ("of: make
> for_each_property_of_node() available to to !OF") in dt-rh/for-next
>
> > Fixes: 611cad720148 ("dt: add of_alias_scan and of_alias_get_id")
>
> How is this related?
>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> > I have an upcoming driver that will use this but which can also be buil=
t
> > on non-DT systems. I'd like to get that in as a fix to avoid inter-tree
> > dependencies later.
>
> Do you have a link?
>
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -362,9 +362,6 @@ extern struct device_node *of_get_cpu_state_node(st=
ruct device_node *cpu_node,
> >                                                  int index);
> >  extern u64 of_get_cpu_hwid(struct device_node *cpun, unsigned int thre=
ad);
> >
> > -#define for_each_property_of_node(dn, pp) \
> > -       for (pp =3D dn->properties; pp !=3D NULL; pp =3D pp->next)
> > -
> >  extern int of_n_addr_cells(struct device_node *np);
> >  extern int of_n_size_cells(struct device_node *np);
> >  extern const struct of_device_id *of_match_node(
> > @@ -892,6 +889,9 @@ static inline int of_prop_val_eq(struct property *p=
1, struct property *p2)
> >                !memcmp(p1->value, p2->value, (size_t)p1->length);
> >  }
> >
> > +#define for_each_property_of_node(dn, pp) \
> > +       for (pp =3D dn->properties; pp !=3D NULL; pp =3D pp->next)
>
> Is this safe if !OF? Can dn be NULL?

Good point. I would say running code shouldn't reach this though.
Also, it should be written in a way it gets optimized away if !OF is
valid.

Long term, I want to make struct device_node opaque. So if we really
want to fix this, I think we'd want to convert this to use an iterator
function. Though I guess any user would be mucking with struct
property too, so the whole loop would need to be reworked. So in
conclusion, don't use for_each_property_of_node(). :) Shrug.

Rob

