Return-Path: <linux-kernel+bounces-64080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E2D8539E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F631F23CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364D260861;
	Tue, 13 Feb 2024 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9har22V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A34C605C8;
	Tue, 13 Feb 2024 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848835; cv=none; b=VXGvJk6KfU/pGYxPFl4YWxxmJCDEQakDIwIbIQRujGnOnMp/547X9Jt1f+vDVbOR+72wdgAHSWwIL/cEHNmqvpFFtCGR7OSpfKtqV3PT2Zz4yvEx0lt3e/ou8F7LeY9pFTd+Rn3AQxdirFDXnKqkxXybpNoVq3/7TIpvnfOZ+uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848835; c=relaxed/simple;
	bh=EEomQul/5eCObV/qD4WM2mcnanKsiiwtICoSctvTsiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ggqap09S/wGYPXBN4uZs23QsD0UQLOyWK09CY8Y9CBEbpRB1m5jDMPAsdMUBZ4Qv5gFyQzIYjlawDUY+K3lBxt93ZaHcnZY3xaNf9sQQKoTVap/OIpUfvkjx64xVEKPk/oFG+Vi+hpvWfaJmaynwfuAwLjvEBdUEP+J7f6hsOxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9har22V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0996C433F1;
	Tue, 13 Feb 2024 18:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707848834;
	bh=EEomQul/5eCObV/qD4WM2mcnanKsiiwtICoSctvTsiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t9har22VlNjrYsAPs23QWx5F8JakOzwdFC/1lruS/tKrJ6yCdOKacC/pvKcHDz4Xz
	 6a547DH5vES8zAB0+Ko3c4DV1ft+UNzaCM4D6spIfaDUQ1h/aPuGS8GYeyPgk6tg32
	 rlR7/TpUrkBx0FKXGTeMjckIYwUa9s7YsPM6COPcWvtlCKj/ubPqjXtDePdZsirvde
	 mY/lo93ZMjgCRU+pvuqePeywS2cVeHqY+3ji+wb/9rlI0a/fpehdZilUY0UnO3aIfp
	 lzFcAhNF5MWxuBrSqHW2vyp6dJAmALqiOt1eVe140g3DjeiKBJV5ijVytal/2mA1AJ
	 yeT1Lu9qurpqw==
Date: Tue, 13 Feb 2024 18:27:09 +0000
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Golle <daniel@makrotopia.org>, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] dt-bindings: usb: mtk-xhci: add compatible for MT7988
Message-ID: <20240213-shortlist-unhook-7e7cc4e66c0a@spud>
References: <20240213130044.1976-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pHlTLsj5De7/cwug"
Content-Disposition: inline
In-Reply-To: <20240213130044.1976-1-zajec5@gmail.com>


--pHlTLsj5De7/cwug
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 02:00:43PM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> MT7988 SoC contains two on-SoC XHCI controllers. Add proper binding.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--pHlTLsj5De7/cwug
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcu0fQAKCRB4tDGHoIJi
0rlwAP4zf4fOz8BYPdkqy1M5Qin5dK9+hRmGcVhgbwy2Ggv7jQD/V8NfIOo4BDHi
iI7P2IJcaXKvELYNAQLya8Fj3+maVAQ=
=fc+4
-----END PGP SIGNATURE-----

--pHlTLsj5De7/cwug--

