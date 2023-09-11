Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D3E79B641
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348742AbjIKVal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbjIKInb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:43:31 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6471A5;
        Mon, 11 Sep 2023 01:43:26 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9338e4695so67908241fa.2;
        Mon, 11 Sep 2023 01:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694421804; x=1695026604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VXFTsP12wrxAzUjCCRboSM4a3IaTPoXxwWoK/D998/w=;
        b=ZnHnDJLjc0GjCqMA4/Z/mZbcL7LVy8Y+yu/mUiA8nzCYT5DMvWQKasVt/iKo7Urrrq
         u5ZukdaeMKSjgTKSdsKx0U+H1wk7ANRNUzcQNeRbXKn1ljj4kn58TwoTOiziOiV2Uh0m
         MRdrZTugI/ZYc3Qljjuwz2m27xUi1OZcFxVYOLsJ+d7M/ozxPGqOBpU9dAVLdXAN1QEl
         r+oWQZN5/iD4EQVz3FxHphkFK4KXR3FJhgspzWtzM2y22laaWubF4EMp46snK36YXWj1
         CRiCozEGdqAtJ1e7dINaUBhl2Y97RRaBOibcsMG50+SwGKA9W+BIVbapX0uzzqxwgc0P
         F1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694421804; x=1695026604;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VXFTsP12wrxAzUjCCRboSM4a3IaTPoXxwWoK/D998/w=;
        b=HQ0hxA6RSH0yanhxMjc/j7STMmEAj334+UycXxFQjH34qiUnjd7v1mSQg/TWpu/Eml
         oOL85jyGlyrx5E49n7XG3vi/GFuvK0MEgsNoIIEigRE7LB7uP8xzgUl8gG+Y1aizLt9Q
         snqmsElmnZPJOM6PlkJNqXVOM2qFASNpFF2Nh2wNs7ketwzJMF3kQWrg1xM7fM/aKQ9h
         hCtXzK1hF+nMmsPUGHMEYHEb47OhyYUWPRy+2aiqOYwzCcLzHkTxAlBc/n70zWHkNGo6
         aqMJvzVkzdebWNGFJr37ih215PoS6/RRFoj8qnNiEfTljglk4ZM0OEgoY4MPWZEr91GR
         xkPg==
X-Gm-Message-State: AOJu0YxtJidUuynkgdeYrBwsj9ycXuOo3sxNc8LXct6VlM0GMwlYcACU
        srAOMFU+clSOMBj+KBoFAhQ=
X-Google-Smtp-Source: AGHT+IEBePdY5vRblamEOb4Bxr3m/BHlMOLZkfFn36ztGoB0yxzSBu2uVVDZkqtjqnQUqPnzTh0XJA==
X-Received: by 2002:a2e:9f45:0:b0:2b6:9da9:2884 with SMTP id v5-20020a2e9f45000000b002b69da92884mr6670730ljk.40.1694421804210;
        Mon, 11 Sep 2023 01:43:24 -0700 (PDT)
Received: from [192.168.100.74] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id f2-20020a1709064dc200b0099cc15f09a0sm4945462ejw.55.2023.09.11.01.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 01:43:23 -0700 (PDT)
Message-ID: <32c8cfb6-e14b-326d-1415-63c4bf46b23e@gmail.com>
Date:   Mon, 11 Sep 2023 10:43:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] dt-bindings: rtc: pcf2123: convert to YAML
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chris Verges <chrisv@cyberswitching.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230907-topic-pcf2123_yaml-v1-1-40e82bed2066@gmail.com>
 <202309101217447eae4bc4@mail.local>
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <202309101217447eae4bc4@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10.09.23 14:17, Alexandre Belloni wrote:
> On 10/09/2023 13:00:27+0200, Javier Carrasco wrote:
>> Convert the existing txt binding to the preferred YAML format.
>>
>> The pcf2123 node may contain SPI settings such as spi-cs-high and
>> spi-max-frequency, which keeps it from being added to the trivial-rtc
>> binding with its current definition. Add a reference to
>> spi-peripheral-props.yaml to account for that.
>>
>> The "interrupts" property was missing in the binding although it is
>> already supported. Add the missing property in the new binding.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>  .../devicetree/bindings/rtc/nxp,pcf2123.yaml       | 45 ++++++++++++++++++++++
>>  .../devicetree/bindings/rtc/nxp,rtc-2123.txt       | 17 --------
>>  2 files changed, 45 insertions(+), 17 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2123.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2123.yaml
>> new file mode 100644
>> index 000000000000..013e5e5dc0ae
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2123.yaml
>> @@ -0,0 +1,45 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/rtc/nxp,pcf2123.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NXP PCF2123 SPI Real Time Clock
>> +
>> +maintainers:
>> +  - Chris Verges <chrisv@cyberswitching.com>
> 
> Is Chris willing to maintain the binding?
> 
The email address chrisv@cyberswitching.com does not exist anymore so it
is likely that Chris will not reply unless he is subscribed to the
mailing list with a different email address. I would propose that I add
myself as the binding maintainer and send a v2.

>> +
>> +allOf:
>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>> +  - $ref: rtc.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nxp,pcf2123
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    spi {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        rtc@3 {
>> +            compatible = "nxp,pcf2123";
>> +            reg = <3>;
>> +            spi-cs-high;
>> +        };
>> +    };
>> +...
>> diff --git a/Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt b/Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt
>> deleted file mode 100644
>> index 7371f525a687..000000000000
>> --- a/Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt
>> +++ /dev/null
>> @@ -1,17 +0,0 @@
>> -NXP PCF2123 SPI Real Time Clock
>> -
>> -Required properties:
>> -- compatible: should be: "nxp,pcf2123"
>> -                      or "microcrystal,rv2123"
>> -- reg: should be the SPI slave chipselect address
>> -
>> -Optional properties:
>> -- spi-cs-high: PCF2123 needs chipselect high
>> -
>> -Example:
>> -
>> -pcf2123: rtc@3 {
>> -	compatible = "nxp,pcf2123"
>> -	reg = <3>
>> -	spi-cs-high;
>> -};
>>
>> ---
>> base-commit: 535a265d7f0dd50d8c3a4f8b4f3a452d56bd160f
>> change-id: 20230907-topic-pcf2123_yaml-2ce57f4e77d7
>>
>> Best regards,
>> -- 
>> Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>
> 
Best regards,
Javier Carrasco
