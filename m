Return-Path: <linux-kernel+bounces-129085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2185C896490
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30921F24D02
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD4E17555;
	Wed,  3 Apr 2024 06:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shruggie-ro.20230601.gappssmtp.com header.i=@shruggie-ro.20230601.gappssmtp.com header.b="jAY+1T70"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BD333F9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712125977; cv=none; b=Ob/SZKE0og5zP/P1sgLCikxgMvB48aSk6L5gRZqcDS/mue21iJwlE2AeI/Tw3/9lbFIq9kpgIPKCGdAkA0OyCdcm0Xk6lUTDE6ezaHG6OcjstgkLlUzZSOFD2wfhIrz5Pi/tNOPkDsiYYfDniCiogMAUW6MdrL39fejUIgD0klE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712125977; c=relaxed/simple;
	bh=qo4bmr1Fhew3KH/aSy9qZ6ZIDLaHOgGZUa/6HC5n8pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRABmYAdfaeXH+K3tXMbRU2DW6Pp4N2Jgz7bvpXWFUxgtDr9VWOOxFSFLc9IDy7v4p5Uf0BOhUuJFaJhk2URhziYTCJld1dzVSCAZ6shVybWwQBkKodk64oZL5wWV1YgZqW2rl1oOZehcwP5p5JtIHtTcM+H7AQBoGPtxDeXcNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shruggie.ro; spf=pass smtp.mailfrom=shruggie.ro; dkim=pass (2048-bit key) header.d=shruggie-ro.20230601.gappssmtp.com header.i=@shruggie-ro.20230601.gappssmtp.com header.b=jAY+1T70; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shruggie.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shruggie.ro
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-513d717269fso7119213e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 23:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20230601.gappssmtp.com; s=20230601; t=1712125972; x=1712730772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQu0eAAfwBJBisoFkbcN2EwG3dZ80aLb6SadbhowWsc=;
        b=jAY+1T70Se0V3HErLQ1oe952ok2bkGgrXWh2g7vtu+v1jULcEVZ8uaQ+WJ3hF6+7Lq
         JfjAdpiQQwB3++Fe+frOeP735+pKR5woX7dH/FWgpARRA2J8+MtthgzaeEvYx0WJVVHd
         kqdzdIaJ8YRKKn/6ww438lTdu2l7q3QvWLbDi8OIdYP89JKlHW90V5y/mb4Nkg4ryOkr
         PUUrIEedKEDOL0ds0m8k1JJmoq8yZUdyOtU4qhq7kW047sbu7Q+KWFTBkuWhlTmFvEJG
         8b8W0soUgBu4SHviFvmIuOe1lmAttQBlIV6e8FnHZCd6LZiT5BS8alktqrOACSVC9nBE
         sWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712125972; x=1712730772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQu0eAAfwBJBisoFkbcN2EwG3dZ80aLb6SadbhowWsc=;
        b=DgSmjdhR/iQY7h2FbTYdt0rxYf6tOyJiioBOom5uo6AdXD61Og7eC4rUaYKm+FvsB9
         7AfPS78AHbv/gxsAZ7JW5eAIyn8YauZhHfZ9r97gzmmhNqGHRqAYsLuoHyOTKxIiE+Ys
         +TgNJneisNZITfHf74zcagRLd0E0H/qUhddiPiGWCe6rxCv6Fm+lXjX4Llwrhn7S2ml6
         lS2qICtyfh3bUxR9y0262VxAVqC2EZAgWtvGNsLIM23n1aikQxE3UyG9SF8FRgC44xQq
         MmWnDZH8ewA2fbrgTushPcloSzK2D4TaIFiwm18rLHOOtVQKWKTX7vpmycdAd4ruI2vK
         Mqvw==
X-Gm-Message-State: AOJu0Yy/QfMpvsgSbjOfLxpdZFTIk5nH2lzOL33hhhCUgOgJ0XjZ/no1
	YDoJhsEQF6XrU6ssTAAvJa1L4JdjvZHE4JmPLm1XhRxo8eoGcjGj8ZgsJGbs0AeCbnNx33wwEhP
	N2ALF1epWZTSCtG4l82MpEUkO6XdovPkCUUO8hQ==
X-Google-Smtp-Source: AGHT+IGZtMZxTp4P+ypCEELpSKJykyHdbborNz/DySvN9QSemx4mIJKZP+NE2BO0MfJ4vxJRk16FRP/P4NLfj2ygcsk=
X-Received: by 2002:ac2:5a4b:0:b0:513:d1c7:7d37 with SMTP id
 r11-20020ac25a4b000000b00513d1c77d37mr9499704lfn.51.1712125972550; Tue, 02
 Apr 2024 23:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402105925.905144-1-alex@shruggie.ro> <20240402165307.GA31874@francesco-nb>
