Return-Path: <linux-kernel+bounces-103049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5727987BA65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7321F22A48
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0A66CDC9;
	Thu, 14 Mar 2024 09:27:43 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB07E6CDC3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408463; cv=none; b=gZq2jQVp2r/EPII1iPYXeaBPX7cPbnb5cXk8/wXXSs62vcHYW0cJUeXQdUte5xFC8dnrAF4EE3HHRcAtxavpfmj2MH5ATPpweiNujtfFkCtpAATWfY4pdwoqUDfMmI9J7iG9NG+p3BycY5oTKSUiUKctpa0F4+KmUTgYB0POVwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408463; c=relaxed/simple;
	bh=f/Op71/HodaIe/ZXYbQm5hzh0Ck9AYk9S6c3uv7jZl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXZicSh0m3/ZRjWDgLEFzrq2jXvjdjjwAXDG5zpFjNPRzVy31NSP0jtxTruxNdE+hU5bRwkhnc41SD/qgI43mUYPY9Tqzv+biwotJymee9RaElrDSIN1ZZB68WhcoGUNv1gH9DAvv56yhZcAb4TyIVXvDna1bqJU8OtrthjlcTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60a046c5262so7479837b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 02:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710408461; x=1711013261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IaLpKVgtNxjkHzGcUUabbJb9+dMavCQgVpAQ745YG6s=;
        b=qtwNe/kQZCxZmTTopJFmSXi/UwfPKXxOoA4gD7wSbVg/YDQqDW+fydqdTB0P+cEtUy
         oHwCAQgnwjzcBj/NJ5N9/qTa2gD5CSmRWyVYBtoLYNZvbpogYZT64hORY3m8NNj8BgPW
         u88tuWZIQZkiup4ugCt3XmZ0S3AEF+bytm819T1SoSjcelXcTffR/elTG4PBIVvpRSiB
         gBw9hWxeib3mNFqhkA/qZRC/MWxoIpBJviGfS7yHcL+U0LjUn0yZ7aDVRCzOYmMphxFA
         vew1eIrkcNtaDKIbm1nTNa7JoIQsjKnci/Z0q28cvckM6Lq60zv2DiW3KqFUFF2vWZdD
         E8bg==
X-Forwarded-Encrypted: i=1; AJvYcCUWtPfd+plUeO+oVLFxQRkb5Aw6UMKsfyvlq4TIVo6LCHRz8ViE28WzHzbf6gcQrEtpIvRY5L4FuLPM9mWzaAJHdjLz/aDBYzvAIWSq
X-Gm-Message-State: AOJu0YzIM3MHQtCgmb85fh3FG09FNylqfojoqEbJEa4k8Y8U63OAe/vE
	iRhDZPBBEr1DumdeNm05ue1xn9ltSN6rAspbpQ38aXzZ3WRA8ZMkhyzT36lV/2s=
X-Google-Smtp-Source: AGHT+IFiVFxJ8nt0Ff0+LVXQVIaJyc6TnXQM4H2fOxeQHqw/JaYPPtJ3ox1crgmBSqbkWpjDv2r1hQ==
X-Received: by 2002:a0d:fe42:0:b0:609:fef9:77b0 with SMTP id o63-20020a0dfe42000000b00609fef977b0mr1255321ywf.37.1710408459760;
        Thu, 14 Mar 2024 02:27:39 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id l71-20020a81574a000000b0060a4b02124dsm196384ywb.144.2024.03.14.02.27.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 02:27:39 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-db3a09e96daso566128276.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 02:27:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCAPHLGnHGrzgNLPEtDj3OZJGCtw+rClMzXfDCgcIyJ9TDou47WT0NNzNuBtUx4ubaRzA6MccvL+AxPWUQLoshvz8i439MWduOYZJk
X-Received: by 2002:a25:a264:0:b0:dcd:38f9:f78 with SMTP id
 b91-20020a25a264000000b00dcd38f90f78mr1053493ybi.29.1710408456666; Thu, 14
 Mar 2024 02:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvG9KE15PGNoLu+SBVyShe+u5HBLQ81+kK9Zop6u=ywmw@mail.gmail.com>
 <338c89bb-a70b-4f35-b71b-f974e90e3383@app.fastmail.com> <20240304-brawny-goshawk-of-sorcery-860cef@houat>
 <85b807289ff2400ea5887ced63655862@AcuMS.aculab.com>
In-Reply-To: <85b807289ff2400ea5887ced63655862@AcuMS.aculab.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Mar 2024 10:27:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUuOnXVpocYU02Mx3_KrPow-=+WgLJqy_ku=AN52SvQiA@mail.gmail.com>
Message-ID: <CAMuHMdUuOnXVpocYU02Mx3_KrPow-=+WgLJqy_ku=AN52SvQiA@mail.gmail.com>
Subject: Re: arm: ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko]
 undefined!
To: David Laight <David.Laight@aculab.com>
Cc: Maxime Ripard <mripard@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	"linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>, Dave Airlie <airlied@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 3:34=E2=80=AFPM David Laight <David.Laight@aculab.co=
m> wrote:
> From: Maxime Ripard
> > Sent: 04 March 2024 11:46
> >
> > On Mon, Mar 04, 2024 at 12:11:36PM +0100, Arnd Bergmann wrote:
> > > On Mon, Mar 4, 2024, at 09:07, Naresh Kamboju wrote:
> > > > The arm defconfig builds failed on today's Linux next tag next-2024=
0304.
> > > >
> > > > Build log:
> > > > ---------
> > > > ERROR: modpost: "__aeabi_uldivmod"
> > > > [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko] undefined!
> > > >
> > >
> > > Apparently caused by the 64-bit division in 358e76fd613a
> > > ("drm/sun4i: hdmi: Consolidate atomic_check and mode_valid"):
> > >
> > >
> > > +static enum drm_mode_status
> > > +sun4i_hdmi_connector_clock_valid(const struct drm_connector *connect=
or,
> > > +                                const struct drm_display_mode *mode,
> > > +                                unsigned long long clock)
> > >  {
> > > -       struct sun4i_hdmi *hdmi =3D drm_encoder_to_sun4i_hdmi(encoder=
);
> > > -       unsigned long rate =3D mode->clock * 1000;
> > > -       unsigned long diff =3D rate / 200; /* +-0.5% allowed by HDMI =
spec */
> > > +       const struct sun4i_hdmi *hdmi =3D drm_connector_to_sun4i_hdmi=
(connector);
> > > +       unsigned long diff =3D clock / 200; /* +-0.5% allowed by HDMI=
 spec */
> > >         long rounded_rate;
> > >
> > > This used to be a 32-bit division. If the rate is never more than
> > > 4.2GHz, clock could be turned back into 'unsigned long' to avoid
> > > the expensive div_u64().
> >
> > I sent a fix for it this morning:
> > https://lore.kernel.org/r/20240304091225.366325-1-mripard@kernel.org
> >
> > The framework will pass an unsigned long long because HDMI character
> > rates can go up to 5.9GHz.
>
> You could do:
>         /* The max clock is 5.9GHz, split the divide */
>         u32 diff =3D (u32)(clock / 8) / (200/8);

+1, as the issue is still present in current next, as per the recent
nagging from the build bots.

> The code should really use u32 and u64.
> Otherwise the sizes are different on 32bit.

The code is already using a variety of types (long, unsigned long long,
unsigned long) :-(

       max_t(unsigned long, rounded_rate, clock) -
       min_t(unsigned long, rounded_rate, clock) < diff)

At least u64 should make it very clear clock does not fit in 32-bit.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

