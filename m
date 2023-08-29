Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2645A78CCAF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjH2TMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbjH2TMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:12:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF8783
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:12:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EC4161CE5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 19:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23CBC433C8;
        Tue, 29 Aug 2023 19:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693336336;
        bh=Zhedh8PAzSNPe4tiegHKDd4Vg+y78P6BVknH0uInuZc=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=u4qhLUK4QQxgMN5Em2HOi/x+A+hTZM+tmUx8Fw4CpwEkpi63VpfndpkPKSsUpZwH7
         +pPMqIJvEP3pjoB/gjZvPqlwJZ617m7mv0KDvGm6X18IIwI4gB1ag+7uMnKnIPKuPS
         KHTWmxYq7E6DJyIWVhRxLx4DjP3bTa2suHCF31XPjS9//cDwSZlL3eMXu/3vhr9p+z
         JtrcLC13twMHEeKxsDV48mWwsRUSOgpYqn2tlP1l45ujggsEFGHrcmIjfVo+Y28SAA
         WXI6A6ISpAjx4VQI+NPWOvQ00ZpGbpA7heyXLNLZO0W7uq6kXHt29QO68qkHlGz056
         /CSI+S3p1Rrqw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230828132316.190386-1-krzysztof.kozlowski@linaro.org>
References: <20230828132316.190386-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: wcd93xx: fix object added to multiple
 drivers
Message-Id: <169333633189.3145573.6095959163890886616.b4-ty@kernel.org>
Date:   Tue, 29 Aug 2023 20:12:11 +0100
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

On Mon, 28 Aug 2023 15:23:16 +0200, Krzysztof Kozlowski wrote:
> Three Qualcomm audio codecs (WCD9355, WCD934x and WCD938x) use the same
> object file wcd-clsh-v2.o leading to warnings:
> 
>   Makefile: wcd-clsh-v2.o is added to multiple modules: snd-soc-wcd9335 snd-soc-wcd934x snd-soc-wcd938x
> 
> Convert the wcd-clsh-v2.o to a module to solve it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd93xx: fix object added to multiple drivers
      commit: 11b0b802f8e38d48ca74d520028add81263f003e

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

