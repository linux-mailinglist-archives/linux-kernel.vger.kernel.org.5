Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAA67F9496
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 18:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjKZRaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 12:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKZRaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 12:30:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69AECB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 09:30:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52783C433C7;
        Sun, 26 Nov 2023 17:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701019810;
        bh=8ojV6a7cA9LYv/jr195EjbCuO3ivVg0awU0eg229aNI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qYz3M403eaUTi/hMjdpYXhdNYCNb5yjIPB3zQQdo5E8BaOBKrnaS1wIYN47e3De9O
         /KToXdsYSF6P+RY3Rcx50jgCbrFsdkdRhGwRMkEkjUHbTg9LU499lCaZTWv2sN0llK
         ohDzK856p14I8nseZEFqyVOQx/Z2SAkWVHmHpuAkCPlBSBle7ZXBystWWT5ac7+x+P
         bllmXWNG+hrbPGc6yHy/5qzi+pZd7PZfgSyegv8LyXgrgbfLg4xKqWGb7wsxWAKAJs
         yK6AV7Cuh9Y41aZUUcF9JS4b/fttd7BVohRrp/T6ghN4rJbOYqja2EchnOLXx9SYgk
         tSP0hOUpYy24Q==
Date:   Sun, 26 Nov 2023 17:30:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: temperature: Add AMS AS6200
Message-ID: <20231126173002.3783271f@jic23-huawei>
In-Reply-To: <7e108db19cd9ad19b6413f65099280c010325a91.1699740057.git.alkuor@gmail.com>
References: <7e108db19cd9ad19b6413f65099280c010325a91.1699740057.git.alkuor@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2023 17:05:01 -0500
Abdel Alkuor <alkuor@gmail.com> wrote:

> as6200 is high accuracy temperature sensor of -/+ 0.4C degree
> with a range between -40C to 125C degrees
> 
Hi Abdel,

Welcome to IIO.  Just one comment on specifying power supplies below.

Jonathan


> Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> ---
>  .../bindings/iio/temperature/ams,as6200.yaml  | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml b/Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml
> new file mode 100644
> index 000000000000..97a73b92a789
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/ams,as6200.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMS AS6200 Temperature Sensor
> +
> +maintainers:
> +  - Abdel Alkuor <alkuor@gmail.com>
> +
> +description: |
> +  https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
> +
> +properties:
> +  compatible:
> +    const: ams,as6200
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1

I'd like to see
vdd-supply: true
and it added to teh required list.

The device needs power. Note there is
a devm_regulator_get_enable() function that can then be used in the driver to turn
on any regulator specified in DT which will provide a stub regulator if there isn't
one (not unusual if a fixed power supply is used that is always on).

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        temperature-sensor@48 {
> +            compatible = "ams,as6200";
> +            reg = <0x48>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <17 IRQ_TYPE_EDGE_BOTH>;
> +        };
> +    };
> +...

