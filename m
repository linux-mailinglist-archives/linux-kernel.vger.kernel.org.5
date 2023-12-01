Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1069680076D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378052AbjLAJsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjLAJsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:48:05 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9028FB2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:48:11 -0800 (PST)
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id D971F1A9C6D;
        Fri,  1 Dec 2023 10:48:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1701424089;
        bh=E/kNTt4ZtHJ7uU7hhO4Xh8THisOQftO+mIU4Wug48vE=;
        h=Date:From:To:Cc:Subject:From;
        b=zCSOAgoSynAP5bwNHyxIfNF9WpBoKphc22mnnYumcY00KmfQgAyCrv2Ny0pAXkaoG
         trF2ugPgoYZ83mIw7KCJNHgGATSR7iJ9dh6LAwtgjuCHhdQ7EeXhuvfx3ILDm1kBgN
         IVxoRL1ykgXeG+17kiIrE8VJYaOaziSN/DZryvhANiyslEo7nEf2VGU/w8niffoESZ
         CtwSUpNqYPRS9vX2DKj6dTa2pIBQccNmIh3mI3fhqqL1wNcQdYfNhxXl1JtsJynPvQ
         R4gQ1GhF1X6u3s5panvKlyjkroODdXAHIkxHrx2JHW5JhjJT8AQoBYCBc8lrtEXniq
         drRkfW5xFlhlw==
Date:   Fri, 1 Dec 2023 10:48:08 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.7-rc3
Message-ID: <ZWmr2O2Lb8Pn_Hhc@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GTdm2kIbdMeztoIc"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GTdm2kIbdMeztoIc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.7-rc3

for you to fetch changes up to c2183b3dcc9dd41b768569ea88bededa58cceebb:

  iommu: Fix printk arg in of_iommu_get_resv_regions() (2023-12-01 10:13:49 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.7-rc3

Including:

	- Fix race conditions in device probe path

	- Handle ERR_PTR() returns in __iommu_domain_alloc() path

	- Update MAINTAINERS entry for Qualcom IOMMUs

	- Printk argument fix in device tree specific code

	- Several Intel VT-d fixes from Lu Baolu:
	  - Do not support enforcing cache coherency for non-empty domains
	  - Avoid devTLB invalidation if iommu is off
	  - Disable PCI ATS in legacy passthrough mode
	  - Support non-PCI devices when clearing context
	  - Fix incorrect cache invalidation for mm notification
	  - Add MTL to quirk list to skip TE disabling
	  - Set variable intel_dirty_ops to static

----------------------------------------------------------------
Abdul Halim, Mohd Syazwan (1):
      iommu/vt-d: Add MTL to quirk list to skip TE disabling

Daniel Mentz (1):
      iommu: Fix printk arg in of_iommu_get_resv_regions()

Dmitry Baryshkov (1):
      MAINTAINERS: list all Qualcomm IOMMU drivers in the QUALCOMM IOMMU entry

Jason Gunthorpe (1):
      iommu: Flow ERR_PTR out from __iommu_domain_alloc()

Kunwu Chan (1):
      iommu/vt-d: Set variable intel_dirty_ops to static

Lu Baolu (5):
      iommu/vt-d: Support enforce_cache_coherency only for empty domains
      iommu/vt-d: Omit devTLB invalidation requests when TES=0
      iommu/vt-d: Disable PCI ATS in legacy passthrough mode
      iommu/vt-d: Make context clearing consistent with context mapping
      iommu/vt-d: Fix incorrect cache invalidation for mm notification

Robin Murphy (1):
      iommu: Avoid more races around device probe

 MAINTAINERS                 |  2 ++
 drivers/acpi/scan.c         |  7 +++-
 drivers/iommu/intel/dmar.c  | 18 +++++++++++
 drivers/iommu/intel/iommu.c | 18 +++++++----
 drivers/iommu/intel/iommu.h |  3 ++
 drivers/iommu/intel/svm.c   | 26 +++++++++++++++
 drivers/iommu/iommu.c       | 79 ++++++++++++++++++++++++++++-----------------
 drivers/iommu/of_iommu.c    | 14 +++++---
 include/linux/iommu.h       |  1 +
 9 files changed, 126 insertions(+), 42 deletions(-)

Please pull.

Thanks,

	Joerg

--GTdm2kIbdMeztoIc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmVpq9gACgkQK/BELZcB
GuP6OA//WlniPB/zH7X7VeD7VFmCiy3NJmRg/9mK+2UgibuPClbMVtxVhT8ugfYA
ASh8H7YzCcD8lxTnTvWz4WPKRvjcImUlecdWkRRE7oiV7qI/TuhO2Khl+kEKzT2k
Q8QMWICutC5TT9sNDUcbIkqSrrcySo9c3dFUgDEEBYj8nDqSSPMH3Caz1BewRlPF
rY1uuF+HkeEV/y2qAPyXVfR50LfMvEuk/OKJOViPSlGXGMEMjK0yAcFsHntIwaHg
SXM0WP/JMTo2aa2X4wpOzYXVtSuFaSLtemY5Zuk287uBgX/1iH+MgotEuSXIXDS1
3bSNnUevIhxhQjZ6ElOGUKV6sBs/727ND1Cx9GpkZAFmtjxNVh9Q4IyMHTHyew0a
DJlZ1WIez2sWwWJ6LcIfZ0Mm+Uc5+iq1N11Iab11GFCOS/XlE602PdXq3Uh+2V1F
zFkzbVzUSEvnvCA4CgB3DyBYmNlQiq4e84q8r4f28NmtK2KmgGKO5xGHV6++Ad0G
Ea4IhmZlJ9Hz4YD88r246Cvzc+rFfr9AlfK9cLQgFMdlOwsXXgUTfqNsf2RW+dIr
0b2F/yJRmwxG/uP5vD38l5tUTk6kGfGzMy7zU6ZRZ+2jml7zl55572IMcvGxdRWZ
v2k3HXdPR0U0OOku6TWPmVZwDw6UEuMJf9wu0mU8qAIKvay05zw=
=GWmz
-----END PGP SIGNATURE-----

--GTdm2kIbdMeztoIc--
