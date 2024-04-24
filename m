Return-Path: <linux-kernel+bounces-156766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEB78B07DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1FC28213A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D8615A4B0;
	Wed, 24 Apr 2024 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZuuJjBc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439CE15A491
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713956325; cv=none; b=gTugaAGUgvqL78E/7VcFOt9D4uq3cRCdQ2nk+Jx67073CW0adPcotAU3AUih2s+6yi7wVT5CU4aM7VV/OQuWfJR8S+r1FPO3CToZjuHvAjz9jdA+l3EMyPGeDlmMOYzwfI/P9W8C2Xlj3IyLIw7iBx85gUt/nF85fUwu9kXGS00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713956325; c=relaxed/simple;
	bh=oWizCb7BdyW9M3jIy6WM++409fA6jIXbKrGaSbTxVwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqVKPSqYFEc08mcdz2x8nwkVI0vJijZ5Rw8CSNKDAK7QtQKvak64NmSralGgZCiRGBhLoindyOLACBlSdes6VtIBbDcyi4zhQo/hYFTXwsbOqIC9FzLBtAtlNiKG+JE3B8MKOt50RPb3N0QXZgtb9Kb5xh6A57QTvYaitNZ1B4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZuuJjBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33512C32782;
	Wed, 24 Apr 2024 10:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713956324;
	bh=oWizCb7BdyW9M3jIy6WM++409fA6jIXbKrGaSbTxVwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZuuJjBcyr0Euwq0h3lI+jyUHHBU6LiWtQ5ZTOsU6dbgwKvUDZDlw6qkmwkVkNSsH
	 zysbaSuxX4jx4jlWELLvy8wrmyj/jR72DHP3uWtM5SY5OyPea0SKGWqh0Wvi0zGJqr
	 CLdChROgNCYsqywynomrhXYXge92QLv4n6QrgwWRRk2XzKkENP266ngSCCn7WxrHFk
	 iWbFDAVwz/X8hgvl7lZgs7lE9kl+GM7xA56b4FkFEcKlRmxETyFNi7rHv+ldiWiAFj
	 on/oENY+Qn7vKO2qliiONz17leVsAsxyoDyERxswra0b66fv2Qs+wB0PwcdWyK9j62
	 hZhpSzamkdFDQ==
Date: Wed, 24 Apr 2024 11:58:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] riscv: defconfig: Enable StarFive JH7110 drivers
Message-ID: <20240424-semicolon-stainless-4647035a30ec@spud>
References: <20240403060902.42834-1-hal.feng@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fSzVW4N5Z1t33Sze"
Content-Disposition: inline
In-Reply-To: <20240403060902.42834-1-hal.feng@starfivetech.com>


--fSzVW4N5Z1t33Sze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 02:09:02PM +0800, Hal Feng wrote:
> Add support for StarFive JH7110 SoC and VisionFive 2 board.
> - Clock & reset
> - Cache
> - Temperature sensor
> - PMIC (AXP15060)
> - Restart GPIO
> - RNG
> - I2C
> - SPI
> - Quad SPI
> - USB & USB 2.0 PHY & PCIe 2.0/USB 3.0 PHY
> - Audio (I2S / TDM / PWM-DAC)
> - Camera Subsystem & MIPI-CSI2 RX & D-PHY RX
>=20
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>=20
> Hi,
>=20
> As more drivers of StarFive JH7110 VisionFive 2 board are upstream,
> add support for them in riscv defconfig.

Don't think we ever discussed sending this kind of material via the soc
tree, so this one is for you Palmer :)

--fSzVW4N5Z1t33Sze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZijl4AAKCRB4tDGHoIJi
0msRAQDayDsgCUh+dVh/+2XHjcsCkv2bNYW3CpxtHoKJDyWU3wEAlNAUmTBYJiVu
UavaCz9gh/JuEjZ2GFw1Ly0z/8W5ngo=
=viBE
-----END PGP SIGNATURE-----

--fSzVW4N5Z1t33Sze--

