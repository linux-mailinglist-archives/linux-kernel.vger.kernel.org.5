Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024BB7FEDB4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345129AbjK3LXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345030AbjK3LXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:23:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD49D54
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:23:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F456C433C7;
        Thu, 30 Nov 2023 11:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701343393;
        bh=xr5JNGOp0U++yPhoXYwejOX8hAi+ZFtXqD6om/BbAXs=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=QgBsYjC3gnQPs3AasGVAnvSuquHzgencfpclZocgw0PS5jw+ivTgpbCiZ/6k0aHK5
         SUYpH3O6+JfQ3+JWxx/Qw6VZQXj0XNVbU2sioRKindebyQPYZvZqzIZpS9oh2EZmPf
         7c+vG9IIRth7yCInARzG/G6l3Qu8YrhnIDJZq8kyFb45hegD9Fo+MJGAqr/b+LAO76
         PTHAzxjqO34SjuN5zf8kLo3L40505MdJUuxnMYo9I8RP1q9ceL6w7X1cUknIIFpXwY
         OSMxUIKe+E0+6CtR+CoKTVOMt0ZUuSagHvr9+v/WT12kL8FQ5PTaTH8o+MTuKC8RFU
         ae0uSg1Sk8sCg==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231128165638.757665-1-krzysztof.kozlowski@linaro.org>
References: <20231128165638.757665-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: qcom: Add helper for allocating Soundwire
 stream runtime
Message-Id: <170134338891.9221.12703514760679769792.b4-ty@kernel.org>
Date:   Thu, 30 Nov 2023 11:23:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 17:56:37 +0100, Krzysztof Kozlowski wrote:
> Newer Qualcomm SoC soundcards will need to allocate Soundwire stream
> runtime in their startup op.  The code will be exactly the same for all
> soundcards, so add a helper for that.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: qcom: Add helper for allocating Soundwire stream runtime
      commit: d32bac9cb09cce4dc3131ec5d0b6ba3c277502ac
[2/2] ASoC: qcom: Move Soundwire runtime stream alloc to soundcards
      commit: 15c7fab0e0477d7d7185eac574ca43c15b59b015

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

