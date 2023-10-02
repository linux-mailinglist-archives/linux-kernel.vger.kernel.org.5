Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DF97B566E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbjJBPXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237877AbjJBPXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:23:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880E4D8;
        Mon,  2 Oct 2023 08:23:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0BCC433C7;
        Mon,  2 Oct 2023 15:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696260226;
        bh=J31MH8/2r2BMfbJUBh+R459Cp6pdTI0Bsk+3NWVzrsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hPStttAfTWc+lyohHbX38wiESvCZgMH8ITKZQzHcHdm8G7UCp7Q5ImGYlldQGDmwi
         JIh2c8/pTqJ9a5pQ3NhFY5MyAysWRzFmSLK7X6uevHewo8kIHvFqKI3FTqgCgMsYXe
         tsrNuodOO+IXVlt+OKJEsk+m2tAC3V5suY4SDpR6BRTAfxHVR4q3imCOiGoVS5Lh5G
         yl9Gr2QCptI3ctd6eYSpy9H/998tREUU18ydMG1t2acp89rKMAtxzSXe5yZ8IFFyMG
         SK15YA+ffl5SMze3JNikC4t3pYswRTXVrWrQ9z/bqAf/vDpvm3RhKRBW+PJ319123s
         w4RiwFX/fxsdw==
Received: (nullmailer pid 1752918 invoked by uid 1000);
        Mon, 02 Oct 2023 15:23:43 -0000
Date:   Mon, 2 Oct 2023 10:23:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        corbet@lwn.net, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, p.zabel@pengutronix.de,
        naresh.solanki@9elements.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
        BMC-SW@aspeedtech.com, patrick@stwcx.xyz
Subject: Re: [PATCH v9 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Message-ID: <20231002152343.GA1747496-robh@kernel.org>
References: <20230918064111.2221594-1-billy_tsai@aspeedtech.com>
 <20230918064111.2221594-2-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918064111.2221594-2-billy_tsai@aspeedtech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 02:41:09PM +0800, Billy Tsai wrote:
> From: Naresh Solanki <naresh.solanki@9elements.com>
> 
> Add common fan properties bindings to a schema.
> 
> Bindings for fan controllers can reference the common schema for the
> fan
> 
> child nodes:
> 
>   patternProperties:
>     "^fan@[0-2]":
>       type: object
>       $ref: fan-common.yaml#
>       unevaluatedProperties: false
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../devicetree/bindings/hwmon/fan-common.yaml | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> new file mode 100644
> index 000000000000..2bd2f57fc9d9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common Fan Properties
> +
> +maintainers:
> +  - Naresh Solanki <naresh.solanki@9elements.com>
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +properties:
> +  max-rpm:
> +    description:
> +      Max RPM supported by fan.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 100000
> +
> +  min-rpm:
> +    description:
> +      Min RPM supported by fan.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 1000
> +
> +  pulses-per-revolution:
> +    description:
> +      The number of pulse from fan sensor per revolution.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 4
> +
> +  tach-div:
> +    description:
> +      Divisor for the tach sampling clock, which determines the sensitivity of the tach pin.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  target-rpm:
> +    description:
> +      The default desired fan speed in RPM.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  fan-driving-mode:
> +    description:
> +      Select the driving mode of the fan.(DC, PWM and so on)
> +    $ref: /schemas/types.yaml#/definitions/uint32

What value corresponds to what mode? I'd do strings instead. 'dc', 
'pwm', etc.

> +
> +  pwms:
> +    description:
> +      PWM provider.
> +    maxItems: 1
> +
> +  "#cooling-cells":
> +    const: 2
> +
> +  cooling-levels:
> +    description: |

Don't need '|'

> +      The control value which correspond to thermal cooling states.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  tach-ch:
> +    description:
> +      The tach channel used for the fan.
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +
> +  label:
> +    description:
> +      Optional fan label
> +
> +  fan-supply:
> +    description:
> +      Power supply for fan.
> +
> +  reg:
> +    maxItems: 1
> +
> +additionalProperties: true
> +
> +...
> -- 
> 2.25.1
> 
