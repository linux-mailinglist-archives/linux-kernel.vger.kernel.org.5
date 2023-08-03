Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDC376EFB8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjHCQkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbjHCQkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:40:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA0FE4D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:40:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47BDC61E0C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 16:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12232C433C7;
        Thu,  3 Aug 2023 16:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691080809;
        bh=VFJ1bf0AHCEbDnDRiBEgNEEgb3tqaVrFtFbqBlQF1Jk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jXrIcou/yNvIPBXif/mS6luiH22zfzXvljOXuJFLZq1A5fZLz/YVWqC8qLkZYNEU/
         J9LoWb9k9KawjboKBYPzHyoXai51JUegCYlVhsZGxqT80KhnHFa8R+zbHdFM4tcP6q
         SX0pQ4hRAlv5vQOb0Vf5VdcC3PgcSKSwkIlqDYW/v/OicU0/BJW8nrWd7GPXqLuUqT
         tN0dc2ocgr57cAKzJ9IBbk5vYtuWTZ8OMVxFsFoQTLqLIL8Jkc5JXV2AWpA2Q7nXiL
         pDjFLZU8CtT3+k11eh7YwMroG6fntz8IPIwhXq2MRqH8OD8UlHx5EjSnIJW1l1H9KJ
         ioIXzAAOhNH5A==
From:   Mark Brown <broonie@kernel.org>
To:     shengjiu.wang@gmail.com, alsa-devel@alsa-project.org,
        Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
In-Reply-To: <20230803072638.640789-1-daniel.baluta@oss.nxp.com>
References: <20230803072638.640789-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH] ASoC: fsl: micfil: Use dual license micfil code
Message-Id: <169108080679.93395.2068713603234427453.b4-ty@kernel.org>
Date:   Thu, 03 Aug 2023 17:40:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Aug 2023 10:26:38 +0300, Daniel Baluta wrote:
> We need this in order to easily reuse register definitions
> and some functions with Sound Open Firmware driver.
> 
> According to Documentation/process/license-rules.rst:
>     "Dual BSD/GPL"	The module is dual licensed under a GPL v2
> 			variant or BSD license choice. The exact
> 			variant of the BSD license can only be
> 			determined via the license information
> 			in the corresponding source files.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: micfil: Use dual license micfil code
      commit: f803ec63686dec863a33cad87218d7d99c4b5e92

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

