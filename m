Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53DA7E5D16
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 19:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjKHSVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 13:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjKHSVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 13:21:40 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6404ED4F;
        Wed,  8 Nov 2023 10:21:38 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ce2cf67be2so4300335a34.2;
        Wed, 08 Nov 2023 10:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699467697; x=1700072497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8YDEMLMN/UPwuHPhRNHU6MkX7vnIvjMYf9zFqGmA3g=;
        b=X2SdbRg0il2O4Perq5BRn9QXzs/ucXLuNAhMbAib+hqb9+OpmK2YQyNjFSTtjen5FO
         eFEWuHBlgkU5lvQrBW2QsIlh5T9ePLvHD8p4xgj/Lh3ufLEPkIHyb2aoa62MU3PaR4aY
         Jt/2uzh10mDZDO/zDP90G0eMf5WyYQQrxnVZBt8pUVGPu/3FNDsYINY9bMakuQQozT0w
         a7wJK/vZ5VaoMaFhpxb+LCxILZvijnWTV/T69MMxiEvEzwoItr3Betl/5TmzMjuA9pO/
         ku3mNxYAM9I9IfykAzUO/mdF7bSLgHt6PqPud9QCh9r+8OaZ+mpbqG5PLb6nzx5pE3bl
         FGWw==
X-Gm-Message-State: AOJu0Yybz8/58MZqyK6SB6p3vwL0vRxD/Teiluh0ilG7G7oSzXew0v6b
        uaLciGZ5dQourXiZaJ8pfw==
X-Google-Smtp-Source: AGHT+IH936tksBL7gMvhFH0Cu8Ga+1XdgbOvw2iCgQmNwYAwBNf4BgvoX3nEqEXZcFtRnb72jnyg2w==
X-Received: by 2002:a9d:4801:0:b0:6d3:194f:f132 with SMTP id c1-20020a9d4801000000b006d3194ff132mr2370150otf.30.1699467697587;
        Wed, 08 Nov 2023 10:21:37 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dw1-20020a05683033a100b006ce46212341sm1966690otb.54.2023.11.08.10.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 10:21:37 -0800 (PST)
Received: (nullmailer pid 2703586 invoked by uid 1000);
        Wed, 08 Nov 2023 18:21:35 -0000
Date:   Wed, 8 Nov 2023 12:21:35 -0600
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
Subject: Re: [PATCH RESEND v10 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM
 TACH Control
Message-ID: <20231108182135.GA2698015-robh@kernel.org>
References: <20231107105025.1480561-1-billy_tsai@aspeedtech.com>
 <20231107105025.1480561-3-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107105025.1480561-3-billy_tsai@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 06:50:24PM +0800, Billy Tsai wrote:
> Document the compatible for aspeed,ast2600-pwm-tach device, which can
> support up to 16 PWM outputs and 16 fan tach input.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> new file mode 100644
> index 000000000000..c615fb10705c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2023 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/aspeed,g6-pwm-tach.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED G6 PWM and Fan Tach controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description: |
> +  The ASPEED PWM controller can support up to 16 PWM outputs.
> +  The ASPEED Fan Tacho controller can support up to 16 fan tach input.
> +  They are independent hardware blocks, which are different from the
> +  previous version of the ASPEED chip.
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
> +  "^fan-[0-9]+$":
> +    $ref: fan-common.yaml#
> +    unevaluatedProperties: false
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
> +
> +      fan-0 {

I assume there's a PWM connection here? How do you know which PWM? You 
said the tach channel is independent, so it is not that.

It should not be 0 from 'fan-0' because that's just a meaningless index. 

You either need 'pwms' here or you can use 'reg' and the reg value is 
the PWM channel.

> +        tach-ch = /bits/ 8 <0x0>;
> +      };
> +
> +      fan-1 {
> +        tach-ch = /bits/ 8 <0x1 0x2>;
> +      };
> +    };
> -- 
> 2.25.1
> 
