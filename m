Return-Path: <linux-kernel+bounces-69257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3122785864E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3141F2137B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F392F137C49;
	Fri, 16 Feb 2024 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNoCtXrb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF97138489;
	Fri, 16 Feb 2024 19:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112541; cv=none; b=I1pH3pkTjYPahto6fZP5nd0/yO8tckpmljIbLB43dCXGBT8N3BXMJOg3NI2SuL0Cjdxb1B3E1z5XQ2Dash79LINAsZrWV2T4SPv3MPEUN5W9FWfDMzQ5YHjlGajSstQV6yXszRU4B2s5jJVLFGB+YGPSpzZiZLiaWAH66K2czLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112541; c=relaxed/simple;
	bh=G09Rd+AEH/jNWLGWYJVBilG2MQtrUYmZgLruk1MG4eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXokfi/6OGhqQsvyavGZ1uXxVd+aidLNQgxAr8xNxnTzIO1RCcp+IP6V9EnRzfm0qKamOrzlCgk2mxZ7P2Yp+yb6ZXQuT7P07C0XM2942YE94i7nc1/snCrTO1WmSxcHg910AO6kRGssTq/vSngUFYzYtX4uux4k4PH73fufUKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNoCtXrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C205C43390;
	Fri, 16 Feb 2024 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708112540;
	bh=G09Rd+AEH/jNWLGWYJVBilG2MQtrUYmZgLruk1MG4eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dNoCtXrbyOz0kqkUfjr00qLi28HEM5dz8epfT1fVP/V+KHmM/mH2OSBBk4dvg1Htl
	 1U9mWyhlysSP+k86YNCNIafKIWZWPaOOEPrbJ0+lqYzpVC0N0lMcY+2E0sLImE0t8y
	 1XVWRogzRP9CNo+9k2OUulIYvvpvdLpxnokzBZcikWiucKZVP+1q+76qpb3gbQtEa/
	 icr2PtV+Bbd8WH/omN37DUmcAQCZzzyNtLXItsUxDPHyumSYSDZ0GskFPZ0vSwWd/U
	 sXPE4owaemI9Eit0JKwnnsiwNHnDFpyUQZyrEzEd4CWdU00y0l8sjUAKKyITkADu4M
	 ETZNygGqTx/vw==
Date: Fri, 16 Feb 2024 19:42:15 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marco Felsch <m.felsch@pengutronix.de>, puranjay12@gmail.com,
	lars@metafoo.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	thomas.haemmerle@leica-geosystems.com
Subject: Re: [RESEND PATCH 1/2] dt-bindings: iio: ti,tmp117: add vcc supply
 binding
Message-ID: <20240216-unlocking-cinnamon-54ab3d755cfd@spud>
References: <20240216102820.1395815-1-m.felsch@pengutronix.de>
 <20240216112120.76a0c0ca@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rHRtSsTE3FTPHipH"
Content-Disposition: inline
In-Reply-To: <20240216112120.76a0c0ca@jic23-huawei>


--rHRtSsTE3FTPHipH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 11:21:20AM +0000, Jonathan Cameron wrote:
> On Fri, 16 Feb 2024 11:28:19 +0100
> Marco Felsch <m.felsch@pengutronix.de> wrote:
>=20
> > From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
> >=20
> > Add the binding to specify the vcc supply. We can't make it required
> > since this would break the backward compatibility.
>=20
> Given convention for supplies like this is to make them required in
> the dt-binding to reflect that providing power is not optional (unlikely
> some other supplies that might not be wired up) and not worry about the
> fact that we happily provide dummy supplies for them if they aren't in a
> particular dts, it should be fine to make it required here.

With the suggested change,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--rHRtSsTE3FTPHipH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc+6lwAKCRB4tDGHoIJi
0vZSAQDKMjsM7WhA8U7jh7O3LcFJDmqmfaumokr0Y7VJyfr1tAEA6C6kBtyI8OZH
LU0pO9RfpBEpn9SjsytOXib6BJAp4Ak=
=GiN4
-----END PGP SIGNATURE-----

--rHRtSsTE3FTPHipH--

