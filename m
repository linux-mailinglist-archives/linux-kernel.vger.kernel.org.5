Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C0177CD8D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbjHONv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbjHONvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:51:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E623110
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 06:51:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D076562BA2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064C9C433C7;
        Tue, 15 Aug 2023 13:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692107511;
        bh=r827jwAp21ZRUwQeZcKwhmpfW5k9rN/IDbA3BannpGc=;
        h=Date:From:To:Cc:Subject:From;
        b=ZOwPYxVBVxliuT7nfRcyXja+W7OGtabY8D6GdWFCDmW/cWwYiye+n4uwrofCUBtGB
         X23nIJ52ZE79EpJDqbbNDX/mN/b5y2O//ModtGYyB67uL8Ady61iGK7x6L37USp8eT
         AET9a+36XU0qmpFiHbal7UmSwEyhxZO12IW9eYME75EFlh4fLw5F/PGfCG7WF6DVc1
         3fQr+FCy7IRw1V/hu8Dhn79dFAFFxdjqCeTu4UQFkkhWO6U1PliNOtxeftwxZsOkSq
         5HMEJ5aDoBQRDnxvdyDhyTy9gPE4nzCIkXFlaWgkdzOlQQxlYLiRLmaAfsy2FAmzLv
         ka/somO946cTQ==
Date:   Tue, 15 Aug 2023 14:51:46 +0100
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 6.6
Message-ID: <20230815135145.GA12068@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please pull these Arm SMMU updates for 6.6. It's almost exclusively
Qualcomm-related SMMUv2 changes but there are some SMMUv3 changes in the
pipeline for next time.

Summary in the tag.

Cheers,

Will

--->8

The following changes since commit 6eaae198076080886b9e7d57f4ae06fa782f90ef:

  Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to afe92fbfbfb7efb77b9525dbae3453c8f63e6b60:

  Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates (2023-08-15 11:34:47 +0100)

----------------------------------------------------------------
Qualc^WArm SMMU updates for 6.6

- Device-tree binding updates:
  * Add additional compatible strings for Qualcomm SoCs
  * Allow ASIDs to be configured in the DT to work around Qualcomm's
    broken hypervisor
  * Fix clocks for Qualcomm's MSM8998 SoC

- SMMUv2:
  * Support for Qualcomm's legacy firmware implementation featured on
    at least MSM8956 and MSM8976.
  * Match compatible strings for Qualcomm SM6350 and SM6375 SoC variants

- SMMUv3:
  * Use 'ida' instead of a bitmap for VMID allocation

----------------------------------------------------------------
AngeloGioacchino Del Regno (6):
      dt-bindings: iommu: qcom,iommu: Add qcom,ctx-asid property
      dt-bindings: iommu: qcom,iommu: Add QSMMUv2 and MSM8976 compatibles
      iommu/qcom: Use the asid read from device-tree if specified
      iommu/qcom: Disable and reset context bank before programming
      iommu/qcom: Index contexts by asid number to allow asid 0
      iommu/qcom: Add support for QSMMUv2 and QSMMU-500 secured contexts

Dawei Li (1):
      iommu/arm-smmu-v3: Change vmid alloc strategy from bitmap to ida

Konrad Dybcio (5):
      dt-bindings: arm-smmu: Fix MSM8998 clocks description
      iommu/arm-smmu-qcom: Sort the compatible list alphabetically
      iommu/arm-smmu-qcom: Add SM6375 DPU compatible
      iommu/arm-smmu-qcom: Add SM6350 DPU compatible
      iommu/arm-smmu-qcom: Add SM6375 SMMUv2

Will Deacon (1):
      Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates

Yangtao Li (1):
      iommu/arm-smmu: Clean up resource handling during Qualcomm context probe

 .../devicetree/bindings/iommu/arm,smmu.yaml        | 41 +++++++++++++
 .../devicetree/bindings/iommu/qcom,iommu.yaml      | 22 +++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 29 +++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  7 ++-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            | 68 ++++++++++++++++------
 6 files changed, 120 insertions(+), 49 deletions(-)
