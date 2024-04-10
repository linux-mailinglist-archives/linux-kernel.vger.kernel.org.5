Return-Path: <linux-kernel+bounces-139290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 100A88A0102
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5868A284F33
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA5B181B91;
	Wed, 10 Apr 2024 20:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPBFLpRp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E7A172BBA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712779522; cv=none; b=bGraMeaJFEurpr/LsKi+JiVY/h32np6PYvOgUotxzkrBNJcY81yDqG8PCyxlrDKUfKYUglqp9YTJ9k9fYcDybMYdX1Q3gOJjaPPBcL5AbCP9LpuNi8VGR6pIzLicj4Qa+DcaMhxHK+fu97Dh6h5hWkvrQP4WT/riFrpheOhWpIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712779522; c=relaxed/simple;
	bh=HtOjRTFnaz26fS+ON3jzDj3B+ISIIl1BDutglNGdAQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzSR+3motwMvjnqmBdlW9G2kVpEC4ULGYfNhuvvAkyAUsl+wWfm7zQfjXqxYF+0hIkUYaSmrHL/YiVIRLmhRHuIyIKuBhHl7zYGg+B6YaR+VSfVmDkiW6G5a2rVbRgLd6tUMKQAQLCeCRWBb3oxuruFmbQR6dFiJQ1Ki8oZY6oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPBFLpRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E10C433C7;
	Wed, 10 Apr 2024 20:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712779521;
	bh=HtOjRTFnaz26fS+ON3jzDj3B+ISIIl1BDutglNGdAQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BPBFLpRpvIB3Cv0gp3JATKs91bzqwti+FmHu+BhAoBmWsmYJRACrikJUHxeTl0zSk
	 OXSJyODGRyu8ZnsvI9dlO302Qlc86+FupRcNWRA/5gs7WUulHTOzRJnvyLzZniEiKt
	 w/thTtD8l7xiObpr+bhXIyMm6GUu6Ls9Y7IscAI8zUkwn4eG+DhtplTyHuKmISatnz
	 /aIl7fE6T8loLE+0KlUI+7m3QTGm18HG+0H/GPJnmwW/qAbChfQXK+3MHY4qJAspGd
	 pXMHPfKNlfs4vxO3jH6ol87It2/tdjqeVlUaT4NXo/k+WtJD+B34OukRq+Tvj06ASq
	 Evso7ljIXslqQ==
Date: Wed, 10 Apr 2024 21:05:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] regmap: spi: Add missing MODULE_DESCRIPTION()
Message-ID: <3602aa7a-15c9-4e77-8aa9-a12f2136530c@sirena.org.uk>
References: <20240410200031.1656581-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OU8IfvZE8K9ydUv1"
Content-Disposition: inline
In-Reply-To: <20240410200031.1656581-1-andriy.shevchenko@linux.intel.com>
X-Cookie: A bachelor is an unaltared male.


--OU8IfvZE8K9ydUv1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 10, 2024 at 11:00:31PM +0300, Andy Shevchenko wrote:

> +MODULE_DESCRIPTION("Regmap SPI Module");

regmap.

--OU8IfvZE8K9ydUv1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYW8P0ACgkQJNaLcl1U
h9DhUQf+JXttkcilGp+fb0Y3VwXn16GNGpIQ/RzCeOopqrk7sGyE/tlRyIaO1BiG
uOMp5qPoxKZhn1AFvSa0UklvJN33NDC/Y0IjyDJ34DPq6WdvmOBvjz5beiiFKL9H
vv/fg5k0/f940asX0mv9YDZz8I4NYemcucKnXaoxr8TNZP77zlXz0TZom3U9HEvm
9eYghYomYcHFmo8batjImF1J5pkTSExWsS6rwy1giRPJAsekdB/ypBkuGB2FAZNi
QFbhDh93Jr4q9/gTqn4LIjY5IarNJLHXoLSKtz1BEwfI6a82ZiXeOfFxiGRva8rN
Tw1oVLUZOU6xGGOQkVQjKnmPHaKnDw==
=YnG+
-----END PGP SIGNATURE-----

--OU8IfvZE8K9ydUv1--

