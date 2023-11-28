Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E1D7FC2A8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346181AbjK1RrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjK1RrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:47:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197F4B4;
        Tue, 28 Nov 2023 09:47:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B21C433C8;
        Tue, 28 Nov 2023 17:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701193647;
        bh=Gfy1IvAJHtOURsa6p0dWEDOWeth/WVJ919Rozyirp/Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=adENEMr6OWS7SCT9+EXSQ5+EIv7/WS8hKvcIez0MT4/CIgBuCbaqBdBwY8XeoRLSI
         mA05jD42QWsEPDZkLnIy3h9aTYfvZOEKMgtWeU+ZiqN2BDXM6/fntIbVYcQ/D8k29T
         q9RWFC9ZNquZWsKV76Chtb47QLyvD0TyQKuulhq6XmKo9c9K3V3CLzXWpkyzu/VN9w
         OnNcvZzkDDbLU7BfE6Rtjw8wbdKepsJN/kB2SzY+24s8ZqJwXCof/TMaNkSsSMM/tQ
         Gn0Q4Q1QBq9bVq59rEqvfNqGgC0pOJ7CGdLM7gXL0y3diYndFeIrqnvd3Xa3LQvBQY
         igrjTxepP+FzQ==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     krzysztof.kozlowski@linaro.org,
        linux-arm-msm-owner@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231116-topic-sm8x50-upstream-tx-macro-fix-active-decimator-set-v1-1-6edf402f4b6f@linaro.org>
References: <20231116-topic-sm8x50-upstream-tx-macro-fix-active-decimator-set-v1-1-6edf402f4b6f@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: lpass-tx-macro: set active_decimator
 correct default value
Message-Id: <170119364524.61148.12462722203643682631.b4-ty@kernel.org>
Date:   Tue, 28 Nov 2023 17:47:25 +0000
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

On Thu, 16 Nov 2023 17:44:21 +0100, Neil Armstrong wrote:
> The -1 value for active_decimator[dai_id] is considered as "not set",
> but at probe the table is initialized a 0, this prevents enabling the
> DEC0 Mixer since it will be considered as already set.
> 
> Initialize the table entries as -1 to fix tx_macro_tx_mixer_put().
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: lpass-tx-macro: set active_decimator correct default value
      commit: 69cecaf48831480252dcb63ba32803724f235b1c

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

