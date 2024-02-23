Return-Path: <linux-kernel+bounces-78757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 094AE861866
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA211C23126
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBF61272C5;
	Fri, 23 Feb 2024 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1OIUjnn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED55482D8E;
	Fri, 23 Feb 2024 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706853; cv=none; b=OMYZBVI8T/TfxkfPDG4zVxwx9bJO+1IIMcRPSQsGfQgcnpyYumxAC5wJWIggUMt8o+cGyBzyjJ+w1FuazC3u5kRmBDAkn2+uJomGZeZBDTEpTa5q0Eww4H8rvu2CbkCIPtkZ6NdOB40vuBAWDUuMJssJwrwJp6eiYF09Q06scSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706853; c=relaxed/simple;
	bh=wsLHvynhU6z1GefHwQExyJOvrdLzMQ/mqdXsNft5llk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEo5KFWspeLn+kdSItbYszvQ9tHKd+vpgwp1p1eJE5qIg7RuwBODfI3dMVUjfMtvN0LEl8TmLfw3XPDgBAeEQNRVnm9TLUxxuGbcJlvsOrk+0sc/d8PncUPjFjc+mSCC74i4mUq1Is9NsU+rKdBCKNy0WTrR+FY7Q2LNNC1vYzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1OIUjnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF91DC433C7;
	Fri, 23 Feb 2024 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708706852;
	bh=wsLHvynhU6z1GefHwQExyJOvrdLzMQ/mqdXsNft5llk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k1OIUjnnzR3bcdJrhXjHDcRKbVeXEG/hqgEpXErt+sGy0AG9+VOW9QUb7IRibNB2v
	 8owmndFnwuMOOB9HhbCSPZISsq+xIU89/thAZO8w4+IxML1KdI2Q0fPJIOnGFxmeDR
	 GOVYuiwQAfr6+0GQ8kSLfS4xT+cja2xNGrqvAYkuMREqH8QpipISNzbqlL3Cre+X1c
	 821O6ZjngP+7EYqyClS+/e2w64YYEaj3uiK3dGotwcJtiwcfEL9oM4BYHzUao7rDM0
	 YxzYTVuhblDwUPBBY3jtgC6KpJudnkH7IJrAouup3wm7RxbIFA3n7WNpBceDMf0ljO
	 8VQGPKXPumGNg==
Date: Fri, 23 Feb 2024 16:47:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: tiwai@suse.com, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v2 6/6] ASoC: cs-amp-lib: Add KUnit test for calibration
 helpers
Message-ID: <ZdjMIVYp7Qb/Tt9d@finisterre.sirena.org.uk>
References: <20240223153910.2063698-1-rf@opensource.cirrus.com>
 <20240223153910.2063698-7-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+NiID9uOcNnKcD/H"
Content-Disposition: inline
In-Reply-To: <20240223153910.2063698-7-rf@opensource.cirrus.com>
X-Cookie: You might have mail.


--+NiID9uOcNnKcD/H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 23, 2024 at 03:39:10PM +0000, Richard Fitzgerald wrote:

> +config SND_SOC_CS_AMP_LIB_TEST
> +	tristate "KUnit test for Cirrus Logic cs-amp-lib"
> +	depends on ACPI || COMPILE_TEST || KUNIT

Should this not depend unconditionally on KUNIT rather than KUNIT or
some other stuff?  ie

	depends on ACPI || COMPILE_TEST
	depends on KUNIT

or equivalent.

> +#define TYPESAFE_ACTIVATE_STATIC_STUB_PTR(test, fn_ptr, replacement_fn)		\
> +	do {									\
> +		typecheck_fn(typeof(fn_ptr), replacement_fn);			\
> +		__kunit_activate_static_stub(test, fn_ptr, replacement_fn);	\
> +	} while (0)

Should this be somewhere more generic in the kunit headers?

--+NiID9uOcNnKcD/H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXYzCAACgkQJNaLcl1U
h9AdaAf/Vs9JrSrEhXziKNX6iqehN1Sj3RcplxRM30tl9i3P1mw5PLxE07esKYUj
hHzcS+MzZt3Jo30134eXcbH4IwAQW5KwQoGlaAaqSmZq57heZrFmAkxYzyHjmO3Q
PYD4gmPiKY6suY1M8Hc2x+MbJzKGXLutlIUnUlyfZFJNRK9vuEUr1jdsfIOVd8AP
fjE6pUBRi79IKlNBDur55KdFgzt9q9J+x6uDWOz1GizJbNWrd8z9BjRcXJtVnLMY
xobl/4INIePPiblwq3X8d46UUez1xmo/XgoXEYKelQlt6E+dmGO90/cp3bokDUw5
Wl3swEjTyJThlczRmjZitXH7JqCUUw==
=uxPg
-----END PGP SIGNATURE-----

--+NiID9uOcNnKcD/H--

