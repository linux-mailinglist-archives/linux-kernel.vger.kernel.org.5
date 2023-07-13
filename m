Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811B77525B1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjGMOzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjGMOzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:55:24 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BEC2712
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:55:15 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-cb19b1b9a36so759739276.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20221208.gappssmtp.com; s=20221208; t=1689260114; x=1691852114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yxJReeu3wFsDEIoI+Y5EvxsHxuUj1xvYudc1q2Ogc0w=;
        b=ond3ynwi15WishNDTT+qMQTWpC87sA93J5YINYb/UQxMxZtD2l81f0u58lE6VXbpVk
         m2eTgHMocycV9opUSB5jzMXo+QW9SIxbmRfv10fDXTK8UDHm+sskKWUAfchlIaw4ZYiZ
         0+f7et0pRsFrjwhnRPex2rRL6iL6jfER52dp3tUGBJBYUoYrqYSq4j+SaQQgN0gUzSMJ
         p0u3HaguYLLz+bv2OZZ2NiBHKAjs6dHJ/X8v7bwJFIBwQbrewTqiEegnqlPaWnASV/Kt
         zASovpdUT8U93pGjLTEtpB10OsfBHfnxvuG2RF35LhZmgSrefjNNE0gH/J/BZd5QKk9D
         Wb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689260114; x=1691852114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yxJReeu3wFsDEIoI+Y5EvxsHxuUj1xvYudc1q2Ogc0w=;
        b=c+HZh85GHJv2iCcSFDkNXTSPEqAByOmztjlsgSDtxxsQ0e9VBKu/Y961ox1iJrCet4
         zDYAkdUS0KccZ084VcM+bi9omC8UwB8od/pFteokURaJNu8JX+KZRBjDvbjbZH/qRdWx
         IEi2rXPMKFQ4RZgJ+IRVkxI2RLKC0DIWmGr6irdqQpIygoIxKvMW5XpK5k3CjE4o6Co1
         f4Z+kKlf4DFXIffJXUeR06tH/9oJF4ibx3ecWKH9086Vkai156vkF2jA22MC4XYGga82
         oLSf5v0pco3lrxWLdnLSLklCeaB9122fPEOSWVnarBBuOAdzIW87jDTWvXgCwHOwYJo7
         2R5A==
X-Gm-Message-State: ABy/qLZkDFqEVZxbka0BDn2m1eS0c8q9603olCSHxINXItO9C2Yc66yG
        6dN74YwQKk6DonE2/NkGtcRdEIRyPkjhWAEvgWMMwg==
X-Google-Smtp-Source: APBJJlG0ILTrJectunWl7ebCGzJocWBo/HnGO1eQZkCt18ndRK/0e8H6CL/4bTNR20NvglKrx3f/qqOh55pLa3q9E78=
X-Received: by 2002:a25:c0c8:0:b0:c4f:43d7:7daf with SMTP id
 c191-20020a25c0c8000000b00c4f43d77dafmr1442561ybf.1.1689260114481; Thu, 13
 Jul 2023 07:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230403193250.108693-1-sebastian.reichel@collabora.com> <20230403193250.108693-2-sebastian.reichel@collabora.com>
In-Reply-To: <20230403193250.108693-2-sebastian.reichel@collabora.com>
From:   Jagan Teki <jagan@edgeble.ai>
Date:   Thu, 13 Jul 2023 20:25:03 +0530
Message-ID: <CA+VMnFz4USPcXmQMyUB9n5EVmvQrJARDvnpO7iBrXZ8q2xcyAA@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] clk: rockchip: rk3588: make gate linked clocks
 ignore unused
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Vincent Legoll <vincent.legoll@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Tue, 4 Apr 2023 at 01:03, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> RK3588 has a couple of hardware blocks called Native Interface Unit
> (NIU) that gate the clocks to devices behind them. Effectively this
> means that some clocks require two parent clocks being enabled.
> Downstream implemented this by using a separate clock driver
> ("clk-link") for them, which enables the second clock using PM
> framework.
>
> In the upstream kernel we are currently missing support for the second
> parent. The information about it is in the GATE_LINK() macro as
> linkname, but that is not used. Thus the second parent clock is not
> properly enabled. So far this did not really matter, since these clocks
> are mostly required for the more advanced IP blocks, that are not yet
> supported upstream. As this is about to change we need a fix. There
> are three options available:
>
> 1. Properly implement support for having two parent clocks in the
>    clock framework.
> 2. Mark the affected clocks CLK_IGNORE_UNUSED, so that they are not
>    disabled. This wastes some power, but keeps the hack contained
>    within the clock driver. Going from this to the first solution
>    is easy once that has been implemented.
> 3. Enabling the extra clock in the consumer driver. This leaks some
>    implementation details into DT.
>
> This patch implements the second option as an intermediate solution
> until the first one is available. I used an alias for CLK_IS_CRITICAL,
> so that it's easy to see which clocks are not really critical once
> the clock framework supports a better way to implement this.
>
> Tested-by: Vincent Legoll <vincent.legoll@gmail.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/clk/rockchip/clk-rk3588.c | 42 +++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/clk/rockchip/clk-rk3588.c b/drivers/clk/rockchip/clk-rk3588.c
> index b7ce3fbd6fa6..6994165e0395 100644
> --- a/drivers/clk/rockchip/clk-rk3588.c
> +++ b/drivers/clk/rockchip/clk-rk3588.c
> @@ -13,15 +13,25 @@
>  #include "clk.h"
>
>  /*
> - * GATE with additional linked clock. Downstream enables the linked clock
> - * (via runtime PM) whenever the gate is enabled. The downstream implementation
> - * does this via separate clock nodes for each of the linked gate clocks,
> - * which leaks parts of the clock tree into DT. It is unclear why this is
> - * actually needed and things work without it for simple use cases. Thus
> - * the linked clock is ignored for now.
> + * Recent Rockchip SoCs have a new hardware block called Native Interface
> + * Unit (NIU), which gates clocks to devices behind them. These effectively
> + * need two parent clocks.
> + *
> + * Downstream enables the linked clock via runtime PM whenever the gate is
> + * enabled. This implementation uses separate clock nodes for each of the
> + * linked gate clocks, which leaks parts of the clock tree into DT.
> + *
> + * The GATE_LINK macro instead takes the second parent via 'linkname', but
> + * ignores the information. Once the clock framework is ready to handle it, the
> + * information should be passed on here. But since these clocks are required to
> + * access multiple relevant IP blocks, such as PCIe or USB, we mark all linked
> + * clocks critical until a better solution is available. This will waste some
> + * power, but avoids leaking implementation details into DT or hanging the
> + * system.
>   */

Does it mean the clk-link topology in the downstream kernel can be
reused the same as normal clock notation?

For example, I'm trying to add HCLK_VO1 directly to VO1 syscon instead
of routing to pclk_vo1_grf(done downstream)
      vo1_grf: syscon@fd5a8000 {
               compatible = "rockchip,rk3588-vo-grf", "syscon";
               reg = <0x0 0xfd5a8000 0x0 0x100>;
             clocks = <&cru HCLK_VO1>;
      };

This seems breaking syscon for vo1_grf and observed a bus error while
accessing regmap. I remember in one of the RKDC discussion that the
double parenting of these clocks is mandatory while accessing
associated IP blocks. Any thoughts?

Thanks,
Jagan.
