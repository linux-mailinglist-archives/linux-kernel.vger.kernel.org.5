Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF6E7B27A1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjI1VmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjI1VmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:42:16 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293E819D;
        Thu, 28 Sep 2023 14:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695937328;
        bh=7d/AAHZO5NDYV5Xp/mzgKQmg52pq5fBtsuv+HaGjUU0=;
        h=Date:From:To:Cc:Subject:From;
        b=gaFFl3Mx/AKahHhi8lqUpkg37QKpQVKNmnqGxkj7gFIM9IwEmF9k5TdVL7YcDeQyz
         GMoCapZFZU4yFDrmuYwOCBKzGPdMbEmuC8smG7ciI/zi6n9tiuEiMR27BNJzPcN/ai
         Yhf6NTJHfVezjWO+5UK89FK8pwy8Q9tci929Be/bfkyItotGxPoMQoJdYeCJ6ylJaS
         9g7pwwfsoZO+0H4zXDB/d2mhJYShkMZTH9NqRF5aw5Uw/8ZPtYYNXlnPT0DEZ0WbOd
         uTEP+a2/ouA+ub2YY/TnsrSRSN6WHnwHMBo1TUP/fS6Lqv78/1h7znEl8uv2rTo+sf
         EzIBn9QnGQqGw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RxRlN036Dz4xPL;
        Fri, 29 Sep 2023 07:42:07 +1000 (AEST)
Date:   Fri, 29 Sep 2023 07:41:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the sound-asoc tree
Message-ID: <20230929074146.329da983@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PZVY+wS=hrUQI1xxUngES5=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PZVY+wS=hrUQI1xxUngES5=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  6d925797304e ("sh: boards: Fix Sound Simple-Card struct name")

Fixes tag

  Fixes: ad484cc98f2 ("ASoC: remove asoc_xxx() compatible macro")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/PZVY+wS=hrUQI1xxUngES5=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUV8xoACgkQAVBC80lX
0GyTdwf/SR92jV4DI/kfhLbP8MXPvHovlVj/sCthsxdsgNHr5qstW82wl7ug0HPT
/SJQZfXnuozi8hF0TUb3EiwgPYqbUsVqbHwYF6+breKyfflhUjqXzMw4DMMp8luM
CDlRUZqEqX2UD/+Owpen/KMyr9YoeALeILli/ReE6aI5ONHyG1opxbYN1ZkP6LLj
RShnt7sZfGULBN3npPbRup9k30GSmHP2hseQ++ryx3IyoDRXPRIEogqg0NnGokkT
yfgwBegr7knOhdOFztOaPBIKe/xFz/z9SDPRWxN3BhI64k73uuKx6TxAJXavxCo4
bVokjVudG9Ih2Z3Wgj8FIznaiRxssA==
=JpSV
-----END PGP SIGNATURE-----

--Sig_/PZVY+wS=hrUQI1xxUngES5=--
