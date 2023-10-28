Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FB67DA7F9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 18:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjJ1QKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 12:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJ1QKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 12:10:30 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B36E5;
        Sat, 28 Oct 2023 09:10:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c87a85332bso27345895ad.2;
        Sat, 28 Oct 2023 09:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698509427; x=1699114227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/R6fybkuPrh/vemQBEtPBgOnhFZTvd3BcrWSjhKvPM=;
        b=JqJFWdSNUZsFAEJuvRxQwLKPQ1dBZRWKx2J+1iTnBwEkoi7fPGeX4vUcVpHy38uNaU
         +GL+iqHsQ7Cr1LBXKgl2XuDfteve4shD5VWkehZnr2OIUilMrB+BVzpHE4x1yC6p6FVo
         cJJ6IOGqg7lYrWx11ZqYnU1MxpHHhU4XzDpHO9Awgp2nUycNhn8CVKtKV94Q7GWXeCIG
         BSwLy4N98p5rwd68ivGW3+h6i21IXpsOqvhww+AfCC2DsoqGqPePsDt82Sg511ovla5+
         /Zckt6Hytk4hPjCU69I4noY370rkdHS4S5nBhcKH9xLgcNj+n3FBzQJm7/qbzhMYCqN0
         hJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698509427; x=1699114227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/R6fybkuPrh/vemQBEtPBgOnhFZTvd3BcrWSjhKvPM=;
        b=WSlw/SqCqLDSIDVlg0I4k2ZVV3Ph413B1WjuRUJY4oAb5CXnNgmu1CxU+VUiAFsb0R
         KdjibKXfBhcr6e1sjfPBH6kiN+76QbW9BwZKkNO5ognN2JcKh2+sH3iiyhtnQiNCsmhP
         lKv7Ux5yIgE0+yJSVTnskbEaK7J5CfP/kQtOZTkqdmWonKyEKlxEIbYjPWUmhXHKAk64
         9X+/vO6B4VhWbrP9bTei9SSXoZaldLRKPio9sTJxFBRTf8XelM8QnuJ3XIAMzGOeEg36
         Xq/nohcsYPX9oDLBp7nYGAojApiZSI6cx3W/8dyo/bGTwbzwTBMgy3RUr/guFHxdkxub
         jA9w==
X-Gm-Message-State: AOJu0YxMX17ZX9PiDyqGT5+GpsqRk1bPQU635BN+bo/yiFW89sqRK4nE
        ewu9HGCReMn4QfBzFdqnCuQ=
X-Google-Smtp-Source: AGHT+IFCxkcX/4mh5DsxzdHDuTmcmJd858zCiXe4nVTZFSwzWWRRXBEzhQe0Dfbz5jaOuSxrUbdwHg==
X-Received: by 2002:a17:903:1104:b0:1ca:29f:4b06 with SMTP id n4-20020a170903110400b001ca029f4b06mr7452678plh.2.1698509427112;
        Sat, 28 Oct 2023 09:10:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709026e0200b001c746b986e5sm3482443plk.45.2023.10.28.09.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 09:10:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 28 Oct 2023 09:10:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: ltc2991: add bindings
Message-ID: <842c0616-f635-4443-99b6-c7b47ab145fb@roeck-us.net>
References: <20231026103413.27800-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026103413.27800-1-antoniu.miclaus@analog.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 01:33:12PM +0300, Antoniu Miclaus wrote:
> Add dt-bindings for ltc2991 octal i2c voltage, current and temperature
> monitor.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

Thanks,
Guenter

> ---
> no changes in v5.
>  .../bindings/hwmon/adi,ltc2991.yaml           | 128 ++++++++++++++++++
>  1 file changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
> new file mode 100644
> index 000000000000..011e5b65c79c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
> @@ -0,0 +1,128 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/adi,ltc2991.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices LTC2991 Octal I2C Voltage, Current and Temperature Monitor
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  The LTC2991 is used to monitor system temperatures, voltages and currents.
> +  Through the I2C serial interface, the eight monitors can individually measure
> +  supply voltages and can be paired for differential measurements of current
> +  sense resistors or temperature sensing transistors.
> +
> +  Datasheet:
> +    https://www.analog.com/en/products/ltc2991.html
> +
> +properties:
> +  compatible:
> +    const: adi,ltc2991
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  vcc-supply: true
> +
> +patternProperties:
> +  "^channel@[0-3]$":
> +    type: object
> +    description:
> +      Represents the differential/temperature channels.
> +
> +    properties:
> +      reg:
> +        description:
> +          The channel number. LTC2991 can monitor 4 currents/temperatures.
> +        items:
> +          minimum: 0
> +          maximum: 3
> +
> +      shunt-resistor-micro-ohms:
> +        description:
> +          The value of curent sense resistor in micro ohms. Pin configuration is
> +          set for differential input pair.
> +
> +      adi,temperature-enable:
> +        description:
> +          Enables temperature readings. Pin configuration is set for remote
> +          diode temperature measurement.
> +        type: boolean
> +
> +    required:
> +      - reg
> +
> +    allOf:
> +      - if:
> +          required:
> +            - shunt-resistor-micro-ohms
> +        then:
> +          properties:
> +            adi,temperature-enable: false
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - vcc-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        hwmon@48 {
> +            compatible = "adi,ltc2991";
> +            reg = <0x48>;
> +            vcc-supply = <&vcc>;
> +        };
> +    };
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        hwmon@48 {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            compatible = "adi,ltc2991";
> +            reg = <0x48>;
> +            vcc-supply = <&vcc>;
> +
> +            channel@0 {
> +                    reg = <0x0>;
> +                    shunt-resistor-micro-ohms = <100000>;
> +            };
> +
> +            channel@1 {
> +                    reg = <0x1>;
> +                    shunt-resistor-micro-ohms = <100000>;
> +            };
> +
> +            channel@2 {
> +                    reg = <0x2>;
> +                    adi,temperature-enable;
> +            };
> +
> +            channel@3 {
> +                    reg = <0x3>;
> +                    adi,temperature-enable;
> +            };
> +        };
> +    };
> +...
