Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D6179C4B3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjILEXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbjILEWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:22:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85429149308;
        Mon, 11 Sep 2023 16:58:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894F1C433BD;
        Mon, 11 Sep 2023 23:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476629;
        bh=1thFA0r6QTXaMMAvmq81qtjuV83w94AXlpxBRNKZhRg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oMnK1bOOaNj/ZlVSiaPag3gDM+dMhWPhyFJ3bLpueNd177LZxpcuKcd3t+Konaz03
         CjqH1fsLDcS7KQY8EICXGiJTA+xHr/IQP2qdc7yxS2QktlSfAKBdZZiLh0wQCJrNca
         sztsB9hMt3cKLSNr1bHETEO8hZBxJev4BjiKf/qZw+sEGzKrLhPU1nVG1V3JnoN5M5
         IMj2qi+guOloCkSp9Mb+FPGLQGW3syQRgD1P+8fKjdbRc49rlwUUFbEw1qdnREBZDB
         XpVU9T8yPhhDyfoaSjWK7V0s+WaINtYrC46O4d4u9Gm4uOmN3ntbWVo5/pum3TKPW1
         ngwlTE+/ivReg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230814080618.10036-1-hal.feng@starfivetech.com>
References: <20230814080618.10036-1-hal.feng@starfivetech.com>
Subject: Re: (subset) [PATCH v3 0/3] Add PWM-DAC audio support for StarFive
 JH7110 RISC-V SoC
Message-Id: <169447662623.2387538.17830103471127363678.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 00:57:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 16:06:15 +0800, Hal Feng wrote:
> This patchset adds PWM-DAC audio support for the StarFive JH7110 SoC.
> The PWM-DAC module does not require a hardware codec, but a dummy codec is
> needed for the driver. The dummy spdif codec driver, which is already
> upstream, is compatible with the one which JH7110 PWM-DAC needed. So we
> use it as the dummy codec driver for the JH7110 PWM-DAC module.
> 
> The third patch depends on tag next-20230809 in linux-next branch.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: Add StarFive JH7110 PWM-DAC controller
      commit: 748c482d032ef8a607cbf696c6d31afd25293bcb
[2/3] ASoC: starfive: Add JH7110 PWM-DAC driver
      commit: d1802d59ab533f5d5fdfa3483c11ca77c5b21fdd

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

