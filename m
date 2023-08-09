Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96717774FE2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 02:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjHIAgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 20:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjHIAgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 20:36:36 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA97B1995;
        Tue,  8 Aug 2023 17:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691541393;
        bh=6ettLlgLL+lNbJJyfC10IQ5aBlfsZGk/KbPDEESsreM=;
        h=Date:From:To:Cc:Subject:From;
        b=okMGYQ047vUFeZphNjsDnfTDdQUDUptnl5PBICJ4BFtXkqXkCqHNwKgt5JiypgmHT
         ilmye8lyqRdWZD7UNCAJy4prVtZp7Anj6GY4HErR4r1XAjYNMx9lEz1167gn/6BQBI
         KYyYHCvXnJezfmx1FNHjw39PWkHEBs1d6LXySXnOxSJ8XJJ3d351cAi7qwXlnNy3qs
         aiTj6qt9kqnzHN9kexD90SoEk/gczV40srC0QS80a4quUWjM99EPeF7yjxqqE2Gx5a
         iEQ7VScmNvA2W+b4cCWU/LYdZE10hUKvClhsDmYOfZNEJaTjB8L0gT34f0Vt+LNyC7
         F2LZoJo3Kc7NQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RLB272Y6sz4wxR;
        Wed,  9 Aug 2023 10:36:30 +1000 (AEST)
Date:   Wed, 9 Aug 2023 10:36:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Fabio Estevam <festevam@denx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: linux-next: manual merge of the fbdev tree with the drm-misc tree
Message-ID: <20230809103626.782dd87d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uUTjO8dq1.Wer9rHpScu0yz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uUTjO8dq1.Wer9rHpScu0yz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the fbdev tree got a conflict in:

  drivers/video/fbdev/Kconfig

between commit:

  8c47895b70a2 ("fbdev/mx3fb: Use fbdev I/O helpers")

from the drm-misc tree and commit:

  87ac8777d424 ("fbdev: mx3fb: Remove the driver")

from the fbdev tree.

I fixed it up (the latter removed the lines modified by the former,
so I just used the latter) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/uUTjO8dq1.Wer9rHpScu0yz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTS34sACgkQAVBC80lX
0GzqZwf9G9a0aUJYQDBMvEb2vlFiUPD+t6Zy9Cpfrhpvuu36cFqeVgWcFzT+MQd1
Zh2uVYaJ/TTEmJSJiaFH1W0j6QSzNmjTN9mm+HMPtipdG887FO4uwGGJQ0MrQ0Ob
FqPL7NV9xkkqQisXzAgLUkhgGDnU8rbA2qbwHx3hjbptRiOf25lDLVxb7UmqzcTc
T6Gm+sm3HB8yCS94G83Wn2r9NCiwZYkFvXeUXTK2aggIHoHFzh2bWH72yKjnubc7
5PgF7rPPOMwgkeTGngB9D8A1cM9rEkIP5uliqgSTSE1e0CGxYWlscUk9ZB2Dq3cw
EBLTOf61NvBrKOCjWadD7P7+E713qA==
=mfCY
-----END PGP SIGNATURE-----

--Sig_/uUTjO8dq1.Wer9rHpScu0yz--
