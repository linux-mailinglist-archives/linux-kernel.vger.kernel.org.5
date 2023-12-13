Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C00B810710
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjLMA4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjLMA4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:56:15 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2021AA1;
        Tue, 12 Dec 2023 16:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702428975;
        bh=fSqpKJ8HzYbAkrw0VUdBtWY8LU2YCqW2PJ/MneJimZ8=;
        h=Date:From:To:Cc:Subject:From;
        b=hlrYCOgriJbNl/PCfw7psBgKitg9EBSXb32sDi6+T+evyD7IUAfPW5V4FmEfrMYDS
         a7gJ5j8zsg25K4kKRYdIwuTvakYnaFZa7npr2J12dQHj/EyidnuDat4Osmri25Wro6
         8FbliHyugZbz9Hc2gJDrHM7Sf49OK17QULaHYl5l41Beuf0RAWAwH/S5nOZAsD8mco
         bG/k3bdHFTmYBW51zNZOZtJYLgkPScivEoyeh64og8lLg4obBgacHahIurCfhTjZtc
         nfhBONXJ4rokiFeSUWRqFao75J6pq1THuWeM3wtzRw7L/ekYWRU67Odx7HT7oHRQiW
         q+ncKVGqxQjrg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SqcVk2y7pz4wcj;
        Wed, 13 Dec 2023 11:56:13 +1100 (AEDT)
Date:   Wed, 13 Dec 2023 11:56:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Helge Deller <deller@gmx.de>, Dave Airlie <airlied@redhat.com>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: linux-next: manual merge of the fbdev tree with the drm tree
Message-ID: <20231213115612.4bbe3258@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Qh.ZrrYP3RXclK0Ec5S7dUz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Qh.ZrrYP3RXclK0Ec5S7dUz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the fbdev tree got a conflict in:

  drivers/video/fbdev/amba-clcd.c

between commit:

  76f92201b821 ("fbdev: Push pgprot_decrypted() into mmap implementations")

from the drm tree and commit:

  13366c25125e ("fbdev: amba-clcd: Delete the old CLCD driver")

from the fbdev tree.

I fixed it up (I just deleted the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Qh.ZrrYP3RXclK0Ec5S7dUz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV5ASwACgkQAVBC80lX
0GzITwf+MprCy8he3YkNyx3AutdZX9UZCaE1PsKoYCXUJ+6TN/DGXy+L0GLCPp0r
ExVDHecQbKwp58pFqiXPDpaiGc1Lz2x7QgKmzsArhvWAI79wLt/7Y0OYkDAMoynu
gUQzK0xs5R8zobLqRTmlkO0MXfTewTFF7aUruoK+U08ZkhVnHSHMbousESPwWEH3
aO88up1U4UWwN/vDwZ5IvxP6+osu5W8+EI1/f0NZZG7TFzPyPfeBRh1nMWDtvQtv
Fe19x+pCjBt3duB/u9/YLFsxzKdCw7OhBMR3ChqYfu9kxxWTnw41HPjARVxjMqpv
whNp7OEFtTcxir5CZwAlpb7EnbaJbw==
=HR3/
-----END PGP SIGNATURE-----

--Sig_/Qh.ZrrYP3RXclK0Ec5S7dUz--
