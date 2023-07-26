Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E12F763C28
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjGZQQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjGZQQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:16:24 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0204726A8;
        Wed, 26 Jul 2023 09:16:18 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3461163c0b6so37727495ab.2;
        Wed, 26 Jul 2023 09:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690388178; x=1690992978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QxZ9c2bp3CuxoSR+aGIpzxjqwq5Taob+y5juqu6C380=;
        b=fHG4e8YEkfo2hCaYEp+MWN/Tjr4PJgK6Nz2cnuHcBaUUBFmN4fP0iKYtQfYD/14MU+
         WAeAWBQ3YeNRlNb54N/NMP2ONPKMACzn9R3wj5oHe34LgO4vH0U8bI6w+A4NyGyBjPIu
         4UwbDUDo49VdxZvzj3IEBjSmUy/Jq1RA2q5nsFBBqVLwDcQuacOHIZvuyqpC6qOw9RDd
         /522cutveGfKQxSzvQYHDLHF7nc6YB+ER1e0/7TnaetZAQW14n/JG2nBAKJ7ckXvh2Me
         nsQ68wzT7HOnPhax/eGVttQry52ZH58YhEYA0bc/4Zkz6My5KWDhv2674A2k7nrKUVuL
         KcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690388178; x=1690992978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxZ9c2bp3CuxoSR+aGIpzxjqwq5Taob+y5juqu6C380=;
        b=AprYXHSU/N491sIWEnuUSU0P5pwulBrlBnMrd6ZmVHDhtpdgZZ9RiU8pc+yp5dYR2H
         qON3HxqvnUv1NnLLaTXq7rcB2guH7JkS1T41vfRXG3sz12d0Jir5xczG18Ck0R7PyZRI
         Xp9+WJp/PkoQ/DjiKPksOpyjN3iqt2TJ4Nbw8mx11f8AGYxNBOcjOx1jf7zRfD2UfmU8
         JRjURarzXNfzNwz64RyEnx9cE4N2V62ue6/v6dPQogN7zqE8BvT5Q5UJhqKlEN2qTaRZ
         mhg+cDu6tkDzUnsZHKZWCkCEv6phvoNDTBFLN4gultfyH8u4SVebvYfdJkX2eoXHrsGX
         bWJQ==
X-Gm-Message-State: ABy/qLbpmkBSI1hUQFZejnmJdiZwM1+SJWGaN/sVgf3OlcOr0K9EmOXJ
        8lnNu6MgmHd2qgYIHTuzGxA=
X-Google-Smtp-Source: APBJJlEp9Mnhsrk/vbd3sxc86lLCJQRy6tFN8Q0KMRjC7MUOpdzCothF98Xkf4mR3W49hmiOHu9uzw==
X-Received: by 2002:a05:6e02:1050:b0:345:d6d4:f9f3 with SMTP id p16-20020a056e02105000b00345d6d4f9f3mr2124185ilj.17.1690388178145;
        Wed, 26 Jul 2023 09:16:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u7-20020a92da87000000b00345d00dc3fdsm4512250iln.78.2023.07.26.09.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 09:16:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f8fdc8d7-6ac5-5e20-10ef-7417d79c1b91@roeck-us.net>
Date:   Wed, 26 Jul 2023 09:16:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: add renesas,isl28022
Content-Language: en-US
To:     =?UTF-8?Q?Carsten_Spie=c3=9f?= <mail@carsten-spiess.de>,
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
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230726152235.249569-3-mail@carsten-spiess.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 08:22, Carsten Spieß wrote:
> Add dt-bindings for Renesase ISL28022 power monitor.
> 
> Signed-off-by: Carsten Spieß <mail@carsten-spiess.de>
> ---
>   .../bindings/hwmon/renesas,isl28022.yaml      | 67 +++++++++++++++++++
>   MAINTAINERS                                   |  1 +
>   2 files changed, 68 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml b/Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml
> new file mode 100644
> index 000000000000..5ecf892db269
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/renesas,isl28022.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas ISL28022 power monitor
> +
> +maintainers:
> +  - Carsten Spieß <mail@carsten-spiess.de>
> +
> +description: |
> +  The ISL28022 is a power monitor with I2C interface. The device monitors
> +  voltage, current via shunt resistor and calculated power.
> +
> +  Datasheets:
> +    https://www.renesas.com/us/en/www/doc/datasheet/isl28022.pdf
> +
> +Required properties:
> +  compatible:
> +    enum:
> +      - renesas,isl28022
> +
> +  reg:
> +    maxItems: 1
> +
> +Optional properties:
> +  shunt-resistor-micro-ohms:
> +    description:
> +      Shunt resistor value in micro-Ohm
> +      defaults to <0> when not set
> +      monitoring of current and power not supported when <0>
> +

Should not default to 0 (disabled).

> +  shunt-gain:
> +    description:
> +      Shunt gain to scale maximal shunt voltage to
> +      40mV, 80mV, 160mV, 320mV
> +      defaults to <8> (320mV) when not set
> +    enum: [1, 2, 4, 8]
> +
> +  average:
> +    description: |
> +      Number of samples to be used to report voltage, current and power values.
> +      defaults to <0> when not set
> +    enum: [0, 1, 2, 4, 8, 16, 32, 64, 128]

Should not default to 0 (disabled).

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        power-monitor@40 {
> +            compatible = "renesas,isl28022";
> +            reg = <0x10>;
> +            shunt-resistor-micro-ohms = <8000>;
> +            shunt-gain = <1>;
> +            average = <128>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c61aa688cd11..ec9b97ace50b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11076,6 +11076,7 @@ ISL28022 HARDWARE MONITORING DRIVER
>   M:	Carsten Spieß <mail@carsten-spiess.de>
>   L:	linux-hwmon@vger.kernel.org
>   S:	Maintained
> +F:	Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml
>   F:	Documentation/hwmon/isl28022.rst
>   F:	drivers/hwmon/isl28022.c
>   

