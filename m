Return-Path: <linux-kernel+bounces-135490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB1489C69D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB82D28447E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C49385654;
	Mon,  8 Apr 2024 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXqWGpHB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3D585923;
	Mon,  8 Apr 2024 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585675; cv=none; b=Pdg/kzhfjxgWQWhZaezHkjRXOWmZszRmT2MM1uqqvNHILch0qnq/nJ9eWetOaKcFbMr94HN0uOMC6ZqvcFBt29jxCL1gVPikTvdOyooYv523HrYFOyJa5OaTvb12vcRAqOOYEAqW4oml2hDv7bqkiiJyKyyQIQWi99oTe0fiYhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585675; c=relaxed/simple;
	bh=wzSiWPtqXyFgGmWUA/jTJid5eNPrZSQwVZnt2S6fuK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IG3HsR15eHMMpqIzDxjG6SUacgnObsYEO2KMri427t70mrZcOZwN9Vqh1aDdU7NPAt4jVnkQfxfHOB9ov+R4hkh51NGbPnr9tfGtC5dUC9NoLhOHF7RE1hbpASCGyuRlStZKq9heUwKYLkmLEdn5ki9qyVHpr8JyVgIsks0mRQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXqWGpHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9D9C433F1;
	Mon,  8 Apr 2024 14:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712585675;
	bh=wzSiWPtqXyFgGmWUA/jTJid5eNPrZSQwVZnt2S6fuK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXqWGpHB9XBoUwEwRDEfq60lBAG1g6HMqGMHqVv+3el8gZ+MjckDS281OyorIrFmr
	 3+8YmXbtSeS97OHRl2AODfML/G1fNw9+0bV96DJU/bLzcLcJoPDYUbFzzoNvpNlLuM
	 D0kjv9w5v0nnXsOM2+6kHcxG3KJ6zEEyhPlXNnyf0p3ByIb7+WXe9C+97+vFTO4zIn
	 ZUHiaFHgaYLEvdyj/lhseGgHpcH0ALlYQTayx/xI/BPLCsjf72qIZ4usplny9j6yfZ
	 Kyb/U64jIb1WVgWyJTY8SxpwEByQraEClQd3Xe2OuWilju5+bgo+u+YxVwYvpLnF6f
	 kxX6AXMfiZUDA==
Date: Mon, 8 Apr 2024 15:14:29 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vaishnav Achath <vaishnav.a@ti.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v2 02/11] spi: dt-bindings: cdns,qspi-nor: sort
 compatibles alphabetically
Message-ID: <37d89b59-d94e-47aa-8841-f2758b8e18b2@sirena.org.uk>
References: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
 <20240405-cdns-qspi-mbly-v2-2-956679866d6d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I1H6M8trMyV6zMZV"
Content-Disposition: inline
In-Reply-To: <20240405-cdns-qspi-mbly-v2-2-956679866d6d@bootlin.com>
X-Cookie: Drive defensively.  Buy a tank.


--I1H6M8trMyV6zMZV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 05:02:12PM +0200, Th=E9o Lebrun wrote:
> Compatibles are ordered by date of addition.
> Switch to (deterministic) alphabetical ordering.
>=20
> Signed-off-by: Th=E9o Lebrun <theo.lebrun@bootlin.com>
> ---
>  Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/D=
ocumentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> index 5509c126b1cf..e53d443c6f93 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> @@ -79,13 +79,13 @@ properties:
>        - items:
>            - enum:
>                - amd,pensando-elba-qspi
> -              - mobileye,eyeq5-ospi
> -              - ti,k2g-qspi
> -              - ti,am654-ospi
>                - intel,lgm-qspi
> -              - xlnx,versal-ospi-1.0
>                - intel,socfpga-qspi
> +              - mobileye,eyeq5-ospi
>                - starfive,jh7110-qspi
> +              - ti,am654-ospi
> +              - ti,k2g-qspi
> +              - xlnx,versal-ospi-1.0

In general it's better to sort trivial cleanup patches like this before
new functionality in order to avoid spurious dependencies.

--I1H6M8trMyV6zMZV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYT+8QACgkQJNaLcl1U
h9DkMwf+NlFSC2qFWAWFFvL1A3RX6Bk2S1kNzmDmdTZQpnbR/QViiS7MW+PFmctk
BXIPuKqXUT7G8iZTuIqVoD58e3aqiQMYTBz4lrFwtELkutB/p6fELMpyQiydY9RC
52J1VwmlrHGdPjxCFTKjyxgs+MRureArQJFTvpZ1Pgs8QsfV0MvpVy/sKAVARrsb
TMWybUZH2H0dAli99lS/Z+QeyYCMBwyJQ6N4E0hdcY8R2jwhTeClrje9rww3CTLO
1qxTdotfMg/JGbZ5kSTWkwdSSMEdAsMGpyJGnWXxhtSZhowGnStTBvSTmA24xq3Z
hB9KTFo+G8G7No/ZDXbuhRYAsI0YBg==
=luZ8
-----END PGP SIGNATURE-----

--I1H6M8trMyV6zMZV--

