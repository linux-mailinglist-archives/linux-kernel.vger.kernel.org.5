Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638B2761F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjGYQuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGYQuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:50:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B17359F;
        Tue, 25 Jul 2023 09:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDC6A617F3;
        Tue, 25 Jul 2023 16:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77FBC433C8;
        Tue, 25 Jul 2023 16:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690303774;
        bh=L4VvWc/XpiKpMxRX4WTAwtabVH7J0IT0oNOuEjjs92A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tl8a1jwSsPzW+8j4I2mT6JhlGUVLWHQEBBw+t4rtlyfhcVkvo95n0oiVHGQJmkYHk
         b8LjUZEGM0qlPVHPxbk+c7DJpPtCfbcWAbKTgihj+KvBcC/a9Bw4Yu0MbT7EZGW8ER
         76zq6mgEZ7vzJLIY5xS3OVo1GdU5eS/TbJNje/rWablIwmnAiqO+QlK8iqrsbjUVaP
         fVZ1nCCfvimonAU++LMLp3eVtMKJ1TZKu/arY+m0eE3iIHVOLI4HyTH2NqYJJ7dZZd
         DVAAlmiiNqHr2jy/tz6n1YPA+k5+EmtkAd74L4tmD+rNU2/glLSbZPIHMKRPBFABDo
         CjKFCrt/EBN8w==
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Minjie Du <duminjie@vivo.com>
Cc:     opensource.kernel@vivo.com
In-Reply-To: <20230725035038.1702-1-duminjie@vivo.com>
References: <20230725035038.1702-1-duminjie@vivo.com>
Subject: Re: [PATCH v2] spi: fsl-dspi: Use dev_err_probe() in
 dspi_request_dma()
Message-Id: <169030377267.1485233.13435532825497669475.b4-ty@kernel.org>
Date:   Tue, 25 Jul 2023 17:49:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 11:50:37 +0800, Minjie Du wrote:
> It is possible for dma_request_chan() to return EPROBE_DEFER, which means
> dev is not ready yet.
> At this point dev_err() will have no output.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsl-dspi: Use dev_err_probe() in dspi_request_dma()
      commit: 908e5a3d4e6f60fa2d3912be7087e745639c4404

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

