Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43417A8DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjITUcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjITUcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:32:03 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2A6A1;
        Wed, 20 Sep 2023 13:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695241913;
        bh=LFTg2HI9qSgWo74IMrI4kpPpJmSuShGV+RDCu1SwzLY=;
        h=Date:From:To:Cc:Subject:From;
        b=oYFQvsLmzUKk6ZvESRg9d6ggoFp3AkHPOKEb53Pxt/C/TWbQ3KUsve5hBovnqXblm
         TC6E0Ef4tI1ZwM7ig4Kiy/YMBIscwbO1bCnF00IobWX9xTWXm7IGhq0eod2j3SZDKi
         B0F9zzOi5YNbC3Cy8u4/5ZqauCo/Pkve3FTzC5s0eOS774/BPeY99AWFFBgUP+V9p/
         mMjIzp3oAHk7VQOiU1FYUJNZs5Z7So6UqPvE5ujsvny6vwRoNVcnL8Z/pX4ZFCq3hh
         dt2PQxSTATeg5zAKAQIu/ZHPbZwigYOZVGq2nNsM7K9f59Lv/ZarWA2hmzE3sPslPk
         MLYsvBOg1pn0w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RrVZ06wGNz4xPN;
        Thu, 21 Sep 2023 06:31:52 +1000 (AEST)
Date:   Thu, 21 Sep 2023 06:31:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the btrfs-fixes tree
Message-ID: <20230921063141.7ab60044@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/O77yK9Wu/ee7qpLNByZlsuq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/O77yK9Wu/ee7qpLNByZlsuq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  3a5260210762 ("btrfs: fix race between reading a directory and adding ent=
ries to it")
  994649f7da1b ("btrfs: refresh dir last index during a rewinddir(3) call")
  3a7b9dc311b9 ("btrfs: set last dir index to the current last index when o=
pening dir")

These are commits

  8e7f82deb0c0 ("btrfs: fix race between reading a directory and adding ent=
ries to it")
  e60aa5da14d0 ("btrfs: refresh dir last index during a rewinddir(3) call")
  357950361cbc ("btrfs: set last dir index to the current last index when o=
pening dir")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/O77yK9Wu/ee7qpLNByZlsuq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmULVq0ACgkQAVBC80lX
0Gzsqwf9GnDOpo1Q10b0wA48qyjk/FkbRMS8FPm5stVR0kue9l1HrvcHQ/GDRKAg
4GgPYA3dOnsdEuPOz+pggdyQN1nQGQJka1ZGA3r6HfOKb1aaVW9ICvdFKvVHyn/K
rlMmnf/t7t6A0MTy7JVKinK7OS4Nb0mkvAVacv/QDRRxwh7cpiIlFYxkB9TFhztr
g9SFlaUKlThw2YvOjd0xhomIcHj/29JKs0WHYBB2BFujhIcg5Rk5wo6sKoFXxmXX
zGp3VnV9Ewen5llLDhBuVjQsdJ2grXEcOoFZZvIupFmR3tDKTs5aMxdabSmpK7DR
qZyLtLahHnPljZw2qmV3Qhq0SmjyFg==
=InTM
-----END PGP SIGNATURE-----

--Sig_/O77yK9Wu/ee7qpLNByZlsuq--
