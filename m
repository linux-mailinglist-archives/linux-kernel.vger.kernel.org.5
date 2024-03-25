Return-Path: <linux-kernel+bounces-117206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C2588A8A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BA31F67421
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D48146016;
	Mon, 25 Mar 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOTzcdvu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12568144D29;
	Mon, 25 Mar 2024 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375733; cv=none; b=EF86jAMCRyXbIQpB9NxAbndJO+LTqX6jsvNV0XUSr20N+yaZJ/EPk+hQUNmotz5+ttsSDXYeoP6dbH8fOokXky1KPvVjZrpPLI2u5f9+xr1yPlx7TUBkxJvH2QuHiUozDPX1i+1lAN0X3UpHKNX2OriYwngDT7CbC27t+OMEpxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375733; c=relaxed/simple;
	bh=v77K2lXCAffaMNsAT9TfKHWPDHhZTtkwYbbgpXH3MNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klEVPSxKi5XedjIV5bQu9xUo65pJr4STeKLpGY4BCtTpG1f1vrf6+B5+G9wPIbvDmIQFAqACMoargxVPuZO9B8WqD7Ip75DAWhJJvr2KTpXRarmDsTh1MayjoJ2bXuxITdnND8bUO9tmQKEZtlQS202XrXJqQmxJxE7+dTdZT64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOTzcdvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC103C433C7;
	Mon, 25 Mar 2024 14:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711375732;
	bh=v77K2lXCAffaMNsAT9TfKHWPDHhZTtkwYbbgpXH3MNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hOTzcdvuzEQbUyKqPngIrTSSaxzjhmCgTRw715aFVrTUhhI3tpue6Ntodf9E77lPQ
	 jVSfIJ3nUhOqpQYoIy8LcXfEjRvk8pEMcPBukIEHDqb5s85enMZptO8RwKWhO7jsZ+
	 T0PgtsMn6CGcwZ38cTt9342eD+MQQCHOMDEHCt/3TahsldVPl+kxRPrjSi5GOZ40e0
	 KnivdXGE3PMp9Z/wRPfMd/arg+u+FDCAS2W0JpTNXKoZF6EcXcBGOk+lo/b2CAVJ7p
	 gsPv+8xRJzlm7gM929L67DEfGsFKFKbTz1iQv8fn0/nbxoJjZgx/1klQQydbewQyqG
	 SAXMdt36YZpUA==
Date: Mon, 25 Mar 2024 14:08:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: rspi: Get rid of unused struct rspi_plat_data
Message-ID: <8c75da02-ff4c-4a31-93ae-7b55d16e1bf8@sirena.org.uk>
References: <20240307155045.3796045-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zT+t8iy7V+f39IXG"
Content-Disposition: inline
In-Reply-To: <20240307155045.3796045-1-andriy.shevchenko@linux.intel.com>
X-Cookie: This report is filled with omissions.


--zT+t8iy7V+f39IXG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 05:50:45PM +0200, Andy Shevchenko wrote:
> No in-kernel users of struct rspi_plat_data. If required,
> the software nodes should be used for such users. For now
> just get rid of it.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/spi/spi-rspi.c   | 11 +----------
>  include/linux/spi/rspi.h | 18 ------------------

This breaks the build:

/build/stage/linux/drivers/spi/spi-rspi.c:27:10: fatal error: linux/spi/rsp=
i.h: No such file or directory
   27 | #include <linux/spi/rspi.h>
      |          ^~~~~~~~~~~~~~~~~~

--zT+t8iy7V+f39IXG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYBhXAACgkQJNaLcl1U
h9BzhAf/eMt6n0rJgrp1dAwYh6D9LcoV/DHbbI0Ysn/8ChKMNwolhqPpldOGyrBh
prmxAYC8bJR0cY0HjJK43I7JucJcX6G30N6LQokKLnDhEIpI3VhlucmJyZN7C++e
5Mh3lyATeUFqLmnDfsAPOM3sM1A0jVM/NZrD15fQS37wZGlqeEB7PEJUrKuYx6co
5LkkUjQUdAOwqeP5KWvtbwt7QJmMS1d5zSnM3aYs4Wn8FOB6BZ+4B1BPBlHxY6wn
fHIiPYGQfGQKxlYre+CJL/piJH08BZnHVIEOZY8v82QbFc04fDF9Wt+ye9Nd8+hD
UezmJK7vDO86F52eeIglCU9RLKCnMg==
=3lel
-----END PGP SIGNATURE-----

--zT+t8iy7V+f39IXG--

