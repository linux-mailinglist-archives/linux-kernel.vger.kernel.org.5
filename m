Return-Path: <linux-kernel+bounces-149363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C04D88A9018
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C761C2102F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D754C99;
	Thu, 18 Apr 2024 00:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plN4Fvkg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C58A628;
	Thu, 18 Apr 2024 00:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713400690; cv=none; b=GHN3e81eDXo0McVsgV/WjMuj31eRTLJlr79DymiivmqeRwETfWYnGQst9bkCEtRQaCdmwO1dDPIuulKkO853fEo5a/Achm7P2ayv1PGMBj3KRtvpr+Rkc9kBSoGBnaeHpBBpimrBYUgbf0Wiq3UaI3wKowRS/x/64LhMw8RB5SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713400690; c=relaxed/simple;
	bh=EWWSe6x4qhSDklZv8YTkkIt93xdetH43wC9mZrPXeQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5mO8a54EVWGxTKRNOSld9AB/6A2jRwaI90tKbim/hXvaOV1Pk1pYQNdo4UpcUBPq4+1Khq+tGXJn+fI0M/kQH675DP+Iu5LQKGWOEArMUNRTodpwMopuMTTovgbzvPfvqkNGy8pIAxnuowSkxRYe8kh9sMYbn0griqRxNXPBa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plN4Fvkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A37DC072AA;
	Thu, 18 Apr 2024 00:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713400689;
	bh=EWWSe6x4qhSDklZv8YTkkIt93xdetH43wC9mZrPXeQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=plN4FvkgAq4UvhaDEv+dsWthNazEOjQckDCKYogPLvbIL+s6RO/YmeNyY3gJ0w6g/
	 l4cHljJX1nh/yh2f/Gff7vkj3YHNP7fAb0TnTjrJ8CfXgiPV0dqm+3Blb+sqWnb+GQ
	 7yL9VxTU3EeSBZNbraHNbtrB5OEdJ4/MJEOgMGZAqiesBqF6ZC+7JgMouo2tx5CXoQ
	 V+rXcVc8s9jOBaf7tJhfNbi98pyPlOfJnt5tIIhjSR4q5lTsDfkqO7As9Gb5sNhbt2
	 nXaKo9Bjhh25bCD6/O0JebQM8Kq744vc43UxjWBk97kI+SSLdiPiWNxvg87pIvFWtz
	 BDS0Cv0vaO28Q==
Date: Thu, 18 Apr 2024 09:38:06 +0900
From: Mark Brown <broonie@kernel.org>
To: Fabio Aiuto <fabio.aiuto@engicam.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: Re: [PATCH 2/4] regulator: dt-bindings: pca9450: add pca9451a support
Message-ID: <ZiBrbghc510G02tx@finisterre.sirena.org.uk>
References: <20240417153528.7838-1-fabio.aiuto@engicam.com>
 <20240417153528.7838-3-fabio.aiuto@engicam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1K8DqkjjS4/eYr78"
Content-Disposition: inline
In-Reply-To: <20240417153528.7838-3-fabio.aiuto@engicam.com>
X-Cookie: To the landlord belongs the doorknobs.


--1K8DqkjjS4/eYr78
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 17, 2024 at 05:35:26PM +0200, Fabio Aiuto wrote:
> Update bindings for pca9451a support.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--1K8DqkjjS4/eYr78
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYga20ACgkQJNaLcl1U
h9D6RAf+N4RZNwSw3Wma2095eiTrwMaGS0mna3eIDZ8cNN3b759Cmmnl5Gmmxf/7
cnqaM7Hwjto3/Q58bi+FkwhdnT2+IDHrMSnpO5Ib7kIsApncwrDOzV6+78FxynT3
qEGLUUwE6XNi55rfPJWbFSI/bcGuHX93CSTFyYVKrm8p7PP8GLO7HcYN5z/1x5sq
U6jcRikwKckc5BLYi6GtfGryWnd8taqZL7cKH1f8nIo6XPklelelkjg3sc38IPZi
yF9iEXaozRF5bQZreeUTrExqiE8pEhZcTFw+3cgG85oUDuCSqtM5OIwolAmlS2RS
gWFCdIFpi9GwRDIddrCGP47QWpSJjA==
=ZkrE
-----END PGP SIGNATURE-----

--1K8DqkjjS4/eYr78--

