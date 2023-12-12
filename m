Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DACC80F16C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377148AbjLLPqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377023AbjLLPq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:46:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49289F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:46:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB37BC433C7;
        Tue, 12 Dec 2023 15:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702395995;
        bh=QdFOL5GvOmMjeT6ecJwNi7r1ylofZKmjdO216ly8fKY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CcFK03V9l8qE3zl4R/Qpxj4+eR9xKsYRNwj7tEbnyqZaT8/AnTlsRUoXvnLrPSVAh
         +px0wae8aDtMedHB/MSvmCEghN6TgfFqMvo1R+4MoekhjKzNJ3lrRajEZSm7rCjgtD
         INevh84+LJortP+519bg/SRRMbewMCjaweuMEIKItkOj6tzMJvbQ7ftQjIfyvlCUj/
         9l62DcxBEv+rWQmICB4EXuxCMySsc6d67IBCckPEwbw3zV/OtVxEZccmgukSdurzfq
         6c3ZEgs3kLdc4dSaAZYNnT+2GtIy/kQysEwJZ4jD6It7QIVcNttn1+kBZvLCiW7O98
         ex5U9cg4Jjbbg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, kernel@pengutronix.de
In-Reply-To: <cover.1701778038.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701778038.git.u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/8] regulator: Convert to platform remove callback
 returning void
Message-Id: <170239599261.81481.1924826267147407361.b4-ty@kernel.org>
Date:   Tue, 12 Dec 2023 15:46:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2023 13:26:15 +0100, Uwe Kleine-König wrote:
> this series converts all drivers below drivers/regulator to struct
> platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
> Provide a remove callback that returns no value") for an extended
> explanation and the eventual goal.
> 
> All conversations are trivial, because all .remove() callbacks returned
> zero unconditionally.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/8] regulator: arizona-ldo1: Convert to platform remove callback returning void
      commit: 03560ff08d2839d7381f18576b329a2eee5cfb37
[2/8] regulator: bd9571mwv: Convert to platform remove callback returning void
      commit: cddda6f5f47f7cb13191b7753bc3882940b6f325
[3/8] regulator: db8500-prcmu: Convert to platform remove callback returning void
      commit: 0210a60aad02149d8503d259525bfbe0e99f8cb2
[4/8] regulator: stm32-vrefbuf: Convert to platform remove callback returning void
      commit: 6f382a0c7ec12f85f4e40d5343ba53f16f543ccb
[5/8] regulator: uniphier: Convert to platform remove callback returning void
      commit: 964575179663db70832e374edfacc91539e783d3
[6/8] regulator: userspace-consumer: Convert to platform remove callback returning void
      commit: 3b2e8e98692b20436d0346fc6adffff1b596d50f
[7/8] regulator: virtual: Convert to platform remove callback returning void
      commit: d637a75ede3db84f7ae4bc2ab398fe2232f22c26
[8/8] regulator: wm8350: Convert to platform remove callback returning void
      commit: 8d6fab52f3fdaeb8aabfd046d95e5d3f9464399e

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

