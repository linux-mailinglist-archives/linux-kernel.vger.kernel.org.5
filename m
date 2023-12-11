Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E01780D113
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344355AbjLKQUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344439AbjLKQUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:20:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77B9AD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:20:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CE8C433C8;
        Mon, 11 Dec 2023 16:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702311615;
        bh=VhUeyCzkh5zgAybWShsWIF7CbargN192ExlRAXEqL78=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GnCg+LgGTUf3EY6SFnUOmBjJYnYF+M+0wX1+lQzGU0tguyJwJhtTEozqvF5d3GXi6
         lNAr5zy1iFQ8SEGDC39RTGk/A50uGDK4giOmsROkRinhIIH6RNCi5locCA18O9BLxu
         ce2f0/ffHJbu/VBe0Y65BUwyRAw6t1duQ0xHLrSfntKl9Srew1ehEe9fGLT32hX8mf
         koCnzdB0WX9SwAtbN1n65yu8oYaAvsh3Nmb4t/rUhPXg2cRPr57FNDnwA9CnNqRPnR
         zMfKKfI6MD1TBCP9wbc5vvwTc89T+uA61Df/6bJYtpcExP6aZmUg2tzHxLWkctkR20
         b6bp+ZmomR1tQ==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231211-topic-sm8x50-upstream-wsa884x-fix-plop-v1-1-0dc630a19172@linaro.org>
References: <20231211-topic-sm8x50-upstream-wsa884x-fix-plop-v1-1-0dc630a19172@linaro.org>
Subject: Re: [PATCH] ASoC: codec: wsa884x: make use of new
 mute_unmute_on_trigger flag
Message-Id: <170231161312.85457.4028188008468218226.b4-ty@kernel.org>
Date:   Mon, 11 Dec 2023 16:20:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 12:40:57 +0100, Neil Armstrong wrote:
> This fix is based on commit [1] fixing click and pop sounds during
> SoundWire port start because PA is left unmuted.
> 
> making use of new mute_unmute_on_trigger flag and removing unmute
> at PA setup, removes the Click/Pop issue at SoundWire enable.
> 
> [1] 805ce81826c8 ("ASoC: codecs: wsa883x: make use of new mute_unmute_on_trigger flag")
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codec: wsa884x: make use of new mute_unmute_on_trigger flag
      commit: 28b0b18d53469833bf513a87732c638775073ba4

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

