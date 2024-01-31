Return-Path: <linux-kernel+bounces-46500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3EE84409A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106781F2B5D1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E3B7D3F2;
	Wed, 31 Jan 2024 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ6rqX4H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64C979DD0;
	Wed, 31 Jan 2024 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707896; cv=none; b=FpyjvmPIw9XGzajBfW6EN9LKsp4cavGSHAXeL+kCzeO+0aKZwstS2CLWyus7QAcDmo7YTxy3tVsjcCiV/W18kEo24wkv0AprpTEHfIzjYm7NUKPIrxl5GN42Kx5FMnOMn6xs1JhnfaWzV0A/dULs28nUHOJSlPt4TXGf6JUB5Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707896; c=relaxed/simple;
	bh=/wX6XvVShZF4f+RJM2tJZ0XC0594GygcaRPbj/ixCk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nd36MOfBhxJuObUBb8nG2eAM3cfXYHBEVSobySKVn3Q9sbu6gLf3AFXGykwfUuswsy8q9pFs2NiO881L4lRvGQdbyWl7x39nuTa5v8oyagtxDa/Vf1C1svkvWipy3dzykqB9B9ndGUMakKQEWAzXYCg2bQ86I2hb6TzCwXKug0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ6rqX4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85D6C433F1;
	Wed, 31 Jan 2024 13:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706707895;
	bh=/wX6XvVShZF4f+RJM2tJZ0XC0594GygcaRPbj/ixCk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZ6rqX4HHl5QPe4BXP9ckVtW/dcev6Rq6IzWVYJDhFivWx7cFifDs1+R9FdydacKM
	 CLnyPI/uws4gRcxB08g8zmEwBYedkXliswtYEjoK/YMTOeTE7tiCBwqigWCrAo9o1L
	 AlrLuZRsk/28HfWdPg/FiADJxaLl3Ze8Xg3N896RV88GixeqJMj/AXfgA3mXIK2XbY
	 KLwTYK7Z/sqitkr8m9Gg4JXdZLnT/bXByYRaP3zxHaT2Fr8s1NmfAuGU0yzaSGn+u8
	 GRH0BLK1sPMhdlu96cWuBrUYCVX/3De0cQKgX0NhIt7fh8qU6Q5KcozDtJpSjCfT8s
	 9/AXjhzoQG96w==
Date: Wed, 31 Jan 2024 13:31:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v6 4/6] reset: Instantiate reset GPIO controller for
 shared reset-gpios
Message-ID: <7a65b551-817d-4f51-8eb9-bd8b2f93dcba@sirena.org.uk>
References: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
 <20240129115216.96479-5-krzysztof.kozlowski@linaro.org>
 <CACRpkdYf4HUaV-Pjr81WjLbzy9zdAnyFWs9gPayPC6-3OjHQwA@mail.gmail.com>
 <CAMRc=Mc1SGLeUOWmKg=fvCdM+RR6FSu2QkFuR17s7L99eRMGug@mail.gmail.com>
 <CACRpkdbaxqTzwL9L02vCpMMdBYsubNP1VkNuJ8mXB_=4E3Kjaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5U5lAS5lCFVLuVnC"
Content-Disposition: inline
In-Reply-To: <CACRpkdbaxqTzwL9L02vCpMMdBYsubNP1VkNuJ8mXB_=4E3Kjaw@mail.gmail.com>
X-Cookie: I will never lie to you.


--5U5lAS5lCFVLuVnC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 02:17:54PM +0100, Linus Walleij wrote:
> On Wed, Jan 31, 2024 at 10:37=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:

> > This is a different problem: it supports many users enabling the same
> > GPIO (in Krzysztof's patch it's one but could be more if needed) but -
> > unlike the broken NONEXCLUSIVE GPIOs in GPIOLIB - it counts the number
> > of users and doesn't disable the GPIO for as long as there's at least
> > one.

> I don't know if the NONEXCLUSIVE stuff is broken, if you mean reference
> counting isn't working on them, then that is by design because they were
> invented for regulators and such use cases that do their own reference
> counting. It's also used for hacks where people need to look up a desc in
> a second spot, (perhaps we can fix those better).

Their own reference counting or whatever other coordination they want -
the deal is that users are responsible for their own coordination
whatever that might be.

> The NONEXCLUSIVE stuff was prompted by converting regulators to
> gpio descriptors, so it was for the greater good one can say. Or the
> lesser evil :( my judgement can be questioned here.

Right, previously we were working out if a GPIO was shared by looking at
the GPIO number but with descriptors we need to get the GPIO before we
can do anything with it, including figure out if it's shared.

--5U5lAS5lCFVLuVnC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW6S64ACgkQJNaLcl1U
h9Bm0Qf+PFOwuKiFI40ez5qHeItPwuHuhqbENB0dhjJvdchHy3Bdgsm1MCOMCTZd
6/cO4FuB77KP/slLSj7ICXs76V7dBj+b44PHcYb8WLCekOT8Sqj5Q4CJTjdw0qSp
fAHhiisIim79bkwRPZgsDDqBg3tPk84eHCE5ucSRJKd620AHcOMT5TNPUWLsrREg
btTfJTz5iioUdkoMfH1nbKWhhE9SeSP7DDnQ1EHb4kT8GEe9W7rvxtiky7BVK0FP
FkXKDzVduVT1NWiWk6tBtoowFaiiG9r5Oj1xQh0W/o7MBJPE5GqAEMMWrgaop/93
k0CRefl+PXGzcKCbK0TE9DN/8NVk6w==
=M89N
-----END PGP SIGNATURE-----

--5U5lAS5lCFVLuVnC--

