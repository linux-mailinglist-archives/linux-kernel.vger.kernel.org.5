Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004FC7DFC56
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377465AbjKBWYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbjKBWYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:24:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E04191;
        Thu,  2 Nov 2023 15:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698963861;
        bh=ZlVCvY82QOeLiHdlrr8UQ+RcoGdT/HaxJojnEOjSafw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b83w4jl2s0xNtIoH8SVL9ix+itLwetnVXKCl0A6LA0nm4dSj0rGFZfHXqvmGcBPQx
         TVkT9nyUxMLdiQD5hvrmSGxe9E4JBsOvcA46ZnVvKLgMl+aDWspAe4DxvD7XQwSkjD
         jMxrDQ3kF6aJ2mVmRKOMWZcddFZMVhXvcs+7Ab1rjKzQ7+mHVJrxbi6CGC+ALIMOu2
         wBuAmsAIb4pdmREuWTStUWCDBm4R2OBusqig1LGALP18DLavOdnxLYyqMYsPcj5r1F
         63HeJMCw3Ou3GrJI+3vpk8eZbx+9ktic2g6TAI+dEm9p7HriJltMm/9VD/wMKIcE8Q
         G1ijxpIgy/9Bg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SLz1w4x4hz4xNH;
        Fri,  3 Nov 2023 09:24:20 +1100 (AEDT)
Date:   Fri, 3 Nov 2023 09:24:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Jack Brennen <jbrennen@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: linux-next: manual merge of the modules tree with the kbuild
 tree
Message-ID: <20231103092419.5eb5fcdd@canb.auug.org.au>
In-Reply-To: <20231004114354.39a71ab3@canb.auug.org.au>
References: <20231004114354.39a71ab3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/C7E/kMuG_RqMba91bhYsXBR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/C7E/kMuG_RqMba91bhYsXBR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 4 Oct 2023 11:43:54 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the modules tree got a conflict in:
>=20
>   scripts/mod/modpost.c
>=20
> between commit:
>=20
>   4074532758c5 ("modpost: Optimize symbol search from linear to binary se=
arch")
>=20
> from the kbuild tree and commit:
>=20
>   dc95e422c283 ("module: Make is_valid_name() return bool")
>=20
> from the modules tree.
>=20
> I fixed it up (I used the former version of this files and applied the
> following merge resolution patch) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 4 Oct 2023 11:39:03 +1100
> Subject: [PATCH] fix up for "module: Make is_valid_name() return bool"
>=20
> interacting with commit
>=20
>   4074532758c5 ("modpost: Optimize symbol search from linear to binary se=
arch")
>=20
> from the kbuild tree.
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  scripts/mod/modpost.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index 6413f26fcb6b..5a0324f3257f 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -163,12 +163,12 @@ static inline unsigned int get_secindex(const struc=
t elf_info *info,
>   *
>   * Internal symbols created by tools should be ignored by modpost.
>   */
> -static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
> +static inline bool is_valid_name(struct elf_info *elf, Elf_Sym *sym)
>  {
>  	const char *name =3D elf->strtab + sym->st_name;
> =20
>  	if (!name || !strlen(name))
> -		return 0;
> +		return false;
>  	return !is_mapping_symbol(name);
>  }

This is now a conflict between the kbuild tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/C7E/kMuG_RqMba91bhYsXBR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVEIZQACgkQAVBC80lX
0GwjOwf/URVrI6ilIzTnAxCt/nyoaSM8wbKj7KEw5MngcnBan1Qp7cUxrUU/yAk+
vIht8lAG+l7KQ9qXKYyE0UfSn5xSaKwiUKJAzzhqC1zZG+GFKQmVZYuFpKEE5zUP
6tYg3nxpvx2RFia0NSPQSPVPJ2gfrbZlxHLJ2K6GhWQ+W0wZKFC0UWfCcsDEeOrU
jGr5NfgG4i9461Q/ONC8EoxWsblsr/6Atof1LLAPKpxCno5tuUdLAqVvFSa6KmOK
O6jpfw+rPQug7y3O+dO1pQ3CSN1K5iMLt7MVanPDPv5Qo5QNwT+OpbdHFjJKgBQ/
V0zfmJHy5iWjKtD5z1OtcaBoMm5dog==
=5+nE
-----END PGP SIGNATURE-----

--Sig_/C7E/kMuG_RqMba91bhYsXBR--
