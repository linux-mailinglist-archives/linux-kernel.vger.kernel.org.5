Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BCF80F8CB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377426AbjLLU7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjLLU7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:59:20 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B7A95;
        Tue, 12 Dec 2023 12:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702414762;
        bh=Q+mUWsYRG0wHEwnZzLb20+KepKx6aqzjBSnA5aqwrwg=;
        h=Date:From:To:Cc:Subject:From;
        b=JKJv1weXACAHh85RlIJaAh1AZL3FkeZu65pY2JemdpGAoYF/qChTxXyybxowbCheM
         jko4oltcpRWxnrjRt25tSs886VB+KMr/2u94F39CLW/M1Ijw8kxHAhtzJebpW/I0py
         9VMDxk+CzvU3iIH2aI+WaI6EzJ9ivuQU50l+F8Piv4W8YXf9Ae85qWbP9bfn06fEWY
         UfFW4in7qFWgCtGeNvyI7LqapQngNcDzTrYQjYMH29vk6OTJr0AJtHOB7PIsx958nI
         I5TSotiYZx3c+L+3uhQWvbVKLvYi5mCVlXjffSWVqwvY0MzYppf5lmbdbj6cltxNBM
         0aUb1qLcksc2w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SqWFP4zl3z4wb1;
        Wed, 13 Dec 2023 07:59:21 +1100 (AEDT)
Date:   Wed, 13 Dec 2023 07:59:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm tree
Message-ID: <20231213075919.311c962b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/r.gIuKxXWZHC9KkGXPtrK9O";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/r.gIuKxXWZHC9KkGXPtrK9O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  fa28adea6a65 ("mm: thp: Fix build warning when CONFIG_SYSFS is disabled")

Fixes tag

  Fixes: fe2c9313a8c0 ("mm: thp: Introduce multi-size THP sysfs interface")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 17e9a3099850 ("mm: thp: introduce multi-size THP sysfs interface")

--=20
Cheers,
Stephen Rothwell

--Sig_/r.gIuKxXWZHC9KkGXPtrK9O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV4yacACgkQAVBC80lX
0GyIFgf8CUSvKjzWNpUOw/0Sb41a9mwa4cGelDp6DuBVh4Qgd2mOVNYpewY+6aAe
l62drguaTwJbdbcmFtIkNvTU0j/4toPzhl3hnH/wY0bvkN+FXsoHORmXmJp6WXzs
391yFQQmynIF6YvuWSVVp75Sv9lCRJSeswhNJrmvC3uhMFEDr86P0/0gjeecdfEU
Kxi0Gjz+0gSMjv7B1YcjF0Bx8AmiL37Ta27o3XIJdJ+otPP75aXKivmM0elE5SxW
Z7xpHXqcszyVQ/LpA1vdpBCMrl6FMuMXeBQkdklhXN611rEmdtEAuoaRFHuP0FyZ
g04ny3fUunOJ34CyZSJx4sFw7Wd/fg==
=kgUI
-----END PGP SIGNATURE-----

--Sig_/r.gIuKxXWZHC9KkGXPtrK9O--
