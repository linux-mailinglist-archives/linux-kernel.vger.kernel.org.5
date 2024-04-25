Return-Path: <linux-kernel+bounces-158910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376E88B2692
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2FF286DA7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6135414D28F;
	Thu, 25 Apr 2024 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sY1YezMy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EB9374FB;
	Thu, 25 Apr 2024 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062796; cv=none; b=f3yxT6nTfIbpnL7c/J57y4lY652CWKo5/YSJu66ySTSMffOLxCf5Mb+qhzRqUKlTAZGIsuV12IJreq5UsDgyq7m3858veV88azcOcdFfnRl26PuGw2fpv5u24u3g07BbOUHyY/a3/Hp7LprZDiDqtvJFDI9WMbgWELxfbY6xZs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062796; c=relaxed/simple;
	bh=oe5+Aih7+reqvvLN37kEo2K9EvVhPCev4/HNX69J5Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUhARQu0awcHvnFz1tGuRQXyYrbBdLeMEb0r9GsHYV5IHTDoPypw+t2IsxPD+BbNI81qAjtWY1EqPQ7SFDQ6d2L27lWg8CKgPQ2AbMmEn8GmPhtmDIiuoO1zhh1LmDWVS998OUc2KdEFiE2ycIzbhLAM3w/8I4wY7wGbnlxVL4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sY1YezMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE888C113CC;
	Thu, 25 Apr 2024 16:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714062796;
	bh=oe5+Aih7+reqvvLN37kEo2K9EvVhPCev4/HNX69J5Jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sY1YezMyRooZbXbgTN2l8RN46PCN+WGPIY8gz8Q5qUtImRGgvRerRs6yCui/NOokn
	 X7Zfx3Qw0/SYswPCYCbjdwwdWzpduJBdcOhAlqVdRLlv0wMqfdpfP/mYCzcbrCr4S6
	 tQzDPEmJO6rnbczBRay+a0mZB9XddylTB49d2Bkjdi5BQYnPZbdWYk5bdueSAJUJdU
	 fRvNsWqrkN6DLy7yhok/hnxsnHNwa7oa0zmEi1mpGj92nMOrOnhTvAIazSygnaP6Tb
	 T92eg169l1K7DlSz7LcN93WJYnqvKG0e5qAamx9dCLKThE5EvCvKuJaWQRcrlZDhKc
	 uXPshgdUaGqFw==
Date: Thu, 25 Apr 2024 17:33:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Pratik Farkase <pratikfarkase94@gmail.com>
Cc: Pratik Farkase <pratik.farkase@wsisweden.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] dt-bindings: serial: brcm,bcm2835-aux-uart: convert
 to dtschema
Message-ID: <20240425-scorebook-designer-980e9e31944d@spud>
References: <20240425162554.13576-1-pratik.farkase@wsisweden.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KyGyLFpFMyKsZQ1Z"
Content-Disposition: inline
In-Reply-To: <20240425162554.13576-1-pratik.farkase@wsisweden.com>


--KyGyLFpFMyKsZQ1Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 06:25:50PM +0200, Pratik Farkase wrote:
> Convert the Broadcom BCM2835 Auxiliary UART to newer DT schema.
> Created DT schema based on the .txt file which had
> `compatible`, `reg` `clocks` and `interrupts` as the
> required properties. This binding is used by Broadcom BCM2835
> SOC used in some Raspberry PI boards.
> Changes from original file:
> Implemented complete example which the original txt binding lacked.
>=20
> Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Pratik Farkase <pratik.farkase@wsisweden.com>
> ---
> Changes in v4
> - Added Acked-by flag

BTW, there's usually no need to resend for tags alone - in the vast
majority of cases maintainer tooling is capable of picking those up when
applying the patch.

--KyGyLFpFMyKsZQ1Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiqFxgAKCRB4tDGHoIJi
0kgxAP9/FXU1bPe4BRhO3Ulpg6Yg4Ff7kGIEVvD+O11NntnflAEAxkgLnK5x6BWd
r5NKbJmI/NRZ8E+xWLcrVYROAoPSRA8=
=0kw4
-----END PGP SIGNATURE-----

--KyGyLFpFMyKsZQ1Z--

