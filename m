Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFDB780120
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355841AbjHQWgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355800AbjHQWgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:36:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30CC2722;
        Thu, 17 Aug 2023 15:36:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 787C463292;
        Thu, 17 Aug 2023 22:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734CEC433C9;
        Thu, 17 Aug 2023 22:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692311796;
        bh=tOGckeY7O8J6GlVuUCz6yWek4KQlNAl8jPLek4LXQ0U=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=ixjjApHpPipdtj0u9dHwmmYsUpfpqVxAkquQ6+aGs464Wm5DY+EjZ6eQ2ipAISa38
         lM8u/+z2G4gnXHvbbO5AtHP3jsBFAXaqVJjrVFzWxsrA8vUnXhA7l5mEngiQKF0X4M
         8kbEzXDBWs/DB3kW0IWoO5+HliFfySbiRWbdzDkqGBCeCs/GOGf520Cgxbyl9ZWUCC
         BkaFt0OW7kd1wqm0YuY9uKAQrrY/Gdu2UQsbG4l+GXnz6JfyEmsGn0EJ5iwx6sUJ+I
         LW7DrA3XwZYOaQRWJmfzEGHHp7qfsUwrGizgNtTySyPSVGF7GBz7u/VecwcCnON5iJ
         KYSstiWDDvakA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Maso Huang <maso.huang@mediatek.com>
In-Reply-To: <20230817101338.18782-1-maso.huang@mediatek.com>
References: <20230817101338.18782-1-maso.huang@mediatek.com>
Subject: Re: [PATCH v4 0/6] ASoC: mediatek: Add support for MT7986 SoC
Message-Id: <169231179319.153247.9684848124345959803.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 23:36:33 +0100
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

On Thu, 17 Aug 2023 18:13:32 +0800, Maso Huang wrote:
> Changes in v4:
>  - fix typo of authors and copyright
>  - refine with bitfield helper for readability [2/6]
>  - refine with human readable error message [3/6]
>  - use "mt7986-wm8960-sound" as compatible string [4/6] [5/6]
>  - refine properties based on reviewer's suggestions [5/6]
>  - remove assigned-clocks and assigned-clocks-parents [6/6]
>  - constrain clocks per variants [6/6]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: mediatek: mt7986: add common header
      commit: c4c3c32d088d5a432d3c40efef80d1b64743b6bc
[2/6] ASoC: mediatek: mt7986: support etdm in platform driver
      commit: 9f8df795ae8daa0051fe15b27c7a3b3842d3d91f
[3/6] ASoC: mediatek: mt7986: add platform driver
      commit: 8d0d4884ba2cdabc823dc263c987bb22aae5fa5e
[4/6] ASoC: mediatek: mt7986: add machine driver with wm8960
      commit: 9873277fc2ea6e517602c29cb336bb1e43ff528c
[5/6] ASoC: dt-bindings: mediatek,mt7986-wm8960: add mt7986-wm8960 document
      commit: af835f0b49777476528be5a913e5c00fc3789f41
[6/6] ASoC: dt-bindings: mediatek,mt7986-afe: add audio afe document
      commit: b41efc224a5c859ce982ab73e8a05ecac73d4752

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

