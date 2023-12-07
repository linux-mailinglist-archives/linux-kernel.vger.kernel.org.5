Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F535809576
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444070AbjLGWfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjLGWe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:34:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084731708
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 14:35:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8BDC433CA;
        Thu,  7 Dec 2023 22:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701988505;
        bh=NT7BHAqFBOhaRtrY/szkX/r9R8b3Zw9S8V4qsNXM+rg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fM7G8omPRZ7ZWXJv3Rg5R2B74Wc7o7Kd0E7svQfW9jKfF2c9SyQMkDDpP2fwOg2PS
         TKO6qZXBPmoGXWGrJAefouIWYDB8ffo870ddOmQLfgZp38GIQ2vwXuC+0oI7iBOh5A
         Dmzh3SXRzNyYbWZvBRERx2CaEge5kWXD5un3ta2VoAnw3dOgT54u79sJmF7LZRjAi4
         wAyE+jsMQiEYPkN4VoQz3jAoz/AqgbXL0XVNVTtIB0JtpatC8cCnYqQ03ZaxLmbyKD
         a6Mknh/f6Fz9KzrfxlGNr9kf9sZWMTVB1KDV+sBR/xTblGk3eIJE8dITgwEoK8w1zX
         AsY+ipMKgV9Qw==
From:   Mark Brown <broonie@kernel.org>
To:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        sbinding@opensource.cirrus.com, lee@kernel.org,
        james.schulman@cirrus.com, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com, perex@perex.cz, tiwai@suse.com,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, linux-mtd@lists.infradead.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@tuxon.dev, michal.simek@amd.com,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        git@amd.com, amitrkcian2002@gmail.com
In-Reply-To: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
Subject: Re: (subset) [PATCH v11 00/10] spi: Add support for
 stacked/parallel memories
Message-Id: <170198850030.340565.15742297562436442635.b4-ty@kernel.org>
Date:   Thu, 07 Dec 2023 22:35:00 +0000
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

On Sat, 25 Nov 2023 14:51:27 +0530, Amit Kumar Mahapatra wrote:
> This patch series updated the spi-nor, spi core and the AMD-Xilinx GQSPI
> driver to add stacked and parallel memories support.
> 
> The first nine patches
> https://lore.kernel.org/all/20230119185342.2093323-1-amit.kumar-mahapatra@amd.com/
> https://lore.kernel.org/all/20230310173217.3429788-2-amit.kumar-mahapatra@amd.com/
> https://lore.kernel.org/all/20230310173217.3429788-3-amit.kumar-mahapatra@amd.com/
> https://lore.kernel.org/all/20230310173217.3429788-4-amit.kumar-mahapatra@amd.com/
> https://lore.kernel.org/all/20230310173217.3429788-5-amit.kumar-mahapatra@amd.com/
> https://lore.kernel.org/all/20230310173217.3429788-6-amit.kumar-mahapatra@amd.com/
> https://lore.kernel.org/all/20230310173217.3429788-7-amit.kumar-mahapatra@amd.com/
> https://lore.kernel.org/all/20230310173217.3429788-8-amit.kumar-mahapatra@amd.com/
> https://lore.kernel.org/all/20230310173217.3429788-9-amit.kumar-mahapatra@amd.com/
> of the previous series got applied to
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
> for-next But the rest of the patches in the series did not get applied as
> failure was reported for spi driver with GPIO CS, so send the remaining
> patches in the series after rebasing it on top of for-next branch and
> fixing the issue.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[02/10] ALSA: hda/cs35l56: Use set/get APIs to access spi->chip_select
        commit: f05e2f61fe88092e0d341ea27644a84e3386358d
[03/10] spi: Add multi-cs memories support in SPI core
        commit: 4d8ff6b0991d5e86b17b235fc46ec62e9195cb9b

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

