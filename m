Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FF97D85AE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345420AbjJZPMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345409AbjJZPMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:12:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D274C1AA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:12:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B38C433C7;
        Thu, 26 Oct 2023 15:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698333137;
        bh=89zofsyGqaKGHkukw8q1uMvzNeWPZxdaR/ZVsXLlHds=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=okgt+qV890hd9IJu1o6LWqEtz5sJM6zuthGM8IFw02a+MC0aw2TUwfDeZYkHY1uoV
         3lfCAdR460MxaNYFKp3CsBXkdmU3A7EIRtgEYYIaP1I4/tqeRnL8LcGHWR/MGNHw3o
         ue83Z6Q1WAnfzNebj+cPquJoOJcRbWVNPwANvaAqv5tw8QTwWJH47dKfm4tLW23Whw
         LCUP3bg1UB/EDQxqgcDVV6ad1+AlS9dS0S5ZhB8EvcBY0ycttOzC8zJmmvQYpThOcf
         ShKQssP1gRVzgXPiOW9rXt9jNTBmefirG5VW7LkbFdXYIZo55/CvfCoMKYgcx+jHbP
         hM5yy+8nMdVgg==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231017161429.431663-1-krzysztof.kozlowski@linaro.org>
References: <20231017161429.431663-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: q6apm-lpass-dais: pass max number of
 channels to Audioreach
Message-Id: <169833313494.133649.12373491407224846679.b4-ty@kernel.org>
Date:   Thu, 26 Oct 2023 16:12:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 18:14:29 +0200, Krzysztof Kozlowski wrote:
> Using the params_channels() helper when setting hw_params, results in
> passing to Audioreach minimum number of channels valid for given
> hardware.  This is not valid for any hardware which sets minimum
> channels to two and maximum to something bigger, like four channels.
> 
> Instead pass the maximum number of supported channels to allow playback
> of multi-channel formats.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: q6apm-lpass-dais: pass max number of channels to Audioreach
      commit: e29de7abdaf56f58141b01f74862b320191c9203

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

