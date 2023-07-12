Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B182E750EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjGLQiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbjGLQiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:38:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D4B139
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:38:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E84816181E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D290C433C7;
        Wed, 12 Jul 2023 16:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689179890;
        bh=DQexuOyJUEJfGQ3HBfoUhZkBbrW+cFpy5QnqcROH1P8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=S4QleozcAyIBCTdD1watgV7kBpQI7x6hlWAONqekBmjhg8yw7uiPqk5NHky5BjToB
         4WcXIJSIMl+t4rTAJbNZTIOZgen+ikbkRbdrZPjegUliecOOunjxe/FcWFPp5wmYGH
         OXNvs/gny7Bdb74wtiBYsVWUmCbeH5OY30IIjBLnJ3gvL0XcJza33lss/6dnWvp0jR
         fWra+EhLUKMMP4FFRmWd5bMNqUr1u/9AtB9VJqw3k/wv3AOSTvZJqMbXttA/DLN4WF
         p9KzcqYXRKxtffEWe11J/qUbqV0DUg1d/osdtet+CqAnjRuabYyE2ssg4s72i3lYzF
         5E4fW8bIQlD1Q==
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
        Takashi Iwai <tiwai@suse.com>, Yong Zhi <yong.zhi@intel.com>,
        Uday M Bhat <uday.m.bhat@intel.com>,
        Gongjun Song <gongjun.song@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Terry Cheong <htcheong@chromium.org>,
        "Dharageswari . R" <dharageswari.r@intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230712191423.443765-1-brent.lu@intel.com>
References: <20230712191423.443765-1-brent.lu@intel.com>
Subject: Re: [PATCH v4] ASoC: Intel: sof_rt5682: add jsl_rt5650 board
 config
Message-Id: <168917988590.102640.2782247586550802134.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 17:38:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 03:14:23 +0800, Brent Lu wrote:
> This configuration supports JSL boards which implement ALC5650 dual
> I2S interface codec. Two DAI links are added: AIF1 (on codec side) for
> headphone and AIF2 for speakers.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_rt5682: add jsl_rt5650 board config
      commit: 6657fcc91db9b01fcbc4f8de0659e10cabd7ce2f

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

