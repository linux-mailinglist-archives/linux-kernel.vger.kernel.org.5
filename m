Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15587AE779
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjIZIId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjIZIIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:08:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0A9E4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:08:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BFDC43391;
        Tue, 26 Sep 2023 08:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695715704;
        bh=aH7ozQDhP9+rq7B4jdXLYIVBH8NAT/Xa3VrnhdITKYM=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=cA2N1EB/lkUXDBj7skkCBPE9ET93tY348x5+OtyzW0VOVK3FNkYS/qnQKMpn8NfAt
         SDZeYQGbg8TwoZQ4S2gkmzcY1E5vpWwHCrqFWMJ12/8W3m6B81YzX6NWdUE2lFC+io
         7Y4RWyuyhQeHVaNVV93n8gqs21mY/Ip1VPtW6J+dhY1U59P9ZQQ7uF157qc9GxqVif
         nNMo6gK/TfS1KAUv3KjsD65+RzGeF1LXwQFsiooPbYAux7uZd0cJCri2BRJMAoVkI0
         a7B3WJU+ufJ5mWC1Z6IwhWl9KkZJF4ik/IJX5FFFMAB8RmBAkF2WMDaSkVBLRT2xn1
         ye1yKzgOK+/aQ==
From:   Mark Brown <broonie@kernel.org>
To:     shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        matuszpd@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1695116533-23287-1-git-send-email-shengjiu.wang@nxp.com>
References: <1695116533-23287-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Don't disable bitclock for i.MX8MP
Message-Id: <169571570223.2520438.2470473456796299214.b4-ty@kernel.org>
Date:   Tue, 26 Sep 2023 10:08:22 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023 17:42:13 +0800, Shengjiu Wang wrote:
> On i.MX8MP, the BCE and TERE bit are binding with mclk
> enablement, if BCE and TERE are cleared the MCLK also be
> disabled on output pin, that cause the external codec (wm8960)
> in wrong state.
> 
> Codec (wm8960) is using the mclk to generate PLL clock,
> if mclk is disabled before disabling PLL, the codec (wm8960)
> won't generate bclk and frameclk when sysclk switch to
> MCLK source in next test case.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Don't disable bitclock for i.MX8MP
      commit: 197c53c8ecb34f2cd5922f4bdcffa8f701a134eb

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

