Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B404576C156
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 02:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjHBAGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 20:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHBAGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 20:06:21 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8061BF0;
        Tue,  1 Aug 2023 17:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690934779;
        bh=H43OmrJAOPMO04ydQakhKGsbl9v6+fR2jL3IHuXpCYU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mLmwxij51hVvN5ipun0/4mebBNutaRQuEmgmQmjSbWpCKXygC9SwA/ZzOCr7AHYsH
         uIhCiZi17hVI6g7/LIrLPdlEd+T5f7EcBx61ptzCLUNkz40TqZtuVfeX91cZ+X5TNw
         WNtzZLwFhEsXfVbqyteGnekA8KbIyXrn9QOFeEH8kFcz7K/JEk6iPnu36B5gY5VDA/
         fNyhZ1CestQfAHUiU7MFMdfjviyJt6n589VCCQ2Fy03zFyZH3F1AzYo7gJvNxHMFmT
         mJCtIuxK4salGqMtbypiDsSYzzUsfY9FOCFVdh4/vHr7j9ddWCCX3/bBCifeKpd9dH
         0ObYowEuxz61w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RFshV6Xbcz4yGN;
        Wed,  2 Aug 2023 10:06:18 +1000 (AEST)
Date:   Wed, 2 Aug 2023 10:06:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Eddie James <eajames@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the aspeed tree
Message-ID: <20230802100618.3cbf4712@canb.auug.org.au>
In-Reply-To: <20230720104019.11dee2b2@canb.auug.org.au>
References: <20230711095101.6277674b@canb.auug.org.au>
        <20230720104019.11dee2b2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oG0atfuduz6qtjNS7g2Ipq4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oG0atfuduz6qtjNS7g2Ipq4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 20 Jul 2023 10:40:19 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Tue, 11 Jul 2023 09:51:01 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > After merging the aspeed tree, today's linux-next build (arm
> > multi_v7_defconfig) produced this warning:
> >=20
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:238.6-19: Warning (=
reg_format): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@a/eeprom@50:re=
g: property has invalid length (4 bytes) (#address-cells =3D=3D 2, #size-ce=
lls =3D=3D 1)
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:247.6-19: Warning (=
reg_format): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@b/eeprom@50:re=
g: property has invalid length (4 bytes) (#address-cells =3D=3D 2, #size-ce=
lls =3D=3D 1)
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:256.6-19: Warning (=
reg_format): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@c/eeprom@50:re=
g: property has invalid length (4 bytes) (#address-cells =3D=3D 2, #size-ce=
lls =3D=3D 1)
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:265.6-19: Warning (=
reg_format): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@d/eeprom@50:re=
g: property has invalid length (4 bytes) (#address-cells =3D=3D 2, #size-ce=
lls =3D=3D 1)
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: Warning (pci_devic=
e_reg): Failed prerequisite 'reg_format'
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: Warning (pci_devic=
e_bus_num): Failed prerequisite 'reg_format'
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:233.27-240.6: Warni=
ng (i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@a: inc=
orrect #address-cells for I2C bus
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:233.27-240.6: Warni=
ng (i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@a: inc=
orrect #size-cells for I2C bus
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:242.27-249.6: Warni=
ng (i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@b: inc=
orrect #address-cells for I2C bus
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:242.27-249.6: Warni=
ng (i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@b: inc=
orrect #size-cells for I2C bus
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:251.27-258.6: Warni=
ng (i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@c: inc=
orrect #address-cells for I2C bus
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:251.27-258.6: Warni=
ng (i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@c: inc=
orrect #size-cells for I2C bus
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:260.27-267.6: Warni=
ng (i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@d: inc=
orrect #address-cells for I2C bus
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:260.27-267.6: Warni=
ng (i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@d: inc=
orrect #size-cells for I2C bus
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: Warning (i2c_bus_r=
eg): Failed prerequisite 'reg_format'
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: Warning (i2c_bus_r=
eg): Failed prerequisite 'i2c_bus_bridge'
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: Warning (spi_bus_r=
eg): Failed prerequisite 'reg_format'
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:236.15-239.7: Warni=
ng (avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-b=
us@a/eeprom@50: Relying on default #address-cells value
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:236.15-239.7: Warni=
ng (avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-b=
us@a/eeprom@50: Relying on default #size-cells value
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:245.15-248.7: Warni=
ng (avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-b=
us@b/eeprom@50: Relying on default #address-cells value
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:245.15-248.7: Warni=
ng (avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-b=
us@b/eeprom@50: Relying on default #size-cells value
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:254.15-257.7: Warni=
ng (avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-b=
us@c/eeprom@50: Relying on default #address-cells value
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:254.15-257.7: Warni=
ng (avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-b=
us@c/eeprom@50: Relying on default #size-cells value
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:263.15-266.7: Warni=
ng (avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-b=
us@d/eeprom@50: Relying on default #address-cells value
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:263.15-266.7: Warni=
ng (avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-b=
us@d/eeprom@50: Relying on default #size-cells value
> >=20
> > Presumably introduced by commit
> >=20
> >   267c95dc9f80 ("ARM: dts: aspeed: bonnell: Add DIMM SPD") =20
>=20
> I am still getting those warnings.

Any progress with this?
--=20
Cheers,
Stephen Rothwell

--Sig_/oG0atfuduz6qtjNS7g2Ipq4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTJnfoACgkQAVBC80lX
0GwXIgf7BIJgL0OrbH75jyyt2AcjiMW8v3Ey6A0pwPDPagIgR0bNVSsB96CQql7P
pIWKzX6m2OMEKcqmEGgg+lYeAGP9oWDkxTjwpFCRCAInKou6QuSqh1m41W5K+xbA
8Pjzt9aUgQxPvMlpEJ/fy73RwbXBNFG0UxHkTVO+92vhkAv3D7w/dJEUxPxtT7na
wSpdz3m5g/36JBLvhNMcancqFjDWOYKEIWqJopnJCDVJlhTDl3o70XHSpJhhlsb8
EhSPNef2ie/kLeHkZhfaQyKsHQX0mtanSaMm1Eo3Vq/Y05ZEyiDMqscC0kd7JyXV
Z4rERa9ri28rg7hEV7mu7WZA9exe2Q==
=c37Q
-----END PGP SIGNATURE-----

--Sig_/oG0atfuduz6qtjNS7g2Ipq4--
