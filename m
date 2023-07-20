Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B432175A386
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 02:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjGTAk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 20:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTAkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 20:40:24 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D0B1BF7;
        Wed, 19 Jul 2023 17:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689813621;
        bh=TQy00HgHfulP+Ik3COT5AftXJ4S1hcJL4lb1g38rFXk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QO6SNswZXa+QfxiIkVtrV55KsHtMIHbnl4urCOOM6lthokjUbPsx7sz0FNFbl+mbt
         TtYOjZ0GJwfCqRCmrO+dOYMpJnSVto/B1EhYUNWY81To43Sjxut2N2dKUcPUKAucoC
         SPLML9td+M0ctVpcRWn6Bmmn5EGofdqWrHwzPSj/HHys9PDGGeZEnC/+6g2PO8LQ/2
         F/I1cbreH5x/QRvM2Y8ogpDyCdaUVDh7Jn8O6yXRw8Uc39neY6yk4AUs7IvU1KjUEq
         FB+tE8tLE0aa92y0jwdHJNximvV/2aSeqzuNgEGEdmL2or/+3bfd5WemiSkrSP2/MO
         yh3Yxj+vsk0uQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R5v3n4cGlz4wxR;
        Thu, 20 Jul 2023 10:40:21 +1000 (AEST)
Date:   Thu, 20 Jul 2023 10:40:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Eddie James <eajames@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the aspeed tree
Message-ID: <20230720104019.11dee2b2@canb.auug.org.au>
In-Reply-To: <20230711095101.6277674b@canb.auug.org.au>
References: <20230711095101.6277674b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jYpZDlB.hK.rM+oC6r.MP2B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jYpZDlB.hK.rM+oC6r.MP2B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 11 Jul 2023 09:51:01 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the aspeed tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>=20
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:238.6-19: Warning (re=
g_format): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@a/eeprom@50:reg:=
 property has invalid length (4 bytes) (#address-cells =3D=3D 2, #size-cell=
s =3D=3D 1)
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:247.6-19: Warning (re=
g_format): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@b/eeprom@50:reg:=
 property has invalid length (4 bytes) (#address-cells =3D=3D 2, #size-cell=
s =3D=3D 1)
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:256.6-19: Warning (re=
g_format): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@c/eeprom@50:reg:=
 property has invalid length (4 bytes) (#address-cells =3D=3D 2, #size-cell=
s =3D=3D 1)
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:265.6-19: Warning (re=
g_format): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@d/eeprom@50:reg:=
 property has invalid length (4 bytes) (#address-cells =3D=3D 2, #size-cell=
s =3D=3D 1)
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: Warning (pci_device_=
reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: Warning (pci_device_=
bus_num): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:233.27-240.6: Warning=
 (i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@a: incor=
rect #address-cells for I2C bus
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:233.27-240.6: Warning=
 (i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@a: incor=
rect #size-cells for I2C bus
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:242.27-249.6: Warning=
 (i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@b: incor=
rect #address-cells for I2C bus
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:242.27-249.6: Warning=
 (i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@b: incor=
rect #size-cells for I2C bus
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:251.27-258.6: Warning=
 (i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@c: incor=
rect #address-cells for I2C bus
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:251.27-258.6: Warning=
 (i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@c: incor=
rect #size-cells for I2C bus
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:260.27-267.6: Warning=
 (i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@d: incor=
rect #address-cells for I2C bus
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:260.27-267.6: Warning=
 (i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@d: incor=
rect #size-cells for I2C bus
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: Warning (i2c_bus_reg=
): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: Warning (i2c_bus_reg=
): Failed prerequisite 'i2c_bus_bridge'
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: Warning (spi_bus_reg=
): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:236.15-239.7: Warning=
 (avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus=
@a/eeprom@50: Relying on default #address-cells value
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:236.15-239.7: Warning=
 (avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus=
@a/eeprom@50: Relying on default #size-cells value
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:245.15-248.7: Warning=
 (avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus=
@b/eeprom@50: Relying on default #address-cells value
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:245.15-248.7: Warning=
 (avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus=
@b/eeprom@50: Relying on default #size-cells value
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:254.15-257.7: Warning=
 (avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus=
@c/eeprom@50: Relying on default #address-cells value
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:254.15-257.7: Warning=
 (avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus=
@c/eeprom@50: Relying on default #size-cells value
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:263.15-266.7: Warning=
 (avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus=
@d/eeprom@50: Relying on default #address-cells value
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:263.15-266.7: Warning=
 (avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus=
@d/eeprom@50: Relying on default #size-cells value
>=20
> Presumably introduced by commit
>=20
>   267c95dc9f80 ("ARM: dts: aspeed: bonnell: Add DIMM SPD")

I am still getting those warnings.

--=20
Cheers,
Stephen Rothwell

--Sig_/jYpZDlB.hK.rM+oC6r.MP2B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS4gnMACgkQAVBC80lX
0GyEHQf+LfFk9fr06NDw6uz2aiuxKfwIM5s8im3vit/IElwGlLiqokUkKeYl0ioL
KVccFXqvmVecAVnej5tmnSGjXy7wfh1D6uNERDNAweMh+G3mvO+TGcqrKEC5wo5X
bSuVZS4MQb2yIXBJBaa0FvWRc4/mNQyJMgfuJEis/zDkLQ52kWsBruZRSK0UeoTN
z12IANGX3KvqYRaqmXF9Ti6EYaWeG3euou2at3uHmzRfxQ2ojHyRr0Y9d+/u0Wmq
oS26njKBg4tOzpQTNFhXcy46o6AfTyE1nuyGuCswZ73W7POlnCuxHXbLv0YpmEP7
/8BOQEAaJDu2/rITmgF9mFNmJBBIOw==
=Qhzb
-----END PGP SIGNATURE-----

--Sig_/jYpZDlB.hK.rM+oC6r.MP2B--
