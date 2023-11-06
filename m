Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E062C7E22AE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjKFNDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjKFNDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:03:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C547BD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 05:03:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8481C433C8;
        Mon,  6 Nov 2023 13:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699275811;
        bh=tvuETolrhSYwQGmU50Kms37nVGRMVAfF+sc+bKCkR5Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fGSmUVsZj3YqNPEPJ6n5tf0SkZoxwAJRvId189ljL97gzh8LlaaCB8wlw7BSZGxJX
         4Wmjzm3pcT7odjTzds59ex/i+/NdKNC4ZRKpbynMf9GL5svnjJUD4865kHdo9bv1Ud
         mNtSnA7zLw66ig+A/K7R5qje2BmbjuGcCjPmoeiE9JPRGxMFJnL4sfKNEjzdKGN/1o
         ptVsbOEYbOa/ikOL9zLw8TPYppejcYt6mR2gr6YAQtZxEPhAqqB9UshoEDDFNw+sXi
         iIgj4T7hrpe0i0uEWnwUk9zpVZpN6tSDNahgwy0TK4psWicVqbLHN3FLOery8e1X8t
         JLfzH+McJFmrg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, mario.limonciello@amd.com,
        venkataprasad.potturu@amd.com, arungopal.kondaveeti@amd.com,
        mastan.katragadda@amd.com, juan.martinez@amd.com,
        amadeuszx.slawinski@linux.intel.com, dan.carpenter@linaro.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20231031135949.1064581-1-Syed.SabaKareem@amd.com>
References: <20231031135949.1064581-1-Syed.SabaKareem@amd.com>
Subject: Re: [PATCH 1/3] ASoC: amd: acp: Fix for indentation issue
Message-Id: <169927580618.3037292.18150963657719003157.b4-ty@kernel.org>
Date:   Mon, 06 Nov 2023 13:03:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023 19:29:32 +0530, Syed Saba Kareem wrote:
> Fix indentation issue reported in acp70_pcm_resume() function.
> 
> Fixes: e84db124cb21 (ASoC: amd: acp: Add pci legacy driver support
> 	for acp7.0 platform")
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: amd: acp: Fix for indentation issue
      (no commit info)
[2/3] ASoC: amd: acp: correct the format order
      (no commit info)
[3/3] ASoC: amd: acp: fix for i2s mode register field update
      commit: ed2232d49187cebc007ecf4e6374069b11ab3219

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

