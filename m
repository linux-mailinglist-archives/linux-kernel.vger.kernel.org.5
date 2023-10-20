Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58147D1566
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 20:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377936AbjJTSEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 14:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjJTSE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 14:04:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B99D5A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:04:26 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-317c3ac7339so853013f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697825065; x=1698429865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jrYybwUMXMQDct16/KSDb1AL83UYfzbsLKEmVGzNrmk=;
        b=BOaO6fAsSS1BYv2zeHRsxNEG3DxCKyKtjwv0YQj+nFr5iLN3iJeBCG0+XKJbAImB2x
         07TgIbjBKwHa4xngbu0FZiN8fMoyHRsF0BoUKD4Gg4DfbhaPQnBEisr7/1UGcYrDd3MC
         OstJdO+z3fPqpoPHL2apG3oepMrgWEr/xA65VWSu00KJuWwGGuOA3tlK+Xqpgj1firR+
         BhNrwXcc5a2fgEkKlEpl1o2jkaM25sljOBPTs4EpNyP3geDB/bWunnj7MkJt8NrGmh1g
         9IODW4g242DSBHomcatmGNsd3KNAA/HjflAk21yS+U8qTNQ5DfNUICNeuuMLpaNuAi+q
         JVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697825065; x=1698429865;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jrYybwUMXMQDct16/KSDb1AL83UYfzbsLKEmVGzNrmk=;
        b=B2+sAJR02hLFoc8ZCeccBL1S1VQBq3VR6fObnxCyey6CESJG+IfrQC/AJ80YKI1j9b
         OVa3ICPg3uHQcc3EjDniGCb99bGY+6TcdrgqSy+91R623NLlPmdZs2dPHKm0KigL5E+B
         ZUqCUOkBQ9/pM9leM/NUkJQK2+GwLffHCU4lnrVTXsWEsHCbf8aJFue+ncebiSOPby3/
         E0xQI1lI29LdUwT29TC0mTzhlLZuomjVIlBiCWm13MgAm7NPqbp6A/oPVqMzXna1QAlG
         vC5RyRr2H7F5EnyvLItm5TPpidrfedaFbIct4Q5XWdcVZdJY6FN9qQI6APsd9nwiAcaC
         9JtQ==
X-Gm-Message-State: AOJu0Yx3Zf96uOb3x5U1KPQTIHZJD6N81WmkVGIi4qOje/hfCrBOoO3n
        dlO0ZUhRvG0BDToujTi+lYn+LcyLyXoFZP4ur2A=
X-Google-Smtp-Source: AGHT+IGAQcB/OoprNSPgK5yZLGsiVkKqJvmE66/NqlSJUrxMppe2XNIXq95JTC4Fb2lqnycn9cH6tw==
X-Received: by 2002:adf:e5c8:0:b0:32d:6891:f819 with SMTP id a8-20020adfe5c8000000b0032d6891f819mr2224887wrn.41.1697825064975;
        Fri, 20 Oct 2023 11:04:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id o7-20020a056000010700b0032da6f17ffdsm2162312wrx.38.2023.10.20.11.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 11:04:24 -0700 (PDT)
Message-ID: <b0247572-607d-48e9-92ef-a3e0a8fe17f9@linaro.org>
Date:   Fri, 20 Oct 2023 20:04:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] dt-bindings: pwm: Add OpenCores PWM module
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Hal Feng <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20231020103741.557735-1-william.qiu@starfivetech.com>
 <20231020103741.557735-2-william.qiu@starfivetech.com>
 <20231020-barley-rosy-92c3688cd515@spud>
 <20231020-giddy-fidgety-f070ef121ff2@spud>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231020-giddy-fidgety-f070ef121ff2@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2023 16:22, Conor Dooley wrote:
> On Fri, Oct 20, 2023 at 03:21:15PM +0100, Conor Dooley wrote:
>> Krzysztof, William,
>>
>> On Fri, Oct 20, 2023 at 06:37:38PM +0800, William Qiu wrote:
>>> Add documentation to describe OpenCores Pulse Width Modulation
>>> controller driver.
>>>
>>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>>> ---
>>>  .../bindings/pwm/opencores,pwm-ocores.yaml    | 53 +++++++++++++++++++
>>>  1 file changed, 53 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/pwm/opencores,pwm-ocores.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/opencores,pwm-ocores.yaml b/Documentation/devicetree/bindings/pwm/opencores,pwm-ocores.yaml
>>> new file mode 100644
>>> index 000000000000..0f6a3434f155
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pwm/opencores,pwm-ocores.yaml
>>> @@ -0,0 +1,53 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pwm/opencores,pwm-ocores.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: OpenCores PWM controller
>>> +
>>> +maintainers:
>>> +  - William Qiu <william.qiu@starfivetech.com>
>>> +
>>> +description:
>>> +  OpenCores PTC ip core contains a PWM controller. When operating in PWM mode, the PTC core
>>> +  generates binary signal with user-programmable low and high periods. All PTC counters and
>>> +  registers are 32-bit.
>>> +
>>> +allOf:
>>> +  - $ref: pwm.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - opencores,pwm-ocores
>>
>> What does the extra "ocores" suffix add, when it just repeats the vendor
>> prefix?
>>
>>> +      - starfive,jh71x0-pwm
>>
>> Krzysztof, did you approve this generic compatible?

Patch was quite different than reviewed by me. This obviously does not
make any sense. Thanks for spotting.

I guess carrying tags should not be trusted.

>>
>> And the whole thing looks like it should really be something like
>>
>> items:
>>   - enum:
>>       - starfive,jh7100-pwm
>>       - starfive,jh7110-pwm
>>   - const: opencores,pwm
> 
> (assuming that the opencores,pwm compatible represents a subset of what
> is implemented on the jh7100 series)



Best regards,
Krzysztof

