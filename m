Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280B579C259
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbjILCIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243634AbjILCGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:06:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC71F8FF9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:37:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A309AC197C4;
        Mon, 11 Sep 2023 23:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476654;
        bh=LeuApLpG3v8SYN8BHFkhSYMJ/eALFnk+G1jkLasFDnM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QEWWVVngtHVHAwR30+E8WivwUqjWkChBZJKrl/XHINMzEFqr7EXO+Xt7imEmwN7wm
         +sSWtLmIIMAWnjBlZLv0YLOVtFB0d3nm0n3noo+yu3XaXQCCLce+IRQs8SZYgybSRP
         16pZ7ovq1vukKeYwAdiwMHEAGDRc64iTZtY/rAEETPi69t2mRLAKQ7wpeLgnWzePgP
         hItJ2WCw11kIGq3VwetC2krMWVmhjggnOUMHpNkRIegP3xuMuDAp9dmnP3GuepYBsR
         c387xpjWPupQtc5Mbd/GYSIlE+Ni/OoGSY8ExMxxDoMIyZvUKxRzsFc7Sxki/t2EQ9
         ZbjbUGJ/+Cc0g==
From:   Mark Brown <broonie@kernel.org>
To:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <x1077012@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230828191014.138310-1-biju.das.jz@bp.renesas.com>
References: <20230828191014.138310-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 0/2] Match data improvements for tlv320aic32x4
 driver
Message-Id: <169447665230.2387538.10106285236700897579.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 00:57:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 20:10:12 +0100, Biju Das wrote:
> This patch series aims to add match data improvements for tlv320aic32x4
> driver.
> 
> This patch series is only compile tested.
> 
> v1->v2:
>  * Created patch#1 for adding enum aic32x4_type to aic32x4_probe() and
>    drop using dev_set_drvdata() from tlv320aic32x4_{i2c,spi} drivers.
>  * Return value of i2c_get_match_data() passed to type paramemter in
>    aic32x4_probe().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: codec: tlv320aic32x4: Add enum aic32x4_type to aic32x4_probe()
      commit: cac1636e214930b01b2f8ac9867771486554271a
[2/2] ASoC: tlv320aic32x4-i2c: Simplify probe()
      commit: d44f7bc9d181a2bec0dcff694d00b08c8f99284d

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

