Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D18E80F16E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377153AbjLLPqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377023AbjLLPqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:46:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB413A7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:46:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A947C433C9;
        Tue, 12 Dec 2023 15:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702396003;
        bh=1EoyiyiWGTyfjx9FO3oP4RxDZ5ISUcDITWVN+yHSbI0=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Dyja94fmBpK/L7pgyIsyjQdnu6utBkN7DE1U8nqzNsnYSaCvd3akMQE/Gh6sRxno1
         wiV51z62brySE+b75GHzRT23HVR3bQIQUaALldvP8WOePsZj09DnKN523YMKvDY3ty
         jphTRdcoTSkqZUx8v4ERMSy551F9WnaIgtf+bdC1yqsiQ35234cKJBvhrmznNazrU6
         TnvIeM7VXbmikYuZVAG93gK8pN3gSS6ZYuCZzjZSt9QSXqhRcYyZVyT3GmHa9c0dFC
         fF54MUhDZ0ylcfkhdbfJgFh82SoWdxWf93w7pl5LAihxp8xMtN4ua1YcfWceWaOa2V
         FrSa0v9H4W1OA==
From:   Mark Brown <broonie@kernel.org>
To:     linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nam Cao <namcao@linutronix.de>
In-Reply-To: <cover.1702298527.git.namcao@linutronix.de>
References: <cover.1702298527.git.namcao@linutronix.de>
Subject: Re: [PATCH 0/2] spi: pl022: clean up some unused variables
Message-Id: <170239600215.81606.18013257147179685580.b4-ty@kernel.org>
Date:   Tue, 12 Dec 2023 15:46:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 13:49:13 +0100, Nam Cao wrote:
> The driver was refactored in 9b2ef250b31d ("spi: spl022: switch to use
> default spi_transfer_one_message()"), and some variables are now unused
> because of that. Clean them up.
> 
> Nam Cao (2):
>   spi: pl022: delete unused cur_gpiod in struct pl022
>   spi: pl022: delete unused next_msg_cs_active in struct pl022
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: pl022: delete unused cur_gpiod in struct pl022
      commit: 4c6dd33de9d3148909bc403d394f527bec4aec27
[2/2] spi: pl022: delete unused next_msg_cs_active in struct pl022
      commit: 3c49d848d2d3c6fe46522e4d750fc3a18e699997

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

