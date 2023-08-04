Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7890877087F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjHDTFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjHDTEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:04:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B364C05;
        Fri,  4 Aug 2023 12:04:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D559C62103;
        Fri,  4 Aug 2023 19:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508E0C433CB;
        Fri,  4 Aug 2023 19:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691175869;
        bh=520B+rY2lic+DubRUABO4/l2XzI3W+yK1LeWrhQ29eQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UAcT9Ac3f8LkU11WSIvLmbMd4Ufi9ds698gVhlwy5RpKng8fUTcV1gqP/wxN5ipWN
         icn5qzNMqe3SeKN2HKV9eF9C9TBZOpO8MIVOS8++eu3sv2lFACFEGnKDmR8UvUm6PZ
         11ynCvJQPV0g6FHw4TG+zJhUV+xmthHsu0sIgz3iD0/E4HHxR/wbcfJAdmXw/BSCCp
         qf3HxbN678i1eRa/LSqN9RC46iIXsKSm+f41MncnNp7SZno78ZWsa+L1AO6O4Eoscm
         ZobGhqn08B/bh76FbWCqtQvW83eereBKB1k1wIRPY2lNTzLVlJdR/BJ4BEjXUEDEJK
         jCPv/oC0NpLXA==
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        William Qiu <william.qiu@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
In-Reply-To: <20230804020254.291239-1-william.qiu@starfivetech.com>
References: <20230804020254.291239-1-william.qiu@starfivetech.com>
Subject: Re: (subset) [PATCH v6 0/3] Add initialization of clock for
 StarFive JH7110 SoC
Message-Id: <169117586705.140468.16858943354312367424.b4-ty@kernel.org>
Date:   Fri, 04 Aug 2023 20:04:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Aug 2023 10:02:51 +0800, William Qiu wrote:
> This patchset adds initial rudimentary support for the StarFive
> Quad SPI controller driver. And this driver will be used in
> StarFive's VisionFive 2 board. In 6.4, the QSPI_AHB and QSPI_APB
> clocks changed from the default ON state to the default OFF state,
> so these clocks need to be enabled in the driver.At the same time,
> dts patch is added to this series.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] dt-bindings: qspi: cdns,qspi-nor: Add clocks for StarFive JH7110 SoC
      commit: 0d2b6a1b8515204924b9174ae0135e1f4ff29b21
[2/3] spi: cadence-quadspi: Add clock configuration for StarFive JH7110 QSPI
      commit: 33f1ef6d4eb6bca726608ed939c9fd94d96ceefd

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

