Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE88E7C0378
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343648AbjJJSdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343640AbjJJSdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:33:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E724B9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:33:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09051C433C8;
        Tue, 10 Oct 2023 18:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696962816;
        bh=FBG4dlajtykfzMX/8w9AtsLkDPUKg5hOUXTrm5l9Stg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oxT26bVGbjXMrDDViObRjNSkFr37Xxq1pvX3bQMhdhM1FNNcyixTLWVGOm32AaatM
         +RRzHoj/dIIKYxeS1c9QuIGPjWlp80sblxsemtbmrjBepLtcQGF1vVf/35pSj+uTha
         jyzzq7ie+gTIXiarIlKHvn0XrP/7rtcw/Rsr4zYCC7HccmYvGyGz5ivOjLyM1Q86S4
         efFGdjjVYKam3mQqb30fch8uqehQNmxQ8/mgKEt0ugYm1SubBhPYOiCohaopY5AW+x
         OA08f/05wnO5iQMk1YWBBXKCjaf5S7j90MdDRndSHmzyA8dmKZ1SWaOXL3NE2aid1U
         RUOl54lwq7HGA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, perex@perex.cz,
        trevor.wu@mediatek.com,
        xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20231010023738.8241-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20231010023738.8241-1-xiazhengqiao@huaqin.corp-partner.google.com>
Subject: Re: [v5 0/2] ASoC: mediatek: mt8188-mt6359: add rt5682s support
Message-Id: <169696281374.221758.11961649530549486978.b4-ty@kernel.org>
Date:   Tue, 10 Oct 2023 19:33:33 +0100
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

On Tue, 10 Oct 2023 10:37:36 +0800, xiazhengqiao wrote:
> To use RT5682S as the codec and MAX98390 as the amp, add a new
> sound card named mt8188_rt5682s.
> 
> Changes in v5:
> - PATCH 2/2: modify asoc_rtd_to_codec to snd_soc_rtd_to_codec and make it consistent with the latest revisions
>              remove common struct definitions like rt5682s_jack_pins,mt8188_rt5682s_widgets
>              and mt8188_rt5682s_controls.
> - Link to v4: https://lore.kernel.org/all/9c28b84e-2d4e-7bc2-88f3-ad5b30d2c727@collabora.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: mediatek,mt8188-mt6359: add RT5682S support
      commit: 748d508e5b4cb537ed91e7bc5a664c526b6c64f6
[2/2] ASoC: mediatek: mt8188-mt6359: add rt5682s support
      commit: 163284402c42e9094b6aa8e4f69e43da1031efc6

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

