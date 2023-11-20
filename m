Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2A87F1D36
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjKTTS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKTTSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:18:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAA3BB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:18:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05A4C433C8;
        Mon, 20 Nov 2023 19:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700507931;
        bh=7l/BJemceh+NKK3sSMzDbS+2RzVYcr6sgFQMzStHspU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KTUjuRogANol7OYCdPyp7ohz8lnqc/2AsUFiCtytA6PVPb6xDLTlsKHiEdVGaYnkV
         OpCB+CLx/yhopSc7sgbvGlk9LUu4AGp+qnp9NxfO4Qe/7/zMqyNlyafre1aPb8tKOJ
         lgLl5+JWl6PohkmCvaIQUvXdcqVw7g3Ed+PRwS8QIKG2Wd4vWFrsI3BoZFU7MmoB1S
         drWAxY+46M5W5RaDa8p0n1cAcR1gy3gV0Rf1jWX6+Mo2PzqlnMTlo+5JGt34NfNziL
         Qv2I1Mriclg0NTXbA68HjMgwQOMj+ezvYHE09HJpR4pjlNoN6Rd0pBkoZAw53JyeL9
         YSToaWCcFKj4Q==
From:   Mark Brown <broonie@kernel.org>
To:     David Lin <CTLIN0@nuvoton.com>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, YHCHuang@nuvoton.com,
        KCHSU0@nuvoton.com, WTLI@nuvoton.com, SJLIN0@nuvoton.com,
        ctlin0.linux@gmail.com
In-Reply-To: <20231120084227.1766633-1-CTLIN0@nuvoton.com>
References: <20231120084227.1766633-1-CTLIN0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8810: Fix incorrect type in assignment and
 cast to restricted __be16
Message-Id: <170050792951.1294254.14784272204812613089.b4-ty@kernel.org>
Date:   Mon, 20 Nov 2023 19:18:49 +0000
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

On Mon, 20 Nov 2023 16:42:28 +0800, David Lin wrote:
> This issue is reproduced when W=1 build in compiler gcc-12.
> The following are sparse warnings:
> 
> sound/soc/codecs/nau8810.c:183:25: sparse: warning: incorrect type in assignment
> sound/soc/codecs/nau8810.c:183:25: sparse: expected int
> sound/soc/codecs/nau8810.c:183:25: sparse: got restricted __be16
> sound/soc/codecs/nau8810.c:219:25: sparse: warning: cast to restricted __be16
> sound/soc/codecs/nau8810.c:219:25: sparse: warning: cast to restricted __be16
> sound/soc/codecs/nau8810.c:219:25: sparse: warning: cast to restricted __be16
> sound/soc/codecs/nau8810.c:219:25: sparse: warning: cast to restricted __be16
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: nau8810: Fix incorrect type in assignment and cast to restricted __be16
      commit: af524e9dcb43f5914cecb3a3f4b79081d2e3f7f8

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

