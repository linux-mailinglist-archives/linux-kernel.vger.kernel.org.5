Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF6A75FF0E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjGXS22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjGXS20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:28:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B516F1704;
        Mon, 24 Jul 2023 11:28:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3439E6137A;
        Mon, 24 Jul 2023 18:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1E2C433CA;
        Mon, 24 Jul 2023 18:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690223302;
        bh=x/TDji6c9EOf6CdtqHPxOL7LIWME4rsp6ZMLSc+V2yw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ufbjpu/OPz+c9IWljebyj/kbvEFAhkQ/7lbv37QKEHtgmItO6wEI7PWeMwakMhAqj
         ELYflae4MEHz2Yg490tdoHYocAZ6g1UkBXooJMn3x369OaLAd5zuJ81M9S3Eq+y1TB
         9uS51IHFBmxJWEmVcdu6wSDBpNhpbt/6/oiwl6WdiFgVJlfddOKOFImSFs7FInMmAu
         H789xXQrvkKkYqhj0bcyN4K9hvXUTTeI3+FkqRlVpsF91P91PL/0/ez9m2AqF/fe1P
         MdRumk31d4H51OrUg9Wyy6FLgO8tODCruVXgnZ1fBSzASZ3Bjg+0lj1LphiYwnSRFw
         cRmFq0jE2I09Q==
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        William Qiu <william.qiu@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>
In-Reply-To: <20230724101054.25268-1-william.qiu@starfivetech.com>
References: <20230724101054.25268-1-william.qiu@starfivetech.com>
Subject: Re: (subset) [PATCH v3 0/2] Add SPI module for StarFive JH7110 SoC
Message-Id: <169022330023.1044366.15536884337765854561.b4-ty@kernel.org>
Date:   Mon, 24 Jul 2023 19:28:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023 18:10:52 +0800, William Qiu wrote:
> This patchset adds initial rudimentary support for the StarFive
> SPI controller. And this driver will be used in StarFive's
> VisionFive 2 board. The first patch constrain minItems of clocks
> for JH7110 SPI and Patch 2 adds support for StarFive JH7110 SPI.
> 
> Changes v2->v3:
> - Rebaed to v6.5rc3.
> - Registered one more clock.
> - Dropped commit that changed the number of clocks in YAML.
> - Rewrited the commit comment.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] dt-bindings: spi: add reference file to YAML
      commit: 8858babff615ee366bf570c1facfbd0845dd924e

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

