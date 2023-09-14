Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4097A0262
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbjINLTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237644AbjINLTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:19:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07181FD3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:19:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39E8C433C7;
        Thu, 14 Sep 2023 11:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694690379;
        bh=O3CIa31gYoOF4a1uQIEH6AoTOjXHQf3zX/6sb/ewrxg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rFHctGm94GQQptUu4nkbO7IPXbQDLt8ya/Sd/f8crD5NSHTBHsz5SB04rtxEWGikl
         wkOGGwIgCCJayBetITKzU7Opxd8jpLTCEB2n8GJN0cY4auaEKiLWLK1tfYUP24C2vW
         UAbORmaP1y/3eqgGfvL9rHikI7Jw4fnKwbM//aozKcVyJUz1qJkB55OUciSbPwe8XH
         6BLPKEJPmapi61bUHWxBJnNIJ8PragwRqUP5WT+o4JZv9dNCOrIaGY+Z6fv0VBP6DG
         FwQEZa9ZwPdrU/F6EaFI5zgYj+vQTJKgJLVuPTpL16DK+DOl9xvywQRPoJqkiFyO5r
         ZfcAYerC75JMw==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com,
        yung-chuan.liao@linux.intel.com, kai.vehmanen@linux.intel.com,
        peter.ujfalusi@linux.intel.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230912163207.3498161-1-rf@opensource.cirrus.com>
References: <20230912163207.3498161-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/4] ASoC: cs35l56: Use PCI SSID to select specific
 firmware
Message-Id: <169469037763.23670.11361040315224579897.b4-ty@kernel.org>
Date:   Thu, 14 Sep 2023 12:19:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2023 17:32:03 +0100, Richard Fitzgerald wrote:
> The PCI device registers contain a subsystem ID (SSID), that is
> separate from the silicon ID. The PCI specification defines it thus:
> 
> "They provide a mechanism for board vendors to distiguish their
>  boards from one another even thought the boards may have the same
>  PCI controller on them."
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: soc-card: Add storage for PCI SSID
      commit: 47f56e38a199bd45514b8e0142399cba4feeaf1a
[2/4] ASoC: SOF: Pass PCI SSID to machine driver
      commit: ba2de401d32625fe538d3f2c00ca73740dd2d516
[3/4] ASoC: Intel: sof_sdw: Copy PCI SSID to struct snd_soc_card
      commit: d8b387544ff4d02eda1d1839a0c601de4b037c33
[4/4] ASoC: cs35l56: Use PCI SSID as the firmware UID
      commit: 1a1c3d794ef65ef2978c5e65e1aed3fe6f014e90

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

