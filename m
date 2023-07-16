Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4177A75576C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 23:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjGPVhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 17:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjGPVhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:37:11 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8AE183;
        Sun, 16 Jul 2023 14:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689543423;
        bh=Oe/lGVhL5jiQrrH6YQDQoe+kmJJNafVcIbFFM2tttoM=;
        h=Date:From:To:Cc:Subject:From;
        b=UuK+YUMl3xXB5psMCKcYjVwvftC1ZmAaGoEyQGEUUMYWRcgym1mwufHAgqXmEXW8H
         lG/1WVLmK+6hA/F3Bxy6KIs0EoKj5U4kbPbyS9KArfhGwfQQc6GfK9jnB12x240sGP
         SSS9kVhzLEJzjUjgv8a1zCBEBZiHtrlwiNBRf/q7Rn/SEHC5PrO6mSzY23Ps4H5GZA
         t9/9F0/nEI9Ks2u2NjMPB8VtPKVL6JAHgXsiiWVIj1SvXYe6gBKtAOgtu5/Ti8aGhr
         rnq0zIiLgArzg8o+r7XogNZgLL7Fj0vYGkHk0CTfdcSna2IhJ1wQUpmnggBurAvy/u
         T7TWL5ZABpYOg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R3z7f6DYZz4wZp;
        Mon, 17 Jul 2023 07:37:02 +1000 (AEST)
Date:   Mon, 17 Jul 2023 07:36:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tags need some work in the rdma-fixes tree
Message-ID: <20230717073649.5fc71a09@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/U5CsUi/Y7T0xSiWHzE=C2s9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/U5CsUi/Y7T0xSiWHzE=C2s9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  e77ac83ee5fd ("RDMA/irdma: Fix data race on CQP request done")

Fixes tag

  Fixes: 915cc7ac0f8 ("RDMA/irdma: Add miscellaneous utility definitions")

has these problem(s):

  - SHA1 should be at least 12 digits long

In commit

  df56ce725d7c ("RDMA/irdma: Fix data race on CQP completion stats")

Fixes tag

  Fixes: 915cc7ac0f8 ("RDMA/irdma: Add miscellaneous utility definitions")

has these problem(s):

  - SHA1 should be at least 12 digits long

In commit

  13120f2d08fd ("RDMA/irdma: Add missing read barriers")

Fixes tag

  Fixes: 3f49d684256 ("RDMA/irdma: Implement HW Admin Queue OPs")

has these problem(s):

  - SHA1 should be at least 12 digits long

This can be fixed for the future by setting core.abbrev to 12 (or
more) or (for git v2.11 or later) just making sure it is not set
(or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/U5CsUi/Y7T0xSiWHzE=C2s9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS0YvEACgkQAVBC80lX
0Gyx/Af/dK5rhLfmrrTgzGa8lzs6fmBmcaUqzxyPmr9nfOKdm+lSYMhJIG6aJrW9
VBZA3BKQrA8xK3b0mjcFaT73E3xynwlRhulso4o0wDTL0A5MwyhONI0I4m6OHtPC
rsNLbfN3ARhT0RbRHF1fZzR02pDpUhcPWmz+8/VOb/Mnhm5Nl51HLnC+F5zsoRT+
65/CEsBzYgtpa3Ze/Gno86jKbFGPzr+yhETIJcNunypTE6jfVD25Usx1QvtHCKef
clZOW8t0NXeYcfDZfgs6jL6k/OKA4NBShYwLod3UUTBO6ugBNOevpcbTE5E1R2zL
NKUh0V3kOe/PDKeMqSWaM6zQ3tn+mg==
=vclb
-----END PGP SIGNATURE-----

--Sig_/U5CsUi/Y7T0xSiWHzE=C2s9--
