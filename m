Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038E379C2C8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbjILC20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237850AbjILC2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:28:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C1F11AA5A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:52:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E72C116D4;
        Mon, 11 Sep 2023 23:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476631;
        bh=eOmDusuTp1utIJYuSczsLIAkbuZQLw7Sxoi8jQp9lAk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cVzAtPbk9FxAp/DM3cm0Jw4Z3tqtzaiTutJkJD5vd7PDjSz02Blz+Hxkaeoiez6j1
         GTUbU27tSlkpodhs7NZ/pvQM69djJLYrtnUVpJcfcqBkSKJfgTfnS+9IgEhbP8yJzB
         DHvCCKk7UZMHATdPec+GzX/Z6t0GGv7YM+Xf+o5bUQ3vFCQKTcAtSKvyhEeAwP3dFA
         PCCUbRxA6RqQv4yjJgH3WabWCcmbhaLpKKMj2t9siX3nIS1xQpkgey/d1yal58MYz0
         1Ob0MRSRxexi6dGYcCdNnvDY1MIaYu0qlzM/mXQzn+/RRPSgoQ9xyN75nFaQv2tl3G
         GnpGD2lVRKNaQ==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230825-descriptors-asoc-max-v1-0-b212292b2f08@linaro.org>
References: <20230825-descriptors-asoc-max-v1-0-b212292b2f08@linaro.org>
Subject: Re: [PATCH 0/7] ASoC: Convert some Maxim codecs to use GPIO
 descriptors
Message-Id: <169447662997.2387538.6093833545457230678.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 00:57:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 10:12:10 +0200, Linus Walleij wrote:
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

