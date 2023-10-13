Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA207C8DB2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjJMTVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjJMTVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:21:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F3495;
        Fri, 13 Oct 2023 12:21:45 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-313e742a787so1553732f8f.1;
        Fri, 13 Oct 2023 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697224904; x=1697829704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxJuvqrlrMiNG1ulmdPZtrlk8o7WsHfPxtKGTiZjzss=;
        b=Co01GOYGKAW0tQQfAmpsibGFUdT3tWMB9LGgrEHqjrWdnn/cictPGKaT+buXMDDxo8
         9mTSPOyQbM3yktvph8Uhm/RwJLa0Mn4cU+kZThLUoJWrYiJ9/xtPPGqc+uZjvX3KAN62
         6hBHeHM2CxjrCAHFF9Oz/WjWhOInzArEYZTez7GrG3NX2AwKV75PmJreeufy9LfAIOZX
         bWdVkbBACxDIcSI+Jc99LgAyqwEIIvuJCZDnmyKZIaSMrv8/TJdZy/rQxjr1wtaSJCbY
         0NXkL2E4UnP0PcJwK0w2zHIafoqQ8XQXF8mPIAXUn/kvvmrwF8Kmmflk9CqIWjhR9MWu
         YrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697224904; x=1697829704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxJuvqrlrMiNG1ulmdPZtrlk8o7WsHfPxtKGTiZjzss=;
        b=H2KUddwtoOqGJArF+kzDzhh8WF+mnFxXnJYUK/f2MsHmJ7X9bERJvDuHvuJqIkysqu
         pxAtvjbTJvEIskwnGzi7MdtoqVfjIJ+5PU4gNBZ7H33gev02Mj6Upn4h9N3h6WxZB/Hi
         psMqiNG2aMxjgmKmbdGkMi3jpD+vKReyyVWOBzd5OhHOpoP3WjKMHC52Vte0owa9MbYq
         edpxKLA9ijejU70TZ/RxJ4rvreDX/eDkJYqWtOGNsbIGbmUqwjSujxOJ1s1IhQu08q6k
         nm+YeG5A+NSkJWf9J5gUf/KciFoIcb/kpSp4UNh9SmQWKVjZHnkcizsOGURoQryPKUFf
         JoTg==
X-Gm-Message-State: AOJu0YyOrnJSqDkJmBTNME15si8d48czKCRofb4hRfrgqgW44wqyPcyF
        AnqcM/zdENmbxVocMjsbiiU=
X-Google-Smtp-Source: AGHT+IELDlyPz7gN5vyh6szAavsAMEHQMOCMaIDGJwmShMWPYZa5uXJZDWsPkLOjZ0lf9lhi98Ixag==
X-Received: by 2002:adf:b353:0:b0:317:6734:c2ae with SMTP id k19-20020adfb353000000b003176734c2aemr905155wrd.11.1697224903581;
        Fri, 13 Oct 2023 12:21:43 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d4749000000b0032d9523de65sm4071755wrs.48.2023.10.13.12.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 12:21:43 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     conor@kernel.org, Julian Ribbeck <julian.ribbeck@gmx.de>
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org,
        julian.ribbeck@gmx.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        robh+dt@kernel.org, samuel@sholland.org, wens@csie.org
Subject: Re: [PATCH v4 1/2] ARM: dts: sun7i: Add Iteaduino Plus A20
Date:   Fri, 13 Oct 2023 21:21:42 +0200
Message-ID: <22045443.EfDdHjke4D@jernej-laptop>
In-Reply-To: <2242644.iZASKD2KPV@jernej-laptop>
References: <20230929-given-making-f3fac6afb176@spud>
 <20231006090154.9289-1-julian.ribbeck@gmx.de>
 <2242644.iZASKD2KPV@jernej-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Dne petek, 13. oktober 2023 ob 21:18:00 CEST je Jernej =C5=A0krabec napisal=
