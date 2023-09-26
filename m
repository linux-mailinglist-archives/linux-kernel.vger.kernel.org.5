Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E257AE8E8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbjIZJXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjIZJXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:23:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779BDBE;
        Tue, 26 Sep 2023 02:22:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34C1C433C7;
        Tue, 26 Sep 2023 09:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695720177;
        bh=7bQwHcH+xWHqv+nnB0YFhg3IMMKQkz8UhvLE1d7eG8M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=M1xplYQZkL0gLVXD6WWu6NC2lSVGCgPQjwpbfvsjP9D6W5G6vJs3/Zj99PU2el5t9
         1sAWwaQfmb+sBCMvniIPJHBkWynklQ9WZqKyZyYN2h7Fn0Ylmai86/njsMolJSW5lt
         jOdnhXSD9YzXlOqRcAJcRuzICo9zDSkUD8UgCQhRwCThgtlMOPSq9sd14subNz101N
         Y1SJlV2MzEhyUX/DQBxf088+RvlBd1Vd/MlK7vQSQb8EzWyNP5uSVHBuhXoDxN5Eco
         IgXTQBXFY63ITCIKmywywL7ZhnBnop0tmjEDdNkOuARjoy4AqACBsbzYdATlCtGt0O
         BPwpzeok9xgqQ==
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230914190049.1853136-1-robh@kernel.org>
References: <20230914190049.1853136-1-robh@kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: st,stm32-spi: Move "st,spi-midi-ns"
 to spi-peripheral-props.yaml
Message-Id: <169572017456.2563985.7790100096745250244.b4-ty@kernel.org>
Date:   Tue, 26 Sep 2023 11:22:54 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023 14:00:42 -0500, Rob Herring wrote:
> In order to validate SPI peripherals, SPI controller-specific child node
> properties need to be in a separate schema, spi-peripheral-props.yaml,
> which SPI peripheral schemas reference. As there is just a single
> property in this case, just add it to spi-peripheral-props.yaml directly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: st,stm32-spi: Move "st,spi-midi-ns" to spi-peripheral-props.yaml
      commit: 0fc57bf1b2ff178377e756761a884d4b6c69ebf9

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

