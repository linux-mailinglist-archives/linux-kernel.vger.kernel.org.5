Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEA17BEF5E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379043AbjJIXua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379099AbjJIXu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:50:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5269D;
        Mon,  9 Oct 2023 16:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696895425;
        bh=dnZV4RzzP9FMaCBlEyghmh9sjDpcoyZ4mg0YcWIuolc=;
        h=Date:From:To:Cc:Subject:From;
        b=tSkHXXoM9Sjk+lz7z09c2ciLGLCcVnS/Z6WPaGHThiUe99eaxykYGk3XiyPfs23dU
         4ApY/LNgrBKn0HIgDiFP+CcOvsmFPDT4hpXMEh1xEcFwI68lq6KC+akAGXbPyJYMi9
         273bcE5qhTN6LW9fOoyyzUOZ9SgH79Q1RrCeYLfS+ehynpJa2dzO/6Icyd3MxWUxSq
         T9iz4cGpMIkuPDEZH3S2c5jaRYoJDBE+md2cN20DXgLSRUqrDwbDNrEjng4ffKdHWO
         nZz2wb3tzTuH9005LjNVtBeZfrVmPB2gVtQJ/L7IHmGsIhF7piRsY7OzxzMTRi4JDK
         9iy15hN9Eig/Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S4G4G6MkRz4x1p;
        Tue, 10 Oct 2023 10:50:22 +1100 (AEDT)
Date:   Tue, 10 Oct 2023 10:50:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Larsson <alexl@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: linux-next: manual merge of the vfs-brauner tree with the overlayfs
 tree
Message-ID: <20231010105021.57fa4379@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZKIpQ573POdotYh0BhHD3UK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZKIpQ573POdotYh0BhHD3UK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/overlayfs/super.c

between commit:

  1e97d6e67406 ("ovl: Move xattr support to new xattrs.c file")

from the overlayfs tree and commit:

  3f644c1cd7b5 ("overlayfs: move xattr tables to .rodata")

from the vfs-brauner tree.

I fixed it up (I used the former version of this file and applied the
following merge fix patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 10 Oct 2023 10:47:16 +1100
Subject: [PATCH] fix up for "ovl: Move xattr support to new xattrs.c file"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/overlayfs/xattrs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/xattrs.c b/fs/overlayfs/xattrs.c
index 1b16b0abdf91..8a9c76adbf5c 100644
--- a/fs/overlayfs/xattrs.c
+++ b/fs/overlayfs/xattrs.c
@@ -251,13 +251,13 @@ static const struct xattr_handler ovl_other_xattr_han=
dler =3D {
 	.set =3D ovl_other_xattr_set,
 };
=20
-static const struct xattr_handler *ovl_trusted_xattr_handlers[] =3D {
+static const struct xattr_handler * const ovl_trusted_xattr_handlers[] =3D=
 {
 	&ovl_own_trusted_xattr_handler,
 	&ovl_other_xattr_handler,
 	NULL
 };
=20
-static const struct xattr_handler *ovl_user_xattr_handlers[] =3D {
+static const struct xattr_handler * const ovl_user_xattr_handlers[] =3D {
 	&ovl_own_user_xattr_handler,
 	&ovl_other_xattr_handler,
 	NULL
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/ZKIpQ573POdotYh0BhHD3UK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUkkb0ACgkQAVBC80lX
0GzaWgf/cC2TeY5OJwDdyGfsM7vDQfmIA7qSksnT7pm2cCw++vrT9j1guCo2is9D
EOrfFlh54szOgU7R/L3r5EZiIuHbI4xao4dOZ4qvwi0wOjcZWYkrOLlgKxoWJjXm
oJghbxa8KUKpExlBizXO+85bJzsmKm2AycHpT2KEAZiRVxmKTDFFSKxYte9mHqWw
jLc1JlmMpHBkXehx1tKehqNIggQ31Jcjcwtv6NvL4hiFcjKtDg679pM6LMaaTJCj
fysUEioo4E3Ek9sgNfdj3omQpru410OCu+t8S5P67NvAsElsCO1joV1Vj59vSyQF
YpX84VWKhDZJS83hTr4eMjhEgESuAw==
=Q+Y+
-----END PGP SIGNATURE-----

--Sig_/ZKIpQ573POdotYh0BhHD3UK--
