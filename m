Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9B57B161F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjI1IfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjI1IfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:35:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AD5B7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:35:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9ACC433C7;
        Thu, 28 Sep 2023 08:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695890120;
        bh=FSwConUjZIxe3YIjZXjdGETHRwEytleBmz3Wk6V8jsM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tG6gu8nmBr//c+0sxeGNAKgiqhPzAheOubFfmZHix/2WQKZ40yLhBzw93ow720DUa
         pOqwYaAn4OG0t/EoWve7+iUQpy0ZsDNkdL4o+fiwVUDEsbkOAmHKmuwZQ7pjLa0EFl
         YlhJLK222o1MVevD6Bg1NOddV+u13e79/mAusHqz7yI19sQHjH0b7F5qQsXW3bNwGt
         1kfoUuJSBTQLl09IRPgW5Irfn30ENJMDshFkJDUqTyvvPx8p99TFAQuyIhV3cHCi7+
         1mntMPVJz6GugJ6OzG0UN1DBgu5BEIXuDBwN7mGE+E0wunvUufvAgN+p848DLR4z5/
         xDV7tGIPPDfjA==
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com,
        coolstar <coolstarorganization@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rander Wang <rander.wang@intel.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20230927071412.2416250-1-Vijendar.Mukunda@amd.com>
References: <20230927071412.2416250-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: SOF: amd: fix for firmware reload failure after
 playback
Message-Id: <169589011676.2716296.8639160633859429574.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 10:35:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2023 12:44:10 +0530, Vijendar Mukunda wrote:
> Setting ACP ACLK as clock source when ACP enters D0 state causing
> firmware load failure as mentioned in below scenario.
> 
> - Load snd_sof_amd_rembrandt
> - Play or Record audio
> - Stop audio
> - Unload snd_sof_amd_rembrandt
> - Reload snd_sof_amd_rembrandt
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: amd: fix for firmware reload failure after playback
      commit: 7e1fe5d9e7eae67e218f878195d1d348d01f9af7

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

