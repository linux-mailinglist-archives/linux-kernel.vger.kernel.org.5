Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AF07EEA16
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 00:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345574AbjKPXrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 18:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjKPXrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 18:47:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E290B9;
        Thu, 16 Nov 2023 15:47:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2E2C433C8;
        Thu, 16 Nov 2023 23:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700178448;
        bh=WOHViIxsGHrN/gNE3gzTC77FjzxEiTyE2iTd8xz+Wfo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=spwA8m5Pr1mTw2K20qPXTga4zIBXC9OJ1X5QWrXnqNs2gzaXFKXrU/H+7kfniORsl
         u2IE2F3hl2dfiq64dm6BPyEZMcaMTwKlPjq6JXkxQ1MwtXHTEcvo4fn/ZJFMlODiRu
         efIaSERo1pGEo045uX3+ZG8AM2PDrdX5VUwUP8h6tx+9Oxpc/gDUzhSA7rYpAX7OaJ
         O+2aY9djpBVlYAsRXWBBgRPxx0R2Z6Jd4pA93kSbw5Y0JjiBAvxcnJIN2ieIpaKSL2
         4wIipQZdYm+IEPYuH7HFcP/4Gdd0wVbeOBBg7p4OI+PWVtP/ffsVobKBX+DNmX95tG
         E59PATZh6evLQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231115213358.33400-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231115213358.33400-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] ASoC: dt-bindings: renesas,rz-ssi: Document RZ/Five
 SoC
Message-Id: <170017844517.82995.8563530422140477667.b4-ty@kernel.org>
Date:   Thu, 16 Nov 2023 23:47:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 21:33:58 +0000, Prabhakar wrote:
> The SSI block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,r9a07g043-ssi" compatible string will be used on the RZ/Five
> SoC so to make this clear and to keep this file consistent, update the
> comment to include RZ/Five SoC.
> 
> No driver changes are required as generic compatible string
> "renesas,rz-ssi" will be used as a fallback on RZ/Five SoC.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: renesas,rz-ssi: Document RZ/Five SoC
      commit: 7d562ac331ddc4f798e6185a858bc98c22ee7d1b

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

