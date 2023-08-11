Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5C8778E14
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbjHKLpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbjHKLpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:45:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8435FB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:45:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67A5E6709E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CC2C433C9;
        Fri, 11 Aug 2023 11:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691754311;
        bh=B7VW0vp9hivzH9fIya7tAIlQ7u7zBXplJceKTWYJHVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CFOkuGxf6SqQWbZ1BFWWITBVo3AOyUiQiQ/2ZCrWlCA0xhpt6RKa4BruiboIRC64/
         hScNBXp4o0OB1WW2B59q+jmnJs1gjh8ZTxZ49+GwUrgc4D0YeZvlLCJGblZTo3pI71
         YFe2YGuFnQppWOkltZyhQquaWx1pRrW5rasoyG7tohKK8Q/DQFNDh0XXOP0uWwcIfy
         wrQYTZYk0jVmD9lqpQmQFnUhTx1+Uwqg5c7XYdU53waOPNltTr1bEsS1ywM4qLzMbG
         HPRJBJCzXSBo/S90UYaSzQZ/VGY59H9xbMaoS3tVWHFT7/IRNw8eb5BJ1otI3l7bSB
         UkUDId7gblqhw==
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] arm-smmu: pick up lost qcom impl compatibles
Date:   Fri, 11 Aug 2023 12:44:54 +0100
Message-Id: <169175369837.3926405.1362817144660675229.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230810-topic-lost_smmu_compats-v1-0-64a0d8749404@linaro.org>
References: <20230810-topic-lost_smmu_compats-v1-0-64a0d8749404@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 19:45:03 +0200, Konrad Dybcio wrote:
> I noticed that some of the compatibles for either matching SMMU probe
> or peripheral workarounds were lingering on my branch.
> 
> This series collects them in an effort to get them merged.
> 
> The bindings are all there.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/4] iommu/arm-smmu-qcom: Sort the compatible list alphabetically
      https://git.kernel.org/will/c/ec2ff4d8160f
[2/4] iommu/arm-smmu-qcom: Add SM6375 DPU compatible
      https://git.kernel.org/will/c/6ebaa77ce483
[3/4] iommu/arm-smmu-qcom: Add SM6350 DPU compatible
      https://git.kernel.org/will/c/7e85676a4523
[4/4] iommu/arm-smmu-qcom: Add SM6375 SMMUv2
      https://git.kernel.org/will/c/757d591d965f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
