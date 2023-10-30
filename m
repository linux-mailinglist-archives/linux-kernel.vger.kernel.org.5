Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9C27DC049
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjJ3TUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjJ3TU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:20:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70A6B4;
        Mon, 30 Oct 2023 12:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07C3C433C8;
        Mon, 30 Oct 2023 19:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698693625;
        bh=2/AkVrexR/JZ05pQV2i1gYvGNuV3Dwqm9KVT5lmWsow=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MECrVJeaJQC/0R+9DGzfSEbAPTwEj13FUBlJTrbfoq03rmpvluF9xyOpYxTFIQFmf
         eZ5R7l+BSqM+t0G/yW+R0PJbCbQV2sNHt9/hcaBwol1aYQJVBNfvIE4Fu69TE1/Rtv
         p0SgLcOqBmHTxfd1HHb6LS4p8kx/hwgFjZ4wUhxZXUzaWg/F/L2kV673C8CUEIgaZa
         3mwkUHVGXmWMlymc0FimQKyXBm1hYPvM+9cn/So0hYbyttNGTwsKTgLfkORrxWbRB1
         TJ5BwSLYVSgjF8M66mGnETfIi5iHzmv8zlr9EwuHKuwtFj4fl544bwH2CkfFWyElyN
         4LB1xzx2Hr2vA==
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Tony Lindgren <tony@atomide.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231030052340.13415-1-tony@atomide.com>
References: <20231030052340.13415-1-tony@atomide.com>
Subject: Re: [PATCH] ASoC: ti: omap-mcbsp: Fix runtime PM underflow
 warnings
Message-Id: <169869362256.44249.15039737144512154634.b4-ty@kernel.org>
Date:   Mon, 30 Oct 2023 19:20:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 07:23:38 +0200, Tony Lindgren wrote:
> We need to check for an active device as otherwise we get warnings
> for some mcbsp instances for "Runtime PM usage count underflow!".
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: omap-mcbsp: Fix runtime PM underflow warnings
      commit: fbb74e56378d8306f214658e3d525a8b3f000c5a

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

