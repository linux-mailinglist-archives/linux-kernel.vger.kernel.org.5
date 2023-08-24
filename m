Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EA3787B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243950AbjHXWoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243908AbjHXWnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:43:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A93B1BF1;
        Thu, 24 Aug 2023 15:43:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A1F06370C;
        Thu, 24 Aug 2023 22:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4231C433C8;
        Thu, 24 Aug 2023 22:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692917015;
        bh=hQ1fgLiWLR8trUuCaYLEOSHIOYHu6hkDSCVcbXCSY+k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rrZfqM18bVtzaiGaUuKP9b7xmnkXs8g8c3wSLjDJ9HzgvNmH1i2m8emrAWI22C21D
         FHYQa5K/Xvxz9/lDO7HHXUlWLdV4vvrN94IQYKumiqfmDGWUwd2FRaogmS2/L1lAyi
         /tjXD+/k1vOAQnMppF2o5IP53a9TV3sg6ePYqRXorT/qChWJ7NDY6HbXzwUDBLrvST
         E9uKOIjPBXdr59q5RMQ4zTSCflL+vR7vf98eVvLDQWmMa9ieWWehqU5DUZKQc7WHUH
         iOQYoLdmjWSg9RSQtPTAiQZ4EETCktewKG8lTbcdwEkJRUNOdtKrYgvLHhLL2M2sbt
         qPvBqcszAOpEA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Weidong Wang <wangweidong.a@awinic.com>,
        Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, kernel test robot <lkp@intel.com>
In-Reply-To: <20230824191722.2701215-1-harshit.m.mogalapalli@oracle.com>
References: <20230824191722.2701215-1-harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH next] ASoC: codecs: Fix error code in
 aw88261_i2c_probe()
Message-Id: <169291701152.2997200.14506800052724539808.b4-ty@kernel.org>
Date:   Thu, 24 Aug 2023 23:43:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 12:17:10 -0700, Harshit Mogalapalli wrote:
> Passing zero to dev_err_probe is a success which is incorrect when
> i2c_check_functionality() fails.
> 
> Fix this by passing -ENXIO instead of zero to dev_err_probe().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Fix error code in aw88261_i2c_probe()
      commit: 8886e1b03669c498f7a24bc5e483f46db5e81f82

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

