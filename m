Return-Path: <linux-kernel+bounces-78820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A29861942
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B053284FF5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF431C68E;
	Fri, 23 Feb 2024 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2wHc/gq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E07712AAE0
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708812; cv=none; b=KyMkBykp/kZbBOmqv16/D8IzTtXOp2NbK6CsJ4AhP9Fn+Dcgi1YRoJsPhSqe8YDk+LO7w1M8yXtBMlAqTx7L97KcPc0aEaB2yiRV5ekdXO6cKc0f7QTxV5DsvuWWBldKbAWybdJYBYkj6OE3nBvLOfMLXNcZiUlO6srC76Z4PSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708812; c=relaxed/simple;
	bh=T3y3bvy64o+ZYZ7fO4C4nj0LTrwniTjzjpka6LToHr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKNpgkAv3P49UxO9rI04kMauIVl9Sw1zHD/zTyvyp/WsN0frNU2/SerbJpssWNs38icnOQY4J6TxMpUenZy7n3zghBSBLX0+GyVQKEgJnVYUcOt6S2nmZfHvmK0NAVmMeLm0W33g/LjBL/fTrNDb+1zl8EUAq6I9GkyTOnHlCFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2wHc/gq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00988C433C7;
	Fri, 23 Feb 2024 17:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708708812;
	bh=T3y3bvy64o+ZYZ7fO4C4nj0LTrwniTjzjpka6LToHr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j2wHc/gqwUx4LU7n5jV4YJGxdYvcIIlVOlZgIu0Gv7+6tjiPvHaqsXIvFAFgkCVVb
	 Yyb/b9rxiY/iKEy++S21TC79mUB1hinHwv7463qyAbYlphTWnY9FePw+xQS3z9HZgC
	 erlaHvgN7pC3nKiH8w6yEFYasWS47UJ8hYOmqdr5BlLO0kTbLE/K5vUImKcC9QQAyF
	 dSGCaDa/euhWKFmSmaTcRwFYjVAXcdVBwehQ2m/EWxnbtNfoOXlZoYWenZafd4aCpZ
	 fWdtzy/CyFgRqvvRJrHmHa+TW4J3dJlbBQZaZyAsHk3JiwPTe5lD4lCKqk3+sgzLSo
	 EoJk8CpQwCBKw==
Date: Fri, 23 Feb 2024 17:20:09 +0000
From: Mark Brown <broonie@kernel.org>
To: "Ding, Shenghao" <shenghao-ding@ti.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"13916275206@139.com" <13916275206@139.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
	"bard.liao@intel.com" <bard.liao@intel.com>,
	"mengdong.lin@intel.com" <mengdong.lin@intel.com>,
	"yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
	"Xu, Baojun" <baojun.xu@ti.com>, "Lu, Kevin" <kevin-lu@ti.com>,
	"tiwai@suse.de" <tiwai@suse.de>, "soyer@irl.hu" <soyer@irl.hu>
Subject: Re: [EXTERNAL] Re: [PATCH v9] ASoc: tas2783: Add tas2783 codec driver
Message-ID: <ZdjTyccCDoD9QYpi@finisterre.sirena.org.uk>
References: <20240222074000.659-1-shenghao-ding@ti.com>
 <10f53a13-a0ff-40f9-b089-f5baacdb76b6@linux.intel.com>
 <5c7127256bf54fcd921fc1ec83f3e527@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JSSHE0FUht8S9Os8"
Content-Disposition: inline
In-Reply-To: <5c7127256bf54fcd921fc1ec83f3e527@ti.com>
X-Cookie: You might have mail.


--JSSHE0FUht8S9Os8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 10:12:49AM +0000, Ding, Shenghao wrote:
> Hi Pierre-Louis
>=20
> > In the SoundWire spec, the unique_id is *LINK SPECIFIC*, and only used =
at
> > the bus level within the context of a link to help avoid enumeration
> > conflicts

> > If you are using the unique_id as a SYSTEM-UNIQUE value to lookup EFI
> > data, this is a TI-specific requirement that needs to be documented.
> > That also means you need to double-check for errors so make sure there
> > are no board configurations where the same unique_id is used in multiple
> > links, or by devices other than tas2783.

> This code only covers the tas2783s sitting in the same bus link. As to ca=
ses of the
> different SWD links, customer will be required to have the secondary deve=
lopment
> on current code. I'm sure my customers have much knowledge to handle this.

As Pierre says I think we really should have some sort of defensive
programming here, even if you're going to leave multi-link systems to
future work people will still have older versions in distributions or
whtaever.  While I'm not sure the consequences of getting things wrong
are likely to be that bad (I'm expecting bad quality audio) it's also
going to be kind of hard to figure out if we just silently pick the
wrong calibration, especially if it's actually a valid calibration for
another device in the system.  Other vendors (eg, Cirrus) seem to have
figured out a scheme here?

--JSSHE0FUht8S9Os8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXY08gACgkQJNaLcl1U
h9CDTAf/bo/BBm0FaalBPQlGYIf6F1SuRLsnvDOwApCG85Z6wSol1qV1EdXwsRHM
4ijYqyHPymwdgpesQnl3LhgpuZ2m/eMk8xXOqOtjC/yCLN0f59uCAmw7XglxhQsP
WmS/0JEZ3Xv2+JcddbErmCdrWi+uJQkiJuhUYkxpx9p0gao5pYarIOoNyHC9vCFF
K+Cxv/YKjuQqakXNVGTfvC7ywD7iX3tT2UVtlAFm8VnFr9W44jkggE9MzyJPP9xb
yvqkqyrcKIEUCGSdMJLxXFTiT1N3cfWPN2/kjJ933DZMEHp2L1ytio4p1lionLE7
+KMiDfhfNZabb3w0gy+dU7MI71OnbA==
=aP7c
-----END PGP SIGNATURE-----

--JSSHE0FUht8S9Os8--

