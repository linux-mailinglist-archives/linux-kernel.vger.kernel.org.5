Return-Path: <linux-kernel+bounces-77970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D91860D84
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DCE2824B5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CC01B59B;
	Fri, 23 Feb 2024 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="SoG8xm5R"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E08411CBF;
	Fri, 23 Feb 2024 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679206; cv=none; b=UvVCquP6qGXnmaTCAAKqcs7/DWDTtFztpzq6PgbJ9qqKEKrSUqKtdDYCMlUfU/iAsSWuPdDTI3AUTxYoYoDhQCO9sd8GO7790A/+MTXY+u0r8bwOpPqjIzrZAFxzMIZ7Mhpdv5cgRrl+UWls0WJE8DLK3w4+zzVdeCVYc4/XQwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679206; c=relaxed/simple;
	bh=Bh0dPiH+mKxEWK6cUDABbed2Pe8Xm10K5FtG9kZd1mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYL15NorZSxUWWttS0GX9QX9YOQ57sXwaA3jKflZkK1WhruqnUlBKOjqtKBkYZw/WolleI+zVsLirPBjR4/pYLTDqH9/ncOlZn8uEat8kR7ArwPKkR4+LpWffxM8t70p0bHLgcpr4BoagqSZ8MExslgoDL2pXegOm7lUmMRILZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=SoG8xm5R; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708679202; x=1740215202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VgtHxEGL1VIdQ9PPu9qSENiuIzT8Bdf8Y4csSbIwc7k=;
  b=SoG8xm5RIoCo09pdf2wJMXimWeE9udDm+63J1uKMa5RQglRpJK5GuaXf
   dAERKWnZiUlWnmMpNsQ7d2RjTT+dPfzcUVFF7+TWRH2UDC6ZaavnUFa8T
   UP3FAMZ/S8AwLZDqH0Y4RpffCqeDTckOhok2h+r0F/yXgJZqYv800lYeI
   aJofscXk+5lYZPv7lNlPBh5ERZFaJCLoYlzeBfb2vjyJWDjstyN0V9gNf
   LOaIMs3HKswMX7JeLaHnZWhEVsPXlQ3B9vNqDG9b47D2yrKVNTsTtndJq
   1VctAepuG3mqpYPTAlBgqNG8/Sm3Cjo1tc9sm8QHKkR1yaebne1nOa8/X
   A==;
X-IronPort-AV: E=Sophos;i="6.06,179,1705359600"; 
   d="scan'208";a="35562337"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Feb 2024 10:06:34 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id F316D280075;
	Fri, 23 Feb 2024 10:06:33 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp-evk: Add HDMI audio sound card support
Date: Fri, 23 Feb 2024 10:06:33 +0100
Message-ID: <1786327.VLH7GnMWUR@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <1708675339-8180-1-git-send-email-shengjiu.wang@nxp.com>
References: <1708675339-8180-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,

thanks for the patch.

Am Freitag, 23. Februar 2024, 09:02:18 CET schrieb Shengjiu Wang:
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
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 12 ++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi    | 10 ++++++++++
>  2 files changed, 22 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/bo=
ot/dts/freescale/imx8mp-evk.dts
> index f87fa5a948cc..63f6e72fa18a 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -138,6 +138,14 @@ simple-audio-card,codec {
> =20
>  	};
> =20
> +	sound-hdmi {
> +		compatible =3D "fsl,imx-audio-hdmi";
> +		model =3D "audio-hdmi";
> +		audio-cpu =3D <&aud2htx>;
> +		hdmi-out;
> +		status =3D "okay";

No need for 'status' here.

Don't you need to configure the PAI as well? See [1]
for downstream implementation. I'm wondering because I had to hack something
similar. Without I got no HDMI audio.

Best regards,
Alexander

[1] https://github.com/Freescale/linux-fslc/blob/6.1-2.0.x-imx/drivers/gpu/=
drm/imx/imx8mp-hdmi-pavi.c#L51-L59

> +	};
> +
>  	reserved-memory {
>  		#address-cells =3D <2>;
>  		#size-cells =3D <2>;
> @@ -191,6 +199,10 @@ &A53_3 {
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
>  			};
> =20
>  			sdma3: dma-controller@30e00000 {
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



