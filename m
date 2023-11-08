Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5723D7E5D04
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 19:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjKHSRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 13:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHSQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 13:16:59 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC47C1FF3;
        Wed,  8 Nov 2023 10:16:57 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b565722c0eso4225893b6e.2;
        Wed, 08 Nov 2023 10:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699467417; x=1700072217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDMXHrCNHotVlfHJTukvHxKiw+LRe2nJBe8uVVsPODE=;
        b=AJLw2WO6nzQiq1U+LsjSws/FH/bJId6MK6h/6VniVZLBkn7jRdT6JEo3M8UOdZVgJM
         wJ6XLr5RTA+pCupHZ8RXU/cMVFvVNFNJJaGLQwNTJvAk8QWaZlTfaspk4nH7NqnP42Yy
         Lzb6e5/sNuvg/zwXTcwj4s43p85t6Bxqc3crsUNy5+yKQuG/Hg4zuegbDyc3IjLtQtP7
         hUssaaUCHChiO/dwSiLCOh+y3RVXcep5KUZMpnhmZoL3gD6L0y5424XAbzILcjePWQqP
         Pp5BQwPVlhwkb1XbTd1oFd6c+NxqlkQ1RTVrkqEEtmz/2PCODsoEl+37BwfQUsXIL3K5
         mukg==
X-Gm-Message-State: AOJu0Yy52JB4wuJ5V9IZZxlXfB0KWQYrMhuMKoF1viZnLSZYHifFL2Q4
        93pxKy4erYQGfkrwUJP6vQ==
X-Google-Smtp-Source: AGHT+IG8jY8GfwEmq1IF9uXyhmf+3vLAsgL0KuuTgiy5XZG6/I66+r21zbsN2TLNHOOJD0uL9WcRyA==
X-Received: by 2002:a05:6808:181c:b0:3a7:500a:a491 with SMTP id bh28-20020a056808181c00b003a7500aa491mr3345541oib.28.1699467416982;
        Wed, 08 Nov 2023 10:16:56 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u6-20020a056808150600b003af6eeed9b6sm1976108oiw.27.2023.11.08.10.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 10:16:56 -0800 (PST)
Received: (nullmailer pid 2697492 invoked by uid 1000);
        Wed, 08 Nov 2023 18:16:54 -0000
Date:   Wed, 8 Nov 2023 12:16:54 -0600
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
Subject: Re: [PATCH RESEND v10 1/3] dt-bindings: hwmon: fan: Add fan binding
 to schema
Message-ID: <20231108181654.GA2664986-robh@kernel.org>
References: <20231107105025.1480561-1-billy_tsai@aspeedtech.com>
 <20231107105025.1480561-2-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107105025.1480561-2-billy_tsai@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 06:50:23PM +0800, Billy Tsai wrote:
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

Looking pretty good to me. It's disappointing that no one else 
interested in upstreaming their fan controller can be bothered to 
comment.

> 
> diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> new file mode 100644
> index 000000000000..be4ce3bd7f22
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
> +    $ref: /schemas/types.yaml#/definitions/string

You need to define the possible values. I assume it's:

enum:
  - dc
  - pwm
  - anything else???

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
