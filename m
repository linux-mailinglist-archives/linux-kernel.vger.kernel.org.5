Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CFF75EC77
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjGXHZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjGXHZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:25:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5945180
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:25:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-992f6d7c7fbso712326766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690183549; x=1690788349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W9l6Fr37LZFsRI9a0cNRKO3u2d4EkTsh5kDdAxFsIuI=;
        b=t9vzLQ9R8JYoxSaw9dEkBOCBjCFmpSHYtUzBgPJ3pXOUgFiR4HbwH/weIkqYtWTnB/
         ev8/SA2VV71ZCmED5AALV5FndUCgw1iqyxftbB5HJlQXoL+2WCQZ4ThWLdsCwvQ0fjpS
         FYdxJh1TQPh/EEIz8LfAqJWjubGC0qTYBlzzR2W1t3ZbAZaQ/2ME2JZmA9P8+4PxbrX3
         gINhauBulbi5+Tbf0M4T/8zSDM5G1J3donIDnbDT7rZEhx1c66nuTYwv2EDSBhaP+an4
         My4BhRVpyZCbAD9l9iyDn9QvDx1mXt6xTENO7/T+5qhQGJHEenCO4NoIRR/UQJhjwrU2
         m9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690183549; x=1690788349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W9l6Fr37LZFsRI9a0cNRKO3u2d4EkTsh5kDdAxFsIuI=;
        b=CRIqM+x2oaDtyLTN5w/b4hSaDohRAmt5qB00PHRlLjSxEYXmX7uiaZpeVQe0QNfWZl
         nQSbuQN9hJ2OjXPqcX+TaVsM/60b/V44AkEJWy2sqUP2Z8aqeTpuCZshPKh29+v/d8Wd
         UEB4Hv6F9xUDLWQpfmjpSPU6FP4EAVh/iEL7lx7Q5eRwcuBbGCF9hOS1O09r+JVS9+86
         AGlr/5jqsjLpggiWNKEv3xl0nFpYIGYh6k8ukXHg5zhuSfawIwWaQEUvtEYIJgGPMoQL
         oJNnQ9m/nUgGjtU0pEE42F3eUZ/4IMcplpZVXw5OP3BEXVusouXKqrLCM9FePxpl6+lg
         EQjA==
X-Gm-Message-State: ABy/qLai/Xp564QxQ2DYWkJ39PBgc6OkCNbNLnUzUzcWRLapSFwxHRC6
        mZIXDrJEP0KRuYPZKh+f5E2ANw==
X-Google-Smtp-Source: APBJJlF9IAG1RI4StyH32kjNgDCa1flUBleL5s+aVpEXrbFOAOpWmrTFckd4EbsDhL8JWoJKxTxFfg==
X-Received: by 2002:a17:906:3185:b0:965:fb87:4215 with SMTP id 5-20020a170906318500b00965fb874215mr8662868ejy.15.1690183549124;
        Mon, 24 Jul 2023 00:25:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id bt16-20020a170906b15000b00993159ce075sm6235250ejb.210.2023.07.24.00.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 00:25:48 -0700 (PDT)
Message-ID: <61409dfe-60b5-e124-a6ef-5437752f4d2e@linaro.org>
Date:   Mon, 24 Jul 2023 09:25:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 1/3] dt-bindings: interrupt-controller: Add header file
 for Amlogic Meson-G12A SoCs
Content-Language: en-US
To:     Huqiang Qin <huqiang.qin@amlogic.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20230724060108.1403662-1-huqiang.qin@amlogic.com>
 <20230724060108.1403662-2-huqiang.qin@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230724060108.1403662-2-huqiang.qin@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 08:01, Huqiang Qin wrote:
> Add a new dt-binding header that details the interrupt number of the GPIO.
> 
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
> ---
> 
> V1 -> V2: Rename irq-meson-g12a-gpio.h to amlogic,meson-g12a-gpio-intc.h


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

