Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7870677B70C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjHNKsm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Aug 2023 06:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjHNKsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:48:12 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55C8DD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:48:09 -0700 (PDT)
Received: from [192.168.2.144] (bband-dyn221.178-41-211.t-com.sk [178.41.211.221])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id BEB661F54D;
        Mon, 14 Aug 2023 12:48:05 +0200 (CEST)
Date:   Mon, 14 Aug 2023 12:47:59 +0200
From:   Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH v4 4/4] arm64: dts: allwinner: h616: Add BigTreeTech Pi
 support
To:     Jernej =?iso-8859-2?q?=A9krabec?= <jernej.skrabec@gmail.com>
Cc:     Martin Botka <martin.botka1@gmail.com>,
        Martin Botka <martin@biqu3d.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Martin Botka <martin@biqu3d.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Andrew Lunn <andrew@lunn.ch>, Icenowy Zheng <uwu@icenowy.me>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Message-Id: <ZBNDZR.IENEPBA0KL4D2@somainline.org>
In-Reply-To: <9148039.CDJkKcVGEf@jernej-laptop>
References: <20230807145349.2220490-1-martin@biqu3d.com>
        <10318766.nUPlyArG6x@jernej-laptop> <168CZR.KVQVUV8KXJ5Y1@somainline.org>
        <9148039.CDJkKcVGEf@jernej-laptop>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Aug 14 2023 at 12:26:07 PM +02:00:00, Jernej �krabec 
