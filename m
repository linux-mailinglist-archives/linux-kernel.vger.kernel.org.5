Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7579275C07E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjGUHzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGUHzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:55:13 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A203F19B6;
        Fri, 21 Jul 2023 00:55:11 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666eb03457cso1120159b3a.1;
        Fri, 21 Jul 2023 00:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689926110; x=1690530910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5xW1jRQSZihGEtMJPZeQmnAS3v2SxkbZcL5e7ETIR+0=;
        b=i87Mf0HStvpFjpfG/RzgKDWpiKNE7zgQ3mdRwkTLfdHvA7yZRr64WZYhO7GfciUaE8
         Bn5RYK0RaQ1sE324Kp1NVHg2DU4tv5jkmJGfNtX38GHFyhGkLvRhMu7ivVtFNr+c4kVw
         E+uHgn1wPatvF9Dw3HQ8W+axpB29bnCE1myI20FARQ51yshgE+3g1Uht270Kkh9MdrDJ
         cUY8oY2CYqGyzGrSerfWHSa8vDRRfzWgC39jzZjoBNioFkJjoACePKNI0amKkpQBc9bn
         rZPBaKfEda4J/hoWEZMVOtJRjvpKq2KJmUovHK8RVU1HhKWDgTJNDoUsx6jXNK+1Ogwo
         glgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689926110; x=1690530910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5xW1jRQSZihGEtMJPZeQmnAS3v2SxkbZcL5e7ETIR+0=;
        b=NwlBVoER8KVU1KM4nuPlimAUEPaJ9cUBgVJJdl2CuAGZZrikLg/M6vclOKPxeV26K1
         Fq9YNT9o0z545ofsUltmypQmmGkGkkTg5SuWPaOtXgT25TIkuRHqKvTjs2Wy+YjZzKph
         MbJ7heTYRl3PqprBuf+CkQ01uHvDyBZl2KL3aAQrCCCfU6ze07Dl/ZqBENxcmX5x0Hsc
         MFjtO6396wpZTDvlPxfewfvwsNrUXxkisk9+Dkhc9Ohi9QFQ4DTnH9K+SOHnmY0CbaWN
         WDzg5DPlbQnIEprVy0DWdrHiJy0xjOK94wp8yHlmrv6Vhn36UGBiPi0cuWLbWnwmVqoe
         eMUA==
X-Gm-Message-State: ABy/qLa7r3WHyR53zhkSXwVhawkEKDxEv6xTaiwJNKrt9KSSG4x1iRX3
        A9isTj0lBzupNU5ObGCG/Oc=
X-Google-Smtp-Source: APBJJlFF4Iz9CsoLhkHQ2KETwbX5uXeLZIrl23phg9ovDuqpAxWBDtOWbXu5KHlKpF9x+RGF+XoQXw==
X-Received: by 2002:a05:6a20:96d3:b0:133:b0d5:b3fc with SMTP id hq19-20020a056a2096d300b00133b0d5b3fcmr954086pzc.7.1689926110426;
        Fri, 21 Jul 2023 00:55:10 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d90200b001b9ff5aa2e7sm2755789plz.239.2023.07.21.00.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 00:55:10 -0700 (PDT)
Message-ID: <e2d76107-5b25-c3ce-8741-50b0f0498284@gmail.com>
Date:   Fri, 21 Jul 2023 15:55:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] dt-bindings: rtc: Document nuvoton ma35d1 rtc driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, mjchen@nuvoton.com, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230720012826.430026-1-ychuang570808@gmail.com>
 <20230720012826.430026-2-ychuang570808@gmail.com>
 <7889ef36-90ee-222b-fe67-ab4e127d1df6@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <7889ef36-90ee-222b-fe67-ab4e127d1df6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/20 下午 02:10, Krzysztof Kozlowski wrote:
> On 20/07/2023 03:28, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add documentation to describe nuvoton ma35d1 rtc driver.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   .../bindings/rtc/nuvoton,ma35d1-rtc.yaml      | 45 +++++++++++++++++++
>>   1 file changed, 45 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml b/Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml
>> new file mode 100644
>> index 000000000000..08c30f3018fb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml
>> @@ -0,0 +1,45 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/rtc/nuvoton,ma35d1-rtc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35D1 Read Time Clock
>> +
>> +maintainers:
>> +  - Min-Jen Chen <mjchen@nuvoton.com>
>> +
> Missing ref to rtc.yaml.
>
>
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nuvoton,ma35d1-rtc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +
>> +additionalProperties: false
> And then use unevaluatedProperties: false instead.
>
>
> Best regards,
> Krzysztof
>

Thank you for the advice.
I will fix these two issues in the next version.


Best Regards,
Jacky Huang

