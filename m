Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8888779A4AB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjIKHmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjIKHmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:42:00 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B07118
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:41:54 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bce552508fso67071411fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694418112; x=1695022912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X6Wi2Cl6yqEgEwDpqAn0o8L4gTcv/vavP+EfJY/TstY=;
        b=cGUVsO53Kd03jleKUWd14r3WkBxLTVzVOO+C7Ojez8JFXojVGjPLNRnU7NG+A8C6NO
         J679xBFIdEjLs2JR93o23dBY5eWHK4u3ddsR3l9FDIzKzC1a1hBxOxGBRVxGkuab+tsN
         wOuF9PfHNV+tJY71Fo404+4z2I2JdbxPto3A/q2x15yWmjgN3pxTZaRw0OB5myafEYbp
         JUT/3Z0Lc2JQw4VuJwrgsqSBwDKHg+F+iGBghanqtxst7gLqinLeFW93+7rhmawdn4Br
         oFvu6t4sDa2JtXfZurvLPgZThZc4vkII+Bq2LWgwWoxxGEAjA7oT5Kj+Q34QK5Ug6Efa
         SMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694418112; x=1695022912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6Wi2Cl6yqEgEwDpqAn0o8L4gTcv/vavP+EfJY/TstY=;
        b=Ssj1L31+9lmcixW23oytZZTYX8XRD3JMrtpsIiFfSs0XqAf+mxUImftY7XJWJg5d0d
         3pYse4SdcdZpHyQCM2vvTFnlDOzbHjo+F1TGkJQHqBqTRxnLQww9v/u5m8UQdjhWJ6CR
         HeCiHsQ3R/IrLRXKWxg7GLojXxDcOiElm3B/2smzlgIiMYLkDbGyFavuyXCvRDyF4XMZ
         /nt6Hk1/XJ2iTWMqz5wsjkjwzUR/O5rlXvW1zu6uG4RtTS2es4PdFpA/lKq9/z0PYe+m
         2WjqdxuCNuRuKZKMiou7lt6EKQLn9eOEPlnhhFQD1Jtirhzdo35dmYRpQMsuaLrkeFmg
         9z/A==
X-Gm-Message-State: AOJu0YwHfvKyHxAK0gC7J84VvW+9sMf9Sa8EtVpMb5qF0hdLr40osfhf
        +HOwk5UbnfhQxdxT8xARoquA3A==
X-Google-Smtp-Source: AGHT+IF24kz1iYQ9vPXRQ0ngdaYWmIH4ZWnCCdeM2ZQ1388/L6JwGV+ir1r1kuZ0k8URNwxzbj1NoA==
X-Received: by 2002:a2e:b015:0:b0:2bc:bf29:18d3 with SMTP id y21-20020a2eb015000000b002bcbf2918d3mr6679147ljk.31.1694418112182;
        Mon, 11 Sep 2023 00:41:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id l15-20020a1709060e0f00b0099bcd1fa5b0sm4902868eji.192.2023.09.11.00.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 00:41:51 -0700 (PDT)
Message-ID: <500f8285-3939-4cc7-9731-e4127d08451f@linaro.org>
Date:   Mon, 11 Sep 2023 09:41:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/3] dt-bindings: regulator: Add mps,mpq2286
 power-management IC
To:     Saravanan Sekar <saravanan@linumiz.com>, sravanhome@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20230911034150.181880-1-saravanan@linumiz.com>
 <20230911034150.181880-3-saravanan@linumiz.com>
 <34ede760-d612-4628-17e6-600c133ee878@linaro.org>
 <d7eb272e-8abb-c307-4aa8-b0af3f943453@linumiz.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d7eb272e-8abb-c307-4aa8-b0af3f943453@linumiz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 09:12, Saravanan Sekar wrote:
> On 11/09/23 11:56, Krzysztof Kozlowski wrote:
>> On 11/09/2023 05:41, Saravanan Sekar wrote:
>>> Document mpq2286 power-management IC
>>>
>>> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
>>
>> Please use subject prefixes matching the subsystem. You can get them for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> your patch is touching. It's: regulator: dt-bindings:
> 
> Thanks for your time to review. git log has mix of "regulator: 
> dt-bindings" and "dt-bindings: regualtor".

Just take a look how many times each appear... they are just few cases
of the latter.


> I had referred my own 
> accepted driver regulator/mps,mpq7932.yaml
> 
>>
>>> ---
>>>   .../bindings/regulator/mps,mpq2286.yaml       | 59 +++++++++++++++++++
>>>   1 file changed, 59 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml b/Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml
>>> new file mode 100644
>>> index 000000000000..d00d887870a9
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml
>>> @@ -0,0 +1,59 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/regulator/mps,mpq2286.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Monolithic Power System MPQ2286 PMIC
>>> +
>>> +maintainers:
>>> +  - Saravanan Sekar <saravanan@linumiz.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - mps,mpq2286
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  regulators:
>>> +    type: object
>>> +
>>> +    properties:
>>> +      "buck0":
>>
>> You did not test it... Sigh. Anyway, there is no need for entire
>> regulators node for one regulator. Can the device do anything else than
>> being a regulator?
>>
> 
> I tested it, but documentation is not updated with test findings (buck0).

I mean, testing bindings. You did not test this patch. Testing this
patch produces warnings, so this is considered a failed test.

> 
> Other chipset has multiple regulator so dts has regulators node to keep 
> the driver common
> 
> Primarily device is a regulator with pmbus capability like fault status 
> (OV,OC, VIN, VOUT, Power good status), temperature status.

OK, then regulators node seems fine. Anyway, drop quotes and test this
patch (which means: test the bindings).

Best regards,
Krzysztof

