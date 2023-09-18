Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBA07A4E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjIRQIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjIRQID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:08:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3954246A8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:06:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4191AC43397;
        Mon, 18 Sep 2023 16:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695053165;
        bh=V2Ca0FDQjE39oqGvsLz24cV0i2ZCGGyShiYZ2H0bMsg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UldQm7CJ9UETNwt+IdBde9nLe74kkvoFkvfYLgXu1wygHRMBeXhwMD4yoVxTVDqT5
         KF7laZavM388qSKV5hu541FbgkeV/OLoJMEGr+esV1HWx69xQ6y+hPQZwPJBJTSHFW
         i5jmLAjYCu93Oh0/saLqhJ0sr40KOZQO/dBntn5sFcSBZDrY9AmceMpk0ZnvZ7FZve
         yzGiJyTINuLc2TZuyXflbd6l8bjKcZJMnI76hyKDALDA7yESCoJR7uWEPL6OvGPSt4
         NGwyHhGF3qIuZbVamVqmwshVBvQbcrA3P5Tl7uoelHpXhj5GrgTl1M/muH0HokK8SJ
         34BmXpUUBpeQQ==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, John Watts <contact@jookia.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230918131532.2257615-1-contact@jookia.org>
References: <20230918131532.2257615-1-contact@jookia.org>
Subject: Re: [PATCH v4 0/3] ASoC: wm8782: Allow higher audio rates
Message-Id: <169505316298.74713.188374805406477074.b4-ty@kernel.org>
Date:   Mon, 18 Sep 2023 17:06:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2023 23:15:29 +1000, John Watts wrote:
> The wm8782 supports higher audio rates than just 48kHz. This is
> configured by setting the FSAMPEN pin on the codec chip.
> 
> This patch series introduces the 'wlf,fsampen' device tree property
> to indicate the pin status and control the maximum rate available
> when using the codec.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: wm8782: Constrain maximum audio rate at runtime
      commit: 00524a8415aa400567538c0e75a463d517cded7f
[2/3] ASoC: wm8782: Use wlf,fsampen device tree property
      commit: 5d34887eab8daad8f63d584ae4d12d480beb9f0e
[3/3] ASoC: dt-bindings: wlf,wm8782: Add wlf,fsampen property
      commit: 5d5529b0057146043a4328aa194280299ba966c2

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

