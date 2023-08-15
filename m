Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5729E77C600
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjHOCiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjHOChj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:37:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52B9173D;
        Mon, 14 Aug 2023 19:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692067046;
        bh=huKMfCWmr5WH8y8VWSx6JW2chuwKekbLHr8GF8q/rg0=;
        h=Date:From:To:Cc:Subject:From;
        b=PPcvuPNhH8xLLx593UBSz53n1miJBYeZzga8YfNb4FZUcHrsPyv7LNn1CLNcV9WiC
         hPTzxUnmS6BfJqSWeKyCaiSBmmWYfhbYPWnfnbtj4UMK2H0dCWFPnKkvTDRKTZYwT1
         9JJ/TbKp2KvcRfg3gBkRwJ8GI4VTWyvdfVyRIvby9hmXgYFu/giRrnMIQilLz+yHqg
         KFaGYeIJZDp8bU/O9jRcTOtTtHSOQdRVbLXAfDtlBIVI9zxQzZ9QCCFSIl+0w30d1D
         SYn3eP3zU0Dnj17W9XDdD4toeOwMJ5O3LioCjeP15nMMQ5qgHJb+IkHZCDbvI9/EAb
         uSpoJ5/uwy4LA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPwQt5D2vz4wZx;
        Tue, 15 Aug 2023 12:37:26 +1000 (AEST)
Date:   Tue, 15 Aug 2023 12:37:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>
Subject: linux-next: manual merge of the mlx5-next tree with Linus' tree
Message-ID: <20230815123725.4ef5b7b9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aspgHXhiW1RW0x0i5noZGVE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aspgHXhiW1RW0x0i5noZGVE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mlx5-next tree got a conflict in:

  drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c

between commit:

  aeb660171b06 ("net/mlx5e: fix double free in macsec_fs_tx_create_crypto_t=
able_groups")

from Linus' tree and commit:

  cb5ebe4896f9 ("net/mlx5e: Move MACsec flow steering operations to be used=
 as core library")

from the mlx5-next tree.

I fixed it up (I removed this file and added the following patch) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 15 Aug 2023 12:34:29 +1000
Subject: [PATCH] fix up for "net/mlx5e: Move MACsec flow steering operation=
s to be used as core library"

interacting with commit

  aeb660171b06 ("net/mlx5e: fix double free in macsec_fs_tx_create_crypto_t=
able_groups")

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/driv=
ers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
index 2f2cb67717cd..4a078113e292 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
@@ -278,6 +278,7 @@ static int macsec_fs_tx_create_crypto_table_groups(stru=
ct mlx5_macsec_flow_table
=20
 	if (!in) {
 		kfree(ft->g);
+		ft->g =3D NULL;
 		return -ENOMEM;
 	}
=20
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/aspgHXhiW1RW0x0i5noZGVE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTa5OYACgkQAVBC80lX
0Gx1JwgAjN50iYaT5uUmOnH+7QR6KHFwsJn9/7FGS6HQnKpjleknH97SiJM/L/Gq
xqA424YRtrNFM6dkagD5gXQV2XnxDSLbVvV+HPFIhjOZdoK5QA7IpQpNN1kC02//
U2YcIUvbqJUQnOHO1Fc5Ftw1jVcagenLlCN3Lf9NQPmmOaIOd138bK1HE22qYdNM
YLHSBDU6EyNPVfcS+Kb1NQdf4wuBpcP42Qlnd9O2ia9Ej4NwaOT9BxbFmT6shDUk
U5jtYhYIzT3Md4OqFjDspHIdUvNO9LHqwuqObme7OvtYhFiEb52qT0FhGpWSaCU3
6Yswbttw3r0NtIn3wVrd4s0yEB5E5g==
=zvZm
-----END PGP SIGNATURE-----

--Sig_/aspgHXhiW1RW0x0i5noZGVE--
