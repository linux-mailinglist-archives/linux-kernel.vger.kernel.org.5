Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90037834AB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjHUVJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHUVJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:09:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB06B13D;
        Mon, 21 Aug 2023 14:09:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AC1D64BDA;
        Mon, 21 Aug 2023 21:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCB4C433C8;
        Mon, 21 Aug 2023 21:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692652162;
        bh=RSs/K1RGWpTDgXycVMeH8t5ATjuA68n/VvoYZujJIvA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ki8vk72TwrLCcwVhG+lbpfRg0WxFA1e5JjT1cR8co7mZ6W2GW+X2fSorlHJz8mH+S
         +50lStVFCI7OXNDtLvBkLUSB/3zGhBGRFh9gDBmOe5k3vzGBCSUH6dwCzuUKEWaBpL
         gUPeuyOegSeLw89Avmy61Cuxt1wo8CaljtqFEow+lpjheu2QsksQ9OoQTDst6ByQrC
         ZCZb98g3XGXqpYBttg8rm/OFlyNmyV0mRAUpqtfzXhlqgFyEPjmRC+si3DhHOmJXsi
         qnjufIvTyYKnqnzosicM+k2kmv3D7VaJbQ5zJlAB7BkLR+BgJrH85UP8poYp9+syax
         H1Txzg2HNqy7g==
From:   Mark Brown <broonie@kernel.org>
To:     valentin.caron@foss.st.com,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, robh+dt@kernel.org
In-Reply-To: <20230816145237.3159817-1-l.goehrs@pengutronix.de>
References: <20230816145237.3159817-1-l.goehrs@pengutronix.de>
Subject: Re: [PATCH] spi: stm32: fix accidential revert to byte-sized
 transfer splitting
Message-Id: <169265215965.467713.8072981996743958072.b4-ty@kernel.org>
Date:   Mon, 21 Aug 2023 22:09:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 16:52:37 +0200, Leonard Göhrs wrote:
> Commit 6f486556abe35 ("spi: stm32: renaming of spi_master into
> spi_controller") included an accidential reverted of a change added in
> commit 1e4929112507f ("spi: stm32: split large transfers based on word
> size instead of bytes").
> 
> This breaks large SPI transfers with word sizes > 8 bits, which are
> e.g. common when driving MIPI DBI displays.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: fix accidential revert to byte-sized transfer splitting
      commit: 715dc9a1f0c8ae0bbd4e5b37f9a165ea39e47fe9

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

