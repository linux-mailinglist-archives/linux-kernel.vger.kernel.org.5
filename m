Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326C37BA540
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbjJEQPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240464AbjJEQNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:13:02 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD5586B9;
        Thu,  5 Oct 2023 01:21:40 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-690bccb0d8aso584321b3a.0;
        Thu, 05 Oct 2023 01:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696494100; x=1697098900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6xF4VcmjAf7zdGNHFHYPdHCqEwDNHCYpzit/ZJRYbdY=;
        b=nQCum2bf1WuahhSloLrn+5CETzLT6bCJ39ky3i3Ju5kCNcILwmVDsAzUhrLV7UUQeT
         W/zSEOqej7Wg6LBWTw40QqqwSOV10A3dIt5r+6d5iMraJlHQLNU/eTSOWOF792oKvEV+
         n4fy5mYY1E3foUVO/Jae36FuQV1jfppD/L60dz2WrMZeuR77Rgt0bvwa/BmjwE3kTaBW
         J03LrM82kvjszBxrecLnLwXDOYVzGEgDuWl/mDTlgCoQ9yAbR3DCaEIN8A9q+YoGn0FZ
         yQEBVj48kbR0EecMMg+Zu6xPauvZPW93hogohpoAztxJcUveTDj6KHSXpQ/JwL2yFhC1
         vLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696494100; x=1697098900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xF4VcmjAf7zdGNHFHYPdHCqEwDNHCYpzit/ZJRYbdY=;
        b=desiblIG1zP9+vC8OhJ0Go3tJrJWlDqm4JjMltCFlUo8CcMWoOPYj1sAIJgLuySyik
         f0mg1DOU5ABgrPzpUCAijByJ+NM96+W7p5rwH0CjJKxOHuM7pwtP7LCo+Hcx59WQJFw1
         LWnUS/ilFbBKGfNN3yfaqBOM3gky4MoMjlfQil3eCmVsruhx+yshbdyl+kQ8UT1v/lP6
         jlQK8BqNvQG5hBLOFYmSC24jOS9N5jY+idNF9Qh/LqRx8DXI228xZa5xWpzmBdIL63g3
         blCPWrgMg6V0WuM5s/jl8qGRjF1BLAuxXQgEpsbNmaGyzVTDLkv7xqucJfycSeWkecqc
         obNQ==
X-Gm-Message-State: AOJu0YxrMPeZIruqO9B9M1oHHyMnUBdMiO4hbX6BwWEOsqpwna7u6kxJ
        fQxzJFVT/KpTPH5LCTn8Rv8=
X-Google-Smtp-Source: AGHT+IFKBdwGGId/1JAn0eJrQXX5wPVt+NoaMAx1n6nayA0VFCwN8qF7d/i7qqYCoj4hKXcATdIsBg==
X-Received: by 2002:a05:6a20:3d95:b0:159:b7dc:2295 with SMTP id s21-20020a056a203d9500b00159b7dc2295mr4774516pzi.9.1696494100161;
        Thu, 05 Oct 2023 01:21:40 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.93])
        by smtp.gmail.com with ESMTPSA id du6-20020a056a002b4600b0068a13b0b300sm842288pfb.11.2023.10.05.01.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 01:21:39 -0700 (PDT)
Message-ID: <aa63918f-3a95-5e86-d61d-91a59cf643ad@gmail.com>
Date:   Thu, 5 Oct 2023 13:51:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 1/3] dt-bindings: net: Add ti,cc1352p7
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        greybus-dev@lists.linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vaishnav@beagleboard.org,
        jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231004184639.462510-1-ayushdevel1325@gmail.com>
 <20231004184639.462510-2-ayushdevel1325@gmail.com>
 <a171cc72-98cf-4f7f-ba86-6da2ac45ea22@linaro.org>
Content-Language: en-US
From:   Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <a171cc72-98cf-4f7f-ba86-6da2ac45ea22@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
>> ---
>>   .../devicetree/bindings/net/ti,cc1352p7.yaml  | 51 +++++++++++++++++++
>>   MAINTAINERS                                   |  6 +++
>>   2 files changed, 57 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
>> new file mode 100644
>> index 000000000000..291ba34c389b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/ti,cc1352p7.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments Simplelink CC1352P7 wireless MCU
>> +
>> +description:
>> +  The cc1352p7 mcu can be connected via SPI or UART.
>> +
>> +maintainers:
>> +  - Ayush Singh <ayushdevel1325@gmail.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: ti,cc1352p7
>> +
>> +  clocks:
>> +    maxItems: 2
>> +
>> +  clock-names:
>> +    description:
>> +      sclk_hf is the main system (mcu and peripherals) clock
>> +      sclk_lf is low-frequency system clock
> This does no go here, but to clocks. I wrote how it should be done.
> Don't ignore the feedback.
It was suggested to use `clock-names` by Nishanth Menon in the previous 
email, so I thought this was what it meant. I will remove clock-names if 
that's better.
>> +    items:
>> +      - const: sclk_hf
>> +      - const: sclk_lf
>> +
>> +  reset-gpios: true
>
> No, really, why do you change correct code into incorrect one? Who asked
> you to drop maxItems?
I found that many bindings (`display/ilitek,ili9486.yaml`, 
`iio/dac/adi,ad5758.yaml`) use this pattern instead of `maxItems` for 
`reset-gpios`. So I assumed it was some sort of convention. I will 
change it back to `maxItems`.


Sincerely,

Ayush Singh

