Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1C27C0380
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjJJSeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343591AbjJJSdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:33:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62F5C4;
        Tue, 10 Oct 2023 11:33:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7E8C433C9;
        Tue, 10 Oct 2023 18:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696962830;
        bh=/p2wW3LtXnVJqisJI3qtLmkp5TAuA7mNUsAWuCq1bTM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BzpXO/lG95a3CgmwGLrAeZoeMAmzRUL43Jb3Ak51EHWtgTG+rRyt6wAzC54M5kpAC
         L2m2uHVRoDOk4TUBcybDsa5Kgqn4LQAJM3KsQYDbGMoCvfLHgjMSjM3qaJkg1JcEHq
         F3vIgETE5yNcsGqDCasolCTTxomgwjw1LTKusiWbGZQ+TyQr18IC1sb5OFLzyRwRQi
         0KFTNaW/gh1XOepWrghe7+KUFK5TcdGK83X95zxU6BRWiuoHi6YG7zg/hQG4IkUgWe
         b7BDz7MP0eGTV2NT4kLOhjnLd/WSMQ+XzMtDKArPuD+a2t+/lRX9uav2xOjdPQyvWf
         l49RjiyeqgY7Q==
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
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231004183906.97845-1-brgl@bgdev.pl>
References: <20231004183906.97845-1-brgl@bgdev.pl>
Subject: Re: [PATCH] spi: bcm2835: add a sentinel at the end of the lookup
 array
Message-Id: <169696282723.222014.3485016870976123694.b4-ty@kernel.org>
Date:   Tue, 10 Oct 2023 19:33:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Wed, 04 Oct 2023 20:39:06 +0200, Bartosz Golaszewski wrote:
> GPIOLIB expects the array of lookup entries to be terminated with an
> empty member. We need to increase the size of the variable length array
> in the lookup table by 1.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm2835: add a sentinel at the end of the lookup array
      commit: 9aaa25df9b02bfe5579cbc9b4cc1177c662ec33f

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

