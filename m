Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE997A36A0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 18:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbjIQQq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 12:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237140AbjIQQqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 12:46:25 -0400
Received: from out-210.mta0.migadu.com (out-210.mta0.migadu.com [91.218.175.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2AC130
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 09:46:18 -0700 (PDT)
Date:   Mon, 18 Sep 2023 02:41:39 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1694969176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cWEPku0i8kVPsZpOe1gkv2DiCKZJ0Jfwih7/n8DF784=;
        b=se7/6/QM0A8jm9+kIdXkUD3Jf6aYwkf6CSra3Mddks3SB0bfk7CUE5iQyuYNXvelfrLiIO
        gG86cqzwkLn7Fj50xHajVTRKAPbMR4UwO+lxAtR7wAdXTUFi9e01LUXiplLeCXEWsYbvtV
        aOtiEjof1sHiIwLA6SQG5aMDNLUw7E5vK9v5cMqjDSXOXjjh7qJO8faxgdvSpuaqpOKgdH
        GzYlxOQt4DE/BfkYobq6EvHORYo/wVuOr/Yu3tLOGqLbJ/MZ3y8jsdv4NzkOG4nVeJA7qd
        QRfHK40BzGPumrAcx8/lo56P+JuZhu61BnmhuOXrFHaF5CnvucD4RJTdk7PE/w==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     linux-can@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] can: sun4i_can: Only show Kconfig if ARCH_SUNXI is set
Message-ID: <ZQcsQ3z1OZMfZLH9@titan>
References: <20230905231342.2042759-2-contact@jookia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905231342.2042759-2-contact@jookia.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I'd like to bump this. Do I re-send this or just reply to it?

John.

On Wed, Sep 06, 2023 at 09:13:43AM +1000, John Watts wrote:
> When adding the RISCV option I didn't gate it behind ARCH_SUNXI.
> As a result this option shows up with Allwinner support isn't enabled.
> Fix that by requiring ARCH_SUNXI to be set if RISCV is set.
> 
> Fixes: 8abb95250ae6 ("can: sun4i_can: Add support for the Allwinner D1")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/linux-sunxi/CAMuHMdV2m54UAH0X2dG7stEg=grFihrdsz4+o7=_DpBMhjTbkw@mail.gmail.com/
> Signed-off-by: John Watts <contact@jookia.org>
> ---
>  drivers/net/can/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index 649453a3c858..f8cde9f9f554 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -190,7 +190,7 @@ config CAN_SLCAN
>  
>  config CAN_SUN4I
>  	tristate "Allwinner A10 CAN controller"
> -	depends on MACH_SUN4I || MACH_SUN7I || RISCV || COMPILE_TEST
> +	depends on MACH_SUN4I || MACH_SUN7I || (RISCV && ARCH_SUNXI) || COMPILE_TEST
>  	help
>  	  Say Y here if you want to use CAN controller found on Allwinner
>  	  A10/A20/D1 SoCs.
> -- 
> 2.42.0
> 
