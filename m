Return-Path: <linux-kernel+bounces-500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCB4814202
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE732833C8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70F7D28D;
	Fri, 15 Dec 2023 06:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODUYZIqb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD716D268
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ceba6c4b8dso280631b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 22:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702623313; x=1703228113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wW3WF9+yE7Fm8DHl64+vajrAUnSKM81cqUzh0Jur8M8=;
        b=ODUYZIqbG31opih5NjZ/0tAbHtZumbjHDD6c1mShUwUh7DP6e1vDUdtqABYdtN5/h5
         z7HpEs0KwHdD7bd3h2ySScupyN18HUqPqQyziXAGOZJ76xspHhyotNANP/k8TSW1YkW1
         Dpobp6rYlSgCoBX7SSj27AY1uV1RcCiAWqg+P4R0cPemEg3RH4YqZTJdkgXWJe50i8ip
         pHSeV1E4XBUHX3lo7+OT0DxbeCnOvTcyHWuv1Xqr2He5gUPtwBaBdAhunQefY7KWzxex
         eVSpweJZPZcSZBIuZYFhDUWRAHupMKyUNJDeMPvXYBaxLkfEV4QsMOt8fW2Wa7+AwzZ4
         S9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702623313; x=1703228113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wW3WF9+yE7Fm8DHl64+vajrAUnSKM81cqUzh0Jur8M8=;
        b=gyYONX3X+BeXDcMhbvQEqbCv5jt2UaTG0aQK4G5znUYe2h5G/WiWSt3yGZ9lCrWpp6
         H9cEFK+dU3+zsgUY/br3mq/hOdAoHrL+xkJoY9fqGJ5gcY0FCBb/mn6+ESdm3PA8gt5m
         PR7CvgjREBofMnKP2cdJf7kyqOj2be8TiywYlPMIjoy+EOnMpX01llzMckIGa1J0saa4
         bdWFoAgb4NoIc1ImIsCOuf19MzGKbMZkPkYEMDKDr2YZfbJKpZNP4RNKvsarDu6JrqtF
         PYG0sX107MkANklq9D3OnzGyWewLPFIpliaOsoBqfR9fUSsBrvAPAU+jRDiYizD2mGOv
         7jwg==
X-Gm-Message-State: AOJu0YxAZLlDWnAPMq5Fw7xEM1TZY/nwCu65Yix1FpVjBc6DR0oViKq4
	61u9ugUG/KQhnDPs6R4yGaXeGeTA9ksQY+SPBec=
X-Google-Smtp-Source: AGHT+IGPkfV7hNbg63dlvmC9Me/aKmPpSuwzxEZdk0PYRCQAfXjtY5wCwqdgCiwgYgU1akmtIIUMwo4xZdFuEsr0N30=
X-Received: by 2002:a05:6a00:4653:b0:6ce:6f99:4ec4 with SMTP id
 kp19-20020a056a00465300b006ce6f994ec4mr14009886pfb.1.1702623313006; Thu, 14
 Dec 2023 22:55:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215052033.550509-1-ghanshyam1898@gmail.com> <5a58e510-e5b4-42ae-95a3-257ca802212a@infradead.org>
In-Reply-To: <5a58e510-e5b4-42ae-95a3-257ca802212a@infradead.org>
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Date: Fri, 15 Dec 2023 12:24:36 +0530
Message-ID: <CAG-Bmocu0nL-AW=nR7ZaTG4fzRvw4XSq5grk4N-wDRF0opMR4Q@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: amd: fixed typos
To: Randy Dunlap <rdunlap@infradead.org>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, Hawking.Zhang@amd.com, candice.li@amd.com, 
	Le.Ma@amd.com, lijo.lazar@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 10:59=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Hi--
