Return-Path: <linux-kernel+bounces-152648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298A28AC1F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493BE1C20BA1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4DE41E22;
	Sun, 21 Apr 2024 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9YpNOSr"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A778825;
	Sun, 21 Apr 2024 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713739076; cv=none; b=dJPLHd5A1ZaFsM8eKDU/9uWOPZPq/5xKaMpXVwc+7lhC0izy3BBTkfo+TOytOwhHms3hsdBlL2tTBwtanHo/M9iEZ21Kl89og6KT/76JJLsJWmx7ld9b9j/aNSR95My2rAmALjo/zFrBTTHt4992dMFQyzTEvvL+Jo16jMpMshM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713739076; c=relaxed/simple;
	bh=ED2KUNybaTZCGHu1xf5jmu9Csg3u27LinEyUsaSmgWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugKaK1Ya6rMmbXc9iad0wTkx7bknc1CzeymJVsI/IjqFDGlJKY0M1vFr90DGPDdvp6cc8OZ8cm+GlNUxf2Kohrn9mZQnte3DgdrVOeGcyx3UZA4kC77zf5khxzV2rw8u/8yZFZfrG3oMU10INibFTimGZQDgiu/D5ISG/v7FZ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9YpNOSr; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed9fc77bbfso2915222b3a.1;
        Sun, 21 Apr 2024 15:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713739074; x=1714343874; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WUx899AlIPRyngzNugN2/dx6PADQZiMXRdrzUhUEewk=;
        b=i9YpNOSrdvv21wG14tSERwVPRIut3M4671XhFZdwWChONqbrGxQ/Ub5rfSB8EwwpYh
         PaSIiUAw/h8D0lgJ5GcB9Zr6D9M/l0f9jp9tgLJ94qwWZZQhsEQk9y+w9QXz3juy4vJ3
         q8T267+WtZjqq5XZd9j+0SF5k3JwUd2tNq7jMiKVGdZFeJUwl4Yv1wCrKkskGMUfwkWS
         2so7a4rPOfceji485+1oCfO5Fyr3V1cOq4JMDOAlJbfPM44cvuc90xXf9eq6QpsD/HLD
         ayWfpSx2oBF2i/WfLj0x7difbyDPp+7PuSNOg3AREOyUAruBw9Z2XjVWswnzQrvS+r2Y
         Xi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713739074; x=1714343874;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUx899AlIPRyngzNugN2/dx6PADQZiMXRdrzUhUEewk=;
        b=lZi6khn3dVIvCKbQhWROOS2MliF65FfroAQdgB03Ib5g11xYUS2PAvOoBtkTzAWmM+
         +zJdXtNfPgy1+hGEDUdxD9d05dwiw++VFUzNZKomcO0z7KO1eEnOkyLAGTnpm+5zHIOi
         +konY9s+9/RVVP/8+pr7jAae5KxcR/3xN6cLkornXFAchpgXc+AfJ4jkcd0rE6+ypRhZ
         AE5tqKiFv/E9XXAlBK2c3IbEh9e0aVjQRcQN6+m9eWOevmElNKor2j9TekQgX6cANa8U
         oQfla3Vgsp0vBpPFchpEiItVYTvEwmr7PcUzshyCIA94utX8eR8Y+DF0cpx6w5gSmsG7
         HctA==
X-Forwarded-Encrypted: i=1; AJvYcCXF5sq1P6pU5AwBdoteH6ka73u5ikNqcm2xVIDS3aakNOlfy11XJzsAEI7NfwUpzMZYtbU8uWD13MNRThepeDmWDCy76LoxeHcofDIBtbecBBGEoYOEHhkKxY4U8+RjIOiKboJU2HvjEbQzxiEzSLT+FxZw5D2ZsNteV6z0hNOpjJA/9w==
X-Gm-Message-State: AOJu0Yx8n4ca5pLgzvujqIkvMRGCfQIvJc1XOpsjUCsa42ry6IZo7Cwe
	OfeEyaqGfaCGSAgYPWdbdYiaUCnP+FoWS1DA6gEYvBpOYe/mDUiR
X-Google-Smtp-Source: AGHT+IHhfRLpiANtw5I0fxOhQwEu2KEub5ledxp7eabgu8DAb2biAXMA2w5yUgEs1D4Z4+S2q/ZFeg==
X-Received: by 2002:a05:6a21:9184:b0:1aa:5f83:12c6 with SMTP id tp4-20020a056a21918400b001aa5f8312c6mr9985746pzb.0.1713739073463;
        Sun, 21 Apr 2024 15:37:53 -0700 (PDT)
