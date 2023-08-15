Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C45077C589
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbjHOB5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjHOB5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:57:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CC5DD;
        Mon, 14 Aug 2023 18:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692064657;
        bh=vd0JC7hw4IxL+4WIfWCTpQiNykHEfD+ooEnaSXL1iMw=;
        h=Date:From:To:Cc:Subject:From;
        b=NR5IldqLrvdL4VTdJ4svRS5ymVy/JK10FQDaIDr1a6Le+DxyUDL9GWlhmCpdRtusv
         IQfrsXqOqEE/auJAsNK7pRQlFTdFDJFymF0fEDPa5mmupyycSvl4cCWWLwI+PAucxh
         GDH1epWBRNvRg7DbHhQ7Xs6HvAWTA4iP90JneoYpqgvtRFx8bcNU2jpznAQB1HCBfV
         nRtemU6VMTvX4e0qT81kBKlqwvn7AqUmkLftjJEDgpa2dGCoCqLQJI2GHUm9aibg7g
         7I5LSI5XpvXP5/OluxLJ7ZEFLJu11GfGLnSANQuUnIZvK9m8/ZUQeefUwKy9gBQH6I
         8xjfEvtmIVOIQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPvXx0GLkz4wxQ;
        Tue, 15 Aug 2023 11:57:36 +1000 (AEST)
Date:   Tue, 15 Aug 2023 11:57:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Andi Shyti <andi.shyti@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>
Subject: linux-next: manual merge of the i2c tree with the i2c-host-fixes
 tree
Message-ID: <20230815115735.04151abc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2Cy.X.WDeTfy0W61UyH8vHf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2Cy.X.WDeTfy0W61UyH8vHf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the i2c tree got a conflict in:

  drivers/i2c/busses/i2c-hisi.c

between commit:

  9a5adaf694f5 ("i2c: hisi: Only handle the interrupt of the driver's trans=
fer")

from the i2c-host-fixes tree and commit:

  fff67c1b17ee ("i2c: hisi: Only handle the interrupt of the driver's trans=
fer")

from the i2c tree.

I fixed it up (I used the latter) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/2Cy.X.WDeTfy0W61UyH8vHf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTa248ACgkQAVBC80lX
0GxA/Qf+IyCV7mY93TVGkENs/leKA8//uGmqvB1WwCrqNo8sTNRtG5bD9ISevglH
vJXLTMm2Do3Ek97mdcIcLxpGD4ZKTtarOzZwbJIl3ipAr+JohIO8pwYhbG3TOaPH
dIqTRThB10aNTGImA35HisMRGHLNvshRrVb3UItuYsIdM82PCNDAxdPUSFxTUUng
lz9iGAN+bAHO+xHoyJ4/Xh2JZ3onJQz3a32/JGUF2aXsY6ibu/Ha71MG15g+yfGu
vCD6lQ43i7+IRsGa4RAL8Tzc6djsM1ntMDbvRx338TnpsHE65txJFDcG05uxiXxw
79mk9Fy138pHW4cKVFiXmdZgR4QBKw==
=hBbc
-----END PGP SIGNATURE-----

--Sig_/2Cy.X.WDeTfy0W61UyH8vHf--
