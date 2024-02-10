Return-Path: <linux-kernel+bounces-60501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BCD8505C3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76AD71C23946
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3F65D471;
	Sat, 10 Feb 2024 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmYEOHFO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F06259B;
	Sat, 10 Feb 2024 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707586972; cv=none; b=ZvlC/6xRH7QufIMQXYw6JV2hgADpPv98sPSfnEibAXBc9D2S+wY6XUnq07JHakT9fV0/04E/KNkOJJAr0hW6jXBOkZoaGdG73uEWsCOP5LNMZfh0zrPEZsTWi0J/ssTkJ6xaElXfzvvyPCDYMPSSXMkMl5a5JxzPrgYuAv3t3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707586972; c=relaxed/simple;
	bh=F7oZGvL/sYlmHwJCPXB6gJfnpzBuQezPqvGmSOPj4EM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXI1m8oqFzIDPmNxXTbVwELqSaca/DZ6HI/TrORj8J3DVopLbxp227qBLHk1sfJQSP5P1Lyq9DH+lZv8EHSgcl0W8Y69UNbtaoGFYNwKEyWCgDopbDWcC8EH5kkNLE2cv65Tk1WAqeTeYQXEv2+6PW5v1+oD9tQN+xRyfBu0Yps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmYEOHFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4122FC433F1;
	Sat, 10 Feb 2024 17:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707586972;
	bh=F7oZGvL/sYlmHwJCPXB6gJfnpzBuQezPqvGmSOPj4EM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rmYEOHFOVRqGkeSpWH6e8VuEnRkkRmWlgWmLNEK2SCX4EgIddG/nLVlAtI+IuGiMQ
	 LblpJtZB2uSWl00OyetkIxjziGXxIpWs6As/0QZyY2JzYIN9ev8PXGa9IMYs+c9fJh
	 m6HPIuB72+83Q13wCT2AFxkPfqMrvypqvVCU4x8gFBHk4N/wDsPOCf8GOUHFqCoFp5
	 vIDBEm/tjZNgiIJ64HW1RCIE4q1knH0UYBCSAoCcORoUXEo5DK9w7kcS5o9EDsZbMs
	 LQdffJVs+PZ0LpVteHahXZ3LcBwfIF1Oo+9dUyodHJ6UVmKxKFAEH/tOljcwWusdXf
	 x/gCALHZpjceQ==
Date: Sat, 10 Feb 2024 17:42:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad7944: add driver for
 AD7944/AD7985/AD7986
Message-ID: <20240210174239.550c5d64@jic23-huawei>
In-Reply-To: <06a2a5618058909df52b685f461e668b259ff42a.camel@gmail.com>
References: <20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com>
	<20240206-ad7944-mainline-v1-2-bf115fa9474f@baylibre.com>
	<5fd17b66eab1989b9cfb874445c18480a2282809.camel@gmail.com>
	<CAMknhBHP40uXtviZ1KCQ3ZyruaLUVrjpp573u7QqMCT1tuoYjw@mail.gmail.com>
	<06a2a5618058909df52b685f461e668b259ff42a.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


> > >  =20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (chan->scan_type.sign =3D=3D 's')
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 *val =3D sign_extend32(*val, chan->scan_type.realbits - 1);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 return IIO_VAL_INT;
> > > > +}
> > > > +
> > > > +static int ad7944_read_raw(struct iio_dev *indio_dev,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
nst struct iio_chan_spec *chan,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
t *val, int *val2, long info)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct ad7944_adc *adc =3D iio_priv(indio=
_dev);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 switch (info) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_RAW:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D iio_device_claim_direct_mode(indio_dev);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (ret)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > > > + =20
> > >=20
> > > I'm not totally sure but I think Jonathan already merged his series f=
or the
> > > cleanup stuff for the claim direct mode. Maybe take a look and use it=
? Not a
> > > big
> > > win in here but I guess we could still reduce some LOC. =20
> >=20
> > Yes, if it is merged already, happy to make use of it here.
It is in my tree, but I'd rather maintain some separation between
patch sets (incase I need to pull it out again for some reason).
Given the saving here is minor, we can just follow up with a patch
making the conversion after both are in place.

> >  =20
> > >  =20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D ad7944_single_conversion(adc, chan, val);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 iio_device_release_direct_mode(indio_dev);

