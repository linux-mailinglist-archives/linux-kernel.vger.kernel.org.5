Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F202C7731B9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjHGV5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjHGV5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:57:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA44AA8;
        Mon,  7 Aug 2023 14:57:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 490AF6228D;
        Mon,  7 Aug 2023 21:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC70C433C7;
        Mon,  7 Aug 2023 21:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691445452;
        bh=Hjr9TC5T/2rdK2wbUjAujziz8ImCXcl8RITuuGXMqSk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Im0t4U06DzMB4wtkyZXrmkFPUAX3Fxpyy0MDNdyekL5M8fCCdm9IruGDp55cDUa2w
         +4hYC7Lt2/hI5/bWH9o/ATBup8f0cH//laVEISqdoteME7mL9Wx0x5wW66Huqywfh1
         eOI7UhXge1+CKSoneaH9ALInBa+g8+qiVziGELnC3q7YZs57nWrupd2RwZlptO1IxA
         IkmvQ+LuA1Vzy9Z0jgQfMRuYdmtzrgwdgsjhYonsOh8PX91D+K8rpuHYeGCPhd9ZPa
         UYQigIMTSBeBsUyX7cXNbClECaSC6tBL2hPVuKPanreOgnJsPwDJfsNR+YicvABe02
         5sSPavZGYoiRA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        coolrrsh@gmail.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org
In-Reply-To: <20230806083734.7685-2-coolrrsh@gmail.com>
References: <20230806083734.7685-1-coolrrsh@gmail.com>
 <20230806083734.7685-2-coolrrsh@gmail.com>
Subject: Re: [PATCH v3] spi: spi-mpc52xx-psc: Fix an unsigned comparison
 that can never be negative
Message-Id: <169144545157.329334.2631329470445507219.b4-ty@kernel.org>
Date:   Mon, 07 Aug 2023 22:57:31 +0100
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

On Sun, 06 Aug 2023 14:07:34 +0530, coolrrsh@gmail.com wrote:
> In struct mpc52xx_psc_spi, the variable 'irq' is declared as an unsigned int.
> The comparison of variable 'irq'  with signed int operand is incorrect. Also,
> the return value from the call to platform_get_irq(pdev,0) is int and it is
> assigned to an unsigned int variable 'irq', thus redeclaring the type of
> variable 'irq' to signed int.
> 
> This fixes warning such as:
> drivers/spi/spi-mpc52xx-psc.c:332:5-13:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mpc52xx-psc: Fix an unsigned comparison that can never be negative
      commit: 4f5177458ba97734149897c5d4d44f85b8fe0348

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

