Return-Path: <linux-kernel+bounces-161161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A733D8B47D4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 22:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C8B282354
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 20:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC06145B00;
	Sat, 27 Apr 2024 20:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkYNMRet"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1916F23A6;
	Sat, 27 Apr 2024 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714249351; cv=none; b=ZQmgCDcQAUR9V/EdUurtOd9XOyGIfS+DIbeTQY5+4qZBx6hubm7NG5IOnm4I+xn12uFAOiUdx1Vppv1sjnMPZgeV6S8NZOS3C2NTqmij4vFONSydpoWKT8iK7GF8eMwqZOuWkJuJ8mkx5tjeo+jYbQEfQiVT76tWy9fEUbWckj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714249351; c=relaxed/simple;
	bh=LDjuDNnpc9lFvXeRQ8z4w2g/YhjMM5pK9irt+42ZJIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSxOh9nSWzs6rKFT05RpRNp2YQQV7jeSUniZI80F8Ody/squPbs2O57hr6tzdWEPf75TB5LT5HVy/EPGUNu20HkNEoDgptzHDiQ4rPX/7gOHykWeDLRNbItDjVMNkMlYXWX1LaLn4G5LBQhjBoBGz3IIkl7uDpORxbIkcfvV6ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkYNMRet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B935C113CE;
	Sat, 27 Apr 2024 20:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714249350;
	bh=LDjuDNnpc9lFvXeRQ8z4w2g/YhjMM5pK9irt+42ZJIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PkYNMRetqWM78vJ7xyZc5gRS9Cpqww62DSeZjJFWgUlflt8ECQcXP2AMRCdm2ZaGy
	 OeTObP6A6pSQUUBrG1cJyfwvhTXL7AA2xcmIGfQFH7ZvXN4bgl52EJanexmHcFCDnh
	 CW8uqah6piwWYMraHUK0JhTeVBo8Ge6euLLsHzZhYc8uug0l4/Jg+qH6xB3bv69HZt
	 71JcZkDla0vAeAx7dJA29I2TCif7+fRH1OVf+y/tDi/A3gtTxD3gbda0Y73C9HyF2A
	 kABY+0OodVVW+z07IE/Vcpoh7BCzoW0w9AbdwMo/+7EHpwIPU1TNj5pl4ZpQN59Y1/
	 0eMbrJ3atrcTQ==
Date: Sat, 27 Apr 2024 21:22:23 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew@lunn.ch, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Message-ID: <20240427-attention-negate-a3b6ede708d7@spud>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>
 <Zi1PxgANUWh1S0sO@builder>
 <20240427-vaporizer-pencil-be6a25030f08@spud>
 <Zi1cbScrKzFN3PNT@builder>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ht22igVR9zkqfURh"
Content-Disposition: inline
In-Reply-To: <Zi1cbScrKzFN3PNT@builder>


--Ht22igVR9zkqfURh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 10:13:33PM +0200, Ram=F3n Nordin Rodriguez wrote:
> On Sat, Apr 27, 2024 at 08:57:43PM +0100, Conor Dooley wrote:
> > >  static const struct of_device_id lan865x_dt_ids[] =3D {
> > > -       { .compatible =3D "microchip,lan8651", "microchip,lan8650" },
> >=20
> > Huh, that's very strange. I don't see a single instance in the tree of a
> > of_device_id struct like this with two compatibles like this (at least
> > with a search of `rg "\.compatible.*\", \"" drivers/`.
> >=20
> > Given the fallbacks in the binding, only "microchip,lan8650" actually
> > needs to be here.
> >=20
> > > +       { .compatible =3D "microchip,lan865x", "microchip,lan8650" },
> > >         { /* Sentinel */ }
> > >  };
> > >  MODULE_DEVICE_TABLE(of, lan865x_dt_ids);
> > >=20
> > > Along with compatible =3D "microchip,lan865x" in the dts
> >=20
> > Just to be clear, the compatible w/ an x is unacceptable due to the
> > wildcard and the binding should stay as-is. Whatever probing bugs
> > the code has need to be resolved instead :)
> >=20
>=20
> All right, so when I change to
>=20
> @@ -364,7 +364,7 @@ static void lan865x_remove(struct spi_device *spi)
>  }
>=20
>  static const struct of_device_id lan865x_dt_ids[] =3D {
> -       { .compatible =3D "microchip,lan8651", "microchip,lan8650" },
> +       { .compatible =3D "microchip,lan8650" },
>         { /* Sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, lan865x_dt_ids);
>=20
> I still get the output
> [    0.124266] SPI driver lan865x has no spi_device_id for microchip,lan8=
650
> But the driver does probe and I get a network interface.
>=20
> If no one beats me to it I'll single step the probe tomorrow.

I think the error pretty much is what it says it is, the driver doesn't
appear to have a spi_device_id table containing lan8650. The name of
the driver is lan685x which is used in the fallback clause in
__spi_register_driver(), so it complains as it does not find lan8650 in
either. If my understanding is correct, either a spi_device_id table is
required or the driver needs a rename with s/x/0/.

Cheers,
Conor.

--Ht22igVR9zkqfURh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZi1efwAKCRB4tDGHoIJi
0jDsAP0cItUc6sedwNS3eRcU7KmYLY9HiiA9Ch9O5PlNtGXuWQEArfmeqLOOooG1
PK0PZHRsFJKKp9IKbHS+rjwURy4eFgg=
=s9NR
-----END PGP SIGNATURE-----

--Ht22igVR9zkqfURh--

