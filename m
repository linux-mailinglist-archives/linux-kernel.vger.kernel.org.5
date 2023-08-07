Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2577577301F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjHGUGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjHGUGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:06:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0C0E66;
        Mon,  7 Aug 2023 13:06:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C1FD621C5;
        Mon,  7 Aug 2023 20:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6075CC433C9;
        Mon,  7 Aug 2023 20:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691438793;
        bh=+1qj84olRLv+gw33x9xv4AJC1ye6/RmLGqEDA6DYiUA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mRKIamwQFnGtZeHvuUfAhkvUzRFsB94rvDyRHxJD/n7wmLYEPIiGY1xI3x3onJD0Y
         wvFtumTxXPlINXwRUa4jGH+X37RSTacgL3QPd7MVUkDgo2tBSG7hebGsnRgjPYd93l
         h67yxebo6d4UyTTvnT+WiT6AO+8tsJhSenCiU7iB6BrRuhGuCF7tysKiu+K2399vQD
         rfzuBPbJ4AeHxfbVsHjlivcS6un3hiaiV3vIHchkEhNstFvYbKTQENVHKv5dWqxxVT
         uBRsPFM+bOMl+yGQzH9HjBIPQfzk6KwQQCueLAhRc5NkGe1naAN+5m3MDTfZGMJ1C7
         GRqBTdrsMGClA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Alina Yu <alina_yu@richtek.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <1691389687-31211-1-git-send-email-alina_yu@richtek.com>
References: <1691389687-31211-1-git-send-email-alina_yu@richtek.com>
Subject: Re: [PATCH v7 0/2] Add Richtek RTQ2208 SubPMIC support
Message-Id: <169143879211.313569.6869257260821190569.b4-ty@kernel.org>
Date:   Mon, 07 Aug 2023 21:06:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Aug 2023 14:28:05 +0800, Alina Yu wrote:
> This patch series adds support for RTQ2208 SubPMIC regulators.
> The RTQ2208 is a multi-phase, programmable power management IC that
> integrate with dual multi-configurable, synchronous buck converters
> and two ldos. The bucks features wide output voltage range from 0.4V to 2.05V
> and the capability to configure the corresponding power stages.
> 
> Thank you,
> Alina yu
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: dt-bindings: rtq2208: Add Richtek RTQ2208 SubPMIC
      commit: 4b591ed6971191134e331f02300b4ec4dee188ea
[2/2] regulator: rtq2208: Add Richtek RTQ2208 SubPMIC driver
      commit: 85a11f55621a0c18b22b43ab4219450ac1d19386

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

