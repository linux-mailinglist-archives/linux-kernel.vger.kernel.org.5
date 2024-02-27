Return-Path: <linux-kernel+bounces-83217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFABD869061
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08B41C21C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFD513A886;
	Tue, 27 Feb 2024 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q96w8Ear"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE8113A871;
	Tue, 27 Feb 2024 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036630; cv=none; b=r7jFDEJXo8moz4HS4ZLUi5LvlrP3L+YjVdYRJeD6V9jpnOshlfiGbHo4PDo31OM3H+hQtMUlC6tGCDNLci/ZDlabikiYBmV+kQVio6NGTzj2x0V8WjfCpH6EG6lOxZaZQo7y4FfR38r4+Qi3bMOM/MlQr6HR/Fmtqw1F8x32pQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036630; c=relaxed/simple;
	bh=L9JTm5Lf0SsIjWJTBYD0q8VS3/2tTfKG67hVf6QapvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8PE4++OapSig+3R3r3FZ8o8ibFeGFv/fleDMuH5tpmeOTkYmkpBP34wra5VWgH4sq3VSdDKFtjd8+1Oho5qsAQLRzQetD3QPqMNbd3mo/RVch2aaxTrHzZDbjOA+hcPvZ6aRA3TAtMzSoPlrv8RSCynzOH9Hm0CT6AlLBI5d0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q96w8Ear; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C508C433C7;
	Tue, 27 Feb 2024 12:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709036630;
	bh=L9JTm5Lf0SsIjWJTBYD0q8VS3/2tTfKG67hVf6QapvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q96w8EarfdTw7Nn+uHmL70OQwA82vbyGIVfWY4X8YPXtGWtPWojtkjkGECQ/2HYm9
	 FzVSdhXo02JoOcetHDnYBi7im+lEcRMYW7i/Bx51rbp1HV+qTRoaikuZfbqZ1DyixM
	 eCyj+mVyPXSIm4osBiZlrtr4osJe0ENEPafQBP1IZpWXFTtTEfm4nbp79gLN+mx0F/
	 0GdFJdS/QgBIfdKyUdyGDBCZIJWSiAp9/OvJ9dGlPOzELuGcnUQJc9p+eTLXLKc8s7
	 5hdoCoLk+gew1iTcCsegMI53ez/CoSsnNBYe34z94/wDMo/FfHPZ+U0wdDqJmVyZoh
	 xwAEhABkzPerQ==
Date: Tue, 27 Feb 2024 12:23:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, kernel test robot <lkp@intel.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	kernel@pengutronix.de,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 2/3] spi: ppc4xx: Fix fallout from rename in struct
 spi_bitbang
Message-ID: <e09007e4-f7eb-401b-8106-2282e73d2de6@sirena.org.uk>
References: <20240210164006.208149-5-u.kleine-koenig@pengutronix.de>
 <20240210164006.208149-7-u.kleine-koenig@pengutronix.de>
 <y2my7hxrpnwg72ols6a5w7n6zqz2yaxtswq4zlv6xpguiyaunm@tguc7ua3ypa5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CwjuQbiwYGwivzwL"
Content-Disposition: inline
In-Reply-To: <y2my7hxrpnwg72ols6a5w7n6zqz2yaxtswq4zlv6xpguiyaunm@tguc7ua3ypa5>
X-Cookie: Please go away.


--CwjuQbiwYGwivzwL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 08:23:06AM +0100, Uwe Kleine-K=F6nig wrote:

> If you're interested to prevent such problems in the future, there is a
> tool in https://github.com/krzk/tools that can catch this type of
> problem:

These tools are *far* too finicky about the precise formatting of the
fixes line already, I do actually run them but routinely have to turn
them off since they're just causing noise.

--CwjuQbiwYGwivzwL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXd1FAACgkQJNaLcl1U
h9ABrQf/dyIlXOvOb6gFDRAjhr9ToQp4Ksy66FL0jL3Ahm0Akk5p0U2e0thX7ANW
3UFXVWSsK+JWhDUjQLrpCyUdAZUxshwlzHttOULZowVXjmEaLb7LcQbEeXQZoZqe
zK14fySMQVqLtY87oI0pr610cbvVv01WwX3H0e8CiroyN3si5uclYT6ONHT5ycqa
j0/mfdn3G7Wt309ylk6leVX3+QSmSc27w/YzBUUzuk5UukJc6/IF0PNUeI6+H78O
LfBKbbU2x2p/tDKLeJODArElaW7VMzyPrvtdqAt6ZgS0Vo7VG7qg5I1BPUT9grSK
VXAmFH4St8z9mQvKDmrxKUCdVSNExA==
=ppoI
-----END PGP SIGNATURE-----

--CwjuQbiwYGwivzwL--

