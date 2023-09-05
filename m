Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4BF792C94
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjIERkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239978AbjIERjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:39:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC55395DE;
        Tue,  5 Sep 2023 10:15:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14762B815B4;
        Tue,  5 Sep 2023 17:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F2FC433C7;
        Tue,  5 Sep 2023 17:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693933658;
        bh=wvydTW5tlFfjmX77STi/JFlf00/5kzHytlOiPmKMEV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uXlbNU97DMqwAC9ZNu5M7ajd6mDymvsmtCU7vrn1VzmDTcTpbt0vvMp1v641v2IQZ
         SgVsL37pQLJ/Gp4U5eQffjkCedFKhKlriLxtQAh7m7RFlWBXj13W1YVwXqPfOmfJZF
         vx1JCiQ4Ylx48/d2kHSiqhU93FzLfhAIaKFUhqGmoddtVvktDjJGF3LkiQJlVL++Q0
         1zVL4u23WIIDcAaP3kxgwZwe32m2/F5Uh6SiFLBZWOUUp8D3ZxzkN+s25HRuMfDEpX
         VwMPqEwD8llmszk0BL/HJOAZevfkwn64EsM4CTipbwOMQo+5pLTtFrkQYZhoHcNMIG
         IRFBOOwr4tiIA==
Received: (nullmailer pid 3568796 invoked by uid 1000);
        Tue, 05 Sep 2023 17:07:35 -0000
Date:   Tue, 5 Sep 2023 12:07:35 -0500
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
Subject: Re: [PATCH v8 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM TACH
 Control
Message-ID: <20230905170735.GA3528724-robh@kernel.org>
References: <20230830123202.3408318-1-billy_tsai@aspeedtech.com>
 <20230830123202.3408318-3-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830123202.3408318-3-billy_tsai@aspeedtech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 08:32:01PM +0800, Billy Tsai wrote:
> Document the compatible for aspeed,ast2600-pwm-tach device, which can
> support up to 16 PWM outputs and 16 fan tach input.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> new file mode 100644
> index 000000000000..95bac5588c04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Aspeed, Inc.

A few years out of date.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/aspeed,g6-pwm-tach.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED G6 PWM and Fan Tach controller device driver
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description: |
> +  The ASPEED PWM controller can support up to 16 PWM outputs.
> +  The ASPEED Fan Tacho controller can support up to 16 fan tach input.

Are PWM and tach channels independent? Would be useful to know here.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-pwm-tach
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +patternProperties:
> +  "^fan[0-9a-f]_hwmon+$":

Drop 'hwmon'. Standard practice for naming without 'reg' is 
'^fan-[0-9]+$'.

> +    $ref: fan-common.yaml#

       unevaluatedProperties: false

> +    required:
> +      - tach-ch
> +
> +required:
> +  - reg
> +  - clocks
> +  - resets
> +  - "#pwm-cells"
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    pwm_tach: pwm-tach-controller@1e610000 {
> +      compatible = "aspeed,ast2600-pwm-tach";
> +      reg = <0x1e610000 0x100>;
> +      clocks = <&syscon ASPEED_CLK_AHB>;
> +      resets = <&syscon ASPEED_RESET_PWM>;
> +      #pwm-cells = <3>;

Blank line.

> +      fan0_hwmon {
> +        tach-ch = <0x0>;

Don't you need 'pwms'?

> +      };

Blank line.

> +      fan1_hwmon {
> +        tach-ch = <0x1>;
> +      };
> +      fan2_hwmon {
> +        tach-ch = <0x2>;
> +      };
> +    };
> -- 
> 2.25.1
> 
