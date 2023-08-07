Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9035772557
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjHGNTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjHGNTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:19:23 -0400
X-Greylist: delayed 598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Aug 2023 06:19:22 PDT
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45243CF;
        Mon,  7 Aug 2023 06:19:22 -0700 (PDT)
Received: from 8bytes.org (pd9fe94eb.dip0.t-ipconnect.de [217.254.148.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id CB3112802C0;
        Mon,  7 Aug 2023 15:00:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1691413215;
        bh=7JkbUbcsQYDUm7+d1Qwf9eXdnSaQOoOuTXAnXPF6eXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JPMPMNcXrYSDEc82SoNmtOqraBcGews6IPyM7KqoT53fWXP892yQrt6FntitNudOw
         aIZudgFHjcWlsw8HCeSgY9qxqkdFRAgpuvTl753O1uV1Sp4cNTC71xOxvpmfH50yb7
         0rsRVjsm3j1M2pQRDzFnq1Sq/Ez4f8w+eOaD5QrOdnAh0QTwXHdo3dFg68vtgetqmo
         PraCiPeh53gllj0O0TljM9b6kC4EiPum0LZGv+qgFvl6qajCl0Eo5b1J9EzUkGrqRr
         TvO9A7Nez2tJI3c5SbUT2557k5CxQlNq7XH7JrP7+PVM/M8cCYN9APgtwcNs9SN6ZH
         LeUd395XfXWrQ==
Date:   Mon, 7 Aug 2023 15:00:13 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Rob Clark <robdclark@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] iommu: Explicitly include correct DT includes
Message-ID: <ZNDq3da76i13WuqA@8bytes.org>
References: <20230714174640.4058404-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714174640.4058404-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 11:46:39AM -0600, Rob Herring wrote:
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c | 2 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c            | 1 -
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c          | 3 +--
>  drivers/iommu/ipmmu-vmsa.c                       | 1 -
>  drivers/iommu/sprd-iommu.c                       | 1 +
>  drivers/iommu/tegra-smmu.c                       | 2 +-
>  drivers/iommu/virtio-iommu.c                     | 2 +-
>  7 files changed, 5 insertions(+), 7 deletions(-)

Applied, thanks.
