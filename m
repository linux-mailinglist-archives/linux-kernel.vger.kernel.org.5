Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80B47B67E5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239912AbjJCLaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjJCLac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:30:32 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80E6A1;
        Tue,  3 Oct 2023 04:30:28 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 393BUHjf096934;
        Tue, 3 Oct 2023 06:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696332617;
        bh=N5ZztSjzf9OfIIVeBtDwEBQrwZRy6ntL0AONwTZqnXw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=mIM4nmepfnBsiBPoQGZMKtED0Id5K9QGTYM5QBcs19bqIrdApWtG8xJ9TF66WyjlU
         KWKdEghFAJU71LY0ZTk1QiDESv7KVi9PDdDx8Fnzo2vYigwzZrqHQ0uUoNvixrV5rY
         IRSzIAv3YY1oJC/7XjsuxaJ6544GwKzq57tGAWLo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 393BUHf9015649
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Oct 2023 06:30:17 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 06:30:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 06:30:17 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 393BUHiB023243;
        Tue, 3 Oct 2023 06:30:17 -0500
Date:   Tue, 3 Oct 2023 06:30:17 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Ayush Singh <ayushdevel1325@gmail.com>
CC:     <greybus-dev@lists.linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <vaishnav@beagleboard.org>, <jkridner@beagleboard.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 1/3] dt-bindings: Add beaglecc1352
Message-ID: <20231003113017.z3yyjscvvinwnyy7@putdown>
References: <20231002182454.211165-1-ayushdevel1325@gmail.com>
 <20231002182454.211165-2-ayushdevel1325@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231002182454.211165-2-ayushdevel1325@gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23:54-20231002, Ayush Singh wrote:
> Add DT bindings for BeaglePlay CC1352 co-processor.
> 
> The BeaglePlay has a CC1352 co-processor. This co-processor is connected
> to the main AM62 (running Linux) over UART. In the BeagleConnect
> Technology, CC1352 is responsible for handling 6LoWPAN communication
> with beagleconnect freedom nodes as well as their discovery
> 
> This commit adds net/ti,cc1352p7. It is used by gb-beagleplay greybus
> driver.
> 
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> ---
>  .../devicetree/bindings/net/ti,cc1352p7.yaml  | 48 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> new file mode 100644
> index 000000000000..57bc2c43e5b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/ti,cc1352p7.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments Simplelink CC1352P7 wireless MCU
> +
> +description:
> +  The cc1352p7 mcu can be connected via SPI or UART.
> +
> +maintainers:
> +  - Ayush Singh <ayushdevel1325@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: ti,cc1352p7
> +
> +  clocks:
> +    maxItems: 2

I would suggest clock-names and description for it.

> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  power-gpios:
> +    maxItems: 3
> +    description:
> +      The device has three power rails that are exposed on external pins VDDS,
> +      VDDR and DCOUPL.

Shouldn't these be regulators? The power rails are input to the MCU,
correct?
The properties should be something like:
vdds-supply
vddr-supply
dcoupl-supply ? (not sure what dcoupl is, but description should provide
		that info).

the gpio controls for those can be modelled by regulator-gpio ?

> +
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    serial {
> +      mcu {
> +        compatible = "ti,cc1352p7";
> +        clocks = <&sclk_hf 0>, <&sclk_lf 25>;
> +        reset-gpios = <&pio 35 GPIO_ACTIVE_LOW>;
> +        power-gpios = <&pio 1 GPIO_ACTIVE_HIGH>, <&pio 2 GPIO_ACTIVE_HIGH>, <&pio 3 GPIO_ACTIVE_HIGH>;
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 37b9626ee654..5467669d7963 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8969,6 +8969,12 @@ F:	drivers/staging/greybus/sdio.c
>  F:	drivers/staging/greybus/spi.c
>  F:	drivers/staging/greybus/spilib.c
>  
> +GREYBUS BEAGLEPLAY DRIVERS
> +M:	Ayush Singh <ayushdevel1325@gmail.com>
> +L:	greybus-dev@lists.linaro.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> +
>  GREYBUS SUBSYSTEM
>  M:	Johan Hovold <johan@kernel.org>
>  M:	Alex Elder <elder@kernel.org>
> -- 
> 2.41.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
