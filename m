Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD36B7D85AC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345396AbjJZPMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjJZPMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:12:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B431AA;
        Thu, 26 Oct 2023 08:12:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28133C433C7;
        Thu, 26 Oct 2023 15:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698333132;
        bh=cxODEnMO4778yY18WaIb5R8VLHNJEiwUh5aRzxmJgNc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=At/OXXwcPSr7L5TiGR9U+5gydhYj7ahmCUdWL/Xstax0T8JOoqYsL243KzWxAG+zC
         WqMB7ebYD2nV7xOVIXthxnYGCyoczvhy8i2slBEs04ZCpwc0oi7UAUeU/QdfYHBOOu
         CSxn8/JWdvHg7B12oUUpJeuiGTg508YOVawrl0vNBkoZd8XYl4FxEKM+Us5GiytmM3
         8bLUEx4xZHE0NDIBSJEsJz4P3AeNNvfOOESZO8ysbISeCQb09vqAJMEWPhwDOnv139
         EH6m7u87kR8gEENrqAumKuLshQiC/UF6NHAGz93TilvoHXQIApdLCAGm0nRmdEuZ/Z
         Q0rL2hTSpqB1A==
From:   Mark Brown <broonie@kernel.org>
To:     cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, perex@perex.cz, tiwai@suse.com,
        Su Hui <suhui@nfschina.com>
Cc:     zhangyiqun@phytium.com.cn, amadeuszx.slawinski@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <20231020092619.210520-1-suhui@nfschina.com>
References: <20231020092619.210520-1-suhui@nfschina.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: add an error code check in
 skl_pcm_trigger
Message-Id: <169833312844.133649.16742223419669591458.b4-ty@kernel.org>
Date:   Thu, 26 Oct 2023 16:12:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023 17:26:20 +0800, Su Hui wrote:
> skl_decoupled_trigger() can return error code like -EPIPE if failed,
> add check for this.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: Skylake: add an error code check in skl_pcm_trigger
      commit: f5c7bc7a1fad4e1e8d3d29d71dd9f430a3350f42

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

