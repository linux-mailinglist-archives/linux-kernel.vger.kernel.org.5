Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1232787FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241144AbjHYGWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjHYGV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:21:28 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B691FF0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:21:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c1f6f3884so65514866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692944478; x=1693549278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CBxnZfv7/cH1hRB0BhsWxJRlKySChDxPip0EzQICdP8=;
        b=v8kdgE5e4XH4nsipzfMsATjh5Oy01RtVCq5xvJd2GoQII71ClGbkLd02yu5J94HcPy
         rnw71C8Itn6w/02FswZ2Ivsa0N3dQ9Ofwtx//vFtHG6ULEv2luOQvVwrGMcOBQdDsSzw
         qvSoC1uwYBfgyLfdAWwhkqf3eMe6SR6jZp874Bq6AXit3XFsYpbmEBrfiZrR3yDKQ9Hp
         vt91MnKjP/yw81XJq5rYLvySUtmQNeoTrltEr1zba0DpqGiC67BI7Ru5OmYh2NdRNPkX
         ZLy/vybV98yylUYcKNJH97/3qKdICWKeqm5MWMvAd5fGIuwY2BrecWUErSUQF9TOUTim
         47VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692944478; x=1693549278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBxnZfv7/cH1hRB0BhsWxJRlKySChDxPip0EzQICdP8=;
        b=joPiEScwl3kn46KGVvhn04eTqn3+UOCgvKwCvO6pzxDqcXys7vp5qcymnpSORJY26d
         HCYK3ZuOVtEtcijcn8p/xfgbBJFDfpc79muS1mjbm2g96E+4VTTwcNhxlgI0epfAWuCD
         3jnMLsUGjL0q78gp1y8gR6SzigZvbxgzsyVxHcYN8MgFawYHYcMdFuHAMUJ0NcGkafxe
         zgfYU03NJoeMxnM8uG9ekpdOB6aZW9mG9eOc5l6sSWRp7akavUcsQi6GHVhNsJ0VO6Tx
         gZG+woOyQJsv0ul6YmZn4DWocMge05fh8oc2jDRrxbiF7S3GuXiAMAd2Mqbvymhtkjn8
         HtAA==
X-Gm-Message-State: AOJu0Yxb+e7ECO9rJA2bdkHRTUIuSDlBG32ENGfTfawSn+NfXrLQg+VZ
        imCUdYd3szkz9P6NMusd9D+vL+DLXgdSZeMkdOA=
X-Google-Smtp-Source: AGHT+IFljUSTpwe44zryqFCU44Zs/vd81YaW0Y2DPrJTJb8DDeiQwlMm6Xs2N4hra1eh0QlpLazdiA==
X-Received: by 2002:a17:906:3ca1:b0:9a1:891b:6eed with SMTP id b1-20020a1709063ca100b009a1891b6eedmr10694918ejh.76.1692944478566;
        Thu, 24 Aug 2023 23:21:18 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id re4-20020a170906d8c400b009930042510csm570386ejb.222.2023.08.24.23.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 23:21:18 -0700 (PDT)
Message-ID: <eb951323-d896-5ab9-e477-7dd412af58e5@linaro.org>
Date:   Fri, 25 Aug 2023 08:21:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] dt-bindings: gpio: pca95xx: document new tca9538 chip
Content-Language: en-US
To:     Liam Beguin <liambeguin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
References: <20230824-tca9538-v1-0-ee3bf2065065@gmail.com>
 <20230824-tca9538-v1-2-ee3bf2065065@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230824-tca9538-v1-2-ee3bf2065065@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2023 01:16, Liam Beguin wrote:
> The previous patch added support for this chip. 

This is not needed. If by any chance this would go via different trees,
it would stop to make any sense.

Also, is wrong. Bindings come *always* before the users.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

