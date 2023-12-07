Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1FB8089B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442628AbjLGN7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjLGN7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:59:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389DFD5E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:59:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E126C433C7;
        Thu,  7 Dec 2023 13:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701957587;
        bh=xRjuwAzrqlcjnOGRq1pqq7Lp1FZjkiM2NMq1l7NLBm8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XltynE0Yrz8pP2zYajfeEZwz3kHRMBES4I4yU8u67sXIEaHd6B94aLUYmaDDdrscG
         7hLXQULlN5te4xsCqnggyiqqwcaoWAIah+OH1iDq7pqMJADbocujtq70fHZQwUwVDi
         XdBGBfg0JTs9KX/p0Y9rBLhRZOKxdXnENHNAFua9vnohq8T/2UfTtdF74U1QcY4ZfB
         1TbMIOyONzJxOGG2iiEJAsWKjfRSIfBYZviyjkTk8OxnwV/6yfdvYlwwjp4tCouODE
         2YF4mmVnkZJlgc3OJLrd5gGG2GWS9ly/jYabJgrG/CNLTiYxMqS0zypZzwrizvdNe1
         gASijK/MTBhmw==
From:   Mark Brown <broonie@kernel.org>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231206160318.1255034-2-rriveram@opensource.cirrus.com>
References: <20231206160318.1255034-1-rriveram@opensource.cirrus.com>
 <20231206160318.1255034-2-rriveram@opensource.cirrus.com>
Subject: Re: [PATCH 1/3] ASoC: cs35l45: Use modern pm_ops
Message-Id: <170195758517.40629.8262800996139784314.b4-ty@kernel.org>
Date:   Thu, 07 Dec 2023 13:59:45 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec 2023 10:03:16 -0600, Ricardo Rivera-Matos wrote:
> Make use of the recently introduced EXPORT_GPL_DEV_PM_OPS() macro, to
> conditionally export the runtime/system PM functions.
> 
> Replace the old SET_{RUNTIME,SYSTEM_SLEEP,NOIRQ_SYSTEM_SLEEP}_PM_OPS()
> helpers with their modern alternatives and get rid of the now
> unnecessary '__maybe_unused' annotations on all PM functions.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: cs35l45: Use modern pm_ops
      commit: 12e102b1bd22ee00361559d57a5876445bcb2407
[2/3] ASoC: cs35l45: Prevent IRQ handling when suspending/resuming
      commit: c3c8b088949b9ccb88da2f84d3c3cc06580a6a43
[3/3] ASoC: cs35l45: Prevents spinning during runtime suspend
      commit: a0ffa8115e1ea9786b03edc3f431d2f4ef3e7a2e

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

