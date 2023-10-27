Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAF97DA3C4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjJ0Wy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0Wyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:54:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460CCE1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 15:54:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C542C433C7;
        Fri, 27 Oct 2023 22:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698447292;
        bh=AAbhixexRBgU2mP2uZA4N/fZc+2gBeKHSi49XtAGO/M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=T6/P/dPKeM2YOJtS8zCh/In1bSRqhzUao/JdNVvEkOMOHiijogmKsP2zx5niseyUV
         qnbxRyGLldv+aUr4aGbgtlCPQe7RELV7zDG3iMbsmg0WNzgKNLLKu5EqCd12BE2XOm
         jKC5EKfW26gr6i15F6NI0E5hC7t4rKDYeDMw5dwHV2t8dJRmjE7/5d8F0ntvgXF3Ba
         dSNA7DVJn2ZSfpTcprU5j/POvmWwc50FTnK2U+YH3lSo9/SPBtsu1PjY7UBYDobNo8
         5++QIBUpmuyuCGpfiSrM3KXQudAIAbn6c58RVWix0mcMvZKEl0qKMAMezxGQ6s1RHZ
         beDSGQQtFHaZQ==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     johan@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20231027105747.32450-1-srinivas.kandagatla@linaro.org>
References: <20231027105747.32450-1-srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH 0/2] ASoC: soc-dai: add flag to mute and unmute
 stream during trigger.
Message-Id: <169844729083.3013518.3783480503939987434.b4-ty@kernel.org>
Date:   Fri, 27 Oct 2023 23:54:50 +0100
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

On Fri, 27 Oct 2023 11:57:45 +0100, Srinivas Kandagatla wrote:
> Click/Pop Noise was a long pending issue with WSA Codecs which are prone
> to accumlate DC when ports are active but without any data streams.
> There are multiple places in the current setup, where this could happen
> in both startup as well as shutdown path.
> 
> This patchset adds a new flag mute_unmute_on_trigger to dai_ops to let
> generic code do the mute/unmute on trigger.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: soc-dai: add flag to mute and unmute stream during trigger
      commit: f0220575e65abe09c09cd17826a3cdea76e8d58f
[2/2] ASoC: codecs: wsa883x: make use of new mute_unmute_on_trigger flag
      commit: 805ce81826c896dd3c351a32814b28557f9edf54

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

