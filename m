Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3D97A4DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjIRQEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjIRQE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:04:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE71346AD;
        Mon, 18 Sep 2023 09:04:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE62C116A4;
        Mon, 18 Sep 2023 15:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695051949;
        bh=ksMsvVVaejx1APqhq2i7kD3yw+ZOS+jSbgEPKvp1JpA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LeTtNVGYlc8zzXaO6uxKHS7X7UOLFqgDmlZ8DQUOtavW1Epygy3RtMnCNakMrg2Xa
         3HwbCEy4VWi0NQslOa8t3pD/NVwWr/3yK5Ou9SCx1Wco9dhv05oW7wP7E3mvnomvFO
         c5askY1lLgkNpysahEDIJDKFpu1r0RonYGKOHIEitHzcbJ5u3oKtqplJFrJ5LzOskE
         sDvSWmvLxHAXFmI7omefs9x04vHUeMIaMg557wxjeefouFTHPH95xhEbZqjrU0lbc2
         QzNLlIHldlrRZ2Lq4Xn3d+cM4tVeVbRX8QANAMB5Yv/peNWRNfDbr1SS42nUehwvXP
         dh60ZSo1fhA9w==
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
In-Reply-To: <20230911161553.24313-1-brgl@bgdev.pl>
References: <20230911161553.24313-1-brgl@bgdev.pl>
Subject: Re: [PATCH v3] spi: bcm2835: reduce the abuse of the GPIO API
Message-Id: <169505194716.72731.16420346521932884531.b4-ty@kernel.org>
Date:   Mon, 18 Sep 2023 16:45:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 18:15:53 +0200, Bartosz Golaszewski wrote:
> Currently the bcm2835 SPI driver uses functions that are available
> exclusively to GPIO providers as a way to handle a platform quirk. Let's
> use a slightly better alternative that avoids poking around in GPIOLIB's
> internals and use GPIO lookup tables.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm2835: reduce the abuse of the GPIO API
      commit: 21f252cd29f08892d48739fd7513ad79c1cff96a

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

