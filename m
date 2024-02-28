Return-Path: <linux-kernel+bounces-84932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FD486ADDB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217D9293BD0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FE2137C38;
	Wed, 28 Feb 2024 11:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toBiZAO1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7087D135A65;
	Wed, 28 Feb 2024 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120254; cv=none; b=i2HpnDyzPuJJQiuHvIb6sn1KqsEeGmJVwB2n+F1owR0yDCTanD8nFnyvJJE173KiSAYbp/gq/5xo9BixHbsaEeXSTR9ypK7IRuzzHdn1NmdxtBq8yaZX6BQ6SRffwCk0+MA8jPNP+JQjLEhmxZhKah/pP5Z3ZexKyjEpRlknrXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120254; c=relaxed/simple;
	bh=Tvp+p5Xk3fozdO2g75WRBimh75zt30LHNGCj/0SSdbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=su8JHHfAWQ/tLfMzGOgVI6+TnaAnbM80NvEtrY3W3nPZWcLbs58TjlVhqQ9A11OFzPpMJudaXF1N8c1q+qSxOvaCKm0g8r/MdrtRWDiu4mUaI4cdU/1gjM3PgN9PQlAXwwqGKLu8o56lLl2AodpGJfM4W9x2FQhNO68l3uPCwKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toBiZAO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09EBC433F1;
	Wed, 28 Feb 2024 11:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709120253;
	bh=Tvp+p5Xk3fozdO2g75WRBimh75zt30LHNGCj/0SSdbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=toBiZAO1mdqQnmskk4C+PYBSfjXMIfnVrtT2NTtUjHhEeSQvE+Av5vHpg8HXTO36o
	 dJiawL2eo+Gm/tiOMru6MS7M0a2UnN2v3i1s5Zg6pAbfBjaPzMHXlIh1CYlr/4Z/4M
	 bi7VrXlnTSyMHU7EegxNhoxcZX6CkovTsPrNGjyJJGh0MG5zq7a68pgGRZvYJ6ZNuS
	 FeKhIQdiGtIqHjVYM3uPmjSvGVyzY+Nss1yer9rOTyfiyedkd+1uyNHIzAZao6WSB4
	 WLXajK0dwvBFDYR2XNY6MgiSSVd+O91TzVnlMeh3SlkYN2bNOrMFwXFp0k2PoYAGsT
	 RUSED7kUYVlmA==
Date: Wed, 28 Feb 2024 11:37:27 +0000
From: Conor Dooley <conor@kernel.org>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com, maxime.chevallier@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: Re: [PATCH v2 1/6] dt-bindings: net: Add bindings for PHY DP83640
Message-ID: <20240228-maroon-wrinkle-1f0d2aa7c186@spud>
References: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
 <20240227093945.21525-2-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XgYe8bqBfCjZqdEt"
Content-Disposition: inline
In-Reply-To: <20240227093945.21525-2-bastien.curutchet@bootlin.com>


--XgYe8bqBfCjZqdEt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:39:40AM +0100, Bastien Curutchet wrote:
> The DP83640 is a PTP PHY. Some of his features can be enabled by
> hardware straps. There is not binding yet.
>=20
> Add a device tree binding to be able to override the hardware strap
> configuration when needed.
>=20
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--XgYe8bqBfCjZqdEt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd8a9wAKCRB4tDGHoIJi
0hbmAQCKk+K3MdOEb8IqasR55iD/+VrgCTPjSqIMqvkGdC8X7wEA4Yf9lr7hn2u/
lhgbMZwQ4tJDtbpTSFyODKxmlorwAwk=
=zfhz
-----END PGP SIGNATURE-----

--XgYe8bqBfCjZqdEt--

