Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6F17AE8E6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjIZJXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjIZJXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:23:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3FDBE;
        Tue, 26 Sep 2023 02:22:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85A0C433CD;
        Tue, 26 Sep 2023 09:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695720174;
        bh=XizUt1Q7kWwQVBWeHzt2ZtzkYTGFUWffB2y0PHPGIyg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=J4h5WnIkDZPA676VW6bCVSBg3R8KzghueRiwnq2ly6bSGmvJI6G2UhzKQGVAop4zD
         zTxzyJPnVZ17ssFHT6rqIleG+ey/Ro5wbbhx1IJtDFh1plL4TkCardmpUMf48PEEGy
         IXr+JR1TipPUKdCXC+jqw2FpCuEr/twjAtJM5iFtrfKDD7ssPNBhpn99/SHsyFeXYz
         nvVnAxOrsoOr3p6gowjnTbmzzkhY2FyNsIo5EEr6KUz0yxwTvprqsGSl+vrf2HCa0N
         yKeAoNqHKtTVBDS5ozvOjs0TfVmARLQkG+E1PYEgKZ/h8cwEEVLvWPpAxgdbEI2pTl
         v6wdEK42a6k+Q==
From:   Mark Brown <broonie@kernel.org>
To:     Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <84eb08daf85d203b34af9d8d08abf86804211413.1694961365.git.christophe.jaillet@wanadoo.fr>
References: <84eb08daf85d203b34af9d8d08abf86804211413.1694961365.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] spi: at91-usart: Remove some dead code
Message-Id: <169572017245.2563985.3260563484580012452.b4-ty@kernel.org>
Date:   Tue, 26 Sep 2023 11:22:52 +0200
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

On Sun, 17 Sep 2023 16:36:26 +0200, Christophe JAILLET wrote:
> dma_request_chan() does not return NULL. It returns a valid pointer or an
> error pointer.
> 
> So, some dead code can be removed.
> 
> The IS_ERR_OR_NULL() in the error handling path are still needed, because
> the error handling path is common to the whole function and the
> ctlr->dma_xx are NULL when at91_usart_spi_configure_dma() is called.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: at91-usart: Remove some dead code
      commit: 8a771075e50bef5e2a063a9f954b36a33fb7359f

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

