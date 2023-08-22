Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015BC7847B9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbjHVQdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237881AbjHVQdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:33:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E4DCE8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:33:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C44B65C8F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 16:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20691C433C7;
        Tue, 22 Aug 2023 16:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692722008;
        bh=yNKUaFqiWjC0vS8/Nk7KvaD1e3zbikEBwSOWAo1nACM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IvulK8lZrDRnzWAylOM8y+4SkDj43ORPN0KTjZOQSYykrHVwmM8/ijcWa2fvgQlkR
         OR4gtYXvJMYpZEPxcibq0Ca0fiScelOVEv+rrU5sbkssqdhKtHHMnkmHcL3et2KtHW
         Eqyq+Ofa6Hn3ejgFgsizvgPGq6dAyepG45foNpKCoptOPupIobEmCyBLE3tmkx2fsP
         BQeRbGICNo1eZI18nwMWT/Mhqoj3XjyyAcqB1r1aY8NiFic3C9AyLIP2pLLFa87E8j
         mk+OO1dnWSfCtCZZdQZtdYxJKcHA9arhnhZWxmOiZ8zwHe4ACCCbfsi/JD4NXbUCXi
         BIVLOJCPQlGzQ==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc:     vsujithkumar.reddy@amd.com, Vijendar.Mukunda@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        syed.sabakareem@amd.com, mastan.katragadda@amd.com,
        arungopal.kondaveeti@amd.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>
In-Reply-To: <20230809123534.287707-1-venkataprasad.potturu@amd.com>
References: <20230809123534.287707-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH 1/3] ASoC: SOF: amd: Add sof support for vangogh
 platform
Message-Id: <169272200384.71502.14840159001955531773.b4-ty@kernel.org>
Date:   Tue, 22 Aug 2023 17:33:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2023 18:05:20 +0530, Venkata Prasad Potturu wrote:
> Add pci driver and platform driver to enable SOF support
> on ACP5x architecture based Vangogh platform.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: SOF: amd: Add sof support for vangogh platform
      commit: d0dab6b76a9f05bd25d7ad957c3275a9dec42a06
[2/3] ASOC: SOF: amd : Add support for signed fw image loading
      commit: 6a69b724b2f82b1c44852b432010fbe25f0e2b75
[3/3] ASoC: SOF: amd: Enable signed firmware image loading for Vangogh platform
      commit: f7da88003c53cf0eedabe609324a047b1921dfcc

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

