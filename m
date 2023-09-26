Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162507AEF73
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbjIZPHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbjIZPH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:07:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BDB10E;
        Tue, 26 Sep 2023 08:07:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0919FC433CB;
        Tue, 26 Sep 2023 15:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695740841;
        bh=utr3s0fcBZor2mmaSb4QCUFmubnfG2v96GrxEnd9zyY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qP2xjaVabQ72EiPfkWl4nZUd1ArM3pwru0fvtQM1Ee/0GwZhQ5IhYQavjBfQNpOYt
         PDyAjDd1yBBMjqb/8n14TwkUhMVZr21AgeQwjVrBbyIuuulB9bpUi9cf9YL/nE4FeX
         3wzD2H3VxuKWWtxuEtkg33Yua5zU4I4Kix1CRtu604NR/hZgPfbT/xa3A18/5T3ZRm
         p3Y/rmqg4ujVmbqw6F3UglGoqAHM3PdZM28Lvy1dyDzMlQGkXuU6tyFN/X1i+VpUBo
         xuustMpS5sv/7P4x57EkMEWSrXMWkItlJ8smbUW7XwEp8989h+kmfOTNJJI5pAV3PP
         ThgBKg1GqTvVg==
From:   Mark Brown <broonie@kernel.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20230926130926.314751-1-d-gole@ti.com>
References: <20230926130926.314751-1-d-gole@ti.com>
Subject: Re: [PATCH V3] spi: spi-cadence-quadspi: Fix missing unwind goto
 warnings
Message-Id: <169574083974.2649563.4476641080804661499.b4-ty@kernel.org>
Date:   Tue, 26 Sep 2023 17:07:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2023 18:39:27 +0530, Dhruva Gole wrote:
> The following smatch warnings were recently introduced:
> 
> drivers/spi/spi-cadence-quadspi.c:1882 cqspi_probe() warn: missing
> unwind goto?
> 
> Fix these warnings by releasing dma channel and adding a goto fail probe.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cadence-quadspi: Fix missing unwind goto warnings
      commit: 86401132d7bbb550d80df0959ad9fa356ebc168d

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

