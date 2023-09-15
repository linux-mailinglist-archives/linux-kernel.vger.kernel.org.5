Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BB07A2359
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbjIOQOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbjIOQNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:13:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0654B19A0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:13:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726DEC433C8;
        Fri, 15 Sep 2023 16:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694794412;
        bh=iNKMq8pQmi1xurRTgo9Yv30Q912F1svy9/M2MmUxALg=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=B0CxjdTmKQ3QyOnISup33+DTuKAuN7MOookDWNbwjVRVmOgorLjl6x+gzqYLRqXDS
         ko4kjD3Y+1rkBa5dlqyMQq/WIf0OAbx91itA8T5pw8B+lpwydmgXJNfc3LpQyXJhQE
         fMgPe7BlStiajx885jBtB0IjwLflfHCsH6Wxe5WUoj/8EgxjYY4Tzm9SMG0YZCKX16
         hGDc9dlE7mBiEuQHM3P1v73RPWmkRK8s/LVTwGF0R10gQl935X6ijsunkeK561BA9g
         xhveRZFOnKWYSNn2bOaHZw8zBLU0lWswGHDgKWGC35lezyqDmSeJ998M58f8JkrTF3
         NMY27gWpd9RJw==
From:   Mark Brown <broonie@kernel.org>
To:     shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1694757731-18308-1-git-send-email-shengjiu.wang@nxp.com>
References: <1694757731-18308-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: imx-audmix: Fix return error with devm_clk_get()
Message-Id: <169479441018.352295.3740215215305425642.b4-ty@kernel.org>
Date:   Fri, 15 Sep 2023 17:13:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 14:02:11 +0800, Shengjiu Wang wrote:
> The devm_clk_get() can return -EPROBE_DEFER error,
> modify the error code to be -EINVAL is not correct, which
> cause the -EPROBE_DEFER error is not correctly handled.
> 
> This patch is to fix the return error code.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-audmix: Fix return error with devm_clk_get()
      commit: b19a5733de255cabba5feecabf6e900638b582d1

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

