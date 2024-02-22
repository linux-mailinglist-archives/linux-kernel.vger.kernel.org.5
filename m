Return-Path: <linux-kernel+bounces-76971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F62B85FF3A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0418D1F26C97
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C39155A55;
	Thu, 22 Feb 2024 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="ezEI1lab"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB81474B6;
	Thu, 22 Feb 2024 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622613; cv=none; b=s8Y847pYBOW/BlcEK1mduOs3LMmoPzg4nG9NtQajsAFXrga2XgP9yJAwBTzKY8dYDgtCAWQh6WmuWicPtD5poK4KLUVvS7ZShKDI3MHT3yUxTTe1y/kVeocxm6tefkzT8iFIUAAPlrlJq2yZVQCd0wdp5TbycUu8QCGIfR11WyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622613; c=relaxed/simple;
	bh=G4iGZXz5pANw6P6dixF3j3pUndbXm1HnCQBrGRH5/6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXlHMySniOq0uzeVqB1BXU20amLB4lJFEvNeEQ5x9a4NzoSriSTass+SThhMf7U+mFgCv6tYMnMFUZKWMP0OR2LCjDrZGAGkjLM9sdGFNHHhGwdRf0adtf4UwTqh2hZL9e+HhtjyuqCzEPy8xsgG7ZWm20amvaC24dfeFA3Irps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=ezEI1lab; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 013ED1C0080; Thu, 22 Feb 2024 18:23:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1708622607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2YjIr5aUgTsjvLi9xKmkXNDQcBTORFOndacLAudYXZw=;
	b=ezEI1labo1josuTpKvSGarOXtuMPuKQbWe9fuLiN+78ANCflfREpDesPvqpd0WhQeMiDGq
	gpAH0ncJG9L8QPdHbrX8ZG4ZI19nY1nxkQgAx1w6ICGbWBtKEr8/x5leIGYnCAxSWAUYnT
	S0DLIRatlkRt4yd4T3ag6Mt+d9LDUso=
Date: Thu, 22 Feb 2024 18:23:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Werner Sembach <wse@tuxedocomputers.com>, Lee Jones <lee@kernel.org>,
	jikos@kernel.org, linux-kernel@vger.kernel.org,
	Jelle van der Waa <jelle@vdwaa.nl>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	linux-input@vger.kernel.org, ojeda@kernel.org,
	linux-leds@vger.kernel.org
Subject: Re: Future handling of complex RGB devices on Linux v2
Message-ID: <ZdeDD9u965bM+CCc@duo.ucw.cz>
References: <730bead8-6e1d-4d21-90d2-4ee73155887a@tuxedocomputers.com>
 <952409e1-2f0e-4d7a-a7a9-3b78f2eafec7@redhat.com>
 <9851a06d-956e-4b57-be63-e10ff1fce8b4@tuxedocomputers.com>
 <1bc6d6f0-a13d-4148-80cb-9c13dec7ed32@redhat.com>
 <b70b2ea8-abfd-4d41-b336-3e34e5bdb8c6@tuxedocomputers.com>
 <477d30ee-247e-47e6-bc74-515fd87fdc13@redhat.com>
 <e21a7d87-3059-4a51-af04-1062dac977d2@tuxedocomputers.com>
 <247b5dcd-fda8-45a7-9896-eabc46568281@tuxedocomputers.com>
 <ZdZ2kMASawJ9wdZj@duo.ucw.cz>
 <b6d79727-ae94-44b1-aa88-069416435c14@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8HNHTJiCVl5tEqHo"
Content-Disposition: inline
In-Reply-To: <b6d79727-ae94-44b1-aa88-069416435c14@redhat.com>


--8HNHTJiCVl5tEqHo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Yeah, so ... this is not a interface. This is a backdoor to pass
> > arbitrary data. That's not going to fly.
>=20
> Pavel, Note the data will be interpreted by a kernel driver and
> not passed directly to the hw.

Yes, still not flying :-).

> With that said I tend to agree that this seems to be a bit too
> generic.

Exactly.

> Given that these devices are all different in various ways
> and that we only want this for devices which cannot be accessed
> from userspace directly (so a limit set of devices) I really
> think that just doing custom ioctls per vendor is best.

I don't think that's good idea in the long term. Kernel should provide
hardware abstraction, so that userspace does not need to know about
hardware. Obviously there are exceptions, but this should not be one
of those.

BR,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--8HNHTJiCVl5tEqHo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZdeDDwAKCRAw5/Bqldv6
8qiyAJwLN/fdcmrJOkkG2EAbYAv8zFZEFgCfZXqQdlbGlNFyskYJxo9aqek7NBI=
=F8Cz
-----END PGP SIGNATURE-----

--8HNHTJiCVl5tEqHo--

