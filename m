Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F00B78011A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355792AbjHQWgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355786AbjHQWgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:36:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967F02722;
        Thu, 17 Aug 2023 15:36:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3428463292;
        Thu, 17 Aug 2023 22:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C67C433C7;
        Thu, 17 Aug 2023 22:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692311780;
        bh=iwnF8c85O3uju+ekbUvHDPccr5dGqM08s5FL1orzYeY=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=sdsYZBBOSds1U94P5WJac9uzfW2crT6LrbnOz2cXSymV2AiSU5VyIaUesFvDXqmXE
         V7L5x8m140HMYKP5ICCsp0dYeZA76YmHRLeN/ytwdKG2M9u6gLvDArgKu52+mx7oq9
         WGIgjvMAJOKEV68h42I3IcuwylLhqCRUoDpqqJtr2vRNpXvNG6/L3vZg6BvU/x/Qh0
         7ohljCk5TfINfeTA+Gpn4UUuCp38B+nB/xUApH5TlsJVIrl0NilpXelkcNcRXcFUPI
         f6exrlB+pZOaJx+jnK2Sbf4ta4C7YpZZBO9Q6iCWcSf40VRT9ke6f86xrfzKgnkVEn
         ynW4bFRYh49ZA==
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Rohit kumar <quic_rohkumar@quicinc.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
References: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 00/12] ASoC: dt-bindings: Add
 sound-card-common.yaml
Message-Id: <169231177466.153247.5925846074355578903.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 23:36:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 11:42:51 +0200, Krzysztof Kozlowski wrote:
> Almost every board machine / sound cards has "audio-routing" and "model"
> properties, so we can make things simpler by introducing one common
> binding.  It is also expected that given property has only one definition.
> 
> If the patchset looks good, then the next steps will be:
> 1. Convert more vendor audio-routing properties to audio-routing,
> 2. Add dai-links children to common binding.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[02/12] ASoC: dt-bindings: Add common sound card properties
        commit: a06ce12efb63bad77bd4a6cedc180f181a651920
[03/12] ASoC: dt-bindings: mediatek,mt8188-mt6359: use common sound card
        commit: 34e7bf1acc33da5b45ded94f459a6e30d4c6acdc
[04/12] ASoC: dt-bindings: samsung,aries-wm8994: use common sound card
        commit: d63cff2ba4d6cb9eed12508469bf8c1b207be4f1
[05/12] ASoC: dt-bindings: samsung,midas-audio: use common sound card
        commit: e1d776441d7e19cd98d74bb204713940eb6951be
[06/12] ASoC: dt-bindings: samsung,odroid: use common sound card
        commit: 5ddff831f064ee300351ffdd92bfde1e17c88861
[07/12] ASoC: dt-bindings: samsung,tm2: use common sound card
        commit: 631e9d4b1f3241008bc6f1c62ec0d19d745d02be
[08/12] ASoC: samsung: odroid: use of_property_present to check for property
        commit: ebba2fd5adc2d79afa10c00255a60c79665c091a
[09/12] ASoC: samsung: aries_wm8994: parse audio-routing
        commit: 55ebfafbc32db54259d91383faf65a5bc6bef382
[10/12] ASoC: samsung: midas_wm1811: parse audio-routing
        commit: c91e67145bc6d03f94416f7fbe566c6f6751cd47
[11/12] ASoC: samsung: odroid: parse audio-routing
        commit: 2dc8c0366599cb4dfd939e6eafd94010f3aff233
[12/12] ASoC: samsung: tm2_wm5110: parse audio-routing
        commit: 17b9f4387ebabb19b871bbe2d06562e48e4e7130

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

