Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0F9787CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbjHYBF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237893AbjHYBFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:05:47 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB74CE77;
        Thu, 24 Aug 2023 18:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692925538;
        bh=uUtGTs4X78PexzbkEEJy8B6OYkJ7Qlh9Azo+AhsdcG4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m1yF+I+67+M7nlRTlQCDWT8EVPOjO5C/S08lrwOEdDGfWEsmTn2Uu9vCRTAADLVNB
         2mUhUnz0wENmhHk8Z1eP4RO9UoYK/6hyKN0NowEEx3NHUexchewJSPH3lrHkahl28d
         0/mFFyJJazOqh3t4f0nGuJliYxm1PjzbECnunjkHmf2LDlNLy52GEZi5U+Y4ZHXfad
         b1TrhMiBC1zEm4WjPxFPd7/nCW/IloM8zUC/QXSCaWhqyDOmjsxJXQz1iG9/eA8ISo
         FpU2Yj/m1Q3cWlGQBsUqSC+Toiy1pbdNzGo/hozYdhq1LIVO4icO3hkjkZZ7E4mthy
         qzyjHDN4PWHUg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RX1wL0R8Xz4wxK;
        Fri, 25 Aug 2023 11:05:38 +1000 (AEST)
Date:   Fri, 25 Aug 2023 11:05:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: linux-next: manual merge of the mlx5-next tree with Linus' tree
Message-ID: <20230825110536.41195860@canb.auug.org.au>
In-Reply-To: <20230815123725.4ef5b7b9@canb.auug.org.au>
References: <20230815123725.4ef5b7b9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eS=2.ipWSCZYskORoxqV2PG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eS=2.ipWSCZYskORoxqV2PG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 15 Aug 2023 12:37:25 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the mlx5-next tree got a conflict in:
>=20
>   drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c
>=20
> between commit:
>=20
>   aeb660171b06 ("net/mlx5e: fix double free in macsec_fs_tx_create_crypto=
_table_groups")
>=20
> from Linus' tree and commit:
>=20
>   cb5ebe4896f9 ("net/mlx5e: Move MACsec flow steering operations to be us=
ed as core library")
>=20
> from the mlx5-next tree.
>=20
> I fixed it up (I removed this file and added the following patch) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 15 Aug 2023 12:34:29 +1000
> Subject: [PATCH] fix up for "net/mlx5e: Move MACsec flow steering operati=
ons to be used as core library"
>=20
> interacting with commit
>=20
>   aeb660171b06 ("net/mlx5e: fix double free in macsec_fs_tx_create_crypto=
_table_groups")
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/dr=
ivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
> index 2f2cb67717cd..4a078113e292 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
> @@ -278,6 +278,7 @@ static int macsec_fs_tx_create_crypto_table_groups(st=
ruct mlx5_macsec_flow_table
> =20
>  	if (!in) {
>  		kfree(ft->g);
> +		ft->g =3D NULL;
>  		return -ENOMEM;
>  	}
> =20
> --=20
> 2.40.1

Was the second part of this resolution (i.e. the update to
drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c) missed, or
deemed unnecessary after the mlx5-next tree was merged into the
net-next tree?

--=20
Cheers,
Stephen Rothwell

--Sig_/eS=2.ipWSCZYskORoxqV2PG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTn/mAACgkQAVBC80lX
0GxnjQf+OLjT+aIodPPEee6ZS0dGT2tpO8Il8DoDSuI+9ehadfbHjNQeGLjsU4bk
Q0DrHAItV9+r+E5BDGdzg+7P9K9DzYYN0i/PFIuYAmwu7ZkIVn64xULiAJjvqlMa
Fc0iLWq6AMXXdcHsfTzs0RL1Gh+FG5e33evnguza04l+DIhatwJbDNnMnAs9SSW6
67ZV562z2KZxnnOidccmSY8k+RAfszCDR5SAsZMfRA+A25g8cCKf611mQ/rB63LA
iYqpptTy+nbvw9MDBmMS41lWvJ375QZiDDmwbuJUPI2OkbdChsdxFkG1/AJlcqGM
P6tsiaamWBUFWjZ0hAvaWIto3eBPgw==
=CBIa
-----END PGP SIGNATURE-----

--Sig_/eS=2.ipWSCZYskORoxqV2PG--
