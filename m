Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDF9763F28
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjGZTBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjGZTBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:01:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8E7212D;
        Wed, 26 Jul 2023 12:01:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A201C61C0A;
        Wed, 26 Jul 2023 19:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71471C433C7;
        Wed, 26 Jul 2023 19:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690398088;
        bh=NlpD57Q9uo82dlo2KwzGSqFvnnE9hFFJnOUASgQEM2U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fNzXwah7yJYCua91BM9jXjfkdv4Tw/yCf1sqMY5htOgSrAYbp6a3tCRLWurxwRVp+
         I7MB95PGiR48bVJqUxvVY0kNR5KuF3sW2VRKIpK3+6O93QNo6ZR8wYhhQmqlymcdpF
         VoXhXSNVGduq3rcApXMxnRN2xSgNky6A5LxKqOgFKyjJCa3VvvYppKl66pKWMVLuRt
         nOmUFwzV3K1gMnwsFxDfJtS0/RFyJWO06LCmIThw/DWTooLgApBEk5MwXRqAAFV0CE
         tyOUKsrryPV8Gs8gIBZ0yIA8rHGFNqVXozeHmsg3wxrzPX3quEkTIuyDJ0lVUrAb7R
         tnN+viVjH0eew==
From:   Mark Brown <broonie@kernel.org>
To:     thierry.reding@gmail.com, Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     ldewangan@nvidia.com, jonathanh@nvidia.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <tencent_71FC162D589E4788C2152AAC84CD8D5C6D06@qq.com>
References: <tencent_71FC162D589E4788C2152AAC84CD8D5C6D06@qq.com>
Subject: Re: [PATCH v2] spi: tegra20-sflash: fix to check return value of
 platform_get_irq() in tegra_sflash_probe()
Message-Id: <169039808617.123111.4823461346107082698.b4-ty@kernel.org>
Date:   Wed, 26 Jul 2023 20:01:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jul 2023 23:49:09 +0800, Zhang Shurong wrote:
> The platform_get_irq might be failed and return a negative result. So
> there should have an error handling code.
> 
> Fixed this by adding an error handling code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra20-sflash: fix to check return value of platform_get_irq() in tegra_sflash_probe()
      commit: 29a449e765ff70a5bd533be94babb6d36985d096

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

