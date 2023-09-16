Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EC37A2CE3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 03:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238639AbjIPBMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 21:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbjIPBLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 21:11:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94357E3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 18:11:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58260C433C9;
        Sat, 16 Sep 2023 01:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694826691;
        bh=Bj2qh4y6sKb9dvuxkfpcxQVhYnAqob9WgtHaABSZtlk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UXpT5QjTyKN5n5xo8qmVHdtuL1XzaLDtkv+t3h2xYtDFoRJuSqO9SHSLm4yYGVJI+
         RWIpPM5yXAZoX/TiLJxcs1HKuo0N+955KKZlQuMClCIMNzDDxxZxZ8qXdJDqQVCRJY
         Rcu4B+OZRnMumfUQgntjK2F8XUZNebDgygYgiBD92pPO01O++klFamDVUDPwiMSQp7
         xramL8E/PKOOwVvqI7QTnhwh2QCskir7Dg2z1iLs1BOT4C8I0VcXwEtP2HdeMNKVe1
         lv4pwK8qSJ9eDSjmKCbegyVOuYHDUrFNixiazSeQTexpjdA9muxVBNlGZ4ZPbbwmkL
         VrMZ7USP8oHbQ==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230914150918.14505-1-rf@opensource.cirrus.com>
References: <20230914150918.14505-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/3] ASoC: cs35l56: Define and export I2C/SPI pm_ops
 only if needed
Message-Id: <169482669005.606223.15627123606539321145.b4-ty@kernel.org>
Date:   Sat, 16 Sep 2023 02:11:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023 16:09:15 +0100, Richard Fitzgerald wrote:
> These 3 patches update the pm_ops for I2C/SPI so that they are only built
> and exported if they are needed.
> 
> Richard Fitzgerald (3):
>   ASoC: cs35l56: Use pm_ptr()
>   ASoC: cs35l56: Use new export macro for dev_pm_ops
>   ASoC: cs35l56: Omit cs35l56_pm_ops_i2c_spi if I2C/SPI not enabled
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: cs35l56: Use pm_ptr()
      commit: 3d3a86679541044a65ea23175cb95206921c8fe2
[2/3] ASoC: cs35l56: Use new export macro for dev_pm_ops
      commit: 6399eb58254b98bbe42c9d14e07c50e1c3d9f8cd
[3/3] ASoC: cs35l56: Omit cs35l56_pm_ops_i2c_spi if I2C/SPI not enabled
      commit: 01e76ee227564008d71ddce6e43132b36d2d2252

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

