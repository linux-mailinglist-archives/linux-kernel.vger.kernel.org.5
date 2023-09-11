Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331AC79C2D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbjILC2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237725AbjILC2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:28:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0A449CB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:52:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2CCC116D5;
        Mon, 11 Sep 2023 23:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476641;
        bh=ICaA0huUb9/fxo/31gwj6ndxM2rczzeMvoZAt/a+ZQ0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KA2BC0FMcnu9QuVVOd2+jU0GKXjvRJv2BICe1BJl7nwpyTz4mu24002KX2mmN7mGW
         l629wWKQ1d3CxBiL2O+A32Tse5at5otAN44Q3EsZ6LIHIhTrK0AAVKlE10XVXHT7I1
         QYVwiAQosPKCnpvIyUACIfRhVQBfgjhcX/+lnLt89H2rm+dqGsrYnc3sVZ97fibijn
         W87M0kpRazJlZyt2G4GWgwc+YOuBHx51ijPDYTpfJLtPdN3lyHVbaQY+NkDODW+DAN
         Lkdh6dsjC+CxygpzHWxN9/h5NdE3iv3fJBsrKgJjqA6axja2ufrlf6iuM/EMoMkfG4
         CH8y2SASTUSjg==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230828174019.119250-1-biju.das.jz@bp.renesas.com>
References: <20230828174019.119250-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2] ASoC: wm8580: Simplify probe()
Message-Id: <169447663845.2387538.8668283266177753726.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 00:57:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 18:40:19 +0100, Biju Das wrote:
> Simplify probe() by replacing of_match_device->i2c_get_match_data() and
> extend matching support for ID table.
> 
> While at it, remove comma in the terminator entry and simplify probe()
> by replacing dev_err->dev_err_probe().
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8580: Simplify probe()
      commit: 26eacb98ca7dd3ba5a6845028a13d13a7f03123f

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

