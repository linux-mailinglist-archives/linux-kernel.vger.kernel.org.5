Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C624F759F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjGSUBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjGSUBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:01:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F31F1FE9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:01:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A1F9617F4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 20:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B31C433C8;
        Wed, 19 Jul 2023 20:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689796907;
        bh=w2xExNL6EbofhaPL7HrdC2dQl+hHtjTWHi8Iv1ep0XM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bcTlPpPYAYmB2sS5fUgqGZUU3FJICfaHN5WbE7TGHrxRYFbYb08wO2sohI7OddFUT
         pwKL5HrnkJPeEpRx3gngzC63J27H+jVm1ZhEqqFCeZ4T7vR8Ea3fvm4/GOICqQ4mqK
         NHLz6DQ2xvaokv+q7OVorcg5ORkWMbT0MU5y9TuLd9qt1G/8qQnmFEt5DWUiv/ULgg
         l6nYmC5JAWfo3Tfl7wFAXkvaXvm7D4qXK2lE3S+VxFSRrMGB9omCjpsfDUZ5HgDhNn
         BedXC2DS3xEVCLkKF8mEw7Xsh/XqC79MMe4Y+AbMWACLcGez8yBsTZlvGez+jUma+s
         thMkIBC5WTkwA==
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matus Gajdos <matuszpd@gmail.com>
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230719163154.19492-1-matuszpd@gmail.com>
References: <20230719163154.19492-1-matuszpd@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Add support for 22.05 kHz sample rate
Message-Id: <168979690540.180044.4033002873442934544.b4-ty@kernel.org>
Date:   Wed, 19 Jul 2023 21:01:45 +0100
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

On Wed, 19 Jul 2023 18:31:53 +0200, Matus Gajdos wrote:
> Add support for 22.05 kHz sample rate for TX.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: Add support for 22.05 kHz sample rate
      commit: 65bc25b8d0904e0aff66b1c3a9dd4c0dcb8efbf1

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

