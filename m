Return-Path: <linux-kernel+bounces-1240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAC8814C34
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6926EB2273A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAA539FC7;
	Fri, 15 Dec 2023 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/2tZh3K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F76F381C3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2037b2d77dbso223367fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702655921; x=1703260721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMDmmtKyEjaK61NBtkr7gJU4IeLSBq2Hb033B/z2d3o=;
        b=m/2tZh3KaObazr9DTLPdRNVIdWOEtIhjEGxZofvnnHuMM1sHBtxi9EU/A8Cb8C2P/R
         K0M5eYmQjS/gYbnzjnhQnoA5IPf/HTZm4LpUqk5ULL65g9D13NgijQJ4RYzAJfHjK/XJ
         ra6tNN5dlxv5f/F05L+5uZvSQObcLyXtq2UNL421z17mvEMcUFX4aEA/KY4xK030zHxa
         Y7UdCg3KyfD/N7GRnJTQE/hw6tR4nekD9SZCZlu+QKGTowEgZH/qWlvz3pmIudvsDPIV
         KRybhssBfWNm0OcS/uCMr5H9r9iJxHjyB2uX/d/5HwmpmnAMu1CklTe7tQPq6ioNMWyQ
         UxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702655921; x=1703260721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMDmmtKyEjaK61NBtkr7gJU4IeLSBq2Hb033B/z2d3o=;
        b=FL8yH6fv3hVimBuBb+aeUhMPhE/mYk2i5lRjhfKjwishgRwRiA9sFsyWCO1zD6tTAR
         61XtlVEEuKgDYdZZFd5Uo7fWbo/5MVi5Un1hB7NMkDi7sEt1Hz9hr6UcJuAyS9inxcYM
         eC0/uodUO6shGZlj2w9lwrV0FmDY6/tZT5RZaajzsZYJlbIQuLzUmrHHgu44KoL6Fggh
         2AGRpmQ+k9wLE5WiwJZsFfDTaR+5p0alUUvRpytPAECq2ZODaO73lH2hutFyrnIjKsXY
         Lt72Zwv/a8AsOqdEv7WUijskgTXFKEGR8+Ft1sWz5R+pfMo4csR5cXIxxjpfTGq/ewv1
         xQOA==
X-Gm-Message-State: AOJu0YxLGWbzwhdYk9o5Yg4iCreJVN3ktpQFnqp6Li68nAkbPcf1Zs5c
	vET3txDG7gUVnSYp3PbMXYZ7j4Cp1m9jLj324s9URZAn
X-Google-Smtp-Source: AGHT+IFIi3S32z46SzFX1pWpqrOHerdi992+8y485w4cqmMH31HQdZY3ZXqLpXoY2w8aDsU/J4iXfeN2P9pJ+BkDG8M=
X-Received: by 2002:a05:6870:b07:b0:1fb:75b:12ec with SMTP id
 lh7-20020a0568700b0700b001fb075b12ecmr14937481oab.62.1702655921316; Fri, 15
 Dec 2023 07:58:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215052033.550509-1-ghanshyam1898@gmail.com>
 <5a58e510-e5b4-42ae-95a3-257ca802212a@infradead.org> <CAG-Bmocu0nL-AW=nR7ZaTG4fzRvw4XSq5grk4N-wDRF0opMR4Q@mail.gmail.com>
In-Reply-To: <CAG-Bmocu0nL-AW=nR7ZaTG4fzRvw4XSq5grk4N-wDRF0opMR4Q@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 15 Dec 2023 10:58:29 -0500
Message-ID: <CADnq5_P4CjkYvbbF=t++d6EDb45gvA7rWK8f5Dc1WBjYLOt6dQ@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: amd: fixed typos
To: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, lijo.lazar@amd.com, Xinhui.Pan@amd.com, 
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Le.Ma@amd.com, 
	dri-devel@lists.freedesktop.org, daniel@ffwll.ch, alexander.deucher@amd.com, 
	candice.li@amd.com, airlied@gmail.com, christian.koenig@amd.com, 
	Hawking.Zhang@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 3:40=E2=80=AFAM Ghanshyam Agrawal
