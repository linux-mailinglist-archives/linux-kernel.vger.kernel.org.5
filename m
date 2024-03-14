Return-Path: <linux-kernel+bounces-103163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7020387BBC7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14401C2130A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E8A6EB56;
	Thu, 14 Mar 2024 11:15:09 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC566E617
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710414909; cv=none; b=AxKs3CqgsRW1d+Y+wmzbn0Jtvfz5K9yRKz2ewkPN+FuD+h+pcXoXpeQr3fQ8SCHiVHkEilk7IHzsqRrYeUe9Yp9u8UsuMg/z0OekmvEGH+o5JkkwexrhvVvFf129rvqBQEfb54znMJf0RN0LWnoA3saOqPzJ0K+tlJZELoggAns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710414909; c=relaxed/simple;
	bh=MHPwaGe+JEy2PghaKynwl1tJuqHfhafULXPHJzyP8ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPr/ilPq2Td7jBfgQSf75JxF+7wDmUb8+wg9TJFKgGjilXd5tbMXQSXlR0nTzPO8hIgdb4uPqVe+gGiMc9iQe+CkYVf1ELiOu3noQgFK8Npv2L38JjVgjUb000vvIiq7QIW5B0j39qYg+2HeuDx48Dse9DoEni7nXJ91NP4OrGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-609f359b7b1so10470837b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 04:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710414905; x=1711019705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaxQeb/LOGJ+tXY7ROrISTEEvDtokZCLzq0Vp5ELGOY=;
        b=JORK8pw7T1bTfMAgLI/0aEZ/BWR6FxCQkyHkV3ZeBSaaNwap8+aG9pihQlmALCjqic
         BwZaAoiAU1Qg3dThG1bugxDSZcnOPrb35Z2m1JCOUeuG8YnzxOaHeQKqCW9PHUBjWrZR
         Eknz7B/T/4keEsDvQqPgTAsmUkNBZFDVm3hGKpvzPZ5twI5bTkOa9K8E9vw4leNzSXDs
         r52PzMFYtu35xn5ysrevjhzMaAuYw4a2E/0RLDRjhQ+u4thMyhHDU+1DhhuDRqeHoi/f
         H64wlG/uDzN0z1r7rilW/iNZ/z2IPwqcFibaYqEJBygOTpy9NK5b8O2nTR2PBaIXZRkj
         wKMg==
X-Forwarded-Encrypted: i=1; AJvYcCWwG3vQlO2NCztEvf3iBda6HsIIadBbBCarWAkAgwENY0r/TENfgRHInN3mOKe2CAvkiizEQCehG5xKXLiBXdMo0LKFEPIW5rbHaqng
X-Gm-Message-State: AOJu0Yxdb1FX4nPxZaLtjwkh7EOoYiktE10kZY3Stpr9sQJ2cWJSC5PM
	eWLmpfMEA6cXmm9e+mxnRbusm4K+GX1PyWA9Ez4YdF+XXVCtAp7PhoG7rjmdRjY=
X-Google-Smtp-Source: AGHT+IHlf7yjRfh3hwLDVCcES73+tXcnUssHVZ2jAsN57d38Fl9BJkzKxbkGf6fCmhmfHhkIwxqGWg==
X-Received: by 2002:a81:6ccc:0:b0:60b:a592:724b with SMTP id h195-20020a816ccc000000b0060ba592724bmr1391981ywc.18.1710414905521;
        Thu, 14 Mar 2024 04:15:05 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id fj3-20020a05690c330300b00609f893ee94sm223467ywb.127.2024.03.14.04.15.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 04:15:04 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-609f1f97864so9234757b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 04:15:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXk9Kd7hnMzhai6RYFrGmRKONv4q11Mgz3PqznF3oxBzQlhpoc9h+c1esNQc0XYzqxY/owdmeM4iU12iX8oBHc3uap4mi4j9DOu5UQ0
