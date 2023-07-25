Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FB5761F73
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjGYQuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjGYQt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:49:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0068B3582
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:49:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 656BB61820
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 16:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE4AC433C7;
        Tue, 25 Jul 2023 16:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690303756;
        bh=1F7griQ+z3bvllj2m8OXOd5aUu8hpTnYOGJgxms+w/Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gfN2Yb5qnFZhfS7QoywqxwZbY/GgJaljlE/TeJL42bf1B4d7S+c8Dzr9ZoGUCZ1ru
         caQeMpyyi+CYAWaeBWWaf1O7kaqFKLMNBPulmx2gMWPESRYqyXE3nyR1aENY35ZjMD
         R7zXSdGODLBG9EzhxUfUSlA70MeFPcCDCSTPAOGk0yC189yXwDTfwcSIp93y3cRoAT
         TlL9J3Yrm+2yMgfRmsk8UijAWhkXWZYmoNEspJ4jlOTHFV0njQbKUAMrDjrOeDzg3u
         Ama2eMDAqeS0NkSNCgtRR5zanDWZTR5ghu445OMNq+sD+g2H3Zv/hLSXQXPVvTC9KB
         3mEpHUJClS/jA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Suti <peter.suti@streamunlimited.com>
Cc:     pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230713095258.3393827-1-peter.suti@streamunlimited.com>
References: <20230713095258.3393827-1-peter.suti@streamunlimited.com>
Subject: Re: [RFC PATCH] ASoC: soc-dai: don't call PCM audio ops if the
 stream is not supported
Message-Id: <169030375511.1462400.7618926843800056957.b4-ty@kernel.org>
Date:   Tue, 25 Jul 2023 17:49:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 11:52:58 +0200, Peter Suti wrote:
> PCM audio ops may be called when the stream is not supported.
> We should not call the ops in that case to avoid unexpected behavior.
> 
> hw_params is handled already in soc-pcm.c
> 
> [0] https://lore.kernel.org/alsa-devel/ae06b00a-f3f7-f9d1-0b58-4d71f3394416@linux.intel.com/T/#t
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-dai: don't call PCM audio ops if the stream is not supported
      commit: 4005d1ba0a7e5cf32f669bf0014dca0dd12c2a44

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

