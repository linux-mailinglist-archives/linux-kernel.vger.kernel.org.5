Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F91A77D480
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239333AbjHOUno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239641AbjHOUna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:43:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B307268D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:43:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA379661B0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 20:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FFDC433C8;
        Tue, 15 Aug 2023 20:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692132110;
        bh=N7ipikLuPtGgetkxcY+A3Ut1e/FpcdlgAB/lDl1fW/w=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=RGz9IEfwwSDU6RkRCDeWBhsyJ+y2VV6ZRXXHxyIz7K8wWaxdNlc5MB+oifALvzeFx
         xVp2/GLHXEFshr5NDyFnNwpxhhc1x0I7k+Opw5udpcBO3Cw9s+a5GrJ8p4D1Lp4M0J
         3RoPY6uyfLC5ThJEynhJt2NUQat69iIK0PyC31cFkaxrPBNi2LpskBL6VFq+HAgmB1
         lVis78itGCJiqXLjUD8UCCrPk77UTS1P2qaKKk9DM5lHzxvQTKeFw2tsbgstnd86k5
         LcGYGqEIYoS93FvFWe+XHckNIw2VkSrCd6lMs4RaVMVTtbSRnymapWooXYIrjYRqv0
         rFTAGSJRqdiVw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230815143204.379708-1-krzysztof.kozlowski@linaro.org>
References: <20230815143204.379708-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RESEND 1/3] ASoC: codecs: tlv320aic32x4: Fix
 Wvoid-pointer-to-enum-cast warning
Message-Id: <169213210789.572973.6949298748225335967.b4-ty@kernel.org>
Date:   Tue, 15 Aug 2023 21:41:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 16:32:02 +0200, Krzysztof Kozlowski wrote:
> 'type' is an enum, thus cast of pointer on 64-bit compile test with W=1
> causes:
> 
>   tlv320aic32x4.c:1352:18: error: cast to smaller integer type 'enum aic32x4_type' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: codecs: tlv320aic32x4: Fix Wvoid-pointer-to-enum-cast warning
      commit: 66de320b0214a60095287ba1afa09e870d8cdbe5
[2/3] ASoC: codecs: wm8904: Fix Wvoid-pointer-to-enum-cast warning
      commit: 5a1803324949f4ebdf6e887b59e0e89afc3ee0bb
[3/3] ASoC: rockchip: Fix Wvoid-pointer-to-enum-cast warning
      commit: 49a4a8d1261230378a8931d0859329057686b6eb

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

