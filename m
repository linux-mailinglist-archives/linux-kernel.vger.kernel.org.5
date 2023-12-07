Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17CA809574
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjLGWe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjLGWex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:34:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BF9D5B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 14:35:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B444C433C7;
        Thu,  7 Dec 2023 22:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701988500;
        bh=zov89DUbTcicayLKcWLvQaeckTRBhXiHS291tZk65GQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NiqWv2sH+gBdS9tK/zHe2RthyctB0XEVMnr+am+VOVJRegAb1tkq6JAZFLBDzIyuV
         4PpgwjbUvP9cMJiut6vPLA+Jfwy44V3+xV3dt0hz4nXmFDk1wRmJC7tmlb716NB5+D
         TECFsCDsIBc7lgSK0o1X4twaPo/wqivtAd+HmpIxNvyNJaMMJjffoMorYh3OJ8Dafk
         xbXA+UL3FYEPzYdgmP7csUhuBc+/ewpy73zOMXhm+Vo+Pej9Y+dwDI0w4txa/z0OoA
         ZzT+Zvyuq4fRPqdlfBT0zwE9WK88mWlRFu/VhSC/PGVzJjoOo9IVfnZWR7oL+tctXu
         ec+KuoftjYzUg==
From:   Mark Brown <broonie@kernel.org>
To:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        sbinding@opensource.cirrus.com,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, linux-mtd@lists.infradead.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@tuxon.dev, michal.simek@amd.com,
        linux-arm-kernel@lists.infradead.org, git@amd.com,
        amitrkcian2002@gmail.com
In-Reply-To: <20231118135446.52783-1-amit.kumar-mahapatra@amd.com>
References: <20231118135446.52783-1-amit.kumar-mahapatra@amd.com>
Subject: Re: (subset) [PATCH v10 0/8] spi: Add support for stacked/parallel
 memories
Message-Id: <170198849588.340565.18426692818757581382.b4-ty@kernel.org>
Date:   Thu, 07 Dec 2023 22:34:55 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Sat, 18 Nov 2023 19:24:38 +0530, Amit Kumar Mahapatra wrote:
> This patch is in the continuation to the discussions which happened on
> 'commit f89504300e94 ("spi: Stacked/parallel memories bindings")' for
> adding dt-binding support for stacked/parallel memories.
> 
> This patch series updated the spi-nor, spi core and the AMD-Xilinx GQSPI
> driver to add stacked and parallel memories support.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/8] spi: Add multi-cs memories support in SPI core
      commit: 4d8ff6b0991d5e86b17b235fc46ec62e9195cb9b
[6/8] spi: spi-zynqmp-gqspi: Add stacked memories support in GQSPI driver
      (no commit info)

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

