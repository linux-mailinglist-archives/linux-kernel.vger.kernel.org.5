Return-Path: <linux-kernel+bounces-126353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B85089357E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 21:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 864EBB22E75
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D406146D6B;
	Sun, 31 Mar 2024 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="EWburBWB"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D024146D5C
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711912239; cv=none; b=qseDj+iJ7LukWlsDdpzXiIj+bYDfqys6qMPzKG8rwNSFWGDyGsS49OVvkLYgKTpCxDPueQDJ2kWHgTC0TmYV1kbX9n5ummGIFDr1wfE1RhxWxExFOtEgTfM9tVhlq+VeGrzKvS4DTSuvuPczOTFARghoJZzmf6Jqpu6OsY5gxdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711912239; c=relaxed/simple;
	bh=zquvECkhXFKGeqN+2HotacergWrCotq0h8xbNwu5S0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W4G1ziO37es1NB/3L2edSjuVjnASfnueMJu5UZt59Gir/qN4Q2n6WCKjDQgXXsjbr/lCZhagnRGprjqUuAPKbZP8TM+RNGhx3by62h83ZoIWAqq3XEGYxdYvUQHX9zmEiCz/kHfO/eCMO7bxyBRutwft8eXVRM454Exyz4ulyZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=EWburBWB; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id A577C62FD5E0;
	Sun, 31 Mar 2024 21:10:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1711912226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/EtX0OVt3ih5dbQ01+pyMTmXRKnYiOfgjTF+4SBncoQ=;
	b=EWburBWB7TKQXoda3pMGIi/jRURXx0cTJ+HY3XiIq22mxZTtnQZ+lrGDyD3k/0+PtJMW9R
	51WB8jFLu3p+3YSqm7c1p8hMaJiW8M9I5c6SsMkyWw1sJ1C8AkiuFodk6EICKOlLRbKSEf
	N1PJFoUblLPUF8RiE1hD38Ue8gBh3Wk=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/display: fix typo
Date: Sun, 31 Mar 2024 21:10:13 +0200
Message-ID: <2740172.mvXUDI8C0e@natalenko.name>
In-Reply-To: <a7c8ec21-adf5-4dcc-af7d-33662f864596@infradead.org>
References:
 <20240119102215.201474-1-oleksandr@natalenko.name>
 <a7c8ec21-adf5-4dcc-af7d-33662f864596@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12423692.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart12423692.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] drm/display: fix typo
Date: Sun, 31 Mar 2024 21:10:13 +0200
Message-ID: <2740172.mvXUDI8C0e@natalenko.name>
In-Reply-To: <a7c8ec21-adf5-4dcc-af7d-33662f864596@infradead.org>
MIME-Version: 1.0

On sobota 20. ledna 2024 7:44:45, CEST Randy Dunlap wrote:
> 
> On 1/19/24 02:22, Oleksandr Natalenko wrote:
> > While studying the code I've bumped into a small typo within the
> > kernel-doc for two functions, apparently, due to copy-paste.
> > 
> > This commit fixes "sizo" word to be "size".
> > 
> > Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.
> 
> > ---
> >  drivers/gpu/drm/display/drm_dp_dual_mode_helper.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c b/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
> > index bd61e20770a5b..14a2a8473682b 100644
> > --- a/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
> > +++ b/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
> > @@ -52,7 +52,7 @@
> >   * @adapter: I2C adapter for the DDC bus
> >   * @offset: register offset
> >   * @buffer: buffer for return data
> > - * @size: sizo of the buffer
> > + * @size: size of the buffer
> >   *
> >   * Reads @size bytes from the DP dual mode adaptor registers
> >   * starting at @offset.
> > @@ -116,7 +116,7 @@ EXPORT_SYMBOL(drm_dp_dual_mode_read);
> >   * @adapter: I2C adapter for the DDC bus
> >   * @offset: register offset
> >   * @buffer: buffer for write data
> > - * @size: sizo of the buffer
> > + * @size: size of the buffer
> >   *
> >   * Writes @size bytes to the DP dual mode adaptor registers
> >   * starting at @offset.
> 
> 

Gentle ping. I don't see this change in linux-next, so probably it got lost.

-- 
Oleksandr Natalenko (post-factum)
--nextPart12423692.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmYJtRUACgkQil/iNcg8
M0s4gRAA5iLebl3ys6Ahv0UbaSkAVM2x4sVViWzB8xhhyJ5uzt//1482rTXM/fuk
griAEfUtxGcoeU+WHSpBNbd6vNfQPgPJU826ZoUkWp7lpebHYSYfGofZjU9226jW
aAugwhPVnAU5yM/i3d2UnqJXs9iBRyfjFHoBxKOXYJxR+0bbSKvSemRRh0IZQrNd
EnZ6Q0LSsiin98uFZ7asf+9P1RkXMT/ZSWjg03VNUmMDxC7NVLBCx6erTb6+KN95
xGxqi7wmQizlYtO9zvVTzYyRt5HCWKzv6SpY6C4fYYFEzjZXncAa+G9DCGnhCR4u
IIfJUEnp1uW2+AEyflXH4rdv0835yLq+vxeImpo7zjIpgoqUXu0/3HnASmVI3pay
vMrQC/pWKF+5hz9L154wDsHzYUJvKPAeYIbdDak6QQEppRL6slOqy2dyeK8rsizT
po4TPtqba2d5QZ3P0p0BOdEjMKCzjRD1nFxbMRi+UkA0EIE9XI3A90WUpcgI1G+A
0UPCR04RKEgyafXnbLJ0z2Tdan0Inwa64URtkOpVhz11SeYa61JBcQz0wie4v/1k
aGaHS77AP1s/3NkX4FyrL4SIb3p+pr6DzFGI/MeRRsTGCLzSmdu9X5gdQh5AYpuh
+5bt2Kny7bvfnCjOOidCvLY4iQvgOysdxgSUTZVDn3Ztwg2FizY=
=3A4y
-----END PGP SIGNATURE-----

--nextPart12423692.O9o76ZdvQC--




