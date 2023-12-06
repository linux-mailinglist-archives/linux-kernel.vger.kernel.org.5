Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D136F8070A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378426AbjLFNMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378368AbjLFNMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:12:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F70AC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:12:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E6FC433C7;
        Wed,  6 Dec 2023 13:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701868372;
        bh=EStk6AojKy4VrHDz7eSOQKX/7HbeZy7ZzJ/2crabbHk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pUHMnBj0fpV+uqC8lC/kqLL2SDwI80ZQvcD8acliYpy+7Mx25yFwsyR8EnLmLATER
         DJNzK3a6Z8osyx1yUzskQq8PAGIfJQHZqEg4ND/T9pSa4fMwrCj7MKAaWnpAKrnE1s
         UPHRFLp/CvVHDqYRczUb7LpV5Hw+E/F3MlJ9gp4qmJ9f9BeTly+H68k3m5WnYKqVBb
         ykdzlvyp/Oig+Mj/ZdrrYgBYjbpkvFSgGvqtE0ypoPsVADMwYAtCZNHPbyXv5TGVZq
         fj3/ZeUSAb32tMlZ0DuJM3o8I5ghrDV8QYkSVwbz8x5hycvMQ3Mgjei4KI9vs2qQq2
         ypjE16CzHOXgQ==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        kai.vehmanen@linux.intel.com, cezary.rojewski@intel.com,
        ranjani.sridharan@linux.intel.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20231205135001.2506070-1-rf@opensource.cirrus.com>
References: <20231205135001.2506070-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: Intel: sof_sdw_cs_amp: Connect outputs to a
 speaker widget
Message-Id: <170186836988.22386.11650594415666700683.b4-ty@kernel.org>
Date:   Wed, 06 Dec 2023 13:12:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2023 13:50:01 +0000, Richard Fitzgerald wrote:
> Hookup the CS35L56 DAPM_OUTPUT widgets to a DAPM_SPK widget so
> that there is a complete logical path to a speaker.
> 
> There is no particular reason to use multiple speaker widgets.
> The CS35L56 are designed to work together as a set so they have
> all been connected to a single speaker widget.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_sdw_cs_amp: Connect outputs to a speaker widget
      commit: 138a4e2a26ec73197e22fe64ee3957b1594eabb3

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

