Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A07D79C3A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241713AbjILDEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241334AbjILDD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:03:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF27F90D9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:37:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B0FC116D7;
        Mon, 11 Sep 2023 23:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476648;
        bh=MSxqurdc8bOtYnK9Km+C7wTUaWO8dsr+XYdswOb0/DU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gonV2JpZp5voL21Jh0K0zZxmkJfFJmUQuuyfWMB6CNMVFMNXM6U9wz4JPQ3GQzCS2
         a2lj78+HQt5bUllt3CXhsTo7goNpftJCvMYcs0Es7epn2j+dRBUb26Ri/zeq73Q8DA
         mz8vYrUkvjN9UECag70JHQEDfKoiN+TOVBfpPY7ekoQzuF7NeTWrmqN6fl/1Kz/9AX
         Gyhu1wYy02RTJNOVEVoSc9Bv4GOXtG6AoPaMQLtzBxZK2ts6R52L2j2fiVv4JVS7rZ
         Hiiobp2e89z5VfVG4uEdzFANrDZbohyEtlSMlQmjNumI9E7sCuJffmRh1XWcFyhA71
         hTOWWvCLat4oQ==
From:   Mark Brown <broonie@kernel.org>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
In-Reply-To: <20230828174856.122559-1-biju.das.jz@bp.renesas.com>
References: <20230828174856.122559-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2] ASoC: cs42xx8-i2c: Simplify probe()
Message-Id: <169447664471.2387538.2128490633533923133.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 00:57:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 18:48:56 +0100, Biju Das wrote:
> Simplify probe() by replacing of_match_device->i2c_get_match_data() and
> extend matching support for ID table. Also replace
> dev_err()->dev_err_probe() to simplify the code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42xx8-i2c: Simplify probe()
      commit: ad191992330cfeb80ba341d1e75d9fe2719ced68

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

