Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815A27E9E17
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjKMOGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjKMOFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:05:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A651981;
        Mon, 13 Nov 2023 06:05:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95728C433BF;
        Mon, 13 Nov 2023 14:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699884343;
        bh=sxsc1as84ufBJ/QWw+HF6gUxx16PTyNBJZX2C9hWzFg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lA4FOOmVCxOsLUhsXylSsn0uQGk1cRkWNFFB6hIAml7Syoj4pWqKUW+f5D9ijJp+o
         Xp7V5hUeMiGcWL6NiqOFEgsS7BQUKEDbDe/mpoD411tpclM83GCoAWtSuJoD/zahbk
         VPg0CJR9J0cukizX6yczfOqSbmuDRo7ve9OMIv4hNaLd9HKNhlHpnz+nBTIWQ0bu7Y
         w+7JoPKdOJqPRGqN04epRNOdRle7bJicQh95Sq6OGuCMGsrDxdLRKNWRk3jtRziMpX
         M5rFjw/9gHgVU8bMuQPEEfYk4omp1HcrEisfzhbcWMraVsrJdMbuC13MSLKRc31IgD
         l/kEmWi0paWpA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-tegra@vger.kernel.org
In-Reply-To: <b78685e4103f12931ddb09c1654bc6b04b640868.1699724240.git.christophe.jaillet@wanadoo.fr>
References: <b78685e4103f12931ddb09c1654bc6b04b640868.1699724240.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: tegra: convert not to use
 dma_request_slave_channel()
Message-Id: <169988434099.3280890.15869529541068548630.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 14:05:40 +0000
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

On Sat, 11 Nov 2023 18:37:39 +0100, Christophe JAILLET wrote:
> dma_request_slave_channel() is deprecated. dma_request_chan() should
> be used directly instead.
> 
> Switch to the preferred function and update the error handling accordingly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tegra: convert not to use dma_request_slave_channel()
      commit: 8df735701a7051825254ec7a12a661307bb7bdc1

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

