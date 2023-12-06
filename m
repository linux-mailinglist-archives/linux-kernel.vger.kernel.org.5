Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC897807AC5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377261AbjLFVuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjLFVuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:50:13 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D869E8F;
        Wed,  6 Dec 2023 13:50:18 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b9d2b8c3c6so202925b6e.1;
        Wed, 06 Dec 2023 13:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701899418; x=1702504218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEnrg1KlYR6vf/zDP0yzao4X3UI09Y6k9tq3wxu2Hyk=;
        b=jQ39/hVKGkpq7jOKtOB/YLWL7yjPN/spVP3CjlPoPpeTdCo6ZLY8iKhTx3p7bJzD6I
         ma+dOp8xa8x6J+pRergvvj5HjqnL0Sj9VMLUVbn3eSdcGVqY45R5F+2R0XX4/VmJXNN3
         YzL/bJMPnlLB02g+9hJjSzkkTepFyxRxM/rhmhdEZdYPPnGRhQBGOmkW6PXgzSiHJakZ
         Bi+XnCNt66qZdhizuwirpDMsl6CnCwc0fV8KKp+gqU8A1O8ACpl6e+mbRlb4dy8Vd/SX
         cHUFUBQjUC5zaccgUGV6MD36YF37V1RnT2oJUPCiTbsn6s51Qoq97Rwl3mb2tEZNE5CI
         tUTQ==
X-Gm-Message-State: AOJu0YyQONmZ2shU3q/s7eKZotzohhz2TKbKTM963Ump2S7KUB2Jsu9+
        9e2xkLHNJR+MhcRaG7ta6Q==
X-Google-Smtp-Source: AGHT+IERHoALlq7OdHIXZ4O4/+rMxWVHFWkvKbTfFzryW2OMoqqku1HaTGIob5AKzzHZ6T1m0WhzTw==
X-Received: by 2002:a05:6808:209d:b0:3b8:b063:8247 with SMTP id s29-20020a056808209d00b003b8b0638247mr1940169oiw.73.1701899418101;
        Wed, 06 Dec 2023 13:50:18 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n22-20020a9d6f16000000b006d87f95566bsm119111otq.51.2023.12.06.13.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:50:17 -0800 (PST)
Received: (nullmailer pid 3384012 invoked by uid 1000);
        Wed, 06 Dec 2023 21:50:16 -0000
Date:   Wed, 6 Dec 2023 15:50:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: arm: hwmon: gpio-fan: Convert txt
 bindings to yaml
Message-ID: <20231206215016.GA3379159-robh@kernel.org>
References: <20231202222934.137191-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202222934.137191-1-david@ixit.cz>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 11:29:00PM +0100, David Heidelberg wrote:
> Convert fan devices connected to GPIOs to the YAML syntax.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../devicetree/bindings/hwmon/gpio-fan.txt    | 41 -----------
>  .../devicetree/bindings/hwmon/gpio-fan.yaml   | 70 +++++++++++++++++++
>  2 files changed, 70 insertions(+), 41 deletions(-)
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
> index 000000000000..0e220874bee6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> @@ -0,0 +1,70 @@
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
> +    gpio_fan {
> +      compatible = "gpio-fan";
> +      gpios = <&gpio1 14 1
> +               &gpio1 13 1>;
> +      gpio-fan,speed-map = <    0 0>,
> +                           < 3000 1>,
> +                           <36000 2>;
> +      alarm-gpios = <&gpio1 15 1>;
> +    };
> +  - |
> +    gpio_fan_cool: gpio_fan {

Drop unused labels.

> +      compatible = "gpio-fan";
> +      gpios = <&gpio2 14 1
> +               &gpio2 13 1>;
> +      gpio-fan,speed-map = <   0 0>,
> +                           <3000 1>,
> +                           <6000 2>;
> +      alarm-gpios = <&gpio2 15 1>;
> +      #cooling-cells = <2>; /* min followed by max */
> +    };

Not really much difference in the 2 examples. Drop the first one 
(having fewer properties).

Rob
