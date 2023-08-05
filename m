Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43667710FD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjHERjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHERjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:39:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D313103;
        Sat,  5 Aug 2023 10:39:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9586C60D57;
        Sat,  5 Aug 2023 17:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F29C433C8;
        Sat,  5 Aug 2023 17:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691257155;
        bh=MDSXAe8XWbnhwTQRcCe7HpqPED1RoWnoD6b8xheiylc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fGZSBsxcIX5nXyzKjSka28CLNSLhnJbtCwRKcXqetJOipPR7Q+v42goOK3NqXtkZ8
         c9vqay6aP/z8nP8Qow3TFzMonKkTjr3Y80GZL4+q/QjB5yO2dBYqYL781pXoVmn3A/
         3vqlsQj850uz9+SF7C1APCRYb3l/FjFUoRmSnXJv/1r2+92iCPEcX5ox5HPm6gv9RL
         Mf7vm0reM27++NPqrgZBq1tbnaHfTmrm/KU3nl95So9GBKXTczY3SZmpm+7DZg9Xbq
         faIrkjieDd8YzCV6WE9idXOcxtRkpGz6G+ZjmmL62UMi2zaGfDkfk90yWjo6Ap5aqx
         digNnzD+ZMOGg==
Date:   Sat, 5 Aug 2023 18:39:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <marius.cristea@microchip.com>
Cc:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Message-ID: <20230805183906.521c90b0@jic23-huawei>
In-Reply-To: <20230804142820.89593-2-marius.cristea@microchip.com>
References: <20230804142820.89593-1-marius.cristea@microchip.com>
        <20230804142820.89593-2-marius.cristea@microchip.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2023 17:28:19 +0300
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the device tree schema for iio driver for
> Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
> Delta-Sigma ADCs with an SPI interface (Microchip's
> MCP3461, MCP3462, MCP3464, MCP3461R, MCP3462R,
> MCP3464R, MCP3561, MCP3562, MCP3564, MCP3561R,
> MCP3562R and MCP3564R analog to digital converters).
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>

Given driver handles the channel label binding, nice to have
that in the example here.


> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "microchip,mcp3564r";
> +            reg = <0>;
> +            vref-supply = <&vref_reg>;
> +            spi-cpha;
> +            spi-cpol;
> +            spi-max-frequency = <10000000>;
> +            microchip,hw-device-address = <1>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            channel@0 {
> +                /* CH0 to AGND */
> +                reg = <0>;
> +            };
> +
> +            channel@1 {
> +                /* CH1 to AGND */
> +                reg = <1>;
> +            };
> +
> +            /* diff-channels */
> +            channel@11 {
> +                reg = <11>;
> +
> +                /* CN0, CN1 */
> +                diff-channels = <0 1>;
> +            };
> +
> +            channel@22 {
> +                reg = <0x22>;
> +
> +                /* CN1, CN2 */
> +                diff-channels = <1 2>;
> +            };
> +
> +            channel@23 {
> +                reg = <0x23>;
> +
> +                /* CN1, CN3 */
> +                diff-channels = <1 3>;
> +            };
> +        };
> +    };
> +...

