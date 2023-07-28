Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9ACF7666CC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbjG1IT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjG1ITJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:19:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D847E1BC6;
        Fri, 28 Jul 2023 01:19:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 634A062046;
        Fri, 28 Jul 2023 08:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCACC433C8;
        Fri, 28 Jul 2023 08:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690532341;
        bh=fi+a2t7tNdwyL0bBeVh7ZcTqwoG6vf1Wbk6bUaq+pLc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AtjGgYEAp+/8NgBK9Vt9i/NstWExo712ZM4PRxLAXz+yMXci14VaBM555GppP8SWM
         nSnm8b+KUfTZcEeZEg69EpQqnbfKRCiU0D65eygmQSlyyDWFZFWuT+Iy37SmWFCneN
         xlsHeRiip7ODldMLdmA6E1goHgoLp+zKTqSRAIdG7u0oKUe7O2butxJ3paF/d05tVN
         xzjARnEXcifNHk7SdOG+IAFPW/8xdtzKjXYL9rw7J4R4QL051WLdwaUiyHgIInzqqu
         GOqqKjgolWMNzTojYe+LTdEttPWoEcR4PSU0Z4MCpu2ilkrwLYpf0ECDZCsOitNjQs
         9jvMF3qAmrzLA==
Message-ID: <7dea9abf-4ab4-55ec-5a00-829840b221c2@kernel.org>
Date:   Fri, 28 Jul 2023 10:18:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] media: dt-bindings: imx519: Add IMX519 DT bindings
Content-Language: en-US
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Lee Jackson <lee.jackson@arducam.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        kieran.bingham@ideasonboard.com,
        Marco Felsch <m.felsch@pengutronix.de>,
        jacopo.mondi@ideasonboard.com
References: <20230727154108.308320-1-umang.jain@ideasonboard.com>
 <20230727154108.308320-2-umang.jain@ideasonboard.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230727154108.308320-2-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 17:41, Umang Jain wrote:
> From: Lee Jackson <lee.jackson@arducam.com>
> 
> Add YAML device tree binding documentation for IMX519 CMOS
> image sensor.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC (and consider --no-git-fallback argument). It might
happen, that command when run on an older kernel, gives you outdated
entries. Therefore please be sure you base your patches on recent Linux
kernel.

> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  .../bindings/media/i2c/sony,imx519.yaml       | 113 ++++++++++++++++++

A nit, subject: drop second/last, redundant "DT bindings". The
"dt-bindings" prefix is already stating that these are bindings.

>  1 file changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml
> new file mode 100644
> index 000000000000..6f38b09890d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml
> @@ -0,0 +1,113 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/imx519.yaml#

Please test.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sony 1/2.5-Inch 16Mpixel CMOS Digital Image Sensor
> +
> +maintainers:
> +  - Lee Jackson <lee.jackson@arducam.com>
> +
> +description: |-
> +  The Sony IMX519 is a 1/2.5-inch CMOS active pixel digital image sensor
> +  with an active array size of 4656H x 3496V. It is programmable through
> +  I2C interface. The I2C address is fixed to 0x1A as per sensor data sheet.
> +  Image data is sent through MIPI CSI-2, which is configured as either 2 or
> +  4 data lanes.
> +
> +properties:
> +  compatible:
> +    const: sony,imx519
> +
> +  reg:
> +    description: I2C device address

Drop description, it's obvious.

> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  VDIG-supply:

lowercase

> +    description:
> +      Digital I/O voltage supply, 1.05 volts
> +
> +  VANA-supply:

lowercase

> +    description:
> +      Analog voltage supply, 2.8 volts
> +
> +  VDDL-supply:

lowercase

> +    description:
> +      Digital core voltage supply, 1.8 volts
> +
> +  reset-gpios:
> +    description: |-
> +      Reference to the GPIO connected to the xclr pin, if any.
> +      Must be released (set high) after all supplies and INCK are applied.
> +
> +  # See ../video-interfaces.txt for more details
> +  port:

That's not how this is done. Open existing bindings, e.g. imx219, 258 or
any other and look. Please, do not write patches entirely different than
all other drivers/bindings. There is a reason why some things work but
other don't

> +    type: object
> +    properties:
> +      endpoint:
> +        type: object
> +        properties:
> +          data-lanes:
> +            description: |-
> +              The sensor supports either two-lane, or four-lane operation.
> +              For two-lane operation the property must be set to <1 2>.
> +            items:
> +              - const: 1
> +              - const: 2
> +
> +          clock-noncontinuous:
> +            type: boolean
> +            description: |-
> +              MIPI CSI-2 clock is non-continuous if this property is present,
> +              otherwise it's continuous.
> +
> +          link-frequencies:
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/uint64-array
> +            description:
> +              Allowed data bus frequencies.
> +
> +        required:
> +          - link-frequencies
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - VANA-supply
> +  - VDIG-supply
> +  - VDDL-supply
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c0 {

i2c

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        imx519: sensor@1a {

drop the label imx519.

Best regards,
Krzysztof

