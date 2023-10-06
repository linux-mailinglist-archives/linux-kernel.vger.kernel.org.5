Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705C77BBDEC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjJFRpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjJFRpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:45:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E4EBE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 10:45:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041DDC433C8;
        Fri,  6 Oct 2023 17:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696614339;
        bh=eR2R0F/vcWmTXvkygEMikVDgfUW8yNTc/B0mv/Thh/Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=H3+2v7Y+DSgsz0T5otVWlNHANJXOJ5610MQm+JQ5HL6JBe9soPh07DyrGaiAQEKzx
         kRpt/7yu3hew9LpWKdWNZgbsSxTRUC8tj8vTBgaQx9c+9T2v9LzYTbYZ+NoLSJ0qMa
         SgTu9j7tsGszpThY+Ifqwxa12g1xGOu05D3EBLNUzrPPbhyrPpU1ETpSNtuQ3IJgqp
         2cdCLqJHQReUXZtr00Vz+IPajuyhMhtUmM6jDivPHJwLL0MGwhw9g2jBue0Pz3SyJb
         Tmq6k0fYbLvcqKgFHW7NTMXIjewIHDNDJhj3DsY5Q+c8POuLpaeuHkYogpWtu/vj49
         L5SA3fNqvyLRg==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20231006111039.101914-1-rf@opensource.cirrus.com>
References: <20231006111039.101914-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/4] ASoC: cs35l56: Update hibernate/wake sequences and
 enable hibernation
Message-Id: <169661433758.222574.6492928964060068556.b4-ty@kernel.org>
Date:   Fri, 06 Oct 2023 18:45:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Oct 2023 12:10:35 +0100, Richard Fitzgerald wrote:
> Update the hibernate and wake command sequences to meet the latest
> datasheet specification and enable hibernation for I2C and SPI control
> interfaces.
> 
> Richard Fitzgerald (1):
>   ASoC: cs35l56: Enable low-power hibernation mode on SPI
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: cs35l56: Change hibernate sequence to use allow auto hibernate
      commit: a47cf4dac7dcc43ef25d009ca0ad28fc86ba0eef
[2/4] ASoC: cs35l56: Wake transactions need to be issued twice
      commit: 3df761bdbc8bc1bb679b5a4d4e068728d930a552
[3/4] ASoC: cs35l56: Enable low-power hibernation mode on i2c
      commit: 79b101947a829a1c4c3eca4b6365093d2b534cf4
[4/4] ASoC: cs35l56: Enable low-power hibernation mode on SPI
      commit: 634ed138d80b1cc8a903edb226458ea203c44abd

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

