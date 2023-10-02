Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178AE7B4B92
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbjJBGlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbjJBGlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:41:16 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 221179B
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 23:41:12 -0700 (PDT)
Received: from 8bytes.org (pd9fe9df8.dip0.t-ipconnect.de [217.254.157.248])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id EA6E11A25DB;
        Mon,  2 Oct 2023 08:41:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1696228871;
        bh=W4Tp5WnCJ54D2BoW9qbc/kq5SmRYARJLysU6XU7xl+s=;
        h=Date:From:To:Cc:Subject:From;
        b=ypTQIu+moWXyectBcNgrPPIu1c/q6jjyAtaAcmB2OQ27Ii91wMMq0dLagmlUlknqy
         NE1y3Axabb8KpaULYy7+RMhHvII9P0i5I7PYrR+abt2s3+9C9S9ke8G024R8TOmnvL
         rmk5DvEFLmr2KzUb6hSkGHrxpMLdta0voInaMdtBaAwEv5FrqZLdLdbHFbwqyVXUiz
         qF9r/QCMJ6QjYXUy/BmeoMHPAy4gijfqUkxbt6hCiFWrd18sH0UIoRLhg8i1JQjP5W
         LNt3jUXsYUz324ImUV9ZMjcsAT8v2Sl/nB89FiWOvd6jM6L/OAMFvIn+/uL7NgqO1w
         1kWZuFKxBHSGw==
Date:   Mon, 2 Oct 2023 08:41:09 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.6-rc4
Message-ID: <ZRpmBaTbF3xPNJHz@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TGFrNeBVgX5uFluk"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TGFrNeBVgX5uFluk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.6-rc4

for you to fetch changes up to 59df44bfb0ca4c3ee1f1c3c5d0ee8e314844799e:

  iommu/vt-d: Avoid memory allocation in iommu_suspend() (2023-09-25 16:10:36 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.6-rc4

Including:

	- Arm SMMU fixes from Will Deacon:
	  - Fix TLB range command encoding when TTL, Num and Scale are all zero
	  - Fix soft lockup by limiting TLB invalidation ops issued by SVA
	  - Fix clocks description for SDM630 platform in arm-smmu DT binding

	- Intel VT-d fix from Lu Baolu:
	  - Fix a suspend/hibernation problem in iommu_suspend()

	- Mediatek driver: Fix page table sharing for addresses over 4GiB

	- Apple/Dart: DMA_FQ handling fix in attach_dev()

----------------------------------------------------------------
Hector Martin (1):
      iommu/apple-dart: Handle DMA_FQ domains in attach_dev()

Joerg Roedel (1):
      Merge tag 'arm-smmu-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into iommu/fixes

Konrad Dybcio (1):
      dt-bindings: arm-smmu: Fix SDM630 clocks description

Nicolin Chen (1):
      iommu/arm-smmu-v3: Fix soft lockup triggered by arm_smmu_mm_invalidate_range

Robin Murphy (1):
      iommu/arm-smmu-v3: Avoid constructing invalid range commands

Yong Wu (1):
      iommu/mediatek: Fix share pgtable for iova over 4GB

Zhang Rui (1):
      iommu/vt-d: Avoid memory allocation in iommu_suspend()

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml |  2 +-
 drivers/iommu/apple-dart.c                            |  3 +--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c       | 18 ++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c           | 15 ++++++++++-----
 drivers/iommu/intel/iommu.c                           | 16 ----------------
 drivers/iommu/intel/iommu.h                           |  2 +-
 drivers/iommu/mtk_iommu.c                             |  9 ++++-----
 7 files changed, 33 insertions(+), 32 deletions(-)

Please pull.

Thanks,

	Joerg

--TGFrNeBVgX5uFluk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmUaZgUACgkQK/BELZcB
GuM9yRAAkqY5NPFkF3VVS0ZN2EfXa35LE+ngwJa43Y/HQDEE6NriOyNTlQHLHdlp
ia7b8qrqVO0vFhQ6XXX1LVqrBA9kep9Nf3G40Gt068Uo6KUiYaSrw7exPszDsSQz
L0A7WDS5MAHr/5JgzpI5Lmd/shpPxoRo9YMiP7ehKfQY8/WVtfOt5jIU1A30nsf+
oSegb64EroHrc7aKTXTJwBTQn7pqLusdj0B4DeQB6ohEmx08S6JLHvHuDvhMUJ+0
nbefpUNLZgPORtXQPiw6CZ5M2vZVKpNBWIEhqAofcUwEYpgizxmt07C4mih22daB
m+kWwvVDLFKAqvZIbVYQaHVbCmBWvYC8w7DMgmtKAV1QQLpxBibMC/VXGz1Gy5Uh
F/hTh2d1KCtVGJDpE/uK24O7RaIRyVwlACRbU8jGOamuWYCyiRP39RbioqnBjF5I
4AJFeop21xBYcoTtQrKdw2+axZOn1OwQlcdEeMoo/5WLfeelCef0EgsmW5jwNcTc
LrH1FWNiFaEd07pD865DmgDJF/+epZRRGPBq+slIO8lLM69jg47PHsgCFa/eckhI
q1H8IxUFpe5KoVata0srQc8OC8QjQmULYts4yeiNJB0T7H1JrvNpWiNEiCycRhCk
uHuTL/T7CBiky4QAgR+DUXaBpa2qivHMTGZQ3tHw2B+mlngI5WY=
=Gnk2
-----END PGP SIGNATURE-----

--TGFrNeBVgX5uFluk--
