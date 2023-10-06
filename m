Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125637BB697
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjJFLj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjJFLj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:39:26 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC8BDB;
        Fri,  6 Oct 2023 04:39:24 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 396Bd6On066274;
        Fri, 6 Oct 2023 06:39:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696592346;
        bh=RShf9vWYlA28WSj9vvaz773dgfGwV29iK3mMXjvsR14=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xTt+yRkcNvnmZzk6xcZ0qa3KOBCt0VlW+m5sDVE3fzZAc7cFXmccg9UoNOW47qGj9
         7a96KCSgflQcBi3qlUb4SS+d/bzIRWd0G2m75oMfJaFalywtZv3edIj7zKouFWU6Ei
         +Do0xVMe35wP1iAE6xRduMUaKr8e8LZgIOvSuEm0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 396Bd6Iu003541
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Oct 2023 06:39:06 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Oct 2023 06:39:05 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Oct 2023 06:39:05 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 396Bd506028492;
        Fri, 6 Oct 2023 06:39:05 -0500
Date:   Fri, 6 Oct 2023 06:39:05 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Ayush Singh <ayushdevel1325@gmail.com>
CC:     <greybus-dev@lists.linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <vaishnav@beagleboard.org>, <jkridner@beagleboard.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 1/3] dt-bindings: net: Add ti,cc1352p7
Message-ID: <20231006113905.a7xhcjisgomfj7dk@banknote>
References: <20231006041035.652841-1-ayushdevel1325@gmail.com>
 <20231006041035.652841-2-ayushdevel1325@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231006041035.652841-2-ayushdevel1325@gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:40-20231006, Ayush Singh wrote:
> Add DT bindings for Texas Instruments Simplelink CC1352P7 wireless MCU
> 
> BeaglePlay has CC1352P7 co-processor connected to the main AM62 (running
> Linux) over UART. In the BeagleConnect Technology, CC1352 is responsible
> for handling 6LoWPAN communication with beagleconnect freedom nodes as
> well as their discovery.
> 
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> ---

very minor comments follow:

>  .../devicetree/bindings/net/ti,cc1352p7.yaml  | 51 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> new file mode 100644
> index 000000000000..742763e04543
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> @@ -0,0 +1,51 @@
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
 s/cc1352p7/CC1352P7
 s/mcu/MCU

> +
> +maintainers:
> +  - Ayush Singh <ayushdevel1325@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: ti,cc1352p7
> +
> +  clocks:
> +    items:
> +      - description: main system (mcu and peripherals) clock
s/mcu/MCU
also I'd call it high-frequency clock to give explanation of what "hf"
means.

> +      - description: low-frequency system clock
> +
> +  clock-names:
> +    items:
> +      - const: sclk_hf
> +      - const: sclk_lf
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  vdds-supply: true
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
> +        clock-names = "sclk_hf", "sclk_lf";
> +        reset-gpios = <&pio 35 GPIO_ACTIVE_LOW>;
> +        vdds-supply = <&vdds>;
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

With those minor comments (if there is a need for a respin):

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
