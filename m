Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D50809A4F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 04:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjLHD1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 22:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbjLHD1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 22:27:51 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5499310E3;
        Thu,  7 Dec 2023 19:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702006076;
        bh=3uUxl8AjSfB8bvexoex29z4Sn6xbCPQjVqOSbPXD9OI=;
        h=Date:From:To:Cc:Subject:From;
        b=P0zvy+yyzvPgu5HJ5lPWY2Vq9Trg1MjG5jC+Y7GtWkCL9Tuu5qC45vzFX4gU24S2t
         pg5773vWwEuqQbSmMLVGbJcacCw+LL3bDs/cITQ2bQYdYX7tdkzzLXIXbc90fXhd9y
         FsnOkL1axQbh06dcLD0K6K33QOh2c5U9BOOvBGxqbeKeuzSGG6mwPyVj8mttDybi0e
         o00EinfMVSn7P08r3ziVSqc5w2E2Ol9cIFJQjCQ/4Ma7ow5JAEE+fQT1W+97LrxvMa
         qtL/CFB/q8MsPp2bbiLRlXkI2aAfsd6df5SAP7wCiuLPvP1Ke81naAA6ZkO8fxFrHF
         321NP6NwUqCRg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Smc6401bmz4wbn;
        Fri,  8 Dec 2023 14:27:55 +1100 (AEDT)
Date:   Fri, 8 Dec 2023 14:27:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the spi tree
Message-ID: <20231208142754.6720183e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3qSm+5zJNQx3=QRiXxHHFiG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3qSm+5zJNQx3=QRiXxHHFiG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the spi tree, today's linux-next build (htmldocs) produced
these warnings:

include/linux/spi/spi.h:246: warning: Function parameter or member 'cs_inde=
x_mask:SPI_CS_CNT_MAX' not described in 'spi_device'
include/linux/spi/spi.h:778: warning: Function parameter or member 'last_cs=
_index_mask' not described in 'spi_controller'

Introduced by commit

  4d8ff6b0991d ("spi: Add multi-cs memories support in SPI core")

--=20
Cheers,
Stephen Rothwell

--Sig_/3qSm+5zJNQx3=QRiXxHHFiG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVyjToACgkQAVBC80lX
0GyDQwgAjgAyX1oREeAHMk+mcIDF8MHCJp52cgkX9CHKVAsThqN5WbHWueCafJBa
6tBjiZ8RKs5fn7dj0pCJatZRqWp6hq7bjN9ACnfw+LB3b69/gWKq/Xw0M4d7e0PN
RxDvhoTlqP7TUP1MAtHqbhv0SCMKEIlCFcchfibW1Ir8B2uGRqbZeLVG2JCGWZ9b
Y9mZTsVBXZAOtAY+XGQelZgbptIi4PCwW5EwmhtDFL9uZ572vdEsLS28SbnsrhdI
YGyXuegnWfQDhzxmrCYEulGOvwuKZjcb/cAHUE/bWZnegNJ990/QFGwR0AjdZyT+
+IwpTa4IdCIOVOrY/HC+itpHrPx5lg==
=E4+Z
-----END PGP SIGNATURE-----

--Sig_/3qSm+5zJNQx3=QRiXxHHFiG--
