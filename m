Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6267BBA9F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjJFOos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjJFOos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:44:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFC28F;
        Fri,  6 Oct 2023 07:44:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881FAC433C8;
        Fri,  6 Oct 2023 14:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696603486;
        bh=uv9MGtNOVBn4RfKg4MbVlN5VgwbEkH9mg0Fg8sz9LDI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rFRfFP6DGJngKgWRC3VWAdjuuOGoWAnQHE74AC/JIdnMgB2Yg6cj7peuqeIBjMADv
         UM4fL7zRPAxP2oZisS70WWTl6C2oKfDt5vC8AUW3dziXbSvOaG+bMDr5ccX6kD+2QQ
         MMaKGHU+yY3E+MRTy2sQrAnIvDhKOPJoE3BiPXcOPTBoepWmiPxMSIfZFjFTPWg44F
         Ip01byReWVsUeYjSUDHPy6tdL/QygzyXgml4HZb4a9N0kHTG3XMG9QSYj2zWLnqehO
         /mRqX/mPzNOjXXGP1VW+H3iIDNgBVwr4GMU6UQ8kU5QUPeYTt/pq4mCj+Bp+P36ubL
         ZWiY+Qq72vm8A==
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20231006112945.1491265-1-geert+renesas@glider.be>
References: <20231006112945.1491265-1-geert+renesas@glider.be>
Subject: Re: [PATCH] spi: mpc52xx-psc: Make
 mpc52xx_psc_spi_transfer_one_message() static
Message-Id: <169660348525.39801.7796334144610073729.b4-ty@kernel.org>
Date:   Fri, 06 Oct 2023 15:44:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Oct 2023 13:29:45 +0200, Geert Uytterhoeven wrote:
> With W=1:
> 
>     drivers/spi/spi-mpc52xx-psc.c:178:5: warning: no previous prototype for ‘mpc52xx_psc_spi_transfer_one_message’ [-Wmissing-prototypes]
>       178 | int mpc52xx_psc_spi_transfer_one_message(struct spi_controller *ctlr,
> 	  |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> mpc52xx_psc_spi_transfer_one_message() is only used inside the file that
> defines it.  Hence fix this by making it static.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mpc52xx-psc: Make mpc52xx_psc_spi_transfer_one_message() static
      commit: 881fe6ed21e8c7e60095aabc274c4f2bfdc87c5e

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

