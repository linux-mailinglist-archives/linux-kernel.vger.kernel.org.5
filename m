Return-Path: <linux-kernel+bounces-12291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 836D981F266
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 23:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232F21F231EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0720A482ED;
	Wed, 27 Dec 2023 22:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tqcXeBIQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333AD481BA;
	Wed, 27 Dec 2023 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703715541;
	bh=lVrc7pxkQHkTuollDpRgSMgm5cYN81tWN40U/e2kEUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tqcXeBIQEcV3CNcZJ16qIstgq1OEJm881nbEZVThQzd9IBww5OuWVAof3T2xqS1hp
	 tB+EG2z+6ImNyrwIr8YUuBL0xDYrd+FbFwenLHY7uKsQOlqY5oVCUUIWDiBgndGrvf
	 Vrh2CCa1a3Vj4i9VNu4HkefX6rGg2N45Vs1m/CF/4cTZ+xNxRVo7MVoy+FaiAi8dSx
	 tTAaHKKmDqJayfeGlqpNRM3iuNIUZizxRNcki5vNHupAgQf7OQXKaGNmkj7t/uOJUA
	 lM5n74o63FkLtqZvpLS2WstF+QtK6c4tnKNj4nMIJ81vROjzjmto4xQLpLQU/4GfSM
	 VuvYrA4aOFHCw==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2BEC43780624;
	Wed, 27 Dec 2023 22:19:01 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id CA6A4106CE00; Wed, 27 Dec 2023 01:16:01 +0100 (CET)
Date: Wed, 27 Dec 2023 01:16:01 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: John Clark <inindev@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, 
	Thomas McKahan <tmckahan@singleboardsolutions.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: rockchip: support poweroff on the
 rock-5b
Message-ID: <pqvmguq77qbxmuxsushrz4ykxtmvkugirbxnckmbfk47gx2u5n@cz2kllnjr6ba>
References: <20231225222859.17153-1-inindev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kvxm4plewcxgwfam"
Content-Disposition: inline
In-Reply-To: <20231225222859.17153-1-inindev@gmail.com>


--kvxm4plewcxgwfam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 25, 2023 at 10:28:19PM +0000, John Clark wrote:
> Allow the rock-5b to poweroff its pmic. When issuing a "shutdown -h now"
> on the rock-5b it reboots instead. Defining 'system-power-controller'
> allows the rk806 to power down.
>=20
> Commit c699fbfdfd54 ("arm64: dts: rockchip: Support poweroff on
> NanoPC-T6") similarly resolves this issue for the nanopc-t6.
>=20
> Signed-off-by: John Clark <inindev@gmail.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> Changes since v1:
>  - added commit message with additional patch detail
>  - expressed the related commit using checkpatch
>=20
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64=
/boot/dts/rockchip/rk3588-rock-5b.dts
> index 74719aaf697c..dc7b88f29172 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -426,6 +426,8 @@ pmic@0 {
>  		pinctrl-0 =3D <&pmic_pins>, <&rk806_dvs1_null>,
>  			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> =20
> +		system-power-controller;
> +
>  		vcc1-supply =3D <&vcc5v0_sys>;
>  		vcc2-supply =3D <&vcc5v0_sys>;
>  		vcc3-supply =3D <&vcc5v0_sys>;
> --=20
> 2.43.0
>=20
>=20

--kvxm4plewcxgwfam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmWLbL0ACgkQ2O7X88g7
+ppLdRAAh2XPhGTc/H7YdLn4Qr1Z2zdInwHqPU48aPogwAwNH0X4GOjp+e05nCPG
umdF7rRq+ZQvwp5wADlZ76cGpJ1PhxyiXGXjv00EvflDBb0S/edJjvrhxj4MFJMl
e5UJH8pQNLaJlCk2wpz0nSEO7MiCM5xnukb8aUAuXJhunjqrFEXT4b8I88kmWlW5
YmcvT40usLIv7s9tyYyy0l9KE/BdPBQ/ANDhKfJaulN2s3+UdfIco8cgUuR2UaUX
Ry3cqQUm7jLi3iDVAwUTS8lCv+3gI//D890PEh4KDd5XCsU5q5Y0XYi/WcXWNmJQ
hgbfyWSgAXToOc1AKFj2STX+hgESqLMigV1MbZOeDBVUajJ9U9d9I0ewMlGxjNwB
reCEvU60sH6LrO37Lxmzwt+w1G8oD1NA6LWPglhh3CAPGnOXW0Fq53TIs9DdZ0x6
vVRXWTevFPYwXTUehJD1PzLmJ0vUEwHXBtErcOcfllAieRetQMr9A5RwDNao6nST
j3kxWh3ExyXX48sAOU3b0AhF+lbqojesaxtXweXj6Nn9hPz6qvDyqWHn9nd9bL2e
E4rW7i91zVuovFC1ExDsLkypFMm7Wxxkte82NgbWAMGXC0eosSs+246wQWMlNniZ
7nyYUW/tin2mfYvugbyYzgpsbI4nW8gtoE3JgMuM0gEQzQr+jjU=
=+bGO
-----END PGP SIGNATURE-----

--kvxm4plewcxgwfam--

