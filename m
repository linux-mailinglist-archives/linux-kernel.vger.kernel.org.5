Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D837CCC47
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344217AbjJQT3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbjJQT3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:29:05 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37ECED;
        Tue, 17 Oct 2023 12:29:03 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3af6bd48093so3972056b6e.3;
        Tue, 17 Oct 2023 12:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697570943; x=1698175743;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cClk5aKpdEmHCYWR3pE5BYIwnM1+GggDeTeYY2IMW1s=;
        b=RX6aGeU4XK9StblL0epVPIrN3qpMxDlBzSKCyHjVzSIQwk8bKacW+zeFs7lmO20vjS
         Tey0+WVUcDYe/Kn4zu5iYT3ACaEY7jbqnCw5XbG4iEToa9ky0MgAeemFHL+wh0VkMzB1
         k/EyZw2uRg/po/TeKGPKjU96WNulofx+1riw5WtWG7PFvb2eAfZUEE4xxToLL+r0r94r
         XLFmgQiVsH846G/M/OMGbo0iHlF2R9gVVkg6Fz1Ac3AobTWXTlTopcBaaHHusNa1WSs1
         x+IXb2XIO7emgll28JvbvTgdyKYpPwvawLhFdDcLSDFWJVkfV+gVol9CmoBIYtfbTY3X
         Nfgg==
X-Gm-Message-State: AOJu0Yy99bPXz3mTb0iLWphPmybZM+CxZRtVv1Px0VgVxjgeUfQ57fwx
        eNSjTwZkgCO5ZlYs++KpEPlsQkjTIw==
X-Google-Smtp-Source: AGHT+IGcMdkVV6al4MOlEPkTvoFb6kKb/+o+yG5ZgqwPclpmzp5pU4x0e2kObfKY3Jdkho1lXsvP8A==
X-Received: by 2002:a05:6808:181a:b0:3ae:2877:9b31 with SMTP id bh26-20020a056808181a00b003ae28779b31mr4035483oib.20.1697570942873;
        Tue, 17 Oct 2023 12:29:02 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n6-20020a05687104c600b001d6e9bb67d2sm388822oai.7.2023.10.17.12.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:29:02 -0700 (PDT)
Received: (nullmailer pid 2548219 invoked by uid 1000);
        Tue, 17 Oct 2023 19:28:59 -0000
Date:   Tue, 17 Oct 2023 14:28:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Jacob Siverskog <jacob@teenage.engineering>,
        Sergej Sawazki <sergej@taudac.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: clock: si5351: add PLL reset mode
 property
Message-ID: <20231017192859.GA2544830-robh@kernel.org>
References: <20231014-alvin-clk-si5351-no-pll-reset-v4-0-a3567024007d@bang-olufsen.dk>
 <20231014-alvin-clk-si5351-no-pll-reset-v4-2-a3567024007d@bang-olufsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231014-alvin-clk-si5351-no-pll-reset-v4-2-a3567024007d@bang-olufsen.dk>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 08:19:42PM +0200, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> For applications where the PLL must be adjusted without glitches in the
> clock output(s), a new silabs,pll-reset-mode property is added. It
> can be used to specify whether or not the PLL should be reset after
> adjustment. Resetting is known to cause glitches.
> 
> For compatibility with older device trees, it must be assumed that the
> default PLL reset mode is to unconditionally reset after adjustment.
> 
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Rabeeh Khoury <rabeeh@solid-run.com>
> Cc: Jacob Siverskog <jacob@teenage.engineering>
> Cc: Sergej Sawazki <sergej@taudac.com>
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> ---
>  .../devicetree/bindings/clock/silabs,si5351.yaml   | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/silabs,si5351.yaml b/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
> index 16d1142c4a2f..9621b534f30e 100644
> --- a/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
> +++ b/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
> @@ -60,6 +60,27 @@ properties:
>          - description: PLL source, XTAL (0) or CLKIN (1, Si5351C only).
>            enum: [ 0, 1 ]
>  
> +  silabs,pll-reset-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    minItems: 1

If there's only 2 PLLs, then the maximum is 2 entries, right? So 
'maxItems: 2' in addition.

> +    description: |

Don't need '|'

> +      A list of cell pairs containing a PLL index and its reset mode.
> +    items:
> +      items:
> +        - description: PLL A (0) or PLL B (1)
> +          enum: [ 0, 1 ]
> +        - description: |
> +            Reset mode for the PLL. Mode can be one of:
> +
> +                0 - reset whenever PLL rate is adjusted (default mode)
> +                1 - do not reset when PLL rate is adjusted
> +
> +            In mode 1, the PLL is only reset if the silabs,pll-reset is
> +            specified in one of the clock output child nodes that also sources
> +            the PLL. This mode may be preferable if output clocks are expected
> +            to be adjusted without glitches.
> +          enum: [ 0, 1 ]
> +
>  patternProperties:
>    "^clkout@[0-7]$":
>      type: object
> @@ -199,6 +220,9 @@ examples:
>          /* Use XTAL input as source of PLL0 and PLL1 */
>          silabs,pll-source = <0 0>, <1 0>;
>  
> +        /* Don't reset PLL1 on rate adjustment */
> +        silabs,pll-reset-mode = <1 1>;
> +
>          /*
>           * Overwrite CLK0 configuration with:
>           * - 8 mA output drive strength
> 
> -- 
> 2.42.0
> 
