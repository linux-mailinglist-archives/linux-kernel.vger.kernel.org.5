Return-Path: <linux-kernel+bounces-162165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C78C8B56EB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4681C216A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5FF45957;
	Mon, 29 Apr 2024 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC+nGYW2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C9C3C24;
	Mon, 29 Apr 2024 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390749; cv=none; b=EYdt7JP3Fniln9ORe5iaO4HEO+QoMDKnPuIald4Be6WMcbQn3FOdNa8pxRhT4WdaVKIZoFQyvuzqCUHOm9uUpt8bQMPqKzv1Pn5JCDoweLmUU2/hdUOQjp7WFqmG5KNogEvusYy3RBsnfCcI+pY9+/VxQA1UlaqWdsmyw1mTroY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390749; c=relaxed/simple;
	bh=uZu3wKHQNWr0ZLymAFjd5ivV78yNbTAn33ozggWSTE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PH1kE/m6n/e0WBIRTH1FKIF+sWAjfWngKmvGkUCowhTNEb9B3E5XOBDkTepz716SKHBC19Dtao6aBQqiFLeL20R9EP0KP38wfQslhMB4ki70G7/yxtjoLDANmgTWeLu2DEq8llzQHM5eyrB5NcsrT+yqN+aFRYxW030pSZIaqTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC+nGYW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A805C113CD;
	Mon, 29 Apr 2024 11:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714390748;
	bh=uZu3wKHQNWr0ZLymAFjd5ivV78yNbTAn33ozggWSTE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HC+nGYW2S8rw/A3OruRlx4jB+D0gz6jk7NqR9R3PD4B/0HEXqW+bZlzv5BlOdJrrY
	 35TrG6u24kc/7Igpkw3xHpC+21isyj/mWgnZaz7LUqmvQhTK0ATuaZwqpAgWjUXkI9
	 qK4HvdMYxr/fLAh8VFLa7Y7Wh3NOqqp0VQ2Qrkq+2K+0xti8Dz4wpSBsp26g9nXvK6
	 GOL3H26QxYWHjhZi3rPuusu+SBqJpF9boYvhrXddnSQMK8CEnNcfWqsCg8MvbXQFye
	 0ENWLu3F3Wxv5CffhqU4AovNvY79Jb0X2BrlZp1mDFVfpaUjT3EPaFa42qr3QA+Zxf
	 DUIqQ5gZ080tQ==
Date: Mon, 29 Apr 2024 13:39:06 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>, David Lechner <dlechner@baylibre.com>, 
	Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v1 1/1] drm/ili9341: Remove the duplicative driver
Message-ID: <20240429-gorgeous-beetle-of-downpour-492bbd@houat>
References: <20240425124208.2255265-1-andriy.shevchenko@linux.intel.com>
 <20240425-perky-myrtle-gorilla-e1e24f@penduick>
 <ZipxEk9Lpff1kB7b@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ypdsdw5t4cfybdrt"
Content-Disposition: inline
In-Reply-To: <ZipxEk9Lpff1kB7b@smile.fi.intel.com>


--ypdsdw5t4cfybdrt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 06:04:50PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 25, 2024 at 04:58:06PM +0200, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Thu, Apr 25, 2024 at 03:42:07PM +0300, Andy Shevchenko wrote:
> > > First of all, the driver was introduced when it was already
> > > two drivers available for Ilitek 9341 panels.
> > >=20
> > > Second, the most recent (fourth!) driver has incorporated this one
> > > and hence, when enabled, it covers the provided functionality.
> > >=20
> > > Taking into account the above, remove duplicative driver and make
> > > maintenance and support eaiser for everybody.
> > >=20
> > > Also see discussion [1] for details about Ilitek 9341 duplication
> > > code.
> > >=20
> > > Link: https://lore.kernel.org/r/ZXM9pG-53V4S8E2H@smile.fi.intel.com [=
1]
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >=20
> > I think it should be the other way around and we should remove the
> > mipi-dbi handling from panel/panel-ilitek-ili9341.c
>=20
> Then please do it! I whining already for a few years about this.

I have neither the hardware nor the interest to do so. Seems it looks
like you have plenty of the latter at least, I'm sure you'll find some
time to tackle this.

Maxime

--ypdsdw5t4cfybdrt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZi+G2QAKCRAnX84Zoj2+
dpzEAX9NlMH8mHXaP+9bA+sNZT1R3FNYhW4Pt/1Pn1ubi1pgXk5iBoL6JrqISoVP
QXA4pXMBgORaHd6OB/qFoTj87/v5BZX5gZC0QpOeO4bItwlvpgRISkUwBwjWNi6u
pd9y46+Yag==
=V5/I
-----END PGP SIGNATURE-----

--ypdsdw5t4cfybdrt--

