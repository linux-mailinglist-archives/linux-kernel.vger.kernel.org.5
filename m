Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E352877EF99
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 05:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347877AbjHQDim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 23:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347870AbjHQDiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 23:38:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F74D123;
        Wed, 16 Aug 2023 20:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692243492;
        bh=suVGXzZK1za3LotyI8GwsyflZ72PwO3Z4uf0t2QDh+I=;
        h=Date:From:To:Cc:Subject:From;
        b=Pvz6ewJMjHkdKFIrStSp4T9noRHzqS2YVkLp5NsfVM0/QE2u+LCwiKBI4pNjqzq4c
         3yxfP7YgSBfgQqRoADsYxV4Ticr9N6v4GgrWjtnuZ4ESrRWjHk8Xy3dXrHajJOyyVI
         PgDZUIKPOw4xLt6ptyvZhG7NkI3UFdztZhWUb/2eV3sWrjXlAxBlqNUdVZrsqv3K0o
         soTBecAGNbin7ATPw0sq6ksGW0smvgW5uNepEA4897gmMsfBZ7TS32jfqClncP8ihH
         nDNIqpgBSdTyYLOJyGhtnsTnZ7NURBLCDrQCeAdCzvUIbYy9zhmY2GUKXs1t/Xab7V
         fHYslwD+VsZgg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RR9h36glhz4wZx;
        Thu, 17 Aug 2023 13:38:11 +1000 (AEST)
Date:   Thu, 17 Aug 2023 13:38:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
        Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the nolibc tree
Message-ID: <20230817133811.0a73c624@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EGVuQwFWSy86H.a2DSRfRt_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EGVuQwFWSy86H.a2DSRfRt_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the vfs-brauner tree as a different commit
(but the same patch):

  ba859b2e419c ("selftests/nolibc: drop test chmod_net")

This is commit

  49319832de90 ("selftests/nolibc: drop test chmod_net")

in the vfs-brauner tree.

This duplication is causing a conflict.

--=20
Cheers,
Stephen Rothwell

--Sig_/EGVuQwFWSy86H.a2DSRfRt_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTdliMACgkQAVBC80lX
0Gwg7Qf9EcEq00U/ASm7iE2us0Gyqemp1k8pVEiIutTZA7CSv5gm3w8JGNld2u8Q
s932Gpdax+ImhoX7nULCD5RYbgIL2xlPnnY49n7AjcvsrR9s1CC6yKJgFeDrH6TD
fOfJcHRAwmwcNai2HPtBH7JVPNORE706mw6VpJiv/Z4q8GNblQWkdN58LwTjwzRQ
+qvQqd4WbDdvBZN33HAcgzXQ/FsuHlomfXczzyfMsen6dcy+gH3g218w6dgEx5eS
bFxPh8mv+hNihYrAUiAUdTerSa+eNnKGMkl6SUgOO8GlhjDxVlwtMLiUQjRAuZaW
yXphxL06Ol8MRMq2W15PbH4Tbu7r7Q==
=dNHK
-----END PGP SIGNATURE-----

--Sig_/EGVuQwFWSy86H.a2DSRfRt_--
