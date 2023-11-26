Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A027F95BE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 23:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjKZWUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 17:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZWUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 17:20:02 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E03ED;
        Sun, 26 Nov 2023 14:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701037203;
        bh=pwtJNSoXkveHX1SXeN6U10haPoHwI65c0JyDqWVKi2E=;
        h=Date:From:To:Cc:Subject:From;
        b=mzFOSvI5mpc3V8MPJDqU+3W3UuExZda5/z7LYbquPdMbMrujjKmUY/L+ZZzFY90cN
         nTqU7l5Wuufp+84YyYJJ+/Vrk+nX9HF55vF2sxy19jqOLLCV6a6on4zF9O7r0f1dKt
         +k73eV6QmkhnaarXSE4lELXV8HFxoyBL/AE2wk+X+PfC18KxSTEaQVd2b1xnjHd2k8
         K92sBB+69U/BJyZDOqisPy+qqxjnxYBI2DP9OOdpDSo8339h1P5XCkTp4Ea331cA3d
         kp5z/ZYfwKqSBJfFbBj4D83TR3arYqd+NVJlTnTMYzbUsnv5zsz+ay4io6g0sko6Ig
         Hkc6ewidaQy1Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sdjnt3Z0vz4wcK;
        Mon, 27 Nov 2023 09:20:02 +1100 (AEDT)
Date:   Mon, 27 Nov 2023 09:20:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, Jan Kara <jack@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the btrfs
 tree
Message-ID: <20231127092001.54a021e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I3Xqh2DgEW3w5Xn2q6qm7Hj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I3Xqh2DgEW3w5Xn2q6qm7Hj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/btrfs/super.c

between commit:

  2f2cfead5107 ("btrfs: remove old mount API code")

from the btrfs tree and commit:

  ead622674df5 ("btrfs: Do not restrict writes to btrfs devices")

from the vfs-brauner tree.

I fixed it up (the former removed the funtion updated by the latter, but
a further fix may be required to implement the intent of the latter?) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/I3Xqh2DgEW3w5Xn2q6qm7Hj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVjxJEACgkQAVBC80lX
0GwjAQf8DoiwWi9+TfHakb0vP8exndf9aBFUoUC3oLyzPrFFAlo6fimG85Ivzi9x
oNeV3F59RY5gvEgldQnwLzSeljJ08yw+4S6+qx6PoroM5jyi5VwYQ8aY6gmD5fEN
QlDOMim+4VW2+kyDoPQzfDXfRMF6JFdO5XVV7QZ9U6NMbduOq5jpu1UCZZWksxcw
7dKXMD6tPL/eV5lHPZ3C74U0jjJJWcqr7YfZhh1/Pwv4gjhze4XlUTpCJ4u7/1zg
SKHLiFW6jERI8FWPiU1LdkyfyKg2P08yJ7J5pVjWAkGjVtAfR5uR54iWvZNc7yZi
lyYCz0iW1Mxxamtioy1kan0GQeiQxw==
=CivK
-----END PGP SIGNATURE-----

--Sig_/I3Xqh2DgEW3w5Xn2q6qm7Hj--
