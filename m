Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6864D772FED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjHGTyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjHGTyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:54:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66017E79;
        Mon,  7 Aug 2023 12:54:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F087F61EB4;
        Mon,  7 Aug 2023 19:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE523C433C7;
        Mon,  7 Aug 2023 19:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691438054;
        bh=BJz6MirJZr4GIuALmgQd8ZM1FYtuXj7SXO6/fRuEKwc=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=NOQwMSLuGaykZa6XChbrUucGXaE1b3IQozwo0csRfwEVqvjt8Kx+whuxMPf+uz74b
         gkut8MSqnBkyH1YgK0dVcZPnp/A8j5/0h/0GLfvstdT4lv7vWwtgxhSKNjRwi2f646
         1iNlv3TOr6Mpgk0N0fYyZZxLy44Ovb3bLfgZDGQfnUTkzQP6oWK6D35YmVZtbKxsNI
         f2eBflc9a+LkX7EXLHgfBWunmwpo4KJY3vblCLOct2/ssHmjHMZIaWJhinnZpLboV9
         JLyfBkVAHrWsP1sdySRP78cuxwX1FxAV+dKYVPw/QMmqLFLPw7I8SMMVd7FDEoeBVo
         UOzjXbj/CBZWQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ryan Lee <ryans.lee@maximintegrated.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230730201826.70453-1-krzysztof.kozlowski@linaro.org>
References: <20230730201826.70453-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/3] ASoC: dt-bindings: Convert maxim,max98925 to DT
 schema
Message-Id: <169143805139.302632.1243042344493103435.b4-ty@kernel.org>
Date:   Mon, 07 Aug 2023 20:54:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jul 2023 22:18:24 +0200, Krzysztof Kozlowski wrote:
> Convert the Maxim Integrated MAX98925/MAX98926/MAX98927 speaker
> amplifier bindings to DT schema format.  Changes during conversion:
> 1. Add "sound-dai-cells", already used by DTS.
> 2. Use "maxim,interleave-mode" instead previous "interleave-mode" and
>    undocumented but used interleave_mode.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: Convert maxim,max98925 to DT schema
      commit: 7136368a2f3fda492d696bdeddf4d2af71fa8b92
[2/3] ASoC: codecs: max9892x: Unify interleave mode OF property
      commit: ddef7518e76d832ab9f6d0430ad28cc0e04c083a
[3/3] ASoC: codecs: max9892x: Reformat to coding style
      commit: 38b288ab454f9aecf7b717974028f57f5243dc5a

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

