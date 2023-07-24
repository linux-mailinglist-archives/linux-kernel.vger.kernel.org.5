Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D2476002D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 22:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjGXUAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 16:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGXUAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 16:00:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E71910C9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 13:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B104E61357
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 20:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA6BC433C7;
        Mon, 24 Jul 2023 20:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690228815;
        bh=WTZBlqc2ZcO87LtEbEdgMwGeiInXUbSGlZY5+YNwyJg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hEPlxVCInMg2i0rpUO/Mm7EnW+wHQQjk/WxcEaH9GIrLnP7ffcdPpP2utf2CxqewJ
         1s1EbI1hoPzVN+KSoMUnbmHD38sl5vbq+tduPefQaLRMP9eVoCp9374lzakokcbUum
         GRIJHx+WNdKpIMMkMFIP1tP4iIWBDTCalFXOKsZ104W6+U9V3lVS9y89eHmgQKuGLX
         VOm6bm/9xFW9ZiGa2zuswjki4TUzA0KAiGnzLxPsNn/B1OJ2p2DCzCdJgO0WaI7dk4
         s6Vh8b7rKWdhLQDkDDJHzAjA3yHxcrcXLqe8rcdWgIJ/r18arBkj4bsjcEzMPPAbOI
         r8jHAe4chP+FA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com,
        Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Cc:     perex@perex.cz, tiwai@suse.com, wtli@nuvoton.com,
        u.kleine-koenig@pengutronix.de, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230719200241.4865-1-edson.drosdeck@gmail.com>
References: <20230719200241.4865-1-edson.drosdeck@gmail.com>
Subject: Re: [PATCH] ASoC: nau8821: Add DMI quirk mechanism for active-high
 jack-detect
Message-Id: <169022881228.1309709.2767178684192633298.b4-ty@kernel.org>
Date:   Mon, 24 Jul 2023 21:00:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 17:02:41 -0300, Edson Juliano Drosdeck wrote:
> Add a quirk mechanism to allow specifying that active-high jack-detection
> should be used on platforms where this info is not available in devicetree.
> 
> And add an entry for the Positivo CW14Q01P-V2 to the DMI table, so that
> jack-detection will work properly on this laptop.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: nau8821: Add DMI quirk mechanism for active-high jack-detect
      commit: 1bc40efdaf4a0ccfdb10a1c8e4b458f4764e8e5f

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

