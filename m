Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315777E390C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjKGKZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjKGKZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:25:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C667111A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:25:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9324BC433C8;
        Tue,  7 Nov 2023 10:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699352724;
        bh=BJYa7WwWYDL69BqG3PQQTMCd6K2zi9dVHj9I654KmmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=irR4zolsO5pqpVMR7T/OGz8JIEzjqy7/l6bKFeYZWEeovZ10siQeU5vk7ohwGOEaL
         S5sBBVp6TiyYQAc1k9jZTuctPrIvgU17UMPcPhg6L5zK5Zlj3AGpE6uXsrQnS41KR5
         W3i/XMA0gRZZX22niJPbPUAxMGmNGcU7kt4GN+amtJVSt40L/ozAjbOld6pxNWAY2V
         o/irCpUJHfxHFtxYHAHgzlNnfMmg4K8lZspHwUnONrKDrZ2YIvaf5SxOMRByUHD3GU
         Ok8YSGewLBEY3H0xwLW6EVvVoLeNutE6h7a8NkX/zKvVhvKJoda1Q0b2O5qzKynDUb
         IupOiwpsUiPMg==
Date:   Tue, 7 Nov 2023 10:25:19 +0000
From:   Will Deacon <will@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: list all Qualcomm IOMMU drivers in the
 QUALCOMM IOMMU entry
Message-ID: <20231107102519.GE18944@willie-the-truck>
References: <20231103225413.1479857-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103225413.1479857-1-dmitry.baryshkov@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 12:54:13AM +0200, Dmitry Baryshkov wrote:
> For historical reasons the 'QUALCOMM IOMMU' entry lists only one
> Qualcomm IOMMU driver. However there are also the historical MSM IOMMU
> driver, which is used for old 32-bit platforms, and the
> Qualcomm-specific customisations for the generic ARM SMMU driver. List
> all these files under the QUALCOMM IOMMU entry.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5a7dc3e56e1e..ed1c864794aa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17888,6 +17888,8 @@ L:	iommu@lists.linux.dev
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
>  F:	drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +F:	drivers/iommu/arm/arm-smmu/arm-smmu-qcom*
> +F:	drivers/iommu/msm_iommu*

Acked-by: Will Deacon <will@kernel.org>

Will
