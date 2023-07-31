Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1AC76A423
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 00:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjGaW0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 18:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGaW0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 18:26:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E21173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 15:26:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30D3A60FC3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 22:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1FEC433CA;
        Mon, 31 Jul 2023 22:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690842393;
        bh=eTwdcbysjbn6rcR3c4nOy+ZCFxizPHnkvqF1+9/kS50=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hRJrNSJq7QiWqgmwZKQpWBDLLeHf0O2BQ9ABQY9Q+KgEjhQhVby5iLD+jjWKU9sZO
         vvRyeDqib5GuoKP5e7+wLLFWJnvVG8klF48vafQqdc8h/Tt+FN9mSJUNvy7WTHW610
         J4T6QsMsr/UU4LZz2vP6cAkSLtLxUinOftpJXbp9xEZbp44EfofDcK65HDSKEYH0d5
         brYiuiWBV5rAr7VFNiazRlFcox9W75pFpIvAZre3Mv5r7ufLZ6AVqwszBZ9xDbgbdY
         awkP2NBtUG0HIsUFY7+/GK0N48f16ofyPNFoXdAeWmxkpZ1/8GQp1MqAZQsFY0XyhJ
         Td0APpdpUs+Cg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Brent Lu <brent.lu@intel.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Terry Cheong <htcheong@chromium.org>,
        Uday M Bhat <uday.m.bhat@intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        "Dharageswari . R" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230731103419.2536036-1-brent.lu@intel.com>
References: <20230731103419.2536036-1-brent.lu@intel.com>
Subject: Re: [PATCH v4 0/1] Intel: sof_rt5682: remove quirk flag
Message-Id: <169084238942.576259.13368835067308367459.b4-ty@kernel.org>
Date:   Mon, 31 Jul 2023 23:26:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 18:34:18 +0800, Brent Lu wrote:
> We add a helper function to detect amplifier number according to device instance
> in ACPI table so the SOF_MAX98390_TWEETER_SPEAKER_PRESENT flag and a dmi quirk
> for 4-amplifier configuration could be safely removed.
> 
> Also refactor the max_98390_hw_params() function to use an array to handle the
> TDM parameter.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: maxim-common: get codec number from ACPI table
      commit: 36eb986845a8ca87c1f7f91976fad53ee249ae8c

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

