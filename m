Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C52B77D5BC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbjHOWBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238769AbjHOWBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:01:17 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722A91FEE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:01:15 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a7d7e5fb03so4492268b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692136874; x=1692741674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EanoirrAIIqmjEmFxPEGErGDDAw5E8I+jQbh8PxdYrU=;
        b=Do4jZ7jAN02ACPuBm4mLKSg776UDwsiuLUSd1Ycj272fRJZY3EE5MoXos4WsV1joNi
         57Ulp5WaY8fX/iIYsHYIcyCMcuv3RFJUncIKXP6bBXTSxvvngtJ2pyT/obrFXRxDpazs
         +/ZicRfAD95lJvnHtN3SkJBpZt2yhLnTUN4lP8TLfEDzTIdLzirBYy1NoBT1tFg5DJ9U
         kGCPnL7mxHkE6PE5F81uddpQnwElnVHattSZ0lJ+3viaoX0CKNNH1jqLH1RMR3Ex4aD6
         1Sv6rYF4DVIJEEIZSc/7BTKGDfm6f5Lv202eF+G6mzuSH3Te22PZFu7Rjz3uWSut44TG
         qAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692136874; x=1692741674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EanoirrAIIqmjEmFxPEGErGDDAw5E8I+jQbh8PxdYrU=;
        b=Prxrtg8FrspYCgwLXAvGWLEnAbXxHseuE1MgEg2nAKS2d9qY86BP7PDz6+/H9p4M/H
         3UFLniFszO2d5dM4o83Zl/h2eISkpY3cCOu9daC9Hf9xISedqKQm6RACcBiXz/jyoW1q
         H3f9a7NfwfUJe6XSEyUlamNTcRGBna0WDablMNeLYaeVaDn+cqXrz8CaZgWvMOdijhW9
         9oYgcIiDQljy+Fsbyvz7dsDP++OPoVctXYL/mO8SHGOdTrenPC82btwBHvN2GU9gErHp
         eQ5shl8jbxkfLsqdLH9Rk9KKZiPG1/ptHRdpl6HS2XCTwmFgpdKr5ObZ3+0dVSIk/fIx
         MmTw==
X-Gm-Message-State: AOJu0YxGmyDIcpDHt8LLqQoPApTo8ScSBkkclAP6bGwlKYd/9HzjzVMs
        +2421KXCnbJ+8wCr3B/mi5/4xFh4nvdTuGR+OvFnYQso
X-Google-Smtp-Source: AGHT+IHLzfVjBlYs+ef8iyZs5oJ0i4x0j9rwMup2L5KJLyWOFpr9WOyieiHvc8Q9/WUJDjtrMM0hsJz7LqjBzfVuO6Y=
X-Received: by 2002:a05:6808:1391:b0:3a4:8e9b:e5cb with SMTP id
 c17-20020a056808139100b003a48e9be5cbmr19892632oiw.1.1692136874441; Tue, 15
 Aug 2023 15:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAGgoGu7Vim82Hu1JKc+m6cPkcn7+WWDFwK5P_YE6grFQS9E21Q@mail.gmail.com>
 <ZNm2ihdTojuPJM2f@debian.me> <CAGgoGu5XuHhVbnrNKBzhZyZH993bBHiLgjTrtyofvePZ-dxLow@mail.gmail.com>
In-Reply-To: <CAGgoGu5XuHhVbnrNKBzhZyZH993bBHiLgjTrtyofvePZ-dxLow@mail.gmail.com>
From:   Fawad Lateef <fawadlateef@gmail.com>
Date:   Tue, 15 Aug 2023 23:01:02 +0100
Message-ID: <CAGgoGu5iTE1xeupwTUUAcJv59294dNQJEf9oUWQKF72hrpFxRw@mail.gmail.com>
Subject: Re: Question regarding Linux-6.3.5 and Sunxi A20 NAND/NFC support
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux sunXi <linux-sunxi@lists.linux.dev>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        boris.brezillon@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Can someone guide me? I am not sure what I am missing here.

I am trying to debug the code but I assume that the SUNXI NAND driver
is supposed to be working and that something is missing from my
changes and additions to the dts/dtsi for A20 SOM.

Thanks in advance


