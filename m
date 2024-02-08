Return-Path: <linux-kernel+bounces-58205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D96F84E2B8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8DC1C29930
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2418877F0A;
	Thu,  8 Feb 2024 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXP0hne3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABF8763E8;
	Thu,  8 Feb 2024 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400795; cv=none; b=EOOwS9wqZS0LTDGUpRQkqZrbnXZpmb235cy8rw0r6dfMjU/rKfVZSHl7NxzYKjNd9O0KzGLK6haGfynRzrgvOWZ7GPnx9IzwAlTVT1uWyFoOEUmT61I3prrc8QTMFW1AS92xciD4R1eYzQvBW6PMs1pQi/FkC996o9nuYwz4/o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400795; c=relaxed/simple;
	bh=SFycL/QTbxXtHffCvIqzQJ022IjZq/ABMVUAlWStI4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQWuIz7rtMNR2S/xyzx7Hbgmu0RY+jYd1o2KiJxIaApHP5XqQp+eKvlX7Nxt5gpGSrajZkOiGA9tBouYJwXVdPTdwePqGU+VTX5Z9WvOpCW0ggSuO+zRD1CkaiDZlGMRPxKRb+KXnUdrYa/7Ijlmfro1h7Uwa00WHbDUcqx0Eds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXP0hne3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94027C433F1;
	Thu,  8 Feb 2024 13:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707400794;
	bh=SFycL/QTbxXtHffCvIqzQJ022IjZq/ABMVUAlWStI4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lXP0hne3lZHEUhqCvVcQwFvKcUTrsiEwDHRGfgBur5BCAZI8Xeh7r5Tu/lYLz6MwV
	 fNvBIae+pYlGFPyohdxNBJ9Pdmj6KJtgbu9s9lUnxLkAjLeclQpuloZfXwxZFFFirQ
	 Ga24+RCb8UbS7rvmeAoKfVDKvG/t4t8TFHbR73FdYB+Ujh1g9JHYxKVbtH7Z9jR5oo
	 Y3pCn3ooa62mI3SUgZGeC2OrdLpMoBP5pIAm+RzIdPbPIdikzpaXmDmggsq6sgLAq6
	 CbA/Bl3vFw5MeQXWv7vQTz9sG1q3fJIbYMlRShrcLRvxkjAOwDQirmBwuijSRFUxRA
	 dtklbmaVmrlkg==
Date: Thu, 8 Feb 2024 13:59:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	andy.shevchenko@gmail.com, patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: (subset) [PATCH v4 1/6] spi: cs42l43: Tidy up header includes
Message-ID: <ZcTeV9SAnaFkKN7T@finisterre.sirena.org.uk>
References: <20240129152557.3221212-1-ckeepax@opensource.cirrus.com>
 <170738736196.904064.7729211182384063971.b4-ty@kernel.org>
 <ZcTYift6P9KkiI7g@ediswmail9.ad.cirrus.com>
 <20240208135711.GO689448@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fZFK9MYKSxOUAeQV"
Content-Disposition: inline
In-Reply-To: <20240208135711.GO689448@google.com>
X-Cookie: You might have mail.


--fZFK9MYKSxOUAeQV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 08, 2024 at 01:57:11PM +0000, Lee Jones wrote:
> On Thu, 08 Feb 2024, Charles Keepax wrote:

> > The SPI one needs to be applied along with these, otherwise
> > this will cause build breakage in the SPI driver.

> Okay.

> Mark, can I just take it without sending a PR?

Sure.

--fZFK9MYKSxOUAeQV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXE3lYACgkQJNaLcl1U
h9Bobgf/YycpVNmrAzh9rxprC5HBFODlWTYA2sHhZxugEV2W8A2rGA5c8Xd3uSin
0pJD4DHVQBPCrTk0yjWPSdTGSg9Uv5EiCfKCVK/YdpoSV589GhT3fz+LV/AqCKPa
LiAko83xNYpGi6royUp51s5X/rgU0M0tO8EU1VnC7b0R8FZ6+9ANR3LJrqPZAxzo
HkjP4mY4xyXtlH+c2OswI9kPGE1BztNuyWGkVjE/6zGxS09PhpovVBAQyYb6YALr
/72IhksTqanvx2Sg2jqvqaJ1Nw/0e/+C96RLQVNiDk4dbC5GV/APjx7dIgm+yMP4
Cp/wYzl7fXB7NczBu0o90Mj8P7oYPQ==
=J5mt
-----END PGP SIGNATURE-----

--fZFK9MYKSxOUAeQV--

