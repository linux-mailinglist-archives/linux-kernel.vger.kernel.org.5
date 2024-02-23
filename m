Return-Path: <linux-kernel+bounces-79151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181AF861E3E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F4D1C25140
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B6D146E6E;
	Fri, 23 Feb 2024 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="QDYA8WAx"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7091412A16D;
	Fri, 23 Feb 2024 20:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721822; cv=none; b=O8XxSLjYtjxdXv+D5mD/H9TUwmMK0HF9v+ydkyjqFoRwONL7qsgdZGwsy9YSZsGzr9fKQDiwc7L2afcH2Of1BNCnsG9863mCrYKKRxODlcOioZGXw+20Ajo5KLaDCRWk/KHlA54OpiNdZilnN2p7h7gtkSrXUypOQilz+RPneD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721822; c=relaxed/simple;
	bh=CKZrZ6sYomS5NW1gYcqEpokW/ERpUA257FQDucHaWjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeoJg5sgI+LuMcUSeUMeeeege6DRTXAQqZgfIKQDbCH26xpUAnlP2mfde08HmNX39QdmmGY0YWt9RmyprJ7AL+LrzMtgdbvryRQKm3Et2tfrcWoXWFANo2mkT/zlaxS2jOOx2jsm4HcZg3go0TAZjjKuPPXqClw/583TDyct4vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=QDYA8WAx; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 377961C006B; Fri, 23 Feb 2024 21:56:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1708721817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=19PmzHinJBrlqK95eJjEcRGwQvI5W5s5uv/yUxNPc48=;
	b=QDYA8WAxyJChGBr3RHP0k1/MDQiSnDHWQnghXsOWwRcRxIKvWBd2PzCJKaW4sW4YjLns43
	voiF48OWAHvesB7KGc6XbfJCRYyCQks0w50tRTDYWVO+G/s9fSzzEaWNFnbgCNe8LUYAoT
	eIcijqHdFA9axqOQSwFbKPuZzEFvhgI=
Date: Fri, 23 Feb 2024 21:56:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v2 1/1] leds: expresswire: Don't use "proxy" headers
Message-ID: <ZdkGmE2HFxXpIonR@duo.ucw.cz>
References: <20240223203010.881065-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2lTx/hEuWHPoqeWW"
Content-Disposition: inline
In-Reply-To: <20240223203010.881065-1-andriy.shevchenko@linux.intel.com>


--2lTx/hEuWHPoqeWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Update header inclusions to follow IWYU (Include What You Use)
> principle.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: added one more missing header
>  drivers/leds/leds-expresswire.c  | 4 ++++
>  include/linux/leds-expresswire.h | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>=20

> diff --git a/include/linux/leds-expresswire.h b/include/linux/leds-expres=
swire.h
> index 3c61902ccac8..a422921f4159 100644
> --- a/include/linux/leds-expresswire.h
> +++ b/include/linux/leds-expresswire.h
> @@ -8,7 +8,9 @@
>  #ifndef _LEDS_EXPRESSWIRE_H
>  #define _LEDS_EXPRESSWIRE_H
> =20
> -#include <linux/gpio/consumer.h>
> +#include <linux/types.h>
> +
> +struct gpio_desc;

If include tweak means you need to declare struct, is it ian
improvement?

BR,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--2lTx/hEuWHPoqeWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZdkGmAAKCRAw5/Bqldv6
8kAvAJ0UQUgcqts8MRgtY+0Rml1psMSvWQCgnUAbxDekDN5xR7B5siUnzJgeMIU=
=ENYA
-----END PGP SIGNATURE-----

--2lTx/hEuWHPoqeWW--

