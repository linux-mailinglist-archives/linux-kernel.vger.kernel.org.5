Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FA279C36B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240554AbjILC51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240882AbjILC5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:57:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B03558F4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:27:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27E0C32787;
        Tue, 12 Sep 2023 00:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476916;
        bh=b7QKl0a0AEHRzG/6bKiidEwJZlxjVK/5NxsY7VlNA8Q=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=H2B1meaujGjdupBvdKujlqBDeO+9jyKuGE747IQuFVPFFSmruNXZYdxPcCcDW2aCE
         SX3TIKkNBV1YjsBqRpxtvCmmFuHcPksCKc1PHACOUz7yB9mx84z6xOuZ6xvrC99V0R
         SJ2se1JUKRlOA+p6cawZzrRkSAkNGq43GTJhR2Qs59VLEAsCis1d1i2zG1UTRwj4qE
         j2NOVEqjqXstwTczrGuj+GF0S4g6WYZi0x2mlYqfVL54mx31Zl0xI7t62E2bvoGUqI
         ip4Qt4O5if/a02Zyd/RegMMGZ67J/MV3AzbMxlm7znXn3it3v/kes7+7XNcR2b2LEd
         ttonejNGSDKtw==
From:   Mark Brown <broonie@kernel.org>
To:     shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1694414287-13291-1-git-send-email-shengjiu.wang@nxp.com>
References: <1694414287-13291-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl: imx-pcm-rpmsg: Add SNDRV_PCM_INFO_BATCH
 flag
Message-Id: <169447691360.2390116.6423554135052140931.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 01:01:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 14:38:07 +0800, Shengjiu Wang wrote:
> The rpmsg pcm device is a device which should support
> double buffering.
> 
> Found this issue with pipewire. When there is no
> SNDRV_PCM_INFO_BATCH flag in driver, the pipewire will
> set headroom to be zero, and because rpmsg pcm device
> don't support residue report, when the latency setting
> is small, the "delay" always larger than "target" in
> alsa-pcm.c, that reading next period data is not
> scheduled on time.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: imx-pcm-rpmsg: Add SNDRV_PCM_INFO_BATCH flag
      commit: 2f9426905a63be7ccf8cd10109caf1848aa0993a

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

