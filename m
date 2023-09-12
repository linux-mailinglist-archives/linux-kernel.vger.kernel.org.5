Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C669F79DB91
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjILWGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjILWGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:06:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D18010D9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:06:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EBCC433C9;
        Tue, 12 Sep 2023 22:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694556367;
        bh=E2XTGRL/IkbTW32YCF8VS7zqFT4U8Ka0FnC5/INNJTc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lCNqeIvByiakywFUCNyfdE+DcGHmywQ1NaP4iUBTtfw1rRWFTvrjxbxN4LXuE1lF3
         NihgDqoloyCBLJ/fm/XGU/7/hu7ugPD9logEwUU8kFCsfqFzKBFvDSMJW6pcfLVQCG
         LtmYN3dqtwW6QbnDOdzopGP5F8d1PGRrV6xR1Z5tcuGahOadNnoZW+HC5uzHDfCTT/
         7s2xHD9K2wJD9SotQfH49yld6kxN1Pob/VPQs7euUXS6Unb8/hceODu4Rz7FSA68KM
         /+1/z7YDG/5blnaiLkag3mikuMpMJWFXrKy4ao18Ip0d/IIETfnxL2X7Idk8GbTWpo
         CwptUU65PUzug==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230912133841.3480466-1-rf@opensource.cirrus.com>
References: <20230912133841.3480466-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Disable low-power hibernation mode
Message-Id: <169455636529.155240.12687921810988180049.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 23:06:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2023 14:38:41 +0100, Richard Fitzgerald wrote:
> Do not allow the CS35L56 to be put into its lowest power
> "hibernation" mode. This only affects I2C because "hibernation"
> is already disabled on SPI and SoundWire.
> 
> Recent firmwares need a different wake-up sequence. Until
> that sequence has been specified, the chip "hibernation" mode
> must be disabled otherwise it can intermittently fail to wake.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Disable low-power hibernation mode
      commit: 18789be8e0d9fbb78b2290dcf93f500726ed19f0

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

