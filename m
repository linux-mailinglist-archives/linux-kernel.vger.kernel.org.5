Return-Path: <linux-kernel+bounces-137371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F01F89E120
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC8F1C22977
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50097155A46;
	Tue,  9 Apr 2024 17:10:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651C6153BD8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682649; cv=none; b=h7A/Q9OLm5Jaj3YTX6EKlJUpX1a6Tf47WdmbBRJlcT8i54JVE745MnQOWdgWkeKxNAi6S3igbbzYxWQ6sOvcFMuRnCWSholYyb7rSTs37/49VW5izsR/oWmqw5ij6vi34QFw1F4jjHqlSZzU5Dgic70zpyv+1vwX2O+D/q6eIQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682649; c=relaxed/simple;
	bh=//NYRKb9J4jh0dSOg7w2Vs50Sdc+5h5cLrGT0qMmio8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAuEPNzV90pLXZjJltUjuN5TcjiVv6vN4654fLUhcJONECu9zwxg5KHKDTFK8unXbgyNnM6y8HdyrC5ERWr/N9cXrfD+M8W3/Z+VHA53lU2AK7vPRzhzMBAFeE15Hh0V+T5RyTLUMtvDQgw2ExI8uFpxc9KaKjyMq0NhjqECdaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruEzS-0008Pk-KN; Tue, 09 Apr 2024 19:10:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruEzR-00BLKD-3C; Tue, 09 Apr 2024 19:10:33 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruEzQ-00H51y-3C;
	Tue, 09 Apr 2024 19:10:33 +0200
Date: Tue, 9 Apr 2024 19:10:32 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 0/4] gpu: Convert to platform remove callback returning
 void
Message-ID: <tlmlxgcsz27q2hm2z5hht7deiksp7lrpin3ju2sutc2higfhmo@bw3avnea6sac>
References: <cover.1712681770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wh4wffqp5vy4ayph"
Content-Disposition: inline
In-Reply-To: <cover.1712681770.git.u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--wh4wffqp5vy4ayph
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024 at 07:02:47PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> with some patches sent earlier[1], this series converts all platform
> drivers below drivers/gpu to not use struct platform_device::remove()
> any more.

I forgot to include footnote with the list of earlier patches. For
completeness:

[1]:
	https://lore.kernel.org/dri-devel/20240409165043.105137-2-u.kleine-koenig@=
pengutronix.de
	https://lore.kernel.org/dri-devel/20240304091005.717012-2-u.kleine-koenig@=
pengutronix.de
	https://lore.kernel.org/dri-devel/20240304090555.716327-2-u.kleine-koenig@=
pengutronix.de

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wh4wffqp5vy4ayph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYVdocACgkQj4D7WH0S
/k4NBQf/fGCO4C5nBz03r5cSavubMucd4IklIaLfyl262aXVhEoDky/JmF6J/iBK
DH//l0VXopedb0iA1DoShtgQd0/4murtDOrKL8i6pZ8pIzkT4VeVxaftlnnLUtrS
pi6ryVXU5kfczK9gx1c+VTbgl/sTzKmOTP7VUd7V5MctnmEE1l35kwlMwWwbLBHq
VK7IkbRT+nIRuqDfmjpIJCMWAigeJAXIclmMT5z5W7TGfqGlbhGsoVL29gdL4PsK
phXuywB6RFq0kpDbCBYBSau6ylBov/kaX5hlcGliWuxNxOjAXaXX1rbk6vghqatH
HrmfYNmYaOg/oL5DdyZD4fqTUawBrA==
=Mzy3
-----END PGP SIGNATURE-----

--wh4wffqp5vy4ayph--

