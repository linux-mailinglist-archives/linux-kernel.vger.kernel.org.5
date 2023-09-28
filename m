Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7064B7B201D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjI1OvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjI1OvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:51:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A9B19E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 07:51:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561DEC433C8;
        Thu, 28 Sep 2023 14:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695912678;
        bh=vtAG6cN4FFihjCJoKNItIO/oCqZM7u5zMuURdQJMWd4=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=mrJ3s6DZjF8wixjaOzrLe9Udx9g8i1HtTEMgowCifYnZOr1hb79Bz/WtbZH8A7nSg
         Ch35Aw6rP6UOhmn6Os7pCePBfwIdgUhl4Hm2vuMpT6GokC4VIZ7nnlEbVTs9wkXBwD
         afpx/jy8qCRD6Q5ftt8RCg1AIdOnPDJ6+ilHhiULkIxBiMYx2H1FUoKfKkuAx/dlMM
         hTtw5hcJmI8UM2Seaabk5NM/Kw4MaMHEiKuOFmQ76jBOIN3Ghlh20mgYZc+J0H2abh
         ZwXJNA3I+QAkEDuk9ar7XJb7uzBn8X5ZdpAhijqgvpnqBDNkHerrO+7pq9I461eI6b
         x237b0Ph/d13g==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.com,
        herve.codina@bootlin.com, shumingf@realtek.com,
        ryans.lee@analog.com, 13916275206@139.com,
        linus.walleij@linaro.org, ckeepax@opensource.cirrus.com,
        povik+lin@cutebit.org, harshit.m.mogalapalli@oracle.com,
        arnd@arndb.de, yijiangtao@awinic.com, yang.lee@linux.alibaba.com,
        liweilei@awinic.com, u.kleine-koenig@pengutronix.de,
        colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangweidong.a@awinic.com
In-Reply-To: <20230919105724.105624-1-wangweidong.a@awinic.com>
References: <20230919105724.105624-1-wangweidong.a@awinic.com>
Subject: Re: [PATCH V4 0/7] ASoC: codecs: Add aw87390 amplifier driver
Message-Id: <169591267537.2776105.6073100654657258877.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 16:51:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023 18:57:17 +0800, wangweidong.a@awinic.com wrote:
> The awinic aw87390 is a new high efficiency, low noise,
> constant large volume, 6th Smart K audio amplifier.
> 
> Add a DT schema for describing awinic aw87390 audio amplifiers.
> They are controlled using I2C.
> 
> v3 -> v4: Divide the changes of aw88395 into multiple patches
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: dt-bindings: awinic,aw88395: Add properties for multiple PA support
      commit: b99d8d8adfda1f9220dd2ee9bdb96ba02dc62bd7
[2/7] ASoC: dt-bindings: Add schema for "awinic,aw87390"
      commit: 457b6587c112e162d3bec871c7b93359168d5c0a
[3/7] ASoC: codecs: Modify the transmission method of parameters and property node
      (no commit info)
[4/7] ASoC: codecs: Add code for bin parsing compatible with aw87390
      commit: b116c832c9e84843c64eed087271e29b3bc6c1b8
[5/7] ASoC: codecs: Modify i2c name and parameter transmission methodls
      (no commit info)
[6/7] ASoC: codecs: Change the aw88261 variable name and i2c driver name
      (no commit info)
[7/7] ASoC: codecs: Add aw87390 amplifier driver
      commit: 37b4346ed8681660ae60de4facc3d499d8e5cf2a

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

