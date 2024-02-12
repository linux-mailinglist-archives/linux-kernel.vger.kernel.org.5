Return-Path: <linux-kernel+bounces-62083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31125851B23
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643EF1C22660
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8793DB9B;
	Mon, 12 Feb 2024 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjSpG3uA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBA53D56E;
	Mon, 12 Feb 2024 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758352; cv=none; b=OXaxrGRP0n0MWFsJz2GMCX8eQgaVLQ42occE6WXm9+TXHsYwLWLyfwvCZySnwp1OOSa5YpynqniIsW0Yua8uI6BQIds9B3NhlpiMmEYeuT2VbIFRghCmEyb61PCPtn9/1GadsdeVhKqTa64jJsmGitCOZUt4i7euR+3j+hHXnm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758352; c=relaxed/simple;
	bh=no2/NzxWWuHICc6wckxr+ESPrBfhnTVeMBX9zwKQ47Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MI9pcbQJFc6zcA0dai57I6uU6ycl2309AYYJaL1fzPOA9Vg0gnyvHgBcV0VBfH/eZlw9f0jehk3hu0NBXnZejas92FOzBnsrjaH1CYJ54NUUpOUThvS0BH4H646VcLVvQ+HhIxVSvunyMY+Mk+Q6COtKVdz9Z3AlTO0xuCuebu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjSpG3uA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DBFC433C7;
	Mon, 12 Feb 2024 17:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707758351;
	bh=no2/NzxWWuHICc6wckxr+ESPrBfhnTVeMBX9zwKQ47Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fjSpG3uAoqBmFhPZb5Vy7vbtQ5bZuCXvr472iN5qyabQCi8CbqztWaZucLZ+hi4K/
	 x6Ns+n1Dj9JFAXcLRTwUxC9wGztQ2hJLYyJUWMWSjlCBvJlP6JU5sdVnbF4gsLpKSo
	 aJ+DVrd93wi0i3pOv3cqakuxpfuscwxcfwNsRSlkKVvuTabjVBD7zHauxCbo7n4dcu
	 wc3sUIRV3wo23rpFKgh9piDNt8tcOo8rWHT2DtW02TjQ/Xx8FiU6sRiNMlovCUP7DZ
	 YAFTfZRAtHCYxQ2aQ7NU8AbvxvyeR77HzTAIPmMWKxPqGxRqYL4oPBwQpFyc3TjrVz
	 sfIUVd+bZqOZg==
Date: Mon, 12 Feb 2024 17:19:06 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 0/2] usb: dwc3: drop 'snps,host-vbus-glitches-quirk'
Message-ID: <20240212-removed-ecard-3ea529f8fd67@spud>
References: <20240212-vbus-glitch-v2-0-d71b73a82de1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DMeqOs24phb1cRj3"
Content-Disposition: inline
In-Reply-To: <20240212-vbus-glitch-v2-0-d71b73a82de1@nxp.com>


--DMeqOs24phb1cRj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 11:19:06AM -0500, Frank Li wrote:
> Since dt maintainer give comments at old thread
> https://lore.kernel.org/linux-usb/20240119213130.3147517-1-Frank.Li@nxp.c=
om/
>=20
> The patch v4 already merged.
> https://lore.kernel.org/linux-usb/20240124152525.3910311-1-Frank.Li@nxp.c=
om/
>=20
> In thread "dwc3: drop 'quirk' suffix at snps,host-vbus-glitches-quirk"
> https://lore.kernel.org/imx/ZcVr05vAYsObrrRR@lizhi-Precision-Tower-5810/T=
/#t
>=20
> DT maintainer and DWC maintainer think it is better to apply workaround
> unconditionaly.=20
>=20
> Drop 'snps,host-vbus-glitches-quirk' and apply workaround unconditional.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v2:
> - Drop 'snps,host-vbus-glitches-quirk' and apply workaround unconditional=
=2E=20

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--DMeqOs24phb1cRj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcpTCgAKCRB4tDGHoIJi
0rY0AP9DLd2fuLnE1WJVdYXWzXD20luOJuu0+RrjCoEp2Xhn7AD/WLcZsvbA1PNs
DcZfUzPkWR4nEhXK1rExTlBN/OPvjwA=
=KALA
-----END PGP SIGNATURE-----

--DMeqOs24phb1cRj3--

