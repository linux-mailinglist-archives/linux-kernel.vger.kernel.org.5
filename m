Return-Path: <linux-kernel+bounces-24708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9A082C11D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9341F25ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB9C6D1BB;
	Fri, 12 Jan 2024 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P1QGGUCc"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3AC6D1B1;
	Fri, 12 Jan 2024 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40CDo1jA077687;
	Fri, 12 Jan 2024 07:50:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705067401;
	bh=lbPtsYeeY36RDpZ1dpZig59RqjnFtrAMDUMxS5lJiOg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=P1QGGUCcDQTxgCawaAy38Us4GC2dmjSNZuufDxydkw5c5hystE1J9OKTXiEBaUHao
	 noAlvBW5guI4vd84Fg9glwttkG5/9dkOnRgU5SBcAevkz/ei6d3Fug1FDYvH87xybK
	 E6vlgGlDPiRKAFGWDaeuOKsL3tSSeg1Ah/JSyY5E=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40CDo161065703
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Jan 2024 07:50:01 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 07:50:00 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 07:50:00 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40CDo0JX110565;
	Fri, 12 Jan 2024 07:50:00 -0600
Date: Fri, 12 Jan 2024 07:50:00 -0600
From: Nishanth Menon <nm@ti.com>
To: Sjoerd Simons <sjoerd@collabora.com>
CC: <linux-arm-kernel@lists.infradead.org>, Roger Quadros <rogerq@kernel.org>,
        <kernel@collabora.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am625-beagleplay: Use the builtin
 mdio bus
Message-ID: <20240112135000.b54xz3boeua7y2jf@music>
References: <20240112124505.2054212-1-sjoerd@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240112124505.2054212-1-sjoerd@collabora.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 13:44-20240112, Sjoerd Simons wrote:
> The beagleplay dts was using a bit-bang gpio mdio bus as a work-around
> for errata i2329. However since commit d04807b80691 ("net: ethernet: ti:
> davinci_mdio: Add workaround for errata i2329") the mdio driver itself
> already takes care of this errata for effected silicon, which landed
> well before the beagleplay dts. So i suspect the reason for the
> workaround in upstream was simply due to copying the vendor dts.
> 
> Switch the dts to the ti,cpsw-mdio instead so it described the actual
> hardware and is consistent with other AM625 based boards
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> 
> ---

We have had issues with the ethernet integration previously (also why
ethernet in u-boot is not yet functional on beagleplay[1]).

https://openbeagle.org/beagleplay/beagleplay/-/issues/101

we should probably do a 1000 boot nfs test or something to ensure this
doesn't introduce regressions (I recollect mdio wasn't stable on
beagleplay) and switching to bitbang driver stopped all complains.

[1] https://lore.kernel.org/u-boot/20230822121350.51324-1-rogerq@kernel.org/
> 
>  .../arm64/boot/dts/ti/k3-am625-beagleplay.dts | 42 +++++++------------
>  1 file changed, 16 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> index eadbdd9ffe37..49fb21ba62b0 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> @@ -29,7 +29,6 @@ aliases {
>  		i2c3 = &main_i2c3;
>  		i2c4 = &wkup_i2c0;
>  		i2c5 = &mcu_i2c0;
> -		mdio-gpio0 = &mdio0;
>  		mmc0 = &sdhci0;
>  		mmc1 = &sdhci1;
>  		mmc2 = &sdhci2;
> @@ -231,27 +230,6 @@ simple-audio-card,codec {
>  		};
>  	};
>  
> -	/* Workaround for errata i2329 - just use mdio bitbang */
> -	mdio0: mdio {
> -		compatible = "virtual,mdio-gpio";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&mdio0_pins_default>;
> -		gpios = <&main_gpio0 86 GPIO_ACTIVE_HIGH>, /* MDC */
> -			<&main_gpio0 85 GPIO_ACTIVE_HIGH>; /* MDIO */
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		cpsw3g_phy0: ethernet-phy@0 {
> -			reg = <0>;
> -		};
> -
> -		cpsw3g_phy1: ethernet-phy@1 {
> -			reg = <1>;
> -			reset-gpios = <&main_gpio1 5 GPIO_ACTIVE_LOW>;
> -			reset-assert-us = <25>;
> -			reset-deassert-us = <60000>; /* T2 */
> -		};
> -	};
>  };
>  
>  &main_pmx0 {
> @@ -312,8 +290,8 @@ AM62X_IOPAD(0x00b4, PIN_INPUT_PULLUP, 1) /* (K24) GPMC0_CSn3.I2C2_SDA */
>  
>  	mdio0_pins_default: mdio0-default-pins {
>  		pinctrl-single,pins = <
> -			AM62X_IOPAD(0x0160, PIN_OUTPUT, 7) /* (AD24) MDIO0_MDC.GPIO0_86 */
> -			AM62X_IOPAD(0x015c, PIN_INPUT, 7) /* (AB22) MDIO0_MDIO.GPIO0_85 */
> +			AM62X_IOPAD(0x0160, PIN_OUTPUT, 0) /* (AD24) MDIO0_MDC */
> +			AM62X_IOPAD(0x015c, PIN_INPUT, 0) /* (AB22) MDIO0_MDIO */
>  		>;
>  	};
>  
> @@ -611,8 +589,20 @@ &cpsw_port2 {
>  };
>  
>  &cpsw3g_mdio {
> -	/* Workaround for errata i2329 - Use mdio bitbang */
> -	status = "disabled";
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mdio0_pins_default>;
> +
> +	cpsw3g_phy0: ethernet-phy@0 {
> +		reg = <0>;
> +	};
> +
> +	cpsw3g_phy1: ethernet-phy@1 {
> +		reg = <1>;
> +		reset-gpios = <&main_gpio1 5 GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <25>;
> +		reset-deassert-us = <60000>; /* T2 */
> +	};
>  };
>  
>  &main_gpio0 {
> -- 
> 2.43.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