<jernej.skrabec@gmail.com> wrote:
> Dne nedelja, 13. avgust 2023 ob 18:22:49 CEST je Martin Botka 
> napisal(a):
>>  On Sun, Aug 13 2023 at 05:55:35 PM +02:00:00, Jernej �krabec
>> 
>>  <jernej.skrabec@gmail.com> wrote:
>>  > Dne ponedeljek, 07. avgust 2023 ob 16:53:24 CEST je Martin Botka
>>  >
>>  > napisal(a):
>>  >>  The BigTreeTech Pi is an H616 based board based on CB1.
>>  >>  Just in Rpi format board.
>>  >>
>>  >>  It features the same internals as BTT CB1 but adds:
>>  >>      - Fan port
>>  >>      - IR receiver
>>  >>      - ADXL345 Accelerometer connector via SPI
>>  >>      - 24V DC power supply via terminal plugs
>>  >>      - USB to CAN module connector (The actual USB to CAN 
>> happens on
>>  >>
>>  >> the
>>  >>
>>  >>  external module)
>>  >>
>>  >>  List of currently working things is same as BTT CB1 but also:
>>  >>      - IR receiver
>>  >>      - ADXL345 connector
>>  >>
>>  >>  Signed-off-by: Martin Botka <martin@biqu3d.com>
>>  >>  Reviewed-by: Andre Przywara <andre.przywara@arm.com>
>>  >>  ---
>>  >>
>>  >>  Changes in V2:
>>  >>      - Add UART alongside aliases and chosen for it
>>  >>      - Add model string
>>  >>      - Enable IR receiver
>>  >>      - Enable SPI0 for ADXL345 connector
>>  >>
>>  >>  Changes in V3:
>>  >>      - Add missing semicolons
>>  >>      - Add pinctrl for SPI0
>>  >>
>>  >>   arch/arm64/boot/dts/allwinner/Makefile        |  1 +
>>  >>   .../allwinner/sun50i-h616-bigtreetech-pi.dts  | 70
>>  >>
>>  >> +++++++++++++++++++
>>  >>
>>  >>   2 files changed, 71 insertions(+)
>>  >>   create mode 100644
>>  >>
>>  >>  arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
>>  >>
>>  >>  diff --git a/arch/arm64/boot/dts/allwinner/Makefile
>>  >>  b/arch/arm64/boot/dts/allwinner/Makefile index
>>  >>
>>  >> 7b386428510b..0b6232a7f328
>>  >>
>>  >>  100644
>>  >>  --- a/arch/arm64/boot/dts/allwinner/Makefile
>>  >>  +++ b/arch/arm64/boot/dts/allwinner/Makefile
>>  >>  @@ -39,5 +39,6 @@ dtb-$(CONFIG_ARCH_SUNXI) +=
>>  >>
>>  >> sun50i-h6-pine-h64-model-b.dtb
>>  >>
>>  >>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
>>  >>
>>  >>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
>>  >>   dtb-$(CONFIG_ARCH_SUNXI) += 
>> sun50i-h616-bigtreetech-cb1-manta.dtb
>>  >>
>>  >>  +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-pi.dtb
>>  >>
>>  >>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
>>  >>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
>>  >>
>>  >>  diff --git
>>  >>
>>  >> a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
>>  >>
>>  >>  b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts 
>> new
>>  >>
>>  >> file
>>  >>
>>  >>  mode 100644
>>  >>  index 000000000000..b0d0386e8f13
>>  >>  --- /dev/null
>>  >>  +++ 
>> b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
>>  >>  @@ -0,0 +1,70 @@
>>  >>  +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
>>  >>  +/*
>>  >>  + * Copyright (C) 2023 Martin Botka <martin@biqu3d.com>.
>>  >>  + */
>>  >>  +
>>  >>  +/dts-v1/;
>>  >>  +
>>  >>  +#include "sun50i-h616-bigtreetech-cb1.dtsi"
>>  >>  +
>>  >>  +/ {
>>  >>  +	model = "BigTreeTech Pi";
>>  >>  +	compatible = "bigtreetech,pi", "allwinner,sun50i-h616";
>>  >>  +
>>  >>  +	aliases {
>>  >>  +		serial0 = &uart0;
>>  >>  +	};
>>  >>  +
>>  >>  +	chosen {
>>  >>  +		stdout-path = "serial0:115200n8";
>>  >>  +	};
>>  >>  +};
>>  >>  +
>>  >>  +&ehci0 {
>>  >>  +	status = "okay";
>>  >>  +};
>>  >>  +
>>  >>  +&ehci1 {
>>  >>  +	status = "okay";
>>  >>  +};
>>  >>  +
>>  >>  +&ehci2 {
>>  >>  +	status = "okay";
>>  >>  +};
>>  >>  +
>>  >>  +&ehci3 {
>>  >>  +	status = "okay";
>>  >>  +};
>>  >>  +
>>  >>  +&ir {
>>  >>  +	status = "okay";
>>  >>  +};
>>  >>  +
>>  >>  +&ohci0 {
>>  >>  +	status = "okay";
>>  >>  +};
>>  >>  +
>>  >>  +&ohci1 {
>>  >>  +	status = "okay";
>>  >>  +};
>>  >>  +
>>  >>  +&ohci2 {
>>  >>  +	status = "okay";
>>  >>  +};
>>  >>  +
>>  >>  +&ohci3 {
>>  >>  +	status = "okay";
>>  >>  +};
>>  >>  +
>>  >>  +&spi0 {
>>  >>  +	/* SPI connection for onboard connector for ADXL345 
>> accelerometer
>>  >
>>  > */
>>  >
>>  >>  +	status = "okay";
>>  >>  +	pinctrl-names = "default";
>>  >>  +	pinctrl-0 = <&spi0_pins>, <&spi0_cs0_pin>;
>>  >
>>  > Driver and compatible for ADXL345 already exists, why don't you 
>> add
>>  > child node
>>  > for it?
>>  >
>>  > Best regards,
>>  > Jernej
>> 
>>  Ah. So the ADXL345 actually wont be driven by kernel.
> 
> DT is hardware description, it's not concerned what is done on 
> software side,
> either kernel or user space.
Im aware. But this is not a device that is on the board. Its simply a 
connector for the device.
Like Rpi has connectors for camera module :)
> 
>>  The SPI connection is enabled so that klipper (3d printer firmware) 
>> can
>>  be told to look for ADXL345 at this SPI and use it on its own.
>> 
>>  Klipper will initialize and communicate with the ADXL on its own.
> 
> What do you mean by firmware? User space app? In this case I suppose 
> you'll use
> direct SPI commands from user space? AFAIK that's less and less 
> supported by
> kernel (in contrast to I2C).
Firmware as in 3d printer firmware. Klipper runs on the board (CB1 or 
BTT Pi) and is indeed an userspace app.
And indeed uses direct SPI commands to the device.

The reason for this is the flexibility.
If Klipper read the values from kernel or well from the files the ADXL 
driver would create
then it would be unable to communicate with ADXL that is on toolhead 
board. Or would have to have
direct initialization either way for those. Thus it just controls the 
ADXL itself :)

I understand that this may be bit confusing. If there is still 
something not clear im more then happy to explain in
full detail how the userspace and 3D printer communicate :)

Cheers,
Martin.
> 
> Best regards,
> Jernej
> 
>> 
>>  >>  +};
>>  >>  +
>>  >>  +&uart0 {
>>  >>  +	pinctrl-names = "default";
>>  >>  +	pinctrl-0 = <&uart0_ph_pins>;
>>  >>  +	status = "okay";
>>  >>  +};
> 
> 
> 
> 


