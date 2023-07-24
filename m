Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3214C760329
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 01:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjGXXbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 19:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGXXbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 19:31:21 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9ED10F0;
        Mon, 24 Jul 2023 16:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690241474;
        bh=rUL962e/sq0yjskMcWvQ79vbePqOGQRbrHppxbF7p0A=;
        h=Date:From:To:Cc:Subject:From;
        b=StrA6aO7PYmq8dEi9fVpzKjd1B9x3Lo5cSdRkqIPGQOwkDt8ce9hS3jy8zr6SxI+j
         4SHxeRKDH2xZ/DNXP9mS2GAqbB4uJKWXxQrAhkCw2QO8QFqHlpPAjSE+5GcEXEyWSg
         JcvM9//Ueqss/l/pPfHDLn91msrIur0BqE45DR6mWWAqGmD9VC2H0kQBRnThG7uUI/
         K+eJV4i40MDKJPW4xvUlgCa2ehsweioSZGLtHLfCSEwU11WyYA4erSud41W30Y4V/u
         bIFzP23Fz5I5KvdlpD3U1odHpVm70nQifTt0WfFFR4BGvaWAbTGf7fy4N11bPWqELU
         16gLZ6LZnBTLg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R8xHj0BYvz4wZw;
        Tue, 25 Jul 2023 09:31:12 +1000 (AEST)
Date:   Tue, 25 Jul 2023 09:31:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hector Martin <marcan@marcan.st>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: linux-next: manual merge of the asahi-soc tree with the arm-soc
 tree
Message-ID: <20230725093110.285eb858@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aKZPabUw3Yk/quRw_hIncWV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aKZPabUw3Yk/quRw_hIncWV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the asahi-soc tree got a conflict in:

  drivers/soc/apple/Makefile

between commit:

  869b9dd3339a ("soc: apple: Move power-domain driver to the genpd dir")

from the arm-soc tree and commits:

  6fca0adc61cf ("soc: apple: mailbox: Add ASC/M3 mailbox driver")
  eaf935fa48ec ("soc: apple: mailbox: Rename config symbol to APPLE_MAILBOX=
")

from the asahi-soc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/soc/apple/Makefile
index b241e6a65e5b,20feee6f3943..000000000000
--- a/drivers/soc/apple/Makefile
+++ b/drivers/soc/apple/Makefile
@@@ -1,4 -1,9 +1,7 @@@
  # SPDX-License-Identifier: GPL-2.0-only
 -obj-$(CONFIG_APPLE_PMGR_PWRSTATE)	+=3D apple-pmgr-pwrstate.o
 -
+ obj-$(CONFIG_APPLE_MAILBOX) +=3D apple-mailbox.o
+ apple-mailbox-y =3D mailbox.o
+=20
  obj-$(CONFIG_APPLE_RTKIT) +=3D apple-rtkit.o
  apple-rtkit-y =3D rtkit.o rtkit-crashlog.o
 =20

--Sig_/aKZPabUw3Yk/quRw_hIncWV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS/Cb4ACgkQAVBC80lX
0Gz6DwgAmKYg8IRz4CNEXlo3WdMloXpKt65ayB0GHrGxe9ElRGSuuDEvIc/6CUIH
HwbgrjlX24M/Jlid++BXTGe5En+LKwsilZpgX5sgSWyiWy6mTJKiRe5nPmO2LjR3
gStcDdtC9op5nVpsgbH1ssK2VqaLoTTbNEsof4mUGEF5U8Ys8DQdLUQ6Qx3zMMOE
GFElXHNOoIzAoUCZxVTwqYG70bG0/C+ACpVOej5wpd02BASR+912+c+WCa9HDbue
2J/lec6XVXriaDCatqUw88syz1pGBItixCV6PLF3wBcajya6N5LsaissZvxfno9c
7BrZaBbmrhN8Q6S5pymcbWU4PTihxQ==
=eePt
-----END PGP SIGNATURE-----

--Sig_/aKZPabUw3Yk/quRw_hIncWV--
