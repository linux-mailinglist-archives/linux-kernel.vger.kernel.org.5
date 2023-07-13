Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAE975161E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 04:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjGMCQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 22:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbjGMCQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 22:16:41 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD19C1FF7;
        Wed, 12 Jul 2023 19:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689214590;
        bh=yHB1vaLiMxRJfPbBZEzUppXtlwqbrdIAeG278o7i/5w=;
        h=Date:From:To:Cc:Subject:From;
        b=sD78tL2VOlU0uyQpGv0ARKfQTrijdAbpUlDD272Nq3QJX3gXUQEBLB8IEJk7FU9Hi
         Uf/L0gG68RmsHCgwTRMFaF4mVlzAPP4O/PNOW8gw3kCJMK3lR//jT2wghjt23MiEo0
         U+96VFJC8T6bf5l85iM/TsaUDPzt+aw57ZpsDoA2tFWzgpKmTzleKCaRBZysPFEgAP
         Elzv56n6zCALCU6kvaaOMjUf76pZYZVZO5v3R6uCNIzga+ZIhF40z83ff/YajaTjZL
         eJbC0yq4hLkGcb89bRldA318foM+qRV5InaHVhyPt/NAB30BLPX2BUXsc8aGlxb5rf
         bGsdDbw916HbQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R1dWx5Ztlz4wxN;
        Thu, 13 Jul 2023 12:16:29 +1000 (AEST)
Date:   Thu, 13 Jul 2023 12:16:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <20230713121627.17990c86@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sn=2/FPHQbQyFKKKs6f.WNR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sn=2/FPHQbQyFKKKs6f.WNR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (htmldocs)
produced this warning:

include/linux/int_log.h:1: warning: no structured comments found

Introduced by commit

  f97fa3dcb2db ("lib/math: Move dvb_math.c into lib/math/int_log.c")

--=20
Cheers,
Stephen Rothwell

--Sig_/sn=2/FPHQbQyFKKKs6f.WNR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSvXnsACgkQAVBC80lX
0GxZMwf/TycSZwtm5tDA/l7xtD9U89U7aqrlJfxwWTBR33c0vtjHp7NbR4b9RGkt
Q7wAxX7fv+pyZt8kw1ZYlUYj7P6rRTGn5WEQxrOanTl+3KrtBNrodpmPgQV6ICyQ
DOy5ozA/QJy4AipUGil4WMKi8S1AhDvEEL3aJ+b2D2vn+EP8c3g6ZFk3c9dBZTgK
Z+8WQMzBUWq1NnG0EHRI+2YXtIY4O2KiHAxkjRq5N9VfJASuy6d3motkCfKHVIHP
7lvmk7WawvEnChTHU/sP50uXK1a/nAeX81nYF56EVf/0Bh0Xop1LfP+i4RS1gR7S
iElB4we/xMzgh6pNJZw7xDJ8zoGoRg==
=GW3S
-----END PGP SIGNATURE-----

--Sig_/sn=2/FPHQbQyFKKKs6f.WNR--