Received: from localhost ([2804:30c:1f6c:5400:ea32:e7c8:5bc0:103])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902704800b001e868e29fabsm6760920plt.251.2024.04.21.15.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 15:37:52 -0700 (PDT)
Date: Sun, 21 Apr 2024 19:38:38 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add AD4000
Message-ID: <ZiWVboPqrzyMJB9n@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1712585500.git.marcelo.schmitt@analog.com>
 <7c877c865f0b7da28d9f1f177b3b2692b0ae20b9.1712585500.git.marcelo.schmitt@analog.com>
 <CAMknhBGKNZhGbD7pQ0Z7SMCWqxqGux0LcO_wW0XGP4hLTOwNBg@mail.gmail.com>
 <ZhVfARtMfOLOPRid@debian-BULLSEYE-live-builder-AMD64>
 <20240413171409.4575fe6f@jic23-huawei>
 <87058695-a1a6-4e68-87c5-accdb8451bf4@baylibre.com>
 <20240414190907.000011e5@Huawei.com>
 <Zh7xo8__v-ghLcHP@debian-BULLSEYE-live-builder-AMD64>
 <20240420151727.767b2861@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240420151727.767b2861@jic23-huawei>

On 04/20, Jonathan Cameron wrote:
> On Tue, 16 Apr 2024 18:46:11 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
> > So, I have been trying to make this work, though I haven't been successful so
> > far, and I don't really think using pinctrl is a good solution for this either.
> > 
> > Comments inline.
> > 
> > On 04/14, Jonathan Cameron wrote:
> > > On Sat, 13 Apr 2024 12:33:54 -0500
> > > David Lechner <dlechner@baylibre.com> wrote:
> > >   
> > > > On 4/13/24 11:14 AM, Jonathan Cameron wrote:  
> > > > > On Tue, 9 Apr 2024 12:30:09 -0300
> > > > > Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> > > > >     
> > > > >> On 04/08, David Lechner wrote:    
> > > > >>> On Mon, Apr 8, 2024 at 9:32 AM Marcelo Schmitt
> > > > >>> <marcelo.schmitt@analog.com> wrote:      
> > > > >>>>    
> > > > 
> > > > ...
> > > >   
> > 
> > ...
> > 

..

