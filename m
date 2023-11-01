Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2687DE084
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 12:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbjKALsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 07:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjKALsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 07:48:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCD0DC;
        Wed,  1 Nov 2023 04:48:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC71C433C7;
        Wed,  1 Nov 2023 11:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698839283;
        bh=nxMPbDkv3IAzUXb07QKYgvp8/kcjLcwieAGlAyQanac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kn2TQOyzP5dcMyQRVZi9kU9LccVJlmV9k906FoMoHVQO2ECCiG41yL4dE0Zsu7BGa
         GW54QrYmkpabT+DGlTVsV3jSscpjw2YU4UUTM0K4a1/nj7pxa/AUBXapT7LrBWo6F/
         S3tmtgZ/dU0ilReUZl9sJc6cXWTeFATSp0E0zRIazZW6A8ejdRPAqMZK49TK97lrIj
         SaltIiCqOa2Q83EMO0rxEjUYPtuFvHx0S7gbg/51WOeC/HxujYqwyGFtRfUS3DRjb1
         N47QezATy4pesaDCLaqiWpGRX6SlIvMMt+TdylLQH7vkzbw1q6H1hzLUZ1fJ7cnKzf
         q4M0UnfeQJSyA==
Date:   Wed, 1 Nov 2023 19:35:47 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH v2 1/2] leds: core: add missing LED color strings
Message-ID: <ZUI4E06PYez5Z5LI@xhacker>
References: <20231031132901.11732-1-yangshiji66@outlook.com>
 <TYAP286MB03159A83A77E6FD59F271D9BBCA0A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TYAP286MB03159A83A77E6FD59F271D9BBCA0A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 09:29:00PM +0800, Shiji Yang wrote:
> Some new monochromatic LEDs have been introduced into DT bindings,
> but they do not have corresponding descriptions on the led_colors
> structure. This patch adds the missing LED color strings.
> 
> Fixes: 472d7b9e8141 ("dt-bindings: leds: Expand LED_COLOR_ID definitions")
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> ---
>  drivers/leds/led-core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
> index 214ed81eb..223023928 100644
> --- a/drivers/leds/led-core.c
> +++ b/drivers/leds/led-core.c
> @@ -36,6 +36,11 @@ const char * const led_colors[LED_COLOR_ID_MAX] = {
>  	[LED_COLOR_ID_IR] = "ir",
>  	[LED_COLOR_ID_MULTI] = "multicolor",
>  	[LED_COLOR_ID_RGB] = "rgb",
> +	[LED_COLOR_ID_PURPLE] = "purple",
> +	[LED_COLOR_ID_ORANGE] = "orange",
> +	[LED_COLOR_ID_PINK] = "pink",
> +	[LED_COLOR_ID_CYAN] = "cyan",
> +	[LED_COLOR_ID_LIME] = "lime",

A similar patch was sent out two days ago, earlier than yours ;)

https://lore.kernel.org/linux-leds/20231030054757.3476-1-jszhang@kernel.org/

>  };
>  EXPORT_SYMBOL_GPL(led_colors);
>  
> -- 
> 2.39.2
> 
