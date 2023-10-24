Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321AF7D5AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344199AbjJXSxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344171AbjJXSxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:53:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84C4D7D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 11:53:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945ECC433C8;
        Tue, 24 Oct 2023 18:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698173617;
        bh=Q7AQ8oRrcdeG+H+90jdi3d1PI7uSdUbtZvihZFgYw2Y=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=DhD9CmR9cubugRb44Rs4NUYR5/idllTmfjVSEheguSSbt/3VVJYgdZtKzONNdhwTM
         qC5+d29qkLvZm79zotQxiYd+JOMeiDwHmbtEqAr6UphPOUS3bxsPdKv6RENTs7V+17
         2Nivw8KuvYtYO4M9r2kJsrqoo7kZsft/TuXEYMKf5Cr+FJqeAXml2wjHgJP/LjxDwn
         2TpTfAnWlmYMbS/SQyy4zxSZle5auGVN4/Av73i4XAk3NhU1FSZEYVqit1Lt3DbkQ4
         erLNTMcUa1MV4tMt4SggyUqcQjbyphc6ELGXOzUOAZOjIpNRE62t0f6J5annN9NoDK
         SbbKfl9H6qtvw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Maso Huang <maso.huang@mediatek.com>
In-Reply-To: <20231024035019.11732-1-maso.huang@mediatek.com>
References: <20231024035019.11732-1-maso.huang@mediatek.com>
Subject: Re: [PATCH v2 0/3] ASoC: mediatek: Remove redundant code and add
 sample rate checker of MT7986 SoC
Message-Id: <169817361532.82257.15939611846447961034.b4-ty@kernel.org>
Date:   Tue, 24 Oct 2023 19:53:35 +0100
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

On Tue, 24 Oct 2023 11:50:16 +0800, Maso Huang wrote:
> Changes in v2:
>  - devide v1 patch [1/2] into v2 [1/3] [2/3] with appropriate title and description
>  - refine error log based on reviewer's suggestions [3/3]
> 
> 1. Drop the remove callback of mt7986_wm8960.
> 2. Remove the mt7986_wm8960_priv structure
> 3. Add sample rate checker.
> Patches are based on broonie tree "for-next" branch.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: mediatek: mt7986: drop the remove callback of mt7986_wm8960
      commit: 3e92ea2a460bc410789b24f328de9985ddc3eea6
[2/3] ASoC: mediatek: mt7986: remove the mt7986_wm8960_priv structure
      commit: 0f10adb0ed0c0d74f8bc5facf2c70bc515210295
[3/3] ASoC: mediatek: mt7986: add sample rate checker
      commit: 0e20929434080aa87614fa0135c97bb9337ece27

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

