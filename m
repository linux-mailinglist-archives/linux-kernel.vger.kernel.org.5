Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0D3762727
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 01:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjGYXBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 19:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjGYXBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 19:01:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5861988
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 16:01:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 633AE61938
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE28C433CB;
        Tue, 25 Jul 2023 23:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690326079;
        bh=4HiJelTa8ResVo7/8HpQcSPN/CxrRNPiwChvHZoXin0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=C+G0MsyUwc42y7QdibZEGZ6l5zc25/8SuCVj9NKvX7And9VDdO71gqlqPaejOkOhQ
         aQqSFRdSY7XGahfvw5RKf+oE18vSfIJqmmHzv7Wj5l8M/h/5V86/T7+ijmqk4J8Qvi
         5ZykJ/2ZhKIPxfJNRsMTay8MzYSyFj5DNMxbF1OiF6GuOUJycsfBELVe84xP6wvq+h
         7vqIu/maFt1ww2c3BIwHzm8G4kOBgK8EJC6HYhhjOM3IUsCVMXfQ/9R6EQYvy1V03F
         2TJgHbt8O4Ea1IDGMwKRwEboCK2phDPU9hI/+RqDA7MyoXmcl4IfdayoRgF59JcL9g
         q+h8YWNchspkA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <60938ed138c9331ba3d2891fbd3b3d6644d3fbdc.1690300012.git.geert+renesas@glider.be>
References: <60938ed138c9331ba3d2891fbd3b3d6644d3fbdc.1690300012.git.geert+renesas@glider.be>
Subject: Re: [PATCH] regulator: REGULATOR_QCOM_REFGEN should depend on
 ARCH_QCOM
Message-Id: <169032607868.1636970.13143338092275363376.b4-ty@kernel.org>
Date:   Wed, 26 Jul 2023 00:01:18 +0100
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

On Tue, 25 Jul 2023 17:47:43 +0200, Geert Uytterhoeven wrote:
> The Qualcomm MMIO-mapped reference voltage regulator is only present on
> Qualcomm SoCs.  Hence add a dependency on ARCH_QCOM, to prevent asking
> the user about this driver when configuring a kernel without Qualcomm
> SoC support.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: REGULATOR_QCOM_REFGEN should depend on ARCH_QCOM
      commit: 6b677c1ae8e4096c84fbcbe1b7fd300dab0b381b

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

