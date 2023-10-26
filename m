Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2577D874A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345173AbjJZRKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjJZRKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:10:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977C0D4B;
        Thu, 26 Oct 2023 10:10:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28356C433CD;
        Thu, 26 Oct 2023 17:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698340225;
        bh=Va1jEBWyzwHMFJmzyliMsvcYTsQhokdCctBTTd7BWks=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=PhIcRJkAlRvEUJKrmKS2QMIqgY34kubBOM7CJ2dz9jx7eL/QMCkhRfmsJygzZf/cQ
         DlrzJl4vB5hk4L6rcHwKbGdUGfx2P9LIIEn7xYjzdaTpX1aZoRRQw3IReF+Duv/Gud
         lFTgp3N/zdkkA1VTMjkdtkeDcx9Tqr2vDotqSL/pqYAFZDutEnNid/HWFiRCHVSI9q
         7XWl3TAWHeb78ij9BENyAptFlO3Elvew6KX+mk22drx7L/Wg66PR5MUfmW55RJMQ3M
         tFuMYbozMKxsHov4K4u2DHDxeiwG+mLafID8JZemuGSS8g6pgy1v6q0IhE5KSgCUXx
         pWjp0dPIJFVwA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
References: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [RFT PATCH 00/17] ASoC: fix widget name comparisons (consider
 DAI name prefix)
Message-Id: <169834021871.149939.12687771696008766047.b4-ty@kernel.org>
Date:   Thu, 26 Oct 2023 18:10:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 11:54:11 +0200, Krzysztof Kozlowski wrote:
> Some codec drivers compare widget names with strcmp, ignoring
> the component name prefix.  If prefix is used, the comparisons start failing.
> 
> Except Qualcomm lpass-rx-macro, none of the patches were tested
> on hardware.
> 
> Best regards,
> Krzysztof
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/17] ASoC: codecs: 88pm860x: Handle component name prefix
        commit: ccd0c6c7097b52b01a2c5951cfe96714d4421cd2
[02/17] ASoC: codecs: adau1373: Handle component name prefix
        commit: 7a0762587a814387e631c07ae81169a7c646f012
[03/17] ASoC: codecs: adav80x: Handle component name prefix
        commit: ecea1812b911fed5e675b2d37b29ad4265c067ce
[04/17] ASoC: codecs: lpass-rx-macro: Handle component name prefix
        commit: 5efc1c903e2b43a267ad13696698fcc152ed873a
[05/17] ASoC: codecs: max9867: Handle component name prefix
        commit: a1fa72a780f428ddc956cf5ed4b97e2be76ceba3
[06/17] ASoC: codecs: rt5682s: Handle component name prefix
        commit: b2056ce3cf61a39796041dc5c94d7255de7f9f0c
[07/17] ASoC: codecs: rtq9128: Handle component name prefix
        commit: e2d38e1196f61735716f9c2dd89dff32c0655529
[08/17] ASoC: codecs: wcd9335: Handle component name prefix
        commit: 7df1e6a3c608ab0c345b8898f9ee5d5ac19f2eb4
[09/17] ASoC: codecs: wm8962: Handle component name prefix
        commit: e54db8826f48c9ca52f2abd108d6e030ff20cae5
[10/17] ASoC: codecs: wm8994: Handle component name prefix
        commit: e13b63c47578a27dbf8907974f0dcba0bb2efe58
[11/17] ASoC: codecs: wm8995: Handle component name prefix
        commit: 343b62590d5b950c8bf7f78fef7c81103c5f982c
[12/17] ASoC: mediatek: mt8183: Handle component name prefix
        commit: e84c7f5db97474cb4becd863a93d4ea541dc4110
[13/17] ASoC: mediatek: mt8186: Handle component name prefix
        commit: 0fe153a99fcc2edeae4e863b03c5a8f71376629e
[14/17] ASoC: mediatek: mt8188: Handle component name prefix
        commit: d1ecaabe9f1a669354de7420261bd8737da4bf48
[15/17] ASoC: mediatek: mt8192: Handle component name prefix
        commit: 86cfaf99e4d3c7b4707fb8cc9eb06d8db10c1414
[16/17] ASoC: samsung: speyside: Handle component name prefix
        commit: 317dd0dbadd8bd4de2d69fa6a0611456f3e15b1a
[17/17] ASoC: tegra: machine: Handle component name prefix
        commit: f82eb06a40c86c9a82537e956de401d497203d3a

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