X-Received: by 2002:a0d:e782:0:b0:609:fdf7:b443 with SMTP id
 q124-20020a0de782000000b00609fdf7b443mr1440372ywe.52.1710414904384; Thu, 14
 Mar 2024 04:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvG9KE15PGNoLu+SBVyShe+u5HBLQ81+kK9Zop6u=ywmw@mail.gmail.com>
 <338c89bb-a70b-4f35-b71b-f974e90e3383@app.fastmail.com> <20240304-brawny-goshawk-of-sorcery-860cef@houat>
 <85b807289ff2400ea5887ced63655862@AcuMS.aculab.com> <CAMuHMdUuOnXVpocYU02Mx3_KrPow-=+WgLJqy_ku=AN52SvQiA@mail.gmail.com>
In-Reply-To: <CAMuHMdUuOnXVpocYU02Mx3_KrPow-=+WgLJqy_ku=AN52SvQiA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Mar 2024 12:14:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXbmZyiy_Ca8eVQtwAhJ-_JsKEOpjrGehirWziPKbd=7g@mail.gmail.com>
Message-ID: <CAMuHMdXbmZyiy_Ca8eVQtwAhJ-_JsKEOpjrGehirWziPKbd=7g@mail.gmail.com>
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

On Thu, Mar 14, 2024 at 10:27=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sat, Mar 9, 2024 at 3:34=E2=80=AFPM David Laight <David.Laight@aculab.=
com> wrote:
> > From: Maxime Ripard
> > > Sent: 04 March 2024 11:46
> > >
> > > On Mon, Mar 04, 2024 at 12:11:36PM +0100, Arnd Bergmann wrote:
> > > > On Mon, Mar 4, 2024, at 09:07, Naresh Kamboju wrote:
> > > > > The arm defconfig builds failed on today's Linux next tag next-20=
240304.
> > > > >
> > > > > Build log:
> > > > > ---------
> > > > > ERROR: modpost: "__aeabi_uldivmod"
> > > > > [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko] undefined!
> > > > >
> > > >
> > > > Apparently caused by the 64-bit division in 358e76fd613a
> > > > ("drm/sun4i: hdmi: Consolidate atomic_check and mode_valid"):
> > > >
> > > >
> > > > +static enum drm_mode_status
> > > > +sun4i_hdmi_connector_clock_valid(const struct drm_connector *conne=
ctor,
> > > > +                                const struct drm_display_mode *mod=
e,
> > > > +                                unsigned long long clock)
> > > >  {
> > > > -       struct sun4i_hdmi *hdmi =3D drm_encoder_to_sun4i_hdmi(encod=
er);
> > > > -       unsigned long rate =3D mode->clock * 1000;
> > > > -       unsigned long diff =3D rate / 200; /* +-0.5% allowed by HDM=
I spec */
> > > > +       const struct sun4i_hdmi *hdmi =3D drm_connector_to_sun4i_hd=
mi(connector);
> > > > +       unsigned long diff =3D clock / 200; /* +-0.5% allowed by HD=
MI spec */
> > > >         long rounded_rate;
> > > >
> > > > This used to be a 32-bit division. If the rate is never more than
> > > > 4.2GHz, clock could be turned back into 'unsigned long' to avoid
> > > > the expensive div_u64().
> > >
> > > I sent a fix for it this morning:
> > > https://lore.kernel.org/r/20240304091225.366325-1-mripard@kernel.org
> > >
> > > The framework will pass an unsigned long long because HDMI character
> > > rates can go up to 5.9GHz.
> >
> > You could do:
> >         /* The max clock is 5.9GHz, split the divide */
> >         u32 diff =3D (u32)(clock / 8) / (200/8);
>
> +1, as the issue is still present in current next, as per the recent
> nagging from the build bots.

Oops, s/next/upstream/.
Well, less 32-bit build testing for the next few days :-(

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

