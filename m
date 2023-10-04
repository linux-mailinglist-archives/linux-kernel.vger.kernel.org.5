Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD687B833F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243089AbjJDPL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjJDPL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:11:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7815BBD;
        Wed,  4 Oct 2023 08:11:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47565C433C7;
        Wed,  4 Oct 2023 15:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696432312;
        bh=dmLK1DKw97BO7gbbEGRFxJuTlV8DsqMHc8PPHEDaT9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tp67XPTQ0DDswas/FkM2I2UFCMZYKpolH8nNES6ctDav7ybQsBzGTDiI+jZ1auJjz
         xCAgBCjF8yTOAk0PYGxSC2CLXdybAxc8JVzKQ3y/DRwZuujl98JS3Efs4RQY+xqqQk
         uXObJTAae06II51Fy2sFC4a/GuI42XdfR1+wYHt45fQ1CByoYwir5lh9IRB/0RX8K7
         L23U1OoNzFIc03C2rcEkT2aA63TTtBCUXMAkqzI3UTGA/kDSEWC3cqj9WUbvsC5m2Q
         vfnLZI8uso4qd8epGRJTqR9FOR6pX4FL4cJkQcm09G/XanACJU0H04xymrI/W5cQJj
         Aw5PHNyq27Y4w==
Received: (nullmailer pid 3144693 invoked by uid 1000);
        Wed, 04 Oct 2023 15:11:50 -0000
Date:   Wed, 4 Oct 2023 10:11:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     werneazc@gmail.com
Cc:     jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, lars@metafoo.de, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ti,ads7038: Add description
 for ADS7038
Message-ID: <20231004151150.GA3140591-robh@kernel.org>
References: <20231004102330.3713-1-andre.werner@systec-electronic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004102330.3713-1-andre.werner@systec-electronic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 12:23:29PM +0200, werneazc@gmail.com wrote:
> From: Andre Werner <andre.werner@systec-electronic.com>
> 

Needs a commit message.

> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> ---
>  .../bindings/iio/adc/ti,ads7038.yaml          | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml
> new file mode 100644
> index 000000000000..37fbae95c8e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads7038.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ADS7038 and similar ADCs
> +
> +maintainers:
> +  - Andre Werner <andre.werner@systec-electronic.com>
> +
> +description: |
> +  Family of 7 channel, 12 bit ADCs with SPI/I2C interface.
> +  
> +  Datasheet: https://www.ti.com/lit/gpn/ads7038
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads7038
> +      - ti,ads7138
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 60000000
> +
> +  vref-supply:
> +    description: Supplies the 2.5V or 5V reference voltage

I don't see that in the datasheet. It has AVDD and DVDD.

Also, looks like there are GPIOs. Those aren't ever exposed to the OS?

> +
> +required:
> +  - compatible
> +  - reg
> +  - vref-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "ti,ads7038";
> +            reg = <0>;
> +            vref-supply = <&refin_supply>;
> +            spi-max-frequency = <10000000>;
> +        };
> +    };
> -- 
> 2.42.0
> 
