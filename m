Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB15D763F35
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjGZTFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjGZTFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:05:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AC6212D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 12:05:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so18336766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690398341; x=1691003141;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vc+YnquiSNW9jSHsyvSHU5isKp05LSU7F1ENa1rUcbM=;
        b=bhuVAMVfTt75c+eYp8niKiPd4/9xUfzc2utbmJ/BzL1C57dlAr/yriusVbbhwXfP4V
         ZPIEnsterWWdt8Rn4EFJXUYVri6EDFCwYuTIS1jDY9ZOkQYdiGxGnoYGGdc5dVcspGY0
         ykDAgw6GYd/ibHTacjHZjt2hh2FBmDH9lyHysar7IJIxbXD/yvwqiihGaAED5CRKN4Uh
         E7GMTE5Wm5ISPH9gUPWZHOyI/Gj+C6abY6ofI+rzSr/j6qY4D6HiJ1CTlUjOymDBD7dh
         gvAKJjE3RrtWvExKe8+YI3EdawftzFIRPFcrxEL7s8jWBoIrD5ddpPS0NQU7KwLmWlJH
         5CGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690398341; x=1691003141;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vc+YnquiSNW9jSHsyvSHU5isKp05LSU7F1ENa1rUcbM=;
        b=cDTD2GxVt2ltATuJYrBbKSBLhfyNHQWxu8EmH2sQzxRZ50/tUzCElBW2TtS46zZnXp
         62z1cjzT6cqBHNaRCUqPTQbRN3UOgbAoIApUBu2lI88uiIRMIpziXLG4R8gJG/oYU0/L
         Aa3NSpDqTbY199DkjbJn/5GJ0ZWYLGCRNu+3ZfClzkmwcPczE052rvcbBJ3oym5AOE6a
         nxBsDWNN/6CTRP1ZcnH/tDLWvg07OJB+PlhE5dIRrqn/aoD7sLx2Xwdnq4+kRIaF290o
         vLYQXN4QY3eqTPc+02M2McB4Q7kJdt9WbvIfU/GSDDZz0fxT9NouDFbGOfIVnBLew2//
         1KTA==
X-Gm-Message-State: ABy/qLaCJ4LiJZSEOdDssefq4fSnWb8pl0cfCpmi4ZAgQRlAES5uT980
        d//1l/8i7h5FCoAUmkyQNQEgVA==
X-Google-Smtp-Source: APBJJlE6nZ0OxvOKRGUPIo74Ten0G5lDzCYi3OwLwybTm0cYwZKbYlDBbWbBJKRMB71Ro1jc4qHrKw==
X-Received: by 2002:a17:907:a076:b0:99b:cdfd:fb44 with SMTP id ia22-20020a170907a07600b0099bcdfdfb44mr565067ejc.9.1690398341464;
        Wed, 26 Jul 2023 12:05:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id b10-20020a170906038a00b009929ab17bdfsm9949601eja.168.2023.07.26.12.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 12:05:41 -0700 (PDT)
Message-ID: <778263e2-78f0-a679-e981-c8a7147028c6@linaro.org>
Date:   Wed, 26 Jul 2023 21:05:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: add renesas,isl28022
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?Q?Carsten_Spie=c3=9f?= <mail@carsten-spiess.de>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20230726152235.249569-1-mail@carsten-spiess.de>
 <20230726152235.249569-3-mail@carsten-spiess.de>
 <82628237-e087-269e-9673-cf3873fe4b35@linaro.org>
 <4105d77e-e011-8df7-35bf-bbfca0b640da@roeck-us.net>
 <7a44e513-2b6b-aed3-3d71-e56bd0be2417@linaro.org>
 <7091e719-4d9f-246c-262a-02ad91fd790d@roeck-us.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7091e719-4d9f-246c-262a-02ad91fd790d@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2023 20:59, Guenter Roeck wrote:
> On 7/26/23 11:27, Krzysztof Kozlowski wrote:
>> On 26/07/2023 20:19, Guenter Roeck wrote:
>>>>
>>>>> +    enum: [1, 2, 4, 8]
>>>>> +
>>>>> +  average:
>>>>> +    description: |
>>>>> +      Number of samples to be used to report voltage, current and power values.
>>>>> +      defaults to <0> when not set
>>>>> +    enum: [0, 1, 2, 4, 8, 16, 32, 64, 128]
>>>>
>>>> I am sure hwmon has some property for this. Are you sure it is called
>>>> "average"?
>>>>
>>>
>>> Something with samples. adi,power-sample-average is similar. Others
>>> use average-samples, qcom,avg-samples, touchscreen-average-samples.
>>
>> So probably it's a time to come with something generic, e.g.:
>> average-samples in some hwmon.yaml
>>
> 
> Maybe, but that is going to take a lot of time. Many configuration options
> of hardware monitoring chips (such as the thermal sensor type, the ideality
> factor of a thermal diode, or the number of pulses per revolution reported
> by fans) are actually properties of the connected device, and Rob has made
> clear that he expects such properties to be associated with the actual
> device (fan, thermal sensor, etc). 

Sure, we can go then with usual vendor like property, so:
renesas,average-samples


Best regards,
Krzysztof

