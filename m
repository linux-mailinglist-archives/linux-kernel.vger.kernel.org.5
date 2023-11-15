Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A927ED7FC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 00:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343676AbjKOXCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 18:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjKOXCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 18:02:35 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA25DD;
        Wed, 15 Nov 2023 15:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700089347;
        bh=zPmcuJI/QqEirtF3Hay0wkc2/6ukXaLWGmJ6j2CS9zY=;
        h=Date:From:To:Cc:Subject:From;
        b=dXR5+zTUhLLGzvGN8YFuqrdharXvZ8xDpeN6XvLOfoZTtbmZ5B9swoimRILj8jH2J
         do/M3ldaZAfM9wpOcOysxYPh8964gKLbzYyFlimRyvZwnSIPVekFBnkKvTK3k2ce//
         CptHh5e5izNfeLwe1mnM1KQPtCivNTWlvcT/SfHXvi6mx06lHVVSsq99qSpWZAj+65
         rDwdwME2FemkK5cCQ1pwx2g5aVcFvzSYLQImgt6toJqoV1Un//M5i/CQY7inSSuDv3
         j2miVVWtYASMUyfcbLdIcGC/NUfmIgcTh9M0ugic/lVEh1GunX66PBd72i7oJmPXG0
         5rYI4/tEtvJwQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SVzFt5ZFNz4x5p;
        Thu, 16 Nov 2023 10:02:26 +1100 (AEDT)
Date:   Thu, 16 Nov 2023 10:02:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bcachefs tree
Message-ID: <20231116100225.28b82435@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pBK4s3Hvzqcxg4El=w/1slI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pBK4s3Hvzqcxg4El=w/1slI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the btrfs tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: "getname" [fs/bcachefs/bcachefs.ko] undefined!

Caused by commit

  6c43bd2cbe7f ("bch2_ioctl_subvolume_destroy(): fix locking")

I have used the bcachefs tree from next-20232215 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/pBK4s3Hvzqcxg4El=w/1slI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVVTgEACgkQAVBC80lX
0GxlXAf+MEdq5BrjDHAyMawtFwxZLsZlL1fbC/B+WNOhVziiJ6QgcM30Ap+VXa8X
vPfhjcCUvNqQb+l4yjDUIWXlBegNZxME2WwipGRhdG34KFltpEkS/uCeakCLWEjk
RfviciJo2L9igob+AFtCZ88DsNFAKASZk523eij8c6ZyfFsKxG9jsWjrPs8pbWam
ho/be9L776/map2mP0xE/6aXg+gkHpDQrga/gskJaE0l2vXSdryZCdSHJKrskM0K
zYrjaCDRGolQnC0dYI8+kES0cgu7r538uCn9WzHv9rjXE1hfwxZCTmFXHsyrsY/1
FMvSFUT97o2PQULlwaluVbqSbdlVSg==
=3H/G
-----END PGP SIGNATURE-----

--Sig_/pBK4s3Hvzqcxg4El=w/1slI--
