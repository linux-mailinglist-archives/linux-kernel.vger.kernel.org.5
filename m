Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B7A7F18A8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjKTQca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKTQc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:32:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7CA9E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:32:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E810C433C7;
        Mon, 20 Nov 2023 16:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700497945;
        bh=Eg3tImi0mkQCJ6HTRCQEvLgTbOvveHdT1JhyGy7bH0s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HUHEghF6E+qzSd15aJUyYWeSJUKsr1IzS9i9+xZxN4m8pOdmEhBkgF/ISiGsBlND+
         dCcapm+e1iIIJnU51NzBR3P2CPc1AO2o08miWDdxmUJikvKrUFmPlioKQXTKcFuayc
         cKOxL4Rqeg22g3QB+syVToGk/e9mVk0uTjfnjWXTqGIuOhodjPLJGcKNEfpO/QUm6B
         +3tMTN4WAErI05g0qQzuQvCJVjmtRgAiCreuUUVcb0DTKKB5xLdkjVXMdOBzhm92QT
         Tp54ztVpTQ3lXxbn6EGSAXN3XJK8wX26PYZzvO79/IgAIlcDEV9scCG9r0BYNo1PZd
         3emMAV6c/euTA==
From:   Mark Brown <broonie@kernel.org>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1700474735-3863-1-git-send-email-shengjiu.wang@nxp.com>
References: <1700474735-3863-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Fix no frame sync clock issue on
 i.MX8MP
Message-Id: <170049794283.439381.10112729019532929436.b4-ty@kernel.org>
Date:   Mon, 20 Nov 2023 16:32:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 18:05:35 +0800, Shengjiu Wang wrote:
> On i.MX8MP, when the TERE and FSD_MSTR enabled before configuring
> the word width, there will be no frame sync clock issue, because
> old word width impact the generation of frame sync.
> 
> TERE enabled earlier only for i.MX8MP case for the hardware limitation,
> So need to disable FSD_MSTR before configuring word width, then enable
> FSD_MSTR bit for this specific case.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Fix no frame sync clock issue on i.MX8MP
      commit: 14e8442e0789598514f3c9de014950de9feda7a4

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

