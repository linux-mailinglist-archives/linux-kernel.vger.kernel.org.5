Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E6176C152
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 02:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjHBAEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 20:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHBAES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 20:04:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CFC1BF1;
        Tue,  1 Aug 2023 17:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690934656;
        bh=/1AYR3u+fp6twlJczWRR8fJid1pqils23A/4o/VRoAM=;
        h=Date:From:To:Cc:Subject:From;
        b=rlhFgRFknij3jipwvgocxI38oSQWz9McpqK1ACHOjrPI0gjD3LAavV0xNNyoaJv91
         jKWj7yvgdqoDbn8dmuWFvxNXbI2X609FBJgnMZBG/Nbk1afj2pybu1uVv+a7SfAtiv
         H+pMZltMB5kO5r18iVOfB2K6iQRmSXNNrKPXniW86fUbxniHniSwi1pkF2iKbU7OFY
         nZ1DDLmBEZuJLM0AcDy8gnNzDqpdqXWlD1Fn7gblTrVZbMuFHB7UzK2Cl2QquraPet
         dVYd+rMKtCAP+a3/xN13kLyfh6bxwYOlstMchP2o1hUJzSacRqILxtBBx9jKZxkzP8
         zTQ1EvaTsbDiA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RFsf816Fzz4yGK;
        Wed,  2 Aug 2023 10:04:15 +1000 (AEST)
Date:   Wed, 2 Aug 2023 10:04:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the clk tree with the qcom tree
Message-ID: <20230802100413.199544b8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=cWgl+3MPnFtowoGaMWM=RT";
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

--Sig_/=cWgl+3MPnFtowoGaMWM=RT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the clk tree got a conflict in:

  drivers/clk/qcom/lcc-mdm9615.c

between commit:

  bac4675a4d1b ("clk: qcom: drop lcc-mdm9615 in favour of lcc-msm8960")

from the qcom tree and commit:

  a96cbb146a97 ("clk: Explicitly include correct DT includes")

from the clk tree.

I fixed it up (the former removed the file, so I just did that) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/=cWgl+3MPnFtowoGaMWM=RT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTJnX0ACgkQAVBC80lX
0Gx6kwf+L5uoK11LkXd+DGz8xU62vYGAgUjfJVuy2EckNHfAJ4JSzBiBAMMmA2vm
OwFZ5FVGtHY+IFXTuwgvU99N+2jkcK/1srvAv1JzYXJZavEp9nOLuoRYzK2OwiSR
eT4071x7Hr+ecMfnp1J0OroiDBagFTV1Zvub3iLomooR5mvpIXNXKrpRW7553Zim
jB1oJi0Wju0xQ54vwr+BxbypVe0Fi3xHKkf20pwT7P1OYTEzWojIBr3xQ7n/PyoA
PaUt8y2kkZedhH0uO+Ph/Ni1liwi6VUu5DHlzIOsvtaaK+uHzO1zGUZ3Appi0Bn8
EHGCFvFDlOPCKtpjK8xIV8Gz+QrQlA==
=BQrb
-----END PGP SIGNATURE-----

--Sig_/=cWgl+3MPnFtowoGaMWM=RT--
