Return-Path: <linux-kernel+bounces-117217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862E588A8C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2DD1C3D9DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E45B4D9ED;
	Mon, 25 Mar 2024 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PECatv+9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1144D5B5;
	Mon, 25 Mar 2024 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376179; cv=none; b=lhYrGqFqFOOVZZxMWKp5aNki/kLErc5of25gbSwDHF4hrz/o/z225tmoFL2yVUvOt+Ja0hYQ9rnVp+LeK2KTgS2z1usJ+ZhiLDtwbzRp4yILdAZoN7DbRJltdBeqo8K8AcVJwC4ePkdL7AzAghf32dlyLMg64ib0x8jkfLwjY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376179; c=relaxed/simple;
	bh=r/XMZ3WXauYvm7sf5LS1SIvevJHJOehk70EFv+rTJIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/TirBrTeKoF8+DIFoP3rpu2qI5hdfEhgLZqurxHS3iNwnYl/wA0aj6jaPAGkhkyB0ZZ8jcHF2YBhsx5Wemc7KArNC+2VmXx7Kbz0E49BAo9fXdOD0dZCvSsN/7/xqSQB3Gi2+Eozgzibicw+N4/4mooBmg9KbMivW68C6JBMCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PECatv+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF11C433F1;
	Mon, 25 Mar 2024 14:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711376179;
	bh=r/XMZ3WXauYvm7sf5LS1SIvevJHJOehk70EFv+rTJIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PECatv+9XZy29PUnTXjlhOEIfHdyOmo4E4PPQmBSunU5rDGdGlyOEuLSY4fXBPuvg
	 q1r4kkHcqsnU08vRkE6XeieITlTxK1/lqd31YsDe0JNLOVBlKd79wm/0ZOw6UNv2X/
	 qHvr2RhnPsuGAKp594QMz6FA9/JzuXnA4jkQk1pdDxzbJMcC5WZd1UIStavKiHPtF9
	 GQwLvNdloDVXYzlBLF8MPlhqNyhdonTDUqzuhuaZ1VZDF0EqQZj2AsRMMEPCxa+GTn
	 2p3xfQBfwsl6/5Lb4ZmaIp/6eESaMlyvih24Ir9F1rC357tB8vVxG9MdBW+EzbFgUs
	 459IIiBEnrjoQ==
Date: Mon, 25 Mar 2024 14:16:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ASoC: soc-jack: Get rid of legacy GPIO support
Message-ID: <e6900b97-c1b7-45a5-bc3c-4a4a2745fdf3@sirena.org.uk>
References: <20240318202602.182619-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MR2NRS0l68cHGpCq"
Content-Disposition: inline
In-Reply-To: <20240318202602.182619-1-andriy.shevchenko@linux.intel.com>
X-Cookie: Bus error -- driver executed.


--MR2NRS0l68cHGpCq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 10:25:16PM +0200, Andy Shevchenko wrote:
> No more users.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/sound/soc-jack.h |  2 --
>=20
> If I am not mistaken, after
> https://lore.kernel.org/r/20240318200804.181516-1-andriy.shevchenko@linux=
=2Eintel.com
> there is no more users. Hence the above is the only dependency.

You are mistaken, please try compile tests:

/build/stage/linux/sound/soc/generic/simple-card-utils.c: In function =E2=
=80=98simple_util_init_jack=E2=80=99:
/build/stage/linux/sound/soc/generic/simple-card-utils.c:755:20: error: =E2=
=80=98struct snd_soc_jack_gpio=E2=80=99 has no member named =E2=80=98gpio=
=E2=80=99
  755 |         sjack->gpio.gpio =3D -ENOENT;
      |                    ^

(this is among other things in x86 allmodconfig).

--MR2NRS0l68cHGpCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYBhy4ACgkQJNaLcl1U
h9BowQf/Rppf7Qjjmtff9y9FS5vz5dJ7RLRz1S6N1JTwV4m4QYjv7YSGaWzHrqwf
1Eaa8ZzyvZh/6v6C29hamNu0LtlMg9ucT6v+W+KnTa+WkHz6LE1wqOlmhchqypL/
qRD0cTFjJFyKzM7cLdDeHWyXe+l3M5lr6eeAMG4TRivjecNwului9GuZ2ncVS82a
DBBJPErDR0In1Ec5dk5CSGWJHe5yzLi0Yv26WaEh8sZJXUwhSiYwlEGfON/jp5yW
TgZayyfKkrqBjcptdhUPxLaCa5az4CbBrXrSHCD8gfwQaWfi7P33inXgxFl0FBUU
tL3kTnkC+6lT9/SJ9jJtzPFAKiAJ0Q==
=5laV
-----END PGP SIGNATURE-----

--MR2NRS0l68cHGpCq--

