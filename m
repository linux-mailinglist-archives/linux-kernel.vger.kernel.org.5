Return-Path: <linux-kernel+bounces-33903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295D9837094
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3C28B376D5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC265F54B;
	Mon, 22 Jan 2024 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEW3ozoj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A575F872;
	Mon, 22 Jan 2024 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946791; cv=none; b=OlIXUImKYfKmt/tzasu790Cozi80dulrUWfjAe1HjBPto0wXX3BjU6jxu/TPhwKwl5JDu8UliUuuzwVzXyy5jXrpfGVyfr6C5QQKdMezkuGUo9hsk/gXToDqPfUBD7Wz1/WLdfWtBUPEWa1qUbBChWveqVHidDqdEAIqxNfYTFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946791; c=relaxed/simple;
	bh=kyRl1N9Q/dQhytK5rUW6BG9+l/1vrFhgo42ePkJfkkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llIRRvRuobhTEzcN4HjtDcHLkfXipXethk0YfKsuyeclqIT/ZpL/uEPg2DI1+uvbrh09zujPtGrXlGRhYagQcQPEMv5gwIIqf6DBOZgW9Z3VA4bDDXBs7PleZrL+P7i/pnCCek6cshqI2AyV7EJVpHTuANHR7efBQqc0q7BbhTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEW3ozoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE0EC433C7;
	Mon, 22 Jan 2024 18:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705946791;
	bh=kyRl1N9Q/dQhytK5rUW6BG9+l/1vrFhgo42ePkJfkkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kEW3ozojryUaFqJeewEJEvDyi2f/KWTnppNBa4N7s4zyU7sdQkK3ar00wfaNpRlhJ
	 K3DiEMvUkVOswNvJWjEJRM+OczTCmLApyovnaWgJ+t6ZOh7tJqLIeQW3qOB19Btxxq
	 rjuPe92x5BoG/KKtblBxXjFeJPzFd4j064Rze6cN1oM1KDjyBXPQIqQwW4MKFpfCvP
	 w6OireLjH0tjGeb7eyfwhsVyUnlosSCpj+Y1+8xfhFUI7F9P5oY0n0qKAVT4D1XXEl
	 zIenD0lJ4oyZyd3wn3RSsdT+0wwQbJrKDASIGVVcwO844i3fGlpVDMJo4yO0rmjhjN
	 waIKUjbhX1iEg==
Date: Mon, 22 Jan 2024 18:06:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 2/4] ASoC: qcom: sc8280xp: limit speaker volumes
Message-ID: <8c6fc7e6-7694-4718-be47-d9fc3f893947@sirena.org.uk>
References: <20240119112420.7446-1-johan+linaro@kernel.org>
 <20240119112420.7446-3-johan+linaro@kernel.org>
 <d54d3640-49bf-4a2f-903b-4beeb0ebd56c@sirena.org.uk>
 <Za4cR90XoAaATq8X@hovoldconsulting.com>
 <aca2b125-acf8-4791-a3eb-ea19826d3ee4@sirena.org.uk>
 <Za6l6EP7OqXPU9mj@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PKIws8OF8mXQ1io0"
Content-Disposition: inline
In-Reply-To: <Za6l6EP7OqXPU9mj@hovoldconsulting.com>
X-Cookie: Nice guys don't finish nice.


--PKIws8OF8mXQ1io0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 22, 2024 at 06:29:12PM +0100, Johan Hovold wrote:

> Could you please try again, and tell me which patch fails to apply and
> how it fails?

It was the specific patch I replied to, just the standard "this patch
doesn't apply" message.

--PKIws8OF8mXQ1io0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWurqEACgkQJNaLcl1U
h9DSHAf/T3WNfXxLvAbJenp11DA/SEjMQj9/GAixxPGAr04YGXfFCHS+BU6RwG18
nfNEGntA5qkyWDqYJl7XiMiRn6VcG5yklGOgJAM0BltZFbCGw13HsTnFaMOj2to2
Oo9RdzNeY1iuE57nu5yvvTt3VkMAXaEtFskwAhcG6xXDBac0TWbTOb5WWCeijGua
ZtVT0iG1DF7SEhqdee8Lwr9Q+46VBcu0pChiLmycGGkb/jN1lpT4D6YF2gKUIunH
7f3yuN7asZHZ4VpP8YEsPkCyR2hsQfXYgzjufQWkIvH+YBetfle5X/3GecV3FIeS
mH89vrcQ7v4mkN1BgRpac5XjX9oaqQ==
=Vhot
-----END PGP SIGNATURE-----

--PKIws8OF8mXQ1io0--

