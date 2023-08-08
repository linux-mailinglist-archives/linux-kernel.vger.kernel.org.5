Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95F57744FD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbjHHSei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235939AbjHHSeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:34:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DA844AA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BEEE62942
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 17:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E3AC433C9;
        Tue,  8 Aug 2023 17:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691517426;
        bh=uHvpznl0LP7uiwltab4V4SdVSeYHVaAfEQuMs85B9yM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GoM7IeJpvrztOcDwFg66Hgl55kUFV1QpDaESjTuHzcHwjDMaAi5eX+oop440aF50n
         sazM597gcjHnRwypSNsAogaEiwGgOsG/kQKNghN3e0zg9/S6BeAdlFjozjEPB+1Oaq
         CrykA2/LGxfm0JXjENEVzC7Io8rkh15x2+laZb31UqDB1T0xbJVGYg7EvXcmkzZQMi
         Zv/InmEepdIjNN9+giea7EUtudn7JlFNXkxUZVA8Yne80PYN28McpVS7NECirY/p50
         gSkx2FFg/K2bowQLRh6L63zrX+OeYoyiHDAnps0jQZlbcblsoQaFzH7VAEYGZc+i4T
         dzXkPeyEMmW6Q==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
In-Reply-To: <20230805162216.441410-1-alpernebiyasak@gmail.com>
References: <20230805162216.441410-1-alpernebiyasak@gmail.com>
Subject: Re: [PATCH] ASoC: amd: acp3x-rt5682-max9836: Configure jack as not
 detecting Line Out
Message-Id: <169151742431.78353.7016590322365439084.b4-ty@kernel.org>
Date:   Tue, 08 Aug 2023 18:57:04 +0100
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

On Sat, 05 Aug 2023 19:22:16 +0300, Alper Nebi Yasak wrote:
> The RT5682, RT1015 and RT1015p codecs used in this driver do not seem
> capable of distinguishing Line Out connections from Headphone, but
> the driver configures its jack object as if it can. Remove the wrong
> value from the jack creation call to avoid any confusion.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp3x-rt5682-max9836: Configure jack as not detecting Line Out
      commit: 94c40dbbffa11bec54b5ca74df1c5bb0f52995b9

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

