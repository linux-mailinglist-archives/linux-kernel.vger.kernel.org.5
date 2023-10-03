Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A867B6A4D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbjJCNVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237812AbjJCNUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:20:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FF4106
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:20:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551ACC433C9;
        Tue,  3 Oct 2023 13:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696339200;
        bh=NJkZa5fLpnbgCQvHqK6BhiW9OOqCSp7Z7g/SgMcQrpU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QFOK/NZ0NO5ULyQzVv9DPmSEE5+ADtNYsyxawwv9uEfVm5xe6bzS6q0gTbdC9izIG
         s5CQ3ByprQkxQWhH4jY7slLRVypdKWkVp5l0BB2cWc9b5idtryTAqojvlxA3IhKbOL
         hfSwNR3ZdIYTmQTXQBX6scSHd3OVlvspe7dzi1gFNDC8nUSNZGsWOgxi4CyXIAh7k4
         EIedJe/PL2nXTcduhBQpR5xsd0klKxPC0hArBigD23P/iTwnkKsHvrjmnnPH/jecBM
         6XiDBmyhmEQ4f1hwasmcijXI3YsYLk13BHwp1h+RsEhCslBJ2OjzSNPHxPC1ETFwg2
         Re1jZM+7sTrBw==
From:   Mark Brown <broonie@kernel.org>
To:     Joerg Schambacher <joerg.hifiberry@gmail.com>
Cc:     a-krasser@ti.com, joerg@hifiberry.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230929150722.405415-1-joerg.hifiberry@gmail.com>
References: <20230929150722.405415-1-joerg.hifiberry@gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: Adds support for TAS575x to the pcm512x
 driver
Message-Id: <169633919804.32637.4231540899734549446.b4-ty@kernel.org>
Date:   Tue, 03 Oct 2023 14:19:58 +0100
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

On Fri, 29 Sep 2023 17:07:20 +0200, Joerg Schambacher wrote:
> Enables the existing pcm512x driver to control the almost
> compatible TAS5754 and -76 amplifers. Both amplifiers support
> only an I2C interface and the internal PLL must be always
> on to provide necessary clocks to the amplifier section.
> Tested on TAS5756 with support from Andreas Arbesser-Krasser
> from Texas Instruments <a-krasser@ti.com>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/2] ASoC: Adds support for TAS575x to the pcm512x driver
      commit: 1f817805262c2c34142291da376d4932d3c493bc

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

