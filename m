Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23AC7BE719
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377747AbjJIQ47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377354AbjJIQ4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:56:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E1092;
        Mon,  9 Oct 2023 09:56:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B84C433CD;
        Mon,  9 Oct 2023 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696870612;
        bh=Hdjk/mLpVxOFDBbGoraaYS6eaQ1jLpNcRKBsyVJpqnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BNxDe1LjMfXyM1GIbnmlffuJcxkKOhIvgyjkWtlGQsoxsVj84JCUUHqNfadc8WJCs
         5Z3rN9wuw8K9bs51iXdRLsi5DjJMf5rW/BQWyyfmeheCyzXTJIzAgJdNahfEhWX0Rn
         xuZ4fl2QnMN7b6hvAx9CtKGxb6q8KK3FeCzem5aWYZPYUrTrgy8q2zrOdZ9vx9Bikb
         va0cXT8amucMTvSLarCOzCBHEAjICScyIBSLR2N/wcTQty1kH/HuSh8UYIGXQhPrzs
         ujbR1EIqXWV6iTs4PSyycZAFA8VFUngVHpdjJrG216RAo8y5Qw41PmdxjKresw4ILB
         7biu2nhYfg39g==
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/4] perf: arm_cspmu: ampere: Add support for Ampere SoC PMUs
Date:   Mon,  9 Oct 2023 17:56:43 +0100
Message-Id: <169651196560.2091238.5548101800453839353.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230913233941.9814-1-ilkka@os.amperecomputing.com>
References: <20230913233941.9814-1-ilkka@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 16:39:37 -0700, Ilkka Koskinen wrote:
> Changes since v6:
>     * Rebased on top of Besar's updated patch
> 
>       [PATCH v6] perf: arm_cspmu: Separate Arm and vendor module
>       https://lore.kernel.org/all/20230821231608.50911-1-bwicaksono@nvidia.com/
> 
>     * Changed Ampere specific module to use ida/ida_alloc() instead of idr/idr_alloc()
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/4] perf: arm_cspmu: Split 64-bit write to 32-bit writes
      https://git.kernel.org/will/c/8c282414ca62
[2/4] perf: arm_cspmu: Support implementation specific filters
      https://git.kernel.org/will/c/0a7603ab242e
[3/4] perf: arm_cspmu: Support implementation specific validation
      https://git.kernel.org/will/c/647d5c5a9e76
[4/4] perf: arm_cspmu: ampere_cspmu: Add support for Ampere SoC PMU
      https://git.kernel.org/will/c/290a9c0e55f8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
