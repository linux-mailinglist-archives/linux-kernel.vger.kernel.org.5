Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D54D7C60F6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 01:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbjJKXPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 19:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbjJKXPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 19:15:16 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970B6AF;
        Wed, 11 Oct 2023 16:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697066113;
        bh=Qf1p2gVy4rqI/LsmbKaNjjPoD1EJg71MiJ3nDq8hLn4=;
        h=Date:From:To:Cc:Subject:From;
        b=oN084AUlbbXslRvm0WWW2JUyVkSaZRiFxYgiHG4tYgSNAuez+ngdfO+kEPEBtfR1c
         UlR7FUEK5rWZPzteTsy1poOrjgrbV09GZSsW3e6iEmgQZLXtGxT0zUwD3FjisC0b6y
         JFmc76NI/AFsqQr015nOXI8pgTVQC6KktuL0Z4SsaUwdNnEwWFJt9c8AjqwtiNngBM
         ZDl0hMvom7H6KLuiB8fpEQYT13zIr2wELV5sovMzJr1LPHJXWHlMsAOnSM5bkoy8kE
         xO5eiiK2//ykgVHoAcavgCqL5BHm2f9a/7nL3D3Ns162A1H3aHwwK/vRBAv3BzSSCK
         ORnCX9BT4Fvvw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S5TBl3TY2z4xVW;
        Thu, 12 Oct 2023 10:15:11 +1100 (AEDT)
Date:   Thu, 12 Oct 2023 10:14:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: linux-next: manual merge of the imx-mxs tree with the net tree
Message-ID: <20231012101434.1e5e7340@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/juvbrqhB/Wpp.Nl2Y1l2rIr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/juvbrqhB/Wpp.Nl2Y1l2rIr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the imx-mxs tree got a conflict in:

  arch/arm64/boot/dts/freescale/imx93.dtsi

between commit:

  23ed2be5404d ("arm64: dts: imx93: add the Flex-CAN stop mode by GPR")

from the net tree and commit:

  d34d2aa594d0 ("arm64: dts: imx93: add edma1 and edma2")

from the imx-mxs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/boot/dts/freescale/imx93.dtsi
index dcf6e4846ac9,4a0d604fd0db..000000000000
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@@ -185,7 -185,47 +185,47 @@@
  			#size-cells =3D <1>;
  			ranges;
 =20
+ 			edma1: dma-controller@44000000 {
+ 				compatible =3D "fsl,imx93-edma3";
+ 				reg =3D <0x44000000 0x200000>;
+ 				#dma-cells =3D <3>;
+ 				dma-channels =3D <31>;
+ 				interrupts =3D <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,  //  0: Reserved
+ 					     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,  //  1: CANFD1
+ 					     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,  //  2: Reserved
+ 					     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,  //  3: GPIO1 CH0
+ 					     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,  //  4: GPIO1 CH1
+ 					     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>, //  5: I3C1 TO Bus
+ 					     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>, //  6: I3C1 From Bus
+ 					     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>, //  7: LPI2C1 M TX
+ 					     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, //  8: LPI2C1 S TX
+ 					     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>, //  9: LPI2C2 M RX
+ 					     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>, // 10: LPI2C2 S RX
+ 					     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>, // 11: LPSPI1 TX
+ 					     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>, // 12: LPSPI1 RX
+ 					     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, // 13: LPSPI2 TX
+ 					     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>, // 14: LPSPI2 RX
+ 					     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>, // 15: LPTMR1
+ 					     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>, // 16: LPUART1 TX
+ 					     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>, // 17: LPUART1 RX
+ 					     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, // 18: LPUART2 TX
+ 					     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>, // 19: LPUART2 RX
+ 					     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>, // 20: S400
+ 					     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>, // 21: SAI TX
+ 					     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>, // 22: SAI RX
+ 					     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, // 23: TPM1 CH0/CH2
+ 					     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>, // 24: TPM1 CH1/CH3
+ 					     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>, // 25: TPM1 Overflow
+ 					     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>, // 26: TMP2 CH0/CH2
+ 					     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>, // 27: TMP2 CH1/CH3
+ 					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, // 28: TMP2 Overflow
+ 					     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>, // 29: PDM
+ 					     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>; // 30: ADC1
+ 				clocks =3D <&clk IMX93_CLK_EDMA1_GATE>;
+ 				clock-names =3D "dma";
+ 			};
+=20
 -			anomix_ns_gpr: syscon@44210000 {
 +			aonmix_ns_gpr: syscon@44210000 {
  				compatible =3D "fsl,imx93-aonmix-ns-syscfg", "syscon";
  				reg =3D <0x44210000 0x1000>;
  			};

--Sig_/juvbrqhB/Wpp.Nl2Y1l2rIr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUnLFoACgkQAVBC80lX
0GzwcAf9Hc6mLVpZ5I6YpGr7lYl3q+ZPuE1SvNHRdHt75L0DiFhgP/OKDKrCUlPu
plsasHbFQvvW5bSxgQHRgLqigMO5kee9ay0tz/WZgBbTkOCUt2eWanclpnuu5ta/
ZjNBcN9XmVyaPEh/H1g6MNM5U62pHqvPp5W9zxUFDv1wqaADLOSrgDpZU2KW0MjW
qrMfxXxWFqMwNb3NF7V4b59E6nZvUWsM8+Mz7P8B3ZIiPrcUYS89ZAYwOMHQS8ib
i3q5ymRgfoJ7VFqh+bOOGU6VzOWErvG6ehFQm8Na/zMTQPn1XMTezmmnZcBjlHt0
oBXYeJkXI8tGWAQ8KwEzJhEJRCw83w==
=fLdv
-----END PGP SIGNATURE-----

--Sig_/juvbrqhB/Wpp.Nl2Y1l2rIr--
