Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626F779F5B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 01:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjIMXyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 19:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjIMXyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 19:54:16 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0105E4B;
        Wed, 13 Sep 2023 16:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694649247;
        bh=HeU4wwPrVEU9zsogKgnhmorT3Fd04M54kOE3V3kzWqI=;
        h=Date:From:To:Cc:Subject:From;
        b=UcLEkhEjunpacZgVNBolWdEAjsiTdA6a5D+8blcZmRXKNMQaQQigQIn0qszyx6qt4
         6vf24MRcsrpH58bLo90qINZg3SQMZilxBof3JrRpnuyEebJlsaTSo+cETV4SajEMvL
         dszBmhfhpm1x6kyebeitqyjNjIx/CtAGhT1cJ1lreasERtbMGTQGzAHtIsq6gucZR/
         29Fn8OyqaAwnb5ZM7VOtjO9RNgSaPoG4Jj5h0m2uO25zfEQ2wo3QNkwLaQUmYRevy5
         DCvrZ5c6Zo6XSyKvq6qCipiRUld/GAVXDD/jVvgQe4XSnHvT8Pb+qZ1U2oZxEEtoyc
         F63ehM86zfuDg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RmHNb2R9Xz4wxj;
        Thu, 14 Sep 2023 09:54:06 +1000 (AEST)
Date:   Thu, 14 Sep 2023 09:54:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the btrfs tree
Message-ID: <20230914095405.45b58b11@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/s5GJCna9tRdWGYhNCpjDbm9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/s5GJCna9tRdWGYhNCpjDbm9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the btrfs-fixes tree as different
commits (but the same patches):

  0a1996a411b5 ("btrfs: set last dir index to the current last index when o=
pening dir")
  568ff9d3df2f ("btrfs: fix race when refilling delayed refs block reserve")
  75a1897cb7f1 ("btrfs: don't clear uptodate on write errors")
  d257cd9f609e ("btrfs: convert btrfs_read_merkle_tree_page() to use a foli=
o")
  d354d8aa8b40 ("btrfs: file_remove_privs needs an exclusive lock in direct=
 io write")
  e6b292f9d6bb ("btrfs: refresh dir last index during a rewinddir(3) call")
  f93cae0fa843 ("btrfs: prevent transaction block reserve underflow when st=
arting transaction")

--=20
Cheers,
Stephen Rothwell

--Sig_/s5GJCna9tRdWGYhNCpjDbm9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUCS50ACgkQAVBC80lX
0GzhbwgAjzZ+Kl0IsU+DMpIOt9T/3dn3/FJZcflJ5Z23XWznZ8l0wkyHITDCrxiS
3WU8gdexggW1G1tLxCxfRkCWT9X8tG7aroRjZnMJpNdHytPZyyElghY/97aGBIs6
b95dKUfE68UTRNpWlzaYiCdNU8l0ibh1H9Jv57d8ahNrZKbhfcja/2YHyVvHVGl8
5WPmpB26FBT85Eu67RYCfMa3k3kN/FPelNirnVMTNGEhCGUCCGMbqyw8bppwniyF
+XwLVC6FSpdUKN5HI3WT35GI/+ao9H/VELTkoOnb3lQs29oeVHvl6xqFBk6l2uG0
kS1Vft6ivRcma2JJwRdfWUDnMImD3g==
=Acln
-----END PGP SIGNATURE-----

--Sig_/s5GJCna9tRdWGYhNCpjDbm9--
