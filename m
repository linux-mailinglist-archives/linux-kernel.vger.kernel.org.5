Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EECE77B666
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236632AbjHNKQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236911AbjHNKQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:16:24 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305D010CE;
        Mon, 14 Aug 2023 03:16:22 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-586bacac98aso37250367b3.2;
        Mon, 14 Aug 2023 03:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692008181; x=1692612981;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G0o4ebEFlNAX87hZsAliF30Sgi/kb42lIQpZnbBPD0w=;
        b=EURjeFEt1mx+tMUkzQBGoZyzgEkG/r33KhBgEKXFd9I43Gs6EQUnkIjes014Ls0PDY
         ktIff5+/Acxarq8NnzK/ha9FGUgJcgkP6lHasUY0EfFK5SXWN3v8DqqM1XmeQDMziaCI
         8paelRM9LSofW77B3vgJq6R9hinSeBlHkrtHjftlrgfD4Fm4fLyMb0meX0gSVKFVplec
         bwGO7DiEjIjPVExzUPdiKOvx2JmwoOSAMJHZxA8eEGl42Ptz1sso0TAayIJC0W5iCBM1
         RIOA+YawT2zqh1lRS98e542Fqq6qmS8v7c001ixx3FqM/P2Q95003YFi9ZtBza2IZREa
         wG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692008181; x=1692612981;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0o4ebEFlNAX87hZsAliF30Sgi/kb42lIQpZnbBPD0w=;
        b=DSLwRb0URRJPvlU4cW8UYAu0bUNSXbSQm7hoPKdVF0q314u4oZo6uWeFCm4vpWPu0R
         ufF+3lAlJ1HT+csYhvrYEDzjYnLE8fw47d2eSwf/gpUCHfNot5CMa3mdvk9dn/Ha+7ao
         5JxjV5BpdeBjNFRO/SVIs5iAHDLzJQAerk8ziiZxpNQSXjzHyHUMdvpb/dX8ljOH5ZbK
         Y0CHIqcMgG/8mqb9pjyz6PyUalZXaGWsqa1iAuh97zEFJbsn5ICmilgchifWztCixDDJ
         i5DsKM+KuMLTHh2WUFnEM2/vHJkg/iT+uxEtw3LKU+klQGQS0lx2SAqfXsCwVebW+qJ1
         fObQ==
X-Gm-Message-State: AOJu0YwlrLevFk6UYyLvLx4nn3B2vGKNs2gdsx0UaLQZFHRCCj8M3Rr9
        53oNWmOMO5229qxkMSEjIehI6UKF6ye4HEoUMyDlaR2UCFn9hc0y
X-Google-Smtp-Source: AGHT+IFRXFmnvs1XP7+ZHAGTY7osbFn2VU8DYPbpsxpCxMfuFkIh3fMd176Ur3qxcwUGUEf2b3tGgCAI19AXpgWko3E=
X-Received: by 2002:a0d:e201:0:b0:589:fb7b:4932 with SMTP id
 l1-20020a0de201000000b00589fb7b4932mr1667312ywe.42.1692008181196; Mon, 14 Aug
 2023 03:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAGgoGu7Vim82Hu1JKc+m6cPkcn7+WWDFwK5P_YE6grFQS9E21Q@mail.gmail.com>
 <ZNm2ihdTojuPJM2f@debian.me>
In-Reply-To: <ZNm2ihdTojuPJM2f@debian.me>
From:   Fawad Lateef <fawadlateef@gmail.com>
Date:   Mon, 14 Aug 2023 11:16:09 +0100
Message-ID: <CAGgoGu5XuHhVbnrNKBzhZyZH993bBHiLgjTrtyofvePZ-dxLow@mail.gmail.com>
Subject: Re: Question regarding Linux-6.3.5 and Sunxi A20 NAND/NFC support
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Linux Devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux sunXi <linux-sunxi@lists.linux.dev>,
        boris.brezillon@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas,