In-Reply-To: <20240402165307.GA31874@francesco-nb>
From: Alexandru Ardelean <alex@shruggie.ro>
Date: Wed, 3 Apr 2024 09:32:41 +0300
Message-ID: <CAH3L5Qr-sT+Q9ZvNSxHKwVMr8-3fU5WPvvaccEWWH49x7oWMyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/bridge: lt8912b: add support for P/N pin swap
To: Francesco Dolcini <francesco@dolcini.it>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, adrien.grassein@gmail.com, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	stefan.eichenberger@toradex.com, francesco.dolcini@toradex.com, 
	marius.muresan@mxt.ro, irina.muresan@mxt.ro
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 7:53=E2=80=AFPM Francesco Dolcini <francesco@dolcini=
it> wrote:
>
> Hello Alexandru, thanks for your patch.
>
> On Tue, Apr 02, 2024 at 01:59:24PM +0300, Alexandru Ardelean wrote:
> > On some HW designs, it's easier for the layout if the P/N pins are swap=
ped.
> > In those cases, we need to adjust (for this) by configuring the MIPI an=
alog
> > registers differently. Specifically, register 0x3e needs to be 0xf6
> > (instead of 0xd6).
> >
> > This change adds a 'lontium,pn-swap' device-tree property to configure =
the
> > MIPI analog registers for P/N swap.
> >
> > Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> > ---
> >  drivers/gpu/drm/bridge/lontium-lt8912b.c | 25 +++++++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm=
/bridge/lontium-lt8912b.c
> > index 4b2ae27f0a57f..154126bb922b4 100644
> > --- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
> > +++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
> > @@ -47,6 +47,7 @@ struct lt8912 {
> >
> >       u8 data_lanes;
> >       bool is_power_on;
> > +     bool do_pn_swap;
> >  };
> >
> >  static int lt8912_write_init_config(struct lt8912 *lt)
> > @@ -78,15 +79,31 @@ static int lt8912_write_init_config(struct lt8912 *=
lt)
> >               {0x55, 0x44},
> >               {0x57, 0x01},
> >               {0x5a, 0x02},
> > -
> > -             /*MIPI Analog*/
> > +     };
> > +     const struct reg_sequence mipi_analog_seq[] =3D {
> >               {0x3e, 0xd6},
> >               {0x3f, 0xd4},
> >               {0x41, 0x3c},
> >               {0xB2, 0x00},
> >       };
> > +     const struct reg_sequence mipi_analog_pn_swap_seq[] =3D {
> > +             {0x3e, 0xf6},
> > +             {0x3f, 0xd4},
> > +             {0x41, 0x3c},
> > +             {0xB2, 0x00},
> > +     };
> > +     int ret;
> >
> > -     return regmap_multi_reg_write(lt->regmap[I2C_MAIN], seq, ARRAY_SI=
ZE(seq));
> > +     ret =3D regmap_multi_reg_write(lt->regmap[I2C_MAIN], seq, ARRAY_S=
IZE(seq));
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (!lt->do_pn_swap)
> > +             return regmap_multi_reg_write(lt->regmap[I2C_MAIN], mipi_=
analog_seq,
> > +                                           ARRAY_SIZE(mipi_analog_seq)=
);
> > +
> > +     return regmap_multi_reg_write(lt->regmap[I2C_MAIN], mipi_analog_p=
n_swap_seq,
> > +                                   ARRAY_SIZE(mipi_analog_pn_swap_seq)=
);
>
> Can you just remove {0x3e, 0xd6} from the register/value array and write
> it afterward depending on `do_pn_swap` value? Or keep it with the
> current value and only overwrite it when do_pn_swap is true?
>
> If you do it this way is a 4 line change.

Hmm, good point.
I did it like this, because I don't have a board with the P/N in the
0xd6 configuration, to test.
But, if I leave it like this, and just overwrite 0x3e when
`do_pn_swap` is true, I can test that; and I don't need to test the
original case.

I'm actually not 100% sure here if the order of registers (being
written) matters for the initialization.


>
>
> >  static int lt8912_write_mipi_basic_config(struct lt8912 *lt)
> > @@ -702,6 +719,8 @@ static int lt8912_parse_dt(struct lt8912 *lt)
> >       }
> >       lt->gp_reset =3D gp_reset;
> >
> > +     lt->do_pn_swap =3D device_property_read_bool(dev, "lontium,pn-swa=
p");
>
> I would call this variable the same that is called in the lontium
> documentation, mipirx_diff_swap

Oh.
I actually based this change on a reference software for the LT8912B.
I didn't get a chance to see/find a documentation for the registers.
I compared with the Linux driver, to see what was missing to get
output on the HDMI display (for our setup).

>
> Francesco
>

