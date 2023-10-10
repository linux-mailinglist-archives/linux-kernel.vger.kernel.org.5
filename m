Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2184E7BEF94
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379203AbjJJAOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379198AbjJJAOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:14:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56342BA;
        Mon,  9 Oct 2023 17:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696896881;
        bh=jFlQ3s3LQk6tdvYwwzOFk/cBbTkwmxGKuqdREZ+lt9s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZNu5PanXqKbNF2kLvMJ3H7XfyBXsTCBXh3Upz6mUokVU0uwDDlDpEQsPHs1c74eSe
         bg1/e1OJZLP8BX7+Xz82ROGnn8cHUUfeyqeX8KJNC3mdi4OdaJ6sI/W4hwKKIJ/b4W
         W5cghZEpz3E//HkRIydBKeDnriToK87/4nNKKjsX0APOLU+/Ust/WifWlQ7CENNNhf
         iqJtfd3Tg0tpUMdSQV4/gutt5QYfoFd2+8N8vHBs3r1pkMo7DqPuB+tEdsqRiHsQjp
         C7holmOFpzz+BGvQBx+HSufRYPgOdvrRmEOcRGihbHtKwV4RBzsNHtacROmGdt2A/k
         I+FrBfaUGS12Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S4GcJ56Zfz4xVM;
        Tue, 10 Oct 2023 11:14:40 +1100 (AEDT)
Date:   Tue, 10 Oct 2023 11:14:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Larsson <alexl@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the
 overlayfs tree
Message-ID: <20231010111436.46f64716@canb.auug.org.au>
In-Reply-To: <20231010105021.57fa4379@canb.auug.org.au>
References: <20231010105021.57fa4379@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fpKi.XBnSUNuJZPtVDLDCb2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fpKi.XBnSUNuJZPtVDLDCb2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 10 Oct 2023 10:50:21 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the vfs-brauner tree got a conflict in:
>=20
>   fs/overlayfs/super.c
>=20
> between commit:
>=20
>   1e97d6e67406 ("ovl: Move xattr support to new xattrs.c file")
>=20
> from the overlayfs tree and commit:
>=20
>   3f644c1cd7b5 ("overlayfs: move xattr tables to .rodata")
>=20
> from the vfs-brauner tree.
>=20
> I fixed it up (I used the former version of this file and applied the
> following merge fix patch) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Actually needs this:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 10 Oct 2023 10:47:16 +1100
Subject: [PATCH] fix up for "ovl: Move xattr support to new xattrs.c file"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/overlayfs/overlayfs.h | 2 +-
 fs/overlayfs/xattrs.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 620d89ba4b6e..ca88b2636a57 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -864,7 +864,7 @@ static inline bool ovl_force_readonly(struct ovl_fs *of=
s)
=20
 /* xattr.c */
=20
-const struct xattr_handler **ovl_xattr_handlers(struct ovl_fs *ofs);
+const struct xattr_handler * const *ovl_xattr_handlers(struct ovl_fs *ofs);
 int ovl_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		struct iattr *attr);
 int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
diff --git a/fs/overlayfs/xattrs.c b/fs/overlayfs/xattrs.c
index 1b16b0abdf91..383978e4663c 100644
--- a/fs/overlayfs/xattrs.c
+++ b/fs/overlayfs/xattrs.c
@@ -251,19 +251,19 @@ static const struct xattr_handler ovl_other_xattr_han=
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
 };
=20
-const struct xattr_handler **ovl_xattr_handlers(struct ovl_fs *ofs)
+const struct xattr_handler * const *ovl_xattr_handlers(struct ovl_fs *ofs)
 {
 	return ofs->config.userxattr ? ovl_user_xattr_handlers :
 		ovl_trusted_xattr_handlers;
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/fpKi.XBnSUNuJZPtVDLDCb2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUkl2wACgkQAVBC80lX
0Gz+sQgAh0oCKUNBc9TxuPivoUcTkpKxxyv8Zj247DAysOHETEQrqVxPlHxXfVRR
f2hqP9A5kGPHHZ8NCjKRNsbjvGFd0HAF0n294mUQXb4pPSELYuyLCTWFbk+hW3+T
xHs+XBOu1Be1VlwDMUstAn3lImAboZD8atr1IAPBKok0n0M+xTkoGZShHT08eS3m
+KHJqaD7LArxkX4PG4whYKxWIf5vCeZ4MZFth0v047uAXmpZA/upW6PXkKRu/M0D
XLvSVahiMh6wpkBEES8KHV45XTpfGgMH6nOQ4rEIsYEeCuhklvdsAdiI1Daz9kcL
RoiJ+sBvsBv1tEEpXmqrzlq9tAcz6g==
=Kcyq
-----END PGP SIGNATURE-----

--Sig_/fpKi.XBnSUNuJZPtVDLDCb2--