On Mon, 14 Aug 2023 at 11:16, Fawad Lateef <fawadlateef@gmail.com> wrote:
>
> Hi Bagas,
>
> On Mon, 14 Aug 2023 at 06:07, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >
> > On Mon, Aug 14, 2023 at 12:40:26AM +0100, Fawad Lateef wrote:
> > > Hi,
> > >
> > > I am trying to make Linux-6.3.5 working on Olimex/Sunxi A20 SOM with NAND.
> > >
> > > Found that the Sunxi A20 NAND is supported in mainline kernel
> > > (drivers/mtd/nand/raw/sunxi_nand.c) and following the guidelines here
> > > (https://linux-sunxi.org/Mainline_NAND_Howto); I added the NFC chip
> > > pin information in sunxi-a20.dtsi and defined/enabled the nfc
> > > controller in the sunxi-a20-olinuxino-micro.dts files.
> > >
> > > The changes I made are below. Problem is when I define the nfc node
> > > entry in dts file "without" pinctrl entry (pinctrl-0 = <&nand_pins_a>,
> > > <&nand_cs0_pins_a>, <&nand_rb0_pins_a>;), the sunxi_nfc_probe function
> > > is called (though the No NAND chip is detected).
> > >
> > > And if I define the pinctrl-0  in the nfc node, all I see related to
> > > NAND/sunxi in the kernel boot log is this line:  platform
> > > 1c03000.nand-controller: deferred probe pending.
> > >
> > > Can someone please guide me why the deferred probe is pending but
> > > never call the sunxi_nfc_probe function?  And without pinctrl-0 entry
> > > why probe function is being called?
> > >
> > > Seems like I am missing something basic here and any pointers to debug
> > > this will be appreciated.
> > >
> > >
> > > --- linux-6.3.5.orig/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> > > 2023-05-30 14:17:29.000000000 +0100
> > > +++ linux-6.3.5/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> > > 2023-08-13 23:27:22.405058025 +0100
> > > @@ -56,7 +56,7 @@
> > >
> > >   aliases {
> > >   serial0 = &uart0;
> > > - serial1 = &uart6;
> > > + serial1 = &uart2;
> > >   serial2 = &uart7;
> > >   spi0 = &spi1;
> > >   spi1 = &spi2;
> > > @@ -66,17 +66,6 @@
> > >   stdout-path = "serial0:115200n8";
> > >   };
> > >
> > > - hdmi-connector {
> > > - compatible = "hdmi-connector";
> > > - type = "a";
> > > -
> > > - port {
> > > - hdmi_con_in: endpoint {
> > > - remote-endpoint = <&hdmi_out_con>;
> > > - };
> > > - };
> > > - };
> > > -
> > >   leds {
> > >   compatible = "gpio-leds";
> > >   pinctrl-names = "default";
> > > @@ -90,16 +79,55 @@
> > >   };
> > >  };
> > >
> > > -&ahci {
> > > - target-supply = <&reg_ahci_5v>;
> > > +&nfc {
> > > + pinctrl-names = "default";
> > > + pinctrl-0 = <&nand_pins_a>, <&nand_cs0_pins_a>, <&nand_rb0_pins_a>;
> > >   status = "okay";
> > > +
> > > + nand@0 {
> > > + #address-cells = <2>;
> > > + #size-cells = <2>;
> > > + reg = <0>;
> > > + allwinner,rb = <0>;
> > > +
> > > + nand-ecc-mode = "hw";
> > > + nand-on-flash-bbt;
> > > + };
> > > +
> > > + boot0@0 {
> > > + label = "boot0";
> > > + reg = /bits/ 64 <0x0 0x200000>;
> > > + };
> > > +
> > > + boot0-rescue@200000 {
> > > + label = "boot0-rescue";
> > > + reg = /bits/ 64 <0x200000 0x200000>;
> > > + };
> > > +
> > > + uboot@400000 {
> > > + label = "uboot";
> > > + reg = /bits/ 64 <0x400000 0x200000>;
> > > + };
> > > +
> > > + uboot-rescue@600000 {
> > > + label = "uboot-rescue";
> > > + reg = /bits/ 64 <0x600000 0x200000>;
> > > + };
> > > +
> > > + main@800000 {
> > > + label = "main";
> > > + reg = /bits/ 64 <0x800000 0xff800000>;
> > > + };
> > > +
> > >  };
> > >
> > > -&codec {
> > > +&ahci {
> > > + target-supply = <&reg_ahci_5v>;
> > >   status = "okay";
> > >  };
> > >
> > >  &cpu0 {
> > > + clock-frequency = <900000000>;
> > >   cpu-supply = <&reg_dcdc2>;
> > >  };
> > >
> > > @@ -123,34 +151,24 @@
> > >   status = "okay";
> > >  };
> > >
> > > -&hdmi {
> > > - status = "okay";
> > > -};
> > > -
> > > -&hdmi_out {
> > > - hdmi_out_con: endpoint {
> > > - remote-endpoint = <&hdmi_con_in>;
> > > - };
> > > -};
> > > -
> > >  &i2c0 {
> > > - status = "okay";
> > > +        status = "okay";
> > >
> > > - axp209: pmic@34 {
> > > - reg = <0x34>;
> > > - interrupt-parent = <&nmi_intc>;
> > > - interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> > > - };
> > > +        axp209: pmic@34 {
> > > +                reg = <0x34>;
> > > +                interrupt-parent = <&nmi_intc>;
> > > +                interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> > > +        };
> > >  };
> > >
> > >  &i2c1 {
> > > - status = "okay";
> > > +        status = "okay";
> > >
> > > - eeprom: eeprom@50 {
> > > - compatible = "atmel,24c16";
> > > - reg = <0x50>;
> > > - pagesize = <16>;
> > > - };
> > > +        eeprom: eeprom@50 {
> > > +                compatible = "atmel,24c16";
> > > +                reg = <0x50>;
> > > +                pagesize = <16>;
> > > +        };
> > >  };
> > >
> > >  &i2c2 {
> > > @@ -160,55 +178,6 @@
> > >  &lradc {
> > >   vref-supply = <&reg_vcc3v0>;
> > >   status = "okay";
> > > -
> > > - button-191 {
> > > - label = "Volume Up";
> > > - linux,code = <KEY_VOLUMEUP>;
> > > - channel = <0>;
> > > - voltage = <191274>;
> > > - };
> > > -
> > > - button-392 {
> > > - label = "Volume Down";
> > > - linux,code = <KEY_VOLUMEDOWN>;
> > > - channel = <0>;
> > > - voltage = <392644>;
> > > - };
> > > -
> > > - button-601 {
> > > - label = "Menu";
> > > - linux,code = <KEY_MENU>;
> > > - channel = <0>;
> > > - voltage = <601151>;
> > > - };
> > > -
> > > - button-795 {
> > > - label = "Search";
> > > - linux,code = <KEY_SEARCH>;
> > > - channel = <0>;
> > > - voltage = <795090>;
> > > - };
> > > -
> > > - button-987 {
> > > - label = "Home";
> > > - linux,code = <KEY_HOMEPAGE>;
> > > - channel = <0>;
> > > - voltage = <987387>;
> > > - };
> > > -
> > > - button-1184 {
> > > - label = "Esc";
> > > - linux,code = <KEY_ESC>;
> > > - channel = <0>;
> > > - voltage = <1184678>;
> > > - };
> > > -
> > > - button-1398 {
> > > - label = "Enter";
> > > - linux,code = <KEY_ENTER>;
> > > - channel = <0>;
> > > - voltage = <1398804>;
> > > - };
> > >  };
> > >
> > >  &gmac_mdio {
> > > @@ -239,10 +208,6 @@
> > >   status = "okay";
> > >  };
> > >
> > > -&otg_sram {
> > > - status = "okay";
> > > -};
> > > -
> > >  &pio {
> > >   gmac_txerr: gmac-txerr-pin {
> > >   pins = "PA17";
> > > @@ -323,9 +288,9 @@
> > >   status = "okay";
> > >  };
> > >
> > > -&uart6 {
> > > +&uart2 {
> > >   pinctrl-names = "default";
> > > - pinctrl-0 = <&uart6_pi_pins>;
> > > + pinctrl-0 = <&uart2_pi_pins>;
> > >   status = "okay";
> > >  };
> > >
> > > @@ -352,3 +317,28 @@
> > >   usb2_vbus-supply = <&reg_usb2_vbus>;
> > >   status = "okay";
> > >  };
> > > +
> > > +&fe0 {
> > > + status = "disabled";
> > > +};
> > > +
> > > +&fe1 {
> > > + status = "disabled";
> > > +};
> > > +
> > > +&be0 {
> > > + status = "disabled";
> > > +};
> > > +
> > > +&be1 {
> > > + status = "disabled";
> > > +};
> > > +
> > > +&tcon0 {
> > > + status = "disabled";
> > > +};
> > > +
> > > +&tcon1 {
> > > + status = "disabled";
> > > +};
> > > +
> > >
> > >
> > > --- linux-6.3.5.orig/arch/arm/boot/dts/sun7i-a20.dtsi 2023-05-30
> > > 14:17:29.000000000 +0100
> > > +++ linux-6.3.5/arch/arm/boot/dts/sun7i-a20.dtsi 2023-08-08
> > > 00:30:04.689288733 +0100
> > > @@ -345,6 +345,58 @@
> > >   #size-cells = <0>;
> > >   };
> > >
> > > + nand_pins_a: nand_base0@0 {
> > > + allwinner,pins = "PC0", "PC1", "PC2",
> > > + "PC5", "PC8", "PC9", "PC10",
> > > + "PC11", "PC12", "PC13", "PC14",
> > > + "PC15", "PC16";
> > > + allwinner,function = "nand0";
> > > + allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > > + allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > > + };
> > > +
> > > + nand_cs0_pins_a: nand_cs@0 {
> > > + allwinner,pins = "PC4";
> > > + allwinner,function = "nand0";
> > > + allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > > + allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > > + };
> > > +
> > > + nand_cs1_pins_a: nand_cs@1 {
> > > + allwinner,pins = "PC3";
> > > + allwinner,function = "nand0";
> > > + allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > > + allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > > + };
> > > +
> > > + nand_cs2_pins_a: nand_cs@2 {
> > > + allwinner,pins = "PC17";
> > > + allwinner,function = "nand0";
> > > + allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > > + allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > > + };
> > > +
> > > + nand_cs3_pins_a: nand_cs@3 {
> > > + allwinner,pins = "PC18";
> > > + allwinner,function = "nand0";
> > > + allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > > + allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > > + };
> > > +
> > > + nand_rb0_pins_a: nand_rb@0 {
> > > + allwinner,pins = "PC6";
> > > + allwinner,function = "nand0";
> > > + allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > > + allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > > + };
> > > +
> > > + nand_rb1_pins_a: nand_rb@1 {
> > > + allwinner,pins = "PC7";
> > > + allwinner,function = "nand0";
> > > + allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > > + allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > > + };
> > > +
> > >   spi0: spi@1c05000 {
> > >   compatible = "allwinner,sun4i-a10-spi";
> > >   reg = <0x01c05000 0x1000>;
> > >
> > >
> >
> > Thanks for the suggestion diff. Can you submit it as formal patch against
> > current sunxi/for-next tree [1]? See
> > Documentation/process/submitting-patches.rst for how to properly submit
> > patches.
> >
>
> Sorry for my unclear email. I am currently facing issues when trying
> to enable and use the MTD driver for A20 SOM (implemented and likely
> maintained by Boris Brezillion); I am confused why the probe is not
> called in deferred probe case and overall NAND on A20 SOM is not
> detected.
>
> I hope to get help in this regard, and of-course as soon as I got it
> working, I will submit patches to be included in the kernel and DTS
> files.
>
> I am not sure why there are DTS files for A20 SOMs (especially one
> sunxi-a20-olinuxino-micro.dts  which supposed to have NAND on the SOM)
> without any NAND pinctrl and nfc node defined. When the kernel have
> driver for it and I assume it should be working.
>
> Added Boris Brezellion in the CC list, hoping to get some pointers and
> suggestions from him too.
>
> Thanks
>
> Fawad Lateef
>
>
> > Thanks.
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/log/?h=sunxi/for-next
> >
> > --
> > An old man doll... just what I always wanted! - Clara
