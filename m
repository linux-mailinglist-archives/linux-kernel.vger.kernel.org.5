Return-Path: <linux-kernel+bounces-48008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759F284562F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036B2286B27
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B48115CD6F;
	Thu,  1 Feb 2024 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZz4QSq+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25C64DA0C;
	Thu,  1 Feb 2024 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706786737; cv=none; b=FOqUBTssYlh3fJlh6TX3Gn65rBqyWm9vhAtJEDB5eU+ta2Aj/VaHHNnNkBTf48dbTytqiOU/uEy4yHrdVDdHawUdJxGo1SwUXZlLD9mBzN6/nck0B/piremyPQqD9hLKrCuVEBqCS0mOAVkkf9pgfYA4ilIvg8AL6OdG+q0VQ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706786737; c=relaxed/simple;
	bh=8FsMzGJfsM0aOcmxMpvBjhVsj+8VYxKWtsJcxs8GM5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkbLdDHco06nXWVHQdkn1wyoqUQcz1Y4slm4xo1ber1ckGSwxpnB7VAFHCQmbVLTNyIC0Qn5uLb44wfC1SPABvqJPC0/cBEQCIVrJUPj0iRHR4titi3swu2VeTxQqrED34LQ6Kguz1b6z9B+r8sUKUz1Pk1FLW5aV46SmJ6MWvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZz4QSq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EC9C433F1;
	Thu,  1 Feb 2024 11:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706786737;
	bh=8FsMzGJfsM0aOcmxMpvBjhVsj+8VYxKWtsJcxs8GM5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZz4QSq+RagaDlfjVVz5KtwyqN+z6+sFOtdgVwirtr8OUVEyjsqZmctO07hi8NI32
	 7CXregjsqNFCRgNzAQC6LkIWzv5+FlZ5wptO3v4wdXf9QnO1eGpacIgLM+ofZOdYxj
	 hAVJ2KjiNLCky+UQLUuEHvtkt1AjCPRNtR+Gf4R7opVdUrpjheRe1N1Z6Ile36juWk
	 LyEHXJ1jGYRdeA/3Qd/ypbl0w5N5Zld3EkS/FrAXVZWt29xWDcW/7+Tb1+hdFwMFor
	 epg+86jqzzvkzy+KV9xJKQ8Wb03jVceOWng1nGR8KT30YOw61WiY7hww8gsNtTPFGI
	 B1ljn8Z04DlNA==
Date: Thu, 1 Feb 2024 11:25:27 +0000
From: Mark Brown <broonie@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com,
	ribalda@chromium.org, nicolas.ferre@microchip.com,
	u.kleine-koenig@pengutronix.de, kuninori.morimoto.gx@renesas.com,
	nfraprado@collabora.com, alsa-devel@alsa-project.org,
	trevor.wu@mediatek.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, lgirdwood@gmail.com
Subject: Re: [PATCH 0/7] ASoC: mediatek: AFE drivers cleanups
Message-ID: <6f7a34b6-6f65-42c3-a92d-6b064bf9dee1@sirena.org.uk>
References: <20240111105247.117766-1-angelogioacchino.delregno@collabora.com>
 <cace3472-7ee3-459b-ab2c-51764db99bd7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PVPGHszu86wFrqHg"
Content-Disposition: inline
In-Reply-To: <cace3472-7ee3-459b-ab2c-51764db99bd7@collabora.com>
X-Cookie: You can't cheat the phone company.


--PVPGHszu86wFrqHg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 11:08:41AM +0100, AngeloGioacchino Del Regno wrote:
> Il 11/01/24 11:52, AngeloGioacchino Del Regno ha scritto:
> > This series converts MediaTek AFE drivers' probe functions to use
> > dev_err_probe() and devm functions where possible and, in some
> > cases, dropping the .remove_new() callback, reducing the size.

> Gentle ping for this series, afraid that went out of the radar :-)

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--PVPGHszu86wFrqHg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW7f6cACgkQJNaLcl1U
h9CaHgf8CtVCkC6J116wxuSCyfeBTiCzoyj46PgrA3xwNRTTduzax3JoO/1grpq3
5NlOg1xyh3YtqEDvxa2wBDCc6fM3zw9mAQPKiXCqHHI2A8WH8xMPSJzvlhfrC14S
SDY7qm/mG8CiXyEI84YBRHdgoxBnBqECwRehV975FL3ZvrDYSQTFO4EbYI0I1oNI
arokA5pQoEzgBMazkodUtmgDueOoBVtbT7HQMsMTjtn+iQ7dMAhf2wGc8uhMC3K1
8jB9piZTC2sZHVRli3Rbzrs4TMYz8Ji5ey/zUMcsfKBO1/awWWGrYqm8eEZJiME4
TtANCMujJdC2XSTWBBod6hXZGV07oQ==
=z6oI
-----END PGP SIGNATURE-----

--PVPGHszu86wFrqHg--

