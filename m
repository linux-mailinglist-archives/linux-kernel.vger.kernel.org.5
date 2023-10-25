Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A246C7D608B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 05:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjJYDdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 23:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjJYDdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 23:33:36 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA343AC;
        Tue, 24 Oct 2023 20:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698204808;
        bh=2/MNtZj22F476DYahEpd+r4Kge0Nga8hsCL0uUv65kM=;
        h=Date:From:To:Cc:Subject:From;
        b=urHrfBKatVB+73QhDU4xJNcWUuDskAVw92AcZdwBFiFkzwCiKcGrrcsa/qinJBWZX
         jU+9PtGBasKk/eFbpBMEab56TZdp6uqI5YTor3OsTPH62fIMa8dLvF3vQekA0gxuBM
         8fRXU0oTvaordKyVJcVkfm101FXBdQV3ALo4PO32thADbt9F8lopw9vrSSFepLT6aJ
         hO3TWgFZmnMuIpuRZ26NxBK+Wb28YSKKt7kDtewXkNjvHyaFswvRYQZihIm9ToxdkZ
         gH+dXkSV0hG67o1fbGQl9jbVb4QmCTVbMMk4B6LNePc1HQKwfvBEDY5RmDYJ4W6DEc
         CWg6aV6HtdPeA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SFZJl3gfpz4wd1;
        Wed, 25 Oct 2023 14:33:27 +1100 (AEDT)
Date:   Wed, 25 Oct 2023 14:33:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Heiko Stuebner <heiko@sntech.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: linux-next: manual merge of the usb tree with the rockchip tree
Message-ID: <20231025143326.1ae29596@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.NULT9TiFcEN9i7kBdJvtPr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.NULT9TiFcEN9i7kBdJvtPr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  arch/arm64/boot/dts/rockchip/rk3588s.dtsi

between commit:

  5a6976b1040a ("arm64: dts: rockchip: Add DFI to rk3588s")

from the rockchip tree and commit:

  bbd3778da16b ("arm64: dts: rockchip: rk3588s: Add USB3 host controller")

from the usb tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 2993e1255042,8b4c99b49798..000000000000
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@@ -443,11 -443,27 +443,32 @@@
  		status =3D "disabled";
  	};
 =20
+ 	usb_host2_xhci: usb@fcd00000 {
+ 		compatible =3D "rockchip,rk3588-dwc3", "snps,dwc3";
+ 		reg =3D <0x0 0xfcd00000 0x0 0x400000>;
+ 		interrupts =3D <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH 0>;
+ 		clocks =3D <&cru REF_CLK_USB3OTG2>, <&cru SUSPEND_CLK_USB3OTG2>,
+ 			 <&cru ACLK_USB3OTG2>, <&cru CLK_UTMI_OTG2>,
+ 			 <&cru CLK_PIPEPHY2_PIPE_U3_G>;
+ 		clock-names =3D "ref_clk", "suspend_clk", "bus_clk", "utmi", "pipe";
+ 		dr_mode =3D "host";
+ 		phys =3D <&combphy2_psu PHY_TYPE_USB3>;
+ 		phy-names =3D "usb3-phy";
+ 		phy_type =3D "utmi_wide";
+ 		resets =3D <&cru SRST_A_USB3OTG2>;
+ 		snps,dis_enblslpm_quirk;
+ 		snps,dis-u2-freeclk-exists-quirk;
+ 		snps,dis-del-phy-power-chg-quirk;
+ 		snps,dis-tx-ipgap-linecheck-quirk;
+ 		snps,dis_rxdet_inp3_quirk;
+ 		status =3D "disabled";
+ 	};
+=20
 +	pmu1grf: syscon@fd58a000 {
 +		compatible =3D "rockchip,rk3588-pmugrf", "syscon", "simple-mfd";
 +		reg =3D <0x0 0xfd58a000 0x0 0x10000>;
 +	};
 +
  	sys_grf: syscon@fd58c000 {
  		compatible =3D "rockchip,rk3588-sys-grf", "syscon";
  		reg =3D <0x0 0xfd58c000 0x0 0x1000>;

--Sig_/.NULT9TiFcEN9i7kBdJvtPr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU4jIYACgkQAVBC80lX
0GxWOQf+Imedv2RE8nQlP8+6bP0Ist8DsotKrDrSd1EAkQboOZ8aOafsJq5V0Y7U
zTXDOV1XP83pF09BEGCTo85CIsdLUwh80Bpsmg7QrTxVVF0Ke4vG9TBnS4BdphCp
rrikDaPSgxVY4FNyT0E2Dr0u4OzugQQ9svpaxzAZqmFvles7+arlLtktb0p+MeSs
z+NccXH2Tj+fme9ujMXo+01or1TiPsKSmUQvfEbX5I2bBj9XiprTuF3MU7IF7pKa
x0PvNhjL0rQQIRKa80yrrpNSyCOyOQ1AJ36MMEgDH/wtqGmepDSX28lGaHZafEDp
/iHyrXA9m6eJuf8MRC4W/YWkowmI4Q==
=UUf1
-----END PGP SIGNATURE-----

--Sig_/.NULT9TiFcEN9i7kBdJvtPr--
