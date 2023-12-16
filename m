Return-Path: <linux-kernel+bounces-2114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 167B581580F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 07:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C170C28617E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A049312E45;
	Sat, 16 Dec 2023 06:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnaRYxQL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4C912B85
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 06:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1f055438492so1012692fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702708169; x=1703312969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IJK4GaizgrLiis48CUXncVArYOoTGeQV2TlJ9v+4Jg=;
        b=lnaRYxQLhRwwd7POIN7rVtAf/lmhfXncOauKE+JMOE6YFD0vzfVgG2FPICxnafzsPv
         YLg+BUPJ38IZran5/aPKJ23GHg10h8A7LuX4gp0Jb3OaPXHSYh3IYh1WGC7cSPbhK0gF
         8adMBY1OQ3xfuYxspycc/KiX7dCtjU6+58vyZykkhCtCUR8OWRcgL4pliH4F9I317CW3
         ezj4BkguPvYV6GSem3StNzpAwAfgW2jXRDwpG4M2sHuccp9j8DM4pgmNMtRR+0mNJith
         nZIcz5HLxIF/M1Kmeq0pBNbOSHeBP0OLmSXrr9ZJeIA4xPzH+OvxpYbRGZtpNCEG8rdh
         ekPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702708169; x=1703312969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IJK4GaizgrLiis48CUXncVArYOoTGeQV2TlJ9v+4Jg=;
        b=K/Xp3qA9/JRel4oCgVKFvuewJgin2yBgxCSuRkfmwY2Rh8l6409kjHKLR8FAYtRhPO
         m37ir2tU43kjxaqjFhuCAMFBBzEBL3mG47I/oIzSC1CYDXqjifCIKMw0uuRFMTTUesil
         TsJxQ6vHrNIVY2IXDLqXxhdfobTyoCG0N6t5ygBQ52iVFPJ2Nlmcv4+scq031IVloh0o
         yxe7dnO4NEd1XUS90K60bzDyTeN5Rr/ai7nHInJ9D0u5thsVecLXI98VKVNBOlWR/fDx
         vW6ISTfGr1zZnDE3riZwGJIi51RJ3uHPeAuVRDwVW3JY5ab08fNe0PFYLlNU4gKbW8RL
         NLCQ==
X-Gm-Message-State: AOJu0YzblVfWlVFtdYTxuugiP7mWtTFyPMoIqShM5OYYWYyT7/SKPR9l
	0kzcnMbb3rN5MA2WGzddBe1Gn2CN9DVTcs5q+Jk=
X-Google-Smtp-Source: AGHT+IFVO5b/fxJ9lhSJ879XvFrsRuenl9hZQvW04aqgkEzF+07nwoSmElUj5FpYOGXztsvQGXg3h5RRceSXZ0MAdHw=
X-Received: by 2002:a05:6871:3a0b:b0:203:743e:37ef with SMTP id
 pu11-20020a0568713a0b00b00203743e37efmr2548588oac.33.1702708169397; Fri, 15
 Dec 2023 22:29:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215052033.550509-1-ghanshyam1898@gmail.com>
 <5a58e510-e5b4-42ae-95a3-257ca802212a@infradead.org> <CAG-Bmocu0nL-AW=nR7ZaTG4fzRvw4XSq5grk4N-wDRF0opMR4Q@mail.gmail.com>
 <CADnq5_P4CjkYvbbF=t++d6EDb45gvA7rWK8f5Dc1WBjYLOt6dQ@mail.gmail.com>
In-Reply-To: <CADnq5_P4CjkYvbbF=t++d6EDb45gvA7rWK8f5Dc1WBjYLOt6dQ@mail.gmail.com>
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Date: Sat, 16 Dec 2023 11:58:53 +0530
Message-ID: <CAG-Bmofw2rR34ov4YrYHx5wuq0YpnUNOayq9ZzWtoP2WSTRvZA@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: amd: fixed typos
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, lijo.lazar@amd.com, Xinhui.Pan@amd.com, 
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Le.Ma@amd.com, 
	dri-devel@lists.freedesktop.org, daniel@ffwll.ch, alexander.deucher@amd.com, 
	candice.li@amd.com, airlied@gmail.com, christian.koenig@amd.com, 
	Hawking.Zhang@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 9:28=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Fri, Dec 15, 2023 at 3:40=E2=80=AFAM Ghanshyam Agrawal
