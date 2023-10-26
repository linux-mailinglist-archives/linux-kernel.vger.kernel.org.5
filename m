Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819077D85AF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345429AbjJZPM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345404AbjJZPMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:12:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631F61BC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:12:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAC3C43397;
        Thu, 26 Oct 2023 15:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698333143;
        bh=RFW7uLv+twmN9Zxx5uVVI8VSIlPDPbQpUmh2VkD4x9k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GulcXol7u27lGmQgmhDNiBfxYfP0KhogF94kF5tQQyEFprZFbudlGycHPQDGqpWMm
         StXBPINVD5jSzJON1+YAY+ZwN+plg2tRq/bCrNmeLEXo4yVcG0gOT1JMU4QX1TVvIJ
         ofwRpvMKWnDNFenCbb/rfVdJigbBLF83RH370yOKUw6g0OR6q21zcCOANVIqDSb2EI
         W09Zjqp+oSlhqnbnKxQFb+5jlgPnY0jc9odh/wI/VHxRzSSnrlfFYSsXCeWGojIxRh
         wfePpyLFt+3x9BYBudisbdhHCtzNT5lPovYnGw+sjK0QeF37GL7TyTjTZD6SHIHGtf
         kLLO6RUUU4VTg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, mario.limonciello@amd.com,
        venkataprasad.potturu@amd.com, arungopal.kondaveeti@amd.com,
        mastan.katragadda@amd.com, juan.martinez@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        V Sujith Kumar Reddy <vsujithkumar.reddy@amd.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
References: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
Subject: Re: [PATCH 01/13] ASoC: amd: acp: Add acp6.3 pci legacy driver
 support
Message-Id: <169833313785.133649.17022798870659830462.b4-ty@kernel.org>
Date:   Thu, 26 Oct 2023 16:12:17 +0100
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

On Sat, 21 Oct 2023 20:20:42 +0530, Syed Saba Kareem wrote:
> Add pci legacy driver support and create platform driver for
> acp6.3 based platforms.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/13] ASoC: amd: acp: Add acp6.3 pci legacy driver support
        commit: 33d120a49b970acbe465041d7b71e0cd6a1d1de0
[02/13] ASoC: amd: acp: refactor acp i2s clock generation code
        commit: 40f74d5f09d7c068bd7a980dc06a688dc8d2b3e3
[03/13] ASoC: amd: acp: add i2s clock generation support for acp6.3 based platforms
        commit: c7bf9156f811bcffb4201a0bf5d1b32d97ec0e5f
[04/13] ASoC: amd: acp: add machine driver support for acp6.3 platform
        commit: 9393bfb4c4dea406dd345820a6b39b9c70a7f934
[05/13] ASoC: amd: acp: add Kconfig options for acp6.3 based platform driver
        commit: d4c2d5391d7efc29fdd59d54355526c9ace16bec
[06/13] ASoC: amd: acp: add code for scanning acp pdm controller
        commit: 3a94c8ad0aae2b14a55059869871ea2d199af489
[07/13] ASoC: amd: acp: add platform and flag data to acp data structure
        commit: 57e857770f6021a73af85e6b201203520cb1a529
[08/13] ASoC: amd: acp: add condition check for i2s clock generation
        commit: 16fb2a25440a85708778f6442914066c98dc2f1e
[09/13] ASoC: amd: acp: add machine driver support for pdm use case
        commit: 39d9ee47167a2210d803f651c8fdcac84f03e766
[10/13] ASoC: amd: acp: change acp-deinit function arguments
        commit: 1b6180c095bc9a6c25e38ae1ec6481f8df20a81f
[11/13] ASoC: amd: acp: change acp power on mask macro value
        commit: caa126f2b0c821811eedf2e2fd435b11844bf0f1
[12/13] ASoC: amd: acp: Add pci legacy driver support for acp7.0 platform
        commit: e84db124cb2158b538820f31f641c28b86fb3ca3
[13/13] ASoC: amd: acp: add machine driver support for acp7.0
        commit: b97f4dac40eecfc2fc9b818b427a8eda44cb7763

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

