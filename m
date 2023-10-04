Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8037B8CEE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244922AbjJDTH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245398AbjJDTGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:06:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D379819C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 12:01:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D2CC433C7;
        Wed,  4 Oct 2023 19:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696446060;
        bh=KXhIAxC3cWPvbaUSJOIWxCpwDiHLL34grSKs/NFG5xI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=b/gXRsyUcekMcDB06jK/mb8y8hObNsAlthUhKOoBFbCB2jzeegRgfyGBaMi5a2Lxa
         qLuJ8QCxct1r6sgg9/iHWuaMOZZySerQVqhazIgU+Eb9DQR1KOZwnrG0Vh0C9wqH5K
         qfJhp2Pc4iDdsMOjDqxvSW4n7FNCixufWFR2ZnSGm5mSZ7+iA5zXg5MkD/Xw8LR1EP
         q6UqDcyjDd8iEykydiaBcip1SIbb1bhdryGHxGYKZ/XQTFdOYuwYSZXZoIZb1LqFEf
         73sg06oV6RdwIMibkGf6futHDBhbOZE2PsyUkHBsoyRPmXPAiPq4yoDXHjhHPCow3r
         DbjaW2IUuKkEQ==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Simon Trimmer <simont@opensource.cirrus.com>
In-Reply-To: <20231004144203.151775-1-rf@opensource.cirrus.com>
References: <20231004144203.151775-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Initialise a variable to silence
 possible static analysis error
Message-Id: <169644605631.49424.12854334653954573178.b4-ty@kernel.org>
Date:   Wed, 04 Oct 2023 20:00:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Oct 2023 15:42:03 +0100, Richard Fitzgerald wrote:
> read_poll_timeout() is a macro and val will be populated before use,
> however some static analysis tools treat it as a function and warn of
> uninitialised variable usage.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Initialise a variable to silence possible static analysis error
      commit: c98a0a83dccd19283da34a298876d26c7f06750f

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

