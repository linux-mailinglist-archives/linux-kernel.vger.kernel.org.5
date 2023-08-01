Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286CC76BEA0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjHAUmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHAUmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:42:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE862706;
        Tue,  1 Aug 2023 13:41:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50DFD616D4;
        Tue,  1 Aug 2023 20:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B228CC433C8;
        Tue,  1 Aug 2023 20:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690922512;
        bh=Ru+b3oEZPQazdmXzDRhzAlXaDh13Ys1hi6gQ2UgJgEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KrVAmGhpykx3UOI+aLOwipKXGDy/7xPxNoU0w1zrSKS5oYRg70zlHxY1m+2Pr9vm9
         HnlWgITb8lpMSeu4Aye8R+4CznA3cJR9f3DR7p1be9HX5uj6xXTmWxKtD8Km+VzRx5
         W3CTDr7IMFTHCSen7s1sdoBSWg5aMS4iz2D4dZFbpVeTJLWdjRaS51EHtunjyVeP/C
         Aonb7SmvFBx+V0JL3ySA5ohs4l/1vuNRK/mRSPLy82dY6HAK9i1B/hK9iV6K/T7RHR
         4eenXoeJJWDjOrWgK4HxBoca0gDyOWiB3st14eYU74iEfvCU7pCqf/M0le22xCWtbl
         ghYa+TlhDiWpA==
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>,
        Yangtao Li <frank.li@vivo.com>,
        Rob Clark <robdclark@gmail.com>, Joerg Roedel <joro@8bytes.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/6] iommu/arm-smmu: do some cleanup
Date:   Tue,  1 Aug 2023 21:41:46 +0100
Message-Id: <169089727545.1325205.14020331794830361964.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230705130416.46710-1-frank.li@vivo.com>
References: <20230705130416.46710-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2023 21:04:11 +0800, Yangtao Li wrote:
> Convert to use devm_platform_ioremap_resource() and fix return value
> when platform_get_irq fails.
> 
> 

Applied Arm SMMU patch to will (for-joerg/arm-smmu/updates), thanks!

[1/6] iommu/arm-smmu: Clean up resource handling during Qualcomm context probe 
      https://git.kernel.org/will/c/0a8c264d51ad

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
