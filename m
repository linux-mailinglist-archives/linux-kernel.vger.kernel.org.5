Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41CD79C368
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241160AbjILC5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240891AbjILC5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:57:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C202A256;
        Mon, 11 Sep 2023 19:27:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCECC433BD;
        Tue, 12 Sep 2023 00:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476913;
        bh=XmvvSnPPZfJmsrUyZ/7/dR8/drInjaaG1l50K2Joi1E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=J0Rk2Gsw9fmnC318IRR7A9MwTuYhIUXoxBG/mV08+o+a9NMDng3RLoWLdjqDSbyj6
         T7Trxr8PMmaa+NyAoxw1FbB/8CMFZfypZzHMxJkHe7rYA5r3OfEVEjgdviBY6qB7V+
         VmWcqFOHxxHKLkziEo4zjmpWs8NlKQ7PqWTJ3L+sAJqbNh6gG8SH+Pe/az3z/BOzz8
         ajXfxuTAGfgEK4sZrCJxiiuvsYDBCIlIpuIDi5um+azat7+RPw09UPts++GnRP7112
         jpFRygQisPn4UE+mP2iZcsD7E+NxrvBEuppmLYhz6i0Ioomnnn9P3TUQil0Q/sTtfX
         Tt/1YPvx4itFQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        Sameer Pujar <spujar@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
In-Reply-To: <1694098945-32760-1-git-send-email-spujar@nvidia.com>
References: <1694098945-32760-1-git-send-email-spujar@nvidia.com>
Subject: Re: [PATCH v2 0/2] Fix redundant PLLA update
Message-Id: <169447691068.2390116.10518505217580469969.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 01:01:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Sep 2023 20:32:23 +0530, Sameer Pujar wrote:
> This small series fixes redundant PLLA updates that happen for
> each DAI link in the audio path. This helps to resolve DMIC clock
> issue seen on Jetson TX2 platform.
> 
> Sameer Pujar (2):
>   ASoC: soc-utils: Export snd_soc_dai_is_dummy() symbol
>   ASoC: tegra: Fix redundant PLLA and PLLA_OUT0 updates
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: soc-utils: Export snd_soc_dai_is_dummy() symbol
      commit: f101583fa9f8c3f372d4feb61d67da0ccbf4d9a5
[2/2] ASoC: tegra: Fix redundant PLLA and PLLA_OUT0 updates
      commit: e765886249c533e1bb5cbc3cd741bad677417312

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

