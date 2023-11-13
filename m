Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2E07EA10A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjKMQOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjKMQOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:14:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2FB10E0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 08:14:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FE3C433CA;
        Mon, 13 Nov 2023 16:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699892085;
        bh=P1HsCRngx2AULeZ5NjJzkJnUfB2/UHXYrbiKx+V3dsw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZatGpOBLjKNxznQDsZctXqsvFhBhjf8PWoirXtdiwxa9fifmlLOI2Vi5OS8HThuG/
         o0pkOtnkwKY26BgyOTV/a2W/SrzsOPiD7t/43Pups9X3OC9Ez3lFdPnntPkKV+tMUX
         mW/b5FCxuuoCJ3Md6Wn/MkEviUOTi373Z4cUuveMAruuicBtM2gTQQV/c0wE6Rmrsm
         kGyLYCruxDIjr9xg4Xw60IfgcT8FQlxi9wbidKBiquR1IGgYJFkcz88Xg529QIQayz
         SJMa4c9HrJsKNUL+GlWwDFhNcW5aTKNdFp+du6qqI3eEjFfsDa0V+Qdeeud+4Im8ON
         A/SQ8kpg/rC4w==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, lgirdwood@gmail.com, tiwai@suse.com,
        perex@perex.cz, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        Trevor Wu <trevor.wu@mediatek.com>
Cc:     yc.hung@mediatek.com, sound-open-firmware@alsa-project.org,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231103095433.10475-1-trevor.wu@mediatek.com>
References: <20231103095433.10475-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH 0/3] ASoC: SOF: mediatek: remove unused variables
Message-Id: <169989208005.3289099.6135603822989118878.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 16:14:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Nov 2023 17:54:29 +0800, Trevor Wu wrote:
> There are some variables that are no longer being used because they
> were declared for the deprecated memory layout. Currently, these code
> sections confuse the users. Therefore, this series removes the code
> that was implemented for those variables.
> 
> Trevor Wu (3):
>   ASoC: SOF: mediatek: mt8195: clean up unused code
>   ASoC: SOF: mediatek: mt8186: clean up unused code
>   ASoC: SOF: mediatek: remove unused variables
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: SOF: mediatek: mt8195: clean up unused code
      commit: ab475966455ce285c2c9978a3e3bfe97d75ff8d4
[2/3] ASoC: SOF: mediatek: mt8186: clean up unused code
      commit: a4de5a345cf76c6f294a906e11c2fb675a46fd3d
[3/3] ASoC: SOF: mediatek: remove unused variables
      commit: 82e340ca3f25dc3ddd20e88e3606ed9006f90f5d

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

