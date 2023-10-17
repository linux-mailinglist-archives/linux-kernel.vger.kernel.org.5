Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2F57CD0F7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbjJQXlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344441AbjJQXls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:41:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DCA126;
        Tue, 17 Oct 2023 16:41:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF443C433C8;
        Tue, 17 Oct 2023 23:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697586101;
        bh=cosGpqTPBP8SyGB5H3DKe/jNOoJkAxcsVXoEDGMqP/M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Q7nuLFDt00WV1OayCAu2PTX6zT0gcHiWi6Rbc92RpYMc7tzlRkm196nRGWk2m177n
         qQOfJj/YaIwe656Gqv/l6WaX0hpyvsCjYZCE8+sD75vr3HHC8KgRdsM/+WVI0Lci8o
         MEUdmpO9uHLnV6loWfgwk1KHPEQE23PFxPxD/cGOTSiwMaay7U8gqSo9/gvMwtn8Nh
         5SuCB9MCMiTRa6WR21Nm3c5MXvP4Cn/F4ob2gk+o+e1BwXsoZ0IGyAJa2rIJW3zgAe
         dO1JI29+yBS2HJqz1f6Fqf1wpId8c4Ry0JtM50zHc8cPcBWGAtEpIaLkRgDlF8Pxcg
         nLOk6lWqh7+Ig==
From:   Mark Brown <broonie@kernel.org>
To:     Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231017203352.2698326-1-robh@kernel.org>
References: <20231017203352.2698326-1-robh@kernel.org>
Subject: Re: [RESEND PATCH] spi: stm32: Explicitly include correct DT
 includes
Message-Id: <169758609942.3230802.8032777106804469822.b4-ty@kernel.org>
Date:   Wed, 18 Oct 2023 00:41:39 +0100
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

On Tue, 17 Oct 2023 15:33:51 -0500, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it was merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: Explicitly include correct DT includes
      commit: 692225015c82d3eece55a07d16cd24c4dc63a6a5

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

