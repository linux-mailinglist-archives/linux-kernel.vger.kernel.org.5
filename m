Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685C2759613
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjGSNAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjGSNAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:00:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3BB11C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:00:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA2FF61626
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCAFC433C8;
        Wed, 19 Jul 2023 13:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689771642;
        bh=vTRTi8gePGQh/v/SApP6VdgisFuhvR4V4ouD65IvxwQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Y0H1OEXL/5HzI2GvKdCbZZ5lX64S2dYzS441FtomQqJZrAdhgYgPTOG3Y9Hcfr9AJ
         SU5+SMqBOXZ6o36ULFel0jrL4YTcPhx73RVmfx0akqMFf/fmQRhtnmGjbYbiLiojCa
         PhvpZTbkq4DFce3erI+clBoPAyZeCQHld7UGFC1neK0n5YZP3X+xpFvL+sb6dOLFiD
         Gu5Dvq6d/v+fvm4IKbYBdRMjYK502U+ONKAB3qKI+OqAiZJzz5SKnaSWpV1aSRViQ6
         PmJAcRx71fbxaO55kKmMs9JB6f3/CITiM2QyxkFABDi2WTRUnHetFqqfguUnei/Q0O
         Lm09LgMRk8E4A==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     lgirdwood@gmail.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20230718003255.124594-1-yang.lee@linux.alibaba.com>
References: <20230718003255.124594-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] regulator: Remove duplicated include in
 mt6359-regulator.c
Message-Id: <168977164102.32923.17335159942963668524.b4-ty@kernel.org>
Date:   Wed, 19 Jul 2023 14:00:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 08:32:55 +0800, Yang Li wrote:
> ./drivers/regulator/mt6359-regulator.c: linux/platform_device.h is included more than once.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Remove duplicated include in mt6359-regulator.c
      commit: 6023fffc3e276d1ab0d1262ea9be3b720325fede

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

