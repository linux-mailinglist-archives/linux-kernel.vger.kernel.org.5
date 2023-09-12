Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A3C79D031
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbjILLid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbjILLiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:38:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF3A170E;
        Tue, 12 Sep 2023 04:37:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A73C433C8;
        Tue, 12 Sep 2023 11:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694518675;
        bh=qP2dOGtWGvlle8iQUWZgWiX7KRolx20OnvWXsEa+L70=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EfJ/zOl4uXw7Xm2f4+OxNYwK4bEnGDq3SkJG4kYEuMapSJ547kQ97GjGPTeUvS2xK
         niB7MiQ6NbPGS50H9ovPXJ9UaMDGzhAuzr9gb2At4noP0NO0w+7wQKgfCvAinlqeGr
         4VH6JgTIeoRFwXD2DQ5nfO1R441U8bBGoTKC2s+1Egdtq2xO/rOFPZnJa38AQIb0gr
         s8/V9u0aZ5Sy+X9J5B1QkDV1Ty8EJz7kyZ2ge40IjrLVA98tt7bJW1bOkkyoF7FScf
         3GYrjTR1vG2JicjdcYI0HaFwzpsV+NTlJVHzIcTVRxHwtl8tecwO2eTPPXwnAWhw5v
         2q9Oora1B6aFw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@siemens.com>
In-Reply-To: <20230824162209.2890440-1-andriy.shevchenko@linux.intel.com>
References: <20230824162209.2890440-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/3] spidev: A few cleanups
Message-Id: <169451867395.2398433.2006166923656658924.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 12:37:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 19:22:06 +0300, Andy Shevchenko wrote:
> A few cleanups to the spidev.c to utilize existing APIs and make it
> use less amount of Lines of Code. No functional change intended.
> 
> Andy Shevchenko (3):
>   spidev: Decrease indentation level in spidev_ioctl() SPI_IOC_RD_MODE*
>   spidev: Switch to use spi_get_csgpiod()
>   spidev: Simplify SPI_IOC_RD_MODE* cases in spidev_ioctl()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spidev: Decrease indentation level in spidev_ioctl() SPI_IOC_RD_MODE*
      commit: 12c8d7a76cd6100a2f35b9ef4b87d11128b9105b
[2/3] spidev: Switch to use spi_get_csgpiod()
      commit: 193a7f9e1a78f69c913bb26ca4500f6edad1e8ff
[3/3] spidev: Simplify SPI_IOC_RD_MODE* cases in spidev_ioctl()
      commit: 764246c7feda01f46b1a243cfa15ad5627874ef9

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

