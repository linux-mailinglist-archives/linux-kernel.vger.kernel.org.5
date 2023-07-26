Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BD3762806
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 03:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjGZBKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 21:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjGZBKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 21:10:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2CF212D;
        Tue, 25 Jul 2023 18:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690333830;
        bh=x81De0pyPq/SqFSFmk4EAkh9ZgAg19r+n3E+hX4bWn8=;
        h=Date:From:To:Cc:Subject:From;
        b=XXI+kGZcIIAiMbkcPVwkd8Ri5HUoisUR4qXDrU0ZSdooBCn3+qisR/r1z8y342fBL
         2yueWtURHxa1ylTeX2ee9qP48kFz7lwhHnAY5VNiGLEpmAHVoiXnPrA+MKVXwm1TsT
         1RtfyKeWxRNgFtLdn8v5yVIVGfRbYMtoYp/SYZaxlS0oyVewmyPRCxYfAsL1yXpadr
         EGLot4+l5az9FOujR3SbqKdI65mHpk7Gj3s+VQL1AgKtOTVlbcuivjNInUUGFd0qKN
         qspHULOZHDksHu+Rgp/w8Vr/tdzPCGg8jOCBVVvmsdov3zZh+GFDjYW95Z9+YKTS6h
         H8u216zxuEZ8g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R9bRn1dQYz4wZs;
        Wed, 26 Jul 2023 11:10:29 +1000 (AEST)
Date:   Wed, 26 Jul 2023 11:10:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Dave Airlie <airlied@redhat.com>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: linux-next: manual merge of the amdgpu tree with the drm tree
Message-ID: <20230726111018.6a023a7d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GcJb70x6Xj5jHq4d7Cvw41N";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GcJb70x6Xj5jHq4d7Cvw41N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the amdgpu tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c

between commit:

  8a206685d36f ("drm/amdgpu: use drm_exec for GEM and CSA handling v2")

from the drm tree and commit:

  30953c4d000b ("drm/amdgpu: Fix style issues in amdgpu_gem.c")

from the amdgpu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 7da871972a8e,992dfd3de49c..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@@ -226,9 -229,6 +225,9 @@@ static void amdgpu_gem_object_close(str
  		goto out_unlock;
 =20
  	r =3D amdgpu_vm_clear_freed(adev, vm, &fence);
 +	if (unlikely(r < 0))
- 		dev_err(adev->dev, "failed to clear page "
- 			"tables on GEM object close (%ld)\n", r);
++		dev_err(adev->dev, "failed to clear page tables on GEM object close (%l=
d)\n",
++			r);
  	if (r || !fence)
  		goto out_unlock;
 =20

--Sig_/GcJb70x6Xj5jHq4d7Cvw41N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTAcnoACgkQAVBC80lX
0GzdbAgAgDrIqg6GLxXBvoD801tI5aVqEARno9PYvGQtHs9Udzhu6k7B8yiMfswn
xnovXnIyBf2OTzgzawjbN8pdAG2UC2bXQjZvOCykQutIqHRRBVJ/nLbNMd2bIdGG
1d9emDP5uFhf9vDldFkQfDqvvQEomE+hhlRJGG72W4FOg4j834X7JFFZmOsCN6sM
hsokD/iHbfFSdSqlZbSyGAZjdyXDfnaz1Wj1fDjLeeEkHi+sXKQtnMMDd7TSviEn
DXplwdQ48lpQD5baOMsCtQB3z7X/ahg1hmwxG7Z/3s2/wb5EgxT6p+1ay49YXfzN
757MBtlRPIkFp08pneBd6rjPVkcYZw==
=tN22
-----END PGP SIGNATURE-----

--Sig_/GcJb70x6Xj5jHq4d7Cvw41N--
