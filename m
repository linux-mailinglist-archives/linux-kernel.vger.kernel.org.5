Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972717B2021
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjI1Ova (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjI1OvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:51:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ADC1A1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 07:51:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F26C433CD;
        Thu, 28 Sep 2023 14:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695912683;
        bh=StfEneqPnMXWDqQdDqylaWm7UVtDGEIMdVg0t3atZ0Q=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=bgiOSo+n1ZlOzg1fdq+N77rfK+/KqBoOiNPq5OiJKBIBqO98ZnNZRzf7kb32d2PVQ
         lB55ahJVx53g7eFv6yYNPNIAG1nJ5J/G0bJZyDCzkQ4KA2DGFfNfVMt2X+dskZYt3F
         0PicXLtYQyqZV6BEtbOCTV6iWiYzLwQmQJpyxvCugcPZpiKBsjpl0HK83Jie6BP4DS
         MIsYPlghzipIGM2T3jKXqfGe8Hjg9dNXstIaRa93Q2UshQ8InG3aluEoyU0Epvg8Kv
         uFUZokN9X0Vy39MXTXACBvle+zMI3ahdE11hWY+3e0LgUWFTeyfISfn+ZSmWpYRTnq
         8bJrP9YHoSoRA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, shumingf@realtek.com,
        rf@opensource.cirrus.com, herve.codina@bootlin.com, arnd@arndb.de,
        13916275206@139.com, ryans.lee@analog.com,
        linus.walleij@linaro.org, ckeepax@opensource.cirrus.com,
        doug@schmorgal.com, fido_max@inbox.ru,
        harshit.m.mogalapalli@oracle.com, liweilei@awinic.com,
        yang.lee@linux.alibaba.com, u.kleine-koenig@pengutronix.de,
        yijiangtao@awinic.com, dan.carpenter@linaro.org,
        colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangweidong.a@awinic.com
In-Reply-To: <20230927121634.94822-1-wangweidong.a@awinic.com>
References: <20230927121634.94822-1-wangweidong.a@awinic.com>
Subject: Re: [PATCH V5 0/8] ASoC: codecs: Add aw87390 amplifier driver
Message-Id: <169591268017.2776105.16111377066038628.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 16:51:20 +0200
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

On Wed, 27 Sep 2023 20:16:26 +0800, wangweidong.a@awinic.com wrote:
> The awinic aw87390 is a new high efficiency, low noise,
> constant large volume, 6th Smart K audio amplifier.
> 
> Add a DT schema for describing awinic aw87390 audio amplifiers.
> They are controlled using I2C.
> 
> v4 -> v5: Adjust the order and context of the patch
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/8] ASoC: dt-bindings: awinic,aw88395: Add properties for multiple PA support
      commit: b99d8d8adfda1f9220dd2ee9bdb96ba02dc62bd7
[2/8] ASoC: dt-bindings: Add schema for "awinic,aw87390"
      commit: 457b6587c112e162d3bec871c7b93359168d5c0a
[3/8] ASoC: codecs: Modify the code related to the property
      (no commit info)
[4/8] ASoC: codecs: Modify the transmission method of parameters
      commit: e83219c94abb4ad977f6b2b8be7d466ef0c2248f
[5/8] ASoC: codecs: Add code for bin parsing compatible with aw87390
      commit: b116c832c9e84843c64eed087271e29b3bc6c1b8
[6/8] ASoC: codecs: Modify the code related to the property
      (no commit info)
[7/8] ASoC: codecs: Modify the transmission mode of function parameters
      commit: f83287a72551833a6fe2fc96f334b26e6eba77e8
[8/8] ASoC: codecs: Add aw87390 amplifier driver
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

