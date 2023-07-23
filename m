Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E2375DFEF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 06:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjGWE7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 00:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGWE7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 00:59:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84F810D8;
        Sat, 22 Jul 2023 21:59:41 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99454855de1so481126166b.2;
        Sat, 22 Jul 2023 21:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690088380; x=1690693180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4lRuB5t7lbiPhYG692DvefCkvkwHh1+HHIitls9jjU=;
        b=OnoEaMwxEiAyUtBBk2ATXpJ0ysNJMHDpJcetClM1VHv7260ZkFQrQJQZ60eYnIvRTC
         ghFZ2hMX3kPXr70KdOZLNrBe7E7TvvI0+NGTqu3X7NE923IWplr96+biW0hd1/HelmYT
         lPJgogIX9/9JkDemUf2cm1pxbrMP19k9nWVgKGmnw32O9gpFjlI82+ijtzYJoaVXGr3U
         x6i2iT6AL8UpCwTkw+ekdYxfQcjycfV55v4zldMrG+lXqikSMarzAONCdR/U4+3RYncI
         D8hw1JmOVczQnIkTLIszTqXNTLJjfY9mH+Zglc7A5sW71N9TonDB/lZovZfq4gr7bXm5
         ImQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690088380; x=1690693180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p4lRuB5t7lbiPhYG692DvefCkvkwHh1+HHIitls9jjU=;
        b=B8vdcWhxCb6iFiWoicRBOS8dpA2BHFWCYiCHA9tzOn/rYURlisnDpQp9crCPN7KGFI
         0ZdItir/IDpnRDs8dYgcdem+AK2FxZ8nmihCaUhebD9GJHuDzoMWldYKUqgYjwTGDWP9
         iVO1GrMWqFoKwzpf+A0kmljSeRsJQCFKV2vV7jmlpArWkmIQrAVSpTC7r23/fXq/14S4
         KTs6w7KbKNXh+bo6hkNSSgvOH/T/1HPsSYmfhEVdDseNwSn01UCrmLx7+Klq1Hwkysu2
         Klj0tbUWsrSeJ44BwSeKjzJnr7eLfTNEBaLXt3AGsaoyjh5F3LKFzy/HqkoUAUsbgpY6
         ZIFQ==
X-Gm-Message-State: ABy/qLZ5oDlLaKCuGD0RlnqrngcIV2zFGLZPiA8lk6OEj90wQKX+SPfE
        EFfcaazrZKD48uTxvLqC45Q=
X-Google-Smtp-Source: APBJJlE9N5+KgFgrbyO/R9dPRgkkRzr3bDkB1s5pb2SM5UofM7KLoyhZAhjFvjrJjEKyhiBzYt/VIA==
X-Received: by 2002:a17:907:7631:b0:993:e9b8:90f5 with SMTP id jy17-20020a170907763100b00993e9b890f5mr5501402ejc.8.1690088379974;
        Sat, 22 Jul 2023 21:59:39 -0700 (PDT)
Received: from [192.168.4.4] (host-95-237-109-246.retail.telecomitalia.it. [95.237.109.246])
        by smtp.gmail.com with ESMTPSA id jj28-20020a170907985c00b0098d93142ce1sm4523735ejc.109.2023.07.22.21.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 21:59:39 -0700 (PDT)
Message-ID: <263fd788-dd66-412e-bd8d-0bf6319025b9@gmail.com>
Date:   Sun, 23 Jul 2023 06:59:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: add mcp4728.yaml
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1689857295.git.andrea.collamati@gmail.com>
 <9816cd272d19802ec6eeff0c7c29e85d4a0ade88.1689857295.git.andrea.collamati@gmail.com>
 <20230720-nastily-professor-3a5cae27893d@spud>
From:   Andrea Collamati <andrea.collamati@gmail.com>
In-Reply-To: <20230720-nastily-professor-3a5cae27893d@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On 7/20/23 19:01, Conor Dooley wrote:
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
> This can just be
> compatible:
>   const: microchip,mcp47288
> since you only have a single item in your enum.

I will in include in v4.

Thank you.

               Andrea

