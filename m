Return-Path: <linux-kernel+bounces-133224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B7889A0C5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E223283BD0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2915E16F84F;
	Fri,  5 Apr 2024 15:14:48 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B3916F84A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330087; cv=none; b=PJWnOnk8ssYFSGZDVmIHVAgS4UJyTuYOvHz2bURB/VJsYAv+7m+c4MAIiEEKOHmS24ulwTNJXxDvvo6rexyaWBOA+Si+OH+51Qa5LYQSS//cJbvtf9xn3fBvZcUgY37RzFTp4BD7wGFD0lkRS0IpuisPcipGcKuS8hhcojtG3ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330087; c=relaxed/simple;
	bh=snf41gCimFFTVbLiUagJ2pBfBfC8jnvj5uqnhSaspAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uV53W5O2AOst6IJJLuXFhbeQLMlN15ENLqaHhqBlH3OcQ3C1RVn9uiabr634YFFUnd0Bey7PLHoekQDv7vTVccvMnfzqNpU/CoOD9Mq4tAExs9G7Gf/rbICdFNM77z1ucqmJkNJw0eAxV9AL0Qq1WExHbzXOEbwA7VK7gpG2Evk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rslH9-0003tV-1z; Fri, 05 Apr 2024 17:14:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rslH7-00AaFd-Tr; Fri, 05 Apr 2024 17:14:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rslH7-00FWAw-2i;
	Fri, 05 Apr 2024 17:14:41 +0200
Date: Fri, 5 Apr 2024 17:14:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.hennerich@analog.com, nuno.sa@analog.com, dlechner@baylibre.com
Subject: Re: [RFC PATCH 0/3] pwm: add support for duty_offset
Message-ID: <yi2h45jkaqevzmbv56lxnhopfg43474pumoz5gfmozmf65dxov@4ezyfnakwwkv>
References: <20240405003025.739603-1-tgamblin@baylibre.com>
 <fhrderkiwqzc7fw2hptz2la3aco72wlossqbrr4m42qllcpcpw@vhxflah2ex2a>
 <9b2bab7a-24a7-49da-8cb8-f58e28baf065@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ihutw3or4wakatkd"
Content-Disposition: inline
In-Reply-To: <9b2bab7a-24a7-49da-8cb8-f58e28baf065@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--ihutw3or4wakatkd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Trevor,

On Fri, Apr 05, 2024 at 10:19:20AM -0400, Trevor Gamblin wrote:
> On 2024-04-05 08:23, Uwe Kleine-K=F6nig wrote:
> > Having said that I don't like the addition of .supports_offset to
> > struct pwm_chip, which only signals a new incomplete evolution of the
> > pwm framework. Better adapt all drivers and then assume all of them
> > support it.
> Can you clarify what you mean here - is the intent to put basic handling =
of
> duty_offset (even if that means simply setting it to 0) in each driver?

Well, it's a bit more complicated than setting it to 0. It involves
translating a setting with inverted polarity to one using .duty_offset
and make all drivers implement that accordingly.

For drivers that support both polarities the logic in .apply should be:

	if (.duty_offset >=3D .period - .duty_cycle)
		... set inverted polarity
	else
		... set normal polarity

I'm usure how to do the transformation in reviewable chunks. Maybe the
easiest option is a new .apply callback that honors .duty_offset?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ihutw3or4wakatkd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYQFWAACgkQj4D7WH0S
/k6HTwgAlpLr1QB5F/boxHcwG6Vj9ErqXPT9OYI53ScblBJLwDhQkVrysQrVcAum
NmEzuWD670w4+H/v/uuxM/BXYNboNBcLH28i8aZRMXsqQ2OKytZkKDUUjtxZojVq
h2s8l4S/hs5EFp/L0eeWYpPd2oBD+hIWH0Ltv4VLLfrscXLfDfOa5c56ptUBdL8N
gUa8GGbJ+vCNO6gZaIaqOc2sJttunmY8TVxP6qIakvyLCVfad8zq++D768Eyd8H1
8vGL1SWYOnw338OkkwQWxZ8zTCPGxAJcPT826i11IntYTr/bPQBkvtUCKvndWqOT
t8dHlqoPfVe9ZuBIraPCQsbVerTbBA==
=pUxM
-----END PGP SIGNATURE-----

--ihutw3or4wakatkd--

