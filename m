Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3A1789504
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 11:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjHZJIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 05:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjHZJIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 05:08:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08C71BD2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 02:08:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so208444366b.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 02:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693040899; x=1693645699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tHBPO1finZtCSzkNzREsRM57eDDW8dRuPlHc7KXEI7E=;
        b=ebBYVLUEJRCHTJFhPgKmAvvApP456FETyMfE/EEGbTnL7tBGP9RT+lZ0YIKWvRtbkl
         im+YylWMPxqz+/f5RTrBb23Q4vm7To4yJ2MegCZvgRMozl3cZdf7UTjLyJ4JhKrl44Q7
         OkVXAPpMS5IAOAhy4R8rLz4cHfCG0wNlU+xghTM7kBV4LKb0ER8b5pwG7d6ivTmkAIGL
         4RZn1BIUfZpAvMPBrSBDcdg0sSoPIftx6hPOStzwucNWHB4Y7TBrflj76FyXa/Xy5K3g
         WEotVSLv+nQkz4Cr25UDTsy5DC3beU2igsJibK/+J8JsxfUbE3sL4GhKPiIzQhcESIHq
         aJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693040899; x=1693645699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHBPO1finZtCSzkNzREsRM57eDDW8dRuPlHc7KXEI7E=;
        b=IMa+SlAetZO99kgZt5MjiWodloGULexnDe/NHHS524dZt8rSjLBHVwH0+UtpU99J87
         9OlKuixqc9cAHlSsuraz4vEYp+dmyI/gBHCxY4Pq4a8kGZJx8GDNhChCWoRRa9GqwVRe
         xt+xQonYA48eGHy8Af7Gqq+wisyMOND/lcRRM6R86nbFWqSq8U8eqQ2VVBhbL1oLaE3l
         oVTl2habZJ2AMKT9yZaooNd7btMrx4sLpkB4QSEalwE6P3Fk7leZyqwus3Yo6WWo4oNp
         y9k+46G8ZEkrcokRamSpBQtzWvZl/9XISb0vvypIEs2kpYNE05lwBnCUtOq5PDJA+hAl
         A6/w==
X-Gm-Message-State: AOJu0Yyq/3rqX/esYxf5eR1m8ivEh3lPPPXOltFGW6VLyimHV3/gwInl
        lypF9UnqbY+uZlPSvMdODMacK4YcuBHFKFlpzz0=
X-Google-Smtp-Source: AGHT+IFBsq8qdlmmG8uKd+cBMJkWrAnVKUoEBdT+75a6YZ8BdQ8w/8jwBArKR0mhr6742YPO2IV9Aw==
X-Received: by 2002:a17:907:2bf7:b0:9a1:ad87:1354 with SMTP id gv55-20020a1709072bf700b009a1ad871354mr11981804ejc.34.1693040899316;
        Sat, 26 Aug 2023 02:08:19 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id gy25-20020a170906f25900b00985ed2f1584sm1914630ejb.187.2023.08.26.02.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 02:08:18 -0700 (PDT)
Message-ID: <9d44d4a7-bb53-1240-8b4b-2ebcf3f766ec@linaro.org>
Date:   Sat, 26 Aug 2023 11:08:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add lltc,ltc2309 bindings
Content-Language: en-US
To:     Liam Beguin <liambeguin@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230825-ltc2309-v2-0-6d75f2b3fb50@gmail.com>
 <20230825-ltc2309-v2-1-6d75f2b3fb50@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230825-ltc2309-v2-1-6d75f2b3fb50@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2023 20:20, Liam Beguin wrote:
> Add devicetree bindings for the Linear Technology LTC2309 ADC driver.
> 
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

