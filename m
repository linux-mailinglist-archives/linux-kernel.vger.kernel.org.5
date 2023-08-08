Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551B6774AB0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbjHHUd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbjHHUdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:33:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B95E5AC6E;
        Tue,  8 Aug 2023 10:02:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3697F61AA9;
        Tue,  8 Aug 2023 17:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9664C433CA;
        Tue,  8 Aug 2023 17:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691514155;
        bh=ATXpfxlq2nkVzaslrJEtPL7Am1LPKQ5nq2x9hWexo9A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VqehRm5FttgFzXgTZNvxsHCKo6dwAPk9EklpjDPrze+zGQ+Q8VGADnGr1umjHfufn
         54ZxjciXNdsAUhOnNio5g1VoPdfLfz8bb232ZZun7gZLuTw0nO1HPzD27FrjK0Gv70
         quYZ5DCR+obScBWw/Z7bS+2kGU0POXpNeFX+Bf0VwNrRC7JZTV9emjZK/OUNADAQDV
         /hdPRsou1GAGvQyzTD1Z9y2gxhfdD1TBXuHkVQ3/Q9vQ7nNIyDaPBuCnNTUtNM8St/
         eODKIgaOXVmx71/hIp17f4x9k0FaIwkj0La8EvHUr8jjjcl207KBfeNcHy2UhNztrz
         dgJdKXDILsQ/w==
From:   Mark Brown <broonie@kernel.org>
To:     Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20230808-descriptors-regulator-v1-0-939b5e84dd18@linaro.org>
References: <20230808-descriptors-regulator-v1-0-939b5e84dd18@linaro.org>
Subject: Re: [PATCH 00/11] Regulator legacy GPIO header removal
Message-Id: <169151415259.72832.7760300817402372059.b4-ty@kernel.org>
Date:   Tue, 08 Aug 2023 18:02:32 +0100
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

On Tue, 08 Aug 2023 15:46:27 +0200, Linus Walleij wrote:
> This removes some low hanging dangling <linux/gpio.h>
> includes.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[01/11] regulator: tps65910: Drop useless header
        commit: 9b966639b0cc742a9c4b6329a8e27128e4424cf1
[02/11] regulator: s2mpa01: Drop useless header
        commit: d0d58fe27b344fb6d0edb5fd2038372b5e5ed95b
[03/11] regulator: rpi-panel-attiny: Drop useless header
        commit: 052eff402fb754f3472833cb679ceef954ebf2a0
[04/11] regulator: rk808: Drop useless headers
        (no commit info)
[05/11] regulator: rc5t583: Drop useless header
        commit: 2f26d97863f05b83b8f7872aff81ecb9d6b76b50
[06/11] regulator: mt6311: Drop useless header
        commit: 4eb351fb89d68efeaca3625dccbbf492f5450801
[07/11] regulator: mcp16502: Drop useless header
        commit: 2e903eac35ec0ea1f44af5a53d87d98309295fc3
[08/11] regulator: max20086: Drop useless header
        commit: d150c73aa233d6469392282ef648dba5fd4b4821
[09/11] regulator: lp8755: Drop useless header
        commit: e4d48f64fcd469feeb09fc452f8cd1dfc00b43f6
[10/11] regulator: bd71828: Drop useless header
        commit: a5c9a1444088099c6d52939ed2f34049d5d00b5f
[11/11] regulator: bd71815: Drop useless header
        commit: f321708da4db6b15a8691dc64b2d5169234937bc

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

