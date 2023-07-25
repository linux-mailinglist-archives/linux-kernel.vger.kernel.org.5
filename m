Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640E57621E1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjGYS6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjGYS6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:58:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6FB2683;
        Tue, 25 Jul 2023 11:58:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3D46617D5;
        Tue, 25 Jul 2023 18:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34A3C433C8;
        Tue, 25 Jul 2023 18:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690311500;
        bh=oyt2/tFyYF+r1U4h34jjcJ06uwzY7XrZZs1rwMz0yyA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OY5IimFHnNniMNm4hhmV2tgQ0Xl6aBa3U+bovRx+IckroDGJsdxP+dV5PE43fTjyg
         qF8tH9j90WCCTz5Q27jfSj1zgSzaUgYIPSVEeB+g0j0Ja9DDMnM9r6uul5T3Xy0EW8
         0/LW0rWXSbAVAIw+OhFPckeCCVrq/Zdqj97o7Yvg7y72Xbd1NLdufuIVNcgrvy/ILc
         Dycf9G7+7JR0IKwMrmDzQjkLhDsHsTgc1dD08JJmFoirTWpKJSopyskJaPx6aeUf1y
         UscNw3i9gGAsG68aEnKeD4VaB0wmAcIlS3e3flJBOLGLrY1f5qCMTHqvOVT5KuJh0L
         oJ1xfgGyLsbkg==
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230725135411.21152-1-yuehaibing@huawei.com>
References: <20230725135411.21152-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] spi: fsl: Remove unused extern declarations
Message-Id: <169031149939.1603510.6271194546109675378.b4-ty@kernel.org>
Date:   Tue, 25 Jul 2023 19:58:19 +0100
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

On Tue, 25 Jul 2023 21:54:11 +0800, YueHaibing wrote:
> commit b36ece832512 ("spi/mpc8xxx: refactor the common code for SPI/eSPI controller")
> left mpc8xxx_spi_bufs() behind.
> And since commit 3c5395b66ff6 ("spi: fsl-(e)spi: simplify cleanup code")
> mpc8xxx_spi_remove() is not used anymore.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsl: Remove unused extern declarations
      commit: 7ad1c439fb25907dba31af5d66b44c6a3b999c89

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

