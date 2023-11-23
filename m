Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B777F64A0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345420AbjKWRAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjKWRAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:00:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D791E10F0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:00:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15857C433CC;
        Thu, 23 Nov 2023 17:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700758811;
        bh=8F/jiguRcq32VOINzefmDyYIkXt/3k3NK5/RQR1wYU0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MtCQPBEXWTX4xUsNeYiJze7scCumxb+pLoonCyIRI3n/ioJzllWZCfbTm679Z2sxX
         KSA/OIwXxihNsDYi5Tw8H+l7+2FnI0exz8p3+aDp/ZCcqWyK2WGR0VRKyiuMgGLdQ6
         MKe4G90ieENhC5dz5UVGt8ezJ72xxQHe2Sk82kBZcDvDY8XEMWkrgtBpav1ePSDfOH
         30lmj1nMaq4fA0VJLGrPHFNXsv95i5MbNcKDnwvG4C0jOmX4xm458D68Z6PEuf1vXl
         mWjeZPv/Xo2xWEhFc8GMXsJPfXtYP/jrAU3hcPKeYRSCmxbkeK7lYzbTQz8H10G6wJ
         vc7V4ZGJIRHHQ==
From:   Mark Brown <broonie@kernel.org>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1700702093-8008-1-git-send-email-shengjiu.wang@nxp.com>
References: <1700702093-8008-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: refine the requested phy clock
 frequency
Message-Id: <170075880893.2448402.4841454362054924374.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 17:00:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 09:14:53 +0800, Shengjiu Wang wrote:
> As the input phy clock frequency will divided by 2 by default
> on i.MX8MP with the implementation of clk-imx8mp-audiomix driver,
> So the requested frequency need to be updated.
> 
> The relation of phy clock is:
>     sai_pll_ref_sel
>        sai_pll
>           sai_pll_bypass
>              sai_pll_out
>                 sai_pll_out_div2
>                    earc_phy_cg
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_xcvr: refine the requested phy clock frequency
      commit: 347ecf29a68cc8958fbcbd26ef410d07fe9d82f4

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

