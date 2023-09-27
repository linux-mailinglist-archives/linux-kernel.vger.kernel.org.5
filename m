Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14B97AFEF6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjI0Iu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjI0Iuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:50:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C27E4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:50:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E248FC433C7;
        Wed, 27 Sep 2023 08:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695804652;
        bh=9vFab4sPRBAj5706m3HoSNU3XGY+zOPkRZTBDOQYU+o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=V7/ueg+ufSKsCz8S79hASiKUTQk/PoP0RKHm+fyd47r/fKQKSfYi1uL+VyqZe2od/
         VTJs3zzkGNtRSdQTk2JCMdDqnevrdKnh2ucFbUWvk76xl40cs+nExh+c9W6AkiTsXe
         mCHpQwaEKamoyDD3uBMrqU1HRiadaoklgyGEzaz6XD1pGYsq/jbLm1q/7PKTEqS3bd
         vof9i4KJ9SbvEWDVW0ETKdzbeua/6cMsMWCkoQ04lVlVqqhDceVWAy85YXShTEGXa+
         o0GxxcC+1KlXUOe4KBLxCKFcnejqUomhBAGRgCkkOuESiv+r6UqsTK6av7di4ZFOx7
         tYS/Dx1+4JGVQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     Vladimir Zapolskiy <vz@mleia.com>, linux-kernel@vger.kernel.org
In-Reply-To: <b5b19cb458c40c9d02f3d5a7bd1ba7d97ba17279.1695077303.git.mirq-linux@rere.qmqm.pl>
References: <b5b19cb458c40c9d02f3d5a7bd1ba7d97ba17279.1695077303.git.mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v2 1/2] regulator/core: regulator_register: set
 device->class earlier
Message-Id: <169580465113.2674076.14526284679681937734.b4-ty@kernel.org>
Date:   Wed, 27 Sep 2023 10:50:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023 00:50:26 +0200, Michał Mirosław wrote:
> When fixing a memory leak in commit d3c731564e09 ("regulator: plug
> of_node leak in regulator_register()'s error path") it moved the
> device_initialize() call earlier, but did not move the `dev->class`
> initialization.  The bug was spotted and fixed by reverting part of
> the commit (in commit 5f4b204b6b81 "regulator: core: fix kobject
> release warning and memory leak in regulator_register()") but
> introducing a different bug: now early error paths use `kfree(dev)`
> instead of `put_device()` for an already initialized `struct device`.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator/core: regulator_register: set device->class earlier
      commit: 8adb4e647a83cb5928c05dae95b010224aea0705
[2/2] regulator/core: Revert "fix kobject release warning and memory leak in regulator_register()"
      commit: 6e800968f6a715c0661716d2ec5e1f56ed9f9c08

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

