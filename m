Return-Path: <linux-kernel+bounces-57248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4687484D5A4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F981F22290
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CF46A8CD;
	Wed,  7 Feb 2024 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kf2P8NAQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142926A8B7;
	Wed,  7 Feb 2024 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707343528; cv=none; b=ZmO2LeIIaunikZaJiMZcwBZi/qFXCj8KTvQaATBtOlomCYJMzPbNHCdTsmmjcmnmlMF82LtkzBDhBKNqcGu1LNJebk7EbVbAo+e4qNCjDeHVhvJ30B2HhOw7GgkeObL/cIgSbWiY59TrFGy3TzZxf84Z01tX4dESojNFADYzu5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707343528; c=relaxed/simple;
	bh=/fufBs0cxaACI+in6p1EU3OeZWalH85l/GzQAC10rg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jP8LBj59dZjbRRn9c4sIdp8WxIhmykZsqL73kscn1ZDEC35IAOKc0yB3kXRviW3wqkCquBvpgBSPcLmZTKIEbJwWELXjERLQoWO1USGegG3QkGUVJXrwCy2g4pVHAoVmYodZd/0vENTumbIvTlX5qMWyrVHcNaqvqbu3lZl1yTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kf2P8NAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E0BC433C7;
	Wed,  7 Feb 2024 22:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707343527;
	bh=/fufBs0cxaACI+in6p1EU3OeZWalH85l/GzQAC10rg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kf2P8NAQtFMCmN/OMChtave11i1C12HgsAQkDWp62k6xDDwOQaocqSTxzude1Pcww
	 MwxUvJG+kzWSObMlkIXYc2D7+hLPfnEazuw3Mf2oCCsgUuHQ24tUTb0X4MQ72HwpCL
	 0BHAI+F2S3V3NRGDh81F6Uvzm93wbHXBToFyM3g7mZOkY4lHDkMAW6pKE9SnX5rF5C
	 +rO/VNxTJk9cYVgo1RavxQ5zS+PMX8yqMm5Ks2dKqDIx95Ry3RzWQmzcDpjy6c66h/
	 kd1Tml2Zr8XTcZJ2A2dmrN2GvWvLG4bHZ4BBUwL2HKi/rEP/Og7aMXEGinIibaTIhL
	 FuUyw6lvdtrsA==
Date: Wed, 7 Feb 2024 22:05:23 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 0/2] usb: dwc3: drop 'quirk' suffix at
 snps,host-vbus-glitches-quirk
Message-ID: <20240207-settling-drone-90e6f10a3476@spud>
References: <20240207-vbus-glitch-v1-0-7be87099461d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5xzrMLJAtbAM95GZ"
Content-Disposition: inline
In-Reply-To: <20240207-vbus-glitch-v1-0-7be87099461d@nxp.com>


--5xzrMLJAtbAM95GZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 05:00:17PM -0500, Frank Li wrote:
> Since dt maintainer give comments at old thread
> https://lore.kernel.org/linux-usb/20240119213130.3147517-1-Frank.Li@nxp.c=
om/
>=20
> The patch v4 already merged.
> https://lore.kernel.org/linux-usb/20240124152525.3910311-1-Frank.Li@nxp.c=
om/
>=20
> So submit new patch to rename snps,host-vbus-glitches-quirk to
> snps,host-vbus-glitches to align dt maintainer's comments.

I thought the last comment left on the v1 was Thinh agreeing that a
DT property was not needed here and we should be able to apply this
conditionally?

--5xzrMLJAtbAM95GZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcP+ogAKCRB4tDGHoIJi
0sFVAP9YrkK/BR+/aCh7++XlXU9huYVEV3cz9N1Xn7A8y0K7aQEA79UrC0cmqImy
5QfrMU6j/MyXeNmTNjN4DvDy4xOHVgE=
=29T3
-----END PGP SIGNATURE-----

--5xzrMLJAtbAM95GZ--

