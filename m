Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8247ACEB3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 05:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjIYDZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 23:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjIYDZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:25:03 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5393AA3;
        Sun, 24 Sep 2023 20:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695612295;
        bh=rtcQe6NmRhy+jCaNA2gtO8YF5aVZI2AhXeyh1LDwH5A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Iv4RpmrDPw7YSPuUQx+YtJ8dvxnxF3b2LR+3AJBBVPONd1GbVBnImIyEab/amtqE1
         PT8gBhT8oYsUgymflCa0YLrnAbgzf4Nln3C3d8csLFCsLQA1Oa7ULYvjHkZf/3rtGR
         vYxl0uPq+k6qwVOKqtwptjc0jJUdQz68pnTaX6WvthTvKFUj+MDzxCxSrnmg5lHqIR
         jkHFLG7XBjndO4X4ZYDVzIs6j20RRMsj1E6fTKRnTy2WH63TzK4ASMkAwV5dGGOx7K
         1gdx8sFyiCpPEAJghPbdo6ZkwjHA+glxRD1u8BCapcUdKuzei1RFTWmbi/HoZIE5xb
         vVF0+oxUGV7gg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rv7Xl3FKMz4xGR;
        Mon, 25 Sep 2023 13:24:55 +1000 (AEST)
Date:   Mon, 25 Sep 2023 13:24:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Adrien Thierry <athierry@redhat.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the phy-next tree with the phy tree
Message-ID: <20230925132454.7210eaef@canb.auug.org.au>
In-Reply-To: <20230925131607.7a71254f@canb.auug.org.au>
References: <20230925131607.7a71254f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5cX9selYLN_OV5vP5E_whei";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5cX9selYLN_OV5vP5E_whei
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 25 Sep 2023 13:16:07 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the phy-next tree got a conflict in:
>=20
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c
>=20
> between commit:
>=20
>   c599dc5cca4d ("phy: qcom-qmp-usb: split PCS_USB init table for sc8280xp=
 and sa8775p")
>=20
> from the phy tree and commits:
>=20
>   7233090aba54 ("phy: qcom-qmp-usb: simplify clock handling")
>   fcf63482f6a9 ("phy: qcom-qmp-usb: rework reset handling")
>=20
> from the phy-next tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

--=20
Cheers,
Stephen Rothwell

Actually the resolution is this:

diff --cc drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index c69577601ae0,2a094f2345f0..02f156298e77
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@@ -1389,12 -1378,6 +1384,8 @@@ static const struct qmp_phy_cfg sa8775p
  	.rx_tbl_num		=3D ARRAY_SIZE(sc8280xp_usb3_uniphy_rx_tbl),
  	.pcs_tbl		=3D sa8775p_usb3_uniphy_pcs_tbl,
  	.pcs_tbl_num		=3D ARRAY_SIZE(sa8775p_usb3_uniphy_pcs_tbl),
 +	.pcs_usb_tbl		=3D sa8775p_usb3_uniphy_pcs_usb_tbl,
 +	.pcs_usb_tbl_num	=3D ARRAY_SIZE(sa8775p_usb3_uniphy_pcs_usb_tbl),
- 	.clk_list		=3D qmp_v4_phy_clk_l,
- 	.num_clks		=3D ARRAY_SIZE(qmp_v4_phy_clk_l),
- 	.reset_list		=3D qcm2290_usb3phy_reset_l,
- 	.num_resets		=3D ARRAY_SIZE(qcm2290_usb3phy_reset_l),
  	.vreg_list		=3D qmp_phy_vreg_l,
  	.num_vregs		=3D ARRAY_SIZE(qmp_phy_vreg_l),
  	.regs			=3D qmp_v5_usb3phy_regs_layout,
@@@ -1413,12 -1396,6 +1404,8 @@@ static const struct qmp_phy_cfg sc8280x
  	.rx_tbl_num		=3D ARRAY_SIZE(sc8280xp_usb3_uniphy_rx_tbl),
  	.pcs_tbl		=3D sc8280xp_usb3_uniphy_pcs_tbl,
  	.pcs_tbl_num		=3D ARRAY_SIZE(sc8280xp_usb3_uniphy_pcs_tbl),
 +	.pcs_usb_tbl		=3D sc8280xp_usb3_uniphy_pcs_usb_tbl,
 +	.pcs_usb_tbl_num	=3D ARRAY_SIZE(sc8280xp_usb3_uniphy_pcs_usb_tbl),
- 	.clk_list		=3D qmp_v4_phy_clk_l,
- 	.num_clks		=3D ARRAY_SIZE(qmp_v4_phy_clk_l),
- 	.reset_list		=3D qcm2290_usb3phy_reset_l,
- 	.num_resets		=3D ARRAY_SIZE(qcm2290_usb3phy_reset_l),
  	.vreg_list		=3D qmp_phy_vreg_l,
  	.num_vregs		=3D ARRAY_SIZE(qmp_phy_vreg_l),
  	.regs			=3D qmp_v5_usb3phy_regs_layout,

--Sig_/5cX9selYLN_OV5vP5E_whei
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUQ/YYACgkQAVBC80lX
0Gxmugf/aTg8RY8mnjdUW22UG5rC4SB9jdA5LdBqGPYdkQ588fPFAUO3ccV7WCLI
c/Se84rEdfdEO4O9u8uzMeRAAjZjggyb1+JSd+JnzR6IDri64xUkMWqmUV+45p80
+oZSJUuqzFD02zjtTY96bPi+NaFTa2NG3Zx5nuS54Xtl8MNam3PEbjuEg/BE5yvA
iEWgWu40Ijm5hrFxoE80QP5x/32XZuSEw7HwAObMTvsM7nat7n39D5I8XpAcrU1b
gqIhQOe5kowuxkirKtNzSAY0Xc7+lvyDQwciLpEYe9lQE4TAiYErAE2WRHicgdAb
Fql8RnOVNPDMnIwXNUHKy0GX4uWt8A==
=IKbW
-----END PGP SIGNATURE-----

--Sig_/5cX9selYLN_OV5vP5E_whei--
