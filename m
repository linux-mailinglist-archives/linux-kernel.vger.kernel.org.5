Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7CB768890
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 23:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjG3V4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 17:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjG3V4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 17:56:01 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6965DBB;
        Sun, 30 Jul 2023 14:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690754154;
        bh=7XpEkfl8clCT0ZYOcDvCgYCrOefupL9iaTBy5iFI6DY=;
        h=Date:From:To:Cc:Subject:From;
        b=FpJ5M9WZeoL6Tr3b9VQ39JrFyPNWzPg/cQ+Og11AxwtObULjpSSYKSFu69Cer4DLL
         q20YwAl6g7OrNHg0UTz5Ddp5uYoJfYPDyB4/5pSaVniOrwrA5dU48nnumxkCN/Acro
         u7OAFZvpUrS19QSQ/z2dm4fd5gFntw5HZamDbun+cPKPCbGlEf6kbhH2nax044Oulk
         bzrNF3nAbncX4SmqtvxbtlzwVnQFzb7EewhFOSg3UHxkaTDyqNwC9Lg4UagNSWjeMg
         3+YzNVFAz7NzkhIQknpSUjgUjXNCm6DNffUYUinytb3XebWMpm/2p0FcDVdCkUnmLM
         UABynnkWpDxNA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RDZtx1wB0z4wyC;
        Mon, 31 Jul 2023 07:55:53 +1000 (AEST)
Date:   Mon, 31 Jul 2023 07:55:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the v4l-dvb-next tree
Message-ID: <20230731075552.52fbe351@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_i=3Qgft5sBGFhD292kHURu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_i=3Qgft5sBGFhD292kHURu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  7581c293584f ("media: adv748x: Return to endpoint matching")

Fixes tag

  Fixes: ("media: v4l: async: Simplify async sub-device fwnode matching")

has these problem(s):

  - No SHA1 recognised

Maybe you meant

Fixes: 1029939b3782 ("media: v4l: async: Simplify async sub-device fwnode m=
atching")

--=20
Cheers,
Stephen Rothwell

--Sig_/_i=3Qgft5sBGFhD292kHURu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTG3GgACgkQAVBC80lX
0Gy7Awf8DRWzQb7yQAbO7O2psQEt4sWmnbwXXjjr79GT6HxI7ZVzZaBfogIVlLka
yfvF+2uar95Jduz5baWaXFevoeK9++O2gg2qKfl9rtCjjEjNk+ymSgAHYd9qHJIo
z5zCtmnRXp5cYCepWDybU6sTE6Ojpkxda3hpKg8B/pFbfrPIhvInTKL4zIN7+Cup
GTnQwLwGcRK/AWJNKVaTepBCVqy0iDgvTfd3y8CTHjR5kQn2JCaaP9tEhnh3v2yM
rwuyBJN+SSIVEr/9wVfumKsLhSgIKjYErxA6JSBologdCxahHkkDuLquLkUuVT+p
cgTLTkQaBKKAc3xkSwznXK73JtxcVg==
=tf2A
-----END PGP SIGNATURE-----

--Sig_/_i=3Qgft5sBGFhD292kHURu--
