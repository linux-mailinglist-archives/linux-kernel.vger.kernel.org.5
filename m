Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC10A78DF91
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344326AbjH3T1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242803AbjH3JpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:45:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3017E1A1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:45:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a5e1812378so58214966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693388700; x=1693993500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GinLhIkYK1eux6i+cjheW/SanM1hfGzP7zFFV4Pq7CI=;
        b=FJgx5T2mvEQ9S2G1/fVHLtuSDiGBknSUWu2FGlEV2agXp5QBa6/cjbYmUbPK0OoIa4
         jcVlz1KjeX5KKTrGtj4LT5V/tRzSEWCnGrjHuV/A7f/zqkyB1zA3EYEb8pJdB4cIIPcJ
         QmoZQ06e5h15/m0El6jA3h+WRcxKiRsjSpImJh7no3ZmBDDU/uxfVpFax7sa03I2w62J
         6fn4SBmhjGdkKJONvul6Ylc2FCawehGoDtWDbRgtxrPggl5tiWgkO6cYTqT8qhWc63mF
         AdCUYL2Gu0vF+eebe/3SPXq+fuRGIaUJepR9KDlwgRcfJFHj/fhMgKM+9xgEsj1lfSRi
         FADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693388700; x=1693993500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GinLhIkYK1eux6i+cjheW/SanM1hfGzP7zFFV4Pq7CI=;
        b=BpJuSoYNx25rxTdsoKXgvhNSYH8U4fi71i1gFZnZ3hEJcMIdWMDpxLALe7PdxxZkkZ
         19nTilK21yLSatY56MQIAhldJsCnlP068mMrYvF3rK36bKs8M/XCaJHbHejHrU6eFK7u
         0icEHMV5AQabzYCbP4D8UJWt4Isk55tCW/VG8elJ+QKRH1J6BH2k/bXVd1DZR41T933O
         ncNa1/RoA8WWNv4m2xwiox9GTamUgglPI8rpoNB3cq8JqRIZnN1R5XpUNYGhqgiFC1j2
         gWKg4aVgvOMMELCQtZriyYnslmoq+A5Mz3jDTg8LqJf7XHQoaHexc2NWQjGbvV9GyIsw
         8oRw==
X-Gm-Message-State: AOJu0Yw6JnOMRPK7PSE+bjfC2VIlQFqkMHXK1bhb5J8IWG6Zsiyfy6nB
        yn+gWw10IwOiX7LhbvmN3hnMjg==
X-Google-Smtp-Source: AGHT+IErP0xuXzSAW/p+xjsBaBQUM/72RL+nvycu+pslby5SCw0FQTJk9JH2ZdMQgx3+rxaEkK5Myw==
X-Received: by 2002:a17:906:3152:b0:9a5:874a:9745 with SMTP id e18-20020a170906315200b009a5874a9745mr1129087eje.26.1693388700643;
        Wed, 30 Aug 2023 02:45:00 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id a8-20020a1709066d4800b0098e422d6758sm6930455ejt.219.2023.08.30.02.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 02:44:59 -0700 (PDT)
Message-ID: <b9cbe9be-b03e-6c7a-d06c-b75b012b5b25@linaro.org>
Date:   Wed, 30 Aug 2023 11:44:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 1/2] ARM: dts: aspeed: Minerva: Add Facebook Minerva
 (AST2600) BMC
Content-Language: en-US
To:     peteryin <peteryin.openbmc@gmail.com>, patrick@stwcx.xyz,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     cosmo.chou@quantatw.com, potin.lai@quantatw.com,
        daniel-hsu@quantatw.com
References: <20230830090212.3880559-1-peteryin.openbmc@gmail.com>
 <20230830090212.3880559-2-peteryin.openbmc@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230830090212.3880559-2-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2023 11:02, peteryin wrote:
> Add linux device tree entry related to
> Minerva specific devices connected to BMC SoC.
> 
> Signed-off-by: peteryin <peteryin.openbmc@gmail.com>

To clarify: your full name or known identity is "peteryin"?

> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/aspeed-bmc-facebook-minerva.dts  | 385 ++++++++++++++++++
>  2 files changed, 386 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-minerva.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 9e1d7bf3cff6..edb0b2105333 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1604,6 +1604,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-facebook-wedge400.dtb \
>  	aspeed-bmc-facebook-yamp.dtb \
>  	aspeed-bmc-facebook-yosemitev2.dtb \
> +	aspeed-bmc-facebook-minerva.dtb \

Nothing improved here.

>  	aspeed-bmc-ibm-bonnell.dtb \
>  	aspeed-bmc-ibm-everest.dtb \
>  	aspeed-bmc-ibm-rainier.dtb \


> +	"","","","","","","","",
> +	/*O0-O3 line 224-231*/
> +	"","","","","","","","",
> +	/*O4-O7 line 232-239*/
> +	"","","","","","","","",
> +	/*P0-P3 line 240-247*/
> +	"","","","","","","","",
> +	/*P4-P7 line 248-255*/
> +	"","","","","","","","";
> +};
> +

Nor here.

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

Best regards,
Krzysztof

