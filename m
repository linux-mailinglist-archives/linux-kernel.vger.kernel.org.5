Return-Path: <linux-kernel+bounces-137146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AED7A89DD8C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677E228CE8D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33922131180;
	Tue,  9 Apr 2024 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7FrzKg+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1623912FF93;
	Tue,  9 Apr 2024 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674880; cv=none; b=fqRxqfB2fIeIbCgr8Q5Uvi81qPLJOSpw+P4/CG6JR2EKtww1phJRfmqj7EazCjF8Wxo0cWE/2eR69Qm2jAJQZwmlSX1jQT3NqE2N2hflIa2jnEHW15aRLbsea7eNpfdDF9lPt+nnof6qX7OGVHuYr3RZ8OCqxNFSVtOEbUr4D+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674880; c=relaxed/simple;
	bh=b1I7UNfssCV2gFy/ibu4NFSYAMUmL75Q0HBWqKqGBj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJ8HSnCSha6vwnsA2rksO3AZEYhi3G/3660m2K3QiNmvO6jK7ibCj7i9DW/XdSp6jQjokYvvBr+E8X++ROJFwHnSDCanYk5LhjhOUaz5rC26NJsqEuyOwO1Us2QqdyVnV6tvqLeUPMNrea73oJwK0MwM4ybsWNelLLs5IvfKsYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7FrzKg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57233C433F1;
	Tue,  9 Apr 2024 15:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712674879;
	bh=b1I7UNfssCV2gFy/ibu4NFSYAMUmL75Q0HBWqKqGBj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K7FrzKg+6fobNHG/EEzWpZXVTUG9QTgkpqPWOW8uPmuWAp4su5stPl4oNr8fliSAn
	 IfR7PQ5+PMPt0EhaMarEbBRsUjNvBh2mquygB2EpUeYaX7MSvSbiPYScGWBMSyy2eU
	 fY6W67IddvSCbyBbjXynPG7UF4e/mXqORUGgVNhxRTo3Zs4vD4GrivL6pMlWH9ly+I
	 K2kjHSaQTipwgC5WTRfNJlig2VwVL+swEwXxIaLgZgzaBwAQAJXGcCX19+WGE6nuJR
	 Lre9pTqcRSeB4lcpNfxEPF1Z0vblR7jV7Ll/y6IdFf0aAO9WDAf6kDlHAGk8vFBiCh
	 pmFGtmi7aqUTA==
Date: Tue, 9 Apr 2024 16:01:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Eric Lin <eric.lin@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 0/6] SiFive cache controller PMU drivers
Message-ID: <20240409-corral-untruth-591b29f6565d@spud>
References: <20240216000837.1868917-1-samuel.holland@sifive.com>
 <20240216-shopping-unnoticed-e73e72a0e849@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zsV7n7T3orhUeCCb"
Content-Disposition: inline
In-Reply-To: <20240216-shopping-unnoticed-e73e72a0e849@wendy>


--zsV7n7T3orhUeCCb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 10:05:04AM +0000, Conor Dooley wrote:
> On Thu, Feb 15, 2024 at 04:08:12PM -0800, Samuel Holland wrote:
>=20
> > All three of these cache controllers (with PMUs) have been integrated in
> > SoCs by our customers. However, as none of those SoCs have been publicly
> > announced yet, I cannot include SoC-specific compatible strings in this
> > version of the devicetree bindings.
>=20
> And I don't want to apply any of those dt-binding patches until then.
> Stuff like "sifive,perfmon-counters" seems like a property that would
> go away with a device-specific compatible, at least for the ccache.

Reading the P550 stuff today reminded me that I had not got around to
looking at this series again. You should be able to use that to satisfy
my wish for some soc-specific compatibles, right?

And w.r.r. the perfmon-counters property, looked to me like Rob was
proposing it not even having to be vendor specific.

--zsV7n7T3orhUeCCb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhVYOwAKCRB4tDGHoIJi
0jzBAP0bzyW1aj1y1ig0+xzeagwXGMmN9QO8TaiyNHylHG6STAD+Lz2fHDrW9lKK
auwxSW/MgO1tt4GAH7rwtfp8pUBIMAA=
=JS2J
-----END PGP SIGNATURE-----

--zsV7n7T3orhUeCCb--

