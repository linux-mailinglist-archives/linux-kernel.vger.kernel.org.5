Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D117F5DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344976AbjKWLZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345022AbjKWLZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:25:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58684D8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:25:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D26C433C8;
        Thu, 23 Nov 2023 11:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700738748;
        bh=d2fQ5OUt37NZjXyFL/AztRcqGEHUeRQlVmUFvl3AmKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qKN5IfJOAUuRmyDj7z/eZH7XCdF2ILc6caa6Ssp+CAb/4p8gvvIIC1Y8qU2oie668
         S9f57o1peTZBF13xbfqRin0CBh3TaESNBhcdXlo/qDUVHQ8QB9MzCJgbSrGICSGdHn
         RP/0/kIgeEtktseQyMAlVvLvlxJLuFutekQJZvr0fkLFJYDQBoHgYPdAtuByCtgbT8
         mPgryIzc6IsxqgGE629So+6RrORm+ufHhzMejpTYpjDpFrMEHZP+tPkMqyfPhbf2vh
         r2Bohiiip/bWnG+Bfew7B+g6tRyD74Ds92ZGixObxR+DXlQGfMWPVTnFYQbA3dV+C2
         dBd3I6XyPC0EA==
Date:   Thu, 23 Nov 2023 11:25:43 +0000
From:   Lee Jones <lee@kernel.org>
To:     Shiji Yang <yangshiji66@outlook.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: leds: add 'internet' and 'signal'
 function definitions
Message-ID: <20231123112543.GD1243364@google.com>
References: <TYAP286MB0315F4D71698370875F58F6EBCAAA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYAP286MB0315F4D71698370875F58F6EBCAAA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Florian,

Thoughts?

On Mon, 06 Nov 2023, Shiji Yang wrote:

> These two types of LEDs are widely used in routers and NICs.
> 
> The 'signal' LED is used to display the wireless signal strength.
> Usually, there are 3~4 LEDs in one group to indicate the signal
> strength, similar to the signal icon on a mobile phone.
> 
> The 'internet' LED can indicate whether the device can access a
> specific server. It's different from 'wan'. 'wan' usually indicates
> whether the WAN port is connected to the modem (internet services
> may still be unavailable). But the 'internet' shows if the device
> can successfully ping servers such as 8.8.8.8 to detect the internet
> connection status. When the router is running in AP only mode, we
> can even connect LAN port to the AC/modem to connect to the internet.
> In this case, the 'internet' LED should be on. On some routers, both
> 'internet' and 'wan' are available and can be controlled separately.
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> ---
> 
> Changes in v2:
> * Remove the LED name sorting patch as it changes the ABI.
> * Add "devicetree@vger.kernel.org" to '--to' list.
>   Thanks to Rob Herring and Krzysztof Kozlowski for letting me know I
>   can send patch to multiple mailing list at once.
> 
> Changes in v3:
> * Add more information about the new added LEDs.
> * Remove the missing LED fix as Jisheng Zhang has already sent a
>   similar one. I should search the mailing list first...
> 
> Changes in v4:
> * Rename 'rssi' LED to more generic name 'signal'. I forgot to update
>   the source file in v3.
> 
> v1:
> https://lore.kernel.org/all/TYAP286MB0315FE921FF113BF76F7B700BCA0A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/
> 
> v2:
> https://lore.kernel.org/all/TYAP286MB03159A83A77E6FD59F271D9BBCA0A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/
> 
> v3:
> https://lore.kernel.org/all/TYAP286MB0315AE8F62E6AB48E3F9A0DDBCA5A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/
> 
>  include/dt-bindings/leds/common.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
> index 9a0d33d02..f831c5dba 100644
> --- a/include/dt-bindings/leds/common.h
> +++ b/include/dt-bindings/leds/common.h
> @@ -88,6 +88,7 @@
>  #define LED_FUNCTION_FLASH "flash"
>  #define LED_FUNCTION_HEARTBEAT "heartbeat"
>  #define LED_FUNCTION_INDICATOR "indicator"
> +#define LED_FUNCTION_INTERNET "internet"
>  #define LED_FUNCTION_LAN "lan"
>  #define LED_FUNCTION_MAIL "mail"
>  #define LED_FUNCTION_MTD "mtd"
> @@ -95,6 +96,7 @@
>  #define LED_FUNCTION_PROGRAMMING "programming"
>  #define LED_FUNCTION_RX "rx"
>  #define LED_FUNCTION_SD "sd"
> +#define LED_FUNCTION_SIGNAL "signal"
>  #define LED_FUNCTION_STANDBY "standby"
>  #define LED_FUNCTION_TORCH "torch"
>  #define LED_FUNCTION_TX "tx"
> -- 
> 2.39.2
> 

-- 
Lee Jones [李琼斯]
