Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9AB76A5AB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 02:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjHAAnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 20:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHAAnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 20:43:13 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2D319B7;
        Mon, 31 Jul 2023 17:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690850590;
        bh=UOeoP6o8nLk2lubr/P1iUVA7r8c0igQrDiDRg7uhqck=;
        h=Date:From:To:Cc:Subject:From;
        b=i8z5gH1ThEM/rpQyDHxRuBInnpf+wCP6sPpqztCO0IaUtGkv6KeoVxamg3ajLb4vI
         BnNN3EXXCzkkXn83i6eBI+WGyWh0hP+4jPyER2KHwcFA7a0Sgo3HXnm1ZEgps29+uq
         C+1hUTrBIcK1UcSOFelKuehFvBda+6pT/zpTYoXx9CaNjZIKBXWxFoqblCatzXhrEK
         qD6A2yYXC+oBmBf2LWPPDboDaKXNxBhX6PW+ttqlK9NsNgVN17AaKHQeTk5eVayHrR
         KkzwGAhkHx+cskKKC2Q3E3yVmfjSUL6p4zbYYrvQ4A7+0F2FmLc2UeTkJsgwjLGcZJ
         0jv2Cu4eM0vbg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RFGYT4X65z4wbj;
        Tue,  1 Aug 2023 10:43:09 +1000 (AEST)
Date:   Tue, 1 Aug 2023 10:43:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Helge Deller <deller@gmx.de>, Dave Airlie <airlied@redhat.com>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        Fabio Estevam <festevam@denx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: linux-next: manual merge of the fbdev tree with the drm tree
Message-ID: <20230801104308.0de7f835@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qc/9R..mTUGHjsXvnE7TEIt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qc/9R..mTUGHjsXvnE7TEIt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the fbdev tree got a conflict in:

  drivers/video/fbdev/mx3fb.c

between commit:

  8a4675ebbd30 ("fbdev: Remove FBINFO_FLAG_DEFAULT from framebuffer_alloc()=
'ed structs")

from the drm tree and commit:

  87ac8777d424 ("fbdev: mx3fb: Remove the driver")

from the fbdev tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/qc/9R..mTUGHjsXvnE7TEIt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTIVRwACgkQAVBC80lX
0GweYQf+Luz0E8dd76dHdVBilRIJ/GhTDZ2mwr+kQ3IkvjiFx3pT+rQPiS4HZiz9
g0SQtwEYQKKFip2scQ5O6B8kcmcNGvd1cEVSnEBVlJ0EFl3e56x/ikwXUq7YeHP7
5BdZe/6EcneTovS4S6NZS9RoxVklwnyQvChPzgtpMSqUN79uk5DBF/GdJdbC14qR
KLChDMDtR5D0teGj/nMi1e/wnuhh5fI97kU9xfFZw9Vn1NbN5ZFT3MlbkB8w3LK8
vLQhq19rTvKbRJnm+aYIuNgO2zst5VGfxUj1KAm3Ghsca6q+A1Q9WuX4Yr+EKP26
0zTMp6DamHhlmiS/vJbYaJxMojw7HQ==
=ITek
-----END PGP SIGNATURE-----

--Sig_/qc/9R..mTUGHjsXvnE7TEIt--
