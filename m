Return-Path: <linux-kernel+bounces-135721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF4389CA40
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303921F27679
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA328143867;
	Mon,  8 Apr 2024 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sta3/99x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D85B6E60E;
	Mon,  8 Apr 2024 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712595862; cv=none; b=ri7XL6h+QtOi+T57vA/vcNYSYkCVBOe4fwAcw+NM5LEHPGbQ/0aR+1azfMFZZWteQMetiIRRRrUcP/5DGYZzSRdj33cqNObEt77febxZKpwGIf/UQeQ1DGOLEz0DofvCETicTVW/XniwQ+T1i4AKk4of5tFIOpnWjVuQKaaGG1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712595862; c=relaxed/simple;
	bh=dy3oPXhtT+DA8A9ZwN7rVbw8cVMFMCW5FtsQNnUysX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq8iC2Fo6nxQ2JHk1Q5NRGRLE6lh8auFiPd9+5iuMLzg4MbEdGxsU63niVqStsLSMCEQyaggZkIiFhz5Xfnuk7XbeCwkK4dK4LYy2xx11mp46oBGQrIPz2RcL+r7QVi2Xmv1UwbBmPoovsPWBq8HaVjH9zIBH1YtaUXoITekJRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sta3/99x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC845C433F1;
	Mon,  8 Apr 2024 17:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712595862;
	bh=dy3oPXhtT+DA8A9ZwN7rVbw8cVMFMCW5FtsQNnUysX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sta3/99x+vUdccGZVczBTBP2IyoYbfDmqeeDUdY7Igf2g9XzJMbYpi1zPYOhZwnoq
	 9foZTZRBqSHD5TRDoiePadF4JgdwjTSO6Bs0pgQ0OKy0lLDyKLnf9qOAtowOOxGgYV
	 EydTrUD4xfnyaU0vi6OsqNjuQnWHCcnW0KDMiYlr+vD+k4yqqWkKTT3kicerOKnSSh
	 ZeoT0sKIcvA4rejXW1WnXiIiZRqolPMoIbhqALDOI8FLeTdjJA/lANXcrIaIRgJo0i
	 tYI+rs1wULoLQdbI8DAPdDpBAtz1ZabgSuX60NEav5/D7AP7GRh2gpYSvNFhuNLAy7
	 Wb/eoFp9E73dQ==
Date: Mon, 8 Apr 2024 18:04:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	David Wu <david.wu@rock-chips.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] dt-bindings: net: rockchip-dwmac: use rgmii-id in example
Message-ID: <20240408-handpick-scouting-b04de6bec84a@spud>
References: <20240408-rockchip-dwmac-rgmii-id-binding-v1-1-3886d1a8bd54@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="whOycmADd1NrPPmb"
Content-Disposition: inline
In-Reply-To: <20240408-rockchip-dwmac-rgmii-id-binding-v1-1-3886d1a8bd54@pengutronix.de>


--whOycmADd1NrPPmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 08:44:10AM +0200, Sascha Hauer wrote:
> The dwmac supports specifying the RGMII clock delays, but it is
> recommended to use rgmii-id and to specify the delays in the phy node
> instead [1].
>=20
> Change the example accordingly to no longer promote this undesired
> setting.
>=20
> [1] https://lore.kernel.org/all/1a0de7b4-f0f7-4080-ae48-f5ffa9e76be3@lunn=
=2Ech/
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--whOycmADd1NrPPmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhQjkAAKCRB4tDGHoIJi
0vZaAQCzEUq832WzZ37GUbKIrB0V8uvvHYrxPBDcsr17McinxAEA4If1pTgFZfkX
zWzresFYoT+wuXAVCB7RoeelxHJHWg4=
=8IjP
-----END PGP SIGNATURE-----

--whOycmADd1NrPPmb--

