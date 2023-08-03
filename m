Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D393176F1F5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjHCSji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHCSjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:39:36 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806522D45;
        Thu,  3 Aug 2023 11:39:34 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9338e4695so20320741fa.2;
        Thu, 03 Aug 2023 11:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691087972; x=1691692772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qY8y0bhWv/kmv6hE31ySDMBaDOU/coUg2wei1K/EEVk=;
        b=Ii6hJYypF6WDdLtpeezhFvSpG+IN2Yr//dq5Vwj9L/0eUQUthEuLIYzdGTvIruGOzp
         4XzW//U4EzoA+H3XuO/rfAFtVv2lYPV7ip1nPXT2I0GlT0JbtGxGMPpfj66XiMH/lYRp
         2zGpXLFnc/wb6r9wPK+a4hOnE8kTCGglpEEOJv1RV+TNIzInKOAAztCwBzyKF9mCtJyc
         uteTpISFVHfKbkw9LPB1UnQ/EmWqfczH928y5IlVZmw/sWljgANBaD7xbELipINgLGrP
         FlyRQiTOdlUsae/6Tw1yVTbO+g54D+cDOckrN+K7vYhz7kOW0YgxCDBcnGOkxW+BmGXJ
         amtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691087973; x=1691692773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qY8y0bhWv/kmv6hE31ySDMBaDOU/coUg2wei1K/EEVk=;
        b=FOq06qGvakBWZszw4VsIx2viH59FAqNlXFywjcPY+zqh/j3VtP5FveOFh/YfHvbMU8
         V2SotpdTl78zgwohsS4xzN16hQPsQ1WuznxBhfuGqgmxexkCtdAep0i51YD2yVFx6/s4
         rC2C+pLV540qsCTCkS05G4Zqd4ZrG2OIKMmxXs2JzMjEkNBdN76XsMQCx/kIo2ZoA/sU
         HrgbF8dxLMYEeik2aibdGQ+gRL6HRowgoBf8z8hDKBN4ydWZw75jFUH+3pJtIPrgAyJp
         yoBXIdu1t681DpPBys2RFBTHiLxvj7Sv1jHjT+FB/Zrv6A4w7tNII1NLLJz2vWEU667D
         Jq6Q==
X-Gm-Message-State: ABy/qLbSKhl6JSCbPwOYy9zQY0He03k1ZgZ0FcOA/dX8xinLs907P7v5
        opns9GJSugzDO4wgcM+gtnAxo6PZR4OGZg==
X-Google-Smtp-Source: APBJJlHOf2+F29r/zp9GxM9eYaAjaWAp05g+jGZNVxYfIBsu9Ain0eK2tT0JinmQX4BSeZJ+kGE3TA==
X-Received: by 2002:a2e:b054:0:b0:2b9:d7b7:36d4 with SMTP id d20-20020a2eb054000000b002b9d7b736d4mr7343035ljl.16.1691087972346;
        Thu, 03 Aug 2023 11:39:32 -0700 (PDT)
Received: from [192.168.4.4] (host-79-26-241-62.retail.telecomitalia.it. [79.26.241.62])
        by smtp.gmail.com with ESMTPSA id d8-20020a1709063ec800b009927d4d7a6bsm168977ejj.53.2023.08.03.11.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 11:39:31 -0700 (PDT)
Message-ID: <8077daef-bbcc-4162-a9c8-18bae3372878@gmail.com>
Date:   Thu, 3 Aug 2023 20:39:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: dac: add mcp4728.yaml
To:     Conor Dooley <conor@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1691066050.git.andrea.collamati@gmail.com>
 <d93dd116cfa7f958c038c0c62993071ea48451d2.1691066050.git.andrea.collamati@gmail.com>
 <20230803-art-marbles-c57091465420@spud>
Content-Language: en-US
From:   Andrea Collamati <andrea.collamati@gmail.com>
In-Reply-To: <20230803-art-marbles-c57091465420@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry it's the first time I try to submit a driver.

So after your positive review I should add...

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

I will do in v5..

        Andrea


On 8/3/23 17:21, Conor Dooley wrote:
> On Thu, Aug 03, 2023 at 02:56:34PM +0200, Andrea Collamati wrote:
>> Add documentation for MCP4728
>>
>> Signed-off-by: Andrea Collamati <andrea.collamati@gmail.com>
> I gave you a reviewed-by on v3, is there a reason that you dropped it?
>
> Thanks,
> Conor.
>
>> ---
>>  .../bindings/iio/dac/microchip,mcp4728.yaml   | 49 +++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
>> new file mode 100644
>> index 000000000000..99831d7f1c16
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
>> @@ -0,0 +1,49 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +
>> +$id: http://devicetree.org/schemas/iio/dac/microchip,mcp4728.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Microchip MCP4728 DAC
>> +
>> +maintainers:
>> +  - Andrea Collamati <andrea.collamati@gmail.com>
>> +
>> +description: |
>> +  MCP4728 is a quad channel, 12-bit voltage output
>> +  Digital-to-Analog Converter with non-volatile
>> +  memory and I2C compatible Serial Interface.
>> +  https://www.microchip.com/en-us/product/mcp4728
>> +
>> +properties:
>> +  compatible:
>> +    const: microchip,mcp4728
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  vdd-supply:
>> +    description: |
>> +      Provides both power and acts as the reference supply on the MCP4728
>> +      when Internal Vref is not selected.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - vdd-supply
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        dac@60 {
>> +            compatible = "microchip,mcp4728";
>> +            reg = <0x60>;
>> +            vdd-supply = <&vdac_vdd>;
>> +        };
>> +    };
>> -- 
>> 2.34.1
>>
