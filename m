Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF19877666B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjHIR1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjHIR04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:26:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C633DA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 10:26:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A945632C8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 17:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C29EC433C8;
        Wed,  9 Aug 2023 17:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691602015;
        bh=mLoGnOPHxbVLWsH4NNSzTWx/xU1npGsvnrelkvn0Ex0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dha+cNJGci43s86hLcqg9q2U+5A76NmUIQkZ0J4H8DlXz/TTrHQtNkaHPRyDdRgei
         uHvaSFa6vyxDaX/BEhoQswvWf1hlofkqAuZwSm5vj6204hCoVAp/9VR3o42d87gsCv
         xn37MdS16aW2ySMazuJlH9gntJj/bgPnvaNziaXQLuXccj4D5zsjF2/kXaJ9uIzW7a
         4BWWGeMuzc3kewQleR8FLImBgllS/F6VlTrBTFl1QHZNxQqea3u62umMs7kh5KTfoL
         8XZPjwys+CQnt68ohziEZffjrSHDfKUe2Jz3qBCRB8E1SW/7mJ6huwCPuYZFU1Q0Jw
         iyN5EYi0IQaXg==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20230808164702.21272-1-rf@opensource.cirrus.com>
References: <20230808164702.21272-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/5] ASoC: cs35l56: Bugfixes
Message-Id: <169160201427.157618.11759081939312972339.b4-ty@kernel.org>
Date:   Wed, 09 Aug 2023 18:26:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Aug 2023 17:46:57 +0100, Richard Fitzgerald wrote:
> Miscellaneous bugfixes for the cs35l56 codec driver.
> 
> Richard Fitzgerald (3):
>   ASoC: cs35l56: Avoid uninitialized variable in
>     cs35l56_set_asp_slot_positions()
>   ASoC: cs35l56: Don't rely on GPIOD_OUT_LOW to set RESET initially low
>   ASoC: cs35l56: Wait for control port ready during system-resume
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: cs35l56: Avoid uninitialized variable in cs35l56_set_asp_slot_positions()
      commit: ebd0f7b08e032900e5327962f7da6bed6f37feb6
[2/5] ASoC: cs35l56: Don't rely on GPIOD_OUT_LOW to set RESET initially low
      commit: 853734588dcb1bf4c41a17e4d9df231965e559db
[3/5] ASoC: cs35l56: Wait for control port ready during system-resume
      commit: f5eb9503e80e70c22e3d3f73a5d3c149c132407f
[4/5] ASoC: wm_adsp: Expose the DSP power down actions as wm_adsp_power_down()
      commit: d0a3a6ad0d3b24578f1b3832ad1d7fbdb20f7a20
[5/5] ASoC: cs35l56: Call wm_adsp_power_down() before reloading firmware
      commit: e24ef967c735bf7272099610e422f964c0a4258b

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

