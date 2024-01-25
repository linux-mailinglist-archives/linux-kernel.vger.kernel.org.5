Return-Path: <linux-kernel+bounces-38856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7C883C750
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8115C1C22983
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745A5745E9;
	Thu, 25 Jan 2024 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdtXKOCZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4312C69E;
	Thu, 25 Jan 2024 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197995; cv=none; b=Ei3UTzZ4EJsZcWEozQQaQFkp10JJDqumQ8jAe118U5t+ORta0f8xmLiRgPkLCDqg8o/H7sfxEKIHKvreDCZ+qTtSyardJt4hkZshYKy+u7CUY4lP3GpT/oPoYYUgBb0ozTGB19/j8oHqLEaE3gUHOxRS7tkG+nVoUDxBNm0PWVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197995; c=relaxed/simple;
	bh=nOk6+vpBqAnD0NqUVUx1ai0O80sPEh8od21YAXRQz9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLnwPSfiiGdZ/Uh4XDfH6UbqxCZaLqKGrDIt9W1SeG+84A7vX4D0TGKAJdOAZlz/qaDikDNypb8uGE6xe6WFGjebXZfQ5SOr0iAXcudIPok4BO/M6chcV+wjFEZ+gBId+6rrr9woqFmSNeHr86WYuZ9dCbPlj9onl8jjsCfPA5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdtXKOCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE37C43390;
	Thu, 25 Jan 2024 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706197995;
	bh=nOk6+vpBqAnD0NqUVUx1ai0O80sPEh8od21YAXRQz9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QdtXKOCZ0MumhfGjw0KAxGHAURFnRimM7IChc4rD/5CUdG0XlW9fXu/VLy0UzhC5a
	 JBVO6oiLnXxqdToZ2Oewci7VR4Oec51N/DksyQu9WkRK8MbLelC3y0mD9ttDimOQvX
	 833oY53SfTUrWxVTYROVlpcnUwXdw7hiMDltdjiG+5YpN6/o1kSisRhRvQg/GkWcwM
	 JBNPV0gFbVt35774aTuoae4V4gZfGxFr4a+KuE+bWAD3+BdF9i+/XbptMQFcC2q35/
	 +Nm5zlQKc+QoqqqQ5tNL0Fm8YAiWo0x33XS/zIMI5S2aB2kg9ddr1PjTi2VdOkN7sG
	 Uxuvvl528e9Cw==
Date: Thu, 25 Jan 2024 15:53:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	conor+dt@kernel.org, alim.akhtar@samsung.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, andre.draszik@linaro.org,
	peter.griffin@linaro.org, semen.protsenko@linaro.org,
	kernel-team@android.com, willmcvicker@google.com
Subject: Re: [PATCH 0/7] ARM: dts: samsung: specify the SPI fifosize
Message-ID: <eaa04bac-91dc-40e2-981d-e5f04f6ca19e@sirena.org.uk>
References: <20240125151630.753318-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="foFfTHRHUmaAcrJ3"
Content-Disposition: inline
In-Reply-To: <20240125151630.753318-1-tudor.ambarus@linaro.org>
X-Cookie: Entropy isn't what it used to be.


--foFfTHRHUmaAcrJ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 25, 2024 at 03:16:23PM +0000, Tudor Ambarus wrote:

> These patches close the circle and break the dependency between the SPI
> of_alias ID and the SPI driver. The SPI of_alias ID was used as an index
> into the fifo_lvl_mask to determine the FIFO depth of the SPI node.
> Changing the alias ID into the device tree would make the driver choose
> a wrong FIFO size configuration, if not accessing past the fifo_lvl_mask
> array boundaries. Not specifying an SPI alias would make the driver fail
> to probe, which was wrong too. Thus I updated the driver and I provided

Specifying a specific compatible is just good practice, it makes the DT
much more robust for when we discover new things about the hardware and
reduces the surface of the ABI.

--foFfTHRHUmaAcrJ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWyg98ACgkQJNaLcl1U
h9DPcgf/cXFXW2mU/ooxWd/EwkvRCkAW4vwoseFFv6E9z59LkE4ds8tHPZDgZOBE
/3U/AIgAG9tQQFOWmxSNFHnh1E2NCMte/VUoXTisfRnhLdYZj2wlaFdcvGt/JFe+
E5WTpnGFsKLOEC1JB5XIQLpJVHniXRiPEsc4zDJlro7m6+r/5aLqbIh6ORuwVdVg
2uzj2iL2c2Ik8I6PreqCA5T6Ow53h/o5OELqui8W7AhDiN1c2cRL8ukRGteN6q0r
HUWuLVYbuYxifr5BjOS+n7mLDMY2Jg/EhysV+T7ZB23mUSuNZPE9drX1lLb+CZa0
P4cbB+TJ3sk4DkKU2k5l2l3uIxyAkw==
=0MC+
-----END PGP SIGNATURE-----

--foFfTHRHUmaAcrJ3--

