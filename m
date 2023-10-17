Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2967CC94C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343739AbjJQQ6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbjJQQ6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:58:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40D194
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:58:47 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9be3b66f254so586599466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697561926; x=1698166726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sn8ReA+6EHyat1XVOf5lQ+OdxkKcUGO6UHfSeScub60=;
        b=ZUMkAOEevg/vvpVW/qcy4KgOIhPK7ZxAe4o1rDC1sZQLOz1SqAoabFygqfWvkysGjO
         GzkUdVwFSmrKwx3cW0NKDBfb08XHDQdM8uT9ZOOV/FHnKVkARmymCEjjm0nUw2PzYbIz
         700jocec6QtfYrIP+XHQdVyTngVAzLFBWW9SgjM4wa5562XYRSXOcPVnd92lOJNHWBlR
         v6KNpomk2ithoRbsJx8jq6Fy6wIt2oy2NgSYkRhvrRU7uGI/BII7kQlIa37BS1sVpoS0
         f6q36LpYB9oE1GavtvIuLflQij+vw5V2vl/Ndt62GUmG8Xx6apBUe9c6CKx6ua6omy7a
         oXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697561926; x=1698166726;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sn8ReA+6EHyat1XVOf5lQ+OdxkKcUGO6UHfSeScub60=;
        b=m7FsmKYfhWGebGcH5BkkJAclcAGoFrdzQam7x+299h828YxeVBfDq8P0woquEXTLOe
         oSzFmzQFJEbja45FKNVddFTaPv+cXAIPnj+iBycyHy2EJwwIHXui+Yp1kJ6HwnVb3HTV
         GHGG+Ex0DgGlGVe+QKK+6HNxbHEEuHXlJLNZnRgyT11JG4vauy3Puu1Neey6DgXzXX4g
         jBGJXzKWBiQnpo4xWSeYfYzsmQ5CgrxLKjuoP6ziDojlbeNqCRSrlM3mObScXfbO3dMG
         p4ZTctqEw9RZckGnVDM6guHu2MvXcBj4JTiP1wY36BmogxooOhUj+XPcVIJ4cbpppo0A
         fNow==
X-Gm-Message-State: AOJu0Yzzeo8/NNd9SLZUkdrlNkmb94Uvy++RAzMPe9HdIMU6olhZowfd
        F5DnXtqF9oMSjxWB3DoAO98bpA==
X-Google-Smtp-Source: AGHT+IEepVdMHo1jVKr5jfgrzJr65rg1MXBAc6Xm0i6CLsKDavhXSJJkwRDcT95O874DhaQcJEB1Jw==
X-Received: by 2002:a17:907:1c07:b0:9be:d55a:81ba with SMTP id nc7-20020a1709071c0700b009bed55a81bamr2268844ejc.65.1697561926185;
        Tue, 17 Oct 2023 09:58:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.154])
        by smtp.gmail.com with ESMTPSA id s2-20020a170906454200b009b977bea1dcsm139967ejq.23.2023.10.17.09.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 09:58:45 -0700 (PDT)
Message-ID: <9fd1c6cf-ae4d-499b-bd62-e74b580cd29c@linaro.org>
Date:   Tue, 17 Oct 2023 18:58:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dt-bindings: input: Introduce Himax HID-over-SPI
 device
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Tylor Yang <tylor_yang@himax.corp-partner.google.com>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        poyuan_chang@himax.corp-partner.google.com,
        jingyliang@chromium.org, hbarnor@chromium.org, wuxy23@lenovo.com,
        luolm1@lenovo.com, poyu_hung@himax.corp-partner.google.com
References: <20231017091900.801989-1-tylor_yang@himax.corp-partner.google.com>
 <20231017091900.801989-2-tylor_yang@himax.corp-partner.google.com>
 <20231017-womb-lantern-186f16ce67af@spud>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231017-womb-lantern-186f16ce67af@spud>
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

On 17/10/2023 15:59, Conor Dooley wrote:
> Yo,
> 
> On Tue, Oct 17, 2023 at 05:18:57PM +0800, Tylor Yang wrote:
>> The Himax HID-over-SPI framework support for Himax touchscreen ICs
>> that report HID packet through SPI bus. The driver core need reset
>>  pin to meet reset timing spec. of IC. An interrupt to disable
>> and enable interrupt when suspend/resume. Two optional power control
>>  if target board needed.
>>
>> Signed-off-by: Tylor Yang <tylor_yang@himax.corp-partner.google.com>
>> ---
>>  .../devicetree/bindings/input/himax,hid.yaml  | 123 ++++++++++++++++++
>>  MAINTAINERS                                   |   6 +
>>  2 files changed, 129 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/input/himax,hid.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/input/himax,hid.yaml b/Documentation/devicetree/bindings/input/himax,hid.yaml
>> new file mode 100644
>> index 000000000000..9ba86fe1b7da
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/himax,hid.yaml
>> @@ -0,0 +1,123 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/input/himax,hid.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Himax TDDI devices using SPI to send HID packets
>> +
>> +maintainers:
>> +  - Tylor Yang <tylor_yang@himax.corp-partner.google.com>
>> +
>> +description: |
>> +  Support the Himax TDDI devices which using SPI interface to acquire
>> +  HID packets from the device. The device needs to be initialized using
>> +  Himax protocol before it start sending HID packets.
>> +
>> +properties:
>> +  compatible:
>> +    const: himax,hid
> 
> This compatible seems far too generic. Why are there not device specific
> compatibles for each TDDI device?

Which was pointed out by Rob in v2, so his feedback was ignored.

> 
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  reset:
>> +    maxItems: 1
>> +    description: Reset device, active low signal.

No, come one, read feedback from Rob.

>> +
>> +  vccd-supply:
>> +    description:
>> +      Optional regulator for the 1.8V voltage.
>> +
>> +  vcca-supply:
>> +    description:
>> +      Optional regulator for the analog 3.3V voltage.
>> +
>> +  himax,id-gpios:
>> +    maxItems: 8
>> +    description: GPIOs to read physical Panel ID. Optional.
>> +
>> +  spi-cpha: true
>> +  spi-cpol: true
> 
>> +  himax,ic-det-delay-ms:
>> +    description:
>> +      Due to TDDI properties, the TPIC detection timing must after the
>> +      display panel initialized. This property is used to specify the
>> +      delay time when TPIC detection and display panel initialization
>> +      timing are overlapped. How much milliseconds to delay before TPIC
>> +      detection start.
>> +
>> +  himax,ic-resume-delay-ms:
>> +    description:
>> +      Due to TDDI properties, the TPIC resume timing must after the
>> +      display panel resumed. This property is used to specify the
>> +      delay time when TPIC resume and display panel resume
>> +      timing are overlapped. How much milliseconds to delay before TPIC
>> +      resume start.
> 

No improvements here...

You must implement all feedback from v2. Not pieces of it.

Best regards,
Krzysztof

