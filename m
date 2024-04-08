Return-Path: <linux-kernel+bounces-135843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C4389CC00
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE83280E14
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE571448FB;
	Mon,  8 Apr 2024 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPXRMtNI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EACF51B;
	Mon,  8 Apr 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602402; cv=none; b=CgbeNlKLUMl3l1Ny+m8enG5cQdb/H2mnoVFoHpnXdmifMizzvlzT7QqS0/84tLml9zoFgR1bULwoMd85gm7bvumUHmaH8uGFINl5cVVQV9ErmCnrbx2CInqCgOp6RJm8AAwFbD+wcDcBWiDufdbvGoyN8LBsHmnVeN8eMTJWEbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602402; c=relaxed/simple;
	bh=yS6GxyZzqXB2+xOaIOWtiFJnwGVsW8GrqXSYsIS0f/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyK/NIH8MhkUimRdW591P5DSMfIeOtr6I00BK1QqID/MfMejsAWrM2zIKR7Cyu0OUgb4IDUNaalppGOpL9OW91CpIgy1WWfxuK9yDwaKW0WnfAB6QovZ9bgMbXLejfh1XV8EqUOvUyRXY2WvS1gjaZ2+UrSWbSCUPEa50VRP/xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPXRMtNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339BFC43390;
	Mon,  8 Apr 2024 18:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712602401;
	bh=yS6GxyZzqXB2+xOaIOWtiFJnwGVsW8GrqXSYsIS0f/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SPXRMtNIsALYYJhM8h3E4vweAGjKe8MxQZ+iRE6ReyAF+BQ0nbYrjR6r32jDl9k+P
	 TZeuHRAjGFNXHgRa7hyfTtMW0Q0TZt7/uz9M3mC0juDNPxtHgeCCVnhgJAO7CAG0OA
	 z0K4I/vFqZlAwl4N0O489RTdK0H9KauoUJHU4CA2UcQyWd0qQJ29IwVG3cflU/A3n2
	 3N2bKKh1zSFGaXT2+nXt9NiE0KPuHLeG5zj2v2Si9Zn8sVVuaAlZeu6f37Mxean9xG
	 MFKQ9PJayxWDoqBhhpDR2Gr3TN86dK8wvJps/ASKAQo+lyDB73ZMd9Cd9IC5Uk+loy
	 NG0scg4BII4wQ==
Date: Mon, 8 Apr 2024 19:53:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, neil.armstrong@linaro.org,
	lgirdwood@gmail.com, conor+dt@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
	khilman@baylibre.com, martin.blumenstingl@googlemail.com,
	kernel@salutedevices.com, rockosov@gmail.com,
	linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 2/2] ASoC: meson: implement link-name optional
 property in meson card utils
Message-ID: <412306b3-e428-45ac-8bf5-6121f638272d@sirena.org.uk>
References: <20240408164947.30717-1-ddrokosov@salutedevices.com>
 <20240408164947.30717-3-ddrokosov@salutedevices.com>
 <1j1q7fpv1n.fsf@starbuckisacylon.baylibre.com>
 <20240408184041.3jcav5tabxiblpn4@CAB-WSD-L081021>
 <51b39153-d1a4-4e7f-9b30-8c77fc4ee46f@sirena.org.uk>
 <20240408184744.nfktcppdqewurmgg@CAB-WSD-L081021>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HWk5+hm8t/wej2SK"
Content-Disposition: inline
In-Reply-To: <20240408184744.nfktcppdqewurmgg@CAB-WSD-L081021>
X-Cookie: Drive defensively.  Buy a tank.


--HWk5+hm8t/wej2SK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 08, 2024 at 09:47:44PM +0300, Dmitry Rokosov wrote:
> On Mon, Apr 08, 2024 at 07:45:00PM +0100, Mark Brown wrote:

> > I would expect that the place to fix names based on the userspace
> > configuration is in whatever userspace is using to define it's
> > configurations, like a UCM config.

> Honestly, I have tried to find a way to rename the PCM device name or
> mark it in some way (such as using a metainformation tag or any other
> method), but unfortunately, my search has been unsuccessful.

I'd not be at all surprised if there's no such facility yet in whatever
userspace you're using and that it would need implementing, I'm just
saying that that seems like a better place to solve the problem you're
seeing.

--HWk5+hm8t/wej2SK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYUPRoACgkQJNaLcl1U
h9DJUgf+PtNQ01uTKkXCzFIX0QP1JVOK6eTnelaoRvequ7E9jlgWqkpwcmnmHGcG
7JaIcW2gK6BEj0kLODIrk5HrWWvPmPzVkTYOanJ7FWeTtCV8bXJSpU3Y79Ywy5VI
+Z3BPEH11EeIFF0PwWIH4p/oeUIJ4bgZ6p6IRujoBP1hY0bMlrkAlh6u4nOAM26O
6vdyVjM1Tt1JU8OSBBwu8Yi7LwrjWkLve4fY+kr0ZmNBCpDWNzNW8SYc9Ruusjae
rINMvZMEz886w85mpZ9km4tSVJmOUg1cEUBcQuhXufjdwHvk1L0QgcvbDG/5g0ai
0q5+Vy4UezOdjjATWlHxdZEIEOh1HQ==
=AHCz
-----END PGP SIGNATURE-----

--HWk5+hm8t/wej2SK--

