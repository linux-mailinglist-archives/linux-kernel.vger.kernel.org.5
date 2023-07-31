Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56363768FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjGaINe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjGaINA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:13:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1172686
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:09:40 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so47580075e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690790979; x=1691395779;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I6Xc3jYrK1x9tkB4f+PVMDQueLv6yWIREl5+s0F3S8Y=;
        b=ZEaDHT1NaOad79uVsOnmQFfAfnNmsaK9J/EpLBHLR5GUvTr40ib9SttdBlNvncy12y
         7lFLTSSpJWmBlvBQxInq8FJjI1H9gMqt7CK9xtUHBYMhX+CXTp4ifilegX1AKCdsk99R
         mbR2GVbGF/vj4zDf6aYVBxN7EZ7sG7oH+pB//lbrQLhuw3/bqENbEQm4tdVz51/zJjVY
         Ibhjc0OvbBaZHQ1F9XWG6h3/CcbJCg2EIzxlt/9LjKRpvZPeTVVxo9XUOQcqviXpGaOn
         KAMD8vOQXY3D2+Mk7ABvnrq909R0Q1pIGf9xx7tFMLrbS1LkATVH75BMMgngxp1ictv5
         euCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690790979; x=1691395779;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6Xc3jYrK1x9tkB4f+PVMDQueLv6yWIREl5+s0F3S8Y=;
        b=aCFYJf1D9o6RU5mqCLDOH19I7LIO1aWbVvs/PifOtTAWuh+Bjw7NZjQ/BFggHyJZnQ
         Zs9hxTun3bq2fDKQd7kUFF8IePEE2/U+RScDJyqWFeQBuNLXMSimD5LyWQDR+ZU2Sn8v
         rrCemuqigAIP3wG+MS/w+Jwb857/CQXIBf4P8QekdkJApgmJq6Q6V/yaUmCK0YsZ6CJv
         yEbeQcQbtoUfdxZzBlORbHWGsezvpiYfxyjTC0Ya4D3iDI5hHW5ygRC47ZUfdv+ME0+x
         03wAUobCEAq43PKqawxtdjNuHOFQa1HEHQLbD6lquwNMmXHUCrqxS9W382ONJSCdmlHQ
         CSaA==
X-Gm-Message-State: ABy/qLYWerguU5Qqi28SMU8e+XEM5E+SqhqT0vq2Nu8keaf1kxFr5ieq
        5bOMeU/57dWe8vjnGzsJvvg7LQ==
X-Google-Smtp-Source: APBJJlHLZ7vCZwY1QPT0rUh5m9UgeHk+Z//Ttk3OtUPPGC+DmPqwHZsKoDBOZMaGkKjN2MWWPoHN6w==
X-Received: by 2002:a1c:6a18:0:b0:3f7:3991:e12e with SMTP id f24-20020a1c6a18000000b003f73991e12emr7342699wmc.1.1690790978724;
        Mon, 31 Jul 2023 01:09:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d? ([2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c234300b003fc16ee2864sm10764258wmq.48.2023.07.31.01.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 01:09:38 -0700 (PDT)
Message-ID: <4ecb44a1-92d7-e669-8fbc-e1e73eb24177@linaro.org>
Date:   Mon, 31 Jul 2023 10:09:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: Add compatible and DT bindings
 for Amlogic C3 Reset Controller
Content-Language: en-US
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        zelong dong <zelong.dong@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, kelvin.zhang@amlogic.com
References: <20230719060954.14864-1-zelong.dong@amlogic.com>
 <20230719060954.14864-2-zelong.dong@amlogic.com>
 <f7b72ee90009f6749700a7bd79a3a63786a82a32.camel@pengutronix.de>
 <68b7d772-8dc4-a781-031b-ea33dae41751@linaro.org>
 <50935d75-bed6-4919-70fc-adcaba6a30a8@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <50935d75-bed6-4919-70fc-adcaba6a30a8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 10:08, Neil Armstrong wrote:
> On 28/07/2023 18:40, Krzysztof Kozlowski wrote:
>> On 28/07/2023 17:49, Philipp Zabel wrote:
>>>>       maxItems: 1
>>>> diff --git a/include/dt-bindings/reset/amlogic,c3-reset.h b/include/dt-bindings/reset/amlogic,c3-reset.h
>>>> new file mode 100644
>>>> index 000000000000..d9127863f603
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/reset/amlogic,c3-reset.h
>>>
>>> Given that this is only included by
>>> arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi, should this header be
>>> moved to arch/arm64/boot/dts/amlogic ?
>>
>> I think there is ongoing work or at least plan to use the IDs also in
>> clock/reset drivers for all Amlogic platforms. Do I recall this correctly?
> 
> Yes the header is used in DT and the driver, so it's in the right place.

Forget my comment, wrong patchset...

Neil

> 
> Neil
> 
>>
>> Best regards,
>> Krzysztof
>>
> 

