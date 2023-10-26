Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1DB7D85AD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345407AbjJZPMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345390AbjJZPMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:12:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A251AB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:12:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124EFC433C8;
        Thu, 26 Oct 2023 15:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698333134;
        bh=TI0/EViWn+QYi6nNh367rfBcGpgqIjH1+F4SEmPMVXo=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=RTAuC68CAyw810g+HHd7082URkfHzlAoB7K9N0r+Ru9YrD3GfZgYCAnb6XW2kv0Nl
         BXYuEdJ8M29jGohBpmVqV51t8AOH5rnPTb3gNHsrmhniAOhAX62GKbtFZvnMh0X+m+
         B/vhsYa4vpxY8ZFXpb72NI8Gzj+S93tN0HBaeNeYhR6hKsR2UaxkZHROoCyYyNdc7T
         GkgknSV+M6F9Qrwv6i7qeaR0byCgDO4au34byi30hyUsnaCPeEpDCQzccf7Ha76P0r
         md14bdq0BeXcXp+kyqkKiyr6DNNnhtcTUW46CPP9yAV0POgj5yBH+LCp84yzkhIysM
         fbmsVEs1o6LTg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231019144108.42853-1-krzysztof.kozlowski@linaro.org>
References: <20231019144108.42853-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: wcd938x: use defines for entries in
 snd_soc_dai_driver array
Message-Id: <169833313276.133649.3664120134410239820.b4-ty@kernel.org>
Date:   Thu, 26 Oct 2023 16:12:12 +0100
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

On Thu, 19 Oct 2023 16:41:08 +0200, Krzysztof Kozlowski wrote:
> snd_soc_dai_driver array in wcd938x driver has two entries whose order
> must match order of wcd938x->sdw_priv array.  The wcd938x_bind() and
> wcd938x_codec_set_sdw_stream() rely on this order.  wcd938x->sdw_priv
> array is indexed by enum with AIF1_PB and AIF1_CAP, so use the same
> defines instead of raw numners for snd_soc_dai_driver array.
> No functional impact.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd938x: use defines for entries in snd_soc_dai_driver array
      commit: 7618ab524935667699afed76fb83bc9bb38710ec

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

