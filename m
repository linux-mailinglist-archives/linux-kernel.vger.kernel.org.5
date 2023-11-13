Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6AC7E9E07
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjKMOFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjKMOFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:05:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F1BD5F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:05:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D701CC433C9;
        Mon, 13 Nov 2023 14:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699884320;
        bh=YQBSCiuVG1G3ja5F8I/phUL/rwuMuLhVTQF0gNoNEp8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZDwjV/RrWNJ96dUNTh5ogzEl26dd/RehrQ05sq1zF0hwrmc9J5uAMOv7hjyO6fAZA
         veO4b+u8bS3IzIs0ESl0VzX7iLcb69cY2MXRIXlL605zMvumOgby8LvRi2GfRywaZi
         AaDNWSKvwVtFMLwg0FLEqy59SYXovPTz/lH3hZRtN5p/PgM4Q88SWKwcqziynUZAyH
         i5rElHjVGoWGihhguQnd9CRpDJ2BhVwYq8ypdogRD8W583wI5Q6zgVXFqd9x2gbcLI
         PmXHOOuMoJQmfbjSmU1n2k5go6LGhIUcSgeHED17D79UzPMrOdWAFrAlDx5ouKzp2W
         Ryr+lPOGcZkSQ==
From:   Mark Brown <broonie@kernel.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Keguang Zhang <keguang.zhang@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231106-sti-uniperf-v1-1-b2d8749cfa2e@gmail.com>
References: <20231106-sti-uniperf-v1-1-b2d8749cfa2e@gmail.com>
Subject: Re: [PATCH] ASoC: sti-uniperf: Use default pcm_config instead
Message-Id: <169988431826.3280890.10728149969647169185.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 14:05:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2023 20:51:03 +0800, Keguang Zhang wrote:
> The sti-uniperf pcm_config is the same as the default pcm_config.
> 
> Since commit 43556516fffe ("ASoC: soc-generic-dmaengine-pcm:
> Use default config when none is given"), passing a NULL pointer
> could let this driver use the default config.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sti-uniperf: Use default pcm_config instead
      commit: bb341f75a05238ccd35b1ec1eb1849a3955eebb3

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

