Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFE3787BA1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243943AbjHXWoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243933AbjHXWnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:43:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879E21BF7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:43:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26B126370C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB7AC433C7;
        Thu, 24 Aug 2023 22:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692917018;
        bh=DlnGJX17MyL1LSD68GKcwNwP0OejT/tAXjf9NDu5tfg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Y1GVtErOBt3Cwfy1RUkA17OAvCXx5nRto2lkvAuCAKjliQir0FL5o7neqYpTrZK5O
         HItCvFcVS6sABYYWjZXNWwPtVYVe1/6UnnLKv/90D4zvW0R2IcConfNV6N1GwtZP9X
         +kbp/1KCgMkio3gizOefCmNMGUi3sH2oJUtrmSZnivyYgrWgedaPzaK65NIcHRhjdR
         UfUkJ17NWGrro/QO/Rb70gi2st9k8TQnABRWX4nfo5MVqAM3VF4Ux9ntFZE2PulL/X
         i31l2sohEGb/r/xwGxJInIjcAonqYioPZ8SKcpoeJvZOeGi73mRe3KxhUEQJUc4ki/
         T9XM/irbmXdQg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
In-Reply-To: <20230824193837.369761-1-cristian.ciocaltea@collabora.com>
References: <20230824193837.369761-1-cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH] ASoC: soc-core.c: Do not error if a DAI link component
 is not found
Message-Id: <169291701565.2997200.6576849021679425893.b4-ty@kernel.org>
Date:   Thu, 24 Aug 2023 23:43:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 22:38:37 +0300, Cristian Ciocaltea wrote:
> A recent cleanup of soc_dai_link_sanity_check() is responsible for
> generating lots of confusing errors before returning -EPROBE_DEFER:
> 
>   acp5x_mach acp5x_mach.0: ASoC: Component acp5x_i2s_dma.0 not found for link acp5x-8821-play
>   [...]
>   acp5x_mach acp5x_mach.0: ASoC: Component spi-VLV1776:00 not found for link acp5x-CS35L41-Stereo
>   [...]
>   acp5x_mach acp5x_mach.0: ASoC: Component spi-VLV1776:01 not found for link acp5x-CS35L41-Stereo
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-core.c: Do not error if a DAI link component is not found
      commit: 199cd64140f222c66b68ebe288a3fcd0570e2e41

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

