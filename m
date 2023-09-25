Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550C07ACEA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 05:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjIYDQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 23:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjIYDQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:16:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42FDA3;
        Sun, 24 Sep 2023 20:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695611768;
        bh=IbOLLWCtNmvTBpTRJAEhO2mJOGjVP6fyeHq9AFXzBaw=;
        h=Date:From:To:Cc:Subject:From;
        b=jN1jvs+lcyBnjETK8LI2jW5JEFSXWx4vXlNnnhb9sgh47lYIguC4dlWq/zwTemq0c
         pWISYSHBOpFEHoBkAeBM9NYtARRAI/1f9PtJuhxQO0qwKsKNixi4Y/wDaE1JIgZ/0M
         SMCme8p4s30pXqllMbCAIt5Hopad2t+7QWDlPaE4z7xQ6QbgU6UpUBlwtTFKis/gYd
         lWj75nWfOCUjQCJLJeutlpKxT6uraQ3BxwR2qCpGp+2s0xPGGEtSi7lPuAO9z7Q09M
         /PAXAmBap5HCbyZMECFuQQwYbjnnAddr1pOSj2UZZRGhE4+/GUzYJ08EIAPWfQOMKd
         wG9+UndlPLMug==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rv7Lc4wZqz4xGR;
        Mon, 25 Sep 2023 13:16:08 +1000 (AEST)
Date:   Mon, 25 Sep 2023 13:16:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Adrien Thierry <athierry@redhat.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the phy-next tree with the phy tree
Message-ID: <20230925131607.7a71254f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.gR1P+1sU_QRornL/vSKo5+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.gR1P+1sU_QRornL/vSKo5+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the phy-next tree got a conflict in:

  drivers/phy/qualcomm/phy-qcom-qmp-usb.c

between commit:

  c599dc5cca4d ("phy: qcom-qmp-usb: split PCS_USB init table for sc8280xp a=
nd sa8775p")

from the phy tree and commits:

  7233090aba54 ("phy: qcom-qmp-usb: simplify clock handling")
  fcf63482f6a9 ("phy: qcom-qmp-usb: rework reset handling")

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

diff --cc drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index c69577601ae0,2a094f2345f0..000000000000
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@@ -1389,12 -1378,6 +1384,10 @@@ static const struct qmp_phy_cfg sa8775p
  	.rx_tbl_num		=3D ARRAY_SIZE(sc8280xp_usb3_uniphy_rx_tbl),
  	.pcs_tbl		=3D sa8775p_usb3_uniphy_pcs_tbl,
  	.pcs_tbl_num		=3D ARRAY_SIZE(sa8775p_usb3_uniphy_pcs_tbl),
 +	.pcs_usb_tbl		=3D sa8775p_usb3_uniphy_pcs_usb_tbl,
 +	.pcs_usb_tbl_num	=3D ARRAY_SIZE(sa8775p_usb3_uniphy_pcs_usb_tbl),
 +	.clk_list		=3D qmp_v4_phy_clk_l,
 +	.num_clks		=3D ARRAY_SIZE(qmp_v4_phy_clk_l),
- 	.reset_list		=3D qcm2290_usb3phy_reset_l,
- 	.num_resets		=3D ARRAY_SIZE(qcm2290_usb3phy_reset_l),
  	.vreg_list		=3D qmp_phy_vreg_l,
  	.num_vregs		=3D ARRAY_SIZE(qmp_phy_vreg_l),
  	.regs			=3D qmp_v5_usb3phy_regs_layout,
@@@ -1413,12 -1396,6 +1406,10 @@@ static const struct qmp_phy_cfg sc8280x
  	.rx_tbl_num		=3D ARRAY_SIZE(sc8280xp_usb3_uniphy_rx_tbl),
  	.pcs_tbl		=3D sc8280xp_usb3_uniphy_pcs_tbl,
  	.pcs_tbl_num		=3D ARRAY_SIZE(sc8280xp_usb3_uniphy_pcs_tbl),
 +	.pcs_usb_tbl		=3D sc8280xp_usb3_uniphy_pcs_usb_tbl,
 +	.pcs_usb_tbl_num	=3D ARRAY_SIZE(sc8280xp_usb3_uniphy_pcs_usb_tbl),
 +	.clk_list		=3D qmp_v4_phy_clk_l,
 +	.num_clks		=3D ARRAY_SIZE(qmp_v4_phy_clk_l),
- 	.reset_list		=3D qcm2290_usb3phy_reset_l,
- 	.num_resets		=3D ARRAY_SIZE(qcm2290_usb3phy_reset_l),
  	.vreg_list		=3D qmp_phy_vreg_l,
  	.num_vregs		=3D ARRAY_SIZE(qmp_phy_vreg_l),
  	.regs			=3D qmp_v5_usb3phy_regs_layout,

--Sig_/.gR1P+1sU_QRornL/vSKo5+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUQ+3cACgkQAVBC80lX
0Gzr7gf/SDBymukcauQCxmZPkk30Pd55cRmiiHHK7a4HqyFHIW2LFjzEqJtX3tT9
mgPGdJRbk8v/wdBNBj0NEbcna2pK9lQAlr7bEutj/vrv35ye0yZwxKfwj+wO7sMX
D767sr8NcilpCQ2wTBoMHwpnpd0j6Mb4/hfSQuwYTZI23cqI5m38opTpBPjWWW9b
c6R+cqwAukgr7K7xK/c0az1szMwsKv4rirXEE0DPuSP0tiaDmT+oz4pM52tKgvw6
WBezMt/lyp4bgBqwkd2AMXsTUGLWvcoVdakThtnUZOqhSSX12c3iuxd9C+FmhRdF
ml4DAmEWytcQWTUtq8crYzAQCn74MQ==
=ombW
-----END PGP SIGNATURE-----

--Sig_/.gR1P+1sU_QRornL/vSKo5+--
