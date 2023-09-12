Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A8079D037
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjILLiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbjILLiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:38:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725461722;
        Tue, 12 Sep 2023 04:38:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C8EC433C9;
        Tue, 12 Sep 2023 11:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694518693;
        bh=h30b56RrRORKmlU4pC18wtn1e1EQ/8raoGBkCT361sM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=K4YOz5hNZrqjLdTbhxxFHvS2l4kzfDALcCAxmSU6AUaAhJs3afTFzWBtzbY+FWOxd
         /LGrRgZYBnek1Y85XT26sSfS+eQZx6uc12ooEAvV0IOKlY80nX6tskwzTg9/c85ymE
         fQR+hvjnHnkdHiKCPwux7J790Kwu8YmOkreruYmvpvOItqfLUd8BZ26bSLqzzyN3Zg
         zCoyLw9u9CzQSwSzcKK9W/bxFVRJexG48oHeaNiGi0+xm+32KnoedCoKgMt+96CqjN
         eAM/NEjdZ7OShOMnE8pBTH8fYY5cGDez5JMFmGUXsiLaRmr+iGRqetl+dVbMtbQu1S
         AsIApVkwkhzxQ==
From:   Mark Brown <broonie@kernel.org>
To:     ldewangan@nvidia.com, Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, sumit.semwal@linaro.org,
        christian.koenig@amd.com, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
In-Reply-To: <tencent_73FCC06A3D1C14EE5175253C6FB46A07B709@qq.com>
References: <tencent_73FCC06A3D1C14EE5175253C6FB46A07B709@qq.com>
Subject: Re: [PATCH] spi: tegra: Fix missing IRQ check in
 tegra_slink_probe()
Message-Id: <169451868918.2398433.15693451802537494964.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 12:38:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Aug 2023 18:02:54 +0800, Zhang Shurong wrote:
> This func misses checking for platform_get_irq()'s call and may passes the
> negative error codes to request_irq(), which takes unsigned IRQ #,
> causing it to fail with -EINVAL, overriding an original error code.
> 
> Fix this by stop calling request_irq() with invalid IRQ #s.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra: Fix missing IRQ check in tegra_slink_probe()
      commit: eb9913b511f10968a02cfa5329a896855dd152a3

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

