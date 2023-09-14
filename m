Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6087A0263
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbjINLT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237787AbjINLTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:19:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9713C1FE8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:19:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CFBC433CB;
        Thu, 14 Sep 2023 11:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694690381;
        bh=BAzmsoSj0BnX7MoU6zXX/2/yna/irLVGocmTBn20dLU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CO+q3UPZlmZLLf52885QGYBw+GfGnDj3i2p/OQmZzu3eZty6e9GYRLtwlYF/1iBvy
         JqqHmvqKPUjITmfleG4EcUwE+DtLuNOQEcw/qKx4WQTB8+Nnh2n2Qier9+TtZgwEfe
         QPjk14lFH9/4hrgmmOXQZ6mYO8oRvsAAFV4bbaJAW3ES8u31V3SM0Zh88DarVHYRg2
         ht6//d0ZbYMVqTQvLJ2YE7CGO2+So9cGEIQzNVkmdXPm5WBZUt3GLcfAMPZhFi9A7F
         QmM1Tk+/hbBOtl4cbRK8jd8C0L1pZq/2IFiJHZ1xWC2N0rQK39eYPzl7QVjCkC0dja
         OtBbIe1FfxNAg==
From:   Mark Brown <broonie@kernel.org>
To:     Uday M Bhat <uday.m.bhat@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20230913150012.604775-1-sbinding@opensource.cirrus.com>
References: <20230913150012.604775-1-sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v1 0/3] ASoC: cs42l42: Fix handling of hard reset
Message-Id: <169469037974.23670.12014281893865046396.b4-ty@kernel.org>
Date:   Thu, 14 Sep 2023 12:19:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 16:00:09 +0100, Stefan Binding wrote:
> These patches fix 3 problems with hard reset:
> 1. Ensure a minimum reset pulse width
> 2. Deal with ACPI overriding the requested default GPIO state
> 3. Avoid a race condition when hard-resetting a SoundWire peripheral
>    that is already enumerated
> 
> Richard Fitzgerald (3):
>   ASoC: cs42l42: Ensure a reset pulse meets minimum pulse width.
>   ASoC: cs42l42: Don't rely on GPIOD_OUT_LOW to set RESET initially low
>   ASoC: cs42l42: Avoid stale SoundWire ATTACH after hard reset
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: cs42l42: Ensure a reset pulse meets minimum pulse width.
      commit: 41dac81b56c82c51a6d00fda5f3af7691ffee2d7
[2/3] ASoC: cs42l42: Don't rely on GPIOD_OUT_LOW to set RESET initially low
      commit: a479b44ac0a0ac25cd48e5356200078924d78022
[3/3] ASoC: cs42l42: Avoid stale SoundWire ATTACH after hard reset
      commit: 2d066c6a78654c179f95c9beda1985d4c6befa4e

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

