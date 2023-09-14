Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3D37A1184
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 01:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjINXOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 19:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjINXOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:14:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAB81BFA;
        Thu, 14 Sep 2023 16:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694733265;
        bh=0fkXFmYxKas8ulmbWMhm71hM+63PNckbly48tQ+fHdM=;
        h=Date:From:To:Cc:Subject:From;
        b=WaO+mxHPf2/6CvqCXGn+gdHE/HnCrPXj7zfprkDKcULNUgHDUXJd78D0gONKa7bu5
         dEutBJlt51ih4bHLdMmncETIawDy6ZkAfdiJKRrbH4ub7wyz86mqFXbS+z7n83MqNp
         AYQqcFMAOC1upb5VSMI9wUtX9vDSTYBMNPOv51AHIZvLDpC3MzJKit2udB4SUaUOSD
         aSJ3y7U04lCUyE1bNUEFGfVEnLlsBXLOoBt4yvTsnyc9QcYphIVMj3SUhE1ycZJfzK
         9XDnYhM9K8Ki21LyDcUtHu2xsP+NFp6BQ8MSKJ0Vq68wIGV+6HwsDiWvjwJQJZl+fo
         pxtghy/tfqIsA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RmtSJ16fCz4x2b;
        Fri, 15 Sep 2023 09:14:23 +1000 (AEST)
Date:   Fri, 15 Sep 2023 09:14:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: linux-next: manual merge of the btrfs tree with the mm tree
Message-ID: <20230915091421.58207f2c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/83k3IEdMgwIc5sj0Ruae6qf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/83k3IEdMgwIc5sj0Ruae6qf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the btrfs tree got a conflict in:

  fs/btrfs/super.c

between commit:

  c0824542e4d1 ("fs: super: dynamically allocate the s_shrink")

from the mm tree and commit:

  2ebed4689ba2 ("btrfs: open block devices after superblock creation")

from the btrfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/83k3IEdMgwIc5sj0Ruae6qf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUDk80ACgkQAVBC80lX
0Gy9+Qf6AnhpYAVgoa9Xy3LB3GWZF8xDTg/XQj/KcleHTMraHHNYLadSbK21iNsr
AGPM1IZWdNo0lSTYuird4+FufGCBEIct7ZRDr/SgEFNdqL1Q1IxiKRVsohQYwOuF
dHZbVxQOxDxi6U/FNzcH7TEGAS4KeDmbAqgcOar9lPC/UwLHB98jfE5UTuBam0XT
bDdovioXCMfWiZW9QPdJtfxe5n/BC/8FfUVKWrRaGOk4VXDiJN6NIggvX4bmo7q+
Lo0XvhUqUOIhy7rONhIDsEsAVfiC0/p/DS/FH+hQJ/nqSSmxron8UW2trWVd+hHh
yB04V5cbwI6Q9B2yrh7R6RA59WCVSA==
=DEi9
-----END PGP SIGNATURE-----

--Sig_/83k3IEdMgwIc5sj0Ruae6qf--
