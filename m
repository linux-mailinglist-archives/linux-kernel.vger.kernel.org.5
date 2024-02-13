Return-Path: <linux-kernel+bounces-63386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161C3852E91
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C647D284BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB552BB09;
	Tue, 13 Feb 2024 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE4BrgNT"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27852BB0B;
	Tue, 13 Feb 2024 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821969; cv=none; b=e4J7i0El5Q+meBDhkiv4g3QJrvWEWJMUcti82XjFPBiG8EUYiCEQP5nf6NVTs9vUvmGr7Sw3KQoT7FT/Ae780ejEsBiYO4kT3FuF3yaY78kgsu3HA2tt5cia4e9i4hap5qJg0YAAYAufcnTR8QM5NkFeB+t+C3gtYPpIaWy+xH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821969; c=relaxed/simple;
	bh=LqehTDmV+5jKDLejDBoN3BNf/TlQhPLKg2oxo/V0vyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgMljP7JBxymsvnxGxOgGg1rO/F6oT948TLbVcX7hX53wuS/XGnyy37Wpn1uo7DWcQb0F/IuDpCdOCwLSXxBXz2XS64vVz35xGRVtjr700z0eXgYltvw8h4XNEU+Q7kFR0x+gYZlXPz9va6r+gUEti9ae/u2wGOjyOtlSDziFrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bE4BrgNT; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3cfacf0eadso62940766b.2;
        Tue, 13 Feb 2024 02:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707821966; x=1708426766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqehTDmV+5jKDLejDBoN3BNf/TlQhPLKg2oxo/V0vyY=;
        b=bE4BrgNTOwF2AtE4WgyGGDIk1FW5/1OHwxW8rUOsD/3oblRj3bKkZTA8bYrqf3QfIZ
         uWI0p1h1kFFbY9WmCy+4xwBqVHcVqxDRCj36qeCF8bpdtRgT7K1H15Q3fGP816BKl5kB
         xD8ECTSEonAWMdaZdKrw4HYDFySh1YQQdavhkCoUf6e/8iKGQEJEjcv/z9aR/33e3Mni
         p+e0xNxyw06P2WOHAQrbvym19YKe/7UCbWEhErRZyUc1ogGPm21vPwxQRjcdQ7TCllYJ
         tNmCz0KlZL2WiwG52au4EetYbcVSdWPilvJCwsX9MEf/E1Jb4EFdHhxE6UvwLdJSc3oa
         ROJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707821966; x=1708426766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqehTDmV+5jKDLejDBoN3BNf/TlQhPLKg2oxo/V0vyY=;
        b=P5ztYXC5wuQcNyEid5yBnNZumQc+u2Bp2424gEFC6nA7goHe37ICcWmVJyi7i0bjfh
         j26YElDmMh8ZLcFP42o1njxMPHE3w1Xn3kExqBaqbxPuIMpmzTvJAZhpQiBwQx6WMMj+
         p46VORPOch7ZctJNf2h++8DxHZ5n4+VlssV2Bj24ggDMEmkBTnIEGBdrj4i6sidPKt01
         ilGX2iJ1rGMsErIRLTeczVEz7bYXmptPgjOo10wssgjkIzD5ccV/eQT7ZX05hF/9dNh+
         cQS0kAzwYrO04LwYN2PMRB1IM+ym7u2KieaGJmEHXFFeXS4MqU776QZbFd9nZwcrpOmo
         s7KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqQdXJsK0Dt0UnaaR79/xAha2yLAxPuBWD5Z4Jo9609RE3sBrjpDg/eUPAHLqa9ahYeI1ILodeaLs44B4p7FGtkUzx0LJfeY8hXA==
X-Gm-Message-State: AOJu0YwEzHbe1OkboGD383/xXGyWP8w7KwYJ3y0W9EN9cOhgqpKs7G0K
	3epl1/p+4UOjCo/ujdxjaBZxiEbfN1os4+jhzWUuDAGUOwyG9XLdHTPkQOJ32Is1SdNALo6S6Ar
	cl2DEseWmTEcTsbwgXysCcdCxoR8=
X-Google-Smtp-Source: AGHT+IH6bTOc1rk5vP/88wLzWHsc1LGJ+2qG5hyzpPW7yqxehCV9Mg9yXGtDaAZ6gA8lVd9jbrKTi+QDJWjhmR5Pzjc=
X-Received: by 2002:a17:906:f8c7:b0:a3d:311:e132 with SMTP id
 lh7-20020a170906f8c700b00a3d0311e132mr835758ejb.11.1707821965586; Tue, 13 Feb
 2024 02:59:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240211101421.166779-1-warthog618@gmail.com> <CAHp75VeSLvrxMOARDBHBJ5VGVR-Jv-7saxjJiN-NOPMyTwit3Q@mail.gmail.com>
 <20240211231321.GA4748@rigel> <CAHp75VddjcLaRqugKuk+eejYx_0AHVL4SjYcdh7zUKDj8SpcQw@mail.gmail.com>
 <CAHp75VcjsVasfaZe25fWzzV-5vv7m7O0-v4j=pcvtWQGKtY5BQ@mail.gmail.com>
 <20240212095607.GA388487@rigel> <20240213103433.GA191617@rigel>
In-Reply-To: <20240213103433.GA191617@rigel>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2024 12:58:49 +0200
Message-ID: <CAHp75VcBOCinUup=DXE-CqNos4c0aEceSTVsnb6fRy06-rFheA@mail.gmail.com>
Subject: Re: [PATCH] gpio: uapi: clarify default_values being logical
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, brgl@bgdev.pl, 
	linus.walleij@linaro.org, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 12:34=E2=80=AFPM Kent Gibson <warthog618@gmail.com>=
 wrote:
> On Mon, Feb 12, 2024 at 05:56:07PM +0800, Kent Gibson wrote:
> > On Mon, Feb 12, 2024 at 11:44:02AM +0200, Andy Shevchenko wrote:
> > > On Mon, Feb 12, 2024 at 11:28=E2=80=AFAM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:

..

> In response after re-reading these docs:
>
> > > Also
> > > "The values are boolean, zero for low, nonzero for high."
> > > https://docs.kernel.org/driver-api/gpio/consumer.html
>
> That one is logical and should be changed.
>
> > > And there as well
> > > "With this, all the gpiod_set_(array)_value_xxx() functions interpret
> > > the parameter "value" as "asserted" ("1") or "de-asserted" ("0")."
> > > So, should we use asserted-deasserted?
>
> We should use active/inactive rather than asserted/de-asserted. This is
> the only place that terminology is used - which is ironic as it is this
> section (_active_low_semantics) that explicitly describes the
> physical/logical mapping.

..

> > > So, can you re-read all of it for high/low asserted/deasserted,
> > > active/inactive and amend accordingly?
>
> So, from these, consumer.rst is the only file requiring any change.
> I'll submit a patch for that shortly.

Thanks for taking care of this!

--=20
With Best Regards,
Andy Shevchenko

