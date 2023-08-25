Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A37787FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbjHYGT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjHYGTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:19:35 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47461BF1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:19:32 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so7746501fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692944371; x=1693549171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3OvkT3Z0KfNNmbGikZj97H1hwqaycrzDTaDpACXf6YA=;
        b=bvI/h3oYjARxBhcx2gAUnY0OmpxRjHCDnFhJj3iBaT4ivDc062at/yKszxwLodPg/P
         z6FOSUUuBAMvfcjvWdeuYR7DfYKUdmx+QUJdohTSefZzAaOJyKs0hq8+WTrcsh7EcUXR
         zS/mfG1wwwPyiVrnR5N/vy2IIyqnxSlfb7w+kZyM/C3/oPk5+/Vx+2LB0XOyihfOMBhK
         +OoZeu6xl0MW4rKjSLVyIZn8R+t/8MY4kzZfuWkjpHjl7yuFJsUYjL2rImt0gtXLMqdH
         0uQqEnDU2MCEVlhErtDYJ63qu6R7mf4ALoA7Hn6R+YDFcp7yQKJr/J1J1JVcIsvEzGZC
         hYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692944371; x=1693549171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OvkT3Z0KfNNmbGikZj97H1hwqaycrzDTaDpACXf6YA=;
        b=dFb5QrtzJpdECOt5wrS2FGzNaGa13MxCPWqEu98ro88MfUu4WnZCg2K1Ij17uoKpSh
         uY5OYydm6whKz6RqiUVEXWZ4TB0YUdEpro+3NG68Cgva97b5tShT3bR39tu+hnur9S7M
         CibRFN38vMcfpLUquK0PoAN2D6+WVr3Qau1g6T8ZQgRphMzcqdggIdxJVdjnxywJwNpU
         BNIOoS+CZ67iTN5yuNKPNUhwAU4BkBrmClunGls++9M8Lw0mzfXhS8Wpy176A964vF2X
         3dRKl0cWIz3QXCVr0KhEpdsVL+PuHjy7zSUc5atPMXJ8TmWvwJoWcZYOGj9KiUJTT6EP
         Wv7g==
X-Gm-Message-State: AOJu0YxFxWa6V/Vyj/rIm8ox10pHh9irzEWFemo6TA4bue91DXsyq0ko
        TQI1pzmsZKuCCzh5SR4Bpqud9w==
X-Google-Smtp-Source: AGHT+IHJo9ECuER4vgAUWKW7gADLJpu+CPX5GLOGcHcEocLE44CuYzpz5xqqIZMthKOJ1+i6AoTUYw==
X-Received: by 2002:a05:6512:3406:b0:4f8:7781:9870 with SMTP id i6-20020a056512340600b004f877819870mr14983315lfr.60.1692944370837;
        Thu, 24 Aug 2023 23:19:30 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id e10-20020aa7d7ca000000b005256994e335sm629033eds.92.2023.08.24.23.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 23:19:30 -0700 (PDT)
Message-ID: <fb09f5e6-8381-312f-2f1e-f2b471cec68a@linaro.org>
Date:   Fri, 25 Aug 2023 08:19:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] Add Meta openBMC Minerva dts file.
Content-Language: en-US
To:     peteryin <peteryin.openbmc@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     cosmo.chou@quantatw.com, potin.lai@quantatw.com,
        daniel-hsu@quantatw.com
References: <20230825032945.1649050-1-peteryin.openbmc@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230825032945.1649050-1-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2023 05:29, peteryin wrote:
> This is for Meta openBMC Minerva dts.
> 
> Signed-off-by: peteryin <peteryin.openbmc@gmail.com>
> ---
>  .../boot/dts/aspeed-bmc-facebook-minerva.dts  | 330 ++++++++++++++++++>  1 file changed, 330 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-minerva.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-minerva.dts
> new file mode 100644
> index 000000000000..4fb9b5f72942
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-minerva.dts
> @@ -0,0 +1,330 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright (c) 2023 Facebook Inc.
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model = "Facebook Minerva";
> +	compatible = "facebook, minerva-bmc", "aspeed,ast2600";

Missing bindings and that's not correct compatible.

> +
> +	aliases {
> +		serial0 = &uart1;
> +		serial4 = &uart5;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS4,57600n8";

Drop, use stdout path instead.

> +	};
> +

...

> +&gpio0 {
> +	pinctrl-names = "default";
> +	gpio-line-names =
> +	/*A0-A7*/	"","","","","","","","",
> +	/*B0-B7*/	"","","","","","","","",
> +	/*C0-C7*/	"","","","","","","","",
> +	/*D0-D7*/	"","","SOL_UART_SET","","","","","",
> +	/*E0-E7*/	"","","","","","","","",
> +	/*F0-F7*/	"","","","","","","","",
> +	/*G0-G7*/	"","","","","","","","",
> +	/*H0-H7*/	"","","","","","","","",
> +	/*I0-I7*/	"","","","","","","","",
> +	/*J0-J7*/	"","","","","","","","",
> +	/*K0-K7*/	"","","","","","","","",
> +	/*L0-L7*/	"","","","","","","","",
> +	/*M0-M7*/	"","","","","","","","",
> +	/*N0-N7*/	"LED_POSTCODE_0","LED_POSTCODE_1",
> +			"LED_POSTCODE_2","LED_POSTCODE_3",
> +			"LED_POSTCODE_4","LED_POSTCODE_5",
> +			"LED_POSTCODE_6","LED_POSTCODE_7",
> +	/*O0-O7*/	"","","","","","","","",
> +	/*P0-P7*/	"","","","","","","","",
> +	/*Q0-Q7*/	"","","","","","","","",
> +	/*R0-R7*/	"","","","","","","","",
> +	/*S0-S7*/	"","","","","","","","",
> +	/*T0-T7*/	"","","","","","","","",
> +	/*U0-U7*/	"","","","","","","","",
> +	/*V0-V7*/	"","","","","","","","",
> +	/*W0-W7*/	"","","","","","","","",
> +	/*X0-X7*/	"","","","","","","","",
> +	/*Y0-Y7*/	"","","","","","","","",
> +	/*Z0-Z7*/	"","","","","","","","";
> +};
> +

Stray blank line.

Best regards,
Krzysztof

