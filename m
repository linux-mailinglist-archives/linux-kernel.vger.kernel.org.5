Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9E87F262E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjKUHOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKUHOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:14:17 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259DCED
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:14:13 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5488bf9e193so3369892a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700550851; x=1701155651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0qazkUkCGgv5sfVY1VHiC2TdShNHpB3pRIRbc6XsuWk=;
        b=Q1MjXk70i/DV+Qj3rKMl1DR92XsGo/IWwaGHpghvoln3Xu3kvd3IN4Dq+DTVaBRzuN
         okw0PrGlZF6Lz9W0IgHPBEMX49l6ehmKCXQcbkPYSp/p/kNVqwWJ0sVfttXomwGGGEA5
         WhxhRB0NJ7zoZfEPqxZd2GjdpXGQCLt2TdCjrwdhDU1WQ0LXKOYi54+9UzefRS4MaElv
         nfdpm0kb//4JkN6Kw+Y5Ts26+CH//aveG6SfV0mFc32YstQ1FAcowJvBsrUiDMXUqHZY
         XjQWqsreZPmnT2i3+6CCpn0ZdXXHGTC9fbBVMr41ctrkCl8H9Huvm8nNhdGLKibE22uW
         EV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700550851; x=1701155651;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qazkUkCGgv5sfVY1VHiC2TdShNHpB3pRIRbc6XsuWk=;
        b=hdANSXbp5v27oJ/VNtgwISFXCzPlSG68uxc4GkW+2X+s93IwXTnef0/U1ViEmhFOtB
         3k6OYYg0X2CrFTGpmx9sUakF757asL0Gmi/KpRX+WEK1YKdoPT52dEd5YWw9xw1SFZH7
         NyB6uguO02jPLLfvSxV2C1bF9KIhbBtlyfEqITdig8b8QS5RSgPt6/xHcOKW4mwy7EHS
         ZqJZpx2J9Pyww6p0Vd4CcX+7//VT10zeUHN4bVaPgglLSZVJZM7kah95HyftAaRHWr0C
         FKV+UwbJCngZpOar5pvSbzsj+KRBUW2rZOzOZ8VcvNPTOiVzO9gle10u73F0KytkpocA
         PxBg==
X-Gm-Message-State: AOJu0Yw0JZSnMyuvZukuIHASZYLM97s7VoncbQ+5MMiE2MhMHKNEHM22
        YeFlT+sysCGkytV+2vxWJS+nOw==
X-Google-Smtp-Source: AGHT+IHuS+qXtmjZh5mZ4sU/5nD1p0e12yGf9KNTJtYYjKAIBNUiyns7xdbXtfYT+i4gapbvq2vjgQ==
X-Received: by 2002:a17:906:90b:b0:9bd:b8d0:c096 with SMTP id i11-20020a170906090b00b009bdb8d0c096mr6920259ejd.21.1700550851491;
        Mon, 20 Nov 2023 23:14:11 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id g1-20020a170906538100b009fef7d22c98sm1814674ejo.35.2023.11.20.23.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 23:14:11 -0800 (PST)
Message-ID: <c622c2a5-665f-4ee3-b3dd-fafb3adf6191@linaro.org>
Date:   Tue, 21 Nov 2023 08:14:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [rft, PATCH v1 1/1] pinctrl: qcom: lpass-lpi: Remove unused
 member in struct lpi_pingroup
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20231120193353.1670732-1-andriy.shevchenko@linux.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231120193353.1670732-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2023 20:26, Andy Shevchenko wrote:
> The group is not used anywhere, remove it. And if needed, it should be
> struct pingroup anyway.
> 
> While at it, replace kernel.h with what exactly being used.

Missing Reported-by and Closes by for LKP... Unless you discovered it
without its report?

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> _Seems_ like this (I only read the code), hence rft.
> 
>  drivers/pinctrl/qcom/pinctrl-lpass-lpi.h      |  6 +----
>  .../pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c   | 16 -------------
>  .../pinctrl/qcom/pinctrl-sc8280xp-lpass-lpi.c | 20 ----------------
>  .../pinctrl/qcom/pinctrl-sm6115-lpass-lpi.c   | 20 ----------------
>  .../pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c   | 15 ------------
>  .../pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c   | 16 -------------
>  .../pinctrl/qcom/pinctrl-sm8450-lpass-lpi.c   | 24 -------------------

Missing sm8550.

>  7 files changed, 1 insertion(+), 116 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
> index 206b2c0ca828..a9b2f65c1ebe 100644
> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
> @@ -6,8 +6,8 @@
>  #ifndef __PINCTRL_LPASS_LPI_H__
>  #define __PINCTRL_LPASS_LPI_H__
>  
> +#include <linux/array_size.h>
>  #include <linux/bits.h>
> -#include <linux/kernel.h>
>  
>  #include "../core.h"
>  
> @@ -45,11 +45,8 @@ struct pinctrl_pin_desc;
>  
>  #define LPI_PINGROUP(id, soff, f1, f2, f3, f4)		\
>  	{						\
> -		.group.name = "gpio" #id,			\
> -		.group.pins = gpio##id##_pins,		\

Aren't these used by core pinctrl code?

Best regards,
Krzysztof

