Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA8979C260
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjILCJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbjILCCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:02:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D63D1A399E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:32:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E51FC32781;
        Mon, 11 Sep 2023 23:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476675;
        bh=+X6oAuJDVPwkq9UAfnOLPhvWhm6DRKSz6CTUYkjSb7o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nqB4gevlu+p8PlPRRgQ0trfjpHYSkxer+PoPhs5qIboLLWSb56AsB+CWPuienWb+E
         VOpEN0rKh2XlV0dWbHgC3bui+FmQ/Ejamra/tmapzVoDGbDgan6GhZLgq+ARWEutH/
         2EBmKN+LQC7eEaEXG9/R0ZQoUzKNRpeLp32iErSzvj49b4fFh+zsmPQiFNI9a1+/8n
         S6iqBch+wPF9dVUlhlbIiihAyvqwaBToYvu77Rwuj3dWBrCxgrVW8OhIG8H1sQh+b+
         tsd5v5wQY8xmQZi5J8Vig+gJ4MN1oT+1nn8LnmshJsHCp4TeuxAA4vl69T2GSkpHNK
         BNcNnn32c5oPw==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230911-descriptors-asoc-max-v2-0-b9d793fb768e@linaro.org>
References: <20230911-descriptors-asoc-max-v2-0-b9d793fb768e@linaro.org>
Subject: Re: [PATCH v2 0/7] ASoC: Convert some Maxim codecs to use GPIO
 descriptors
Message-Id: <169447667397.2387538.10504456208825837880.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 00:57:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 10:23:47 +0200, Linus Walleij wrote:
> The Maxim devices are pretty straight-forward to convert
> over to use GPIO descriptors, so let's do it.
> 
> Tested with some x86_64 allmodconfig and aarch64 allmodconfig
> to smoke out the worst bugs this time.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: max9768: Convert to use GPIO descriptors
      commit: 0015a18acf9ceafbf7e24f5addefce566326132b
[2/7] ASoC: max98357a: Drop pointless include
      commit: a3b68ba9f594ae4f9a96e0730e9aeadb9f64c43e
[3/7] ASoC: max98373: Convert to use GPIO descriptors
      commit: c5cb83a104a2d95ba4ba182051eff2a8c82d5beb
[4/7] ASoC: max98388: Correct the includes
      commit: 4b0dfc0e8cdebd6aa6ce25593c0dcc71d9d21961
[5/7] ASoC: max98396: Drop pointless include
      commit: 70f29a3078f7bc1f1011b7b5fee41fcd52ff189f
[6/7] ASoC: max98520: Drop pointless includes
      commit: d9241aaea1418fa4bd6653bee093f63cf47a2c6e
[7/7] ASoC: max98927: Drop pointless includes
      commit: 0307ba5420cd785615efc94be6b101b4ac2538cf

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

