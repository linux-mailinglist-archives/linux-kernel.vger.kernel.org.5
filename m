Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0957C7D3CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjJWRAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjJWRAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:00:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4746710B;
        Mon, 23 Oct 2023 10:00:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96B8C433C7;
        Mon, 23 Oct 2023 17:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698080446;
        bh=dGQNiqbY/iChMEghTJj2HaVYSA3dF9/FCpyJWP5llMQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AXSQP2rWFcaGGxor3TGs0db9DDdPitAb3bIB3LejK4tW4Tg+n1Evq3sIKoIxnbr7X
         KYAguzMz6YMexAo4/DVL35yIGgn92zFapp3RrNSuQPNyvPhwY40Uc/7FjsPV+eB/O3
         2Sw9oexuXCrNwDBqiBI7CEmEGCt+Onie0kOyaS3agaJP1Xd3gRF3NLLQaUh89/BiHy
         4tVFZRdlNy+4RahsMo0/DAEtpJU0hPnqxXb1sY5Pg2nZSauCQ0L2FBCCwqz569G9v1
         44PtpTNyCDL45tuKwonkl+8gdp6A+zNqgZGx3jNCJNYMkkzY1rsKgeTAaE6IXtQmSQ
         NPcCoK5bxbLkQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Vaishnav Achath <vaishnav.a@ti.com>
Cc:     linux-kernel@vger.kernel.org, vigneshr@ti.com, u-kumar1@ti.com
In-Reply-To: <20231013092629.19005-1-vaishnav.a@ti.com>
References: <20231013092629.19005-1-vaishnav.a@ti.com>
Subject: Re: [PATCH] spi: omap2-mcspi: Add FIFO support without DMA
Message-Id: <169808044553.106790.13764147935962474573.b4-ty@kernel.org>
Date:   Mon, 23 Oct 2023 18:00:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 14:56:29 +0530, Vaishnav Achath wrote:
> Currently, the built-in 64-byte FIFO on the MCSPI controller is not
> enabled in PIO mode and is used only when DMA is enabled. Enable the
> FIFO in PIO mode by default for transactions larger than the FIFO depth
> and fallback only if FIFO is not available. When DMA is not enabled,
> it is efficient to enable the RX FIFO almost full and TX FIFO almost
> empty events after each FIFO fill instead of each word.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: omap2-mcspi: Add FIFO support without DMA
      commit: 75223bbea840e125359fc63942b5f93462b474c6

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

