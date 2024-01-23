Return-Path: <linux-kernel+bounces-35760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5614B83961B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8906A1C24C12
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E62B80035;
	Tue, 23 Jan 2024 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1ByY1vf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552CF80021;
	Tue, 23 Jan 2024 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030078; cv=none; b=XKPOp9Eyfq9szEPXTIG5M3VekLkBZ7W4ZIfUIBeGl1W7fGqh49E62sXqVale15FqYLcebyRmaGsJ5QaHktlHu6rjA5hfPNqtIzKEpH/7JoSM7u9DSCGLFznzoUFmju+Rvie39jsHH/UlM6YhdTLwqX6BlCEyIKWVovDGgf4ivic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030078; c=relaxed/simple;
	bh=VCYhCGCtLx/Jyo1j6/LXONR0VkamWENNT6rk6KXghPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2qUwJ0djy8armwyF7pQRp5NJr68vJKz43QNSuK9scUDTNLuAdrVON2c+t+v++AQXvxt7TkA0E7TGU29yt+XB8ggFZmELAPVfIP797Jqa8VUPM6nPAG3oVvKFQuTyMoy5mxBdIsKmJzAbuXGMIMewYhg6mVIcdId/vctn50mPTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1ByY1vf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50A3C43390;
	Tue, 23 Jan 2024 17:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706030077;
	bh=VCYhCGCtLx/Jyo1j6/LXONR0VkamWENNT6rk6KXghPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M1ByY1vfZIGPwnhFUO61nlYWKDPVjRsVMHAbF21f3ov4WV0oGLNuAROs6NF7ZQ0mW
	 zUcLEvz0SgQ0x9X58ziLybT2gjt88WTjgnwoK6CtsJtUBQPXDw+/4w7bcHNlisqYS8
	 +gwvxCcjOGuxt1D2DDp3oDUyvA6GJ8kFLYRCU8EjJWyqnLGzSXh1SLiKn7YWA1VZgl
	 5AKg4fRGp/rsrxPVF4UeVdjyBuCML2Eqe92IgrzYZnjDYNSXY4k+vF8RlcYePA001c
	 otnw5/VZizMeyEX3gT+5fmw6jiVZmUgNMb6BTmfUtkbR6yT9TgWJkPiGpwazy+8c2U
	 vlndxs9XEHZiA==
Date: Tue, 23 Jan 2024 17:14:32 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, linux@roeck-us.net,
	heikki.krogerus@linux.intel.com, cy_huang@richtek.com,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: mt6360-tcpc: Drop
 interrupt-names
Message-ID: <20240123-procurer-jumbo-ebbec485505d@spud>
References: <20240119094105.98312-1-angelogioacchino.delregno@collabora.com>
 <20240119-eldest-discharge-e2d3812be0a9@spud>
 <12b7b339-498b-45c1-bc5e-05e07660aefa@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v/T4NYLhZdUREOS8"
Content-Disposition: inline
In-Reply-To: <12b7b339-498b-45c1-bc5e-05e07660aefa@collabora.com>


--v/T4NYLhZdUREOS8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 11:32:30AM +0100, AngeloGioacchino Del Regno wrote:
> Il 19/01/24 17:32, Conor Dooley ha scritto:
> > On Fri, Jan 19, 2024 at 10:41:04AM +0100, AngeloGioacchino Del Regno wr=
ote:
> > > This IP has only one interrupt, hence interrupt-names is not necessary
> > > to have.
> > > Since there is no user yet, simply remove interrupt-names.
> >=20
> > I'm a bit confused chief. Patch 2 in this series removes a user of this
> > property from a driver, so can you explain how this statement is true?
> >=20
> > Maybe I need to drink a few cans of Monster and revisit this patchset?
> >=20
>=20
> What I mean with "there is no user" is that there's no device tree with a=
ny
> mt6360-tcpc node upstream yet, so there is no meaningful ABI breakage.
> Different story would be if there was a device tree using this already, in
> which case, you can make a required property optional but not remove it.

Not every devicetree lives within the kernel.. If the driver is using
it, I'm not inclined to agree that it should be removed.

--v/T4NYLhZdUREOS8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa/z+AAKCRB4tDGHoIJi
0lIGAQDy+QnvesimA/OIHScQAKviK34M6BooBy+5efXbpLxirgEAsWPYDApgg5q7
5GO9YGhChTlvElCUHbl0NhBDEWtLsgY=
=kCYX
-----END PGP SIGNATURE-----

--v/T4NYLhZdUREOS8--

