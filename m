Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A177F6498
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345151AbjKWRAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbjKWRAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:00:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D8A10C1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:00:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B372C433CA;
        Thu, 23 Nov 2023 16:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700758800;
        bh=saYxe/NoTX0miZmb5XKxxLdDu9x5vl+RmTWfCOD6DjM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PDd6yTtbeRsj6wOggVxLqAbMolmiQE6qQ8JQMjxsTnac9OnBXaBn5wL341k2RT5iW
         MJwed2MKyls/spX4p0h0Qy09Zi4t8xmrAikNeHjzWYqUX2oFd/RWh3qB8YOzO1rFh6
         e7cDyh90llt5V42LLzMzVkVM9UgccW2zQwk9ei/zeLmCAykMldI/MfY6tE4jtWAKLH
         7ROICKqUWkOLgoUOsG/w+1glGUDQJcy3jn7OFhf1LBq3TGPEl0tnHmZR3jwypcliZL
         5191BU3/KsCypMK/8YrOif/0LJ1KFG8YItDu84lMN7C/FKY0ghU84hrMggCeLmQ8iF
         6xZz0V0uaO9zg==
From:   Mark Brown <broonie@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Chancel Liu <chancel.liu@nxp.com>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231123091815.21933-1-johan+linaro@kernel.org>
References: <20231123091815.21933-1-johan+linaro@kernel.org>
Subject: Re: [PATCH] ASoC: soc-pcm: fix up bad merge
Message-Id: <170075879786.2448402.7389319315728304933.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 16:59:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 10:18:15 +0100, Johan Hovold wrote:
> A recent change to address pops and clicks with codecs like WSA883X
> touched the same code paths as a fix for clearing DAI parameters and
> resulted in a bad merge.
> 
> Specifically, commit f0220575e65a ("ASoC: soc-dai: add flag to mute and
> unmute stream during trigger") made mute at stream close conditional,
> while commit 3efcb471f871 ("ASoC: soc-pcm.c: Make sure DAI parameters
> cleared if the DAI becomes inactive") moved that same mute call back to
> soc_pcm_hw_clean().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-pcm: fix up bad merge
      commit: 3841d8a563a7473ceb7415ecfe577e20b2a66d37

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

