Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E35379C235
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbjILCH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243658AbjILCGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:06:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5E4101101
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:37:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10A8C16ABD;
        Mon, 11 Sep 2023 23:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476652;
        bh=ZLQwBDO9oB7DwHjbeEilVGbTlMbMwI68sm9U3hUF8Q0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pleTmCeOGpMp8OgSpvq2ZspmRywpezPrXCk/saOp8oLbJxHb1URIfoC2U+sXj6YQb
         go7PMdiP3hem3qYezceAvWhuvcSVY5sHbCC4P3QuK/BjcBrG/53ifTGiH4LopCDjjb
         9QtNWoKdiQoGZdy8AK89kia1vNZ5gciwl8DXLCMirJ+cEk0314moYlCPlZcf4ZJT2s
         2bDllpNOWhsLOfbGSVC3AHO0AK2rX1Czs1VDy+CiD7Vda6nSQkH1324dK0dsJWBZR6
         FMe6FnQj7cZWguglf1y8uLxO3OpQprUklkYJQRnrckKbKmcMzT+JmdDT4dXVqlUncW
         i7rl6oIKaoT+w==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Marian Postevca <posteuca@mutex.one>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20230829220116.1159-1-posteuca@mutex.one>
References: <20230829220116.1159-1-posteuca@mutex.one>
Subject: Re: [PATCH v3 0/5] ASoC: amd: acp: Add sound support for a line of
 HUAWEI laptops
Message-Id: <169447665042.2387538.16679409837029670258.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 00:57:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023 01:01:11 +0300, Marian Postevca wrote:
> This series adds support for a line of HUAWEI laptops with
> AMD CPUs that connect using the ACP3x module to a ES8336 CODEC.
> 
> The CODEC driver must be extended to support the S32 LE format
> and the MCLK div by 2 option. MCLK div by 2 is needed for one specific
> SKU, which uses a 48Mhz MCLK, which seems to be too high of a frequency
> for the CODEC and must be divided by 2.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: es8316: Enable support for S32 LE format
      commit: 2f06f231f0bfe74711fee14e28a8789a3de9bc36
[2/5] ASoC: es8316: Replace NR_SUPPORTED_MCLK_LRCK_RATIOS with ARRAY_SIZE()
      commit: a43c0dc1004cbe2edbae9b6e6793db71f6896449
[3/5] ASoC: es8316: Enable support for MCLK div by 2
      commit: 869f30782cdad0a86598a700a864e4a2bf44f8cc
[4/5] ASoC: amd: acp: Add support for splitting the codec specific code from the ACP driver
      commit: c680f57095411559e7605af689c7ce01f2281005
[5/5] ASoC: amd: acp: Add machine driver that enables sound for systems with a ES8336 codec
      commit: 54fcd9dd44b2c82a0262e29b288c2d0b36c6bba5

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

