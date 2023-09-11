Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFFC79B72B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377413AbjIKWVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241406AbjIKPHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:07:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AFBFA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:07:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F88DC433C7;
        Mon, 11 Sep 2023 15:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694444870;
        bh=6qVJgXOyGrRy3MsXv00ledjxzgW4K3II5wnwOCy951o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GbJIh77cjpriu2wTdMDc3Xss54QbSEvxn48e6G8mddD7/ztnLImVbspXJX7rinsPO
         DKDj6Zb08Dl9gbkNZ8lqLSCJpC4HI23qt0+hDZzP/+91RGtBUeXal/+bswsKswLv3d
         Cw4Gs4AV16GHA0MZk6YFKa0FREh2REFPNRyWD+HHRVpAbUvZ46vvzYt5f9kAM6Zj7O
         KlwU3ufTKnKGomGI2I8/5qO+m6qwFracY69AWM/XTQg9w/QnLJN0YnicVWtaljmsMN
         09d2GCtMnQYInTjc/kbIzrTHH8OaRL7qbYs2SOaHIOvBDAAr04mnyyejzNoBrqm/gc
         TBiC0mXbH+Pbg==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230908101716.2658582-1-rf@opensource.cirrus.com>
References: <20230908101716.2658582-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Call pm_runtime_dont_use_autosuspend()
Message-Id: <169444486689.1851820.7894318882943305777.b4-ty@kernel.org>
Date:   Mon, 11 Sep 2023 16:07:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Sep 2023 11:17:16 +0100, Richard Fitzgerald wrote:
> Driver remove() must call pm_runtime_dont_use_autosuspend().
> 
> Drivers that call pm_runtime_use_autosuspend() must disable
> it in driver remove(). Unfortunately until recently this was
> only mentioned in 1 line in a 900+ line document so most
> people hadn't noticed this. It has only recently been added
> to the kerneldoc of pm_runtime_use_autosuspend().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Call pm_runtime_dont_use_autosuspend()
      commit: ec03804552e9a723569e14d2512f36a8e70dc640

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

