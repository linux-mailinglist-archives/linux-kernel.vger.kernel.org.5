Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715287652A3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjG0Lj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjG0LjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:39:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A36135
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:39:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FEC261E33
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37868C433C7;
        Thu, 27 Jul 2023 11:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690457962;
        bh=AnYhYNSCkoA1i1nJ/uqzgdg16BpZvGqho6C4A1W9zWs=;
        h=Date:From:To:Cc:Subject:From;
        b=YPdwqfQnx8jhE6mVLFootDc0+4r6fjjfl8QpUU+Pt2uRX7QeMPmx/0knPrrFOpBgA
         Qd85hv1zGw/6pzUbmerSZ/U+bGSCCdElgGxLmB6An0hTipdt3rG10fxNr3TeFS31Dm
         4XYiXzZL+ZkXEs5Jmna/kcigqvBWAUSkSfMWiFir0iML8ui7PPsD1NGRW1nE2ROfxI
         EOW/pPFVIbDipTRdSDTRJ6Cbkyd8CRbwo5+B1EEgZdMkj/Bw8I2yCr5K18YhWL2XoK
         J2sFlxcXAVl0D1lL09z69/O36NBHnt8DsqmF3jJe3D2R9y6sHuVJA/sKDbRTq+Sivb
         2hK1BYqDSj0/g==
Date:   Thu, 27 Jul 2023 17:09:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy fixes for v6.5
Message-ID: <ZMJXZoBpjdKbGwxa@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UFkruDOjleKiRkOp"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UFkruDOjleKiRkOp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive few of odd fixes for phy driver for 6.5

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fixes-6.5

for you to fetch changes up to 13c088cf3657d70893d75cf116be937f1509cc0f:

  phy: hisilicon: Fix an out of bounds check in hisi_inno_phy_probe() (2023=
-07-24 16:23:37 +0530)

----------------------------------------------------------------
phy fixes for 6.5

 - Driver fixes for
   - Out of bound fix for hisilicon phy
   - Qualcomm synopsis femto phy for keeping clock enabled during suspend
     and enabling ref clocks
   - Mediatek driver fixes for upper limit test and error code

----------------------------------------------------------------
Adrien Thierry (3):
      phy: qcom-snps-femto-v2: keep cfg_ahb_clk enabled during runtime susp=
end
      phy: qcom-snps-femto-v2: properly enable ref clock
      phy: qcom-snps-femto-v2: use qcom_snps_hsphy_suspend/resume error code

Dan Carpenter (1):
      phy: phy-mtk-dp: Fix an error code in probe()

Guillaume Ranquet (1):
      phy: mediatek: hdmi: mt8195: fix prediv bad upper limit test

Harshit Mogalapalli (1):
      phy: hisilicon: Fix an out of bounds check in hisi_inno_phy_probe()

 drivers/phy/hisilicon/phy-hisi-inno-usb2.c    |  2 +-
 drivers/phy/mediatek/phy-mtk-dp.c             |  2 +-
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c    |  2 +-
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 78 +++++++++++++++++------=
----
 4 files changed, 53 insertions(+), 31 deletions(-)

Thanks
--=20
~Vinod

--UFkruDOjleKiRkOp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmTCV2YACgkQfBQHDyUj
g0cOvxAAw6J2AJqRmV8q/59NcyFUNVaLdrNbVZbJ4Qc8OtYDzChvEdJMVI3+lsjH
yGD3x81aS+GU4bu5tF3/ZGGvIjSyMOU2KEtXJhd6Saf50fnjOpEAygNYDzb83sxg
/hoIxicx+CrIj6KMg64P0utETxkjmEpBY/Fdu0ojGWQRQLj15uK5BBwfn178qqfG
zpkktktg+KqmzP4m+ZcxNawnGSHcEicesrKjZXRcVcyMe6BlWKNjP0AUFedCQIL+
oLPXzaWIW+0LxXGFv0KCAc3OxRs1XUfpvn+nEGK+2GWR6J8emw7ovSglg+OFjMOA
JrgzzblJmu03ryPP+q5+u6g884CsSHfPCQY6xc3VoVqKQ9Ao47msMao1Z6qoL3ne
ubT2DIEoCpQAeNTd4UcUfIPkjrhR4VciHNKFNVOteLxgJDlDhHrFrndXRcIr9+4y
zxKWvL0bT4xXDFLgCilMtOtXA6ftnTgoKKGvi1JoJrw6PM/hjYZdC2bnJ6tDPJAO
sngUM77KG4kxQc2waL8v8j/bWbZD/MoGGzGBHzjmGLcfrxquZTCHavVWGiuRj8rp
jz6l/Uv/hCNRLhyNEQ0n4MDpz2m/eQ6d6UmdewvDr3cd4wXPrYCwHZZ6Fwmk4k5D
wuOQYqk1YjZ1KY9RxN9jBNBJ1nk9KL2jlkN/yXuSavWriB2F6Co=
=2Zqs
-----END PGP SIGNATURE-----

--UFkruDOjleKiRkOp--
