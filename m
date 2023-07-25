Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6A9762363
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjGYUgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGYUgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:36:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4287910F7;
        Tue, 25 Jul 2023 13:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7DF1618E6;
        Tue, 25 Jul 2023 20:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E588C433C7;
        Tue, 25 Jul 2023 20:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690317365;
        bh=1WJsY6Fxk5xmArM3laXI1PCdA9a886qjCfbmt+ZVyyU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VqyStHAFMnUrprjRv35DS+uFXeG+gFpuZOWQdNng/kOiXg70JjB4ON3htuYfUOH3A
         yqF0dbOi7V+HNHoN1gwYpimZ9mAIs+PWwIFDVPTzweN12pfyBDzoJH01exIKVJRQWd
         UALFhYuZwor7CTdpigNZkXpDOiEUAwnHrit7dNsD3clAq7tUW7+kPb8pNaKm9WIOBR
         KKrx++EqECbVYkb8BRN/3+ZUf/YCOjxjoDPapbqqSqYGCXXA/RN5ct5jj8Hi5tmgUd
         K/KokBnm4R2mmbmu7Fz+dGv0dhItGmT1tZYmHGvhSK14ftvA8wuvcF6+a88ZTOdXIR
         LL+xvxFwOSX1Q==
From:   Mark Brown <broonie@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com,
        dan.carpenter@linaro.org
In-Reply-To: <1690285689-30233-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1690285689-30233-1-git-send-email-quic_vnivarth@quicinc.com>
Subject: Re: [PATCH 0/4] spi: spi-qcom-qspi: Follow-up patches to DMA mode
 support
Message-Id: <169031736194.1617289.5213259488916570827.b4-ty@kernel.org>
Date:   Tue, 25 Jul 2023 21:36:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 17:18:05 +0530, Vijaya Krishna Nivarthi wrote:
> This patch series adds 4 follow-up changes to DMA mode support.
> 1. Handles write failure in some cases by averting a race condition
> 2. Handles static checker warning
> 3. Adds a memory barrier to avoid a possible data out of sync case
> 4. Book keeping change
> 
> Vijaya Krishna Nivarthi (4):
>   spi: spi-qcom-qspi: Ignore disabled interrupts' status in isr
>   spi: spi-qcom-qspi: Use GFP_ATOMIC flag while allocating for
>     descriptor
>   spi: spi-qcom-qspi: Call dma_wmb() after setting up descriptors
>   spi: spi-qcom-qspi: Add DMA_CHAIN_DONE to ALL_IRQS
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: spi-qcom-qspi: Ignore disabled interrupts' status in isr
      commit: 17aaf9ea07b656016316dc37716e987742b3e296
[2/4] spi: spi-qcom-qspi: Use GFP_ATOMIC flag while allocating for descriptor
      commit: f7ba36d399c4558f36886adff9400be591b245f6
[3/4] spi: spi-qcom-qspi: Call dma_wmb() after setting up descriptors
      commit: cfb81f2243b25a0d79accc6510ad66c5c5ad99ba
[4/4] spi: spi-qcom-qspi: Add DMA_CHAIN_DONE to ALL_IRQS
      commit: 916a4edf3daed845b1e5d6cf0578a7e43c6f520e

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

