Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ACF79C25E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbjILCJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243650AbjILCGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:06:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAD6FDCBB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:37:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722E2C193E8;
        Mon, 11 Sep 2023 23:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476650;
        bh=poTnKEe6IplQsM0sZiVOzS9IQ55fPQI6l6cswfygPgg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oTBDoyVlmbPiUNJ5ie97Fq3Gib2HBmv+d0kujDh4uPlOPe692KleQ9SwBDkaHgj5z
         OmWIxkph0P1waxpMohJwZvPPmz+IcUhjVyV7jcVNbOqMBhz7iV8Ia8i3aSMFSKwlIa
         NaaqySAI52ke7326cToF0GGbo72iRkGp8mEDfeeGUpokzcu1sScO2/tBYrCNvuzcMw
         t2GHgJx6uf3LWU0UwznApIAWRPRQv8p4a04Z/fN2okpQn+oBVzGn6JXisAlEYLcOat
         mgx0wcUhEpfLHUvMbJkQ7aM28L5avt7HmgZKkXDZLbPZ/nLbIPgz2CGj5VhcQsVG1C
         82ReO3EcZdpVA==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230828180003.127896-1-biju.das.jz@bp.renesas.com>
References: <20230828180003.127896-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2] ASoC: ak4642: Simplify probe()
Message-Id: <169447664816.2387538.7019264836970248142.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 00:57:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 19:00:03 +0100, Biju Das wrote:
> Simpilfy probe() by replacing of_device_get_match_data() and id lookup for
> retrieving match data by i2c_get_match_data() and replace
> dev_err()->dev_err_probe().
> 
> While at it, drop local variable np and use dev_fwnode() instead and
> remove comma in the terminator entry.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ak4642: Simplify probe()
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

