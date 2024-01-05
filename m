Return-Path: <linux-kernel+bounces-17974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE7882562E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3ABF1C23350
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3D32E3EF;
	Fri,  5 Jan 2024 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJFdOn+I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1E22E3E5;
	Fri,  5 Jan 2024 14:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B76C433C8;
	Fri,  5 Jan 2024 14:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704466505;
	bh=lGUdel1pSqfVSSsk+jkeamuY2dz/AgFfW/Up5Y3jyyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJFdOn+INyNtgXvtGywabad049FU0N2AFPiP/S9/QDeKPUFSx0qJYVWxJUx8JP7LH
	 fjFXcHbY3A2zTCxYalisD11ATWbAjkteOdTf0b7dU3HiqxmiB3mAeBpy9AwhA6lDPA
	 rdEtx0TVFHv4j3wxX0jiot75Hbc4bEvCQtJPMkZ4aiSwUT4t7bIMr+HVVH/iQ7whSU
	 2I6tSkXzbo4MYsm3f/Pt+65FOBZrP/hAsF49HxKYCl9ZATpYO69aA8UCs/8QiwyDfN
	 ZIqafqweomkgUK3/0JqrgdauZBACuCdbosWcLQiMqxp1k/iOQJU44MOTBhmoWW1pCA
	 q7XiOB30rQl/g==
Date: Fri, 5 Jan 2024 14:55:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: make spi_bus_type const
Message-ID: <0fcee73a-bdcb-41d5-b6e5-21947ae9e3d7@sirena.org.uk>
References: <2024010549-erasure-swoop-1cc6@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G6vr2r0iBS5VvrxZ"
Content-Disposition: inline
In-Reply-To: <2024010549-erasure-swoop-1cc6@gregkh>
X-Cookie: Your step will soil many countries.


--G6vr2r0iBS5VvrxZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 05, 2024 at 11:32:50AM +0100, Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the spi_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.

Whatever makes the driver core able to handle this doesn't seem to be in
mainline yet - what's the story there?

--G6vr2r0iBS5VvrxZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWYGEQACgkQJNaLcl1U
h9B/wgf/Q1ndw+LG2G204dk6f7CZL+mu1YHZcGuXF/e9pjk8yt4EutHo2sZwVmM/
4rcZTDNzPvQ3siPIJWup9b1gOy9dQ8TlTqOsb5ndoI5kSxu5zHE0v8MFGq1YzV6Q
wi1Wp98J4Kyv6dhBeIudZH8tbv3wthEy06D6cJvcBDOEvBiJdnYSwXYHM+ySZ+Nn
c4l5FPMCCPbBDborTewwnojkwmy1oAXj35QFNrBbhbM3F0rqWuB6EgzgC55jfdja
5Z+STMHmJFU7Q97HVQP5/MK+IR3/wUvYQtOEjA++zniUxJVfHxo4a7hOXuLWQ6ZL
RiGtRBeKIg1uQjfFcShh5j2p2O2Qew==
=9kv/
-----END PGP SIGNATURE-----

--G6vr2r0iBS5VvrxZ--

