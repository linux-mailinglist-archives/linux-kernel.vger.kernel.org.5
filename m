Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DDC77AF02
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 02:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjHNAdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 20:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjHNAd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 20:33:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAC910C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 17:33:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE54662960
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4EFC433C8;
        Mon, 14 Aug 2023 00:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691973204;
        bh=0HKobCwYJFp7mNGj/ksagn8lLLwH/aW5JaCOpwiB5t0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JiRi28u6DZG74urkNp05FI9KBRTVEEI1sk7CL44WhVK5Z19h1fLbOCt3SiAsU/Gmx
         MM6+iWtN14BUEZ7PEjgmx0KsfYMx7nJapVTonxciXv0cPTmgC0py3Qhr9ZNrxNV5pc
         0m17dRuWHn9tQ8lfSf/u4zIz4eS4B5QcF0GSaeLDV7p3p9zexml4Z1IJXR/YfZa3f4
         Dqu7gFyApNgObvjKngdn4VHs6SXAy7PCCo4ZuKItTv/PXsSuD2RzfUXrkH95eYYPJy
         N+ePLnqjQIcCQ1WIiwAtWWejsQa0Dsnx8LCex0H91cy7qMoxg++h30KPjNX5Y5Bs6F
         9Yl7ELOgG/uiw==
From:   Mark Brown <broonie@kernel.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230812-descriptors-asoc-v1-0-eb4dca1f68af@linaro.org>
References: <20230812-descriptors-asoc-v1-0-eb4dca1f68af@linaro.org>
Subject: Re: [PATCH 00/14] ASoC: rt: Drop unused GPIO includes
Message-Id: <169197320197.2741913.755518559282925421.b4-ty@kernel.org>
Date:   Mon, 14 Aug 2023 01:33:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Aug 2023 21:56:38 +0200, Linus Walleij wrote:
> These drivers include legacy GPIO headers for no reason
> at all, so get rid of the includes.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/14] ASoC: rt1011: Drop GPIO includes
        commit: a5c8e75b34fa0d399e8e6b304de3bad4d9e41a3a
[02/14] ASoC: rt1015: Drop GPIO include
        commit: c7a7f4444b1fd648edc3fb54f2d3822215b46c56
[03/14] ASoC: rt1015p: Drop legacy GPIO include
        commit: 3abc7076851f63c5d193ee9d942554f182527d18
[04/14] ASoC: rt1016: Drop GPIO include
        commit: 8a5a8015b1e23e41204738f2147c01bf18039965
[05/14] ASoC: rt1019: Drop GPIO include
        commit: e04cbe53205ecfcb1f2a8314dfc829ebbcb542f1
[06/14] ASoC: rt1305: Drop GPIO includes
        commit: ba55dde45b5a5595763af6d06066ab789792e9d3
[07/14] ASoC: rt1308: Drop GPIO includes
        commit: f36c684e9941b3af6769b984239f62dc9fe99698
[08/14] ASoC: rt5514-spi: Drop GPIO include
        commit: 12ffd88e398cb82f960da25ab990a6864641fee1
[09/14] ASoC: rt5514: Drop GPIO include
        commit: 9fdc4feacdb0a5b3a49d611aff88371f8f8d4971
[10/14] ASoC: rt5645: Drop legacy GPIO include
        commit: 92f1b48277f2fdaa9649630dc9a8ec298bfd6def
[11/14] ASoC: rt5659: Drop legacy GPIO include
        commit: 0b759f3b3faa51022752bc4a99ae1af57baf344f
[12/14] ASoC: rt5660: Drop GPIO includes
        commit: b72a4dc2bede787221a4b1b2e3860f6725f109b5
[13/14] ASoC: rt5682-sdw: Drop GPIO includes
        commit: 1a625a7a5d74be6b367301e6eb9e38d35797313a
[14/14] ASoC: rt715: Drop GPIO includes
        commit: 797df2a670c336500cdea482f404a24b45b28f45

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

