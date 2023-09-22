Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1396F7AB5C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjIVQVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjIVQV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:21:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9BE1B7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:21:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C48C433C9;
        Fri, 22 Sep 2023 16:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695399679;
        bh=qVasgaeBqzB4fxo3zq3tOYMTMxTx+4Qfswcls+zc/QY=;
        h=Date:From:To:Cc:Subject:From;
        b=Rz+V7usszJHSYawlmqDwyYfvKI0WbuInJNKA0ceZ4O7Mv78Vw9CT4/WT0uhbJ+qEK
         mlQmYf3rOM/babY9K1l/st4ntDN05BTYe6myvArEiXefWi6C6KXTzwgG3kug+//dYC
         ti7KMOgJywRcJDUP15/VtqaRcduGtUM1KZF6dsyqJvtYhqFUuCPqp5ftgDKTikcd4z
         42owDroxW0JYtJENAQq/jgSu4WVLqt3LOABBS4GFzYZYRaMgKjH0NyQWNbTaXY0bJf
         8iTCzfBSzpf3AXWKsyiE0B2GR1ob6aaDepLQad6qqydCnejATW5B4+42OQ3BImh+hQ
         RyYVwDFcOGA4w==
Date:   Fri, 22 Sep 2023 17:21:14 +0100
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Fixes for 6.6-rc
Message-ID: <20230922162114.GC23332@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please can you pull these Arm SMMU fixes for 6.6 -rc? Usually, Arm SMMU
fixes can wait, but there are a couple of TLB issues affecting people
using SVA here, so I'd like to land this lot ASAP.

Cheers,

Will

--->8

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-fixes

for you to fetch changes up to d5afb4b47e13161b3f33904d45110f9e6463bad6:

  iommu/arm-smmu-v3: Fix soft lockup triggered by arm_smmu_mm_invalidate_range (2023-09-22 11:15:42 +0100)

----------------------------------------------------------------
Arm SMMU fixes for 6.6 -rc

- Fix TLB range command encoding when TTL, Num and Scale are all zero

- Fix soft lockup by limiting TLB invalidation ops issued by SVA

- Fix clocks description for SDM630 platform in arm-smmu DT binding

----------------------------------------------------------------
Konrad Dybcio (1):
      dt-bindings: arm-smmu: Fix SDM630 clocks description

Nicolin Chen (1):
      iommu/arm-smmu-v3: Fix soft lockup triggered by arm_smmu_mm_invalidate_range

Robin Murphy (1):
      iommu/arm-smmu-v3: Avoid constructing invalid range commands

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c       | 18 ++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c           | 15 ++++++++++-----
 3 files changed, 27 insertions(+), 8 deletions(-)
