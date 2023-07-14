Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30BF75306D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 06:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbjGNENd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 00:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjGNENX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 00:13:23 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48762D45
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:13:21 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-307d20548adso1538636f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689308000; x=1691900000;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YABg4OT5HskdCrnMy3fonfRSK+TYxksn1HKEflOmZ9U=;
        b=O0qZyyZtLoQCGZgpM5FaFcrYrvzYbXDbUSz53lM6i3M6/HLdU9T/ifHsOzhdd1If50
         B67DARaGITXXc3IkD81uMnpTZwp0iR0anyYLo537xVo3TA6dJnwiFYcnX7qnOjaJpyy2
         yU6+2aKAfe2CFemet11kGNUBBCF3428QtyvQGWcAR0iM5tnoAGrZj0ognuG/INgIm4t0
         jOEsMpFvM873U3Ds5HZiKaZQfFKo8QuC1r0v0UOEUT1meKC3/kKhKIZWJXbHEXXtOi+C
         ur6e6xbYWFwrx8ej5s6dgXtYU8IK4QuUv4Hy4+pL2/qMHpPkmEkQguL6on6HRo5g7ytv
         hrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689308000; x=1691900000;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YABg4OT5HskdCrnMy3fonfRSK+TYxksn1HKEflOmZ9U=;
        b=WENx78rEc3bDvvy3Q7xLZzeyZ9+1VaGrMMaUf4Z5JkDDntyXcvQGiGx7p4NAX+Qadm
         wFEwmONFc++r78K506skeg635Y2Q8StsNiJkNk17JUPN7MrZjmZHUYK9QfZFautuzg23
         El2rdsQPjpE31Bzd4n3lha7rZ/7HkC8VDHYvxGvNdJrhKLbA0fXVeRKnoQ8PKT+7J5S5
         EoyGbc4lfS24SDymyLSMMOMU353FEw+rrEg18mYIAkyNftEOFvuvAg7XqCb4efjFh27P
         81bsgNDZLus5qDzk5nfeqaz5nkllh8uVukbw7Mg3KLQsiyVp8JSXlOAOIr8yG7bib9Ch
         J2Nw==
X-Gm-Message-State: ABy/qLagubeqLpbIn31jVIYRgsTfgmvVE5fErvDjHx61cWC/by47Y1MJ
        pTGfnHXxRu8TEQT/jMBypuNnlw==
X-Google-Smtp-Source: APBJJlHErXViedgAwi0LK++yL/hAfrmgSIvP0b1Uv4Vp3sj3YrfFJ573oWAV2G9T1wg1jFToFKR6Pg==
X-Received: by 2002:a5d:4649:0:b0:30e:590f:78d1 with SMTP id j9-20020a5d4649000000b0030e590f78d1mr3120118wrs.63.1689308000246;
        Thu, 13 Jul 2023 21:13:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id x3-20020a5d60c3000000b0030ae499da59sm9591129wrt.111.2023.07.13.21.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 21:13:19 -0700 (PDT)
Message-ID: <0e6e32db-40e1-aa9f-fc05-20f2c5bf544d@linaro.org>
Date:   Fri, 14 Jul 2023 06:13:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: yosemitev4: add Facebook
 Yosemite V4 BMC
Content-Language: en-US
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230712073752.54624-3-Delphine_CC_Chiu@wiwynn.com>
 <20230714023502.3225096-1-Delphine_CC_Chiu@wiwynn.com>
 <20230714023502.3225096-3-Delphine_CC_Chiu@wiwynn.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230714023502.3225096-3-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 04:35, Delphine CC Chiu wrote:
> Add linux device tree entry related to
> Yosemite V4 specific devices connected to BMC SoC.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../dts/aspeed-bmc-facebook-yosemitev4.dts    | 577 ++++++++++++++++++
>  2 files changed, 578 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 59829fc90315..871e6d271262 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1631,6 +1631,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-facebook-galaxy100.dtb \
>  	aspeed-bmc-facebook-greatlakes.dtb \
>  	aspeed-bmc-facebook-minipack.dtb \
> +	aspeed-bmc-facebook-yosemitev4.dtb \
>  	aspeed-bmc-facebook-tiogapass.dtb \
>  	aspeed-bmc-facebook-wedge40.dtb \
>  	aspeed-bmc-facebook-wedge100.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts
> new file mode 100644
> index 000000000000..cfe4838fae5a
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts
> @@ -0,0 +1,577 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2022 Facebook Inc.
> +
> +/dts-v1/;
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/leds/leds-pca955x.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +/ {
> +	model = "Facebook Yosemite V4 BMC";
> +	compatible = "facebook,yosemitev4-bmc", "aspeed,ast2600";
> +
> +	aliases {
> +		serial4 = &uart5;
> +		serial5 = &uart6;
> +		serial6 = &uart7;
> +		serial7 = &uart8;
> +		serial8 = &uart9;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS4,57600n8";

Nothing improved, so you just ignored entire feedback and resent the same.

Sorry, that's not how responding to feedback works.

NAK

Best regards,
Krzysztof

