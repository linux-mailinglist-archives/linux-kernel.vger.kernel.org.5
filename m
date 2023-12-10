Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958B780BD4C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 22:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjLJVLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 16:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjLJVK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 16:10:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBC9DB
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 13:11:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A29C433C8;
        Sun, 10 Dec 2023 21:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702242665;
        bh=sZzRKked3xzptSRcvGavSHnu3Ea2iAGznJRk26/aisA=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=psVGIfGKE7xcK5fz2EYbnxEbzRLbw27mCwwYYD8VHyMEVImoE+VK9fBCa4IHx96Fn
         iirLi5y+9aoX5he6RwF7HxipvkkbNPb6VeSFaVrec1aTY9SShRkyECd13uXslHbNLE
         dzk83nSDz/+Rzx2nigbcQncdQkLxs0fn6GNsj2LHDH8TVOropyNJXLMFoVAX4E7vEF
         5fE2NOD4badSy9lElwBE8Oh7ZbCpg6l/EZ/g+T21WSOiqW6QW5K8nFzcEqL0k7/WcA
         WrghPA7N8iR1KHOsG/FO6zqS2O6BLBefRZDGTLufPEjFzF3uy3sacqBbyTaK5zi0sa
         hLHU/VZLM1qUA==
From:   Mark Brown <broonie@kernel.org>
To:     linux@bigler.io, francesco@dolcini.it,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        regressions@lists.linux.dev, stefan.moring@technolution.nl,
        regressions@leemhuis.info, Benjamin Bigler <benjamin@bigler.one>
In-Reply-To: <20231209222338.5564-1-benjamin@bigler.one>
References: <20231209222338.5564-1-benjamin@bigler.one>
Subject: Re: [PATCH] spi: spi-imx: correctly configure burst length when
 using dma
Message-Id: <170224266337.2977325.7724283128894856611.b4-ty@kernel.org>
Date:   Sun, 10 Dec 2023 21:11:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Dec 2023 23:23:26 +0100, Benjamin Bigler wrote:
> If DMA is used, burst length should be set to the bus width of the DMA.
> Otherwise, the SPI hardware will transmit/receive one word per DMA
> request.
> Since this issue affects both transmission and reception, it cannot be
> detected with a loopback test.
> Replace magic numbers 512 and 0xfff with MX51_ECSPI_CTRL_MAX_BURST.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-imx: correctly configure burst length when using dma
      commit: e9b220aeacf109684cce36a94fc24ed37be92b05

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

