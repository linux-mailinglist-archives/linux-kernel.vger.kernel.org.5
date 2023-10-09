Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E067BE62A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377735AbjJIQTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377781AbjJIQSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:18:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FDBB6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:18:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E8CC433C7;
        Mon,  9 Oct 2023 16:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696868333;
        bh=gkyeCucWHf0UPKQjtfcwMc3717M1vXRgjVqByo3d1Qo=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=aRZvLtrSEzexpMxcLbb9fEIj9PrqerwrngWL08mur9lvbJPmFJooNVKd7ExcXmp8Q
         J20YXEqMxewDDKq2mmG4LWFM6DkaRteITbjhoHBJTIXokR5Z8F7SdTyCmKjB65Asvc
         waTD6RJU7+85dAsS/wPbs5yeg3ubabhUtSlMNImBAJVuB5slOKDs+kRMxHdjkt/3pC
         e80BudsNFRDICSa9TlPJctsI9qDimmR/R+gN0UcxEfFrdfZCOug9iPJMYJeY+CQLR+
         JakzussiRfNylaUapSjF0lYt7izBV+XnJ2mCrBoD/sM6GHzVMTpemjuJk2+f2J6L+E
         4263YhT0J3sQQ==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231005075250.88159-1-krzysztof.kozlowski@linaro.org>
References: <20231005075250.88159-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/2] ASoC: qcom: explicitly include binding headers
 when used
Message-Id: <169686833118.101967.4629707459259465678.b4-ty@kernel.org>
Date:   Mon, 09 Oct 2023 17:18:51 +0100
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

On Thu, 05 Oct 2023 09:52:49 +0200, Krzysztof Kozlowski wrote:
> Few units use qcom,lpass.h binding headers but they rely on them being
> included through a different header.  Make the usage explicit which
> allows easier to find the users of a header.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: qcom: explicitly include binding headers when used
      commit: 0f729a285b4ef7d0cd2497c22233c42037486a7e
[2/2] ASoC: qcom: reduce number of binding headers includes
      commit: 528a4a0bb010489abc3bb298c85c8ffb7ebe7735

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

