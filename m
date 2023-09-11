Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3254179C096
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346857AbjIKVYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241394AbjIKPHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:07:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8BACCC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:07:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EFEC433CA;
        Mon, 11 Sep 2023 15:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694444862;
        bh=V/6hBx5mfx0fd3CGt05eTAr9zX0uhJnhj4yOo8q7jvg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GpTK2/sRNv5OM0TZC09QCDJ+z89ykEEW0HzWjtUQQQyDMbUAlotSUgO3hDmQms3mC
         SjHNXCrzzH3pciauKJw+s6l2epY5XBuDMYEjF8WWilN+uhJJtdvn1MroneBHbJikO9
         ewk5EM+L8Kn2cZI1+UBtOJK6H5sJ76fg2iEmUh+H421I4e2ywu6oVxJQP67AiuWDuF
         IMh11Tx5q4HozD4yYj9J3IhfxRKmfivF6zQKuRP6hdo40cIrnZTkynN0lxhBVL94NC
         t73StKrOtJSZL5ROTYjSKz8v62D/aAEB7UiJurIMUmXXFYTL4zoZOG59zI+8qGN6VA
         fBcSaSQjbXlYg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
In-Reply-To: <20230907090504.12700-1-jbrunet@baylibre.com>
References: <20230907090504.12700-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: spdifin: start hw on dai probe
Message-Id: <169444486047.1851820.2260771441651865260.b4-ty@kernel.org>
Date:   Mon, 11 Sep 2023 16:07:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Sep 2023 11:05:04 +0200, Jerome Brunet wrote:
> For spdif input to report the locked rate correctly, even when no capture
> is running, the HW and reference clock must be started as soon as
> the dai is probed.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: spdifin: start hw on dai probe
      commit: aedf323b66b2b875137422ecb7d2525179759076

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

