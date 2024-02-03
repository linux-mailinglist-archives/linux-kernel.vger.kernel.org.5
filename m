Return-Path: <linux-kernel+bounces-51119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E058486BF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54A61C21039
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9525DF2C;
	Sat,  3 Feb 2024 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJBU77nZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A545F55C;
	Sat,  3 Feb 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706971224; cv=none; b=dMRiCoGZPndT5QDrxLY2unjD/iZ2bErgut8/sDf7uYwL2NIXusZcdZZGzvXtXsHUyrpo7CUoYgsKCI4V7klHnMW94wVAm14wvdQir9jlG3YppXyJnk08qC4x7cMKFftynssL1C7WO6UTZkybUAbVfb1tGIpyG4Gq4SpOmvRCj1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706971224; c=relaxed/simple;
	bh=xIJTVzS/n/XFvKvdBeGCg3VKssfj+QPFUDJK7lYmlKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTuqJF+tqY8aPGKQmeAoK1hlynbNVIiQoJSMIzy6TpKig0X+KQaSuJBuOnPxSzKbzQHUSBFDDnm2V7WcKFPAYJWrwD4STBHcP+Bcf1weey2tumktEs5a54pE0BDzj9zecT1nEtbsLzSuUNeKvBrfDL+J9CjGmtf6DMJ366BBHXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJBU77nZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA8CC433C7;
	Sat,  3 Feb 2024 14:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706971224;
	bh=xIJTVzS/n/XFvKvdBeGCg3VKssfj+QPFUDJK7lYmlKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LJBU77nZWHXaaRbu94s+cXcM13wRLadEKIEj0kmapL4E9fysxnQeS8AEkDHlRlwrm
	 fhM4ikclrTZH4c8tTYMSsJZD0plvSZShss/HWgeoj+DZ+G7Psq+xr9v9jTlZk+cN10
	 BLraLWRTrTceSbFnxAxCO5d6WIvnpTZi1JayaLwCFZvSeY4uTx/N4377jJqbHwTr3i
	 SCt43KtnM01QdjlIXwaM+287SVQX5ktCC0LKJ2T7wfAfgM278OJuqgpwOWfB5Gukat
	 HTM3EQfK2I81YJjUPl7co9/5FhJXllp6xB8fB8Dffa3/a2nuBdgrY0xR19i2VzUQLD
	 JtUyrjcdiIaKw==
Date: Sat, 3 Feb 2024 14:40:19 +0000
From: Conor Dooley <conor@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: sunxi: Add Sipeed Longan Module
 3H and Longan Pi 3H
Message-ID: <20240203-bullfrog-dropout-ce76e339b379@spud>
References: <20240203122502.1259-1-jszhang@kernel.org>
 <20240203122502.1259-2-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OOwGp4su/O+4QrkP"
Content-Disposition: inline
In-Reply-To: <20240203122502.1259-2-jszhang@kernel.org>


--OOwGp4su/O+4QrkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 03, 2024 at 08:25:00PM +0800, Jisheng Zhang wrote:
> Add name & compatible for the Sipeed Longan Module 3H and Longan PI 3H
> board.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--OOwGp4su/O+4QrkP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZb5QUwAKCRB4tDGHoIJi
0pjaAPoDC/P7o8CtrI0Zo2MOdIQ1EprLUP+j0nRYAXBw1JtYfAEAv2QN22X785iW
d3rma/7lycAmZFKI1jkBmBaVgArFUwM=
=N3R8
-----END PGP SIGNATURE-----

--OOwGp4su/O+4QrkP--

