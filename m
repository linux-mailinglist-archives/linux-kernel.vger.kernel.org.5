Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B65E7D536E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343705AbjJXN5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbjJXN5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:57:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93435210B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:55:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9A7C433CB;
        Tue, 24 Oct 2023 13:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698155733;
        bh=6RjFQUx2aS9W96EY+vVbpPyHbDi4OypX4NJKROyEC6s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QNK3gLrGWE5M9wnAF2YOhi3yRCXzv6Ppn57p2FgZvB7mRzzP6HGLzTungGTFKfZRH
         GuL2fCJ7RUlFgktvrM3H7g8nb7/k5zDIIBu2/gsQ/NauyIZXznlB9jk3c99/oOuBHb
         2rMa2PjYaw1emweZ0RQLSoGR1Fd0zm65r2Fh3M9jIrOzVvp6Rto9AooHz0b0YnKfK6
         VcAAUhOUjwLcZu8MHHFuiyQbjlxHyIYseCdC0senVFk18Hj/kg4rLmHZPxrQetwPoA
         cv7k81Rv+GB8/mkaZ5wKGzb8m0NVMxtwSySy5+oEj0WvbqL/XQecfEp2xUTcugeoyl
         NaRvSxE6m0NRw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, shumingf@realtek.com,
        rf@opensource.cirrus.com, herve.codina@bootlin.com,
        ckeepax@opensource.cirrus.com, 13916275206@139.com,
        ryans.lee@analog.com, linus.walleij@linaro.org,
        sebastian.reichel@collabora.com,
        ajye_huang@compal.corp-partner.google.com,
        harshit.m.mogalapalli@oracle.com, arnd@arndb.de,
        colin.i.king@gmail.com, dan.carpenter@linaro.org, trix@redhat.com,
        liweilei@awinic.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangweidong.a@awinic.com
Cc:     yijiangtao@awinic.com
In-Reply-To: <20231020083426.302925-1-wangweidong.a@awinic.com>
References: <20231020083426.302925-1-wangweidong.a@awinic.com>
Subject: Re: [PATCH V2 0/4] ASoC: codecs: Add aw88399 amplifier driver
Message-Id: <169815572396.69390.16547597734984966966.b4-ty@kernel.org>
Date:   Tue, 24 Oct 2023 14:55:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023 16:34:22 +0800, wangweidong.a@awinic.com wrote:
> Add the awinic,aw88399 property to the awinic,aw88395.yaml file.
> 
> Add i2c and amplifier registration for
> aw88399 and their associated operation functions.
> 
> v1 -> v2: Modify the reset mode
>           Delete AW88399_DSP_I2C_WRITES macros
>            and related debugging statements
>           Change the value of max_register in aw88399
>           Change the value of max_register in aw88261
>           Delete the judgment of unnecessary pointers
>           Modify the judgment of the ret return value
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: dt-bindings: Add schema for "awinic,aw88399"
      (no commit info)
[2/4] ASoC: codecs: Modify max_register usage error
      commit: f1c406866af5dacdd9601cfa3be4873ebd801b86
[3/4] ASoC: codecs: Add code for bin parsing compatible with aw88399
      (no commit info)
[4/4] ASoC: codecs: Add aw88399 amplifier driver
      (no commit info)

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

