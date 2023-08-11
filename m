Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFBC778E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbjHKLpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjHKLpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148D6FA;
        Fri, 11 Aug 2023 04:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 978E767064;
        Fri, 11 Aug 2023 11:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2C8C433C7;
        Fri, 11 Aug 2023 11:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691754305;
        bh=HgsOUOeNqsvIxm4oNsewNMVpaiOcHnB2xfANePA9Be0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UpfOv9qZlwxRn/qlxTzxcY/QgqJLAAKzicpbRq+yX1+NA+aCpIDWqDuqg6Zmkn01Y
         cTgqdOMsWSlYQzZD5dXSik6j0qRG8D7wdmIEGsLw1ZklsEBxYVtg/xjJ8y8u3Un6K7
         1ukyAuPWrj1puZsT5CxcYnGfKV2Rle/EerrVONdDOVHyMFRqF74qTie0Zm0eOasXvO
         cgwZVhCTBXhYyGxYZzCHw3YfhHkwrnIlC7XbyDzlz6szNRhyFxvlyBrjyxWFd9phxg
         hv3nbx6MZRlXXhl8OHcOGSPweVycxYDaofHEZsVfrRHzKvsezVnae4fqawg6J8ccyc
         F+1Y/ergM8A2A==
From:   Will Deacon <will@kernel.org>
To:     agross@kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        luca@z3ntu.xyz, conor+dt@kernel.org, robin.murphy@arm.com,
        robdclark@gmail.com, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@linaro.org, iommu@lists.linux.dev,
        kernel@collabora.com, andersson@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        joro@8bytes.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v5 0/6] Add support for Qualcomm's legacy IOMMU v2
Date:   Fri, 11 Aug 2023 12:44:51 +0100
Message-Id: <169158176438.300170.11135849217509321045.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230622092742.74819-1-angelogioacchino.delregno@collabora.com>
References: <20230622092742.74819-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 11:27:36 +0200, AngeloGioacchino Del Regno wrote:
> This series adds support for handling "v2" firmware's IOMMU, found
> on at least MSM8956 and MSM8976 (some other SoCs also need the same
> but I honestly don't remember which ones precisely).
> 
> This is strictly required to get functional IOMMUs on these SoCs.
> 
> I'm sorry for not performing a much needed schema conversion on
> qcom,iommu.txt, but I really didn't have time to do that :-(
> 
> [...]

Applied drivers updated to will (for-joerg/arm-smmu/updates), thanks!

[2/6] iommu/qcom: Use the asid read from device-tree if specified
      https://git.kernel.org/will/c/fcf226f1f708
[3/6] iommu/qcom: Disable and reset context bank before programming
      https://git.kernel.org/will/c/9f3fef23d9b5
[4/6] iommu/qcom: Index contexts by asid number to allow asid 0
      https://git.kernel.org/will/c/ec5601661bfc
[6/6] iommu/qcom: Add support for QSMMUv2 and QSMMU-500 secured contexts
      https://git.kernel.org/will/c/e30c960d3f44

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