On Mon, 14 Aug 2023 at 06:07, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Mon, Aug 14, 2023 at 12:40:26AM +0100, Fawad Lateef wrote:
> > Hi,
> >
> > I am trying to make Linux-6.3.5 working on Olimex/Sunxi A20 SOM with NAND.
> >
> > Found that the Sunxi A20 NAND is supported in mainline kernel
> > (drivers/mtd/nand/raw/sunxi_nand.c) and following the guidelines here
> > (https://linux-sunxi.org/Mainline_NAND_Howto); I added the NFC chip
> > pin information in sunxi-a20.dtsi and defined/enabled the nfc
> > controller in the sunxi-a20-olinuxino-micro.dts files.
> >
> > The changes I made are below. Problem is when I define the nfc node
> > entry in dts file "without" pinctrl entry (pinctrl-0 = <&nand_pins_a>,
> > <&nand_cs0_pins_a>, <&nand_rb0_pins_a>;), the sunxi_nfc_probe function
> > is called (though the No NAND chip is detected).
> >
> > And if I define the pinctrl-0  in the nfc node, all I see related to
> > NAND/sunxi in the kernel boot log is this line:  platform
> > 1c03000.nand-controller: deferred probe pending.
> >
> > Can someone please guide me why the deferred probe is pending but
> > never call the sunxi_nfc_probe function?  And without pinctrl-0 entry
> > why probe function is being called?
> >
> > Seems like I am missing something basic here and any pointers to debug
> > this will be appreciated.
> >
> >
> > --- linux-6.3.5.orig/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> > 2023-05-30 14:17:29.000000000 +0100
> > +++ linux-6.3.5/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> > 2023-08-13 23:27:22.405058025 +0100
> > @@ -56,7 +56,7 @@
> >
> >   aliases {
> >   serial0 = &uart0;
> > - serial1 = &uart6;
> > + serial1 = &uart2;
> >   serial2 = &uart7;
> >   spi0 = &spi1;
> >   spi1 = &spi2;
> > @@ -66,17 +66,6 @@
> >   stdout-path = "serial0:115200n8";
> >   };
> >
> > - hdmi-connector {
> > - compatible = "hdmi-connector";
> > - type = "a";
> > -
> > - port {
> > - hdmi_con_in: endpoint {
> > - remote-endpoint = <&hdmi_out_con>;
> > - };
> > - };
> > - };
> > -
> >   leds {
> >   compatible = "gpio-leds";
> >   pinctrl-names = "default";
> > @@ -90,16 +79,55 @@
> >   };
> >  };
> >
> > -&ahci {
> > - target-supply = <&reg_ahci_5v>;
> > +&nfc {
> > + pinctrl-names = "default";
> > + pinctrl-0 = <&nand_pins_a>, <&nand_cs0_pins_a>, <&nand_rb0_pins_a>;
> >   status = "okay";
> > +
> > + nand@0 {
> > + #address-cells = <2>;
> > + #size-cells = <2>;
> > + reg = <0>;
> > + allwinner,rb = <0>;
> > +
> > + nand-ecc-mode = "hw";
> > + nand-on-flash-bbt;
> > + };
> > +
> > + boot0@0 {
> > + label = "boot0";
> > + reg = /bits/ 64 <0x0 0x200000>;
> > + };
> > +
> > + boot0-rescue@200000 {
> > + label = "boot0-rescue";
> > + reg = /bits/ 64 <0x200000 0x200000>;
> > + };
> > +
> > + uboot@400000 {
> > + label = "uboot";
> > + reg = /bits/ 64 <0x400000 0x200000>;
> > + };
> > +
> > + uboot-rescue@600000 {
> > + label = "uboot-rescue";
> > + reg = /bits/ 64 <0x600000 0x200000>;
> > + };
> > +
> > + main@800000 {
> > + label = "main";
> > + reg = /bits/ 64 <0x800000 0xff800000>;
> > + };
> > +
> >  };
> >
> > -&codec {
> > +&ahci {
> > + target-supply = <&reg_ahci_5v>;
> >   status = "okay";
> >  };
> >
> >  &cpu0 {
> > + clock-frequency = <900000000>;
> >   cpu-supply = <&reg_dcdc2>;
> >  };
> >
> > @@ -123,34 +151,24 @@
> >   status = "okay";
> >  };
> >
> > -&hdmi {
> > - status = "okay";
> > -};
> > -
> > -&hdmi_out {
> > - hdmi_out_con: endpoint {
> > - remote-endpoint = <&hdmi_con_in>;
> > - };
> > -};
> > -
> >  &i2c0 {
> > - status = "okay";
> > +        status = "okay";
> >
> > - axp209: pmic@34 {
> > - reg = <0x34>;
> > - interrupt-parent = <&nmi_intc>;
> > - interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> > - };
> > +        axp209: pmic@34 {
> > +                reg = <0x34>;
> > +                interrupt-parent = <&nmi_intc>;
> > +                interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> > +        };
> >  };
> >
> >  &i2c1 {
> > - status = "okay";
> > +        status = "okay";
> >
> > - eeprom: eeprom@50 {
> > - compatible = "atmel,24c16";
> > - reg = <0x50>;
> > - pagesize = <16>;
> > - };
> > +        eeprom: eeprom@50 {
> > +                compatible = "atmel,24c16";
> > +                reg = <0x50>;
> > +                pagesize = <16>;
> > +        };
> >  };
> >
> >  &i2c2 {
> > @@ -160,55 +178,6 @@
> >  &lradc {
> >   vref-supply = <&reg_vcc3v0>;
> >   status = "okay";
> > -
> > - button-191 {
> > - label = "Volume Up";
> > - linux,code = <KEY_VOLUMEUP>;
> > - channel = <0>;
> > - voltage = <191274>;
> > - };
> > -
> > - button-392 {
> > - label = "Volume Down";
> > - linux,code = <KEY_VOLUMEDOWN>;
> > - channel = <0>;
> > - voltage = <392644>;
> > - };
> > -
> > - button-601 {
> > - label = "Menu";
> > - linux,code = <KEY_MENU>;
> > - channel = <0>;
> > - voltage = <601151>;
> > - };
> > -
> > - button-795 {
> > - label = "Search";
> > - linux,code = <KEY_SEARCH>;
> > - channel = <0>;
> > - voltage = <795090>;
> > - };
> > -
> > - button-987 {
> > - label = "Home";
> > - linux,code = <KEY_HOMEPAGE>;
> > - channel = <0>;
> > - voltage = <987387>;
> > - };
> > -
> > - button-1184 {
> > - label = "Esc";
> > - linux,code = <KEY_ESC>;
> > - channel = <0>;
> > - voltage = <1184678>;
> > - };
> > -
> > - button-1398 {
> > - label = "Enter";
> > - linux,code = <KEY_ENTER>;
> > - channel = <0>;
> > - voltage = <1398804>;
> > - };
> >  };
> >
> >  &gmac_mdio {
> > @@ -239,10 +208,6 @@
> >   status = "okay";
> >  };
> >
> > -&otg_sram {
> > - status = "okay";
> > -};
> > -
> >  &pio {
> >   gmac_txerr: gmac-txerr-pin {
> >   pins = "PA17";
> > @@ -323,9 +288,9 @@
> >   status = "okay";
> >  };
> >
> > -&uart6 {
> > +&uart2 {
> >   pinctrl-names = "default";
> > - pinctrl-0 = <&uart6_pi_pins>;
> > + pinctrl-0 = <&uart2_pi_pins>;
> >   status = "okay";
> >  };
> >
> > @@ -352,3 +317,28 @@
> >   usb2_vbus-supply = <&reg_usb2_vbus>;
> >   status = "okay";
> >  };
> > +
> > +&fe0 {
> > + status = "disabled";
> > +};
> > +
> > +&fe1 {
> > + status = "disabled";
> > +};
> > +
> > +&be0 {
> > + status = "disabled";
> > +};
> > +
> > +&be1 {
> > + status = "disabled";
> > +};
> > +
> > +&tcon0 {
> > + status = "disabled";
> > +};
> > +
> > +&tcon1 {
> > + status = "disabled";
> > +};
> > +
> >
> >
> > --- linux-6.3.5.orig/arch/arm/boot/dts/sun7i-a20.dtsi 2023-05-30
> > 14:17:29.000000000 +0100
> > +++ linux-6.3.5/arch/arm/boot/dts/sun7i-a20.dtsi 2023-08-08
> > 00:30:04.689288733 +0100
> > @@ -345,6 +345,58 @@
> >   #size-cells = <0>;
> >   };
> >
> > + nand_pins_a: nand_base0@0 {
> > + allwinner,pins = "PC0", "PC1", "PC2",
> > + "PC5", "PC8", "PC9", "PC10",
> > + "PC11", "PC12", "PC13", "PC14",
> > + "PC15", "PC16";
> > + allwinner,function = "nand0";
> > + allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > + allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > + };
> > +
> > + nand_cs0_pins_a: nand_cs@0 {
> > + allwinner,pins = "PC4";
> > + allwinner,function = "nand0";
> > + allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > + allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > + };
> > +
> > + nand_cs1_pins_a: nand_cs@1 {
> > + allwinner,pins = "PC3";
> > + allwinner,function = "nand0";
> > + allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > + allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > + };
> > +
> > + nand_cs2_pins_a: nand_cs@2 {
> > + allwinner,pins = "PC17";
> > + allwinner,function = "nand0";
> > + allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > + allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > + };
> > +
> > + nand_cs3_pins_a: nand_cs@3 {
> > + allwinner,pins = "PC18";
> > + allwinner,function = "nand0";
> > + allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > + allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > + };
> > +
> > + nand_rb0_pins_a: nand_rb@0 {
> > + allwinner,pins = "PC6";
> > + allwinner,function = "nand0";
> > + allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > + allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > + };
> > +
> > + nand_rb1_pins_a: nand_rb@1 {
> > + allwinner,pins = "PC7";
> > + allwinner,function = "nand0";
> > + allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > + allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > + };
> > +
> >   spi0: spi@1c05000 {
> >   compatible = "allwinner,sun4i-a10-spi";
> >   reg = <0x01c05000 0x1000>;
> >
> >
>
> Thanks for the suggestion diff. Can you submit it as formal patch against
> current sunxi/for-next tree [1]? See
> Documentation/process/submitting-patches.rst for how to properly submit
> patches.
>

Sorry for my unclear email. I am currently facing issues when trying
to enable and use the MTD driver for A20 SOM (implemented and likely
maintained by Boris Brezillion); I am confused why the probe is not
called in deferred probe case and overall NAND on A20 SOM is not
detected.

I hope to get help in this regard, and of-course as soon as I got it
working, I will submit patches to be included in the kernel and DTS
files.

I am not sure why there are DTS files for A20 SOMs (especially one
sunxi-a20-olinuxino-micro.dts  which supposed to have NAND on the SOM)
without any NAND pinctrl and nfc node defined. When the kernel have
driver for it and I assume it should be working.

Added Boris Brezellion in the CC list, hoping to get some pointers and
suggestions from him too.

Thanks

Fawad Lateef


> Thanks.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/log/?h=sunxi/for-next
>
> --
> An old man doll... just what I always wanted! - Clara
