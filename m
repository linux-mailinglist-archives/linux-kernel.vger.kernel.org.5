Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E90E7ACE9B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 05:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjIYDKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 23:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjIYDKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:10:33 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D7AA4;
        Sun, 24 Sep 2023 20:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695611424;
        bh=EbNGHdwWsbSS+G8Yx4d/omzpYIk/5RTo9vgMOuaOGsk=;
        h=Date:From:To:Cc:Subject:From;
        b=huqIWdwy29RSMhMGyq9M5/+2nDhHxt1GrppB6PllYNvPJYoVH+yegIH1dFaAxAM3x
         jPnpmd+AXkiDoC8ZivLv8pG1gyUopN1lHkjaIJegZw16WRWy/D6+0XGj006QJl5zTy
         sjTQuGC08qw9jrmkNkLQwiNDTJG6Y53TRqVbiDf6jJQmT/MN+iSkXJ4cPM9Jt6CdJD
         NG6rSJz/vi43oQcXShN0l50ZHX9bA2pqLASw7b/3Nt8Qke93TVK/DSyhZWP0R+GrwO
         cAnKwDwuxkOc2FmiaFhLYIUzQHUiRqYmSzB1E/IRKK3IpiXhRK71llCpvIQ0fH8EQJ
         UzrUiQe4agNrg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rv7Cz56Kfz4xF8;
        Mon, 25 Sep 2023 13:10:23 +1000 (AEST)
Date:   Mon, 25 Sep 2023 13:10:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nitheesh Sekar <quic_nsekar@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: linux-next: manual merge of the phy-next tree with the phy tree
Message-ID: <20230925131022.24514a20@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0wkbNgTbgeFWE5oiS0GhEkf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0wkbNgTbgeFWE5oiS0GhEkf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the phy-next tree got a conflict in:

  drivers/phy/qualcomm/phy-qcom-m31.c

between commits:

  5f7cd740a6b6 ("phy: qcom: phy-qcom-m31: fix wrong pointer pass to PTR_ERR=
()")
  426e05ce126e ("phy: qcom: phy-qcom-m31: change m31_ipq5332_regs to static=
")

from the phy tree and commits:

  90f7af497a78 ("phy: qcom: m31: Fix indentation issues")
  68320e35f8cb ("phy: qcom-m31: Add compatible, phy init sequence for IPQ50=
18")

from the phy-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/phy/qualcomm/phy-qcom-m31.c
index 5cb7e79b99b3,d5af4dde6960..000000000000
--- a/drivers/phy/qualcomm/phy-qcom-m31.c
+++ b/drivers/phy/qualcomm/phy-qcom-m31.c
@@@ -82,7 -82,51 +82,51 @@@ struct m31_priv_data=20
  	unsigned int			nregs;
  };
 =20
+ static const struct m31_phy_regs m31_ipq5018_regs[] =3D {
+ 	{
+ 		.off =3D USB_PHY_CFG0,
+ 		.val =3D UTMI_PHY_OVERRIDE_EN
+ 	},
+ 	{
+ 		.off =3D USB_PHY_UTMI_CTRL5,
+ 		.val =3D POR_EN,
+ 		.delay =3D 15
+ 	},
+ 	{
+ 		.off =3D USB_PHY_FSEL_SEL,
+ 		.val =3D FREQ_SEL
+ 	},
+ 	{
+ 		.off =3D USB_PHY_HS_PHY_CTRL_COMMON0,
+ 		.val =3D COMMONONN | FSEL | RETENABLEN
+ 	},
+ 	{
+ 		.off =3D USB_PHY_REFCLK_CTRL,
+ 		.val =3D CLKCORE
+ 	},
+ 	{
+ 		.off =3D USB_PHY_UTMI_CTRL5,
+ 		.val =3D POR_EN
+ 	},
+ 	{
+ 		.off =3D USB_PHY_HS_PHY_CTRL2,
+ 		.val =3D USB2_SUSPEND_N_SEL | USB2_SUSPEND_N | USB2_UTMI_CLK_EN
+ 	},
+ 	{
+ 		.off =3D USB_PHY_UTMI_CTRL5,
+ 		.val =3D 0x0
+ 	},
+ 	{
+ 		.off =3D USB_PHY_HS_PHY_CTRL2,
+ 		.val =3D USB2_SUSPEND_N | USB2_UTMI_CLK_EN
+ 	},
+ 	{
+ 		.off =3D USB_PHY_CFG0,
+ 		.val =3D 0x0
+ 	},
+ };
+=20
 -struct m31_phy_regs m31_ipq5332_regs[] =3D {
 +static struct m31_phy_regs m31_ipq5332_regs[] =3D {
  	{
  		USB_PHY_CFG0,
  		UTMI_PHY_OVERRIDE_EN,
@@@ -255,8 -300,8 +299,8 @@@ static int m31usb_phy_probe(struct plat
 =20
  	qphy->vreg =3D devm_regulator_get(dev, "vdda-phy");
  	if (IS_ERR(qphy->vreg))
 -		return dev_err_probe(dev, PTR_ERR(qphy->phy),
 +		return dev_err_probe(dev, PTR_ERR(qphy->vreg),
- 						"failed to get vreg\n");
+ 				     "failed to get vreg\n");
 =20
  	phy_set_drvdata(qphy->phy, qphy);
 =20

--Sig_/0wkbNgTbgeFWE5oiS0GhEkf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUQ+h4ACgkQAVBC80lX
0Gw2YQgAnIA6YZw/L0WV/2R6KAyIftzDe0JQ8+jKvxyLpb5nG11KrAmlqGLz2bVO
YY3s5jzaTc3cqfnkddrIZ05P4DD+Wex041iXIdWKEV2MWYvcXHue+8wLHrbQyN0+
M9MP1KI+TWxtci+uO4YdO8pfeWyd1i6h6HMXyN27HPgXDzLGkW6tgFCQH8QZIKQo
0l+G5acgoEQg08HvYxMyT51Ttzlf00tSo8iJxC2/p/zud87xJsmGrcsCgJoQxaUv
0/MVcM8P5YtM3t+CmkAC986yHhr4emq8+KitGkavMfXulTR5UtmZWSFhPG77i94J
aPli9UIdYvNcKCokJwiVZnrjI9yWMg==
=Dt8D
-----END PGP SIGNATURE-----

--Sig_/0wkbNgTbgeFWE5oiS0GhEkf--
