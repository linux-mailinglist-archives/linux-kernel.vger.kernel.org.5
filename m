Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7BF7BF26D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 07:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442149AbjJJFrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 01:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378059AbjJJFrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 01:47:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C05C9E;
        Mon,  9 Oct 2023 22:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696916860;
        bh=llAuE+x3KttPI6ZIwES9aPdI1aUvwVKmpPB/UIK6qzI=;
        h=Date:From:To:Cc:Subject:From;
        b=LXDMiwYznOWGh7uLNAsQvd3u16AH9TKRmJq/I7+f78GzComAdgQaEEEHWuERcedQd
         APTBCQTb4IgeaJIuU0D25TWARA/EMiUbB4IviGhqyGshstOc4UkceWJCGlRkFqgPBD
         i1+nY5AqDqaLyhXNi+V8c2ZiY8IzEoXPF3oDOBNsbXHYw5IgEJMrMTIiX4fLrJLBSK
         4jn/4iUWvH/Z2uXaQ7hhdKwSfCFG6Hgll1cWaZzAdOvJO+lacHD0FCc/fgeugL0wfy
         wkmPD5ltNXbpXuVi2Qh7JisO4aCB8pZPpxjWHO6pHHLFzrtciXS47swwwWOKK9xstB
         yCHRJzy1OMlXg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S4Q0X277nz4wy6;
        Tue, 10 Oct 2023 16:47:40 +1100 (AEDT)
Date:   Tue, 10 Oct 2023 16:47:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Zi Yan <ziy@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm tree
Message-ID: <20231010164739.236d916d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PmRNJ2+96Cnq2essMtlqlJ7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PmRNJ2+96Cnq2essMtlqlJ7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  2a936ebfab06 ("mm/migrate: correct nr_failed in migrate_pages_sync()")

Fixes tag

  Fixes: 2ef7dbb26990 ("migrate_pages: try migrate in batch asynchronously =
fi=3D

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes
  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/PmRNJ2+96Cnq2essMtlqlJ7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUk5XsACgkQAVBC80lX
0GyXQwgAg9RlNol8pyZ1ViWknw705C0KW+oInUUxZCCnqudQ5SP8dEzViTeyj3PL
7kGL0uE19gPKrLR0yJnPmHttrmzn8OXUJcsgXKJhjw76KIrVFCpHCguWQgzmAsfX
Xjnavg4eKCssFqNf9/DyBLgcvpI3X8sP0SkrI75kXxPVuFbXwW82Nubnf/mLb8VG
eqp8hyDva0ZFTknVSovDwxm7S0QLiZ2xLmawBe/jtTFKyyhAzN621whXkt1aeiR3
Wd3PRGqX2P6UwvbyuzA5Y4Q+o2SwHfXyqyZcu39EN06i9mcV32jeplGH7Ww0x8vo
iQ8Pz7IoHZjpy2Jtp1c1DpGLE5b7TA==
=ghTN
-----END PGP SIGNATURE-----

--Sig_/PmRNJ2+96Cnq2essMtlqlJ7--
