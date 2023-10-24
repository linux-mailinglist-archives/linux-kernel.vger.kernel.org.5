Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55D27D5AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344062AbjJXSxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbjJXSxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:53:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D483010CB
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 11:53:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A831C433C7;
        Tue, 24 Oct 2023 18:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698173608;
        bh=vNxqHm+60eB8KhMUh9Gts9QrJudWp0vLSzq/SyPgb9Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Df/MdjjtBjHXdzu8gyZCLR+qbzbJ+rtTSIZSmkxrJuNSpYBxu3WiD1mWua8jXuYTl
         S7MlswdBhgZxOABQlERluVoiEhG2s07j5PNOpBMxYOoD9nbxVq7o1qDiibw3k4DpGR
         HZ3JO/i5X2bIlX05gD/iuTNuCtnjJBEOZi8mSIIMvonMaRMXMtrfun5n3NpHHWYZhu
         2pzz/Dpnor4U42UfpytCXIDtPWsYHwlXLQZofYgmzSUs7WxmpY//QPr5Tk1J/3LkoP
         7hC2rPOa2Di7wY6jzEHP0m4LqhGYWzXOpXdgzYdg8uj8wk43SQmQqkC5dTfOeqaN9A
         dDPybsgpKbcAQ==
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231008135601.542356-1-jmkrzyszt@gmail.com>
References: <20231008135601.542356-1-jmkrzyszt@gmail.com>
Subject: Re: [PATCH] ASoC: ti: ams-delta: Allow it to be test compiled
Message-Id: <169817360687.82257.16546449649446463449.b4-ty@kernel.org>
Date:   Tue, 24 Oct 2023 19:53:26 +0100
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

On Sun, 08 Oct 2023 15:53:10 +0200, Janusz Krzysztofik wrote:
> The driver is now built only when MACH_AMS_DELTA is selected, which
> requires a very specific selection of ARCH settings.  As a consequence, it
> gets very little attention from build-bots, if not none.
> 
> Drop the driver dependency on <asm/mach-types.h>, no longer required since
> conversion to snd_soc_register_card() and drop of machine_is_ams_delta().
> With that in place, allow the driver to be built in any environment as
> long as COMPILE_TEST is selected.  Take care of not selecting
> SND_SOC_OMAP_MCBSP if COMMON_CLK is not selected.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: ams-delta: Allow it to be test compiled
      commit: 7790bccd7bac3af28bf044e188215041eb142d56

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

