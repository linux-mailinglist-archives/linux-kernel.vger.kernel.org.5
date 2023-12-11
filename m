Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70F580D112
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344200AbjLKQUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344057AbjLKQUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:20:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4547DB3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:20:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF12C433CD;
        Mon, 11 Dec 2023 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702311612;
        bh=3nTV0SkxLpCj5lGOPMqS4WVJVvWuXILN7ErZ+JOAhRo=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=n8kzE9f4/kvptFZBIE/JI71gnycQC2TponbEtW3zPxbUNhCBYROwQ4lDynuoC65sd
         9yTNY5awadulGSw2vQPRutWRnFonXii/po+AMg6Ws3rIVGXmLWgtL4AmK66hJL9tTC
         /uuJ9ouluS0HVxpq6cLP6GlqvHTzodiU17K9zRRnUuo5EKE37sIpqlIKXUvqJFjOva
         9O3oB3a381lQVF09tpclQHyk/VTlHbkR2wKh1aRnWutFODNSyUMQEFeY9/TYu76+MN
         gJMyHt+QBFlze31vnHpWXw1nHGozEDCMHqkj8MLnUvpm6P1o3RnszyRXBBN+xFpSf/
         dfQoiusfxSUvA==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231130180758.212172-1-krzysztof.kozlowski@linaro.org>
References: <20231130180758.212172-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/3] ASoC: qcom: audioreach: Commonize setting
 channel mappings
Message-Id: <170231161062.85457.2289736198838739317.b4-ty@kernel.org>
Date:   Mon, 11 Dec 2023 16:20:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 19:07:56 +0100, Krzysztof Kozlowski wrote:
> Move code assigning channel mapping values to a common helper function.
> This simplifies three out of four cases, with the last case using
> incompatible type (uint16_t array instead of uint8_t array).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: qcom: audioreach: Commonize setting channel mappings
      commit: ef14f40a3613ddd43a8dd736b5df6f865dcbb817
[2/3] ASoC: qcom: audioreach: drop duplicate channel defines
      commit: bcd684eae5aefc0688fcf43fd555155dd57f27c9
[3/3] ASoC: qcom: audioreach: Add 4 channel support
      commit: 3c5fcb20e07e3681a645fc3a8d890478ca320825

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

