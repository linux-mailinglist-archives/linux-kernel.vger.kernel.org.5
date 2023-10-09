Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3F67BE9A4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378082AbjJISgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377976AbjJISg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:36:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75932B0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:36:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B0EC433CA;
        Mon,  9 Oct 2023 18:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696876583;
        bh=eK/IoEf0w1TEmPULmN+xgJZqbJo1CEPnj1s+f8XTlGs=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=UOFngcAxK7Dhr8ECq4/J5Rh0XUxCGiy4Bbc1r9FM3FVadhVS3nXNYiJr/PcSrzs3E
         VIVwkWK1gc6ir19WjU3FBU6ptz/Iq1eTKwX7n2gG8Vt/hjm3KJXh2UpWLgpnMwOP2w
         CSgj1UABH86lYB/VS6orO+D36eNr0w8v4veBu6c4/wd1hD0sGt9R/w6ETXK1kw++u7
         NBJ5z9ahfs6OzFAlZRA5qQZ6AvODia1qv7yaa22FF6ox1GCBG3pCff9dBB5mxb0bOH
         SCwoznfVv5fMsX50lG9u2gIQ72CIwms22KL3cgbUI0YF46X1URlWFMPVR7SppV5FmE
         41Jj2ajf2PxMA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231003155710.821315-1-krzysztof.kozlowski@linaro.org>
References: <20231003155710.821315-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 0/2] ASoC: codecs: fix widget name comparisons
Message-Id: <169687658062.138823.3860753244741067413.b4-ty@kernel.org>
Date:   Mon, 09 Oct 2023 19:36:20 +0100
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

On Tue, 03 Oct 2023 17:57:08 +0200, Krzysztof Kozlowski wrote:
> Some codec drivers compare widget names with strcmp, ignoring the component
> name prefix.  If prefix is used, the comparisons start failing.
> Add a helper to fix the issue.
> 
> If the approach looks good, I will fix other codec drivers.
> 
> Best regards,
> Krzysztof
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: soc-dapm: Add helper for comparing widget name
      commit: 76aca10ccb7c23a7b7a0d56e0bfde2c8cdddfe24
[2/2] ASoC: codecs: wsa-macro: handle component name prefix
      commit: c29e5263d32a6d0ec094d425ae7fef3fa8d4da1c

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

