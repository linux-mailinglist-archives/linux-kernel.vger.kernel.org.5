Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084DE7DF4E4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376795AbjKBO0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376597AbjKBO03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:26:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC12E12F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:26:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CA3C433C7;
        Thu,  2 Nov 2023 14:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698935185;
        bh=rcXBjMiQQ807SsSE73W1ZsB1P3MDsemZVPcElP+zMXY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hhMeKdRjUwLLB/3HZCgLSvJVy9zZIpSfUk20nwFGioelcmhY4pBPcK13HO1hFK/gb
         OVromLYq9NbTv6i9Z4un9PKBVRVMFiK3Krhnuc/j5RXyZd0th8ot3CGoFVk7vUMWI/
         mwkub2D5EV50L8liy8GTg97YCI7R2wfprqWhzqHWNNE9r7B00b91CYUQwsuHNRweJ/
         gUAsBnTzYZZ3/roV6nh1rA9g5HgOZjqvltaIdy7p+ud0ADoCAV1yBbjY13l5CwBCse
         pj2wQsuvZBL6dVahEthveQ6FFYV7CHvgzwe1g+DAaVSkGV4DXg4Zj/jk/x+7EfVNge
         Wiz8oyY89ku5w==
From:   Mark Brown <broonie@kernel.org>
To:     David Rau <David.Rau.opensource@dm.renesas.com>
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, dmaluka@google.com
In-Reply-To: <20231101022507.6226-1-David.Rau.opensource@dm.renesas.com>
References: <20231101022507.6226-1-David.Rau.opensource@dm.renesas.com>
Subject: Re: [PATCH] ASoC: da7219: Improve system suspend and resume
 handling
Message-Id: <169893518346.36738.17294390778319166082.b4-ty@kernel.org>
Date:   Thu, 02 Nov 2023 14:26:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2023 10:25:07 +0800, David Rau wrote:
> When DA7219 is suspended, prevent the AAD IRQ handler is unexpectedly
> executed and cause the I2C driver "Transfer while suspended" failure.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: da7219: Improve system suspend and resume handling
      commit: ab5201e20c181563774631258f737caeefed2364

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

