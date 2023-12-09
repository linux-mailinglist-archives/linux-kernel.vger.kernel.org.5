Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014BC80B140
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbjLIBIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbjLIBIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:08:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2372172A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:08:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D41C433C7;
        Sat,  9 Dec 2023 01:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702084088;
        bh=2K+JGgWzd0uvMnBn7tqdv3ZVJoRXQSqeh9A9RoILMCQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QtaW38aEctENnrOTJTMrtFOweb20lGnPiTo4yNLTwrdjss82tCBbCf821XyGzaplI
         abxSFD5JzZrfPpdK3siz2VFpwGTZ5kAclcRP5F5xfnhq4i+5sBYSiicxZTPSwypxuH
         rw3Dv5TgmfvDGpobLJvhekahh9kWfdX7pvQSo2f8eCrM9kyhQ5QUORdL3Uiq/mrAR5
         jcGEza6aXLSwhB07OVxvtvJv6/6NgDya0IfeD5CeLnkQKAUaCAw/xLlN6z+w1rgB8y
         X378Eh40Tf6ZDwes0HXtgwWiZvapqTb2YXIuWSDrj3czomFrtvfVPGAhO2sej08w6x
         S4llrB7i5Jq0g==
From:   Mark Brown <broonie@kernel.org>
To:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, linux-mtd@lists.infradead.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@tuxon.dev, michal.simek@amd.com,
        linux-arm-kernel@lists.infradead.org, git@amd.com,
        amitrkcian2002@gmail.com, akumarma@amd.com
In-Reply-To: <20231018213328.40131-1-amit.kumar-mahapatra@amd.com>
References: <20231018213328.40131-1-amit.kumar-mahapatra@amd.com>
Subject: Re: (subset) [PATCH v9 0/8] spi: Add support for stacked/parallel
 memories
Message-Id: <170208408432.2911266.7193653673078869891.b4-ty@kernel.org>
Date:   Sat, 09 Dec 2023 01:08:04 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 03:03:20 +0530, Amit Kumar Mahapatra wrote:
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
[8/8] spi: spi-zynqmp-gqspi: Add parallel memories support in GQSPI driver
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

