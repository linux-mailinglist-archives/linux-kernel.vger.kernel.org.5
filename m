Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBB1772E17
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjHGSpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjHGSo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:44:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44E4198D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 11:44:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D8FD62116
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 18:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71530C433C7;
        Mon,  7 Aug 2023 18:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691433889;
        bh=hmUDDMPneWyGPqzX8N2O3Gbisx+EhLJaoG/DxdAw8J4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YXtooxKzd5RLFXZdEXL+f2Fj73s2mNQTfK4ARGqPteThz5xW8f/2OqfIDbo8X/PnI
         9FXyN2vABkChGtTUSqDXuLvS3cp48kkNmen5gA6f0I9jFi7Gcq6ToBaTQLThcrunFE
         5ZBoJTzhd6LEWqgqU/cLhoeTBrWTDf6blG9QTv402tVJ8R7JvPkj/dIyKRSDBd9inu
         oj3YcVv+88ggWdEvN+uzwlM2TurAoKuG/SXG7QAeZJ6GKrHoJXuimOk7HA+YP1e+S0
         r684ts5CUjEmczd7copzVkVqlCubnL3C4R/kThe1Tco1LTSkWwLQ64GYm1Mw/wEhCd
         QzwbGc0FWJasQ==
From:   Mark Brown <broonie@kernel.org>
To:     oder_chiou@realtek.com, Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <tencent_A560D01E3E0A00A85A12F137E4B5205B3508@qq.com>
References: <tencent_A560D01E3E0A00A85A12F137E4B5205B3508@qq.com>
Subject: Re: [PATCH v2] ASoC: rt5665: add missed regulator_bulk_disable
Message-Id: <169143388818.204874.3565118222220844695.b4-ty@kernel.org>
Date:   Mon, 07 Aug 2023 19:44:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2023 23:59:11 +0800, Zhang Shurong wrote:
> The driver forgets to call regulator_bulk_disable()
> 
> Add the missed call to fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5665: add missed regulator_bulk_disable
      commit: c163108e706909570f8aa9aa5bcf6806e2b4c98c

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

