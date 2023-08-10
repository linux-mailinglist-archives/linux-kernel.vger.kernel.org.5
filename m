Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92362776EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjHJEB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjHJEBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:01:24 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7191F212A;
        Wed,  9 Aug 2023 21:01:22 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7911dfc9824so16813139f.2;
        Wed, 09 Aug 2023 21:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691640082; x=1692244882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qfEv/2Fo+kSHzF3tTfhQtWXqrqlUNwswgB4uFgdQ8k4=;
        b=n2AuO74cGnFo4N5iKw1d3ieJebw75xm8gwS48lNruZ0XjQLDSMex11+GDfss0wpBvf
         /m8oa8f2XGqgQ+KAcUGhyKvlhXWsNF+D6/TsuTWXb4S+yuVcVeCFwUzbNV7KYPv4lRbF
         YPDPuThpaKdxBRpjSF1Q9hUYjae1x3EUn2Ul/40G00lCS3y9K5UgiScHNSHeH+LUHGFd
         NeCeflHQ8mKyfRyUfX/3drYPVbuXXKmNZyIxVsn/+HXHYOobm0E61nNIrG+jLN8iB9ue
         hLSuE8pX1igEik59go6I01770geKoi8rxmKY+V4DmQVeF3ORS6oaHWeCWLCddRk6zNxV
         V/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691640082; x=1692244882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfEv/2Fo+kSHzF3tTfhQtWXqrqlUNwswgB4uFgdQ8k4=;
        b=RySBZmV58kPU9VB8Qr2CRUZiYQai48wb8oM9B2eq3+HcjtRVs8v4XkkcxKZwT73nha
         z82AZOaBAYyk0BRKv+45w+lSlQ1/3qOhRe3mck+YPXiQwaLF/PQbuaU5Yk+cz4sR6Okf
         33SdFMYwie3Ur/LIwkxDAap7SKZ7SRkqPT+7JMvXZ39aH4VReeogAzuy5JPo8ZCRqeKr
         elDidaESFOrAgxbSG0HoJuWiPzyLLVT4WT4t9WzL3FHK7l9WZdbWd59qHXLS9BfCYku6
         geA/vLWs1CzaTQ8HhsePeZUwbAa2V74S5FRNuBv2UmHZk+pc7rMdP/7TOCh6quQ2/9Wu
         ipvA==
X-Gm-Message-State: AOJu0YwrI9KQez6uVjDosO6TsE0zlaPaBNBk4D1UmYWorjl3ufqfl6FJ
        HYMcSUFZcXLOKMPK9sNTgUM=
X-Google-Smtp-Source: AGHT+IHpjxdFu7u7/tggm9kdtZl6LWdyyyeaPjGDbv78ArjWIlnrGvvpFJHXD9cnLU6QhkUtmd6hTQ==
X-Received: by 2002:a05:6e02:1bec:b0:349:3808:e387 with SMTP id y12-20020a056e021bec00b003493808e387mr1581986ilv.11.1691640081674;
        Wed, 09 Aug 2023 21:01:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cz1-20020a0566384a0100b0042b3dcb1106sm164843jab.47.2023.08.09.21.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 21:01:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 9 Aug 2023 21:01:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     krzysztof.kozlowski+dt@linaro.org,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: Add MAX6639
Message-ID: <72e9da2e-6704-4233-95d7-eb5380004127@roeck-us.net>
References: <20230803144401.1151065-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803144401.1151065-1-Naresh.Solanki@9elements.com>
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

On Thu, Aug 03, 2023 at 04:43:59PM +0200, Naresh Solanki wrote:
> From: Marcello Sylvester Bauer <sylv@sylv.io>
> 
> Add binding documentation for Maxim MAX6639 fan-speed controller.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> Changes in V3:
> - Update title
> - Add pulses-per-revolution, supplies & interrupts
> Changes in V2:
> - Update subject
> - Drop blank lines
> ---
>  .../bindings/hwmon/maxim,max6639.yaml         | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> 
> 
> base-commit: cb7022b8976e3c4d12cea2e7bb820a2944e2fd7b
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> new file mode 100644
> index 000000000000..b3292061ca58
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX6639 Fan Controller
> +
> +maintainers:
> +  - Naresh Solanki <Naresh.Solanki@9elements.com>
> +
> +description: |
> +  The MAX6639 is a 2-channel temperature monitor with dual, automatic, PWM
> +  fan-speed controller.  It monitors its own temperature and one external
> +  diode-connected transistor or the temperatures of two external diode-connected
> +  transistors, typically available in CPUs, FPGAs, or GPUs.
> +
> +  Datasheets:
> +    https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max6639
> +
> +  reg:
> +    maxItems: 1
> +
> +  fan-supply:
> +    description: Phandle to the regulator that provides power to the fan.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  pulses-per-revolution:
> +    description:
> +      Define the number of pulses per fan revolution for each tachometer
> +      input as an integer.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 3, 4]
> +    default: 2
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
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      fan-controller@10 {
> +        compatible = "maxim,max6639";
> +        reg = <0x10>;
> +      };
> +    };
> +...
