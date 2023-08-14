Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406C877B0A1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjHNFHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjHNFH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:07:29 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EAFE73;
        Sun, 13 Aug 2023 22:07:28 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bbf8cb61aeso24432175ad.2;
        Sun, 13 Aug 2023 22:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691989647; x=1692594447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4FvbhgfPtRoQdXEdvEExdmNYKsXlPA1pwL1Oh71ly60=;
        b=AnR9qIM5QgEy8+Z64kyTDg7HbDRdr0u7dDMH2p/KeZ3zmnCr+qYmec5eIwp18/hP/d
         UFVVey7AovZTwusmINLWrzqp24AnLPiiTUNUQ438BhkCCdrri6biCHsg07vMvuF3sYIi
         BsK49uTKOHkIwJWInWZ+ikffpGHOcgQwcUc5dvT6GOBWOACZyosdgZMR7nZFqZ+rUqOQ
         rHPFmbgKP5HAvRk6xHQxqqELVPRhifPWHEGGht3PlKuXjufLuDQmww1hm5kBNxIGhEDw
         rp6cpvsTDhvdhztJj0Pgy3+3FRIGlQGdVA/iRcrfgxk851vauY6/bfcC9dAiX5UJ3v4I
         PnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691989647; x=1692594447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FvbhgfPtRoQdXEdvEExdmNYKsXlPA1pwL1Oh71ly60=;
        b=BOSwdJSxmrY41uz9lxcEneaHFhwNrYCz3KdSP+cBstQLQMFmGs4j/I4pUmPjj7Tly/
         IAG7LJTde+idp94Yn4Q52HsvvJkW3jQX5R9h9twpKFInLQt0GFCHAXZoJzU6BI3wf4Kc
         Cnan6Ey8C8bCQ23qci2Nt+WfcrWxW5VvKQZQpuSQTwGlk9pTOe+R1fyisMQiv6VJwXFP
         WzuZU5f5KwgQg7oApPRDIGE/xpDa7gUYYkUlJP07KUi/wM6jIQfGjLuQRocVHOJxqVOC
         tq5sZwXYaN61GWPx3+qq52AYbEBS2MBQmLe0jYLBjfo/9808eFSj7K0oWmWZloe9RMqu
         1ajQ==
X-Gm-Message-State: AOJu0YyiF/tsPmU4GzfppuJ9P7Gzc0jTSo4VTmRXyNmR72vTrKzuJIZZ
        A4IsqU8roCztri7SI18J9IciPVIZrNw=
X-Google-Smtp-Source: AGHT+IFJOd+VJvHyFTKRdeX6K0MqrTp7hcz/0UVwzC054aBXJ3jzICLdxOwN8Vw8ixkXFVBYAHZY5A==
X-Received: by 2002:a17:902:c40b:b0:1bc:921c:eb48 with SMTP id k11-20020a170902c40b00b001bc921ceb48mr8541342plk.34.1691989647101;
        Sun, 13 Aug 2023 22:07:27 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902bc4a00b001bdd51748f8sm2544406plz.271.2023.08.13.22.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 22:07:26 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C699681A9BC3; Mon, 14 Aug 2023 12:07:22 +0700 (WIB)
