Return-Path: <linux-kernel+bounces-108731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EED880F4C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93BD41C21D74
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92AC3C460;
	Wed, 20 Mar 2024 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="cxAuwV6B"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97913BBE7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929224; cv=none; b=mjQocO8oR2Hct8b6f6kCtKZ7KZMYLfBklDwXqP/2By1Txodjnhvexgn6ebbD7cskIF4avdpnB6cKald4ktCUPON7fl50jA/sZxZefp49Xpg1euNRV391QoH5vbL3neFt9ceUAYVIUgvD5mF7KpcqnAGQzTvtlaTNjJb6wxZuriI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929224; c=relaxed/simple;
	bh=8j6Nh4g7pdDIBz086z/2FkNCN/zIx4mqsZTpE9aItDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBFBAvBPp5y9Wrq0hnG4+zBoC+VHXfLtCxYaLhHAkvJtmW7SOLvak9avk87hVj1xbynEUOvVgT2riPS5TkPCtogQG6lnrz0CPsP7nWLKR1M3InVqvdbbs/PX6VaJjpDXmhzcVs3ZbQjXNxTn81L+iIquHkJGZvuFSCjWzsaMbfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=cxAuwV6B; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=8j6N
	h4g7pdDIBz086z/2FkNCN/zIx4mqsZTpE9aItDk=; b=cxAuwV6BbACjhN/8iu4C
	9ALL4xWjsG+r3J0kwR/2VIzWFmwAn4dM/C10Rrm+w+ckYOP2VmY17uviW8NyyVLd
	JIOT9Zy1Y6quLWEFWWDF/utnhrI89X9aWJusQ4vcKQC8aQAiqw1xVCuP+6IhUMGP
	XwsFnAQPMFuiuo1X1WnL3bOrWeCYKuBux50Jl39eaRVimhK/HMGv4lQww4lMqK6z
	BfFSVHl9DyJSPNWSJW/QkyJvMS4fCQDbJtFLhUe2pKOTAw5+PYipUltR8BuQWT6Z
	6ohuafflYfccyP0/+HhMuJ28vUo2yMyJstAGnxzwj3IGL7wf8G2DYaJ1iedsf1Lc
	tw==
Received: (qmail 3168159 invoked from network); 20 Mar 2024 11:06:58 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Mar 2024 11:06:58 +0100
X-UD-Smtp-Session: l3s3148p1@23FNwBQU2rRehhYE
Date: Wed, 20 Mar 2024 11:06:58 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Chris Brandt <chris.brandt@renesas.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 4/4] i2c: riic: Add support for R9A09G057 SoC
Message-ID: <Zfq1QnvnDSC-dNqN@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Chris Brandt <chris.brandt@renesas.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240319132503.80628-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240319132503.80628-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZK1KxQDIhEaW+sSl"
Content-Disposition: inline
In-Reply-To: <20240319132503.80628-5-prabhakar.mahadev-lad.rj@bp.renesas.com>


--ZK1KxQDIhEaW+sSl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 01:25:03PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Extend the RIIC driver to support the RZ/V2H(P) ("R9A09G057") SoC. It
> accomplishes this by appending the compatible string list and passing
> the RZ/V2H-specific OF data.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--ZK1KxQDIhEaW+sSl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmX6tUIACgkQFA3kzBSg
KbZxqBAAovXefEUa41PTmZtGk+KcS1qeyf1ckCAnwtRk5PjBelWFuMyRF1L81Hm5
OGAMcq4BXG/MT2ZVbC3x2jdsMgNsalFvTEsy65RKsKMUhi9iRNQhmPHlj4aFStsG
V2n2BtoGfneLXuFfldqjR6e3pkMVddYG9WXeKGg+jwovxWwu4rOGtFxvhgXlkmqH
M1sXipwx8lPzGcVZtSfZPgt9g8fXDD9IJRFkmU/0/rgVzAoEsqnsgS1Bs93KNdcc
0IW55APInnMRwltTNEJ3ek7lj7mgSqIR4ZDAgoL0IFjuc42YrUoXf3VPNOSw9503
RCxgFDfNTQcTk6uHqJ+OpiwRkZPTSXxSny9BjZhK+j5P6uh43Uokgtzlw/P6yKyH
oc35P1giZ7sOisndpTr8MubVkQZhYQ3fLzmeuV8HMyaSR/GPBtHjy0TJ0R7fEeWl
9S7a2Y6bvDzUtaaK0csT8rS2kRqMOHgchfseXZyG7sF/Xauku2PJjoteSHFU47tZ
Fu9HoJmCLJVfdfsH5DV5+XOZlzN/zWCdp2dXPQrxsQY5Nh4c2qZcHYJ0Sse7z+VJ
c6L7MkRujb9kL/faV3vQU5jQ4ol0unqKfime+7N1ZD57AOKgLsgy7Oy/4+GSX3sB
N7XsP0KbG2tBX+kJFIV0mYJ13HZdplO6iBvRFetU1iKWyF9H3ZU=
=mvW9
-----END PGP SIGNATURE-----

--ZK1KxQDIhEaW+sSl--

