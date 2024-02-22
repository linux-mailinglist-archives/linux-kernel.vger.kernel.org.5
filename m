Return-Path: <linux-kernel+bounces-77196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00BF86020F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B0A8B2D5A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870766AFAB;
	Thu, 22 Feb 2024 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONjU6pu9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC3114B80D;
	Thu, 22 Feb 2024 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627618; cv=none; b=vBI6qywTitGE1lQHpl4F14V5I/6rZYMgkWe2SXdV/4hNZR8AZIrTuCs4tOd+LcVHrCXD7im+Jjq51cXDVpHnKjdRtQuAcbKxg8bCBZoaQdVlrNxjTKvTUULQIU/GsLohzdWQsCn9jcUqoHRd4eIgHR2y1K+b/hQqqbO6RKguF5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627618; c=relaxed/simple;
	bh=feIATsbqV4hw//7gEgLmpkWOiU51YdIAqVTSU+1CWss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ct64Bk+hvrB99IRPqLxhL0ddmJ+ieb1jt9wIRgmT5GVD1sHKoonASoX4lks2BCEPPlUpZVf39wwt1WeQFcKY+4ArfXa+DOTHsF+FI85NTcgi/jVRxTP/qpcZvA8ST8/9dW/eu7jo/rflFMM1GUCxWC38wGl+hV0pxHZUKTebc0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONjU6pu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A89C433C7;
	Thu, 22 Feb 2024 18:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708627618;
	bh=feIATsbqV4hw//7gEgLmpkWOiU51YdIAqVTSU+1CWss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ONjU6pu9PQFbua/6XAPI7F0Z22TV+gQqfg1mm1nbggvGcU16zjpSo4y5hExoFmSuh
	 yH3Sj8H8gMY4w3+7PI0j1G4Gr0ofkZZUKepsizr1C6SGvQWCoz7KQtn1wcL8+kTd1W
	 nOWsMf5fDpjvzXsb08ZjEbGYmSMVlS/H8NRzfNXMl/ww9OoNJ9J5qYEMz7mFAH3DtL
	 vROiJ6JQz4AG6gW0OIOX8J1MD+BCzqKcyILFmxMh8R1FTiFzAeuVHIX6bUN4lB1vDI
	 EYbLfGZr8oMUEZU+epEOi1Bc4APnUXzrHVRCdwiqmxQD9fHOEkZcVOxQnZP6QYazYr
	 YEiAmuVRj+81A==
Date: Thu, 22 Feb 2024 18:46:53 +0000
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 0/4] Add support for jack detection to codec present in
 A64 SoC
Message-ID: <e9f22300-d303-4ca2-84ca-47f7130a0dc1@sirena.org.uk>
References: <20240222181851.3398254-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8lkflKrUIKRf2OBT"
Content-Disposition: inline
In-Reply-To: <20240222181851.3398254-1-megi@xff.cz>
X-Cookie: I have accepted Provolone into my life!


--8lkflKrUIKRf2OBT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 07:18:43PM +0100, Ond=C5=99ej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
>=20
> This series adds support for jack detection to this codec. I used
> and tested this on Pinephone. It works quite nicely. I tested it
> against Android headset mic button resistor specification.

I'd expect to see this implementing a set_jack() operation in the CODEC
driver and then using that from the machine driver.

--8lkflKrUIKRf2OBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXXlpwACgkQJNaLcl1U
h9Aifwf+I6B9/2gaBswUYDsv/V0TVHsb8CWTIaY1B3OQjSroKXN4oz/6Ez03o/B4
pczqcwuHnhnPPgXrVzEmPYATJNWuZRxmxiqOPLLTq861s0vIhcduis6FwPQ579Xh
CWpYoBFfGfdkQ6r5gU6kE5EF94w279M06ygBWb6yzMS902D68ds1u8GXe0blMXjd
6kjaZF0mgiVrdSdj5+FFE7fUzMCRufBVyRqOYNnzG2wOHXr9VbdiUBbs99O8qz1v
VB3UvBuw5mQpL7q7AYsu+bynrGhEP1UJO8onyk43BMOHK52QxpzRRDSbJe8mQF7n
SKw4CzM2hZryreo8PhChH/dl24oj0A==
=dtME
-----END PGP SIGNATURE-----

--8lkflKrUIKRf2OBT--

