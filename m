Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E43770676
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjHDQ50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjHDQ5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:57:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503DB1994
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:57:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1B1B620B9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 16:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FE6C433C7;
        Fri,  4 Aug 2023 16:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691168243;
        bh=H2I4zXc2nLBpbMumRh3ZQqMyQSqwTBBH0hegTbmAV9Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ON1ljACxay13fH0eKtcQ0sm0HX+oy8oRyda6c84If7cwkab2VpSxBcYtJEnF6Zly4
         jnkWppiPqZC/aQPdeuVtXbaUT2gf7JFSaXXaouS9n1YsRQziu6A1cwv27QcDIDi9y8
         kofabDzbls8cWDGOERnWZ5dnGOYT/HJpdkIf2lI/dCTiC4xdFmvak8Dxfbv5g44+2m
         A2FQxuSRLUjQdwO+Rzqfj3UYeVlOYAObgAFnBDLACy1DTaDaEh0vzgpvf08KObYXwP
         24LPhGPKMJ9gi1oAgH9rYZSoyaolkdPXSXyx6cf7vTgNGcfMRxMdDibJfdWu6sV6QB
         EodIsV8ebMTRQ==
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Fabio Estevam <festevam@denx.de>
In-Reply-To: <20230803215506.142922-1-festevam@gmail.com>
References: <20230803215506.142922-1-festevam@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: wlf,wm8960: Describe the power
 supplies
Message-Id: <169116824118.110745.15372323880400701432.b4-ty@kernel.org>
Date:   Fri, 04 Aug 2023 17:57:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Aug 2023 18:55:05 -0300, Fabio Estevam wrote:
> WM8960 has the following power supplies:
> 
> - AVDD
> - DBVDD
> - DCVDD
> - SPKVDD1
> - SPKVDD1
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: wlf,wm8960: Describe the power supplies
      commit: 6a41c3a1606089bdf7f8da2b267d1d82fb32b378
[2/2] ASoC: wm8960: Add support for the power supplies
      commit: 422f10adc3eb5a7ff8567bf6e6590a4e4fa756c3

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

