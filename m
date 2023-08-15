Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D14577D5E7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbjHOW01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239901AbjHOW0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:26:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB111BFF;
        Tue, 15 Aug 2023 15:26:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BEEE65889;
        Tue, 15 Aug 2023 22:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8864C433C8;
        Tue, 15 Aug 2023 22:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692138372;
        bh=u2J4cNbfgmIria82Y3J0jLrhx8mOHkmzVpXhhmJA2WM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sCJobSim8wHHtRQD2nFFH7shET9cdvtLzorIH4WQs6YsaftFgnSlEL1nT+c+V5cAI
         pzlbxIj20k5Xtp8nfsdUxaL1GTqoWYOkAC/QlmahxgbQbGdKaa8VARWyG/7S/pN+/q
         ZgjT7KqIlMSg5NbbVxBvPXQ4NCK6RVvmQmJz2ZiE5gik0h4uEr8ZbN1Y3HRlSdWsDq
         KXXSx419HySmhb9ZL5n96wMkDwdn5vLzTr3WPVj4NKMLYCe8CyaY5qc386b6jh7UfY
         V2aawopG27EPmKJLvwQePdvGi9tYv3U9sXktvIBwP0q53gCqwHF6CZmK8MhuH/IIaX
         fjFYE2ObaIGAA==
From:   Mark Brown <broonie@kernel.org>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Alexander Danilenko <al.b.danilenko@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mason Zhang <Mason.Zhang@mediatek.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
In-Reply-To: <20230815092058.4083-1-al.b.danilenko@gmail.com>
References: <20230815092058.4083-1-al.b.danilenko@gmail.com>
Subject: Re: [PATCH] spi: tegra114: Remove unnecessary NULL-pointer checks
Message-Id: <169213837054.1140278.3526955853668228356.b4-ty@kernel.org>
Date:   Tue, 15 Aug 2023 23:26:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 12:20:58 +0300, Alexander Danilenko wrote:
> cs_setup, cs_hold and cs_inactive points to fields of spi_device struct,
> so there is no sense in checking them for NULL.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra114: Remove unnecessary NULL-pointer checks
      commit: 373c36bf7914e3198ac2654dede499f340c52950

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

