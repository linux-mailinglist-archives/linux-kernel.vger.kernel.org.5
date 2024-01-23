Return-Path: <linux-kernel+bounces-35774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC94839655
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48FD287690
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641E080030;
	Tue, 23 Jan 2024 17:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsyQZ1Cl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21567FBC1;
	Tue, 23 Jan 2024 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030710; cv=none; b=evP4I3YC3BB85wHAlLg9Mj2RtrYTzp8v2D9bdafgf2/ITaqPINJmWnKH6WK/t8HqlpLhwKNUH93oRWCfBpd9jNDX4SwTBFPxC3G+fneRNvRvEUYm7jl4yY7bkkpZIgjW9MFvONYK8D7ZFtcZciADES6yXlVs+Z5hgaJqrfUQFrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030710; c=relaxed/simple;
	bh=/+SkSMXEvZL7JnAfLyB9WU4yUTd/UNiUILkQDm11AUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvh5y+widUkXhpqdbW6I9fNoEzX9NoiOU5e5dvyT0PldXxVejklS5ddCLa+jHSvM5rLYkFm/3NrcTWNaqhG1sF55+pucL7nPZynLPy0zuKH64JcnlPlAcigFTdBkAlpr5eY1iwafj3k7HKj4QDQW9zn5Ybk9yr2Jx5xaA8oelKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsyQZ1Cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9239C433C7;
	Tue, 23 Jan 2024 17:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706030710;
	bh=/+SkSMXEvZL7JnAfLyB9WU4yUTd/UNiUILkQDm11AUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SsyQZ1ClhmUW+4PfVIea5D+atCt9xW/phWP1Ii1PSiS2YlGgTnee/sGoouvb08n27
	 IQxIk1u6H7IGHU8tvDzFP8iP6hiX7O7H9Jlzo0Jyk0Rp8T+Qa9veHJcoTbuYRdHPZI
	 JRej4AbG0ztvIkkb5xW1Cwfw8XTYUoq4hbDrIuywtDECiBc8j+2a+VCj3vu3kmM39+
	 Zv0NTmnqbQ/CFztrkqZjrQlYYcicdi1CDzv0bZV1d3NH0JbcyBL6zRWY3dWMO8rcKY
	 oBdgxmFjhkwQQDGk1SzUDn+z9bcG7eFRIy6xW41Y5xf76ktmfZjLX7zIqMCwLeMRt5
	 mZilSAZa+7QKQ==
Date: Tue, 23 Jan 2024 17:25:04 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	heikki.krogerus@linux.intel.com, matthias.bgg@gmail.com,
	dmitry.baryshkov@linaro.org, neil.armstrong@linaro.org,
	andersson@kernel.org, nathan@kernel.org, luca.weiss@fairphone.com,
	tianping.fang@mediatek.com, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: Introduce ITE IT5205 Alt. Mode
 Passive MUX
Message-ID: <20240123-doozy-sureness-ce1bb4d555a2@spud>
References: <20240122110446.140226-1-angelogioacchino.delregno@collabora.com>
 <20240122110446.140226-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/XCj4OvKvckKfaBz"
Content-Disposition: inline
In-Reply-To: <20240122110446.140226-2-angelogioacchino.delregno@collabora.com>


--/XCj4OvKvckKfaBz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 12:04:45PM +0100, AngeloGioacchino Del Regno wrote:
> Introduce a binding for the ITE IT5205 Alternate Mode Passive MUX,
> used for connecting, disconnecting and switching orientation and
> control the SBU signals for alternate modes on USB Type-C ports.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--/XCj4OvKvckKfaBz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa/2cAAKCRB4tDGHoIJi
0sYQAQDQyqLUgZBdQdVEY6xff7eoCvbdU/jaARvKcKaPn1vdDAEA/hmLVL/fRr56
YR12yOvgBBZRx4C0x/9NuNpVPSbnbgU=
=HBIR
-----END PGP SIGNATURE-----

--/XCj4OvKvckKfaBz--

