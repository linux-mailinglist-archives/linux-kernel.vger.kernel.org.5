Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE747C5DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346995AbjJKTxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjJKTxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:53:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F9490
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:53:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D95C433C7;
        Wed, 11 Oct 2023 19:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697054020;
        bh=49brBIxir2A/eI0wSsvoiOpX9CqLvfF5NO+bYDf2LHQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qQHnOKP8Yog1aP6Q0ugc+XLAq/6nbwFNaqWNS4OTx9gAquHhqPkoXEcpHjwqiYrWy
         psCTd3Wbe1j4Y4yJXtEzz8oXNYRa+7aC3SkPOgiE0kR/RfJj23rzMedsOb2j2vn3tz
         7mq0qdCUUvoH4m8qcp0h1Kb5Svy6RoGYrPtQDjinrVvOBfy6ExLn6szu+3nHbn0oT3
         JmRY3HXQL1iWeBVDKMogLREnEmQ534XjLqxki2RAD7D52Q77oZXtvxgpMdTTMmDlcx
         dRQbgUOEZj1dNqvaWEmv70JIyBaK6kx1H1QHpCNMsyUJCu8mWDyTnYdkYL/fXuhFd4
         tKWuAwtolZkBQ==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20231011134853.20059-1-rf@opensource.cirrus.com>
References: <20231011134853.20059-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l42: Fix missing include of gpio/consumer.h
Message-Id: <169705401914.99325.7680075672500717976.b4-ty@kernel.org>
Date:   Wed, 11 Oct 2023 20:53:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 14:48:53 +0100, Richard Fitzgerald wrote:
> The call to gpiod_set_value_cansleep() in cs42l42_sdw_update_status()
> needs the header file gpio/consumer.h to be included.
> 
> This was introduced by commit 2d066c6a7865 ("ASoC: cs42l42: Avoid stale
> SoundWire ATTACH after hard reset")
> 
> and caused error:
>     sound/soc/codecs/cs42l42-sdw.c:374:4: error: implicit declaration of
>     function ‘gpiod_set_value_cansleep’;
>     did you mean gpio_set_value_cansleep’?
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: Fix missing include of gpio/consumer.h
      commit: d6cbc6a3a856a7d8047316d81e2e039e44432acb

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

