Return-Path: <linux-kernel+bounces-143329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE758A3747
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5551C23148
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C20114EC4E;
	Fri, 12 Apr 2024 20:49:44 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E11E14A600
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954983; cv=none; b=kNitw2CGRHzyJtjYYEeU/Yb72RmXUFzCldp0CXt3slQ/z3saZ7zzETKjzE9IFWqYo1Q1wxdwe1Y7Z9vqZATLCouwGLrZqvF3huN8HcqnND0W5M2UGC1/ids4RKWCzwDH0LHtymBJ6QvjkLdIKrRk8yGsdWhvTnief2DPOpRPLAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954983; c=relaxed/simple;
	bh=qHPCMth1Dk6Js73rTbBzK82G3+seRbaXOvlWBerU8Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwRZv24IgYS6GE9tmMTUvOmbiEOiipefxlLwqsniWvOMCBZrKfH8RId5l1vVthagWMiAzVhmSpn8Svogu4q67VjPXPoZ2NzYmoqEroEjbr9C13XOX3m1ukQ5SbkOe1a399QvtHsxuWWV5zfbb9IRbdaC9ehH6v0IeJxd3PSosdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvNq4-0002W0-2n; Fri, 12 Apr 2024 22:49:36 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvNq3-00BwMt-C7; Fri, 12 Apr 2024 22:49:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvNq3-000NRt-0w;
	Fri, 12 Apr 2024 22:49:35 +0200
Date: Fri, 12 Apr 2024 22:49:35 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Russell King <rmk+kernel@armlinux.org.uk>, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] clk: Provide !COMMON_CLK dummy for
 devm_clk_rate_exclusive_get()
Message-ID: <xfaf22rf6gnrxpinkciybsyk4dx2bfqgozv6udwymegtcgd26i@jq5be7fm5lhi>
References: <202403270305.ydvX9xq1-lkp@intel.com>
 <20240327073310.520950-2-u.kleine-koenig@pengutronix.de>
 <d95554f623f023a2f5499fa2f6f76567.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tcm26yzrf676zf3u"
Content-Disposition: inline
In-Reply-To: <d95554f623f023a2f5499fa2f6f76567.sboyd@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--tcm26yzrf676zf3u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Stephen,

On Thu, Mar 28, 2024 at 03:35:57PM -0700, Stephen Boyd wrote:
> Quoting Uwe Kleine-K=F6nig (2024-03-27 00:33:10)
> > To be able to compile drivers using devm_clk_rate_exclusive_get() also
> > on platforms without the common clk framework, add a dummy
> > implementation that does the same as clk_rate_exclusive_get() in that
> > case (i.e. nothing).
> >=20
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202403270305.ydvX9xq1-lkp=
@intel.com/
> > Fixes: b0cde62e4c54 ("clk: Add a devm variant of clk_rate_exclusive_get=
()")
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
>=20
> Applied to clk-fixes

I assume that means it will be sent to Linus before 6.9? That would be
great because I want to make use of this function in some drivers and
the build bots nag about my for-next branch that in some configurations
this function is missing.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tcm26yzrf676zf3u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYZnl4ACgkQj4D7WH0S
/k4bhAf/dU3dIH1rQHO52ZY4eCb6/UQ6pdDM8CzZxB2oGa60PXugNfbK5LqTCNEB
q5FVGKRHe+lbUG2Dk4belrX3ZNMXweqywtHu0bXbPZZjPjCvrYmCdRJKuHLSQgRV
5gHxyFQshzOr49JHsWieLVj7le4bAHBbgF9r/a2gcWUsS4xOAaNNCzgPb8fR7nzX
pcbXThX4rhn9kP65ZokC2sEJyobMFNCrTewaOXP6UNaSUt/M/qTnsgDhxMa7ywPi
4deahcIXXS5ZKj2ICyz08cNryUnJVA+bhYNvzi7zP51TvNynLcwYfdkF+n5T5Gin
aUgbiu3Sm38THO0Eiw5M+GgIUfYj0A==
=/h7x
-----END PGP SIGNATURE-----

--tcm26yzrf676zf3u--