> <ghanshyam1898@gmail.com> wrote:
> >
> > On Fri, Dec 15, 2023 at 10:59=E2=80=AFAM Randy Dunlap <rdunlap@infradea=
d.org> wrote:
> > >
> > > Hi--
> > >
> > > On 12/14/23 21:20, Ghanshyam Agrawal wrote:
> > > > Fixed multiple typos in atomfirmware.h
> > > >
> > > > Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/include/atomfirmware.h | 8 ++++----
> > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/g=
pu/drm/amd/include/atomfirmware.h
> > > > index fa7d6ced786f..41d553921adf 100644
> > > > --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> > > > +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> > > > @@ -210,7 +210,7 @@ atom_bios_string          =3D "ATOM"
> > > >  };
> > > >  */
> > > >
> > > > -#pragma pack(1)                          /* BIOS data must use byt=
e aligment*/
> > > > +#pragma pack(1)                          /* BIOS data must use byt=
e alignment */
> > > >
> > > >  enum atombios_image_offset{
> > > >    OFFSET_TO_ATOM_ROM_HEADER_POINTER          =3D 0x00000048,
> > > > @@ -452,7 +452,7 @@ struct atom_dtd_format
> > > >    uint8_t   refreshrate;
> > > >  };
> > > >
> > > > -/* atom_dtd_format.modemiscinfo defintion */
> > > > +/* atom_dtd_format.modemiscinfo definition */
> > > >  enum atom_dtd_format_modemiscinfo{
> > > >    ATOM_HSYNC_POLARITY    =3D 0x0002,
> > > >    ATOM_VSYNC_POLARITY    =3D 0x0004,
> > > > @@ -645,7 +645,7 @@ struct lcd_info_v2_1
> > > >    uint32_t reserved1[8];
> > > >  };
> > > >
> > > > -/* lcd_info_v2_1.panel_misc defintion */
> > > > +/* lcd_info_v2_1.panel_misc definition */
> > > >  enum atom_lcd_info_panel_misc{
> > > >    ATOM_PANEL_MISC_FPDI            =3D0x0002,
> > > >  };
> > > > @@ -683,7 +683,7 @@ enum atom_gpio_pin_assignment_gpio_id {
> > > >    /* gpio_id pre-define id for multiple usage */
> > > >    /* GPIO use to control PCIE_VDDC in certain SLT board */
> > > >    PCIE_VDDC_CONTROL_GPIO_PINID =3D 56,
> > > > -  /* if PP_AC_DC_SWITCH_GPIO_PINID in Gpio_Pin_LutTable, AC/DC swi=
thing feature is enable */
> > > > +  /* if PP_AC_DC_SWITCH_GPIO_PINID in Gpio_Pin_LutTable, AC/DC swi=
tching feature is enable */
> > >
> > > s/enable/enabled/
> > >
> > > >    PP_AC_DC_SWITCH_GPIO_PINID =3D 60,
> > > >    /* VDDC_REGULATOR_VRHOT_GPIO_PINID in Gpio_Pin_LutTable, VRHot f=
eature is enable */
> > >
> > > Ditto.
> > > There may be a few more that need this same treatment.
> > >
> > > >    VDDC_VRHOT_GPIO_PINID =3D 61,
> > >
> > > The other changes look good as far as they go, but codespell reports
> > > a few more misspellings to consider:
> > >
> > > atomfirmware.h:213: aligment =3D=3D> alignment
> > > atomfirmware.h:257: Offest =3D=3D> Offset
> > > atomfirmware.h:258: Offest =3D=3D> Offset
> > > atomfirmware.h:390: Offest =3D=3D> Offset
> > > atomfirmware.h:455: defintion =3D=3D> definition
> > > atomfirmware.h:648: defintion =3D=3D> definition
> > > atomfirmware.h:686: swithing =3D=3D> switching
> > > atomfirmware.h:704: calcualted =3D=3D> calculated
> > > atomfirmware.h:967: compability =3D=3D> compatibility
> > > atomfirmware.h:981: intenal =3D=3D> internal
> > > atomfirmware.h:993: intenal =3D=3D> internal
> > > atomfirmware.h:3469: sequece =3D=3D> sequence
> > > atomfirmware.h:3507: indiate =3D=3D> indicate
> > > atomfirmware.h:4429: stucture =3D=3D> structure
> > > atomfirmware.h:4430: stucture =3D=3D> structure
> > > atomfirmware.h:4462: regiser =3D=3D> register
> > >
> > >
> > > thanks.
> > > --
> > > #Randy
> > > https://people.kernel.org/tglx/notes-about-netiquette
> > > https://subspace.kernel.org/etiquette.html
> >
> > Hi Randy,
> >
> > Thanks for your feedback. I will correct the grammatical errors.
> >
> > Regarding the other codespell suggestions, if I make the changes
> > then checkpatch script gives a lot of errors and warnings. Some
> > are related to usage of tabs, line lengths etc. Being a beginner
> > in the linux kernel development, I am not sure how to fix
> > (or whether to ignore) those warnings. Would it be okay if I
> > proceed with only the small number of changes I have suggested
> > with this patch itself?
>
> How concerned are you with fixing these?  This file is owned by
> firmware teams within AMD and shared across different OSes.  It
> defines the structures present in the ROM on the board.  I'm inclined
> to just leave it be to avoid churn when syncing it with the canonical
> source.  We can certainly try and push the fixes back up into the
> canonical code as well, but that may not be the easiest process.
>
> Alex

Hi Alex,

Thanks for your review. I wanted to fix the typos because it helps
someone while searching through the code using text/ code searching
tools. If it is causing trouble as you suggested, we may as well
leave it as is. Let the maintainers take a call on this.

Thanks & Regards,
Ghanshyam Agrawal

