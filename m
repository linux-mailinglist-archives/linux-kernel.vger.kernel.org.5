Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C5C79C265
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbjILCJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237104AbjILCB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:01:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6301A399F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:32:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D1CC3277E;
        Mon, 11 Sep 2023 23:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476679;
        bh=5KdR9Uxjdsqqm9Cq0uLvkPGlOrrGg9FgEKiihbuW1Fk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ri9555RZ2H4mSY3qKw7BFMeL2NE8xysJ78P8+Z5nDp3fRrd5ZuasZSN/vtne0HiK1
         mWmbzINwiXRO9KQxm+sgIY6MnVeyO/ar1pYV62LVllZSZsyWuaX9sDWUe8qfoQgqpg
         6FRzt1qWf4TTjEvsT82PPfuQTldcWEoi/hqo7/W10f8FNKn7t8V51YJqGCzKVStxGd
         +SS4XBoGMpEwF611islvFyPSJPnDUXvOy94ePlRdg6quuUDi58GZ55PQoVJxgJTG0l
         ltKmU3oKb74ejTr+2uWsUxi0zwbmOuu+y9izlzxUbzRJU5jOXz00job6JGeyBV159i
         giBNLbEC73JWw==
From:   Mark Brown <broonie@kernel.org>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com
In-Reply-To: <20230907171010.1447274-1-cristian.ciocaltea@collabora.com>
References: <20230907171010.1447274-1-cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v2 00/11] Improve CS35l41-based audio codec drivers
Message-Id: <169447667585.2387538.14630945148313901984.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 00:57:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Sep 2023 20:09:59 +0300, Cristian Ciocaltea wrote:
> This patch series contains several fixes and improvements to drivers
> based on the CS35l41 audio codec.
> 
> It has been verified on Valve's Steam Deck, except the HDA related patches.
> 
> Changes in v2:
>  - Added Acked-by tags from Charles
>  - Reworked the shared boost handling per reviews from Charles and David
>  - Dropped PATCH 5/9 and moved PATCH 6/9 a bit down the list, as it doesn't
>    contain a Fixes tag
>  - Reverted usage of devm_pm_runtime_enable() in PATCH 9/9 and replaced with
>    a proper runtime PM changes undo in PATCH v2 06/11
>  - Added 3 new patches providing some HDA related fixes
>  - v1: https://lore.kernel.org/all/20230902210621.1184693-1-cristian.ciocaltea@collabora.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/11] ASoC: cs35l41: Handle mdsync_down reg write errors
        commit: a9a3f54a23d844971c274f352500dddeadb4412c
[02/11] ASoC: cs35l41: Handle mdsync_up reg write errors
        commit: 4bb5870ab60abca6ad18196090831b5e4cf82d93
[03/11] ASoC: cs35l41: Initialize completion object before requesting IRQ
        commit: 5ad668a9ce83d819701fb7abc1c2236049ec15c2
[04/11] ASoC: cs35l41: Fix broken shared boost activation
        commit: 77bf613f0bf08c021309cdb5f84b5f630b829261
[05/11] ASoC: cs35l41: Verify PM runtime resume errors in IRQ handler
        commit: 9f8948db9849d202dee3570507d3a0642f92d632
[06/11] ASoC: cs35l41: Undo runtime PM changes at driver exit time
        commit: 2d5661e6008ae1a1cd6df7cc844908fb8b982c58
[07/11] ASoC: cs35l41: Make use of dev_err_probe()
        commit: 3db52739aca981a436536423a36ab59b9f241096
[08/11] ASoC: cs35l41: Use modern pm_ops
        commit: 611b8813a28f49e206e05198dae77c544c72b050
[09/11] ALSA: hda: cs35l41: Fix unbalanced pm_runtime_get()
        commit: 486465508f8a5fe441939a7d97607f4460a60891
[10/11] ALSA: hda: cs35l41: Undo runtime PM changes at driver exit time
        commit: 85a1bf86fac0c195929768b4e92c78cad107523b
[11/11] ALSA: hda: cs35l41: Consistently use dev_err_probe()
        commit: 206b250c3e9be44c096bb9bb1f9d6b7f3440bfbb

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

