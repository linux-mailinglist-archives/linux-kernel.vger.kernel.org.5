Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD7776919D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjGaJYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjGaJXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:23:47 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201C61998
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:21:21 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so4510852f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690795279; x=1691400079;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xDLdel2Rhe994E8t59q5EvpZyXbsA6v8U1EBH//Jf5c=;
        b=pbT4tIkmhIxq47nniPh5aZTwDD69epwzhf1XUckiDQowVbTuSfSbBvW3qLnjjy1ROK
         gvsZCwxfXdvZ3jxZHoDJLPsDFvwG3jQ1DURoM7dKwASIrHQHoFCV4SjMwON7qL55B8U5
         xfAivgd0q/LxIhbZCycHq2xJvA14z3QOSdNeupHn0zfD+ch1ECbfKIwdHa9bBSuXJ1ba
         tt4sIpusTR4wk6dq84Awp+x/wIzKIScO+fDEBi7YMXHDFgQKlHBXGVYBYqIQKtL7t5ij
         jxFBpYd8UZAhtAGDtsxfbBGIXSeomf0UzY+zWDckX+kkE3jtjW2k6j0URGTu0BGu1REX
         Byvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690795279; x=1691400079;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xDLdel2Rhe994E8t59q5EvpZyXbsA6v8U1EBH//Jf5c=;
        b=BZR8ut9O8tyUflPsc5lZ+Bm23XEfRbfqbh2GRZKVbT78g23mcaWAQLg/kbonXF7fW1
         TQ9+iwrI420pMUxRu6+sCDeJcMA/+VFn48deCGuCqgWOfGlUNvZc/Hg2SxU0Rudn0kTL
         BCXfPCvTcYh0CMjJ1bs9uFpQUqBCsP2DwIk0JvgmOLs9H81OZKnYoXRRqvUWZqjVlAb/
         Qi8lLEYpa2OEnS++71CK2eI2FFZRFFc9+yB2nyPg1RSH+UjyGsdqd52iV3hqaLViE3Sn
         pJwC6mxii7EuuIjFdQb/SFzsM8rmkmInNIzDZUBTLOwm09ujoUB4dL8R+jHSAJBAoSSM
         pdnw==
X-Gm-Message-State: ABy/qLaAicRmZCg6PuAy1GCdVihYITivKGJkNmK3g4G306FYdBI0tgFG
        G8Ud2yTyKH+qcwsp8KVkgEuNJw==
X-Google-Smtp-Source: APBJJlHsHDdvsIJ2bUTb4wdaCXnh4rHnl50RqfKbzz7Urb20yM0+LICum4NymicbKaVsEd8soQLuyQ==
X-Received: by 2002:adf:dcc8:0:b0:30e:3caa:971b with SMTP id x8-20020adfdcc8000000b0030e3caa971bmr7529797wrm.51.1690795279502;
        Mon, 31 Jul 2023 02:21:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d? ([2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d6992000000b0031134bcdacdsm12437930wru.42.2023.07.31.02.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 02:21:19 -0700 (PDT)
Message-ID: <a867c31c-df94-5c6c-211c-e35138333922@linaro.org>
Date:   Mon, 31 Jul 2023 11:21:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: amlogic: meson-sm1-odroid: drop redundant
 status=okay
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230731090442.100856-1-krzysztof.kozlowski@linaro.org>
 <273bd185-4aa5-510f-0f1d-1a4cab2d4a2d@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <273bd185-4aa5-510f-0f1d-1a4cab2d4a2d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 31/07/2023 11:19, Krzysztof Kozlowski wrote:
> On 31/07/2023 11:04, Krzysztof Kozlowski wrote:
>> status=okay is by default.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi | 1 -
>>   1 file changed, 1 deletion(-)
> 
> I found few more...

You're faster than me, I planned to get rid of them this week!

Neil

> 
> Best regards,
> Krzysztof
> 

