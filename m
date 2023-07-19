Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3D7759CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjGSRrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjGSRrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:47:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031701BF6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95F31617C2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC17C433C8;
        Wed, 19 Jul 2023 17:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689788834;
        bh=eCinvZYUH/JC1KKDwH42gcUrbZIde3UQTwfcSlixCaE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Jj9gx+ckIzm7lTs3PzLxN4ngYBtS/+aKA4qtJcxa54BzJjaxIF7eYH9XaoENcQMO/
         ghb7JBRhRu1eOkix/LTK+y8IV7ZdCfxQkUjsTFopKVygyPcKZNLKn7N0e8KJ6lDY+S
         yuQcC164lNTw58l6WPFuWUe0HOonS/cSDM9F83N057ekEp+RUTFdsDxJTBR3UV76uA
         87/Hwkr+NH3liqvCALC53Tc3cTMH1Dkhca2bF40CgBgIpHal7H8BhtKozTVVdC3xjM
         trcLMeZXhswfc+YkFnnqAqXEtciSAOvKpWY1B239fRXg08QsY+esMGTHl8W97WLuPS
         COPvfKGzmG5xw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        Trevor Wu <trevor.wu@mediatek.com>
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230706064123.29790-1-trevor.wu@mediatek.com>
References: <20230706064123.29790-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8188: DPCM used FE and BE merged
 parameters
Message-Id: <168978883184.125745.10740530088863632779.b4-ty@kernel.org>
Date:   Wed, 19 Jul 2023 18:47:11 +0100
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

On Thu, 06 Jul 2023 14:41:23 +0800, Trevor Wu wrote:
> To ensure that DPCM takes into account the backend hardware limitations
> when user space queries the hw_params of a device, we need to add
> dpcm_merged_format, dpcm_merged_chan, and dpcm_merged_rate to the FE
> dai_links.
> 
> This patch includes only stereo FE dai_links, since multi-channel FEs
> may be reserved for specific purposes. Therefore, it may not be
> appropriate to consider BE conditions.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8188: DPCM used FE and BE merged parameters
      commit: 30019d220cf9ec4df4e5f5d9082baf5519516018

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

