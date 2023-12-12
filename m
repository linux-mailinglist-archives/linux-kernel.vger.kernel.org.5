Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A55E80F8B8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377490AbjLLUyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377407AbjLLUya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:54:30 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9074E269D;
        Tue, 12 Dec 2023 12:53:52 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d076ebf79cso37316155ad.1;
        Tue, 12 Dec 2023 12:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702414431; x=1703019231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3V74bFEqDGnRxMz9mRGbdIBTf3xxTDlfaM2RqnpzVY=;
        b=U95j3ji7JJQ1LFz17ga+ozhK0N8zeQmVhvYHUPZbgZBVJ3exlaPuuq/0inew2r8G4s
         JT6MzXG2I/tgIYl+cSdZ/2/z6HfBnjuEZKkMi3H5lSbPtCI2D64efvtP/wgpeZetDZML
         fMYFTvoCeuSwJOQ7Jr1nCAIhs3gMgy9FRMOToZPlOmjjNy91HDxX6eqeQd4qNc89qEkD
         sy15Yr7CGOD2HZLJ2UnPSCVGXyFv50ucu40ON6a5ghepKVl7wX2FGSbx9Q1AZfHq7VAN
         RgxEiXvdGNkHA2fFOLTCix8E3ztnlTrAdygG3dM9e53Cps8aqQE+RqB397dGRf9XugK4
         QkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414431; x=1703019231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3V74bFEqDGnRxMz9mRGbdIBTf3xxTDlfaM2RqnpzVY=;
        b=Olz/tVWa6ImN7XI+3jpoiD+JnsqM9iXiL4wQPexrtI48zaeQOnx1pHweRwDOld3uw9
         Lm2NlI95AQtKILDss1wsZco3b3RwQvlxeDCTHpxIi/g1NEj/H0kh1w7sFZ3h5LqUWTMW
         kQ5Q4/TdVfvD6yN6Uzww+4Sv6PknHKw5YDdxj6AdO1dOeJ5RL4YVl9eZPZ/SHFcfluin
         6XdFoiu1pb0kx+vd/oZIp3zrmtaR+CqFUN8cu/rRVYf/gmhzjB1WKl0a7I3CsGnyeDWh
         fPW/xPVUAinj3nWECSnMtn1k1MAs20XW3oABitgQ6qQRhMnmuRwfZljhiz6PkvU7APGq
         9O6Q==
X-Gm-Message-State: AOJu0YyrUu8MSZCRfSANmzsj6WTM3d+9ke2eePn7yua3wgfjQcvgfR8z
        cjURpA/PGEx8mKU9cstIOVI=
X-Google-Smtp-Source: AGHT+IHiXmz/AN2QPmRWW+z4CB5Jj58em8D2Nt4dCM9exP3M/rZIEjMQySTJDZnTZfQGYzpOWNqZwA==
X-Received: by 2002:a17:902:eb86:b0:1d0:92a0:492a with SMTP id q6-20020a170902eb8600b001d092a0492amr4162291plg.85.1702414431330;
        Tue, 12 Dec 2023 12:53:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902748300b001d345b87df3sm732961pll.184.2023.12.12.12.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 12:53:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 12 Dec 2023 12:53:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Heidelberg <david@ixit.cz>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: arm: hwmon: gpio-fan: Convert txt
 bindings to yaml
Message-ID: <98291877-9648-4f5e-b8fc-536468afa68e@roeck-us.net>
References: <20231209171653.85468-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209171653.85468-1-david@ixit.cz>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2023 at 06:15:39PM +0100, David Heidelberg wrote:
> Convert fan devices connected to GPIOs to the YAML syntax.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

Thanks,
Guenter

> ---
> v4:
>  - dropped the 1st example
>  - dropped unused label in 2nd example (now 1st example)
> 
>  .../devicetree/bindings/hwmon/gpio-fan.txt    | 41 -------------
>  .../devicetree/bindings/hwmon/gpio-fan.yaml   | 60 +++++++++++++++++++
>  2 files changed, 60 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/gpio-fan.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt b/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
> deleted file mode 100644
> index f4cfa350f6a1..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -Bindings for fan connected to GPIO lines
> -
> -Required properties:
> -- compatible : "gpio-fan"
> -
> -Optional properties:
> -- gpios: Specifies the pins that map to bits in the control value,
> -  ordered MSB-->LSB.
> -- gpio-fan,speed-map: A mapping of possible fan RPM speeds and the
> -  control value that should be set to achieve them. This array
> -  must have the RPM values in ascending order.
> -- alarm-gpios: This pin going active indicates something is wrong with
> -  the fan, and a udev event will be fired.
> -- #cooling-cells: If used as a cooling device, must be <2>
> -  Also see:
> -  Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> -  min and max states are derived from the speed-map of the fan.
> -
> -Note: At least one the "gpios" or "alarm-gpios" properties must be set.
> -
> -Examples:
> -
> -	gpio_fan {
> -		compatible = "gpio-fan";
> -		gpios = <&gpio1 14 1
> -			 &gpio1 13 1>;
> -		gpio-fan,speed-map = <0    0
> -				      3000 1
> -				      6000 2>;
> -		alarm-gpios = <&gpio1 15 1>;
> -	};
> -	gpio_fan_cool: gpio_fan {
> -		compatible = "gpio-fan";
> -		gpios = <&gpio2 14 1
> -			 &gpio2 13 1>;
> -		gpio-fan,speed-map =	<0    0>,
> -					<3000 1>,
> -					<6000 2>;
> -		alarm-gpios = <&gpio2 15 1>;
> -		#cooling-cells = <2>; /* min followed by max */
> -	};
> diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml b/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> new file mode 100644
> index 000000000000..7f30cfc87350
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/gpio-fan.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Fan connected to GPIO lines
> +
> +maintainers:
> +  - Rob Herring <robh@kernel.org>
> +
> +properties:
> +  compatible:
> +    const: gpio-fan
> +
> +  gpios:
> +    description: |
> +      Specifies the pins that map to bits in the control value,
> +      ordered MSB-->LSB.
> +    minItems: 1
> +    maxItems: 7
> +
> +  alarm-gpios:
> +    maxItems: 1
> +
> +  gpio-fan,speed-map:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    minItems: 2
> +    maxItems: 127
> +    items:
> +      items:
> +        - description: fan speed in RPMs
> +        - description: control value
> +    description: |
> +      A mapping of possible fan RPM speeds and the
> +      control value that should be set to achieve them. This array
> +      must have the RPM values in ascending order.
> +
> +  '#cooling-cells':
> +    const: 2
> +
> +required:
> +  - compatible
> +  - gpios
> +  - gpio-fan,speed-map
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    gpio-fan {
> +      compatible = "gpio-fan";
> +      gpios = <&gpio2 14 1
> +               &gpio2 13 1>;
> +      gpio-fan,speed-map = <   0 0>,
> +                           <3000 1>,
> +                           <6000 2>;
> +      alarm-gpios = <&gpio2 15 1>;
> +      #cooling-cells = <2>; /* min followed by max */
> +    };
