Return-Path: <linux-kernel+bounces-128567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 768D0895C8A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D8B1F26BC1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C39715B96D;
	Tue,  2 Apr 2024 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7rGORmk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFF415B55A;
	Tue,  2 Apr 2024 19:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086129; cv=none; b=Pv3wwKN13ukDRbMl6EKreLPJCd+2n0EaEIyJ6dVY7xKdRyrKslSXPbwx3S/CdLGAYCWklPfgRTwag+tm9e6RipI+fIalcIncj2xaZj7UTshKqBCen5HzfHDAbmWfDtq1dTBb4u3fVtDlKh51dUT3UlqBwLdJRFPZ+MKgla9TUhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086129; c=relaxed/simple;
	bh=NAIlNAyqZ5xFb7S0Rck0DUTBUV83tvWCe1Tb0Ugx5hA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3VHsOKvWUpUvCC58MK2s3nPNo1m+RVpZeQi7WjpOG8dFbobf1yaxj7BDEyOl9AgDjJXkuuBNfjcJo4zOcLkCh/z5Sspo8x1XGlUc4/bBEVX5684Ll1LcuLwK5m7Ad1xTCiblAQuMTZ2Yd9nzJUNWYJlZ9F5wXjdG9YWOLPqgWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7rGORmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FECC433C7;
	Tue,  2 Apr 2024 19:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086129;
	bh=NAIlNAyqZ5xFb7S0Rck0DUTBUV83tvWCe1Tb0Ugx5hA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y7rGORmknipAl9T3i3EjAhORqJ7u26iZykkth0KDXI2iGCw7LBLmRiisGZkTxGEpA
	 bWo/jp375JwcJoLaV3qJ84540XCe1wyyhuNBo3J9ISJnV14eWVlpzUyZazWaXKTm5X
	 1cqqvqOIVQAuyoohD6gQ369KZX0VRLWBY4fbKV6MiBwCyuGFeOSiloTQk/GfS98LSk
	 9nYG6J+CjD09+8QNU9GtH8byaDMG/6qOFBlUjz1lJdB58BEOEvU8mb3X7xJ7A628pf
	 UtPhPVg9NEc+9WavbS4UlPrpbX2FivqOHcaoXhqFF2BAMR1GNfyYMFA6Y9fi6/2ddw
	 a4EuESHZGQvxA==
Date: Tue, 2 Apr 2024 21:28:36 +0200
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Robert Marko <robert.marko@sartura.hr>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: marvell: turris-mox: drop unneeded
 flash address/size-cells
Message-ID: <20240402212836.13d7cf11@thinkpad>
In-Reply-To: <20240402183240.49193-2-krzk@kernel.org>
References: <20240402183240.49193-1-krzk@kernel.org>
	<20240402183240.49193-2-krzk@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue,  2 Apr 2024 20:32:39 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Flash node uses single "partition" node to describe partitions, so
> remove deprecated address/size-cells properties to also fix dtc W=3D1
> warnings:
>=20
>   armada-3720-turris-mox.dts:218.10-255.4: Warning (avoid_unnecessary_add=
r_size): /soc/internal-regs@d0000000/spi@10600/flash@0: unnecessary #addres=
s-cells/#size-cells without "ranges" or child "reg" property
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arc=
h/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> index f1a9f2234359..54453b0a91f9 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> @@ -216,8 +216,6 @@ &spi0 {
>  	assigned-clock-rates =3D <20000000>;
> =20
>  	flash@0 {
> -		#address-cells =3D <1>;
> -		#size-cells =3D <1>;
>  		compatible =3D "jedec,spi-nor";
>  		reg =3D <0>;
>  		spi-max-frequency =3D <20000000>;

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>

