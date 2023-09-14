Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE5979FBBF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjINGRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjINGRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:17:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63086FA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:17:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bcf2de59cso79478866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694672223; x=1695277023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UK0O4WJKJlOZsHN2AORyIn3x8ciKDTzhX6N4dTgrbtM=;
        b=oxpc56GmwVM8T7ITmCtul2+h1l1OM4rnDWfEd6u7N7jZXtABZVKnif8VSsvXly5o8W
         ZppQCIDTxiPPFHMG/O0S7ONp+bztV1vXr0BvZGHKe0U116CKFXCqdprhfxipXkwr/Y+Y
         uoVoTKjlZaqXw44jwEzhOQfF/Si9p9d5W3Im5pIQlcAwkU80k+eV3clTQhY9iYOOh+41
         ebpoN67B8YLhHTGF/LJ/y+H0JBllnPU7mH5bWDj5TsdFahV4i6LQ24sswrkg2BNG6J2P
         FQyxgxjnBKCjQJc7n+36/bKFjL8lxrSRufPcnFUN6RSO7OTY7zT7x+jTwNx9dqUdWzDC
         a+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694672223; x=1695277023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UK0O4WJKJlOZsHN2AORyIn3x8ciKDTzhX6N4dTgrbtM=;
        b=u1bppSTntgwT8VNl3k0ogTwBWpTHJFtNu0HpHD4//ypO60EZ8uXt9Ie3bleBXCsIyh
         zHjEbeSjOa95YkZQ3q/LOVs5Hkc83PfTThWLp5IduCZgdoUlJDnP2FAW8ehR+Qh1+vZu
         OdBFaOR2wGq25CcKTf96rLB8G7n2WTpiuy1Q/6eFjRVPuf7GHXVcQOCctPT3s2NbJDdW
         wjJYhAukk61VgGf3r6g4BuGak6qK139GO/Pno5EKHaCJuGYolwY7gdOKT+Aej0JfhaEZ
         K/912D2KvXG8ntEmrkYBwkzF6tYuFtCgRkvwYRe7oahT+ZouVk+q262p4K5UQUJu+9ik
         0NQA==
X-Gm-Message-State: AOJu0YylHppOMca3HgYezrvsazyPRfjOBy306K4WZDbsCZBPH+EQeYFL
        /tuQvB94whgoxi8bHlYbYtLV7Q==
X-Google-Smtp-Source: AGHT+IFoQUQl22lWSHFNhUxXzHXGNgTqAInQGx0SzU77yOY3Lg/+ylETFd0JjlYLR9E9wxvPxBnT4A==
X-Received: by 2002:a17:907:62a6:b0:99d:e8da:c20b with SMTP id nd38-20020a17090762a600b0099de8dac20bmr4172306ejc.24.1694672221956;
        Wed, 13 Sep 2023 23:17:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id q13-20020a170906770d00b0097073f1ed84sm514322ejm.4.2023.09.13.23.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 23:17:01 -0700 (PDT)
Message-ID: <45637012-0972-fc7b-1276-163da363b962@linaro.org>
Date:   Thu, 14 Sep 2023 08:16:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: Add compatibles for Amlogic T7
 SoCs
Content-Language: en-US
To:     Huqiang Qin <huqiang.qin@amlogic.com>, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, brgl@bgdev.pl, andy@kernel.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230914054525.1180595-1-huqiang.qin@amlogic.com>
 <20230914054525.1180595-2-huqiang.qin@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230914054525.1180595-2-huqiang.qin@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 07:45, Huqiang Qin wrote:
> Add a new compatible name for Amlogic T7 pin controller, and add
> a new dt-binding header file which document the detail pin names.
> 
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
> ---
>  .../pinctrl/amlogic,meson-pinctrl-a1.yaml     |   1 +
>  include/dt-bindings/gpio/amlogic-t7-gpio.h    | 179 ++++++++++++++++++
>  2 files changed, 180 insertions(+)
>  create mode 100644 include/dt-bindings/gpio/amlogic-t7-gpio.h
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml
> index 4e7a456ea4cc..c7df4cd34197 100644
> --- a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml
> @@ -16,6 +16,7 @@ properties:
>    compatible:
>      enum:
>        - amlogic,c3-periphs-pinctrl
> +      - amlogic,t7-periphs-pinctrl
>        - amlogic,meson-a1-periphs-pinctrl
>        - amlogic,meson-s4-periphs-pinctrl
>  
> diff --git a/include/dt-bindings/gpio/amlogic-t7-gpio.h b/include/dt-bindings/gpio/amlogic-t7-gpio.h
> new file mode 100644
> index 000000000000..2bab9a99501a
> --- /dev/null
> +++ b/include/dt-bindings/gpio/amlogic-t7-gpio.h

Use compatible syntax.

> @@ -0,0 +1,179 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> +/*
> + * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
> + * Author: Huqiang Qin <huqiang.qin@amlogic.com>
> + */
> +
> +#ifndef _DT_BINDINGS_AMLOGIC_T7_GPIO_H
> +#define _DT_BINDINGS_AMLOGIC_T7_GPIO_H
> +
> +#define	GPIOB_0		0

Why weird indentation?



Best regards,
Krzysztof