Date:   Mon, 14 Aug 2023 12:07:22 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Fawad Lateef <fawadlateef@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Tony Lindgren <tony@atomide.com>
Cc:     Linux Devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux sunXi <linux-sunxi@lists.linux.dev>
Subject: Re: Question regarding Linux-6.3.5 and Sunxi A20 NAND/NFC support
Message-ID: <ZNm2ihdTojuPJM2f@debian.me>
References: <CAGgoGu7Vim82Hu1JKc+m6cPkcn7+WWDFwK5P_YE6grFQS9E21Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BCnPXbpV8oDh+gJ0"
Content-Disposition: inline
In-Reply-To: <CAGgoGu7Vim82Hu1JKc+m6cPkcn7+WWDFwK5P_YE6grFQS9E21Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BCnPXbpV8oDh+gJ0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 12:40:26AM +0100, Fawad Lateef wrote:
> Hi,
>=20
> I am trying to make Linux-6.3.5 working on Olimex/Sunxi A20 SOM with NAND.
>=20
> Found that the Sunxi A20 NAND is supported in mainline kernel
> (drivers/mtd/nand/raw/sunxi_nand.c) and following the guidelines here
> (https://linux-sunxi.org/Mainline_NAND_Howto); I added the NFC chip
> pin information in sunxi-a20.dtsi and defined/enabled the nfc
> controller in the sunxi-a20-olinuxino-micro.dts files.
>=20
> The changes I made are below. Problem is when I define the nfc node
> entry in dts file "without" pinctrl entry (pinctrl-0 =3D <&nand_pins_a>,
> <&nand_cs0_pins_a>, <&nand_rb0_pins_a>;), the sunxi_nfc_probe function
> is called (though the No NAND chip is detected).
>=20
> And if I define the pinctrl-0  in the nfc node, all I see related to
> NAND/sunxi in the kernel boot log is this line:  platform
> 1c03000.nand-controller: deferred probe pending.
>=20
> Can someone please guide me why the deferred probe is pending but
> never call the sunxi_nfc_probe function?  And without pinctrl-0 entry
> why probe function is being called?
>=20
> Seems like I am missing something basic here and any pointers to debug
> this will be appreciated.
>=20
>=20
> --- linux-6.3.5.orig/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> 2023-05-30 14:17:29.000000000 +0100
> +++ linux-6.3.5/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> 2023-08-13 23:27:22.405058025 +0100
> @@ -56,7 +56,7 @@
>=20
>   aliases {
>   serial0 =3D &uart0;
> - serial1 =3D &uart6;
> + serial1 =3D &uart2;
>   serial2 =3D &uart7;
>   spi0 =3D &spi1;
>   spi1 =3D &spi2;
> @@ -66,17 +66,6 @@
>   stdout-path =3D "serial0:115200n8";
>   };
>=20
> - hdmi-connector {
> - compatible =3D "hdmi-connector";
> - type =3D "a";
> -
> - port {
> - hdmi_con_in: endpoint {
> - remote-endpoint =3D <&hdmi_out_con>;
> - };
> - };
> - };
> -
>   leds {
>   compatible =3D "gpio-leds";
>   pinctrl-names =3D "default";
> @@ -90,16 +79,55 @@
>   };
>  };
>=20
> -&ahci {
> - target-supply =3D <&reg_ahci_5v>;
> +&nfc {
> + pinctrl-names =3D "default";
> + pinctrl-0 =3D <&nand_pins_a>, <&nand_cs0_pins_a>, <&nand_rb0_pins_a>;
>   status =3D "okay";
> +
> + nand@0 {
> + #address-cells =3D <2>;
> + #size-cells =3D <2>;
> + reg =3D <0>;
> + allwinner,rb =3D <0>;
> +
> + nand-ecc-mode =3D "hw";
> + nand-on-flash-bbt;
> + };
> +
> + boot0@0 {
> + label =3D "boot0";
> + reg =3D /bits/ 64 <0x0 0x200000>;
> + };
> +
> + boot0-rescue@200000 {
> + label =3D "boot0-rescue";
> + reg =3D /bits/ 64 <0x200000 0x200000>;
> + };
> +
> + uboot@400000 {
> + label =3D "uboot";
> + reg =3D /bits/ 64 <0x400000 0x200000>;
> + };
> +
> + uboot-rescue@600000 {
> + label =3D "uboot-rescue";
> + reg =3D /bits/ 64 <0x600000 0x200000>;
> + };
> +
> + main@800000 {
> + label =3D "main";
> + reg =3D /bits/ 64 <0x800000 0xff800000>;
> + };
> +
>  };
>=20
> -&codec {
> +&ahci {
> + target-supply =3D <&reg_ahci_5v>;
>   status =3D "okay";
>  };
>=20
>  &cpu0 {
> + clock-frequency =3D <900000000>;
>   cpu-supply =3D <&reg_dcdc2>;
>  };
>=20
> @@ -123,34 +151,24 @@
>   status =3D "okay";
>  };
>=20
> -&hdmi {
> - status =3D "okay";
> -};
> -
> -&hdmi_out {
> - hdmi_out_con: endpoint {
> - remote-endpoint =3D <&hdmi_con_in>;
> - };
> -};
> -
>  &i2c0 {
> - status =3D "okay";
> +        status =3D "okay";
>=20
> - axp209: pmic@34 {
> - reg =3D <0x34>;
> - interrupt-parent =3D <&nmi_intc>;
> - interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> - };
> +        axp209: pmic@34 {
> +                reg =3D <0x34>;
> +                interrupt-parent =3D <&nmi_intc>;
> +                interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> +        };
>  };
>=20
>  &i2c1 {
> - status =3D "okay";
> +        status =3D "okay";
>=20
> - eeprom: eeprom@50 {
> - compatible =3D "atmel,24c16";
> - reg =3D <0x50>;
> - pagesize =3D <16>;
> - };
> +        eeprom: eeprom@50 {
> +                compatible =3D "atmel,24c16";
> +                reg =3D <0x50>;
> +                pagesize =3D <16>;
> +        };
>  };
>=20
>  &i2c2 {
> @@ -160,55 +178,6 @@
>  &lradc {
>   vref-supply =3D <&reg_vcc3v0>;
>   status =3D "okay";
> -
> - button-191 {
> - label =3D "Volume Up";
> - linux,code =3D <KEY_VOLUMEUP>;
> - channel =3D <0>;
> - voltage =3D <191274>;
> - };
> -
> - button-392 {
> - label =3D "Volume Down";
> - linux,code =3D <KEY_VOLUMEDOWN>;
> - channel =3D <0>;
> - voltage =3D <392644>;
> - };
> -
> - button-601 {
> - label =3D "Menu";
> - linux,code =3D <KEY_MENU>;
> - channel =3D <0>;
> - voltage =3D <601151>;
> - };
> -
> - button-795 {
> - label =3D "Search";
> - linux,code =3D <KEY_SEARCH>;
> - channel =3D <0>;
> - voltage =3D <795090>;
> - };
> -
> - button-987 {
> - label =3D "Home";
> - linux,code =3D <KEY_HOMEPAGE>;
> - channel =3D <0>;
> - voltage =3D <987387>;
> - };
> -
> - button-1184 {
> - label =3D "Esc";
> - linux,code =3D <KEY_ESC>;
> - channel =3D <0>;
> - voltage =3D <1184678>;
> - };
> -
> - button-1398 {
> - label =3D "Enter";
> - linux,code =3D <KEY_ENTER>;
> - channel =3D <0>;
> - voltage =3D <1398804>;
> - };
>  };
>=20
>  &gmac_mdio {
> @@ -239,10 +208,6 @@
>   status =3D "okay";
>  };
>=20
> -&otg_sram {
> - status =3D "okay";
> -};
> -
>  &pio {
>   gmac_txerr: gmac-txerr-pin {
>   pins =3D "PA17";
> @@ -323,9 +288,9 @@
>   status =3D "okay";
>  };
>=20
> -&uart6 {
> +&uart2 {
>   pinctrl-names =3D "default";
> - pinctrl-0 =3D <&uart6_pi_pins>;
> + pinctrl-0 =3D <&uart2_pi_pins>;
>   status =3D "okay";
>  };
>=20
> @@ -352,3 +317,28 @@
>   usb2_vbus-supply =3D <&reg_usb2_vbus>;
>   status =3D "okay";
>  };
> +
> +&fe0 {
> + status =3D "disabled";
> +};
> +
> +&fe1 {
> + status =3D "disabled";
> +};
> +
> +&be0 {
> + status =3D "disabled";
> +};
> +
> +&be1 {
> + status =3D "disabled";
> +};
> +
> +&tcon0 {
> + status =3D "disabled";
> +};
> +
> +&tcon1 {
> + status =3D "disabled";
> +};
> +
>=20
>=20
> --- linux-6.3.5.orig/arch/arm/boot/dts/sun7i-a20.dtsi 2023-05-30
> 14:17:29.000000000 +0100
> +++ linux-6.3.5/arch/arm/boot/dts/sun7i-a20.dtsi 2023-08-08
> 00:30:04.689288733 +0100
> @@ -345,6 +345,58 @@
>   #size-cells =3D <0>;
>   };
>=20
> + nand_pins_a: nand_base0@0 {
> + allwinner,pins =3D "PC0", "PC1", "PC2",
> + "PC5", "PC8", "PC9", "PC10",
> + "PC11", "PC12", "PC13", "PC14",
> + "PC15", "PC16";
> + allwinner,function =3D "nand0";
> + allwinner,drive =3D <SUN4I_PINCTRL_10_MA>;
> + allwinner,pull =3D <SUN4I_PINCTRL_NO_PULL>;
> + };
> +
> + nand_cs0_pins_a: nand_cs@0 {
> + allwinner,pins =3D "PC4";
> + allwinner,function =3D "nand0";
> + allwinner,drive =3D <SUN4I_PINCTRL_10_MA>;
> + allwinner,pull =3D <SUN4I_PINCTRL_NO_PULL>;
> + };
> +
> + nand_cs1_pins_a: nand_cs@1 {
> + allwinner,pins =3D "PC3";
> + allwinner,function =3D "nand0";
> + allwinner,drive =3D <SUN4I_PINCTRL_10_MA>;
> + allwinner,pull =3D <SUN4I_PINCTRL_NO_PULL>;
> + };
> +
> + nand_cs2_pins_a: nand_cs@2 {
> + allwinner,pins =3D "PC17";
> + allwinner,function =3D "nand0";
> + allwinner,drive =3D <SUN4I_PINCTRL_10_MA>;
> + allwinner,pull =3D <SUN4I_PINCTRL_NO_PULL>;
> + };
> +
> + nand_cs3_pins_a: nand_cs@3 {
> + allwinner,pins =3D "PC18";
> + allwinner,function =3D "nand0";
> + allwinner,drive =3D <SUN4I_PINCTRL_10_MA>;
> + allwinner,pull =3D <SUN4I_PINCTRL_NO_PULL>;
> + };
> +
> + nand_rb0_pins_a: nand_rb@0 {
> + allwinner,pins =3D "PC6";
> + allwinner,function =3D "nand0";
> + allwinner,drive =3D <SUN4I_PINCTRL_10_MA>;
> + allwinner,pull =3D <SUN4I_PINCTRL_NO_PULL>;
> + };
> +
> + nand_rb1_pins_a: nand_rb@1 {
> + allwinner,pins =3D "PC7";
> + allwinner,function =3D "nand0";
> + allwinner,drive =3D <SUN4I_PINCTRL_10_MA>;
> + allwinner,pull =3D <SUN4I_PINCTRL_NO_PULL>;
> + };
> +
>   spi0: spi@1c05000 {
>   compatible =3D "allwinner,sun4i-a10-spi";
>   reg =3D <0x01c05000 0x1000>;
>=20
>=20

Thanks for the suggestion diff. Can you submit it as formal patch against
current sunxi/for-next tree [1]? See
Documentation/process/submitting-patches.rst for how to properly submit
patches.

Thanks.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/log/?h=
=3Dsunxi/for-next

--=20
An old man doll... just what I always wanted! - Clara

--BCnPXbpV8oDh+gJ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZNm2hQAKCRD2uYlJVVFO
o9HqAQCl9TpDVEIB0OUuq7jAIQlSjpvv/kdOI27BazmJKgasCAD7BktB6wxg1DNS
ltEB7ocmwZ4HklJJJCUx9GUO41jLqwM=
=pbq6
-----END PGP SIGNATURE-----

--BCnPXbpV8oDh+gJ0--
