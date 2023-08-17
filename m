Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758ED780121
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355853AbjHQWg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355801AbjHQWgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:36:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22C12722
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:36:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 673C163B77
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 22:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645F0C433CB;
        Thu, 17 Aug 2023 22:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692311798;
        bh=Z+veBRj8TkRaYvhGldqGAJAH25CBsVdPdS/M9njsKW8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZWFUHTeqHFQQbOXHjtrpxwtkrqiiL1tWVZkVwpSx8FZFLTCuqkcrXv+NMbA5Th1dO
         EECRtA3ViyNFKyHu1iLiVefusPLsnAAYU4t59OQw1++ggxs/tdduSxV8tL6wHO/2S+
         xUN8ILU90UOvbqIJL6qmHF3WMSt1DiN6hDRQE4eCGsgQyFwnoA0l+N7qQW/pSEXN4P
         fedlvUazJSrvNpFvo9m1NWXzfVKRUh9gS8OpjMqJ9+eCRrStwKHRvTpZDOqkAD8Rg8
         hUmWXtq8Jc/P5jNhe01vVOwa2czFR7F7qTxx/Ri3YVQ/k1UfuCR9wPHK9R4b2Uhfyv
         jL6hZRX+qIGqA==
From:   Mark Brown <broonie@kernel.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230817-descriptors-asoc-rt-v1-0-434f5f177cee@linaro.org>
References: <20230817-descriptors-asoc-rt-v1-0-434f5f177cee@linaro.org>
Subject: Re: [PATCH 0/5] ASoC: Convert remaining Realtek codecs to GPIO
 descriptors
Message-Id: <169231179711.153247.17784763872682870421.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 23:36:37 +0100
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

On Thu, 17 Aug 2023 15:30:14 +0200, Linus Walleij wrote:
> After dropping unused headers a few Realtek devices
> actually using the GPIO descriptors remain.
> 
> Converting them to use optional GPIO descriptors is
> pretty straight-forward.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: rt5640: Convert to just use GPIO descriptors
      commit: a9b5f21073c0c687068f17e23385ec43fc643b08
[2/5] ASoC: rt5665: Convert to use GPIO descriptors
      commit: 647a3c4c33cd2c3902cdc07c50f3129166d715f5
[3/5] ASoC: rt5668: Convert to use GPIO descriptors
      commit: ab2a5d17064436585807f2ece5e6b4b03769a11f
[4/5] ASoC: rt5682: Convert to use GPIO descriptors
      commit: ed11701751d43fb2318c625e65e0507b5234f8a5
[5/5] ASoC: rt5682s: Convert to use GPIO descriptors
      commit: 8793bee716452e5e2f9bf085fbe01f9e3d1e659f

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

