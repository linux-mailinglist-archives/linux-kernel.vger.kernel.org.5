Return-Path: <linux-kernel+bounces-117795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1322988AFA3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E761C36C16
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962771BC23;
	Mon, 25 Mar 2024 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FI8o9x9n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE40818C08;
	Mon, 25 Mar 2024 19:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394215; cv=none; b=Hs9c70/9Old4FjGDRvYg1uNmzt88CKsfC9KQeiRC0nlRYkpS/U20QGU1RZVdnDVej1/jWRF9Yfv1jGFfYjeu/Dp1SM9FhALKXn2HKOQTMW7dRaEboMN694RSi2APn84ciHI1si8/Od3dsPgnUleo2ixHn20Rhfn7qZtOWnbgP/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394215; c=relaxed/simple;
	bh=xQjXWR78w6LFX6c6u9rSvz6lq+JxeI4vUXLcsqqJueo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOayrx05W/SPj0hBiH0Tp7vEDqnXLINW1LBQ8w8O/Pgzw1IBzTHvAIKZ5jotE76AmCNRn15VIbEsyNOsH+IVF/YQfZtXFFpiGaG21jcl3EtWjwZ6c5zE8t5kIAANQlFSSVm171Iasp/gSSWs+bSpfXi5ESixO5+oM8+2z2v9UeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FI8o9x9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7339DC433C7;
	Mon, 25 Mar 2024 19:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711394215;
	bh=xQjXWR78w6LFX6c6u9rSvz6lq+JxeI4vUXLcsqqJueo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FI8o9x9nCSGsHEuYt4a6eVqrgrLtd8pqD5SKquNq05RgsxNX+cMZVqSgjam+3dQT6
	 13nS3odq6JkqLTwkRYfvgb4ITtiwq70LKvYT+amYgB3ewFtuudAUBEBh0WGSXo5r4E
	 5knsSkih7udFBuIgfkilrnmAtxhUdsrove0+TcyPGgRbnXAoyOAYi+YKkd5oSBzr3y
	 r6XBKKC0qufuepLF24PTx11qHEDspQXYKBASWo4V38GVgaUAMRzPgssv+Ko4xQp2CE
	 AEJ6qrb3kemhQELSxjbOR8T2UqIcQic+aMcHrE6Fn9NfaNvLqR2UAzBsxTK/uUuN49
	 xypzMWQpNFhZA==
Date: Mon, 25 Mar 2024 19:16:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	o.rempel@pengutronix.de, dario.binacchi@amarulasolutions.com,
	u.kleine-koenig@pengutronix.de, hdegoede@redhat.com,
	p.puschmann@pironex.com, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	caleb.connolly@linaro.org
Subject: Re: [PATCH 0/2] Input: add ft5426
Message-ID: <20240325-cuddle-vivacious-c0fc010bdd1a@spud>
References: <20240324184415.206587-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oF12n2TDHAfViFUe"
Content-Disposition: inline
In-Reply-To: <20240324184415.206587-1-andreas@kemnade.info>


--oF12n2TDHAfViFUe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 07:44:13PM +0100, Andreas Kemnade wrote:
> Add ft5426 touchscreen controller and the corresponding compatible.
>=20
> Andreas Kemnade (2):
>   dt-bindings: input: touchscreen: edt-ft5x06: Add ft5426
>   Input: edt-ft5x06 - add ft5426

I think something got messed up, I only got the cover and 2/2, no 1/2:
https://lore.kernel.org/all/20240324184415.206587-1-andreas@kemnade.info/

--oF12n2TDHAfViFUe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgHNogAKCRB4tDGHoIJi
0v9PAQDZ/28eIpsPGkkAS3vbjS6u0QFJ8N/Y0dXUis3DoZ1XYgEAxpWKQS/w0gOW
lOGmBkEpv23ksVAZDGoWTdHS4w5W+wM=
=uCyX
-----END PGP SIGNATURE-----

--oF12n2TDHAfViFUe--

