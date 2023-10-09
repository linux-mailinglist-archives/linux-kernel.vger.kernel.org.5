Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404867BE9A0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377801AbjJISgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377218AbjJISgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:36:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EFBA4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:36:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24CFC433CC;
        Mon,  9 Oct 2023 18:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696876580;
        bh=OvUCm/3E4vQGGxaOWPx5pkG4KYY+4a8QMGU5u5En9VM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=h8UU138ZAULBx2K/a/pyweRcxOK0U1bwoJKf/Giz6U3OoNs9U7XyBOm7ypKDBOXa9
         uOHzgONzGGHXc2iEpbf+hp8i0jNcFuhc6uRiSbGmmVxQVqQEl53jeD8j6fpbNSiMoD
         U9GYrGPQqcab56dUNdCUPdU292k4eiS12mk0b9Dr5VanzlF5Hz6EOYkrXnnMIBS+Fb
         cu2tbQ38rmhzbxX/cmkXZK0AzxhDjKWoHwwziP8NzCA2MG9EGFhns3Dwko0Cn8KDpl
         0QO5Z+G81YFEC86m79WY9GcswD2kIu67/m5GaS0aXM4M1XUZI+TPfRUJ2f2aeRbYjz
         UqPRlMOSK653g==
From:   Mark Brown <broonie@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231003155558.27079-1-johan+linaro@kernel.org>
References: <20231003155558.27079-1-johan+linaro@kernel.org>
Subject: Re: [PATCH 0/7] ASoC: codecs: wcd938x: fix probe and bind error
 handling
Message-Id: <169687657762.138823.756591490715328419.b4-ty@kernel.org>
Date:   Mon, 09 Oct 2023 19:36:17 +0100
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

On Tue, 03 Oct 2023 17:55:51 +0200, Johan Hovold wrote:
> The wcd938x codec driver happily ignores error handling, something which
> has bitten us in the past when we hit a probe deferral:
> 
> 	https://lore.kernel.org/lkml/20230705123018.30903-1-johan+linaro@kernel.org/
> 
> Fix up the remaining probe and component bind paths that left resources
> allocated and registered after errors to avoid similar future issues.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: codecs: wcd938x: drop bogus bind error handling
      commit: bfbc79de60c53e5fed505390440b87ef59ee268c
[2/7] ASoC: codecs: wcd938x: fix unbind tear down order
      commit: fa2f8a991ba4aa733ac1c3b1be0c86148aa4c52c
[3/7] ASoC: codecs: wcd938x: fix resource leaks on bind errors
      commit: da29b94ed3547cee9d510d02eca4009f2de476cf
[4/7] ASoC: codecs: wcd938x: fix regulator leaks on probe errors
      commit: 69a026a2357ee69983690d07976de44ef26ee38a
[5/7] ASoC: codecs: wcd938x: fix runtime PM imbalance on remove
      commit: 3ebebb2c1eca92a15107b2d7aeff34196fd9e217
[6/7] ASoC: codecs: wcd938x-sdw: fix use after free on driver unbind
      commit: f0dfdcbe706462495d47982eecd13a61aabd644d
[7/7] ASoC: codecs: wcd938x-sdw: fix runtime PM imbalance on probe errors
      commit: c5c0383082eace13da2ffceeea154db2780165e7

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

