Return-Path: <linux-kernel+bounces-33973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 006E9837123
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC1C1F305E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229F6495EB;
	Mon, 22 Jan 2024 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCgAUbk5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6305C3D553;
	Mon, 22 Jan 2024 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947649; cv=none; b=ZMxJTf3scJHo/S4pyoeWiglvIypcnOX4KTfEfYP1tag/mVYxbRNkxAbp73A7q6grNd23eVVXwPKlY56yoQmzynlAyqF6I5hF3l6D816Bs2TiNfBDVoGwRtLXJudzZr2T2HBLjMl6QRwr0exqWIyHfTPkWOTVgskY/fZWrNHwpvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947649; c=relaxed/simple;
	bh=0sJKHQG49NpDF9oXlr8dzTMmdtReYYA/3/HvI32mt3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjvXjgqAjtNAnRMN3Gre/KtVwHaYA6um/3rMzDQaiM9N4LJw9SEEmQwAR2oyj8ipHqvSJo5FVoi2aBNmWFr/m533P2wkJDu3/C59QseKqPOQAnmYkCqi3YuuxjLn1Ss3kZiDfsW1hag5w+9DG0WixUsF9GvNPN0OTzUNpGS4NFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCgAUbk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F51C433F1;
	Mon, 22 Jan 2024 18:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705947648;
	bh=0sJKHQG49NpDF9oXlr8dzTMmdtReYYA/3/HvI32mt3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kCgAUbk5wO9/OcyNXeGVOEeNOJx2Z0zcXXV+pcVXVq6ZC13luQfhGm1aXZWEmlicy
	 MjdrjHYGND4iwtjMVNRzlTEmq+5eJFN0iwV7khwWD2q1dl00DRGugUS/srimkX0Vmd
	 qnx1ASTi/s4Di6GfmNKC01VjPy1VX1aeqytRhc5yC/Xw2zkgD1r+DsORl1wskKTTb4
	 4R6DRmGNqVo2CNVnKM35LvAf/1oZ9BLKd5TIsojzlKHOkvbjwZPr0uIR2Ne8UiDKo1
	 X2yAJUkeZgkGkPvTpjQovXDRcHLP/ktkvLM0pGVSgGDxIif/i45B15z5JV4Zhabnr5
	 1isaAHiq35auQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rRyur-0000000014o-0z39;
	Mon, 22 Jan 2024 19:21:01 +0100
Date: Mon, 22 Jan 2024 19:21:01 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 2/4] ASoC: qcom: sc8280xp: limit speaker volumes
Message-ID: <Za6yDXTPp9MzC1bY@hovoldconsulting.com>
References: <20240119112420.7446-1-johan+linaro@kernel.org>
 <20240119112420.7446-3-johan+linaro@kernel.org>
 <d54d3640-49bf-4a2f-903b-4beeb0ebd56c@sirena.org.uk>
 <Za4cR90XoAaATq8X@hovoldconsulting.com>
 <aca2b125-acf8-4791-a3eb-ea19826d3ee4@sirena.org.uk>
 <Za6l6EP7OqXPU9mj@hovoldconsulting.com>
 <8c6fc7e6-7694-4718-be47-d9fc3f893947@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SDkeIWwVz3rl8Ay6"
Content-Disposition: inline
In-Reply-To: <8c6fc7e6-7694-4718-be47-d9fc3f893947@sirena.org.uk>


--SDkeIWwVz3rl8Ay6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 06:06:25PM +0000, Mark Brown wrote:
> On Mon, Jan 22, 2024 at 06:29:12PM +0100, Johan Hovold wrote:
>=20
> > Could you please try again, and tell me which patch fails to apply and
> > how it fails?
>=20
> It was the specific patch I replied to, just the standard "this patch
> doesn't apply" message.

Ok, thanks. No idea what goes wrong here. I just sent the regenerated
patches as a v5.

Johan

--SDkeIWwVz3rl8Ay6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZa6yCQAKCRALxc3C7H1l
CJxRAQCuI9Q8CVpoSadmK9bGHfSYEgp3BrhBbEZIhHjThFuJOwD7Bqj7D2tNHWON
piUIM+AN1i4Eia0yv8PbzpYWcziIwQM=
=fQyz
-----END PGP SIGNATURE-----

--SDkeIWwVz3rl8Ay6--

