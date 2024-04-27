Return-Path: <linux-kernel+bounces-161154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E3B8B47BC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D751282358
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B499C1428ED;
	Sat, 27 Apr 2024 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrEfZI9q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD5B13AF2;
	Sat, 27 Apr 2024 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714247871; cv=none; b=LqVoLa6Hc/pq+uFSHMWx0LpeU2aHYJZBHzQIRd7nldQ1xknB+7VfzbQPG/dHR7BQ/iH4KYkuLJob8vFMO+iJNiCQFzDJWJEkMXhFwjCKNzPpwpPam8qHtu2q4wu5lcQDMQPKr67V1+YzA1M6yWjXh/4bk0woXJhg+cBNYw0JVw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714247871; c=relaxed/simple;
	bh=piZR/V7gBmjDb0FCJkOygfPzOUBnbSC9+MC1K8f+Oro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pR2bQAL+BAxdPAY7Ya80jDz8Q2yrIdHxMAcd0/0kuLzZu1JOyYNvfvwV9WNw4Ig9JjWEF2MM1DLx/dvlI0qm9NYYq3qvO/yUL8VzPsjvtsht5ErWeaLi2hz0KMChnwAH85JFu+0V9yN6SM9yDNhNrBVRi0GHLmnTNEwcoYObHe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrEfZI9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34864C113CE;
	Sat, 27 Apr 2024 19:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714247870;
	bh=piZR/V7gBmjDb0FCJkOygfPzOUBnbSC9+MC1K8f+Oro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GrEfZI9qE7myQAFFIg/eesizzArEkgx4yGhY/KAkqTp/AWLV+MRUUArkn66MsCjKj
	 1n8Jsm5QNFiqndihwFa8TMBYMiP+fRZhp4vJu6Mfyu0gVs+ckH2OtZdnJFsY1HPXgT
	 cnaElj5s/cTmZDm5kqP8UT61bmCHbR39iwH1G3SuUwttOiuOz8EigkZL+4OJvP53H+
	 jEA7YOD4PXhjkCuy4PYG2dv0xTskpy1wtkG3pzddfYRokBXhcOSmlaEsuoo13M6SC+
	 SmAoPPXJzdAQm029xCzLerWWRBsSRtuXLdgC7fBdGBVsXwEsO+DOzcn5npOx9nHEaO
	 ZA+Itw+yQaadw==
Date: Sat, 27 Apr 2024 20:57:43 +0100
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
Message-ID: <20240427-vaporizer-pencil-be6a25030f08@spud>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>
 <Zi1PxgANUWh1S0sO@builder>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1p94+/8YvCoa5Wnz"
Content-Disposition: inline
In-Reply-To: <Zi1PxgANUWh1S0sO@builder>


--1p94+/8YvCoa5Wnz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 09:19:34PM +0200, Ram=F3n Nordin Rodriguez wrote:
> Hi,
>=20
> For me the mac driver fails to probe with the following log
> [    0.123325] SPI driver lan865x has no spi_device_id for microchip,lan8=
651
>=20
> With this change the driver probes
>=20
> diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/n=
et/ethernet/microchip/lan865x/lan865x.c
> index 9abefa8b9d9f..72a663f14f50 100644
> --- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
> +++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
> @@ -364,7 +364,7 @@ static void lan865x_remove(struct spi_device *spi)
>  }
>=20
>  static const struct of_device_id lan865x_dt_ids[] =3D {
> -       { .compatible =3D "microchip,lan8651", "microchip,lan8650" },

Huh, that's very strange. I don't see a single instance in the tree of a
of_device_id struct like this with two compatibles like this (at least
with a search of `rg "\.compatible.*\", \"" drivers/`.

Given the fallbacks in the binding, only "microchip,lan8650" actually
needs to be here.

> +       { .compatible =3D "microchip,lan865x", "microchip,lan8650" },
>         { /* Sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, lan865x_dt_ids);
>=20
> Along with compatible =3D "microchip,lan865x" in the dts

Just to be clear, the compatible w/ an x is unacceptable due to the
wildcard and the binding should stay as-is. Whatever probing bugs
the code has need to be resolved instead :)

Thanks,
Conor.

--1p94+/8YvCoa5Wnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZi1YtgAKCRB4tDGHoIJi
0tz9AQC+se3qP4Xf+bSZv6Anj1MBfYBu4gBWnoQdzdMtEWnkBgEA99wmPr+F+lEm
pyaHN52IFUeFvWwcIQ0Tb94yB22V4AE=
=XWBf
-----END PGP SIGNATURE-----

--1p94+/8YvCoa5Wnz--

