Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBF478195B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 13:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjHSLvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 07:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjHSLvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 07:51:00 -0400
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF964682;
        Sat, 19 Aug 2023 04:48:40 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e51:0:640:23ee:0])
        by forward101a.mail.yandex.net (Yandex) with ESMTP id E377A46C9E;
        Sat, 19 Aug 2023 14:48:36 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id LmhQkrJDXiE0-65sFpoqX;
        Sat, 19 Aug 2023 14:48:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail; t=1692445715;
        bh=GZPfdaMhut5zVIxAjFfhNCTfyfY27k076tF5JfoAhdk=;
        h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
        b=OIDA7YqAmMrrnGlWjTR031IUxvxVMMVB1FtzfG5FluZijbeCqQodr8d2n0ENvEOW2
         hWVPtWHd1BCAjjTwTRBTw0oA8xO+w7WdRm5rx3XaKKXD+X8/wTqbMSHp89juyzwcSh
         zWZr8TP+b4bL4SQdYk9wz6ighC6m0ncQBLZgfpSk=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@6tel.net
From:   Muhammed Efe Cetin <efectn@6tel.net>
To:     megi@xff.cz
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org, efectn@6tel.net,
        heiko@sntech.de, jonas@kwiboo.se,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        sebastian.reichel@collabora.com
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: Add Orange Pi 5
Date:   Sat, 19 Aug 2023 14:48:20 +0300
Message-ID: <20230819114821.29878-1-efectn@6tel.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <fjlgsejdzef3iap5qamzwp46hiqrjundlkrpbtlh23ldvnjstu@effddwoml7k5>
References: <fjlgsejdzef3iap5qamzwp46hiqrjundlkrpbtlh23ldvnjstu@effddwoml7k5>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondřej,

On 19.08.2023 00:24, Ondřej Jirman wrote:
> Hi Muhammed,
> 
> On Fri, Aug 18, 2023 at 07:05:51PM +0300, Muhammed Efe Cetin wrote:
>> Add initial support for OPi5 that includes support for USB2, PCIe2, Sata,
>> Sdmmc, SPI Flash, PMIC.
>>
>> Signed-off-by: Muhammed Efe Cetin <efectn@6tel.net>
>>
>> [...]
>>
>> +
>> +	adc-keys {
>> +		compatible = "adc-keys";
>> +		io-channels = <&saradc 1>;
>> +		io-channel-names = "buttons";
>> +		keyup-threshold-microvolt = <1800000>;
>> +		poll-interval = <100>;
>> +
>> +		button-recovery {
>> +			label = "Recovery";
>> +			linux,code = <KEY_VENDOR>;
>> +			press-threshold-microvolt = <1000>;
> 
> I calculated 1800. (1.8e6 * 10 / 10e3)
> 
>> +		};
>> +	};
>> +
>>
>> [...]
>>
>> +
>> +	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc_1v1_nldo_s3";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <1100000>;
>> +		regulator-max-microvolt = <1100000>;
>> +		vin-supply = <&vcc5v0_sys>;
>> +	};
> 
> This is still wrong. vcc_1v1_nldo_s3 is just alias for dcdc-reg6.

You sound right. Compared opi5 and several rk3588 boards, opi5 has different design than others. Should we also add regulator-min-microvolt and regulator-max-microvolt to dcdc-reg6 or only add vcc_1v1_nldo_s3 as alias? It seems better to add them according to schematics.

> 
>> +&i2c2 {
>> +	status = "okay";
>> +
>> +	vdd_npu_s0: vdd_npu_mem_s0: regulator@42 {
>> +		compatible = "rockchip,rk8602";
>> +		reg = <0x42>;
>> +		fcs,suspend-voltage-selector = <1>;
>> +		regulator-name = "vdd_npu_s0";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <550000>;
>> +		regulator-max-microvolt = <950000>;
>> +		regulator-ramp-delay = <2300>;
>> +		vin-supply = <&vcc5v0_sys>;
>> +
>> +		regulator-state-mem {
>> +			regulator-off-in-suspend;
>> +		};
>> +	};
>> +};
>> +
>> +&i2c6 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&i2c6m3_xfer>;
>> +	status = "okay";
>> +
>> +	hym8563: rtc@51 {
>> +		compatible = "haoyu,hym8563";
>> +		reg = <0x51>;
>> +		#clock-cells = <0>;
>> +		clock-output-names = "hym8563";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&hym8563_int>;
>> +		interrupt-parent = <&gpio0>;
>> +		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
>> +		wakeup-source;
>> +	};
>> +};
>> +
>> +&mdio1 {
>> +	rgmii_phy1: ethernet-phy@1 {
>> +		compatible = "ethernet-phy-ieee802.3-c22";
>> +		reg = <0x1>;
>> +	};
>> +};
>> +
>> +&pcie2x1l2 {
>> +	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
>> +	vpcie3v3-supply = <&vcc3v3_pcie20>;
>> +	status = "okay";
>> +};
>> +
>> +&pinctrl {
>> +	gpio-func {
>> +		leds_gpio: leds-gpio {
>> +			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +
>> +	hym8563 {
>> +		hym8563_int: hym8563-int {
>> +			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +
>> +	usb-typec {
>> +		usbc0_int: usbc0-int {
>> +			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
>> +		};
>> +
>> +		typec5v_pwren: typec5v-pwren {
>> +			rockchip,pins = <3 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +};
>> +
>> +&saradc {
>> +	vref-supply = <&avcc_1v8_s0>;
>> +	status = "okay";
>> +};
>> +
>> +&sdmmc {
>> +	max-frequency = <150000000>;
>> +	no-sdio;
>> +	no-mmc;
>> +	bus-width = <4>;
>> +	cap-mmc-highspeed;
> 
> Is this useful for anything, when you have no-mmc specified?
> 
>> +	cap-sd-highspeed;
>> +	disable-wp;
>> +	sd-uhs-sdr104;
>> +	vmmc-supply = <&vcc_3v3_sd_s0>;
>> +	vqmmc-supply = <&vccio_sd_s0>;
>> +	status = "okay";
>> +};
>> +
> 
> With the above regulator issue fixed:
> 
> Reviewed-by: Ondřej Jirman <megi@xff.cz>
> 
> (I reviewed just for schematic <-> DT correspondece)
> 
> kind regards,
> 	o.
> 
>> -- 
>> 2.41.0
>>

Regards,
Efe