>
> On 12/14/23 21:20, Ghanshyam Agrawal wrote:
> > Fixed multiple typos in atomfirmware.h
> >
> > Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/include/atomfirmware.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/d=
rm/amd/include/atomfirmware.h
> > index fa7d6ced786f..41d553921adf 100644
> > --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> > +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> > @@ -210,7 +210,7 @@ atom_bios_string          =3D "ATOM"
> >  };
> >  */
> >
> > -#pragma pack(1)                          /* BIOS data must use byte al=
igment*/
> > +#pragma pack(1)                          /* BIOS data must use byte al=
ignment */
> >
> >  enum atombios_image_offset{
> >    OFFSET_TO_ATOM_ROM_HEADER_POINTER          =3D 0x00000048,
> > @@ -452,7 +452,7 @@ struct atom_dtd_format
> >    uint8_t   refreshrate;
> >  };
> >
> > -/* atom_dtd_format.modemiscinfo defintion */
> > +/* atom_dtd_format.modemiscinfo definition */
> >  enum atom_dtd_format_modemiscinfo{
> >    ATOM_HSYNC_POLARITY    =3D 0x0002,
> >    ATOM_VSYNC_POLARITY    =3D 0x0004,
> > @@ -645,7 +645,7 @@ struct lcd_info_v2_1
> >    uint32_t reserved1[8];
> >  };
> >
> > -/* lcd_info_v2_1.panel_misc defintion */
> > +/* lcd_info_v2_1.panel_misc definition */
> >  enum atom_lcd_info_panel_misc{
> >    ATOM_PANEL_MISC_FPDI            =3D0x0002,
> >  };
> > @@ -683,7 +683,7 @@ enum atom_gpio_pin_assignment_gpio_id {
> >    /* gpio_id pre-define id for multiple usage */
> >    /* GPIO use to control PCIE_VDDC in certain SLT board */
> >    PCIE_VDDC_CONTROL_GPIO_PINID =3D 56,
> > -  /* if PP_AC_DC_SWITCH_GPIO_PINID in Gpio_Pin_LutTable, AC/DC swithin=
g feature is enable */
> > +  /* if PP_AC_DC_SWITCH_GPIO_PINID in Gpio_Pin_LutTable, AC/DC switchi=
ng feature is enable */
>
> s/enable/enabled/
>
> >    PP_AC_DC_SWITCH_GPIO_PINID =3D 60,
> >    /* VDDC_REGULATOR_VRHOT_GPIO_PINID in Gpio_Pin_LutTable, VRHot featu=
re is enable */
>
> Ditto.
> There may be a few more that need this same treatment.
>
> >    VDDC_VRHOT_GPIO_PINID =3D 61,
>
> The other changes look good as far as they go, but codespell reports
> a few more misspellings to consider:
>
> atomfirmware.h:213: aligment =3D=3D> alignment
> atomfirmware.h:257: Offest =3D=3D> Offset
> atomfirmware.h:258: Offest =3D=3D> Offset
> atomfirmware.h:390: Offest =3D=3D> Offset
> atomfirmware.h:455: defintion =3D=3D> definition
> atomfirmware.h:648: defintion =3D=3D> definition
> atomfirmware.h:686: swithing =3D=3D> switching
> atomfirmware.h:704: calcualted =3D=3D> calculated
> atomfirmware.h:967: compability =3D=3D> compatibility
> atomfirmware.h:981: intenal =3D=3D> internal
> atomfirmware.h:993: intenal =3D=3D> internal
> atomfirmware.h:3469: sequece =3D=3D> sequence
> atomfirmware.h:3507: indiate =3D=3D> indicate
> atomfirmware.h:4429: stucture =3D=3D> structure
> atomfirmware.h:4430: stucture =3D=3D> structure
> atomfirmware.h:4462: regiser =3D=3D> register
>
>
> thanks.
> --
> #Randy
> https://people.kernel.org/tglx/notes-about-netiquette
> https://subspace.kernel.org/etiquette.html

Hi Randy,

Thanks for your feedback. I will correct the grammatical errors.

Regarding the other codespell suggestions, if I make the changes
then checkpatch script gives a lot of errors and warnings. Some
are related to usage of tabs, line lengths etc. Being a beginner
in the linux kernel development, I am not sure how to fix
(or whether to ignore) those warnings. Would it be okay if I
proceed with only the small number of changes I have suggested
with this patch itself?

Thanks & Regards,
Ghanshyam Agrawal

