Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E777756F3A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 23:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjGQV7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 17:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGQV7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:59:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E223DE52
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:59:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6743F612B2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 21:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7A9C433C8;
        Mon, 17 Jul 2023 21:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689631174;
        bh=OWdGYkH1Y1wnTjNRzoIEt/5CVyG2Gp3bhfXqsNkoW0M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NDRrpCzxZK/xlB9IdhsJCV4cGza+0iHlqW6RUVfMWZhecHzkSehwR0EMqqACY5PPS
         Tj84brPayTvK+JmCFrMAbAr0AtHOmOPqMPDcCecfoMMFeuLBUh0MXvzEFHg75LR6Sp
         9MKOr3JJNEvxOv2q/hmpEcEgd6jn4LSlDA3ZcLeb4R/QWl9nTMazRSpMXeHb65NXEH
         Ecc3yV7A1ZBJPpae+ymy4Z45uH5T775qrCJyS9txlaT5clcv9usUw8zIF4gumgWzHG
         zEz3j/Tcoj7R6r5Bv2FZazbPYM2y0iLzjPzgCXci43p8Pv7IG/x9EHZp8UX8O+p2Fy
         6LaFK4dLMRmOA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Yangtao Li <frank.li@vivo.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230711034846.69437-1-frank.li@vivo.com>
References: <20230711034846.69437-1-frank.li@vivo.com>
Subject: Re: [PATCH 1/5] ASoC: bcm: bcm63xx-i2s-whistler: Convert to
 devm_platform_ioremap_resource()
Message-Id: <168963117327.522208.7041227342789834630.b4-ty@kernel.org>
Date:   Mon, 17 Jul 2023 22:59:33 +0100
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

On Tue, 11 Jul 2023 11:48:41 +0800, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: bcm: bcm63xx-i2s-whistler: Convert to devm_platform_ioremap_resource()
      commit: 7562539e15f1376577d7b62e904b509d17c4bc3f
[2/5] ASoC: ti: Convert to devm_platform_ioremap_resource_byname()
      commit: c8b04f008fc33ab2b902a1780c205810d157c849
[3/5] ASoC: mediatek: mt8186: Convert to devm_platform_ioremap_resource()
      commit: e1537b59633cc0e30305e498ba9eead45e762910
[4/5] ASoC: pxa: Use devm_platform_get_and_ioremap_resource()
      commit: 97b19db1cfb34303101a3f30c26ef0e2ede07d89
[5/5] ASoC: tegra: tegra20_ac97: Use devm_platform_get_and_ioremap_resource()
      commit: 976201dd5f597b7c25b9fc5ebeee382b5e6bf8fb

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

