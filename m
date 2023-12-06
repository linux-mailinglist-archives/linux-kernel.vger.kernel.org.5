Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCF0807A0F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379760AbjLFVEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379614AbjLFVEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:04:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E8F10C2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 13:04:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B951C433C9;
        Wed,  6 Dec 2023 21:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701896691;
        bh=w1X5YST37DXPLXf47U5xpecEc5SmKQf5AI9a4hURkos=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AgVVunDeAF7xTaBXWDHaJ03UBy9hxFDjwpejCYaqNQT0O0MUALToObWN2Gh3RWPxK
         OxTSH2RSj2kFGznCs+328Zk+a4rgAh0TBJvvVzu0NCu25ikv4rJqy//x4ty2fChliG
         8KbQBKadAR61JxQNrS2iqTv+IHo3yYCYxA8NWiocWNJ4k/QgPUuCN2Z9svMxlMDQbm
         +IdvIVGUpRDuPW2qk0wLn2Tiy5Lcfzl5HCjfPHHFg6n6HK/Ci1Vmwnb7fchA6IaJcJ
         Lowf8okB9+79VR1mFitpZ5ax2AnJK76AZdDhDL7HZWy1Ox18eA7Aj+6aQzRcVqRZ8P
         xY3zgF2ro2KSg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
References: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
Subject: Re: [PATCH 0/9] spi: axi-spi-engine: improvements round 2
Message-Id: <170189669029.80266.9452036179086302633.b4-ty@kernel.org>
Date:   Wed, 06 Dec 2023 21:04:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Dec 2023 11:33:26 -0600, David Lechner wrote:
> We are working towards adding support for the offload feature [1] of the
> AXI SPI Engine IP core. Before we can do that, we want to make some
> general fixes and improvements to the driver. In order to avoid a giant
> series with 35+ patches, we are splitting this up into a few smaller
> series.
> 
> This is a continuation of the work started in [2] which has been applied
> to spi/for-6.8 [3]. This series must be applied on top of that series to
> apply cleanly.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/9] spi: axi-spi-engine: return void from spi_engine_compile_message()
      commit: 2e0d75f8dd9e31b3fb175f780494dd7dd988ceae
[2/9] spi: axi-spi-engine: populate xfer->effective_speed_hz
      commit: 9d023ecc31859c7f7c8ca27b5fec52b2dbb8086f
[3/9] spi: axi-spi-engine: remove spi_engine_get_clk_div()
      commit: 1fc8dc5721bbc7a21cb4cc60c35eb8031942542b
[4/9] spi: axi-spi-engine: fix sleep ticks calculation
      commit: be9070bcf67057b7b03c5acc1980d3897448ad20
[5/9] spi: axi-spi-engine: remove xfer arg from spi_engine_gen_sleep()
      commit: e006c181dd9ab006d7b0982d35ef7951fbffe825
[6/9] spi: axi-spi-engine: implement xfer->cs_change_delay
      commit: 125a8390995df1a350e9e16e6da11d010e1e7f76
[7/9] spi: axi-spi-engine: restore clkdiv at end of message
      commit: 3106edac599f59e1298b034a19a43e7da002fccc
[8/9] spi: axi-spi-engine: remove delay from CS assertion
      commit: 0db60d821e485a1c9b8080dbec1ba9871efb6a65
[9/9] spi: axi-spi-engine: add watchdog timer
      commit: 07d33c2810bb5fe67747d11f76980ed68602e287

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

