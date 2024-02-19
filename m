Return-Path: <linux-kernel+bounces-71590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A58C85A778
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCEB71C222EF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23ED39AC6;
	Mon, 19 Feb 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="QhbFq6B3"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EB638398;
	Mon, 19 Feb 2024 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708356903; cv=none; b=IQrkQppQiwRzlQSKamiginByLZTqz/lxMR9wlXGDO6LIs+5iKMfgvYfFvkBm20iK5jxi9pZtR2nI7Cml1M7drXO3d65THuQGQ7aLoUxn8VbGXM/ItA4mjpx8f4k0tXItMYFjE9/lz7kPrUC5M3P3OCJkCtEzWiv1G69/JdjvvM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708356903; c=relaxed/simple;
	bh=aqXyVlW3d+HoF9uReR/+Utxa70z7YXA2kyd8nwe/nkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjVRYQx5UeWUdLNIng5vd0LbnytZqzaRm0+MqxOwyWIWmkKJ7cYxddaqb/2U2BUpLWZQG0U9548U8uTNA5MSnxhe+dfMchRoPRu2XK8u3TRxmmiVQ/IlqDmDGpv/9jXwq//DS/MXsnCSxUcOsLrEQKQG5FVaE81m72rFqffGQHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=QhbFq6B3; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A78651C0071; Mon, 19 Feb 2024 16:34:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1708356891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XGkPyHRZGdXnHCCK4TUPor1qkxga/sNFfj4wWfPCLlE=;
	b=QhbFq6B3Topv1qBT0xYd/ix9Em4Ub9RSJr+dwV5KWiSEbuprYBVo640m+4DoiBnbFCwhPU
	saQ4g26CApXHkDeM6jZRY8HzfUTinelTFjQCFsLMgHDQWs35RPfyi8P2kb3GLZAO9w2Hk9
	gX5Uc1K6BXVy0OHAhKtxlCefSpRrDXg=
Date: Mon, 19 Feb 2024 16:34:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "lee@kernel.org" <lee@kernel.org>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux support for a 7 segment LED display
Message-ID: <ZdN1G6PfCK9/vUol@duo.ucw.cz>
References: <1f598a72-dd9f-4c6c-af7f-29751f84bd23@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yPb17zyHgF1OuMIw"
Content-Disposition: inline
In-Reply-To: <1f598a72-dd9f-4c6c-af7f-29751f84bd23@alliedtelesis.co.nz>


--yPb17zyHgF1OuMIw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm looking for something that I figured must exists but maybe it's so=20
> niche that no-one has bothered to upstream a driver for it.
>=20
> I have a requirement to support a 7-segment LED display[1] (one that can=
=20
> display a single digit from 0-9). Hardware wise it's just a bunch of=20
> individual GPIOs connected to each segment (plus an extra one for a=20
> dot). I can't see anything obvious in drivers/leds but maybe I'm looking=
=20
> in the wrong place. Or maybe it's the kind of thing on PC hardware that=
=20
> is just driven by the BIOS without the operating system knowing about it.

Look at drivers/auxdisplay. I believe we have segment displays there.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--yPb17zyHgF1OuMIw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZdN1GwAKCRAw5/Bqldv6
8qdXAJ9M+scNVUZ8g1U6IPdv+E7AK/PlMACfTgZ/uvO9npw3kAX/VIEJtyVy/Bk=
=vVrC
-----END PGP SIGNATURE-----

--yPb17zyHgF1OuMIw--

