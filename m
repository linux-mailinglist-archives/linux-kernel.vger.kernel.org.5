Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAA2765FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjG0WxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjG0WxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:53:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C629A3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA57161F50
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 22:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FD1C433C8;
        Thu, 27 Jul 2023 22:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690498381;
        bh=nccD0Mf6wU5sbJ5COVN/p0FKMBOhmCCUxaTQs85SCqw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=t/0s9ZMj4z70dOkGNrjMII3EjJTPEzzV5nIVm20v6HgGEhnEWJxOffzdNbfWNjjeT
         PNLu1JgLK4zZ3zYhF4dwVNAPZPSCcxO5FsYnafndjX6muIEp98ZDRvTW1CR0oZwRSk
         Yge5GKj2vEyQwZ0jMDa4Na2fxOnUTJYviYPFrS21NNJYEMG+uTmAoryZofn/b0c/Vw
         F42P5sXjniepCZUWGlsRGBAvS3gqNq7XvwPKV9KeOvZCQGl4H2HaD58DoSjw5M7jrf
         wYKo8oNwFbVUArRrwQD+X3fwQFFYXWKDw15Stv5b3Z7Rl5oqzlWSFPDZyejgjp/z7+
         Fay54jzGP9HTA==
From:   Mark Brown <broonie@kernel.org>
To:     oder_chiou@realtek.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20230727021632.88912-1-jiapeng.chong@linux.alibaba.com>
References: <20230727021632.88912-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] ASoC: rt1017: Remove unused function
Message-Id: <169049837934.173381.10017429412134576375.b4-ty@kernel.org>
Date:   Thu, 27 Jul 2023 23:52:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 10:16:32 +0800, Jiapeng Chong wrote:
> The function are defined in the rt1017-sdca-sdw.h file, but not called
> elsewhere, so delete the unused functions.
> 
> sound/soc/codecs/rt1017-sdca-sdw.h:183:33: warning: ‘rt1017_sdca_mbq_defaults’ defined but not used.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1017: Remove unused function
      commit: 8f59c7ed230784ca914c98e250c65768b71d5de4

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

