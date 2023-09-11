Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0382479C490
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjILELv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbjILELk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:11:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864DC1A4BCD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:32:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6B9C3277A;
        Mon, 11 Sep 2023 23:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476666;
        bh=wdn9zlEHyAc8HiPWc965gAJpmz+DsTAFslrex/UwS74=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HDL5+m/n8EniyneVT4YXFL1cvsyH8H903hGyFuIy5FUSFIkAu4gFiVg5baOz+Yh1R
         sHOJ4MKZg/bVhNKtxDkiBRbnoeOj4r9pKYVfSGID4E4F8QcNOhsoqZCzwXnZ28/tz4
         SqIC24Y/BKwmLBx/8qTCR3s1D6cnoPJfTsmku6GeAwHBQ6lPlAfkJz4kbemp5EjQY+
         7w7SGrYjyLSWjwFApSfG6xRqoFL0L1CmHf/GLsL7q+ikP3W03m0m2W5YDmEq6zl6xS
         YZJF4MRX49rxWrhA1u+9IWUb77kgBMoToH4wnXKrv8e3+VshiSKcVDO8BxQhzMRWWM
         MNift8QGnTlyg==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>
In-Reply-To: <20230901065952.18760-1-biju.das.jz@bp.renesas.com>
References: <20230901065952.18760-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v4 0/3] Match data improvements for wm8580 driver
Message-Id: <169447666353.2387538.719003244549420214.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 00:57:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Sep 2023 07:59:49 +0100, Biju Das wrote:
> This patch series aims to add match data improvements for wm8580 driver.
> 
> This patch series is only compile tested.
> 
> v3->v4:
>  * Created patch#2 for removing trailing comma in the terminator entry
>    for OF table.
> v2->v3:
>  * Added Rb tag from Andy.
>  * Restored OF table postion and moved in patch#2
>  * Moved OF table near to the user.
> v1->v2:
>  * Added Ack from Charles Keepax.
>  * Removed comma in the terminator entry.
>  * Restored original error code -EINVAL
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: wm8580: Simplify probe()
      commit: 26eacb98ca7dd3ba5a6845028a13d13a7f03123f
[2/3] ASoC: wm8580: Remove trailing comma in the terminator entry
      commit: aa11a78fecab8809167dcb59dd3f55b5fdbc9ef3
[3/3] ASoC: wm8580: Move OF table
      commit: ef01a6dec7f1717d13282e84bb4ac68f2119d9d9

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

