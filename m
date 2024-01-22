Return-Path: <linux-kernel+bounces-33830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E728836F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95B128C4DF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2754B5A0;
	Mon, 22 Jan 2024 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8QhUiIs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BBA3FB36;
	Mon, 22 Jan 2024 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944930; cv=none; b=oN/0Dyu+SJtg+3bq4/7ROEfOOTkuDj+MKA4JPkiA6PtkGTyXiZdMzaDv0/fdtYmvQV6omWuDF5phujBPRqdzeB4ph8WtJBQUbqGqqMRX0phaACeNGrNzricar7oHZb4s8GQtdzX1paJgcP9fIDbCC/A7davcti+jfGpVDIeQn28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944930; c=relaxed/simple;
	bh=XfQM0Oq8bhchKaV3+vsc5joKpUAvSeJRZhoVmelAvR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1G1IH0K2dQtPKxeyXus5Fq+/G6TTeiAR27/BDrk/VnkHn2gW869Tis+WE/JdctKq6GwSTYG5NZaIzkKbSKAANbXH9RQtE9To8jCZWKW0kSkJvsIUcyg4zEcw5QxIDmcweIul06Oa5wDZzVoRjwbnrdrNyTygmxx55GCZ/rZvb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8QhUiIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A599EC433F1;
	Mon, 22 Jan 2024 17:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705944930;
	bh=XfQM0Oq8bhchKaV3+vsc5joKpUAvSeJRZhoVmelAvR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8QhUiIsbnGzfIxc6KFXpmIaDt3BUwNKWwmu0bYNI4ZHXrIN9FdllQuxQDUOpLkUO
	 Lh/1oHxgfXg3Vs6ej9AxQwA5Bf1FqP3rg4zPq7Alk9NpK2WvnwGqB7P2nNgwBp3Cuu
	 5wMpQQe5uJZGgM1kUtuvRJAxEOlcOFGBwWQqC2EpCQWpjUPwJKvkCfK2gnL+sIZxzR
	 fRZdcuEIoWHeGZ9NW8qNtH/ubZIgFetySsKWr0AgSpOzFicCeKhyJuTYIFIyO6qGHE
	 3+95CO3njR9+Zhy/bTD/gWvWwgPcwpeL+aj4THbNA/UbgkmlU/rTQd5HB1Y+EVZkE3
	 dDcfXYQuVaaRg==
Date: Mon, 22 Jan 2024 17:35:24 +0000
From: Conor Dooley <conor@kernel.org>
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Crt Mori <cmo@melexis.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: frequency: add admfm2000
Message-ID: <20240122-postbox-slimy-248a2e521896@spud>
References: <20240122090228.28363-1-kimseer.paller@analog.com>
 <20240122-legible-fossil-25349ef9ad6c@spud>
 <PH0PR03MB7141A46C8DD0041775CD0E96F9752@PH0PR03MB7141.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MCbfwdcDBzV4nvA+"
Content-Disposition: inline
In-Reply-To: <PH0PR03MB7141A46C8DD0041775CD0E96F9752@PH0PR03MB7141.namprd03.prod.outlook.com>


--MCbfwdcDBzV4nvA+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 11:06:08AM +0000, Paller, Kim Seer wrote:
> > > +      adi,mixer-mode:
> > > +        description:
> > > +          Enable mixer mode.
> > > +        type: boolean
> > > +
> > > +      switch-gpios:
> > > +        description: |
> > > +          GPIOs to select the RF path for the channel.
> > > +          SW-CH1   CTRL-A   CTRL-B
> > > +          SW-CH2   CTRL-A   CTRL-B    CH1 Status        CH2 Status
> > > +                   1        0         Direct IF mode    Mixer mode
> > > +                   0        1         Mixer mode        Direct IF mo=
de
> >=20
> > I cannot make sense of this table you have here, the double header row =
you
> > have going on is hard to follow. There's also no mention here of what h=
appens
> > when both GPIOs are 0 or both GPIO are 1. Are these configurations perm=
itted?
>=20
> I also feel that it's quite hard to understand without the gridlines. In =
the preliminary
> datasheet, it's a switch control table, and I'm trying to replicate the w=
ay it is presented.
>=20
> On the table, each channel has control pins (CTRL-A and CTRL-B). For a mi=
xer mode
> configuration on channel 1, CTRL-A GPIO should be 0, and CTRL-B GPIO shou=
ld be 1.
> It's not permitted when both GPIOs are 0 or both GPIOs are 1. The state f=
or the GPIO
> should strictly follow the truth table.
>=20
> I'm considering making it much easier to understand by creating two separ=
ate tables for
> each channel, just like the example below. Or is it preferred if it could=
 be discussed in=20
> a sort of paragraph form?
>=20
> SW-CH1   CTRL-A   CTRL-B    CH1 Status            CH2 Status
> 	   1              0              Direct IF mode     Mixer
>=20
> SW-CH2   CTRL-A   CTRL-B    CH1 Status            CH2 Status
>           	    0            1               Direct IF mode     Mixer

I think it would be sufficient to cut down the original table to
something like:
 CTRL-A   CTRL-B    CH1 Status        CH2 Status
 1        0         Direct IF mode    Mixer mode
 0        1         Mixer mode        Direct IF mode

And state that the configurations where A =3D=3D B are not permitted.

--MCbfwdcDBzV4nvA+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa6nXAAKCRB4tDGHoIJi
0gftAP40Y10Z/PEZG3hrDgMfGcEP2C/NdkdxryZWr/keJTMJ6gEAhZHQWc5ETow6
nk4YRriQIquAgLUZulArlOI5DOOyWw4=
=ZKhg
-----END PGP SIGNATURE-----

--MCbfwdcDBzV4nvA+--

