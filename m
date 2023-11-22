Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5DD7F3AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 01:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjKVAvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 19:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKVAvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 19:51:45 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BED18E;
        Tue, 21 Nov 2023 16:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700614300;
        bh=5Y2aSfjsCdGy6qFz2dwjuQl2kp/3JDymxNRBgtubDA8=;
        h=Date:From:To:Cc:Subject:From;
        b=nBRZfI6pFAAPFgya7CKcjI66blAYxQYN5+eyug6nkowRsBesBCXMoB4Oxa9Lxescg
         GWbdXi8H3OcOpzp58h+tJ6Du/kTunWzaNDJz2dTsEbcHk45WCyFI7LM0WGZ1FTwAQ8
         fUYpwZmn3G1q2mntV1Lu7TTdckX/yD8MDqDoBgFREq8pUmqIDjo+66cjhKbrfwB3Ik
         vaNPXu+O8Sg/vusu4aLUk7kiett3RAIGUnoJQ/titb7LcN4OBOLthywrlMWlWidPJo
         e/iWV6fV0GjHsY3ThtOh3nHI/rV7Ck2RKmnGTW8pcjoayo6MfgM6/UWynSjjg1+Stn
         R5T8EDqIDKUcg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SZjP70df2z4wx5;
        Wed, 22 Nov 2023 11:51:39 +1100 (AEDT)
Date:   Wed, 22 Nov 2023 11:51:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Imre Deak <imre.deak@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wayne Lin <Wayne.Lin@amd.com>
Subject: linux-next: manual merge of the drm-intel tree with Linus' tree
Message-ID: <20231122115137.04a33a6c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I2H4f6VqQn9wBne0MzTm_OF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I2H4f6VqQn9wBne0MzTm_OF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-intel tree got a conflict in:

  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c

between commit:

  9031e0013f81 ("drm/amd/display: Fix mst hub unplug warning")

from Linus' tree and commit:

  191dc43935d1 ("drm/dp_mst: Store the MST PBN divider value in fixed point=
 format")

from the drm-intel tree.

I fixed it up (I just used the former) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/I2H4f6VqQn9wBne0MzTm_OF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVdUJkACgkQAVBC80lX
0GzV1wf9Gz35ouxAlzrIOa/+NQj7wvVFopvSvxFv+GEE8UCRSrnkbg96TFLa+4of
vlG5Bvbtmd0N9OoNKGminwK3T5ghQNa38oZ9Ic1tSXEcJY+5W5XuN+PqFRU2eupv
8owuRqF2dH424CfbV0EE5FEr5hDJWNY6e3hFl+hUcH/CF9Z9UYImw51LZxSQyF4d
LhDqVlKq0bgBID6zDTWMRzRB188rdVN+EGjxz+xsO5ysPh7OLLdMdZL5RbcpfE0F
uUVvCDb9ksqZ5HElFgz5sEiYmOVv9ba1u93TtuPrIzLiF69x7VHqhH7cTSOJ9ODJ
g50onkxt3YOqEiasXkAqBMlhGbOCGQ==
=W9Ap
-----END PGP SIGNATURE-----

--Sig_/I2H4f6VqQn9wBne0MzTm_OF--
