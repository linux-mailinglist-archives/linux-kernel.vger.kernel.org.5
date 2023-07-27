Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F15F76467D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjG0GK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjG0GKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:10:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2981715;
        Wed, 26 Jul 2023 23:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690438217;
        bh=8R3Ogk/DTkfYmjT/bQZNu0C3iSpAtP3KSOpXCpvUTfg=;
        h=Date:From:To:Cc:Subject:From;
        b=bHJsIwoeTiX/X9yMdI1+gH5Qu8Nw15WG3gOyY2B/GdmPVeC+LtbJhy3FjEk+xfLQc
         wiMdgqRaaMzAeYNzDmIdp230wPvv1i1Dw71/P+kAh+cO4qTW7SeQRbmQyZyT+FjfJv
         mo42mKELIUvadT6sFS2MkKJvlFK4BEjHrfy97NA5amLB+mjQSIl3R4HVFeZ/QxHyCk
         DtyqN/XGs5vysWOogFUMkjCIxCw506gZMEHp6o8dsfHymbUtr42sxlVscOLc0VvnHz
         K9q2FxaletTbS9CB03S2pSAj3kUBlU4U7AX15cI7NFrLfK59AwQGMvYCHuLlGV2Zu3
         gZt4uvWVGsfLA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RBL3D5pQtz4wZw;
        Thu, 27 Jul 2023 16:10:16 +1000 (AEST)
Date:   Thu, 27 Jul 2023 16:10:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the block tree
Message-ID: <20230727161012.752ff71a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3r_GWD2cq7J6VaXY.5H=Fvp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3r_GWD2cq7J6VaXY.5H=Fvp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (htmldocs)
produced these warnings:

kernel/futex/futex.h:183: warning: Function parameter or member 'wake' not =
described in 'futex_q'
kernel/futex/futex.h:183: warning: Function parameter or member 'wake_data'=
 not described in 'futex_q'

Introduced by commits

  c8d49e4f6dec ("futex: factor out the futex wake handling")
  16759c720d7b ("futex: add wake_data to struct futex_q")

--=20
Cheers,
Stephen Rothwell

--Sig_/3r_GWD2cq7J6VaXY.5H=Fvp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTCCkQACgkQAVBC80lX
0Gw9RAf/Uc+eecvunwmWZ1vvAaa1cdyjuKH4t0CCUTX2jvELVYeplNjY/p3B8asE
9r8wFqts7vmUxHyjFyo9BHK3LlTp1RbbiLE8OfPbznz8ybHw2wJq0K/a6wrOTMzf
N6/bXNA2vxLFKnYtu2ZfYBTEaPAbBbHLVAJncsaRTtqaFT3qTEVUBQeak7tFi0QI
mtN4ZLxQIZp1JGRtLebv7tlJISWxfxUiFr9LoOJsvfU+ymXdajVzU5G1EfVHBr9J
MJZeHOW/xHiJmjQsGNU3LbCI27puL9x8U7pH5mIAD9yMlwPsGtaEFrsAyFLFkTpu
t09WJBHK4dREsAV+7rNV0qPIZkH+BA==
=0ogw
-----END PGP SIGNATURE-----

--Sig_/3r_GWD2cq7J6VaXY.5H=Fvp--
