Return-Path: <linux-kernel+bounces-55251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3602684B9BE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF171C2129C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472BD133435;
	Tue,  6 Feb 2024 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pI3rU8dP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7866B13248D;
	Tue,  6 Feb 2024 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233753; cv=none; b=axHP9yf+U3fb6ETxYBCT/KdBjw4KIXqiih5U01KaquuY20XGIFebmkAlZvhtUvT97NTGJS43Xa0MBBnopc+Gp+RHwSMKnxNazDtFh792MZtCa74Dlciqa0ceAsz/AHD5tNsA6QWvGRAEmD8MCPnU7OFLAfqryBQI/jv47lGHTMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233753; c=relaxed/simple;
	bh=0KrNOJDRkbAkqfoLeqFsoZ3vbkqMpEdzLQxX2yRCMKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTW6+zBNDfM0ZiDQuRSkaXVaACJjYnvEXpVVVkHcsvewfKjtwzZbZofEznQZTVezm2G+Cqoi6FLRJakkm3Etr2dKw7ZygHmu0Dpm9AEjva3GRWGPT0KVnZGPE1M2x9Noobc3qpdwiq7/lXC1BvlwjatyTyol/6jSQlXrTDjoXq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pI3rU8dP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF15C433F1;
	Tue,  6 Feb 2024 15:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707233752;
	bh=0KrNOJDRkbAkqfoLeqFsoZ3vbkqMpEdzLQxX2yRCMKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pI3rU8dP8jGv4mglg2ZRcQgvLeRGuGWK5Ol1WAR+e4Qxp/s+JH8+eIiO96st/TdKL
	 Ktpw/Rm57jiMWOGMlQxkgvZGe4z720CcmyFUINO1aJgBXlQrzFf3iUsW6yed6HYMY/
	 +p9KiyFh5LrAUh1WoV1j8FsLvmj66YXmisPTIaVpx5TplXfRjQw+0EFWgErbQ6uvsN
	 Q9nnenuzaUugiL2Pf5v2mzXoIH6W2rYJmitaO5hWQJJRx4mLqtw/KRFb/dCFq+RWJq
	 QkSPhMGTuBP79P49B7pBZIP3pv45Vio4vvK5DHnEDc3XRMOy32ZEbDjkJCnkMcq+oA
	 KQfvFlv3LTomw==
Date: Tue, 6 Feb 2024 15:35:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Kaehlcke <mka@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 6/7] ASoC: dt-bindings: xmos,xvf3500: add XMOS XVF3500
 voice processor
Message-ID: <ZcJR0LrwaS5GAf5h@finisterre.sirena.org.uk>
References: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
 <20240206-onboard_xvf3500-v3-6-f85b04116688@wolfvision.net>
 <ZcJDFi+iIQOWzgYw@finisterre.sirena.org.uk>
 <7b472cb2-6658-446a-ae47-411d08798cca@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yHkGcuLiRp18RW+b"
Content-Disposition: inline
In-Reply-To: <7b472cb2-6658-446a-ae47-411d08798cca@wolfvision.net>
X-Cookie: You might have mail.


--yHkGcuLiRp18RW+b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, 2024 at 04:05:15PM +0100, Javier Carrasco wrote:

> The names in the datasheet are vdd for the 1V0 supply and vddio for the
> 3V3 supply. I named the latter vdd2 instead because this device does not
> have its own driver and instead it uses the onboard_usb_hub generic
> driver, where the supplies are named vdd and vdd2.

> Those are the names used for devm_regulator_bulk_get(). Is that not the
> right way to match them?

The binding should really use vddio instead of vdd2 but if that's an
existing binding then it gets more annoying, probably that existing
binding is wrong too since vddio does sound like an entirely plausible
standard name for a 3.3V supply. :/  At the very least the binding
should document the weird mapping, though ideally the driver would be
tought to request names matching the datasheet if the compatible is the
one for this device.  Doing the better naming might be too much hassle
though.

--yHkGcuLiRp18RW+b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXCUcsACgkQJNaLcl1U
h9DpOQf/e2VJ3sICtCkXqELdceSjZb2aBilKyDRW+yrS9zM+XjePLiGl0BCmvQCo
9xKfaleXD/fevcqAQKlB1JelXF2reqrMZ6zG0eFPXXXEPsLuCj5eHgGrP3hnRrTK
Y8r3GXf5L7FdtB4hm3IOZu+1tEKOhJCAGpSEXgKsSheE0sTCDl7OzE6mwDJCRAR5
1Ewbd9va+gUBu9y8k7UjWvqDvRX0uxmxw3Ducq7QM74MjysXrwBIwk0Fz3WOqUUK
VxMDwpa7jySK0g9bisyhlZxnTtO9nKyOfAB+4IbiaECQ1yW/5TeJvD04kh9fgdts
it0qrPmYBtvT5+nR/fdydnBAe4YEUA==
=CAS2
-----END PGP SIGNATURE-----

--yHkGcuLiRp18RW+b--

