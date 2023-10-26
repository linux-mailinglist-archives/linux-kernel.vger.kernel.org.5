Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329AB7D8748
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345272AbjJZRKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjJZRKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:10:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC821B4;
        Thu, 26 Oct 2023 10:10:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67392C433C8;
        Thu, 26 Oct 2023 17:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698340218;
        bh=pxnkdIlXjGbj0R9REeTamfZwwcR9rdS0B2bEwp165H4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=J9OmEuaTEt2edm5kYh6st4RPPgw+qSTWLz3Kx0Xsd90Ab/YIDsUnNr6jC/CTfJKKB
         Gsewp9IB5N47fxa8NgZ3F3+HdSMUE3oFImmZcs2dpw1qUC/Yc3HGc/a5vr8+3kZpRe
         twjcFIetZwkTsV9L01auQZ6EaVr3uRhFvTBGm1rbSlUj3PMFc+W12MBwzHUM1RCnDh
         +QOkKgigHCTXkX7wC2tLiaQkCvoovIh4R/+puSdqKe+0yUtfa2pXBgB1lzbsPl4wo3
         g4oegqH5gtR9dM1ujqjspDNf3tyBZOkDH44I9lRtkK4gtTn734jaaT4qlpX8Yoj8jF
         Ya6vfwg+nhu4A==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Nikita Travkin <nikita@trvn.ru>
Cc:     jenneron@postmarketos.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231020-sc7180-qdsp-sndcard-v1-0-157706b7d06f@trvn.ru>
References: <20231020-sc7180-qdsp-sndcard-v1-0-157706b7d06f@trvn.ru>
Subject: Re: [PATCH 0/2] sc7180: Add qdsp baked soundcard
Message-Id: <169834021081.149939.3520512411729712585.b4-ty@kernel.org>
Date:   Thu, 26 Oct 2023 18:10:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023 20:33:45 +0500, Nikita Travkin wrote:
> Some devices, such as Acer Aspire 1, can't use lpass dirrectly, but
> instead must use adsp core to play sound. Since otherwise the hardware
> is, usually, very similar across the devices on the same platform, it
> makes sense to reuse the same boardfile.
> 
> This series refactors the sc7180.c slightly and adds the functions to
> control clocks via adsp instead of controlling the hardware directly.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: qcom,sm8250: Add sc7180-qdsp6-sndcard
      commit: 5443d186163c6ab0084a5b23c901e0f9ba792463
[2/2] ASoC: qcom: sc7180: Add support for qdsp6 baked sound
      commit: 4531f512e3ef147f07d47bceb256c0af5ab130b7

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

