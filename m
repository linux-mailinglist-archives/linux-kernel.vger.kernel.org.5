Return-Path: <linux-kernel+bounces-58496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3F284E723
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD081F298C3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F389082D71;
	Thu,  8 Feb 2024 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfH6EKrD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BBD7A714;
	Thu,  8 Feb 2024 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414772; cv=none; b=tF2C4qX8EizNwQPIflP3SarCtvJqiK0cgWiJYsRPbhLn8hymd38lSKPbFvSqs6H6WI/19YIVDZhdgKHk6kvkOqU5q1H54f0uTmSdXCUAimkIgK6bZQqnXNytyerxZLR5x4R+6XOMxiHjSxQ5YNQ6wPkKwyVpb0lkx+hiJ3II4OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414772; c=relaxed/simple;
	bh=voK6sna2N/Lnp9vi6/RUIFz4KqvtXd51irAZy8iVR9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzIwaU6BswqulL4UxCTiyfzaTLoaGvakgHhxmuNL8wpHVNxbeu2DJvKPvO6mSvFxhk5T5WliKewT6YudR+9xZVTz+F259a29QAehJYhwqfkbjwsC47tMujex4pwudKilon8aIFP2dAKM3D1g7W/1SeRdppKfgn7/UhdMjtrV3rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfH6EKrD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9FBC433C7;
	Thu,  8 Feb 2024 17:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707414771;
	bh=voK6sna2N/Lnp9vi6/RUIFz4KqvtXd51irAZy8iVR9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nfH6EKrDiBBBUUoqVu3JFgkBSh2ymwkFu/NOWSpW8+PCG49sNGe8ym9D1Hs2oQCIX
	 xNjMg3vdtjpO1npZW8zCbPktQYXzcgQJ8PYtEdEY+N7nkf2egMRotdIRUPnICYj/7h
	 kcpbZs1QixhzGg89xHtCoEQBoYfZWLYKBcIsRYo0CL3ZxpbFhrc3S3ZS1eayDVqS+R
	 OWrUIPY15Gu2HO6n00TZWUYhDS9XSPEFqkEzEJELX6zKNbl9mzhRKKvp8/07aUjPeQ
	 QKxdEJpJTjCW2d1GxjceQADl5LOkw1/51tZrP6dPn2CBj5xuVi+Vp88tgr0Ptc0AXH
	 be05zFFihsJCA==
Date: Thu, 8 Feb 2024 17:52:47 +0000
From: Conor Dooley <conor@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v1 00/15] auxdisplay: linedisp: Clean up and add new
 driver
Message-ID: <20240208-drearily-carwash-60e4ba70a559@spud>
References: <20240208165937.2221193-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O7SgCvLz8KEdP71U"
Content-Disposition: inline
In-Reply-To: <20240208165937.2221193-1-andriy.shevchenko@linux.intel.com>


--O7SgCvLz8KEdP71U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 06:58:43PM +0200, Andy Shevchenko wrote:
> Add a new initial driver for Maxim MAX6958/6959 chips.
> While developing that driver I realised that there is a lot
> of duplication between ht16k33 and a new one. Hence set of
> cleanups and refactorings.
>=20
> Note, the new driver has minimum support of the hardware and
> I have plans to cover more features in the future.
>=20
> Andy Shevchenko (15):
>   auxdisplay: img-ascii-lcd: Make container_of() no-op for struct
>     linedisp
>   auxdisplay: linedisp: Free allocated resources in ->release()
>   auxdisplay: linedisp: Use unique number for id
>   auxdisplay: linedisp: Unshadow error codes in ->store()
>   auxdisplay: linedisp: Add missing header(s)
>   auxdisplay: linedisp: Move exported symbols to a namespace
>   auxdisplay: linedisp: Group line display drivers together
>   auxdisplay: linedisp: Provide struct linedisp_ops for future extension
>   auxdisplay: linedisp: Add support for overriding character mapping
>   auxdisplay: linedisp: Provide a small buffer in the struct linedisp
>   auxdisplay: ht16k33: Move ht16k33_linedisp_ops down
>   auxdisplay: ht16k33: Switch to use line display character mapping
>   auxdisplay: ht16k33: Use buffer from struct linedisp
>   dt-bindings: auxdisplay: Add Maxim MAX6958/6959
>   auxdisplay: Add driver for MAX695x 7-segment LED controllers

Not all of these patches have made their way to the lists FYI:
2024-02-08 16:58 Andy Shevchenko [this message]
2024-02-08 16:58 ` [PATCH v1 01/15] auxdisplay: img-ascii-lcd: Make contain=
er_of() no-op for struct linedisp Andy Shevchenko
2024-02-08 16:58 ` [PATCH v1 02/15] auxdisplay: linedisp: Free allocated re=
sources in ->release() Andy Shevchenko
2024-02-08 16:58 ` [PATCH v1 03/15] auxdisplay: linedisp: Use unique number=
 for id Andy Shevchenko
2024-02-08 16:58 ` [PATCH v1 06/15] auxdisplay: linedisp: Move exported sym=
bols to a namespace Andy Shevchenko
2024-02-08 16:58 ` [PATCH v1 07/15] auxdisplay: linedisp: Group line displa=
y drivers together Andy Shevchenko
2024-02-08 16:58 ` [PATCH v1 08/15] auxdisplay: linedisp: Provide struct li=
nedisp_ops for future extension Andy Shevchenko
2024-02-08 16:58 ` [PATCH v1 09/15] auxdisplay: linedisp: Add support for o=
verriding character mapping Andy Shevchenko
2024-02-08 16:58 ` [PATCH v1 10/15] auxdisplay: linedisp: Provide a small b=
uffer in the struct linedisp Andy Shevchenko
2024-02-08 16:58 ` [PATCH v1 14/15] dt-bindings: auxdisplay: Add Maxim MAX6=
958/6959 Andy Shevchenko
2024-02-08 16:58 ` [PATCH v1 15/15] auxdisplay: Add driver for MAX695x 7-se=
gment LED controllers Andy Shevchenko
https://lore.kernel.org/all/20240208165937.2221193-1-andriy.shevchenko@linu=
x.intel.com/

Cheers,
Conor.

--O7SgCvLz8KEdP71U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcUU7wAKCRB4tDGHoIJi
0gXAAP9bL24AhxzmmQRRnY3Rhu2L6gqn1Hh5TRCMhmZCd7TlngD+NNB8AKdlQ1JH
JxoOIo6rC9vlJ1FBJwpHi6QKypAy2As=
=qyIp
-----END PGP SIGNATURE-----

--O7SgCvLz8KEdP71U--

