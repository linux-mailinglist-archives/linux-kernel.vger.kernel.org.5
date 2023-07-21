Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA83675C63B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjGUL6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGUL6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:58:43 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBAB171B;
        Fri, 21 Jul 2023 04:58:41 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e526e0fe4so2651439a12.3;
        Fri, 21 Jul 2023 04:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689940720; x=1690545520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sDGY2dKBI3VGrl6XhclLBCqJ3huDvzOWV6pk1LNtTuE=;
        b=RWYbKR3VvE0mCGc6sIvzKfjWX7/7RprT+HP325MNfy0rSEkqBBmBwyZHw0ghxmuRr3
         SSxg6iVGfnSuTJdF/ICTJfjzrZ5qFYVw45mgU6dUMJvkdcztnW879MQcgg31rXJMrOEh
         4MVkP8jWPaf6smUt8GNB24sw2DWvjq/f3zPwLoWC0EPScHgrM7WfeaZAfP/cQBYWWhwZ
         SAyTE5u1O3sCli1bczYlofnQ1c0GyGN5ihjeTnZ79cDye1sNHyyLpDzzP9heZhVoA3q2
         v0BnUVUJSzA5CFuBEEv6I5/Yszsv2svGNCIiXkdYnCcX9Hwqjy9D0XApcodj/vmsR8Xy
         lv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689940720; x=1690545520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDGY2dKBI3VGrl6XhclLBCqJ3huDvzOWV6pk1LNtTuE=;
        b=i0m16NQOsd1HKlbHb52t/eIzepFHI1q/JqObMFZDbMbF+1XSsMmH8XwdtDFM+Nt6N5
         RpCE5u8cjfRflvqPjcACooTSdqGf4Jfk4MB6o2E/XJQEnR2G59UYJwhoOXCu8+EOmR3E
         9x3gzEAqxmoYAiDzdxMsyruK0JPRTlfXi5tx/uRmEhAeZeyxoyb42EstIkVGu6co3lhh
         obyzVhJRMEddPr0DvXe/klWGC4ssVEQMVqcCBV4uDKx2NGmqMT/EnNkSWGTJKAqac2Qe
         XJwRqZdd/eRjcRMeyTnuo+XFP5oiYEAX1HZmbExrztB0fK3PgBcyK9SkdSkQ6TrSJYCK
         3lBQ==
X-Gm-Message-State: ABy/qLZMgY8E7cklvT20tavmYEnSHXKdnZnONaZajmBHrrjoH2iZk0bE
        FDkY6QYtHKcygdQKnmYaS0A=
X-Google-Smtp-Source: APBJJlFRqUTzN43FwZOKf+KyUVPewz0HKM3tjjBjMXMW0kB23MQMPOY8Vn2Nt3YJCyKJQnH5RQQ85g==
X-Received: by 2002:aa7:d052:0:b0:51d:a73b:0 with SMTP id n18-20020aa7d052000000b0051da73b0000mr1510426edo.10.1689940720104;
        Fri, 21 Jul 2023 04:58:40 -0700 (PDT)
Received: from [192.168.4.4] (host-95-237-109-246.retail.telecomitalia.it. [95.237.109.246])
        by smtp.gmail.com with ESMTPSA id u13-20020aa7d98d000000b0051e0f100c48sm2033792eds.22.2023.07.21.04.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 04:58:39 -0700 (PDT)
Message-ID: <d010f085-ea0e-5086-260e-c5a9be94ebfb@gmail.com>
Date:   Fri, 21 Jul 2023 13:58:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: add mcp4728.yaml
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1689857295.git.andrea.collamati@gmail.com>
 <9816cd272d19802ec6eeff0c7c29e85d4a0ade88.1689857295.git.andrea.collamati@gmail.com>
 <4898bc33-5245-8fb2-e5e6-8ea1a8f32e1e@linaro.org>
From:   Andrea Collamati <andrea.collamati@gmail.com>
In-Reply-To: <4898bc33-5245-8fb2-e5e6-8ea1a8f32e1e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 7/21/23 10:21, Krzysztof Kozlowski wrote:
>> Add documentation for MCP4728
>>
>> Signed-off-by: Andrea Collamati <andrea.collamati@gmail.com>
>> ---
>>  .../bindings/iio/dac/microchip,mcp4728.yaml   | 48 +++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
>> new file mode 100644
>> index 000000000000..6fd9be076245
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
>> @@ -0,0 +1,48 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/dac/microchip,mcp4728.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Microchip MCP4728 DAC
>> +
>> +description:
>> +  MCP4728 is a quad channel, 12-bit voltage output
>> +  Digital-to-Analog Converter with non-volatile
>> +  memory and I2C compatible Serial Interface.
>> +  https://www.microchip.com/en-us/product/mcp4728
>> +
>> +maintainers:
>> +  - Andrea Collamati <andrea.collamati@gmail.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - microchip,mcp4728
> This is a friendly reminder during the review process.

Sorry but I didn't understand all your requests:

- I changed in the title mcp4728 with MCP4728

- I added description

but I don't know which blank line or whitespaces should be removed.

Can you tell me please?

