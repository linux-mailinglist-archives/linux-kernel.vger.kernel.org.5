Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD39579C257
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbjILCIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237201AbjILCCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:02:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB171A39BF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:32:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F1DC32778;
        Mon, 11 Sep 2023 23:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476660;
        bh=FzUo6kz4vSnqAuUZNi1uZ04H7l9XwNQaj5HRYzYXW5A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KPLGGK3Lp6EnbFpvRQP+pxHv1KLQwuwzB/D3+MImSvicANXXvq5YKKY06dPvMyhpQ
         Ta3I4vtrrYIkzKtiq3U8OXjKKlapPQTXLtVqd1n/YsPjkPKUNfG3hBJZ5GVu+E27OZ
         9y59TohCZywhKHhnR++iMANSkfZR5gNlrIA2373H8bsuNEYyhUCeuj539wwCd3mmzl
         lVTz/PaphUEqr9cLM96HHsdlNutd6nbtpte2QlL7x1kpqpQoAsWoQ8N5ouSYIsd1HJ
         k2OV5Vi6iwYBw+NWTETWff7l6tJfLzj0kVcUq1ZTxXk+1MQZd0mkUc30sbmVBww21h
         DEBkjH9BKNT1A==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230831204734.104954-1-biju.das.jz@bp.renesas.com>
References: <20230831204734.104954-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v3 0/2] Match data improvements for ak4642 driver
Message-Id: <169447665810.2387538.3521988123719858959.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 00:57:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 21:47:32 +0100, Biju Das wrote:
> This patch series aims to add match data improvements for ak4642 driver.
> 
> This patch series is only compile tested.
> 
> v2->v3:
>  * Patch#1 for cleanups and patch#2 for simplifying probe()
>  * Replace local variable np with dev_fwnode()
>  * Replace dev_err()->dev_err_probe().
>  * Remove comma in the terminator entry for OF table.
>  * Drop a space in the terminator entry for ID table.
> v1->v2:
>  * Removed forward declaration ak4642_of_match and ak4642_i2c_id.
>  * Restored error EINVAL.
>  * Used dev_fwnode() and replaced dev->of_node.
>  * Removed comma in the terminator entry.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: ak4642: Minor cleanups in probe()
      commit: a157d07d029be5b72ee3bce3ac44dab7b967bc9b
[2/2] ASoC: ak4642: Simplify probe()
      commit: d9e6a80a2c7bea4cc2edc87fa43b876a64b13074

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