<ghanshyam1898@gmail.com> wrote:
>
> On Fri, Dec 15, 2023 at 10:59=E2=80=AFAM Randy Dunlap <rdunlap@infradead.=
org> wrote:
> >
> > Hi--
> >
> > On 12/14/23 21:20, Ghanshyam Agrawal wrote:
> > > Fixed multiple typos in atomfirmware.h
> > >
> > > Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> > > ---
> > >  drivers/gpu/drm/amd/include/atomfirmware.h | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu=
/drm/amd/include/atomfirmware.h
> > > index fa7d6ced786f..41d553921adf 100644
> > > --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> > > +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> > > @@ -210,7 +210,7 @@ atom_bios_string          =3D "ATOM"
> > >  };
> > >  */
> > >
> > > -#pragma pack(1)                          /* BIOS data must use byte =
aligment*/
> > > +#pragma pack(1)                          /* BIOS data must use byte =
alignment */
> > >
> > >  enum atombios_image_offset{
> > >    OFFSET_TO_ATOM_ROM_HEADER_POINTER          =3D 0x00000048,
> > > @@ -452,7 +452,7 @@ struct atom_dtd_format
> > >    uint8_t   refreshrate;
> > >  };
> > >
> > > -/* atom_dtd_format.modemiscinfo defintion */
> > > +/* atom_dtd_format.modemiscinfo definition */
> > >  enum atom_dtd_format_modemiscinfo{
> > >    ATOM_HSYNC_POLARITY    =3D 0x0002,
> > >    ATOM_VSYNC_POLARITY    =3D 0x0004,
> > > @@ -645,7 +645,7 @@ struct lcd_info_v2_1
> > >    uint32_t reserved1[8];
> > >  };
> > >
> > > -/* lcd_info_v2_1.panel_misc defintion */
> > > +/* lcd_info_v2_1.panel_misc definition */
> > >  enum atom_lcd_info_panel_misc{
> > >    ATOM_PANEL_MISC_FPDI            =3D0x0002,
> > >  };
> > > @@ -683,7 +683,7 @@ enum atom_gpio_pin_assignment_gpio_id {
> > >    /* gpio_id pre-define id for multiple usage */
> > >    /* GPIO use to control PCIE_VDDC in certain SLT board */
> > >    PCIE_VDDC_CONTROL_GPIO_PINID =3D 56,
> > > -  /* if PP_AC_DC_SWITCH_GPIO_PINID in Gpio_Pin_LutTable, AC/DC swith=
ing feature is enable */
> > > +  /* if PP_AC_DC_SWITCH_GPIO_PINID in Gpio_Pin_LutTable, AC/DC switc=
hing feature is enable */
> >
> > s/enable/enabled/
> >
> > >    PP_AC_DC_SWITCH_GPIO_PINID =3D 60,
> > >    /* VDDC_REGULATOR_VRHOT_GPIO_PINID in Gpio_Pin_LutTable, VRHot fea=
ture is enable */
> >
> > Ditto.
> > There may be a few more that need this same treatment.
> >
> > >    VDDC_VRHOT_GPIO_PINID =3D 61,
> >
> > The other changes look good as far as they go, but codespell reports
> > a few more misspellings to consider:
> >
> > atomfirmware.h:213: aligment =3D=3D> alignment
> > atomfirmware.h:257: Offest =3D=3D> Offset
> > atomfirmware.h:258: Offest =3D=3D> Offset
> > atomfirmware.h:390: Offest =3D=3D> Offset
> > atomfirmware.h:455: defintion =3D=3D> definition
> > atomfirmware.h:648: defintion =3D=3D> definition
> > atomfirmware.h:686: swithing =3D=3D> switching
> > atomfirmware.h:704: calcualted =3D=3D> calculated
> > atomfirmware.h:967: compability =3D=3D> compatibility
> > atomfirmware.h:981: intenal =3D=3D> internal
> > atomfirmware.h:993: intenal =3D=3D> internal
> > atomfirmware.h:3469: sequece =3D=3D> sequence
> > atomfirmware.h:3507: indiate =3D=3D> indicate
> > atomfirmware.h:4429: stucture =3D=3D> structure
> > atomfirmware.h:4430: stucture =3D=3D> structure
> > atomfirmware.h:4462: regiser =3D=3D> register
> >
> >
> > thanks.
> > --
> > #Randy
> > https://people.kernel.org/tglx/notes-about-netiquette
> > https://subspace.kernel.org/etiquette.html
>
> Hi Randy,
>
> Thanks for your feedback. I will correct the grammatical errors.
>
> Regarding the other codespell suggestions, if I make the changes
> then checkpatch script gives a lot of errors and warnings. Some
> are related to usage of tabs, line lengths etc. Being a beginner
> in the linux kernel development, I am not sure how to fix
> (or whether to ignore) those warnings. Would it be okay if I
> proceed with only the small number of changes I have suggested
> with this patch itself?

How concerned are you with fixing these?  This file is owned by
firmware teams within AMD and shared across different OSes.  It
defines the structures present in the ROM on the board.  I'm inclined
to just leave it be to avoid churn when syncing it with the canonical
source.  We can certainly try and push the fixes back up into the
canonical code as well, but that may not be the easiest process.

Alex

