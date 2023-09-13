Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A7579EFFC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjIMRMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjIMRMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:12:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D3398;
        Wed, 13 Sep 2023 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=r8I4qC7Vlr5B99TPbNKHmvkTd1ZsuG6x4flsCcDEFRs=; b=YlDcCg25K2kp/qNccPwM6H1JVU
        g56M1/39giTMK8jM2ObeQ556zaXIuvuUN0+FUCGzW9iiiWbU5sd4Y0Lt5c14V0fxpZ3ETcYZnRY/g
        /TuM0Fbp/1H1wfHk39baROvANZ05Dl7RyTgFLRcpkUxQRFwRcloyn7hWOLwPEQyzCrIWStG92JVry
        CYDEyCRs60JDPB+JPnjYqyBefagJJXVbw47mtQbevj/m1mQo7yA38QCwoUNzoovpbc2trvGGAZTjR
        HufH0QU/fCLNozR98MGaHYeSclj2YuAjQfJuMEicsPFdm44+yRIhA68+uMcvvbmFgT1oPop7H8RR5
        4ywzvP8g==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgTPz-006TJu-2W;
        Wed, 13 Sep 2023 17:12:47 +0000
Message-ID: <140e7f79-4e03-47ec-99de-90871ca8d445@infradead.org>
Date:   Wed, 13 Sep 2023 10:12:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: nuvoton: Fix up Kconfig deps
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230913-novoton-kconfig-v1-1-1c2dff14c0d2@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230913-novoton-kconfig-v1-1-1c2dff14c0d2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/23 01:50, Linus Walleij wrote:
> We have build errors due to missing dependency on OF.
> Add the dependency and do it the same way for all three
> Nuvotons while we are at it.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Works for me. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/pinctrl/nuvoton/Kconfig | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/nuvoton/Kconfig b/drivers/pinctrl/nuvoton/Kconfig
> index 612e7ba02238..2abbfcec1fae 100644
> --- a/drivers/pinctrl/nuvoton/Kconfig
> +++ b/drivers/pinctrl/nuvoton/Kconfig
> @@ -2,8 +2,7 @@
>  
>  config PINCTRL_WPCM450
>  	tristate "Pinctrl and GPIO driver for Nuvoton WPCM450"
> -	depends on ARCH_WPCM450 || COMPILE_TEST
> -	depends on OF
> +	depends on (ARCH_WPCM450 || COMPILE_TEST) && OF
>  	select PINMUX
>  	select PINCONF
>  	select GENERIC_PINCONF
> @@ -35,7 +34,7 @@ config PINCTRL_NPCM7XX
>  
>  config PINCTRL_NPCM8XX
>  	tristate "Pinctrl and GPIO driver for Nuvoton NPCM8XX"
> -	depends on ARCH_NPCM || COMPILE_TEST
> +	depends on (ARCH_NPCM || COMPILE_TEST) && OF
>  	select PINMUX
>  	select PINCONF
>  	select GENERIC_PINCONF
> 
> ---
> base-commit: c9336ebe87e77f92ed04a86c0131a0310d0e200d
> change-id: 20230913-novoton-kconfig-895c60755500
> 
> Best regards,

-- 
~Randy
