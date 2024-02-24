Return-Path: <linux-kernel+bounces-79827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B535C86273E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75A51C21662
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C604F4CDE7;
	Sat, 24 Feb 2024 20:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkejUbsj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5302907;
	Sat, 24 Feb 2024 20:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708805192; cv=none; b=CCgCKI7hfArDFL/FRuINY7GDECDOH2Kv+Y+LnOyQR24gzacuc1IIdkZhBHhAeFdEg1XI4TyDzw8Sy5wKouXqSFUD/atordFu5p69mIH+Q3afEVTeccwZZ2RE0igF4Nub10j93R9ogpcdbE+vqAd9sXn9Gc5NR4je1IXluWqm3HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708805192; c=relaxed/simple;
	bh=4puK0De6XWcEEa6zuGMHGuAYnNyMd0c5eVc6rbiv46Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+AiT7DYTN+UC5tYjnDWRtwthEiH/pGIvHye2jQjlS3N9Wob0pdWwY9COhdqoBQr90fX4zr/HLF0Z45TDOJsjRSf6dbMxhUfPq+t+dUurVfjBeQUSYfDGeBgDNNgHMe63YOr8mAEjz09cRTriKYVtSzIcqplP1LoVNLaY4Ene9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkejUbsj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B51BC433C7;
	Sat, 24 Feb 2024 20:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708805191;
	bh=4puK0De6XWcEEa6zuGMHGuAYnNyMd0c5eVc6rbiv46Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TkejUbsjQ0HMil2N7Xb9fFYxL4s5QXUrT9Uusg2Uvxc2FYOM0tAVE3M11JyHWw/7E
	 fYAUk3NzXzYjsq3of8XKqh+b+0+Fkll6ZeD5Q1cirG9Dkv0CHPHZrYgj0WQK+9gQZK
	 A1VPBfIjpYhCLhgpGa/vHKSMiFS0NKGhlC3irWYdmwPck4AceZXDlbRquv5/b5sVhg
	 7HXZTfEqNyESSAoYxwdyOHiqs+pxqFhwKJXr0dAIF9daZb6PAXHxiVpQsradIYLkr9
	 3ADHtNrcVfrq/RLv7fCuinURuWMQRjyutoBabM6gUU/dV1kvr4hdWSgZEvwwe3XA0N
	 /nSV6GtXJD49w==
Date: Sat, 24 Feb 2024 20:06:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 22/39] dt-bindings: clk: at91: add sam9x7 clock
 controller
Message-ID: <20240224-fragile-unwed-f1e69bbcbaed@spud>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172741.672694-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="08K8WuCJjwZ2Dt+C"
Content-Disposition: inline
In-Reply-To: <20240223172741.672694-1-varshini.rajendran@microchip.com>


--08K8WuCJjwZ2Dt+C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 10:57:41PM +0530, Varshini Rajendran wrote:
> Add bindings for SAM9X7's pmc.
>=20
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--08K8WuCJjwZ2Dt+C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdpMQgAKCRB4tDGHoIJi
0sOYAPwJwBXEIQ5PHPUQbIROCI93F1KOx91fogdH+/0eLF29bwEArakcTRztZuJr
h9mQ5H70ST/gzqOIGy4XIal57rqTdgo=
=2T/O
-----END PGP SIGNATURE-----

--08K8WuCJjwZ2Dt+C--

