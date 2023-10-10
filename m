Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789767BFE6B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjJJNv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjJJNvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:51:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE12115;
        Tue, 10 Oct 2023 06:51:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44E4C433C8;
        Tue, 10 Oct 2023 13:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696945881;
        bh=EpXqTphoLKu37K9NdPvllSGp61XV715UYGlavQy1hmM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ouUpsJv3gGrhyQ/2AcycBVMVM1BLgNdajK0z4aJoVCjvCcjfq3LXXlZ661XHX8m5Q
         ATnKAwdODd+KWQIHEte0mMFeqqPRA+kSwu7/1C44Ci/Kab3OOSzMV+aaG4sHjrl1E+
         6TZVM/QxDPxkhJPPydAMhoOBSCQHaDLkg16R6VS9Banse7fdooiAsgAMe5q5prVuwE
         FwAH1fp4WKNRtuBV2ORZlfR39F0ToQ9KJ5y5CU+OiJQ+b2A3E84DEXFouOtisEoLW4
         PTpXnsysSMMJf9fOh6fF2f0ChYhr8kHl+rY4kIiHJkvBiHrboWVX8hDXHDf/RsMP/F
         ZcmCoYMSlvPsg==
Date:   Tue, 10 Oct 2023 14:51:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Gazzillo <paul@pgazz.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Avago APDS9306
Message-ID: <20231010145130.3d5ff9c7@jic23-huawei>
In-Reply-To: <20231008154857.24162-2-subhajit.ghosh@tweaklogic.com>
References: <20231008154857.24162-1-subhajit.ghosh@tweaklogic.com>
        <20231008154857.24162-2-subhajit.ghosh@tweaklogic.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Oct 2023 02:18:56 +1030
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> Add devicetree bindings for Avago APDS9306 Ambient Light Sensor.
> 
> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> ---
>  .../bindings/iio/light/avago,apds9306.yaml    | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml
> new file mode 100644
> index 000000000000..e8bb897782fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/avago,apds9306.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Avago APDS9306 Ambient Light Sensor
> +
> +maintainers:
> +  - Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> +
> +description:
> +  Datasheet at https://docs.broadcom.com/doc/AV02-4755EN
> +
> +properties:
> +  compatible:
> +    const: avago,apds9306
> +
> +  reg:
> +    maxItems: 1
> +
> +  vin-supply:
> +    description: Regulator supply to the sensor

Why vin?  It seems to be vdd on the datasheet.
We tend to match the datasheet naming for power supplies as that is normally
what is seen on circuit board schematics.


> +
> +  interrupts:
> +    maxItems: 1
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
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        light-sensor@52 {
> +            compatible = "avago,apds9306";
> +            reg = <0x52>;
> +            interrupt-parent = <&gpiof>;
> +            interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
> +        };
> +    };
> +...

