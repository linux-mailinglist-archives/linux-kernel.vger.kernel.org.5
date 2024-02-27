Return-Path: <linux-kernel+bounces-82825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFB7868A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50AA11F234B9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2499254F98;
	Tue, 27 Feb 2024 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="iw3aeDfk"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C564DA0F;
	Tue, 27 Feb 2024 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020194; cv=none; b=mD+Si+mg5i+Z16kX1ZFjf7d1WYGBNKMcjLIx6oJdIJKXS6qVStyKOdxRQMPqM4/WAkraQEzPWyV8d7vZBxww58H7RjqXXxfwOPc6QwAhJi5J0SL+bz0ELSwkQam4W8mst2KQ0V7WrRxpepy3G0RYpvbLWLWa3npy0JQvk47guoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020194; c=relaxed/simple;
	bh=kqyoZ51n3c6Cyp+MZQKiiI//9HQl+OBfQlBpYU28yvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJueJfVJuVNOGA0GX6keJb6HQ3z/FRBk5FzfYe80LdvaWA+AwG0Am6UieJxJFBKS0l7voGxh/dRRbYdVQMsLSTE5PuI/BS9XM2lLRgffySeNtEoaeCxPgLV0zB2p08r4Dw+Ek2PAkiDJK1VuUgtKSj2XLXVAZWUS/4HeoOQwpEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=iw3aeDfk; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1709020191; x=1740556191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pj5/CkclhkxVz2RUPsfnvUgVyCv3GNYoQ2UzRNbyzp4=;
  b=iw3aeDfkZfAPEm9ox/jUghY6uSaACtaDrvBQ59o+ZFNNSYkDUNgR8nLn
   CDOoBE6WgSRoQmsMjjOjkdG47fu9rZvLAt/g5g+zVy+sD774n+HxtoHXp
   vmoszn6JEJZZYrbBLSKW5e5NdJh5AP4eJPelAXhp3CLj6WgqkxxGrNuc0
   yY5KnSg8E3AlZHuRX0X5qY9g3nHRB/mFc0bq9NCyzOOKBNcIXB1+JxzcK
   hc23nhAuy4M46HHdYaRUqE7WliANUszU5QpraNSu1u3GenaFvbHyAAn1x
   jXjbHNxweyTlTyT7MGTYpFQcT4fwCbWYt2xvZ1JpLDtXAfnLgVgAGzn00
   w==;
X-IronPort-AV: E=Sophos;i="6.06,187,1705359600"; 
   d="scan'208";a="35608635"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 27 Feb 2024 08:49:49 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id DD52F280075;
	Tue, 27 Feb 2024 08:49:48 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: shengjiu.wang@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: imx8mp-evk: Add HDMI audio sound card support
Date: Tue, 27 Feb 2024 08:49:49 +0100
Message-ID: <4905911.31r3eYUQgx@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <1709017406-12624-1-git-send-email-shengjiu.wang@nxp.com>
References: <1709017406-12624-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,

Am Dienstag, 27. Februar 2024, 08:03:25 CET schrieb Shengjiu Wang:
> The AUD2HTX is a digital module that provides a bridge between
> the Audio Subsystem and the HDMI RTX Subsystem. This
> module includes intermediate storage to queue SDMA transactions
> prior to being synchronized and passed to the HDMI
> RTX Subsystem over the Audio Link.
>=20
> AUD2HTX works as the cpu dai in HDMI audio sound card.
>=20
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>=20
> changes in v2:
> - remove 'status' in sound-hdmi
>=20
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 11 +++++++++++
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi    | 10 ++++++++++

Maybe split this patch into two:
* adding aud2htx node
* enabling board support

>  2 files changed, 21 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/bo=
ot/dts/freescale/imx8mp-evk.dts
> index f87fa5a948cc..0fc6c0d21cd6 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -138,6 +138,13 @@ simple-audio-card,codec {
> =20
>  	};
> =20
> +	sound-hdmi {
> +		compatible =3D "fsl,imx-audio-hdmi";
> +		model =3D "audio-hdmi";
> +		audio-cpu =3D <&aud2htx>;
> +		hdmi-out;
> +	};
> +
>  	reserved-memory {
>  		#address-cells =3D <2>;
>  		#size-cells =3D <2>;
> @@ -191,6 +198,10 @@ &A53_3 {
>  	cpu-supply =3D <&reg_arm>;
>  };
> =20
> +&aud2htx {
> +	status =3D "okay";
> +};
> +
>  &eqos {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pinctrl_eqos>;

This part looks good:
Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mp.dtsi
> index 9ab9c057f41e..721ab630d895 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1513,6 +1513,16 @@ micfil: audio-controller@30ca0000 {
>  					status =3D "disabled";
>  				};
> =20
> +				aud2htx: aud2htx@30cb0000 {
> +					compatible =3D "fsl,imx8mp-aud2htx";
> +					reg =3D <0x30cb0000 0x10000>;
> +					interrupts =3D <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
> +					clocks =3D <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_AUD2HTX_IPG>;
> +					clock-names =3D "bus";
> +					dmas =3D <&sdma2 26 2 0>;
> +					dma-names =3D "tx";
> +					status =3D "disabled";
> +				};

My WIP has the same node:
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

>  			};
> =20
>  			sdma3: dma-controller@30e00000 {
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



