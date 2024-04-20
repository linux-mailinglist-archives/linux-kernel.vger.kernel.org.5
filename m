Return-Path: <linux-kernel+bounces-152233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 190548ABB28
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 12:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE0B1C20C2F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 10:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC626288D1;
	Sat, 20 Apr 2024 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+xPIczF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E39DDD9;
	Sat, 20 Apr 2024 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713610530; cv=none; b=C9h9zP41Dkm4/VniftRRkq+muiAxeuvDkhbdpzTCD2dAJgNsvM6ijnYqxLldjMs+tfYGwUMYdX8uRy/wTyx9UfitybEsczUeNvwFCJjNal4oxw+1DyM8QujyNca1/PtyX8KrbaW28yb09AUyWoTOq3Mt0ZSl8ltpwPSBhelBQuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713610530; c=relaxed/simple;
	bh=zTvudgFfH/h0LYFsm8ge6F5OW8AtcgM2CqtKKJJoAFI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVR3qfynIhuJqSi0AD/21mOari82yYpLan0Kb5c+hpPV6DwUj4Cjc0Hj2aGOr3h/3D6/fS0JaCgDXeDi79DxlKK9y7I0ZnteDyTnN49Xm0iB1wOw/aunS7DE3UluVH9r57kHqMJr11qFsV/iQH+BLsXimcFq3Jl4o3mWi/hmx+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+xPIczF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88899C072AA;
	Sat, 20 Apr 2024 10:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713610529;
	bh=zTvudgFfH/h0LYFsm8ge6F5OW8AtcgM2CqtKKJJoAFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K+xPIczFcKc0b03zVTfBLWnljX+6W2rVvX4lqpSCUmjQtyhiSx8W/GZ7/sqAq9Vth
	 8cxUJmGzzX0jLpi9iZXm45JqDTQ+/LgD84zFNZj2wKllv/esuC1O+gc7oa5xkpeD1A
	 j8nfyazAHCWabIAKKCJBJ+VSrhybwPEva7B5sdsTQ5+AEK1m60s4WLvxCgT5Ak/Brj
	 BZqAq8Z7YGLv/YJCe1rXwzb21D1tk8fkGb0c2ljKD/gkRVOARRe0uG9cY2TucckA9A
	 Im5MnlnN1BjXS6PbZ4mD1kFT8meceWp6oE8r/TwNRgb94uXz2yPYKM/krZLWlBHugd
	 n1sU2FSogK41A==
Date: Sat, 20 Apr 2024 11:55:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>,
 michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexandru.tachici@analog.com, lars@metafoo.de, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, okan.sahin@analog.com, fr0st61te@gmail.com,
 alisa.roman@analog.com, marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
 liambeguin@gmail.com
Subject: Re: [PATCH v6 5/5] iio: adc: ad7192: Add AD7194 support
Message-ID: <20240420115457.44f558cf@jic23-huawei>
In-Reply-To: <CAHp75VctFbys8ARoE9ZqsCSCOYWjsZnR80g+YXstbyzo5r6TYw@mail.gmail.com>
References: <20240417170054.140587-1-alisa.roman@analog.com>
	<20240417170054.140587-6-alisa.roman@analog.com>
	<CAHp75VctFbys8ARoE9ZqsCSCOYWjsZnR80g+YXstbyzo5r6TYw@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Apr 2024 20:06:00 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Apr 17, 2024 at 8:01=E2=80=AFPM Alisa-Dariana Roman
> <alisadariana@gmail.com> wrote:
> >
> > Unlike the other AD719Xs, AD7194 has configurable differential
> > channels. The user can dynamically configure them in the devicetree.
> >
> > Also modify config AD7192 description for better scaling. =20
>=20
> ...
>=20
> > +       device_for_each_child_node(dev, child) { =20
>=20
> You can use scoped variant AFAIU that's available in Jonathan's tree.
>=20
> > +               *ad7194_channels =3D ad7194_chan_diff;
> > +               ad7194_channels->scan_index =3D index++;
> > +               ret =3D ad7194_parse_channel(child, ad7194_channels);
> > +               if (ret) { =20
>=20
> > +                       fwnode_handle_put(child); =20
>=20
> With the above this wouldn't be needed.
>=20
As it's a minor improvement, and I tend not to like unnecessary
interdependence of series in my tree (until they are in char-misc
and hence no chance of them changing), I'm fine with not using
that new functionality here.=20

That will change once it's upstream of course!

I will send a pull request to Greg nice and early this cycle
so that should be in my upstream soon.

I'm also fine with you using this if you want to though!

Jonathan

> > +                       return ret;
> > +               }
> > +               ad7194_channels++;
> > +       } =20
>=20


