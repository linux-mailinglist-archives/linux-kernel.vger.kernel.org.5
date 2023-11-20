Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF857F1C54
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 19:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjKTSZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjKTSZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:25:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E7EBA;
        Mon, 20 Nov 2023 10:25:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F0AC433C8;
        Mon, 20 Nov 2023 18:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700504731;
        bh=as2dbUTr2gNO04DeNirVthyfOLxUPxnlg0uKWaOAmZM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pGFme15I/7EO/N83buPkLNI8XbleJ8CmZwuIA+1oqGpiMoj/BXtSlEhokxn7o3yyZ
         LSZGQU2f2LexbTP/1Un3T0Ra+4vIvjfo+sCV3HkW5ckCdBEuFbH8j3S7K22rDEPkN9
         Ee/ZYrMiPGQAKZtxHZGWfxx33Pv7u02sKbP9vO8WFYrIyrC8+iRg1Ey+ibW3PWxgBQ
         I+DPxFcNrnlM2mHfvDp/STdffotW0Skypuyrva/NNHmaFtyxKOpwsyweZHwIBnVLEe
         yGLD6PYCQTa16XoM0wNn8pIRRXuULxaIgDfJeUkK+mz1o34c7XKdJmQhl9+sYYZP6u
         2SLkFoxLrLKcQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        David Lechner <dlechner@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com>
References: <20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com>
Subject: Re: [PATCH 00/14] spi: axi-spi-engine improvements
Message-Id: <170050472905.1279900.9950571556987188981.b4-ty@kernel.org>
Date:   Mon, 20 Nov 2023 18:25:29 +0000
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

On Fri, 17 Nov 2023 14:12:51 -0600, David Lechner wrote:
> We are working towards adding support for the offload feature[1] of the
> AXI SPI Engine IP core. Before we can do that, we want to make some
> general fixes and improvements to the driver. In order to avoid a giant
> series with 35+ patches, we are splitting this up into a few smaller
> series.
> 
> This first series mostly doing some housekeeping:
> * Convert device tree bindings to yaml.
> * Add a MAINTAINERS entry.
> * Clean up probe and remove using devm.
> * Separate message state from driver state.
> * Add support for cs_off and variable word size.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/14] dt-bindings: spi: axi-spi-engine: convert to yaml
        commit: 252eafe11ffc032579a56c7a29faa8431785a91e
[02/14] MAINTAINERS: add entry for AXI SPI Engine
        commit: 68539d1803476b4ecd403c126aa74b9f25b45f2b
[03/14] spi: axi-spi-engine: simplify driver data allocation
        commit: 9e4ce5220eedea2cc440f3961dec1b5122e815b2
[04/14] spi: axi-spi-engine: use devm_spi_alloc_host()
        commit: e12cd96e8e93044646fdf4b2c9a1de62cfa01e7c
[05/14] spi: axi-spi-engine: use devm action to reset hw on remove
        commit: e094de13ae78035c5642d5dfc65b07301765eebc
[06/14] spi: axi-spi-engine: use devm_request_irq()
        commit: 076f32d5db73f16c95b38149f9168210cf267b33
[07/14] spi: axi-spi-engine: use devm_spi_register_controller()
        commit: e16e71e3f3c4b73b20f8c79f7ce8465542a337e9
[08/14] spi: axi-spi-engine: check for valid clock rate
        commit: e6d5eb85e84aeace5e231b951ece86b20df9f63a
[09/14] spi: axi-spi-engine: move msg state to new struct
        commit: 7f970ecb77b6759d37ee743fc36fc0daba960e75
[10/14] spi: axi-spi-engine: use message_prepare/unprepare
        commit: 0c74de5c6853b0e83413ad237867a37ba30ef3f9
[11/14] spi: axi-spi-engine: remove completed_id from driver state
        commit: 4a074ddeb90f5e81738b401643651b2dea257f57
[12/14] spi: axi-spi-engine: remove struct spi_engine::msg
        commit: 4e991445478c6404a6846928093837249c52694a
[13/14] spi: axi-spi-engine: add support for cs_off
        commit: 145bb2aedb9f78f290c2b5503b553894a6ec53fe
[14/14] spi: axi-spi-engine: add support for any word size
        commit: d861b417e1893a46c63cef2cb46d3587da1e5b15

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

