Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B3D7FA137
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjK0Nkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjK0Nkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:40:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6717C3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:40:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C412DC433C7;
        Mon, 27 Nov 2023 13:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701092445;
        bh=A1OsFnb1tNwUij5pGE/EqLpd5k0JhCJWhw9mIA0cyIo=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=EJ2qteMFm/FESMLFKtlGryxNadHIKnXMtpVjE49PbKfsKv6hfBXDpa8ZzckerQr7O
         C+qQTNGuE0s6fQx5ZhxBpwFFzDOY6CfPjL2O0Busbgd8irV06O4FSocP7phdRAziXF
         B1tZVt+3zMvc4gRgvAckG9AwSUQJXjEeioC2g6ILcasLgJ2olwuXjaqFvZMgktoG9q
         KsSo546XHM7i0EJzTL/1bggmb9ClonbEso8FpUABmDlkp5ofb9WeCJrAkw8BMsk54S
         DaT4Ug+ZKmXzHF8xQczUQ0HgUSZYeQO1qA5dQgLVZNvbadQ1g9kB1TNgApA3/tiea4
         fsP0OKC3GwBXw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20231125065300.6385-1-chancel.liu@nxp.com>
References: <20231125065300.6385-1-chancel.liu@nxp.com>
Subject: Re: [PATCH] ASoC: imx-rpmsg: SND_SOC_IMX_RPMSG should depend on OF
 and I2C
Message-Id: <170109244263.2677006.2483367496601425667.b4-ty@kernel.org>
Date:   Mon, 27 Nov 2023 13:40:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2023 14:53:00 +0800, Chancel Liu wrote:
> SND_SOC_IMX_RPMSG should depend on OF and I2C. It fixes the following
> error reported by kernel test robot:
> 
> ld: sound/soc/fsl/imx-rpmsg.o: in function `imx_rpmsg_late_probe':
> imx-rpmsg.c:(.text+0x4f): undefined reference to `i2c_find_device_by_fwnode'
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-rpmsg: SND_SOC_IMX_RPMSG should depend on OF and I2C
      commit: f83d38def6b1b00c9bb17173837045b41df7e7d7

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

