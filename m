Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715267653B6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjG0MYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjG0MXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:23:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E62A3A8B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:23:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1026F61E64
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833F4C433C9;
        Thu, 27 Jul 2023 12:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690460591;
        bh=Xs/kY9pi9DmZWdHXhHYncBqyBCjrK7p7Dd+vVzs/YEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qZIX9J8yK5jx4FyjpuowmnM3ALhzomOtbj7/7i36RI8qCNnmY8A0NcS2L96qX7xNI
         evaHEFDrx8cO07aeAIoonFfYsGMvSojvYHLb69y82S1SF9BFLyqGfJr60ZZT6UybZH
         1HFNOdORdYKy2sB9BB7R2k+GgTtvYz93Pow/6ITSdQF8NoyFxBoFtmNi4dKmfvzJQh
         DmZkYeLEnI/5Jbzx6DtL6OqIAPZxPFOfzlsbe7qxvk1w8NpG1id1njCJNt/MxSg2lr
         3iM/K8M3y+LfpoF1DNmjnV99xNUeQuIBdnjNJsZFzi+/tXToFalCyuj1WL+D1NAhso
         cRE/3+5QdY1Vg==
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@axis.com, robin.murphy@arm.com, jkchen@linux.alibaba.com,
        jean-philippe@linaro.org
Subject: Re: [PATCH] perf/smmuv3: Remove build dependency on ACPI
Date:   Thu, 27 Jul 2023 13:22:37 +0100
Message-Id: <169045924993.3247753.6922281332114900821.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230706-smmuv3-pmu-noacpi-v1-1-7083ef189158@axis.com>
References: <20230706-smmuv3-pmu-noacpi-v1-1-7083ef189158@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2023 11:23:05 +0200, Vincent Whitchurch wrote:
> This driver supports working without ACPI since commit 3f7be43561766
> ("perf/smmuv3: Add devicetree support"), so remove the build dependency.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf/smmuv3: Remove build dependency on ACPI
      https://git.kernel.org/will/c/7c3f204e544d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
