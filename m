Return-Path: <linux-kernel+bounces-92780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECBD8725E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2BC51C22371
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE8B175A5;
	Tue,  5 Mar 2024 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Ye/Kkrf+"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4308017581
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660880; cv=none; b=FOwQH2JT4xrTqaEWx0/DD6SzMu1JhnykUWMjPhpu9rbwHIbw7yflBSmz6iXrRddqvoqW82vDFQ62BzECkH2JH2bbp2SheQXr1gBChR+evM2lPfM8VwoU+ukvG4scCZzA5uikm9UFheT74mWPmlzJD62EnZEZ6DMTnbyYFIKsNh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660880; c=relaxed/simple;
	bh=lqrkc9GF0vxyq5fO5Gre7dxe8G4AxGzKWxssXtWhTsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAoU1HqTWJ2JUPjdXzi+sS1XYyA/YCjwola7+L8zRuQP4b8IrXyZbnwxKFaL4Ao8K9DLiiSN1fvWWeyRGVCL+lMz39XVUyUdMWAhiEhuVZMW2Ym7N/H90XSqUBTS/V5mX2oXksUIUYoPWFFYHyrxGhoVE1uPEIeXib9JZxqIwt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Ye/Kkrf+; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7dacc916452so12696241.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 09:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709660877; x=1710265677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDQM6QfXt4EJ1gFRectW8NUgDjZxP3g8A+hX/it5GaQ=;
        b=Ye/Kkrf+73LdLomFGBPUbr50Ct3a58lFOYaHalIIuAKcywBHPxqwUCemykgu1JKdMV
         1M9U5xui+/V3GnHrGv9ZvfroNgCk50cev/1Toj1fSgt/2xAHbP9T9RMvottoHuQfXw4e
         em/ccHJTQyIdNoP1lkyWxhSolD2/jK4PiFkEr+aQkoeoCpRiHX1KLkPZvT0H0255AfB0
         PuHSsf96U8EH9gkKg2VRfgndTj9Zf3U15iQDnLJ+O94lKQDk1PSWBO4DkFj2eacSpTRd
         ayTgoPGovvYJNPQmyYYdNDsdm30K9qoVyGHqlstnQj5VkOK0+DNa+NIehD1RV/+5owNk
         5M6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709660877; x=1710265677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDQM6QfXt4EJ1gFRectW8NUgDjZxP3g8A+hX/it5GaQ=;
        b=sfhcBp5XiJbliapnFCYZyqU0pnvLXfmPUzEgFRQw+2WPplpD2Q1KQdDpx5cz8SsObh
         v20eH/wf+EHjjKzxeKW+XZxHfrqjiFFvbcvSfpd1SDT5LEz6JPg4sd4MiUbiX/8t8e/K
         lHDnrIG2ia7q8blluLiehe8X9xbaUKa53y1V748KJxoyRZeYrE769mfvzoXmiRQtnwZ9
         7l5+HC2CIYCjc+ph77ceUg9Vz8iRhSQuX/lhNUK+28khqY1viBQLKqP8Z1LmNyfY42eo
         pWcP8fSt5a7GTtITB//QOoibb/F1COZ4zONQV2uTaEZiiZBNF/4hhk7c531byilY4e8t
         oFew==
X-Forwarded-Encrypted: i=1; AJvYcCW6aZ/Iii55mbkTtgo3AlMAetHJDl2Zi1TJcUrufyHR1PkoEqJ6bnkTsd13I01Jbv/lgvAG2otjdPO1j3yTmTNY9hQPk/Q4TRS7Xb6C
X-Gm-Message-State: AOJu0YxJdq4J9CxSyvgIWnLzV1krweZGQkbRR5KiHOpL7PfeNjNCnZfw
	JTLhNx0i4sO/Vw1nUcNbazujzmWZ71mouhFyM2BuYBWcTEjjmTCuEpntYiQOjY1T9JlckWZJjF1
	dSalHVPCNdfzUOcsAF+AmGaH63LNZ34z5JpoB0Q==
X-Google-Smtp-Source: AGHT+IEqLUxIJ4Znb8yoA8Q79Hj8R5LcveXzhu7gKuBQojWjEd1T/Kf7lufFee6lPAtgNFzX1Do816FIQFwzSHWJABc=
X-Received: by 2002:ac5:c953:0:b0:4c0:2bdc:250f with SMTP id
 s19-20020ac5c953000000b004c02bdc250fmr2188459vkm.7.1709660877099; Tue, 05 Mar
 2024 09:47:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303104853.31511-1-brgl@bgdev.pl> <CAMuHMdXWdKZjjZc39iXfa6Nohtn+Xm9YvcF+YoRpNzCgeWD8tA@mail.gmail.com>
In-Reply-To: <CAMuHMdXWdKZjjZc39iXfa6Nohtn+Xm9YvcF+YoRpNzCgeWD8tA@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 5 Mar 2024 18:47:46 +0100
Message-ID: <CAMRc=MehZVdbYpGLH76YE_fJA2q=Wojg5zOV2obkn8M6EBXiYQ@mail.gmail.com>
Subject: Re: [PATCH] of: make for_each_property_of_node() available to to !OF
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 9:32=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68k=
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

This commit added that macro in the wrong place. Back then it was
called differently, it got later renamed but this is the original
commit that provided it.

> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> > I have an upcoming driver that will use this but which can also be buil=
t
> > on non-DT systems. I'd like to get that in as a fix to avoid inter-tree
> > dependencies later.
>
> Do you have a link?
>

Sure, it's here: https://github.com/brgl/linux/tree/topic/gpio-virtual-cons=
umer

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
>

The way I use it[1], it's safe but it's a good point, I'll send a follow-up=
.

Thanks,
Bart

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

[1] https://github.com/brgl/linux/blob/topic/gpio-virtual-consumer/drivers/=
gpio/gpio-virtuser.c#L878

