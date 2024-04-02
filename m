Return-Path: <linux-kernel+bounces-128456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7E2895B11
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4B61F225AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A1C15AABF;
	Tue,  2 Apr 2024 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1n76jr1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8519C60264;
	Tue,  2 Apr 2024 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080156; cv=none; b=UcittZ4yV17c0VRcXU/vWJ5JJunwdUw0yKoE41KWAfGzt5uIQS24W7SCBCOxM7yqQrwX9MD5aTGBARVAZa9rplkqYuxK0dhyN8syINvicQmnzaaetNFz9mfMRj62SZgt7aCtKzVL23f7HDNCb7+MH1LFrOitybeYapmXYvcE4dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080156; c=relaxed/simple;
	bh=yeTBkkEGiyPBxZNMIw1Kx1lDc+1ke0bR08ffcwJUHO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqkMS5+E/Ks2IBftWIjSpCaKW0q0Me6y/z1dhLrXyr4MjIbEJs54OYpaCMY7JBDClwt/v2G2uIYIxiwl8Z9n3Mp++vGEUfNe/zTH4r6S1mlNN6aPNW56VPJ9a5yyycvYzhJXR/CqyDfBtu6zHmPv7Z8VSpHy87nrwJu4vW0tzdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1n76jr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB19C433F1;
	Tue,  2 Apr 2024 17:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712080156;
	bh=yeTBkkEGiyPBxZNMIw1Kx1lDc+1ke0bR08ffcwJUHO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X1n76jr19+CtOwmhZraxUqNYAKKfX8YXLkktLSVqx4MA8F0JH+9rmBpsp0dTDzGUK
	 NaosLj6IbQB206qGYwplSUWFMNi5P7xdW1qUIdA20f8F4Sx44jghslWF87UgeIjN/g
	 Aw2hjFqtWAkDZd9EEEB2OiUR5+QomfRpTT6scwU2zOCYOriREd4dS2+yjnyv+b+//Y
	 a9r9lUYs1TFydiK1Vbl59KcUbUbNdOzB0jdzeUQe9rAKm+le+TNOgwq6BFcUDlsWC5
	 PpNYUix1g04YtUqXEsQALnm3EXx3c2DEFCXssSOXXHdKrNUI/fJqv52xC/GfGdAaym
	 TXv3sZzcq45cQ==
Date: Tue, 2 Apr 2024 18:49:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: renesas,tmu: Add R-Car V4M support
Message-ID: <20240402-jester-bronze-a60ac83542a5@spud>
References: <8a39386b1a33db6e83e852b3b365bc1adeb25242.1712068574.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N9t/vsq8KezZb8i2"
Content-Disposition: inline
In-Reply-To: <8a39386b1a33db6e83e852b3b365bc1adeb25242.1712068574.git.geert+renesas@glider.be>


--N9t/vsq8KezZb8i2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 04:37:02PM +0200, Geert Uytterhoeven wrote:
> Document support for the Timer Unit (TMU) in the Renesas R-Car V4M
> (R8A779H0) SoC.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--N9t/vsq8KezZb8i2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgxFFwAKCRB4tDGHoIJi
0qD5AQCcJ2nz2aV9AcUm/xI2Ib+kByeI9zhw2mcg7Y+8cuSeeQEA3jcdeLWGXBwp
FOl9+KGmzE1ozkN6Ypobny6/SbslDwI=
=Jpph
-----END PGP SIGNATURE-----

--N9t/vsq8KezZb8i2--