> > 
> > The pinctrl configuration for this ADC would not be meant to change once after
> > boot as it looks to be the usual use case for pinctrl (including mediatek-bluetooth.txt).
> > 
> > Also, no suitable mux for the "3-wire" mode in
> > Documentation/devicetree/bindings/pinctrl/xlnx,pinctrl-zynq.yaml
> > to do it like Documentation/devicetree/bindings/net/mediatek-bluetooth.txt.
> > The zynq pinctrl driver (drivers/pinctrl/pinctrl-zynq.c) would have to be
> > updated to add the new mux function in 
> > static const struct zynq_pinmux_function zynq_pmux_functions[] = {
> > 	DEFINE_ZYNQ_PINMUX_FUNCTION(ethernet0, 1),
> > ...
> > 	DEFINE_ZYNQ_PINMUX_FUNCTION(axi_spi_single, 1),
> > 	DEFINE_ZYNQ_PINMUX_FUNCTION(axi_spi_multi, 2),
> > though this is not really a thing that's on zynq, but one that is related to
> > these ADCs so I'm not sure it should go there.
> 
> 
> I'd argue we are after a specific SPI controller setup for this.
> A controller driver would need modifying to make it work.

Ack, makes sense to me.

> 
> > 
> > > > For example, if we wanted to use 3-wire mode for reading
> > > > data, we would set the pinctrl to "default" to write the
> > > > register to configure the chip during driver probe. Then
> > > > to read data, we would change the pinctrl to "single" before
> > > > doing the SPI xfer to ensure that the ADC SDI pin is pulled
> > > > high independent of what the SDO line of the SPI controller
> > > > is currently doing.  
> > 
> > No, the pin configuration for this ADCs would be expected to change unrestricted
> > amount of times. The pin configuration would have to change every time a sample
> > read is made after a register access transfers and vice-versa. If we decide
> > to support span compression, every change to _scale would lead to pinctrl
> > configuration change.
> > 
> > At pin level, we would want to rise SPI controller SDO line to VIO but then
> > the new SDO pin config would conflict with SPI pin group config.
> > 
> > I included pinctrl properties in my test dts to make use of pinctrl framework.
> > Yet, that doesn't really alternate SPI line configuration we are using because
> > the SPI function that is in the PS (FPGA's Processing System) is not what we are
> > interfacing when using spi-engine. Copy of my test dts at end of email.
> > 
> > Currently, the SPI controller we are using to test with these exotic ADCs
> > is the spi-engine which is implemented in the FPGA as an IP block which
> > owns control of the bus lines (SPI, SDO, CS, ...). To alternate the
> > configuration of SPI lines (pull SDO (ADC SDI) up to VIO, connect controller CS
> > to ADC SDI, etc.) I think it should be done in the HDL project. I don't think
> > it's a good idea to hijack spi-engine lines through pinctrl.
> 
> Such functionality would need to be pushed to the spi controller driver
> which could know if there was any need to do anything like this, or if there
> was simply a register to set.
> 

Ack.

> > 
> > > 
> > > Ah ok.  This is implying that we are switching to a controllable
> > > mode to pull that pin high (or I guess one where it is always
> > > high).  I'm not sure if that's more common than an SPI controller
> > > where you can set the 'don't' care state to high or low.
> > > I assume we can't get away with just setting the output buffer
> > > to all 1s because it won't hold that state between transfers?  
> > 
> > I tried sending the tx buffer filled with 1s when testing this with a RPi4 but
> > it brought the controller SDO (ADC SDI) line low between each 8 bits of transfer
> > (attaching an image (yellow line is SCLK, green lines is controller SDO)).
> 
> Pity - thought that was overly optimistic.
> 
> > Anyway, can we have any guaranties with respect to controller SDO line behaviour
> > when its not clocking out data?
> 
> 
> > 
> > > 
> > > Feels like that could be rolled into the SPI subsystem with
> > > any necessary transitions handled there (maybe)  
> > 
> > To me, this sounds more reasonable than pinctrl.
> > Yeah, if we can set a don't' care state for the SDO line then that should be
> > enough for these ADCs.
> > Otherwise, can we really do anything if the controller can't keep SDO high?
> 
> There is one similar (ish) entry already.
> https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/spi/spi.h#L29
> #define	SPI_3WIRE_HIZ		_BITUL(15)	/* high impedance turnaround */
> in that it is controlling state in what I think would normally be a don't care state.
> 
> I think we could have an
> SPI_SDO_DONT_CARE_HIGH (naming to be improved upon ;) 
> that a driver could advertise support for and the spi device could request.
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/panel/panel-tpo-tpg110.c#L429
> 
> Implement that in the spi-gpio driver as a PoC probably and in your SPI copntoller
> driver.
> 
> Ultimately if the controller really isn't capable (including dances through pin
> mode changes if necessary) then the ADC won't work in this wiring with that host
> controller.
> 
> I'd propose something along these lines and see whether Mark + any other active
> SPI folk think it is reasonable or not?

Sounds promising. Will try implement something like that.

> 
> > 
> > > 
> > > Just to check, this isn't just a case of a missing pull up
> > > resistor to drag that line correctly when it isn't actively
> > > driven (combined with all 1s in the write buffer) etc?  
> > 
> > When using spi-engine, the controller SDO is connected to ADC SDI, controller
> > CS to ADC CNV and, for reg access, it works as conventional SPI.
> > spi-engine leaves the SDO line the state it was after last transfer so it we
> > can make it idle high during sample read. No hardware pull-up needed.
> 
> Fair enough. No multi master support I guess (that is a bit obscure for
> SPI).  A little ugly that it's dependent on the last access - so you would need
> to do a dummy access if the normal last bit was wrong level?

Seems I've been lucky with it but yes, we would need a dummy transfer to put
controller SDO line in the desired state. I'm thinking it should not be
difficult to make spi-engine SDO line always idle high (or idle in a
pre-configured state). I'll talk with the guys in the HDL team and what can be
done about it.

Thanks,
Marcelo

> 
> Jonathan
> 
> > 
> > Marcelo
> > 
> > > 
> > > Jonathan
> > > 
> > >   
> > 
> > The device tree source file I was using for testing with the ADC with the
> > changes for using pinctrl. Didn't really work.
> > 
> > // SPDX-License-Identifier: GPL-2.0
> > /*
> >  * Analog Devices ADAQ4003
> >  * https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad400x
> >  * https://wiki.analog.com/resources/eval/user-guides/ad400x
> >  *
> >  * hdl_project: <pulsar_adc_pmdz/zed>
> >  * board_revision: <>
> >  *
> >  * Copyright (C) 2016-2023 Analog Devices Inc.
> >  */
> > /dts-v1/;
> > 
> > #include "zynq-zed.dtsi"
> > #include "zynq-zed-adv7511.dtsi"
> > #include <dt-bindings/pinctrl/pinctrl-zynq.h>
> > 
> > / {
> > 	adc_vref: regulator-vref {
> > 		compatible = "regulator-fixed";
> > 		regulator-name = "EVAL 5V Vref";
> > 		regulator-min-microvolt = <5000000>;
> > 		regulator-max-microvolt = <5000000>;
> > 		regulator-always-on;
> > 	};
> > 
> > 	adc_vdd: regulator-vdd {
> > 		compatible = "regulator-fixed";
> > 		regulator-name = "Eval VDD supply";
> > 		regulator-min-microvolt = <1800000>;
> > 		regulator-max-microvolt = <1800000>;
> > 		regulator-always-on;
> > 	};
> > 
> > 	adc_vio: regulator-vio {
> > 		compatible = "regulator-fixed";
> > 		regulator-name = "Eval VIO supply";
> > 		regulator-min-microvolt = <3300000>;
> > 		regulator-max-microvolt = <3300000>;
> > 		regulator-always-on;
> > 	};
> > };
> > 
> > &pinctrl0 {
> > 	/* Restore conventional SPI pin configuration */
> > 	pinctrl_spi_default: default_config {
> > 		mux {
> > 			/* Are these the ones used by spi-engine? */
> > 			groups = "spi0_0_grp";
> > 			function = "spi0";
> > 		};
> > 		conf {
> > 			groups = "spi0_0_grp";
> > 			power-source = <IO_STANDARD_LVCMOS33>;
> > 		};
> > 		conf-spi-sdo {
> > 			pins = "MIO17"; /* SPI0 SDO? */
> > 			bias-disable;
> > 		};
> > 	};
> > 
> > 	/* Pull-up SPI SDO (ADC SDI) to VIO */
> > 	pinctrl_spi_single: single_config {
> > 		conf-spi-sdo {
> > 			pins = "MIO17"; /* Conflicts with SPI0 pin group */
> > 			bias-pull-up;
> > 		};
> > 	};
> > };
> > 
> > &fpga_axi {
> > 	rx_dma: rx-dmac@44a30000 {
> > 		compatible = "adi,axi-dmac-1.00.a";
> > 		reg = <0x44a30000 0x1000>;
> > 		#dma-cells = <1>;
> > 		interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
> > 		clocks = <&clkc 17>;
> > 
> > 		adi,channels {
> > 			#size-cells = <0>;
> > 			#address-cells = <1>;
> > 
> > 			dma-channel@0 {
> > 				reg = <0>;
> > 				adi,source-bus-width = <32>;
> > 				adi,source-bus-type = <1>;
> > 				adi,destination-bus-width = <64>;
> > 				adi,destination-bus-type = <0>;
> > 			};
> > 		};
> > 	};
> > 
> > 	axi_pwm_gen: axi-pwm-gen@ {
> > 		compatible = "adi,axi-pwmgen";
> > 		reg = <0x44b00000 0x1000>;
> > 		label = "cnv";
> > 		#pwm-cells = <2>;
> > 		clocks = <&spi_clk>;
> > 	};
> > 
> > 	spi_clk: axi-clkgen@44a70000 {
> > 		compatible = "adi,axi-clkgen-2.00.a";
> > 		reg = <0x44a70000 0x10000>;
> > 		#clock-cells = <0>;
> > 		clocks = <&clkc 15>, <&clkc 15>;
> > 		clock-names = "s_axi_aclk", "clkin1";
> > 		clock-output-names = "spi_clk";
> > 	};
> > 
> > 	axi_spi_engine_0: spi@44a00000 {
> > 		compatible = "adi,axi-spi-engine-1.00.a";
> > 		reg = <0x44a00000 0x1000>;
> > 		interrupt-parent = <&intc>;
> > 		interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
> > 		clocks = <&clkc 15 &spi_clk>;
> > 		clock-names = "s_axi_aclk", "spi_clk";
> > 		num-cs = <1>;
> > 
> > 		#address-cells = <0x1>;
> > 		#size-cells = <0x0>;
> > 
> > 		adaq4003: adc@0 {
> > 			compatible = "adi,adaq4003";
> > 			reg = <0>;
> > 			spi-max-frequency = <102000000>;
> > 			spi-cpha;
> > 			pinctrl-names = "default", "single";
> > 			pinctrl-0 = <&pinctrl_spi_default>;
> > 			pinctrl-1 = <&pinctrl_spi_single>;
> > 			vdd-supply = <&adc_vdd>;
> > 			vio-supply = <&adc_vio>;
> > 			ref-supply = <&adc_vref>;
> > 			adi,high-z-input;
> > 			adi,gain-milli = <454>;
> > 		};
> > 	};
> > };
> 

