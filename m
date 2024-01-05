Return-Path: <linux-kernel+bounces-18022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6233F825758
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A32D0B21F82
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617B32E832;
	Fri,  5 Jan 2024 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arsegbl6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14462E828;
	Fri,  5 Jan 2024 15:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333D9C433C7;
	Fri,  5 Jan 2024 15:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704470348;
	bh=F2kxE4JGKW+qCcBW5tUptaqFpPukAthh+brPUzfeGP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=arsegbl6RmS8bRMpLJd4lz9n2iMsUUMlVY2uIbdxDr/GImW39gJqU6PRWuiyWu8Cf
	 SBgMV9vzFl/gQVkME/9/ak35oipmW2vn1ab4v+BiD2QoNFl5ipWIGWzyDz2j48DYFr
	 +WG/246JvKEkbzUYb60X/5ZTVaY3g5p+qCvBHqZZnfkvPQ3Yi0Wm2kULD3Hbcl6B+V
	 N4jCg1Lf+G5Pb86qwWaYcAVk2997FHRVyW0NF9hA/QCGMrYjjegQoHsHy7pYarLgsT
	 12stSXH/8YioGJgC3LDNXLHJYbhtiRm1aYbl3l1ps/DtLbCk4kxh3WM/MkhjME+JNp
	 AVbITOKNzfIyg==
Date: Fri, 5 Jan 2024 15:59:04 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: make spi_bus_type const
Message-ID: <a58e56bf-22e6-48b6-a70a-2acd3e6a482d@sirena.org.uk>
References: <2024010549-erasure-swoop-1cc6@gregkh>
 <0fcee73a-bdcb-41d5-b6e5-21947ae9e3d7@sirena.org.uk>
 <2024010554-unreached-colony-96dd@gregkh>
 <50ecc7bb-50ac-4846-8a6e-fad9148c948f@sirena.org.uk>
 <2024010511-wrongness-ashes-f540@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SKHNWc4iOrwyyFct"
Content-Disposition: inline
In-Reply-To: <2024010511-wrongness-ashes-f540@gregkh>
X-Cookie: Your step will soil many countries.


--SKHNWc4iOrwyyFct
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 05, 2024 at 04:51:04PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Jan 05, 2024 at 03:45:37PM +0000, Mark Brown wrote:

> > so not actually a core thing, I have to confess I didn't notice where
> > the assignment was when I glanced at the errors.

> Ah, missed that, as it was handled by this commit for the i2c tree:
> 	https://lore.kernel.org/all/2023121942-jumble-unethical-3163@gregkh/

> So just hold off on this until after 6.8-rc1 is out, or I can wait until
> then as well if you ack it and take it through my tree.

It's OK - I can just drop it in my queue for applying after -rc1.

--SKHNWc4iOrwyyFct
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWYJ0cACgkQJNaLcl1U
h9CluQf9ElrFC4CkGIirJZXjX16TDF+9kzTpBFF+Fj81Pw11VV2Dut33vLdy/nDF
D0/GvitzhQkPARqhjV5cJb+lF6tOPrNIXYQO1TXw13UPF5su+5reTS/s0BpfLXVK
xmuGJOaPtGTiQOvBrFoonM6k7LikfwFOFF+vTijdrrA3x+Rqg+saj8gnUfZZoutB
qms5zNTgnYnc7+QB11GVY3aZlFhZUpd5XFqimfgMwnz62ODs1WkmPN05ljbMDio9
36ARGy/BoTMN4rLsGhE/e/g5CO7SqQNtRHHnq0JmPp2o9o3pKt/bsxvwnWIW7JZ1
L9qVcBiODCDlACHE3z+hJSkGKVGT/g==
=UQhW
-----END PGP SIGNATURE-----

--SKHNWc4iOrwyyFct--

