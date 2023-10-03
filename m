Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702367B6F43
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjJCRIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjJCRIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:08:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAC2A7;
        Tue,  3 Oct 2023 10:08:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67FCC433C8;
        Tue,  3 Oct 2023 17:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696352915;
        bh=z0khdQB11BoA0tQ40lKmz5sxH1m9xC78cFe/yLn2g6o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oIucdHjiAoMeu9S2B2ofb7H1+u6bLJgvxIzwxoJhO5ggZBy5WKoRWI6T/dVPA55vU
         x8abIexv0M0heossk7yTWtHBnA4FXmaLLqsN/ypGorLlRpzY/2oIhdHjnnYE9ZA2Lb
         csq7Di/OPv8lTrB5UVU91m3/6IZZAm3RFPP/8yZz2ayqOCntxWpkcrnlkxbe1QrnFb
         PF2LCKBuCD2tEvmvRi6YpVntehrK9uC1+TOjXNPaSerqQfzDcfDD7YC2uMLnZufN2D
         6kbBR+Q67GVa9Ca7sv3l6UWKsCgY+/LRZC1iE3aHXM11qu5OXJDU5kJoAEfOUJKDWJ
         I20U96sourupg==
From:   Mark Brown <broonie@kernel.org>
To:     Weidong Wang <wangweidong.a@awinic.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20231002-aw88261-reset-v2-0-837cb1e7b95c@fairphone.com>
References: <20231002-aw88261-reset-v2-0-837cb1e7b95c@fairphone.com>
Subject: Re: [PATCH v2 0/2] Remove reset GPIO for AW88261
Message-Id: <169635291227.42044.6654746210996061480.b4-ty@kernel.org>
Date:   Tue, 03 Oct 2023 18:08:32 +0100
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

On Mon, 02 Oct 2023 16:00:10 +0200, Luca Weiss wrote:
> The AW88261 chip doesn't have a reset gpio, so remove it from the
> bindings and from the driver.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: awinic,aw88395: Remove reset-gpios from AW88261
      commit: c7b94e8614e35f1919b51c23fe590884149ae341
[2/2] ASoC: codecs: aw88261: Remove non-existing reset gpio
      commit: 4eed047b76fa8f56af478ca7e6d56ca7e5330cf2

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

