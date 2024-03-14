Return-Path: <linux-kernel+bounces-103244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2741787BCDA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB22C1F24F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0BA50A87;
	Thu, 14 Mar 2024 12:31:28 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4326647F46;
	Thu, 14 Mar 2024 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710419487; cv=none; b=sLUq5fswfpc9bIZ5lYF+7LWj5AWG4bQGXxL283Y5MWwW+/QqL1BG9ohhcDz95w1GKZ8oky0ZXXvFVgrHnGU6wNHWRoeVo6sD4UBq7zCRPuNQc2DAdd8OOjw3UVOGcIb0D4mDI2fG5DEGDPVfbz/2AiXrlwp6s81yk6/iay2YJP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710419487; c=relaxed/simple;
	bh=esxIP+Mn1RizCEnvwEiAOQ4xYLuuJSPTIKa725nOahs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STrBV/fh84ndgeKtGq+na40ORe3jhJVozvsznTv6vV6EHYRxtGtdjhpvLnPhmg/ezpgLG2Tvc1TK7OZJE7i76CNdx+VFGRtTLErQGQPk0O06xiAmYOnRDKsWSuwUV6xZUc1BIEkLvDujIteZylfoDql4NPA2/XDs2B9y9VhQ8Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9e.versanet.de ([83.135.90.158] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rkkEs-0003Ip-Sw; Thu, 14 Mar 2024 13:31:14 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, arinc.unal@arinc9.com
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Subject:
 Re: [PATCH] arm64: dts: rockchip: set PHY address of MT7531 switch to 0x1f
Date: Thu, 14 Mar 2024 13:31:13 +0100
Message-ID: <4682635.taCxCBeP46@diego>
In-Reply-To:
 <20240314-for-rockchip-mt7531-phy-address-v1-1-743b5873358f@arinc9.com>
References:
 <20240314-for-rockchip-mt7531-phy-address-v1-1-743b5873358f@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Donnerstag, 14. M=C3=A4rz 2024, 13:24:35 CET schrieb Ar=C4=B1n=C3=A7 =C3=
=9CNAL via B4 Relay:
> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
>=20
> The MT7531 switch listens on PHY address 0x1f on an MDIO bus. I've got two
> findings that support this. There's no bootstrapping option to change the
> PHY address of the switch. The Linux driver hardcodes 0x1f as the PHY
> address of the switch. So the reg property on the device tree is currently
> ignored by the Linux driver.
>=20
> Therefore, describe the correct PHY address on Banana Pi BPI-R2 Pro that
> has this switch.
>=20
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>

=46ixes: c1804463e5c6 ("arm64: dts: rockchip: Add mt7531 dsa node to BPI-R2=
=2DPro board")

> ---
>  arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/ar=
m64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> index 7b5f3904ef61..03d6d920446a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> @@ -525,9 +525,9 @@ &mdio0 {
>  	#address-cells =3D <1>;
>  	#size-cells =3D <0>;
> =20
> -	switch@0 {
> +	switch@1f {
>  		compatible =3D "mediatek,mt7531";
> -		reg =3D <0>;
> +		reg =3D <0x1f>;
> =20
>  		ports {
>  			#address-cells =3D <1>;
>=20
> ---
> base-commit: 0276d797531ea2d1865a04fbe54c659608f5788f
> change-id: 20240314-for-rockchip-mt7531-phy-address-ba6c2fff485f
>=20
> Best regards,
>=20





