Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350EC7DB18F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjJ2Xs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjJ2XsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:48:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C383C97;
        Sun, 29 Oct 2023 16:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698622459;
        bh=F+MjMJJVDt6Ghv2oXEwvUwzUlZZUFR7NH8zo3MpE/Cw=;
        h=Date:From:To:Cc:Subject:From;
        b=urD+QinuM2lMqFQFz5d8hcxkGMgRKDl1acWQgfMsqJlEJkTw5fXOFI6xz1poHOQKt
         /OAN3SemDR7ncqCNWCH1YChrsu7SrWcs/n8xnyJKbvFgPqGBqb0yUYqglRZG7v0siT
         M1JVvMMJNP28yoNvfQ+bHafeNZKtYTrvfepLAoeHrB/wisJWSrkBSvj9Uk1EvCts6Z
         DhsUAry4Aoyaj2M8v9b0ezSNvbrl6G1b3hUsqs86tYN0gilp/dFu4dhg4WVqV0KmD+
         HJNgXPeMrc340NpRZq5txS4fbAf11IbF7KCFAr/12BiKWFBeYgROjo+//rbNQYTlHQ
         JGHrx+5Kvcc0g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SJXmT48dPz4wc1;
        Mon, 30 Oct 2023 10:34:17 +1100 (AEDT)
Date:   Mon, 30 Oct 2023 10:34:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Richard Weinberger <richard.weinberger@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Subject: linux-next: manual merge of the mtd tree with the vfs-brauner tree
Message-ID: <20231030103415.401ce804@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B/Rg_CReG_X5M_uLRXDFwHV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B/Rg_CReG_X5M_uLRXDFwHV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mtd tree got a conflict in:

  drivers/mtd/devices/block2mtd.c

between commit:

  1bcded92d938 ("mtd: block2mtd: Convert to bdev_open_by_dev/path()")

from the vfs-brauner tree and commit:

  ff6abbe85634 ("mtd: block2mtd: Add a valid holder to blkdev_put()")

from the mtd tree.

I fixed it up (I just used the former) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/B/Rg_CReG_X5M_uLRXDFwHV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU+6/cACgkQAVBC80lX
0GzPigf9FYse3zoIbgrtnceRLefZqLVZHHG9fNue3KDIkrzXCtlmC9TOGvBNsArb
zw0tQmOGK4hdpSo7wbMH++tv5l2LypquzVxnrFE61fNLREhnm0VoMw5Z8WHQ7Kna
JbkR/ffrPDz7iPt76nebIRkxMpih6QC3qD4Oj2Zd7Z0lNqOiOUjMd1Kmtpf+b09F
5Rb+AxtDxUetMplLP1nqUPWszJqBTteJIUHx1Z7ke7FsXM1sCFw7Iq/GBnGljyN8
cKqcAtEYmz/1vPmKBWAq7ltL1Vua0jHXSPfQZx67j19ftQzAlrmtZX4dmeL9vo7H
9ZDEULocsWiupIWOY6IcDczs1wWDPQ==
=sXr2
-----END PGP SIGNATURE-----

--Sig_/B/Rg_CReG_X5M_uLRXDFwHV--
