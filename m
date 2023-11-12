Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C665C7E92F4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 23:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjKLWXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 17:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKLWXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 17:23:49 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B2B99;
        Sun, 12 Nov 2023 14:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699827822;
        bh=gpKOZ2ZliO+ojYZiPqXGUp9onC1Hm/oLrNozyclSdjQ=;
        h=Date:From:To:Cc:Subject:From;
        b=RB4fq6gB27P1LpBUYO4wUZJ25XEvUhmRegZaa5/4t2Sfz3g31Z6P+OoRrhU6SNQLv
         wui9DIF1wt5KinWUV/VO2BUd9aCBsyBYVhzfV6HfSRkDcqOygFY8yzqeM4TgIBYhVC
         RCyBI8VgCFH+InumoajjuX5JWq1WUpkkcllVb9c8tTV7TGRq1SmH981b/j3Djk5jqE
         2cE0pqODJmiFnQlRIDlVOluFwR35PJ13LeKEQ/G4jxT6YAEaYTV/VMbE9o5JOdZH77
         B3GwBuKMCzyKLJfOP4Kaa8p4teWSK6O0MJ1GH9EyWlulN1ZhK+XffFfMRL1KX+aG1D
         8sOb4/bQL1Txw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4ST6XY5tbFz4wdB;
        Mon, 13 Nov 2023 09:23:41 +1100 (AEDT)
Date:   Mon, 13 Nov 2023 09:23:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bcachefs tree with the origin tree
Message-ID: <20231113092340.6555b428@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GpQKy1LgZXVJwFlPpBVMGFS";
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

--Sig_/GpQKy1LgZXVJwFlPpBVMGFS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bcachefs tree got a conflict in:

  fs/bcachefs/btree_types.h

between commit:

  ecae0bd5173b ("Merge tag 'mm-stable-2023-11-01-14-33' of git://git.kernel=
.org/pub/scm/linux/kernel/git/akpm/mm")

from the origin tree and commit:

  ba1676c7af0c ("bcachefs: Split out btree_key_cache_types.h")

from the bcachefs tree.

I fixed it up (I kept the latter version of this file and applied the
following merge resolution patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 13 Nov 2023 09:18:22 +1100
Subject: [PATCH] fix up for "bcachefs: Split out btree_key_cache_types.h"

interacting with "Merge tag 'mm-stable-2023-11-01-14-33' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/akpm/mm"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/bcachefs/btree_key_cache_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/btree_key_cache_types.h b/fs/bcachefs/btree_key_ca=
che_types.h
index cfd09f519965..290e4e57df5b 100644
--- a/fs/bcachefs/btree_key_cache_types.h
+++ b/fs/bcachefs/btree_key_cache_types.h
@@ -17,7 +17,7 @@ struct btree_key_cache {
 	struct list_head	freed_nonpcpu;
 	size_t			nr_freed_nonpcpu;
=20
-	struct shrinker		shrink;
+	struct shrinker		*shrink;
 	unsigned		shrink_iter;
 	struct btree_key_cache_freelist __percpu *pcpu_freed;
=20
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/GpQKy1LgZXVJwFlPpBVMGFS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVRUGwACgkQAVBC80lX
0Gz4Awf8Co71eZaB+2nvtWugt1+RL3rK1nzB/wLZJSgOLDz9lrqsrfYJpZVp+mQX
g0wobfaa30IIpkAj5R/a4UUW9SxSZEtrOXTdQRsoPQ4SdbYa8F1ZSgFVKVRiuTRe
1PzaIDLxRNrPFib4qYgbYy2IrQLQiLFXrYJGu/00Ns4ZVZFx8iRZU1GENucEM/Cz
U+cOkC89jXr5DYsDvSnBVnFq+TdqPEGRKHtl1/9yUjNRDj2c2zfMnMn9nxr5oDYG
YpbJJaxwdK3wUKGqTt5wvtTA5gS2gvH+WuOJyaKg0b15mUndWsk2XYvS8tm0hmDD
PfsTJcHS4NtmOSeEcNmZa6RIAHDQzg==
=v7X1
-----END PGP SIGNATURE-----

--Sig_/GpQKy1LgZXVJwFlPpBVMGFS--
