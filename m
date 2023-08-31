Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF0F78E636
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 08:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243066AbjHaGVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 02:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241569AbjHaGVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:21:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F5CCD6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 23:20:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52a39a1c4d5so469112a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 23:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693462857; x=1694067657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pG3JY/czPpavqqVu3lLo9xEZ0gRVLmUoMl7zqpjOA3s=;
        b=EdnRbBdvPpZU4vumaNgsB82foaLnlqZkwl5KNQ8OBcQ+t+CD7Y4Evr2H1g6PtUdw4c
         b+AchJRBZ8vd31ltg5kDi8Hu8x/QLPDbB1B3+9WLEqcjQppeooXD5/4DLTEGBm9hJJTQ
         2Xzb+5stxnKjI14dr4R9SevVg252I/M3uD3HVIk1Y1Cibt6//8ZcFoukzR57EwEOO/eF
         YehuRO7+ZZ9dpBfNZ33R40hD7TQKJ40G97DOGnyu1LKYhCetnQpEZjZWH6dWsOGm7OuK
         2jALxPsJAtgSO9sd/uxlE8UStDZW0TzlY3quajQzyMguB2OnAr/j88tZCncB/h7qnVhI
         aG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693462857; x=1694067657;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pG3JY/czPpavqqVu3lLo9xEZ0gRVLmUoMl7zqpjOA3s=;
        b=QxZ3yA5OZrw2Ddu86rzX2cUhWGodYlZNhm9EvfpQ0YUzIlJwedJSgY0nqIAMLt8Atj
         qYakCCfeOSXp8sRejo/fazAuuaE7ctbUQxQHzWvDMsZHcRggCz5YwL32okMt+4PEVLTN
         X+tRb67o7HZHEO8D6nCvTj+ePz4h4WzYPQllMK/WtYizSToBZ6hFrRJSto9CSBiJyNqm
         yQYlD/m87uiEXxmXexYPwyNfJiow0joxPPMpV9JMHaIgS+bMqfchPlO0Hl6lo0N2hZAQ
         GRy1/2vB2cy78vkbm47T1duMZJIcL/tU7beDJjCxglHfUb8lJKbNcVl16jTMrfWgLyfU
         JW3w==
X-Gm-Message-State: AOJu0YwHlSiX1d2PJ1w7NsGXCDtCTI5nXVQjeBtzCSK33yRY5J23rC14
        BHvjLZZ7fMHbHKLMIU6ohT5VJg==
X-Google-Smtp-Source: AGHT+IE5VrHVFgWGXJLbJl+dOweoU18kkN+ftvOBbWJPeXG1U8hZQKsjqxQ+o+0QMmm7ATpbH7hmvA==
X-Received: by 2002:a17:906:8466:b0:9a5:c4ae:9fd4 with SMTP id hx6-20020a170906846600b009a5c4ae9fd4mr3234720ejc.59.1693462857179;
        Wed, 30 Aug 2023 23:20:57 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id h18-20020a1709066d9200b0099b5a71b0bfsm384516ejt.94.2023.08.30.23.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 23:20:56 -0700 (PDT)
Message-ID: <4cbe662d-cd20-ceef-e3e4-6608029f94b7@linaro.org>
Date:   Thu, 31 Aug 2023 08:20:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 1/2] ARM: dts: aspeed: Minerva: Add Facebook Minerva
 (AST2600) BMC
Content-Language: en-US
To:     Peter Yin <peteryin.openbmc@gmail.com>, patrick@stwcx.xyz,
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
References: <20230831055030.3958798-1-peteryin.openbmc@gmail.com>
 <20230831055030.3958798-2-peteryin.openbmc@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230831055030.3958798-2-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2023 07:50, Peter Yin wrote:
> Add linux device tree entry related to
> Minerva specific devices connected to BMC SoC.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/aspeed-bmc-facebook-minerva.dts  | 377 ++++++++++++++++++
>  2 files changed, 378 insertions(+)
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

Third or fourth time: that's not a correct order. This is a nit, but
since you keep ignoring it, I don't believe any other feedback was
applied. Why you did not respond to my comments but just ignored them?


Best regards,
Krzysztof

