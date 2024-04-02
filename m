Return-Path: <linux-kernel+bounces-128495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEDF895B9B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AD51C2250D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3283B15ADBA;
	Tue,  2 Apr 2024 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MS+tO2fd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E7115AD95;
	Tue,  2 Apr 2024 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712082048; cv=none; b=gORMsbb2O+LFtvN3/SCRG7wkkFN0iVYJrTiHSQQkFcoCoNDHAe13+7lesZjvPHllj3CAtNv/3iEndyU2WQP3D0f+Xez5xBB5nWMtcSrzKSx+ywv4gKd6Gh/9WnjMXuggrJwdpa6pPqrTpSVQJh7Bg8gVctbKcgy8vND7pjQziP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712082048; c=relaxed/simple;
	bh=R+dnlvAnN+zOtr2CXbdtuCPTkxZEygoWJCnVX6je7zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASGrNsNyTZV0v0+ttvnm/vLd2vdPRrj/pbe//BwwN5DF6w973euuxdrB0A9ToHc+WlohnzPdQQHg+I5kFA3oRJ13RS1Mm/fbFFBSltz9LNzxza/6xMBEQ6ND0UU1zUVxyOhouyHk07/+kFH+m5ezBX9WoL2ffgjlrexQzWot29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MS+tO2fd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A76C43390;
	Tue,  2 Apr 2024 18:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712082047;
	bh=R+dnlvAnN+zOtr2CXbdtuCPTkxZEygoWJCnVX6je7zY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MS+tO2fdHButcdLwRwDMczgoVv7JLOqbWb/gslRHTG50HvGg9Z5dDC/9cCi66iNH6
	 6g9qe/7/q3c23lNJhEPx0o023ZkiHkvXElbJmxGDv/MkUG8PxSOwpzyaZv/rYdGzuA
	 c/KbwaggUEglG4kB4yZUik3qyAouF0Nn4ui4XJrXq53+oE40IMfYUDwiGHEAo8YIOw
	 nc/hOsgjltNjbcdAZbcFvgRkSxN/vcx/uFhwyx2529tTPl4nT5e4lYMkJMZ5oGncs6
	 UxZIBENP+xABjcAHkoZFRB4k1UvH2DtfHYHCNSAnPVNyYBwzR4YHm1fJdMjCHBFds7
	 YnZJdBL9B70Vg==
Date: Tue, 2 Apr 2024 19:20:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: snps,dwmac: Align
 'snps,priority' type definition
Message-ID: <20240402-surprise-helmet-9f7c0eb6839c@spud>
References: <20240401204422.1692359-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ESvyQlaQyigU/fBK"
Content-Disposition: inline
In-Reply-To: <20240401204422.1692359-2-robh@kernel.org>


--ESvyQlaQyigU/fBK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2024 at 03:44:22PM -0500, Rob Herring wrote:
> 'snps,priority' is also defined in dma/snps,dw-axi-dmac.yaml as a
> uint32-array. It's preferred to have a single type for a given property
> name, so update the type in snps,dwmac schema to match.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--ESvyQlaQyigU/fBK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgxMewAKCRB4tDGHoIJi
0ulmAQCkfrNLqe+sPJxSI8sQY0KUogTFYjfGdbu8F+QOuBqi6gD/Rbh3ZV9LoT5H
lpqNx32GQ3q94ffF/QC3E6OWnnG36A4=
=qjGs
-----END PGP SIGNATURE-----

--ESvyQlaQyigU/fBK--

