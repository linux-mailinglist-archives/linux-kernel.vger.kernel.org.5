Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F97D80F463
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376512AbjLLRVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376396AbjLLRV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:21:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048B5B7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:21:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8F4C433C9;
        Tue, 12 Dec 2023 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702401694;
        bh=ax1TJ8fcxuZhrG1GseVHnGGDWIWrJDvPmtLFkog0odM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qlNhbvWP0Dv5mgbzBG7ZiT/08F9m3fxzXLqsIJwvBHh+I9EfBGC7CZyz0H1dH6ZPt
         yGUHEwpENHdLF/PI7uaBOGFNzy9L1mq7dJaiPxb3X70KtJkH4F2PDGa1T3dO1fza4c
         CSZBXnVoInqWfDZ8XO30aei/keTJw4WQG52z/frNW6wIxR3dS9Z1XEz9cp9qZpSllk
         JiIKSjJDWurE5bIllI9w/QthMu4pvIuNQL05oJtpNTM0kcKwBmfs5FNEn/2JoKvek+
         gunH2c04ObuoBSXHTZQfvFkaNUtW3G36e6AW49Je/eL6f7cAIUkiV0YJAYscstlYw6
         f6c3AbTIg+2IQ==
From:   Will Deacon <will@kernel.org>
To:     ~postmarketos/upstreaming@lists.sr.ht,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Clark <robdclark@gmail.com>, phone-devel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>, Luca Weiss <luca@z3ntu.xyz>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/qcom: restore IOMMU state if needed
Date:   Tue, 12 Dec 2023 17:20:57 +0000
Message-Id: <170238443082.3098533.11843607939616442768.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231011-msm8953-iommu-restore-v1-1-48a0c93809a2@z3ntu.xyz>
References: <20231011-msm8953-iommu-restore-v1-1-48a0c93809a2@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 19:57:26 +0200, Luca Weiss wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> If the IOMMU has a power domain then some state will be lost in
> qcom_iommu_suspend and TZ will reset device if we don't call
> qcom_scm_restore_sec_cfg before accessing it again.
> 
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/qcom: restore IOMMU state if needed
      https://git.kernel.org/will/c/268dd4edb748

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
