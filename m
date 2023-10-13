Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA7F7C8DAE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjJMTTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjJMTS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:18:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63ACEA9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:18:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC77C433C8;
        Fri, 13 Oct 2023 19:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697224737;
        bh=sh12Tmk02dttwiKlHd4emXQh6M+LZUocDGA1gHCo9+k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Qd2R1G7T0AS08lW2b5gtWVhjIwvN/shlLldJMJ2kwRoU1owQ1b/qmhQI1CbVZgXyF
         2Ujd2jNIsubpp61NOckhSZ2sUoKjq60os0DbQudgTv7Mj/SwFnQhlb3q6/pyhp0f+m
         135geFqH20PE8I9oGcPF+75i7UlPxk0wboC5IqyEwazSGqk4+AlydpTLSEGC032JUC
         OQSBFpvKZQikhEA6arCMoFzwK7V/DXIks6GUdroU9T+Xj97Y4dQdwNydTqsFqRe2Xx
         qpmpxrd2Gsy2kaF1pGwT1J8WD1SCKYYu+0LPIv24pfGorM8dL60FJpuI3X/EXbDNvi
         qCfAg+I7V56CA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231013-asoc-fix-dwc-v1-1-63211bb746b9@kernel.org>
References: <20231013-asoc-fix-dwc-v1-1-63211bb746b9@kernel.org>
Subject: Re: [PATCH] ASoC: dwc: Fix non-DT instantiation
Message-Id: <169722473509.2978444.10926248070491002211.b4-ty@kernel.org>
Date:   Fri, 13 Oct 2023 20:18:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 18:37:33 +0100, Mark Brown wrote:
> Commit d6d6c513f5d2 ("ASoC: dwc: Use ops to get platform data")
> converted the DesignWare I2S driver to use a DT specific function to
> obtain platform data but this breaks at least non-DT systems such as
> AMD.  Revert it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dwc: Fix non-DT instantiation
      commit: 9c97790a07dc4f9bdc6e1701003dc9b86f749c71

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

