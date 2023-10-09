Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FDF7BE629
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377782AbjJIQTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377731AbjJIQSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:18:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D9291;
        Mon,  9 Oct 2023 09:18:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097B4C433CA;
        Mon,  9 Oct 2023 16:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696868331;
        bh=Y5wdZoSN5IMGtbcM+xe2nsU6jP+OkHwT0xytzE7h6iw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EhLxMwmAykDV2tsGTVIO8Mx1bEzNGMGZxPWHbvS0VMS8TcV1/JWKZKdQymqtdmSiA
         45FjYxGbz+41a6zVFlokz+n1lgzYNNSJrb6WdpPiVhoZ5bVs/UKCaJ7q+c5y8YZxK1
         SAGMvMSv8fZi9YtL9iiOWGNtGkPPkB4QLBcg/+VP29HVkRKavXbT6cz/aBCuzSxQNx
         dyxqRElF+9s+2a4YPh2sQ3tVcBd5ilw116Ryza6a0DgVHkEK2/VmpLvjnMR80O0M/0
         RpOCUjqHh8TmAswd1cvES9s/sKjsjcnHrxgO4J1yhkU9e2Jk3JlwiZj/ZrpwH45HGj
         fGbauvZ7Lq+Ew==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     stable@vger.kernel.org
In-Reply-To: <20231003155422.801160-1-krzysztof.kozlowski@linaro.org>
References: <20231003155422.801160-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: wsa-macro: fix uninitialized stack
 variables with name prefix
Message-Id: <169686832875.101967.8301588803886718212.b4-ty@kernel.org>
Date:   Mon, 09 Oct 2023 17:18:48 +0100
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

On Tue, 03 Oct 2023 17:54:22 +0200, Krzysztof Kozlowski wrote:
> Driver compares widget name in wsa_macro_spk_boost_event() widget event
> callback, however it does not handle component's name prefix.  This
> leads to using uninitialized stack variables as registers and register
> values.  Handle gracefully such case.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wsa-macro: fix uninitialized stack variables with name prefix
      commit: 72151ad0cba8a07df90130ff62c979520d71f23b

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

