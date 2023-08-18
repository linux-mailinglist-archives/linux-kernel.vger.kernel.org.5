Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828197814BE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 23:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240727AbjHRVZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 17:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240618AbjHRVYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:24:42 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6FF1BF9;
        Fri, 18 Aug 2023 14:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1692393876; bh=M+DHT0rB/MweS/ca6aK+aZ+iPETlJQF4lcQpM2Cr3a8=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=GWFF9yOrac0IUrCu6n6Sq+HmdNFBO2Dh706GYFkKkyE7dgDZRcP+ljrlUsyrh+Qx1
         LjK2qPEPV8Oo6VtISQZtJbHe/0GOJF5QSnNUl1Nkcbn9n+en1fQczIDG9IWqTySrrL
         eu4jbLYF5Sybqd4j47Opmwzdb5chgBwkm6E2gaZw=
Date:   Fri, 18 Aug 2023 23:24:36 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Muhammed Efe Cetin <efectn@6tel.net>
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, heiko@sntech.de,
        sebastian.reichel@collabora.com, jonas@kwiboo.se
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: Add Orange Pi 5
Message-ID: <fjlgsejdzef3iap5qamzwp46hiqrjundlkrpbtlh23ldvnjstu@effddwoml7k5>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
        Muhammed Efe Cetin <efectn@6tel.net>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, 
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, heiko@sntech.de, 
        sebastian.reichel@collabora.com, jonas@kwiboo.se
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <cover.1692372351.git.efectn@6tel.net>
 <201e8df24c3a2f25c13d3f1d129f8be4fe2eb97a.1692372351.git.efectn@6tel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201e8df24c3a2f25c13d3f1d129f8be4fe2eb97a.1692372351.git.efectn@6tel.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muhammed,

On Fri, Aug 18, 2023 at 07:05:51PM +0300, Muhammed Efe Cetin wrote:
> Add initial support for OPi5 that includes support for USB2, PCIe2, Sata,
> Sdmmc, SPI Flash, PMIC.
> 
> Signed-off-by: Muhammed Efe Cetin <efectn@6tel.net>
>
> [...]
>
> +
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 1>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1800000>;
> +		poll-interval = <100>;
> +
> +		button-recovery {
> +			label = "Recovery";
> +			linux,code = <KEY_VENDOR>;
> +			press-threshold-microvolt = <1000>;

I calculated 1800. (1.8e6 * 10 / 10e3)

> +		};
> +	};
> +
>
> [...]
>
> +
> +	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_1v1_nldo_s3";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1100000>;
> +		regulator-max-microvolt = <1100000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};

This is still wrong. vcc_1v1_nldo_s3 is just alias for dcdc-reg6.

> +&i2c2 {
> +	status = "okay";
> +
> +	vdd_npu_s0: vdd_npu_mem_s0: regulator@42 {
> +		compatible = "rockchip,rk8602";
> +		reg = <0x42>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_npu_s0";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <550000>;
> +		regulator-max-microvolt = <950000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc5v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
> +&i2c6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c6m3_xfer>;
> +	status = "okay";
> +
> +	hym8563: rtc@51 {
> +		compatible = "haoyu,hym8563";
> +		reg = <0x51>;
> +		#clock-cells = <0>;
> +		clock-output-names = "hym8563";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hym8563_int>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
> +		wakeup-source;
> +	};
> +};
> +
> +&mdio1 {
> +	rgmii_phy1: ethernet-phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x1>;
> +	};
> +};
> +
> +&pcie2x1l2 {
> +	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_pcie20>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	gpio-func {
> +		leds_gpio: leds-gpio {
> +			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	hym8563 {
> +		hym8563_int: hym8563-int {
> +			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	usb-typec {
> +		usbc0_int: usbc0-int {
> +			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
> +		typec5v_pwren: typec5v-pwren {
> +			rockchip,pins = <3 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&saradc {
> +	vref-supply = <&avcc_1v8_s0>;
> +	status = "okay";
> +};
> +
> +&sdmmc {
> +	max-frequency = <150000000>;
> +	no-sdio;
> +	no-mmc;
> +	bus-width = <4>;
> +	cap-mmc-highspeed;

Is this useful for anything, when you have no-mmc specified?

> +	cap-sd-highspeed;
> +	disable-wp;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc_3v3_sd_s0>;
> +	vqmmc-supply = <&vccio_sd_s0>;
> +	status = "okay";
> +};
> +

With the above regulator issue fixed:

Reviewed-by: Ondřej Jirman <megi@xff.cz>

(I reviewed just for schematic <-> DT correspondece)

kind regards,
	o.

> -- 
> 2.41.0
> 
