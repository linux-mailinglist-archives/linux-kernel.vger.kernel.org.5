Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DB077C44B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjHOAE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbjHOAEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:04:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EB6172B;
        Mon, 14 Aug 2023 17:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692057882;
        bh=RqKH9GvNOBO88FcPOixfV/reYKdOYPGTboDEsqLP7NA=;
        h=Date:From:To:Cc:Subject:From;
        b=PMN8q18wwjiEAShgQ2fwTZ3w8QpEI9iJe1okrGCK09JBw3trnA8YRefJN+NDSHcjP
         KsvviVPCH/IvraC3Rw+S/3NWMWQ97UuxiNzMQSQI90PCCANd8OoLg9G7VoEPuUE8lO
         L+YSMnMrP+mcgHa7GV2d0kQDymNiEQP9IPNt6ku58fEfeSwtmlPpXrZbIlfFBcvfhd
         4sZT4BrSqMHVKanVZaMkyg58ICIZFuRBZKiz/lyrzJKzhgk1IHu0pFuKljdo5KXgPL
         jdcmFrJEM8eyJKARbXlioa2Uimc1RI8HRMOaE0UdiKySLhN4CXn5GNWYxQmH2XNhZE
         +rdRZc/ztu8eA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPs2d4Mcwz4wZt;
        Tue, 15 Aug 2023 10:04:41 +1000 (AEST)
Date:   Tue, 15 Aug 2023 10:04:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Helge Deller <deller@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mm-stable tree with Linus' tree
Message-ID: <20230815100440.7e535779@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/P67_g6EGmJYulcQz.UlqSjI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P67_g6EGmJYulcQz.UlqSjI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-stable tree got a conflict in:

  arch/parisc/mm/ioremap.c

between commit:

  b873bde58578 ("parisc: ioremap: Fix sparse warnings")

from Linus' tree and commit:

  5c28c54a8229 ("parisc: mm: convert to GENERIC_IOREMAP")

from the mm-stable tree.

I fixed it up (I just used the latter as it has removed the lines
modified by the former) and can carry the fix as necessary. This is now
fixed as far as linux-next is concerned, but any non trivial conflicts
should be mentioned to your upstream maintainer when your tree is
submitted for merging.  You may also want to consider cooperating with
the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/P67_g6EGmJYulcQz.UlqSjI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTawRgACgkQAVBC80lX
0GwcJAf8CdgXqSSqXpleqRM2K7kuka0lSJm0GCC9zv2b2RVJ59hE5b7AXRO3Nn3K
FPTNQaxJNNkGZUg3WlENPvBfjWRcuISFk9GB689ZGS1RtbnIXQ+UTofCBKKMflW3
/vdR/UwgLpWTQezGcI+jDumGw/NkGN2hg89PJa9HaY/IU6WXAvn1SA5LljU7AMDa
BeDFRWAw5rQhKl2mphATOufkhnnshimGtGEzZVAcZbOlFYKzeU0VJ+jrK9uVqTvA
QD+Ejr+mpRlF08CXqIVvfKQe5VJRqC9HclxmCtdjPLySmYfAZ5Sw1uNf6MvAJP66
QOPbKvxecRGedq7j/5dyndxcqgp4Og==
=P15i
-----END PGP SIGNATURE-----

--Sig_/P67_g6EGmJYulcQz.UlqSjI--
