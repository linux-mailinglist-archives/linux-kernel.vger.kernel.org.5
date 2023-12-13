Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403EF81214F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjLMWSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjLMWS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:18:28 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2209C;
        Wed, 13 Dec 2023 14:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702505913;
        bh=N2KcphMx/eEE0e2GMNsci+rOYe8jMaZYKg7g7lpghNk=;
        h=Date:From:To:Cc:Subject:From;
        b=NlN8ZMbQUulPjbBkMtVFIsQ+MCvUKG5uDapO27h8uQLv3Mi0b2ZfRzMUV96ijSefq
         gZM0F85idPpDZe4zj6NSS0IwQFh5A3vKFkE/OOKhhrzPSMqbpFaGaqqHtV1Ti28xls
         0Pvviyzge6Q35pKNfL0Qms96kmGMOPPBfKAE/u/NM+OirrlgT4goVtL/Xoawy2/+UF
         ENwq4HYEbQ64iriJWXeJi08m8Kmh+whn5L00msmqfqyJSKeTN/6CaEX+u7+dIjDQPs
         u6MMVxWS+BTLTrBo2hkKAGfM4fWO0SsV88ETfpeGRsbPXkDj4E5VB2/azU/QxPfyHu
         ydgjBm8Jgeppw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sr8yK1fCMz4xS5;
        Thu, 14 Dec 2023 09:18:32 +1100 (AEDT)
Date:   Thu, 14 Dec 2023 09:18:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: linux-next: build failure after merge of the mm-hotfixes tree
Message-ID: <20231214091831.70cc51e0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Jsu8AnM33T+NQPNVNyAWpsW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Jsu8AnM33T+NQPNVNyAWpsW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm-hotfixes tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

lib/maple_tree.c: In function 'mas_preallocate':
lib/maple_tree.c:5506:30: error: 'struct ma_state' has no member named 'end'
 5506 |         if ((node_size =3D=3D mas->end) && ((!mt_in_rcu(mas->tree))
      |                              ^~

Caused by commit

  84bda0b24555 ("maple_tree: do not preallocate nodes for slot stores")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Jsu8AnM33T+NQPNVNyAWpsW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV6LbcACgkQAVBC80lX
0Gw7JAgAjwy0mqo8r9Wsdr6sxma93mdYTcdl2Cf82gXXl+u/+w9bRfB8NMXaW8pg
BsFde4KnnP5hG/bBirf7KeXLwJAaRM7KvaG37IhynsCFcvUS9iLEsweiIez+z5UN
RGol5OqzV9GrdPOOHgviy++i6eNSvEHnhQ5ZrszU4RNCXy9js/H8pVehO6kWDx0a
FanE2e/EBpuWcwNbFzdyYmQFvXhrNXoXXhe3AEF18cZs23K7pZlP/MmbY5whdm/R
jXfrofT8GGov/mU86UzZENAp3+rdueM6h9p2GZbECwF+XcmkIvTsCtZDQXJU1CDz
fM+fe7t7VlNUWJ+icYeST0fn5dQQPg==
=Y/F+
-----END PGP SIGNATURE-----

--Sig_/Jsu8AnM33T+NQPNVNyAWpsW--
