Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF16783513
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjHUV7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjHUV7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:59:22 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0AA13D;
        Mon, 21 Aug 2023 14:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692655153;
        bh=gZ6LBhKsreODtwHlWscg5RW9+vYn4aDYWet+eOpcrcc=;
        h=Date:From:To:Cc:Subject:From;
        b=axRLjdS354QunRZHd2/A0OAQUywjMhIUhDY2oXN04IMclqQ94R72l8h30X+f5Xbig
         7xhYUdFpcRhgDOwyFQNu/QQRQCLNytbUrZvbOhE0nNOs2UkfMxgtHM0NrYSLbwwrwm
         CPKZBEf2m/AeGITdnMvbYZn0U1vy7ipsExjcVbBdQ/IdKMIBzZvhWMphRr+x3DroB5
         N62rxVGgvsjl5N4Xvjq9m9mnK5PnXOI3WQBC/ccNK/Kb7jzelNkA4x3OpT/IUtrmNg
         HEUpqS7Lndiq8ooz1wCLUJs816ZeVhpQoN+HOl1AjoxThbtRv4RSxO4Iq93rs7iI2I
         80SDoVzNuEpMA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RV5wd4DT5z4wxN;
        Tue, 22 Aug 2023 07:59:13 +1000 (AEST)
Date:   Tue, 22 Aug 2023 07:59:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Asmaa Mnebhi <asmaa@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the gpio-brgl tree
Message-ID: <20230822075900.22cafc5f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GNRm6cSuCRSfE8R165ibu8X";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GNRm6cSuCRSfE8R165ibu8X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  38a700efc510 ("gpio: mlxbf3: Support add_pin_ranges()")

Fixes tag

  Fixes: cd33f216d24 ("gpio: mlxbf3: Add gpio driver support")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/GNRm6cSuCRSfE8R165ibu8X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTj3iUACgkQAVBC80lX
0GxmUgf8DUsVaGvdGwtSieAOwYNt5KOG6Nv2xJkKXSyFxUGFlzwbb+bDx/neREmY
r0dD44yXTtzzTKifQ1YW64aYN/2QX8XiZLmsb3u4zG5FmJj1TwkbJlhzo7C7VPDA
UwZ7OuXLd8LoEI05S6VwfZVu4GymXpJkl4Y1lReloxrWMUZKzGksD3y01q/TChI9
WGqqugO/rCcnhOM8XCAie50Zn1aNwK00IpFiEnT62cQa/iHVMFEraoP38UzcY2Cu
YP4xDs6W9ES6wc9a626apmPeHP3wstT7vhMvI8NgjszuILcGwcs7dCHPWjVOkBIR
4RrGlXVDs6XQksxIlvl+ih5KUkg1zg==
=PaGK
-----END PGP SIGNATURE-----

--Sig_/GNRm6cSuCRSfE8R165ibu8X--
