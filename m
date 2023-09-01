Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C5A7900AE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345593AbjIAQZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345275AbjIAQZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:25:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC0610EC;
        Fri,  1 Sep 2023 09:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9AF7B82515;
        Fri,  1 Sep 2023 16:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93AE4C433C9;
        Fri,  1 Sep 2023 16:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693585515;
        bh=sHKOqNSdp4q7wIKiijKS4YQmgT1mGamM+gLYzuAIKt4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lyMZbDyjiAC9n4nQcawlnvJh/Y4UxIyNx5hbyU40khC7ww1Isrn9b0HqjFFyCSnuv
         kONl8Okhidd9vdCfJV9pFvQj/OlTnMjQPrR9c8FEVCO6vJExyFJyJ9JZPLmBDhjxgK
         ZrJYWLPlllbUCLSSllcHb5oyeAh2NUvTPE00Mg/iIwT74pQJTPCTRSxA99kde1SWsA
         UGDun1RUp9dSxyq+duIjemtcUhGw/y6gTZcyX3aQTRXyq0vvGRu2prJh+hhi6lHiYC
         /+ILX4aCoYI/2h00GBYFp1YT72Bfb/osua5wbHdi4WBaIRgMWef6Yv7IS0DBO+UwV1
         WjmcKg6aaIF9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78818C595D2;
        Fri,  1 Sep 2023 16:25:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 0/4] Add support for Allwinner GPADC on D1/T113s/R329/T507
 SoCs
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169358551548.8276.916609345616924463.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Sep 2023 16:25:15 +0000
References: <20230715091816.3074375-1-bigunclemax@gmail.com>
In-Reply-To: <20230715091816.3074375-1-bigunclemax@gmail.com>
To:     Maksim Kiselev <bigunclemax@gmail.com>
Cc:     linux-riscv@lists.infradead.org, linux-iio@vger.kernel.org,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Jernej Skrabec <jernej.skrabec@gmail.com>:

On Sat, 15 Jul 2023 12:18:12 +0300 you wrote:
> This series adds support for general purpose ADC (GPADC) on new
> Allwinner's SoCs, such as D1, T113s, T507 and R329. The implemented driver
> provides basic functionality for getting ADC channels data.
> 
> Change History:
> v9:
> - Dropped fixes tag
> - Reworded commits to remove 'This patch'
> 
> [...]

Here is the summary with links:
  - [v9,1/4] iio: adc: Kconfig change description for Allwinner GPADC
    (no matching commit)
  - [v9,2/4] iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs GPADC
    (no matching commit)
  - [v9,3/4] dt-bindings: iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs GPADC
    (no matching commit)
  - [v9,4/4] riscv: dts: allwinner: d1: Add GPADC node
    https://git.kernel.org/riscv/c/d0d73ee5e98c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


