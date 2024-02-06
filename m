Return-Path: <linux-kernel+bounces-55323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C0B84BB1A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1AE1F26072
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ACFD52F;
	Tue,  6 Feb 2024 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGkku+lM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFFC1373;
	Tue,  6 Feb 2024 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237321; cv=none; b=bHYIhMSpxByHc/cCO6TrXIFVzxJ5JOygRUfCzHSoYOFsth1PTKyALq3olQU+fJwpUMgjEuOxfFqFsjHWpQ1KvvAvr6PHGlbAIz8vRXiGRqSNVcDyIa085Rj60IemuZwLo+Ota6VvGw2K0P5FAr7Mrs6BDCFdw6N4HRdKfI7ngRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237321; c=relaxed/simple;
	bh=Pd5hbjeUaw0bXpSMvlmew8SMjBMs2/PcDGfitcRRlrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHVkWq4pLXB8E71UiRwD3/eLWZA7tvDTtrDrY7E7CDyihEZtRTXhf1Gw0aPjECKb9JiK4OWSF4+BvqVssiG+ptE4aWLKEmXNq0q6c0vF4O5NoO9ZoValckFnaOm0IXXl6bLfCrbX7SF5ffbRfYtuuLcJmQsFmefsTutmkR9kfDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGkku+lM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F05FC433F1;
	Tue,  6 Feb 2024 16:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707237321;
	bh=Pd5hbjeUaw0bXpSMvlmew8SMjBMs2/PcDGfitcRRlrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kGkku+lMjJ1CIPEJIoX1+Fv3byTzutiXUE2/v9sOQPIeA1z2ozWWBdlFlN1d/U3cl
	 5gsSV9vGqZMqYOc2q4ppul4FRFV5eD4YQgjiuqmjTKoDDgccyW4RjQrkm9NfNb4aSX
	 I1je7RWXkXcV3NL4Z2aGdFu2H1IOfZUcPme5Ci5qWNvWbLlHmApVGBco4Dh8ulLohc
	 DTu7tUFwyxEFzJp+gxyEv5oUTJNZ3c7MXQgZK4YyNSjuNjaF9HbgQ6nscSsnzejYwC
	 HGeTUSo2lDmKVDUzFWiQk/c2j4T8oZqJtcNZMZT9lNq3xV1Nxei+zSY662HiCEZvJi
	 bMoqNwKXDSmqQ==
Date: Tue, 6 Feb 2024 16:35:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Javier Carrasco <javier.carrasco@wolfvision.net>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 6/7] ASoC: dt-bindings: xmos,xvf3500: add XMOS XVF3500
 voice processor
Message-ID: <ZcJfxRgysxLWAOIH@finisterre.sirena.org.uk>
References: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
 <20240206-onboard_xvf3500-v3-6-f85b04116688@wolfvision.net>
 <ZcJDFi+iIQOWzgYw@finisterre.sirena.org.uk>
 <7b472cb2-6658-446a-ae47-411d08798cca@wolfvision.net>
 <ZcJR0LrwaS5GAf5h@finisterre.sirena.org.uk>
 <ZcJVD4CGhlWRwgfM@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZQT/yRHuU/ihg6na"
Content-Disposition: inline
In-Reply-To: <ZcJVD4CGhlWRwgfM@google.com>
X-Cookie: You might have mail.


--ZQT/yRHuU/ihg6na
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, 2024 at 03:49:35PM +0000, Matthias Kaehlcke wrote:

> Initially the driver targeted a device with a single supply, the name
> 'vdd' was kept generic since it was expected that other devices would be
> supported (except for a couple of minor bits the driver is not device
> specific). Later support for a device with two supplies was added, with
> the generic name 'vdd2' to support other devices with multiple regulators.

It's generally always going to be a problem to add generic names that
don't reflect the actual hardware names, you still end up needing to
define the mapping from the real names to the generic names that have
been define when you end up with the regulators being controllable.

> Using the correct naming would be doable, with the caveat that the old
> naming still needs to be supported for backwards compatibility.

Yes, the existing bindings need to be supported as a legacy/fallback
thing.

--ZQT/yRHuU/ihg6na
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXCX8QACgkQJNaLcl1U
h9DdNwf9Gyj9Sld7yROz9aRLyvoxIR6qEWLHzv+LnbbvL4odas62FJj65Wxn3aun
MvYZguIF7TY8NpMlCLoSXQBkhCWECnBSe7ayBjXXW/fVGN6pQKX56bQFzG0K2GEe
Y31/cQ7J8iAdUHauvZJzihpekgsRZLCS2VOKyff9oxyllFyIjn+S3egZo1C+m82J
OwE8GBVceOPOzYusyZ5J5mPrR8nEQz+SOy9aThjfY9t3EvppfQqA6zt08fIPw2PZ
afz9T3F878AdZ2tkPIujPrfbCyI0dDuMRLLn5NfYGY42jqgBjQ/J4nwKstZwTJ5x
sg27o4dCPT0Z0UqF1o4NK9IKRo5rsw==
=Hkgg
-----END PGP SIGNATURE-----

--ZQT/yRHuU/ihg6na--

