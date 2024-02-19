Return-Path: <linux-kernel+bounces-71906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5E585AC56
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0F91F2391C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43AC51C2B;
	Mon, 19 Feb 2024 19:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5i4Vepy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6C33BB38;
	Mon, 19 Feb 2024 19:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372026; cv=none; b=M6HXZBVQQ6A1WrmiOhSn6+tAY/zKRJBukWO+o4ehDfPTha5MWsz+lfGawBolPxYi9dHLaSuBpQ9G8B/EMz1XKy7zeUUytP3OIODsPFxV0wlMJIfbAz+f5W/314YG5uw4HF0FlV5UwRX+sgJMXYa0qMd2wl5btArs193prpIjfU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372026; c=relaxed/simple;
	bh=gvbVxu3Tkn/zt+/cAheDgKN/hcXG3/Wj1mBdGg9U0mA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZhRR9kATntNu3hNPso22XqsjiZ+DkyHy51QmnNeb5xcMBQL+x5srcbl1qlrNmmzRuXTR82MLNNIOFuBGb7wcdyyduyMBMjwwLPqyfgeJ3+D7VqftxhPCz+rZ7jA466Ln3/uF25vb24i1/tNwKwt2PoR+mkvB6Ar4FOso7koMv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5i4Vepy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1044DC43390;
	Mon, 19 Feb 2024 19:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708372025;
	bh=gvbVxu3Tkn/zt+/cAheDgKN/hcXG3/Wj1mBdGg9U0mA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m5i4Vepy3iEzKWlrejsEZO23FUuiQY9nFKRTmcnaxlLq0YyBQScagsfKH+tKNDgB4
	 nd+qDGv2hkDXylHBr0dWEzsutsLlasrS3/GLTETmHGORdYe3xp5BkGMGTURkzkFIob
	 Cb1WOqJnmFqn+rOQF3ElEqEZ+egd8QYO9ERswZtMjRFg1RisOqMKr5eiycfPjIHjPP
	 XlwLsI4AhKdFVkICa6MaijFO32Rs+iGMOQ5wFCNdJ2nM9qiwJKIoMuL6j1GdWRsO+6
	 E6piO8NiZBGvlkPk0lxrjlbXcIDCO+f+nuIQQ3c37DJssawEx8JU0yP9RoX99YovxR
	 K0A0W/LnWMwYg==
Date: Mon, 19 Feb 2024 19:46:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ad7944: add driver for
 AD7944/AD7985/AD7986
Message-ID: <20240219194650.3e14c877@jic23-huawei>
In-Reply-To: <CAMknhBH2Pqa9xpPxnTCxJegVTbOG-QDeJA4YrQUPfj+hfSs73A@mail.gmail.com>
References: <20240216-ad7944-mainline-v2-0-7eb69651e592@baylibre.com>
	<20240216-ad7944-mainline-v2-2-7eb69651e592@baylibre.com>
	<CAMknhBH2Pqa9xpPxnTCxJegVTbOG-QDeJA4YrQUPfj+hfSs73A@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Feb 2024 13:13:35 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On Fri, Feb 16, 2024 at 1:47=E2=80=AFPM David Lechner <dlechner@baylibre.=
com> wrote:
>=20
> ...
>=20
> > +
> > +#define AD7944_DEFINE_CHIP_INFO(_name, _t, _bits, _sign)              =
 \
> > +static const struct ad7944_chip_info _name##_chip_info =3D {          =
   \
> > +       .name =3D #_name,                                              =
   \
> > +       .t =3D &_t##_timing_spec,                                      =
   \
> > +       .channels =3D {                                                =
   \
> > +               {                                                      =
 \
> > +                       .type =3D IIO_VOLTAGE,                         =
   \
> > +                       .indexed =3D 1,                                =
   \
> > +                       .differential =3D 1,                           =
   \
> > +                       .channel =3D 0,                                =
   \
> > +                       .channel2 =3D 1,                               =
   \
> > +                       .scan_index =3D 0,                             =
   \
> > +                       .scan_type.sign =3D _sign,                     =
   \
> > +                       .scan_type.realbits =3D _bits,                 =
   \
> > +                       .scan_type.storagebits =3D _bits > 16 ? 32 : 16=
,  \
> > +                       .scan_type.endianness =3D IIO_CPU,             =
   \
> > +                       .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) =
   \
> > +                                       | BIT(IIO_CHAN_INFO_SCALE),    =
 \
> > +               },                                                     =
 \
> > +               IIO_CHAN_SOFT_TIMESTAMP(1),                            =
 \
> > +       },                                                             =
 \
> > +}
> > +
> > +AD7944_DEFINE_CHIP_INFO(ad7944, ad7944, 14, 'u');
> > +AD7944_DEFINE_CHIP_INFO(ad7985, ad7944, 16, 'u');
> > +AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 18, 's'); =20
>=20
> Now that I have been enlightened [1] about pseudo-differntial inputs,
> I'm thinking that AD7944 and AD7985 should not have the .differential
> =3D 1 flag set since they are pseudo-differential inputs with a ground
> sense on the negative input (and no extra supply needed since it is
> always ground). Does that sound right?

yes

>=20
> AD7986 is true differential though, so should be correct already.
>=20
> [1]: https://lore.kernel.org/linux-iio/CAMknhBF5mAsN1c-194Qwa5oKmqKzef2kh=
XnqA1cSdKpWHKWp0w@mail.gmail.com/


