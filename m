Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44D57B101B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 02:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjI1AkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 20:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjI1Aj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 20:39:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2756110A;
        Wed, 27 Sep 2023 17:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695861595;
        bh=FDGB4csrUsfR2IX+TgcOAJbRJr9AaNa4usEGCtv9UM0=;
        h=Date:From:To:Cc:Subject:From;
        b=anEhgZaibKLYk351TCxuH2pphaLhMqCdVVHZHRWXLTDiypTe5VhNBfcSexoB63rzw
         z1WZF3dpofsvjUzE3hQJgkPxy4GOOKpMWzGJaZT0UmRE32g0tnQ4yV3EkzP9rHKU+g
         lc4VfI5WPWx5rjToHa8bjghwjhEFyMr0EXua80pSswpweah2mraMFGhwjcad6EHLuW
         3e0+Kd1kLsOgzFtuh/YFJ3WyvwV2FPuTdvmMlfbWpOBsN7qypyO3nfsmLh6jaXFoHo
         uWdd9TpN8HaUZX0ms23kAln8y0Od5rV8M3Vc9X1xmojjv0YaRSZ+38354By3KzNVRg
         1PXyf4CEhS1FA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rwvkz5lxRz4xQ4;
        Thu, 28 Sep 2023 10:39:55 +1000 (AEST)
Date:   Thu, 28 Sep 2023 10:39:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20230928103954.78444923@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iMPLItn/uOFZjavHpQTX0.U";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iMPLItn/uOFZjavHpQTX0.U
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-brauner tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/md/md.c: In function 'md_import_device':
drivers/md/md.c:3635:25: error: unused variable 'holder' [-Werror=3Dunused-=
variable]
 3635 |         struct md_rdev *holder;
      |                         ^~~~~~
cc1: all warnings being treated as errors

Caused by commit

  15db36126ca6 ("md: Convert to bdev_open_by_dev()")

I have used the vfs-brauner tree from next-20230927 for today.
--=20
Cheers,
Stephen Rothwell

--Sig_/iMPLItn/uOFZjavHpQTX0.U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUUy1oACgkQAVBC80lX
0GynqwgAlHT2iw31F0AJ+pwo3223pLmmtmecLpbJbw2XHpXrD/vVs74ooT9LLC4e
gJRliCkIhpoD1aCV2VHXI8if7Q7a8gMLfI1XRpIA42+fgyk82YW+yWXV2zX6s+Rh
OYfvexn6jrTA1q6sG3wg67wLx+aL28K1SPEdmWI+/XfjxM5sNrnzbA3ABC9gMu3Y
yOCI9Xn4ep3ro0FS6uOxHGN3hrKezAzWMQx1/7G3XHF9tkUKYRp0oqlat8zaGo8v
WgvhCv+0tSole3TMejeHl4Ju/97gPen/KpcSadw8Rg8GFGtoDC6gUofwmUEw1gYK
2js4w5K5FtIZ5GVRRXuPE4NIyMY2vg==
=llvo
-----END PGP SIGNATURE-----

--Sig_/iMPLItn/uOFZjavHpQTX0.U--
