Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D46D7BEAAB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378427AbjJITdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378412AbjJITdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:33:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29415B6;
        Mon,  9 Oct 2023 12:33:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7C2C433C7;
        Mon,  9 Oct 2023 19:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696880028;
        bh=3vSQGl8AKGsrfujKMh0CxRfl2/dxm1puOS4ZfrVqiOQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kqFhJBLbV57LCCJaaGa4Cb6xeE1pwKxBLjp1vrm0M8gC8Jmygrgbw44uVuMC1xJcL
         iIwWM0BMCU0VDZ97wHTtrGSr9jBN9zS4XQKyptleasbRpyzlDxP8vuq0ds579CS79q
         9cqIOB4W+MAevB2BsAgJy5UyEcK1qYoCJZNFIZEzN1XFgDcWNN9l4v4+htQbiULn9x
         3A489kPRl5cgnkrkQuOGQ2QFmbovWkMf0fjokrDYa6EW5lxFKXV5dfHCd5cv660Pqa
         P2da3GVyqDBCKdGJLaM+b0/ybnr+3q4r45vgAyV29YJUXP0zigXz5NjG6XRsVovFdq
         gzFlhg72cEHTQ==
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org
In-Reply-To: <20231006-descriptors-asoc-mediatek-v1-0-07fe79f337f5@linaro.org>
References: <20231006-descriptors-asoc-mediatek-v1-0-07fe79f337f5@linaro.org>
Subject: Re: [PATCH 0/8] Convert Mediatek ASoC codecs to use GPIO
 descriptors
Message-Id: <169688002562.148554.2449511739055608946.b4-ty@kernel.org>
Date:   Mon, 09 Oct 2023 20:33:45 +0100
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

On Fri, 06 Oct 2023 15:46:23 +0200, Linus Walleij wrote:
> Convert over the Mediatek codecs to use GPIO descriptors.
> 
> One few-liner affects gpiolib-of.h, I don't think there
> will be conflicts so I suggest that all of this can be
> merged through ASoC after review.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/8] gpiolib: of: Add quirk for mt2701-cs42448 ASoC sound
      commit: 9e189e80dcb68528dea9e061d9704993f98cb84f
[2/8] ASoC: mediatek: mt2701-cs42448: Convert to GPIO descriptors
      commit: 654a23724072f37c0d07b31395e1d9f45f5563ab
[3/8] ASoC: mt8173-max98090: Drop unused include
      commit: b1306c3b6140f0c299f727edc9bb90ec79700614
[4/8] ASoC: mt8173-rt5650-rt5514: Drop unused includes
      commit: 94a7f618211652235f3e4b88aca477391078dba6
[5/8] ASoC: mt8173-rt5650-rt5676: Drop unused includes
      commit: cb1c18e8a7337c7f3ee461b613a52a45c3f723d5
[6/8] ASoC: mt8173-rt5650: Drop unused includes
      commit: 6dffd1f38ad76660e7fff8e269889284e892603d
[7/8] ASoC: mt8186-mt6366-rt1019-rt5682s: Drop unused include
      commit: 73e1f8a05bd8289ab5154c703a0592729267e979
[8/8] ASoC: mt8192-afe-gpio: Drop unused include
      commit: 3b5d22bdf33c4e44016fdcfc8904a0b0bf218e75

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

