Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CDC7C6EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378659AbjJLM5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347260AbjJLM5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:57:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F03BA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:57:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF889C433C8;
        Thu, 12 Oct 2023 12:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697115471;
        bh=Ok28SdhAWW1nvMtIM0V7FGuq4sgQwHbgRzFRQZos3eo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nwzo08fucF91DIEhvRvfXhMNnJ9L1KcNM2Ht+7wU+42fegJWJqnkRU9lBWCSRTUtJ
         iqHRhGvLvlzvJraz/+HnhcM6RSJ7mLvjtuWzt9BmSfLQMmEJeZrh2EGs+h7sP4FZgL
         mlaRa4DNCZucToVO1rNeGdGNMfahw/pE6xcXyGl3QvAG/Medx+PISc1PD1RAAewdiN
         CDTBYLArI7ySh6l4y0BNZelwyuFmAs8y72Jmf9hdBzaNN3+nnxc+m+6uWkgd5ieed9
         eVT08lDYcmKz67eeiSx36fYOAXfO4sfKQKkqccXaHxqC20M+O8Y/Go3Mo3lpYGtJUU
         UaO7HQpqymbRw==
Date:   Thu, 12 Oct 2023 13:57:46 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, iommu@lists.linux.dev, jgg@nvidia.com,
        baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/7] iommu: Clean up open-coded ownership checks
Message-ID: <20231012125746.GB12142@willie-the-truck>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <0d68867cec0fb90578d50cc145f7f9a180407f20.1697047261.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d68867cec0fb90578d50cc145f7f9a180407f20.1697047261.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 07:14:54PM +0100, Robin Murphy wrote:
> Some drivers already implement their own defence against the possibility
> of being given someone else's device. Since this is now taken care of by
> the core code (and via a slightly different path from the original
> fwspec-based idea), let's clean them up.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  3 ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  9 +--------
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 16 +++-------------
>  drivers/iommu/mtk_iommu.c                   |  7 +------
>  drivers/iommu/mtk_iommu_v1.c                |  3 ---
>  drivers/iommu/sprd-iommu.c                  |  8 +-------
>  drivers/iommu/virtio-iommu.c                |  3 ---
>  7 files changed, 6 insertions(+), 43 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
