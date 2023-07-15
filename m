Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31091754730
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 09:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjGOHP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 03:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOHPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 03:15:54 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46D9DB3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 00:15:53 -0700 (PDT)
Received: from 8bytes.org (p200300f6af03f600fd690381fa83412b.dip0.t-ipconnect.de [IPv6:2003:f6:af03:f600:fd69:381:fa83:412b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 91BDB280007;
        Sat, 15 Jul 2023 09:15:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1689405352;
        bh=uahWeMqDjDajfMcwL+wz0z2u90UDDXgmBH4gzF67IxE=;
        h=Date:From:To:Cc:Subject:From;
        b=NJzw06Syjk1h/omECTnjmTW256SLLt8ABcyH8jRfsTjKyS/nDfOWdt8NFUZ3bkwz4
         zekgGZYdb4l2TxIDpYAn6dzkdUhKn+QVOKgf8DuwqySScJb0JVavrsaeGbnfRUoVq1
         pjL3GlAtYQ6rHqJNGUNjo0K2KU4f3gqSk9vPAuBngPVWB6ttpXR2tgEJ5oSJr1FhRr
         4JlLmn2K73rJu6o5pFQSnxg8IiCpACmW7c5XvI6rOxncgbNUqq/+FUnO9XvryL5zjd
         13nG/taX7Gc+I2Yah3j82gw7E54P70/KDoKSKesZU8bjowOMZ2dN5OZjPuKEvKub2Q
         M8TM3tn8uEbCg==
Date:   Sat, 15 Jul 2023 09:15:51 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.5-rc1
Message-ID: <ZLJHpx42Da4LA_ng@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NYo4bnuuyCWP0V5D"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NYo4bnuuyCWP0V5D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.5-rc1

for you to fetch changes up to c20ecf7bb6153149b81a9277eda23398957656f2:

  iommu/sva: Fix signedness bug in iommu_sva_alloc_pasid() (2023-07-14 14:53:19 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.5-rc1

Including:

	- Fix a regression causing a crash on sysfs access of iommu-group
	  specific files

	- Fix signedness bug in SVA code

----------------------------------------------------------------
Dan Carpenter (1):
      iommu/sva: Fix signedness bug in iommu_sva_alloc_pasid()

Jason Gunthorpe (1):
      iommu: Fix crash during syfs iommu_groups/N/type

 drivers/iommu/iommu-sva.c |  3 ++-
 drivers/iommu/iommu.c     | 27 ++++++++++++++-------------
 2 files changed, 16 insertions(+), 14 deletions(-)

Please pull.

Thanks,

	Joerg

--NYo4bnuuyCWP0V5D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmSyR6MACgkQK/BELZcB
GuNOQhAAmUjSd+P3/LE+rNVJSgPFlt/c4De1UtekYdJSrP2EK05i8oesRWiuNHBE
NseETD2ak6fIXihCl9Dp7IYGTuTxJLWqGV3Ukriw8Cm/sw31u0XCg5qz6dZJ8G3k
o/gRttI6K0eyIz+m638GIMMOVOLFOGvBaqQKtUopmiYD7th7EXcAqkoYqRXCiwYq
9K0bzJ+v+QQJXNYcgS7m79LxWArofj3bNGpAxeUozZRBvkC4MRkVvdEE8ZkSHUH0
YUWfsOxQTKjm2OR4RY4z3ujMnMnlVZaNFmFjIn6JSkjaJfR9fES9f/P5W4iwmoTN
GVp4VefS0FZtKmWHCG5I+N+qy6mcCdO4K3LuZtQ65FtuS6CnEAsag5eOOKXQcJNY
DkRFcTRV6VVg73cRfxgRhIexkKTp/EuIeUjmQuCwFpC5hDAyBdrWMU709Njuf/rm
jJ5rvu2MlAqMCRwa6huIV6384CLxKHUCLrdwj0fKUAL4/Agdalwel035p2JogEcp
0phmafwifxsSBccJoK+6ix5y9APP1+1vP8WqjpiT97Q3lfwqIkmTanQR9XeWs0Ai
zvhK7FMj+qNAe2M3gzi3gI7ZdtafZLDCbmLgpnrsmfyZLGPb1H0uh8Geuu/OAwkP
ICLLIJWG1U4cTrb6wb8nuTUG5gn/8NposMnTqQf75modJk5FuCY=
=knlX
-----END PGP SIGNATURE-----

--NYo4bnuuyCWP0V5D--
