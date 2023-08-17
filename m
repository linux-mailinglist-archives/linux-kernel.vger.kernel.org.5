Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3965B77F82B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351610AbjHQN5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351603AbjHQN5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:57:13 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AD22710;
        Thu, 17 Aug 2023 06:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1692280627; bh=lHsMpMBWoaXU9+vM+W4um07WyzClqhuMHmJs6+Gnpq8=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=a8MJmahxfE5FVhjTqEhuHS7d5AxvvD62ST0VK3d/FHv6rXa9vIdn4JEX4ZTpGBTcS
         7xHjaAugXUiLI1assny4bNiDs53bpLiwvgUNfk+4PFPqZgITnc1dr6+/wClagRB/zj
         XtRQbWXctsKCCYBSvA1aUTGIue2rb2dLOh+zJGMo=
Date:   Thu, 17 Aug 2023 15:57:07 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Muhammed Efe Cetin <efectn@6tel.net>
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        sebastian.reichel@collabora.com
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Orange Pi 5
Message-ID: <dz2i6ix6dphyu6dwsqgvx7byoxegmdlsc6dwhyxd3uffqus6jo@r6jnxz7jprdv>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
        Muhammed Efe Cetin <efectn@6tel.net>, conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de, 
        krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org, 
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, robh+dt@kernel.org, 
        sebastian.reichel@collabora.com
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <ecgsk4j72q32alaw37c4irxzflk6sdd7o7ekrsigc6wbhy5dzd@hfgerdtgskt3>
 <20230817133356.110348-1-efectn@6tel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230817133356.110348-1-efectn@6tel.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muhammed,

On Thu, Aug 17, 2023 at 04:33:55PM +0300, Muhammed Efe Cetin wrote:
> 
> Hi, Ondřej
> 
> Thanks for reviews, i'll fix them soon.
> 
> On 15.08.2023 19:39, Ondřej Jirman wrote:
> > Hello Muhammed,
> > 
> >> [...]
> >> +
> >> +	adc-keys {
> >> +		compatible = "adc-keys";
> >> +		io-channels = <&saradc 1>;
> >> +		io-channel-names = "buttons";
> >> +		keyup-threshold-microvolt = <1800000>;
> >> +		poll-interval = <100>;
> >> +
> >> +		vol-up-key {
> >> +			label = "volume up";
> >> +			linux,code = <KEY_VOLUMEUP>;
> >> +			press-threshold-microvolt = <17000>;
> >> +		};
> >> +
> >> +		vol-down-key {
> >> +			label = "volume down";
> >> +			linux,code = <KEY_VOLUMEDOWN>;
> >> +			press-threshold-microvolt = <417000>;
> >> +		};
> >> +
> >> +		menu-key {
> >> +			label = "menu";
> >> +			linux,code = <KEY_MENU>;
> >> +			press-threshold-microvolt = <890000>;
> >> +		};
> >> +
> >> +		back-key {
> >> +			label = "back";
> >> +			linux,code = <KEY_BACK>;
> >> +			press-threshold-microvolt = <1235000>;
> > 
> > None of these 4 buttons are in the scehmatic. There's one recovery button hooked
> > to saradc 0, instead.
> 
> Will remove these too. I won't add recovery button because of it's mostly used for rockusb.

Recovery button is useful from userspace, too. Please keep it. You already have
the DT nodes, please just reduce them to one node for the recovery key.

> >> [...]
> > 
> >> +	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
> >> +		compatible = "regulator-fixed";
> >> +		regulator-name = "vcc_1v1_nldo_s3";
> >> +		regulator-always-on;
> >> +		regulator-boot-on;
> >> +		regulator-min-microvolt = <1100000>;
> >> +		regulator-max-microvolt = <1100000>;
> >> +		vin-supply = <&vcc5v0_sys>;
> >> +	};
> > 
> > There's no such regulator on the board.
> 
> It's connected to PMIC https://i.imgur.com/sVJdC5K.png

It's not a separate fixed regulator. It's a PMIC output from buck6 https://megous.com/dl/tmp/8630fa17407c75b9.png

So this is VDD2_DDR_S3. If you want to keep the alias, just add extra alias to
dcdc-reg6 like this:

		...
	vcc_1v1_nldo_s3: vdd2_ddr_s3: dcdc-reg6 {
		...

> > 
> >> +	vbus5v0_typec: vbus5v0-typec-regulator {
> >> +		compatible = "regulator-fixed";
> >> +		regulator-name = "vbus5v0_typec";
> >> +		regulator-min-microvolt = <5000000>;
> >> +		regulator-max-microvolt = <5000000>;
> >> +		enable-active-high;
> >> +		gpio = <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;
> >> +		vin-supply = <&vcc5v0_usb>;
> >> +		pinctrl-names = "default";
> >> +		pinctrl-0 = <&typec5v_pwren>;
> >> +	};
> > 
> > No such power rail on the board. This should be VBUS_TYPEC power rail.
> > Please name regulators/power rails as they are named in the schematic.
> > Otherwise it's impossible to cross-check DT against schematic.
> 
> Perhaps i can add it as a comment line. Otherwise the current name seems OK to
> me but still open to suggestions.

Please just use the name that's in the schematic, even if it's subotpimal. Your
comment will not be seen in debugfs/sysfs and other places, where it's also
useful for debugging.

> > 
> > No such regulator on the board. You might have meant VCC3V3_PCIE30,
> > or not?
> 
> Yes. However their naming in schematics is pretty nonsense. The board doesn't
> have PCIe3, i think current naming is more appropriate.

Same as above. It's more important to be able to match DT/runtime debug outputs
and schematic than having a subjectively more meaningful name which is not used
anywhere in the documentation.

> >> +	sata {
> >> +		sata_reset:sata-reset{
> >> +			rockchip,pins = <3 RK_PD1 RK_FUNC_GPIO &pcfg_pull_up>;
> > 
> > Not what you think: https://megous.com/dl/tmp/f135580b68cb5dfe.png
> > 
> >> +		};
> >> +	};
> >> +};
> >> +
> >> +&pwm2 {
> >> +	pinctrl-names = "active";
> >> +	pinctrl-0 = <&pwm2m0_pins>;
> >> +	status = "okay";
> >> +};
> >> +
> >> +&pwm6 {
> >> +	pinctrl-names = "active";
> >> +	pinctrl-0 = <&pwm6m0_pins>;
> >> +	status = "okay";
> >> +};
> >> +
> >> +&saradc {
> >> +	vref-supply = <&avcc_1v8_s0>;
> >> +	status = "okay";
> >> +};
> >> +
> >> +&sata0 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&sata_reset>;
> >> +	status = "disabled";
> >> +};
> > 
> > Where do you see a SATA port? http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-5.html
> > 
> > Or a reset signal in the schematic?
> 
> It's needed to use sata node once you want to use mSata SSD. I don't know if
> it works without sata_reset pinctrl. Don't have mSata SSD to try.

Ok, that makes sense. It would be better to add this once you can test it, though.
And if there's no way to switch between SATA and PCIe at runtime, it's probably
just another thing for an overlay which would enable/disable/add all the appropriate
DT nodes.

thank you,
	o.
