Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D9A7FDFB8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjK2SxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjK2Sw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:52:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01808197
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:53:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B46C433C8;
        Wed, 29 Nov 2023 18:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701283982;
        bh=xE3VGxi1KqB6Ryu8SKT3DnfI6RZJEMWpiPFPbLEUaJw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rJQw+8B4o0JRJzasxhOx6BL6G7wEOmMShOa7P7X52CPjxG+UpuIjothctHLusIKpO
         yN3EtY0s8ZOMFMLVlwXFb1pPO0jtu5123YtgaRUfJfYCelWl0BUxBPDYVP7xj/F5YC
         zm/sQMeAVKcI2wqUOqNyyxOvcMs4BwRKaRrz+eagDMdjmPehE5Pm/0HxLxKkV+hhBe
         U8AZazyYfN7GiJzkR/Fw47uatZ6itVoyDExNyoLKbe5NfH6vyMXxTH/p76s/3tk1NA
         kt2/M26m3nCirh8K2+a7mFydOyfJH8r5KnEmyyBAmNE8k6kffmnJa8q5JwPy2IOBy+
         IOym8QTHw5Hsw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chancel Liu <chancel.liu@nxp.com>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231129113204.2869356-1-arnd@kernel.org>
References: <20231129113204.2869356-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_rpmsg: update Kconfig dependencies
Message-Id: <170128398071.290371.14400360255122979323.b4-ty@kernel.org>
Date:   Wed, 29 Nov 2023 18:53:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 12:31:17 +0100, Arnd Bergmann wrote:
> SND_SOC_IMX_RPMSG gained a new dependency and gets selected by SND_SOC_FSL_RPMSG,
> which as a result needs to have the same dependency, or produce a build failure
> based on that:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_IMX_RPMSG
>   Depends on [n]: SOUND [=y] && SND [=y] && SND_SOC [=y] && SND_IMX_SOC [=y] && RPMSG [=y] && OF [=y] && I2C [=n]
>   Selected by [y]:
>   - SND_SOC_FSL_RPMSG [=y] && SOUND [=y] && SND [=y] && SND_SOC [=y] && COMMON_CLK [=y] && RPMSG [=y] && (SND_IMX_SOC [=y] || SND_IMX_SOC [=y]=n) && SND_IMX_SOC [=y]!=n
> x86_64-linux-ld: sound/soc/fsl/imx-rpmsg.o: in function `imx_rpmsg_late_probe':
> imx-rpmsg.c:(.text+0x11e): undefined reference to `i2c_find_device_by_fwnode'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_rpmsg: update Kconfig dependencies
      commit: 9cce9c4806a89439ea34aad2e382150d68c7ea95

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

