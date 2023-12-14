Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A357812D3D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443714AbjLNKn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443641AbjLNKn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:43:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E44FBD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:43:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89274C433C8;
        Thu, 14 Dec 2023 10:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702550612;
        bh=0bR4DQSOTx7dFp+Uy7dGDy1FL138/1iTrRlHcJbU9BQ=;
        h=Date:From:To:Cc:Subject:From;
        b=FL55BBnEcotWFkU1OW9srDH2/9JP+OOG0ygqlG6GnwpV6yoBntCqZ4dx34HEIPOo2
         0FYDG0duDbLLygjUiAkkh2aYrlLSS3OiooTrAQuxpsQdsq8tMzxCSj3r6vNp7R5SON
         5oIOUbXVzFzEXH6LkCqthBgc1RvkMxunN+0pSomKgITYqOINduLcgnXwJHOFGhpe3J
         xQYZC8iKWOp7b+6n8C42+Kzrm8t5NXVhd7k28L2UtlfydLNOEdP+mKCbLsP/PMEw0q
         1WNkRQYh8j6EhBmzfxXPEHRfatWBpt/sRyi45RlQhcnEwi51zw6I3tn5fgjolu32Il
         A+zjkKmMj/FYw==
Date:   Thu, 14 Dec 2023 10:43:28 +0000
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 6.8
Message-ID: <20231214104327.GA924@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please pull these Arm SMMU updates for 6.8 ahead of the Christmas break.
I'll be disappearing shortly, but I'll keep half an eye on the list in
case any issues crop up.

There's the usual summary of changes in the tag.

Cheers,

Will

--->8

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to 1343121f08e6df62b14e6c0a8c193256ac225b0c:

  Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates (2023-12-13 15:53:02 +0000)

----------------------------------------------------------------
Arm SMMU updates for 6.8

- Device-tree binding updates:
  * Add additional compatible strings for Qualcomm SoCs
  * Document Adreno clocks for Qualcomm's SM8350 SoC

- SMMUv2:
  * Implement support for the ->domain_alloc_paging() callback
  * Ensure Secure context is restored following suspend of Qualcomm SMMU
    implementation

- SMMUv3:
  * Disable stalling mode for the "quiet" context descriptor
  * Minor refactoring and driver cleanups

----------------------------------------------------------------
Jason Gunthorpe (8):
      iommu/arm-smmu-v3: Add a type for the STE
      iommu/arm-smmu-v3: Master cannot be NULL in arm_smmu_write_strtab_ent()
      iommu/arm-smmu-v3: Remove ARM_SMMU_DOMAIN_NESTED
      iommu/arm-smmu: Reorganize arm_smmu_domain_add_master()
      iommu/arm-smmu: Convert to a global static identity domain
      iommu/arm-smmu: Implement IOMMU_DOMAIN_BLOCKED
      iommu/arm-smmu: Pass arm_smmu_domain to internal functions
      iommu/arm-smmu: Convert to domain_alloc_paging()

Konrad Dybcio (2):
      dt-bindings: arm-smmu: Document SM8[45]50 GPU SMMU
      iommu/arm-smmu-qcom: Add QCM2290 MDSS compatible

Krzysztof Kozlowski (1):
      dt-bindings: iommu: arm,smmu: document clocks for the SM8350 GPU SMMU

Neil Armstrong (1):
      dt-bindings: iommu: arm,smmu: document the SM8650 System MMU

Rajendra Nayak (1):
      dt-bindings: arm-smmu: Add compatible for X1E80100 SoC

Rob Clark (1):
      iommu/arm-smmu-qcom: Add missing GMU entry to match table

Vladimir Lypak (1):
      iommu/qcom: restore IOMMU state if needed

Wenkai Lin (1):
      iommu/arm-smmu-v3: disable stall for quiet_cd

Will Deacon (1):
      Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates

 .../devicetree/bindings/iommu/arm,smmu.yaml        |  77 ++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  75 +++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |   8 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   2 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c              | 153 ++++++++++++++-------
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |   1 -
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |  10 +-
 7 files changed, 226 insertions(+), 100 deletions(-)