(a):
> Dne petek, 06. oktober 2023 ob 11:01:30 CEST je Julian Ribbeck napisal(a):
> > Iteaduino Plus A20 is very similar to Iteaduino Plus A10. In fact it
> > shares the same breakout board and the Itead Core A20 on top of it, is
> > only adapted to support the dual-core A20.
> >=20
> > This commits enables the following hardware:
> >=20
> > * HDMI Video output
> > * USB
> > * SATA (untested due to lack of hardware I could attach)
> > * Ethernet
> > * MMC storage
> > * UART
> > * USB OTG (untested, because I don't own an USB OTG cable/device)
> >=20
> > Signed-off-by: Julian Ribbeck <julian.ribbeck@gmx.de>
> > ---
> >  arch/arm/boot/dts/allwinner/Makefile          |   1 +
> >  .../sun7i-a20-itead-iteaduino-plus.dts        | 104 ++++++++++++++++++
> >  2 files changed, 105 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/allwinner/sun7i-a20-itead-iteadui=
no-plus.dts
> >=20
> > diff --git a/arch/arm/boot/dts/allwinner/Makefile b/arch/arm/boot/dts/a=
llwinner/Makefile
> > index eebb5a0c873a..39af5ad94590 100644
> > --- a/arch/arm/boot/dts/allwinner/Makefile
> > +++ b/arch/arm/boot/dts/allwinner/Makefile
> > @@ -124,6 +124,7 @@ dtb-$(CONFIG_MACH_SUN7I) +=3D \
> >  	sun7i-a20-haoyu-marsboard.dtb \
> >  	sun7i-a20-hummingbird.dtb \
> >  	sun7i-a20-itead-ibox.dtb \
> > +	sun7i-a20-itead-iteaduino-plus.dts \
>=20
> This should be .dtb.
>=20
> Other than that:
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>=20
> I'll fix it while applying.
>=20
> For future reference, please follow proper patch submission procedure:
> - each revision should be sent in separate thread
> - each new revision should contain changelog, either in cover letter (when
> there is more than one patch) or below --- line in each patch
> - compatible description patch comes before first usage (I'll invert order
> when applying)

Sorry, I won't apply it as yet. How was this tested if it didn't even built=
 due
to mistake in Makefile?

Best regards,
Jernej

>=20
> Best regards,
> Jernej
>=20
> >  	sun7i-a20-i12-tvbox.dtb \
> >  	sun7i-a20-icnova-a20-adb4006.dtb \
> >  	sun7i-a20-icnova-swac.dtb \
> > diff --git a/arch/arm/boot/dts/allwinner/sun7i-a20-itead-iteaduino-plus=
=2Edts b/arch/arm/boot/dts/allwinner/sun7i-a20-itead-iteaduino-plus.dts
> > new file mode 100644
> > index 000000000000..c9f9b0275381
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/allwinner/sun7i-a20-itead-iteaduino-plus.dts
> > @@ -0,0 +1,104 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > +
> > +/dts-v1/;
> > +#include "sun7i-a20.dtsi"
> > +#include "sunxi-itead-core-common.dtsi"
> > +
> > +/ {
> > +	model =3D "Itead Iteaduino Plus A20";
> > +	compatible =3D "itead,iteaduino-plus-a20", "allwinner,sun7i-a20";
> > +
> > +	hdmi-connector {
> > +		compatible =3D "hdmi-connector";
> > +		type =3D "a";
> > +
> > +		port {
> > +			hdmi_con_in: endpoint {
> > +				remote-endpoint =3D <&hdmi_out_con>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&ac_power_supply {
> > +	status =3D "okay";
> > +};
> > +
> > +&ahci {
> > +	target-supply =3D <&reg_ahci_5v>;
> > +	status =3D "okay";
> > +};
> > +
> > +&axp209 {
> > +	interrupt-parent =3D <&nmi_intc>;
> > +	interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> > +};
> > +
> > +&battery_power_supply {
> > +	status =3D "okay";
> > +};
> > +
> > +&codec {
> > +	stauts =3D "okay";
> > +};
> > +
> > +&de {
> > +	status =3D "okay";
> > +};
> > +
> > +&emac {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&emac_pa_pins>;
> > +	phy-handle =3D <&phy1>;
> > +	status =3D "okay";
> > +};
> > +
> > +&emac_sram {
> > +	status =3D "okay";
> > +};
> > +
> > +&hdmi {
> > +	status =3D "okay";
> > +};
> > +
> > +&hdmi_out {
> > +	hdmi_out_con: endpoint {
> > +		remote-endpoint =3D <&hdmi_con_in>;
> > +	};
> > +};
> > +
> > +&mdio {
> > +	status =3D "okay";
> > +
> > +	phy1: ethernet-phy@1 {
> > +		reg =3D <1>;
> > +	};
> > +};
> > +
> > +&mmc0 {
> > +	vmmc-supply =3D <&reg_vcc3v3>;
> > +	bus-width =3D <4>;
> > +	cd-gpios =3D <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
> > +	status =3D "okay";
> > +};
> > +
> > +&otg_sram {
> > +	status =3D "okay";
> > +};
> > +
> > +&reg_ahci_5v {
> > +	status =3D "okay";
> > +};
> > +
> > +&reg_usb0_vbus {
> > +	status =3D "okay";
> > +};
> > +
> > +&usb_otg {
> > +	status =3D "okay";
> > +	dr_mode =3D "host";
> > +};
> > +
> > +&usbphy {
> > +	usb0_vbus-supply =3D <&reg_usb0_vbus>;
> > +};
> > --
> > 2.42.0
> >=20
> >=20
>=20
>=20
>=20
>=20
>=20




