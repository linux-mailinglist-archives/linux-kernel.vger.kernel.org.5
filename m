Return-Path: <linux-kernel+bounces-158750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FB58B2474
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1AA1F216ED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1BF14A4F9;
	Thu, 25 Apr 2024 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtLHAqD5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9F11494BC;
	Thu, 25 Apr 2024 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057089; cv=none; b=khsGGdkeRZFdXgtKiPBr+iKFqqTtkrTCxcKVFqbS9vtrxgcPO9RtguwIiop46/FeH2x1vgIpmAX78V93Q6ehydjwYvkERTE/OxVS1+QORFvgnjzd1u7y4xVtTC93jCJUBEP7UjoqQHzM9Y7nAZ41IeTsOCVY6oZ0mBFNPejIRbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057089; c=relaxed/simple;
	bh=zyuU7aypTY7g7YWDgpvL/ij2MOClcEQlWT1WF9DZpnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrBNY80yHLRGqkwMG2TsWRB5IIqre21Kp+rx4FyhesahgHFaHDJZzaKp8ovctqLmQL5LL41gTBkDI+ZspZF0mXNBbfAueKQs9EbmF2oS2z/tAfrlTcBMK0VTtQMnP70DF8RPjAs91knQH0QfhYafZSFchBMn27VMkkAUCFg9VqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtLHAqD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A06C113CC;
	Thu, 25 Apr 2024 14:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714057089;
	bh=zyuU7aypTY7g7YWDgpvL/ij2MOClcEQlWT1WF9DZpnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BtLHAqD5xWO6OKKeia9yyRqUbAZB0xhKytVz5eaC5G5Ya1YPReGVbVAaF7/ZaKn9E
	 /YuLVEgSYmSyITwT+i4uYE8KjcE9QsaA7lfLMFml/bQbHVooHG5gooswSTbsbxGkVb
	 GmNqGaU0umBagSSt43PXEn7MfPYYrh/LXo7BxRaX+gCVpY0xbFfTVd1CyJVq44PgVk
	 ijSEO/PN4GdaRWue3P0ayedh8e881ZCREpETeTeD7+LPthn+ICOFyrYRdiNqOwueVG
	 ATod9Y9lk0OwDZmw/nbgeV3Q/0A5a65xik1HCpPMMXHzvhkd1Dz9D4tRGGhx7TSgTg
	 Qw41nwqdHBLPg==
Date: Thu, 25 Apr 2024 16:58:06 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>, David Lechner <dlechner@baylibre.com>, 
	Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v1 1/1] drm/ili9341: Remove the duplicative driver
Message-ID: <20240425-perky-myrtle-gorilla-e1e24f@penduick>
References: <20240425124208.2255265-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="74envoxrgvwfu67m"
Content-Disposition: inline
In-Reply-To: <20240425124208.2255265-1-andriy.shevchenko@linux.intel.com>


--74envoxrgvwfu67m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 25, 2024 at 03:42:07PM +0300, Andy Shevchenko wrote:
> First of all, the driver was introduced when it was already
> two drivers available for Ilitek 9341 panels.
>=20
> Second, the most recent (fourth!) driver has incorporated this one
> and hence, when enabled, it covers the provided functionality.
>=20
> Taking into account the above, remove duplicative driver and make
> maintenance and support eaiser for everybody.
>=20
> Also see discussion [1] for details about Ilitek 9341 duplication
> code.
>=20
> Link: https://lore.kernel.org/r/ZXM9pG-53V4S8E2H@smile.fi.intel.com [1]
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I think it should be the other way around and we should remove the
mipi-dbi handling from panel/panel-ilitek-ili9341.c

It's basically two drivers glued together for no particular reason and
handling two very different use cases which just adds more complexity
than it needs to.

And it's the only driver doing so afaik, so it's definitely not "least
surprise" compliant.

Maxime


--74envoxrgvwfu67m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZipveQAKCRAnX84Zoj2+
dvmrAX9etHoRYY5/bI3esFlwYvaOtVaTDgXGupHx8xowA1Hxjt+tFOdluSqL/hlq
SI1l4y8BfRsxjM/ARJYlGvp4Wnn0sIUBposLg8sGbgX1rxcALiJweK1Et3vTt3+S
QMlLOJkL9w==
=4TjG
-----END PGP SIGNATURE-----

--74envoxrgvwfu67m--

