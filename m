Return-Path: <linux-kernel+bounces-55137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5050484B870
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44A7DB2E4FB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABD413249F;
	Tue,  6 Feb 2024 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQ3Mcsit"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C470FA59;
	Tue,  6 Feb 2024 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230839; cv=none; b=Hjqp8B7y91QrbXuuBe/KSgMK/1K6a101flM7hMg9bbFAzXcZmorFhO6Da1p7pukdfn2w4eaYTRAGZuft2DvKHUvb4LI8BfnNCGm81d77DS3igVd3W/vhikIUk6nZpVGvk/I3LxvlLO7fCqDP7rVrKda5mv7Ji3o6cL755sVg4ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230839; c=relaxed/simple;
	bh=8r7LG2kurSI2U4sQrA5AELqTkRZ0whAc1ZKiEc5C0Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVUe+X6is1yYm2V0qRUacf18gW0vFB61F0wlbgFyYzsAGEc4L1hXxAYtesOa6EcwYV2SL2JT2p25yO45pipgTPmnZNa72iJw813p3JRcf6gUmnZniea86UjqDy5410Z4McLAxMWiXhx/7ZuNyyNL7Wz8J3OEJlqNovPouBmW/Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQ3Mcsit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2C4C433C7;
	Tue,  6 Feb 2024 14:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707230839;
	bh=8r7LG2kurSI2U4sQrA5AELqTkRZ0whAc1ZKiEc5C0Lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQ3McsitDHbr6XqfDLKVSy93H54aZbnwF+4iLq4GkopQQqhGaLOtUPaY6hyY+uw4A
	 pT7fKBrFF5ebu9VkjDHZygFcoEA67srGFH4/zIgosdS/VWYMm2gbqIv+HuNaieqH9m
	 lO3L1zJEIlABmhYD7xc/BVKjuGN28r0ZmMKQPv0uhcbnloTfXpb8XUAwyRrSow7bHJ
	 UWS55jXAabVPvu3Z3w6UWaGeeFjgfAInSsJ21k8S2jAlS20HKuSopZRgrGdHVj0lWp
	 z6TbHWCqFcWE8Q+QkFTMH2LBx54/1s3CiEO8/M+I4taUbPth+dsPOfHCm1vqUaX4S0
	 9O+ROwNjTRY1Q==
Date: Tue, 6 Feb 2024 14:47:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Support for Avago APDS9306 Ambient Light Sensor
Message-ID: <20240206-gambling-tricycle-510794e20ca8@spud>
References: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9RWAyZGM2mdtXYww"
Content-Disposition: inline
In-Reply-To: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>


--9RWAyZGM2mdtXYww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, 2024 at 11:30:12PM +1030, Subhajit Ghosh wrote:
>   dt-bindings: iio: light: adps9300: Add property vdd-supply
>   dt-bindings: iio: light: adps9300: Update interrupt definitions
>   dt-bindings: iio: light: Avago APDS9306

For these 3,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--9RWAyZGM2mdtXYww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcJGcQAKCRB4tDGHoIJi
0jpAAP9RTj4ultRO2eoh8kQrFmAOYj0b0xbfVJ7XJZ7CPsqLpAD/ecM7AEhbDZO0
iO2empQP5jhq/FyNI1iK89zuEKtCJQs=
=Z4KA
-----END PGP SIGNATURE-----

--9RWAyZGM2mdtXYww--

