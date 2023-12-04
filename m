Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE083803E67
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjLDTaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjLDTaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:30:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CEEE6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:30:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41C4C433C8;
        Mon,  4 Dec 2023 19:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701718225;
        bh=Xc/MU6W/EB84lggpE5Bjsxpht9lSHmzC1hC1M4lx884=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EIrkIvfJx7lLroPkfiSuyIr8ejNpLxRnXsF1yGkl2Ky4cpWXvctPtw5qtC8x/tGBU
         X1cTT47I6wpCUUXgc1QA2SwXe23rgU2OFeACkr0kP+6AN/4K426O26H9ylO5kUnSBa
         9ZVnY2WFpD3x7ZE6SG3uGEkx/4scop4w7MNQ5ecCx1qsRbCqeV9PLi5MUKxKvp2Nv6
         yzTLdNnKS8noBJ1k/YEwQehbTEzrRH1AzzVAwWqMmcoDu5+M77rvWo6j9Ej13HaadR
         hPH2tl7zbQwUTIWXYcwhEy+gmmwAe5H/olgiVQRrxJQTdIo/5T0D6m3Ceiclh8Gkve
         I4HmfmbAMP2dg==
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231204033549.2020289-1-wenst@chromium.org>
References: <20231204033549.2020289-1-wenst@chromium.org>
Subject: Re: [PATCH] ASoC: SOF: Move sof_of_machine_select() to core.c from
 sof-of-dev.c
Message-Id: <170171822243.157597.14987594819577549531.b4-ty@kernel.org>
Date:   Mon, 04 Dec 2023 19:30:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Dec 2023 11:35:47 +0800, Chen-Yu Tsai wrote:
> This reverts commit 014fdeb0d747304111cfecf93df4407c1a0c80db.
> 
> Commit 014fdeb0d747 ("ASoC: SOF: Move sof_of_machine_select() to
> sof-of-dev.c from sof-audio.c") caused a circular dependency between
> the snd_sof and snd_sof_of modules:
> 
> 	depmod: ERROR: Cycle detected: snd_sof -> snd_sof_of -> snd_sof
> 	depmod: ERROR: Found 2 modules in dependency cycles!
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Move sof_of_machine_select() to core.c from sof-of-dev.c
      commit: d0ae9dc48e24f5f704abcbb2dca3e4651bf0ff59

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

