Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660E37B1620
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjI1If3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjI1IfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:35:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54663191
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:35:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB85C433C8;
        Thu, 28 Sep 2023 08:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695890122;
        bh=FgZxXfPfyj1K8RRAJj0ZMzaJYR0HOOqlp8GRmy2xQT4=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=CEsnPddtanxIZnCQ8nfB2ejYlQskavisMzmV84O/5C8e5WrCC0F0D5w8PzslZIyad
         KgZE9IeFzvCjaosAMjQjIw4i+6oT2LyusGIis7lPDsw84t/eF2F+jI+xBDtG9C5XDM
         jJ5qLlWjn0Z+uwOG/C308Kwli+8F3L5q0ASCIs5lA7e5FRI9S5TMt00gJRZ0D80TGO
         wnGuek+GM1igKooKx/yhJJ6RT64SEpkh1IxjRiQJcb34Cwh1qnDZTx5HYYRcRrXpyQ
         NwQ3N4vXDRnQ99JvrDPYaJzqIvtIa8cEPF2Ba9GobJjgSb1R7l1yHy9a7K+IV0kFTs
         albymVdGQ1wJw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20230920153621.711373-1-chancel.liu@nxp.com>
References: <20230920153621.711373-1-chancel.liu@nxp.com>
Subject: Re: [PATCH v2 0/1] ASoC: soc-pcm.c: Make sure DAI parameters
 cleared if the DAI becomes inactive
Message-Id: <169589012063.2716296.14624171490779605949.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 10:35:20 +0200
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

On Wed, 20 Sep 2023 23:36:20 +0800, Chancel Liu wrote:
> It's reasonable that DAI parameters should be cleared if current DAI becomes
> inactive.
> 
> Only check DAI active status in soc_pcm_hw_free() is not enough since there's
> the risk that DAI parameters never be cleared if there're more than one stream
> [see A]. Only check DAI active status in soc_pcm_close() is also not enough
> since it will cause the cleanup just happening in soc_pcm_close() [see B].
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-pcm.c: Make sure DAI parameters cleared if the DAI becomes inactive
      commit: 3efcb471f871cc095841d411f98c593228ecbac6

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

