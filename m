Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34D679D036
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbjILLii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbjILLiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:38:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C9DB3;
        Tue, 12 Sep 2023 04:38:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C19C433C7;
        Tue, 12 Sep 2023 11:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694518689;
        bh=HqZxfW2iBbpiVRi2F/vTM/51WFKhuyoLd1l6HUqtiFE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WKvVApt27IXHRt8l3sIkdIyZIpsKkZI7nMRdsgYqDBGM/qwY+7PiblHq2ZBFfypjL
         dS5ajI36JcbE1Bv3Qks5Cmvqz+VePhsYTJUbPu8RItaKOB3R3c8ihcxS6ga3hzlcxs
         zutXNOfWiBd2YSukUJBHPLIoktajMgvQ62k+5WRe4NAzxCo8xsoI0HKMZ/TI8FFB73
         X+RkrGdTYTydbCCMjCcDEHWFRwJzdCGtxAbTCUhkDNJUUt/bbuADUJLO5XBQ7oey/v
         e0d9w0++6AepMTxHzx8IspNVALlwI715tXrdFAWKUGpN8bPM+3LUdV9q1jVkWHBXN8
         M7vSBKJHP3hVA==
From:   Mark Brown <broonie@kernel.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Apurva Nandan <a-nandan@ti.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        William Qiu <william.qiu@starfivetech.com>,
        Brad Larson <blarson@amd.com>,
        Pratyush Yadav <ptyadav@amazon.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>
In-Reply-To: <20230829062706.786637-1-d-gole@ti.com>
References: <20230829062706.786637-1-d-gole@ti.com>
Subject: Re: [PATCH V2] spi: spi-cadence-quadspi: add runtime pm support
Message-Id: <169451868590.2398433.6752989625702796477.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 12:38:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 11:57:08 +0530, Dhruva Gole wrote:
> Add runtime pm support to cadence-qspi driver, this allows the driver to
> suspend whenever it's is not actively being used thus reducing active
> power consumed by the system.
> 
> Also, with the use of devm_pm_runtime_enable we no longer need the
> fallback probe_pm_failed that used to pm_runtime_disable
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cadence-quadspi: add runtime pm support
      commit: 0578a6dbfe7514db7134501cf93acc21cf13e479

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

