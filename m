Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A87F7FC1C2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346529AbjK1PCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345961AbjK1PCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:02:00 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755C310C;
        Tue, 28 Nov 2023 07:02:06 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3b8382b8f5aso3454058b6e.0;
        Tue, 28 Nov 2023 07:02:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183725; x=1701788525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWiVW1Tj7aQ56Epxxc+8Fc1eCMFReni5f+36Hxx0HAU=;
        b=Fu3J2EvT9YSaFxHgrdDBJKPc+4jakCdgE1k+I35kcU+oSv0MBkIjXCfo9omiZkRbyA
         KlKe/KVYI2CRXKqBmtZB87x0AEBB2jijvTbAuAHb7g8jLPBLea8vP8lcn34ZTbTRXJaQ
         PmS1q4MKTiVm0/DZinqBLH5DQ0df2529udcQIuoSYxknPOa+xDl0FdFI6LfGz671HY40
         PUdpiG7QWYYvIQu3p1ePRUDqbp1PmEtCbV92vZLiPloJOTBFjLMVw0XNj/Q0cVCMihfh
         dSLves/FSEfVcb4gR87wWP3LTxOlrQg/GwDGVgiEfOGi6/RP0iviZkjNVajmvBX4fSwq
         7x7A==
X-Gm-Message-State: AOJu0YzFuhvi9uY+Ky5SzcgQQVuICeMOlcWEqRbQOxjwa+RkBxHlvghw
        dZCU7+jKVG39uVrutUVpcg==
X-Google-Smtp-Source: AGHT+IEeLzPRwuhWLu/lFo1HqvMvDm3Ulpwlen9Y4ezRuH348Sgi+IzPCxqC07eSOVGL9ia1tTiC6Q==
X-Received: by 2002:a05:6808:1188:b0:3b2:f27a:8a52 with SMTP id j8-20020a056808118800b003b2f27a8a52mr18433036oil.41.1701183725601;
        Tue, 28 Nov 2023 07:02:05 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ay9-20020a056808300900b003b8388ffaffsm1852220oib.41.2023.11.28.07.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 07:02:05 -0800 (PST)
Received: (nullmailer pid 3274715 invoked by uid 1000);
        Tue, 28 Nov 2023 15:02:03 -0000
Date:   Tue, 28 Nov 2023 09:02:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     netdev@vger.kernel.org, woojung.huh@microchip.com, andrew@lunn.ch,
        f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marex@denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v6 1/2] dt-bindings: net: microchip,ksz:
 document microchip,rmii-clk-internal
Message-ID: <20231128150203.GA3264915-robh@kernel.org>
References: <cover.1701091042.git.ante.knezic@helmholz.de>
 <7f1f89010743a06c4880fd224149ea495fe32512.1701091042.git.ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f1f89010743a06c4880fd224149ea495fe32512.1701091042.git.ante.knezic@helmholz.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 02:20:42PM +0100, Ante Knezic wrote:
> Add documentation for selecting reference rmii clock on KSZ88X3 devices
> 
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> ---
>  .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 38 +++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)

You forgot Conor's ack.

> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index b3029c64d0d5..6fd482f2656b 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> @@ -11,7 +11,6 @@ maintainers:
>    - Woojung Huh <Woojung.Huh@microchip.com>
>  
>  allOf:
> -  - $ref: dsa.yaml#/$defs/ethernet-ports
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
>  properties:
> @@ -78,6 +77,43 @@ required:
>    - compatible
>    - reg
>  
> +if:
> +  not:
> +    properties:
> +      compatible:
> +        enum:
> +          - microchip,ksz8863
> +          - microchip,ksz8873
> +then:
> +  $ref: dsa.yaml#/$defs/ethernet-ports
> +else:
> +  patternProperties:
> +    "^(ethernet-)?ports$":
> +      patternProperties:
> +        "^(ethernet-)?port@[0-2]$":
> +          $ref: dsa-port.yaml#
> +          properties:
> +            microchip,rmii-clk-internal:
> +              $ref: /schemas/types.yaml#/definitions/flag
> +              description:
> +                When ksz88x3 is acting as clock provier (via REFCLKO) it
> +                can select between internal and external RMII reference
> +                clock. Internal reference clock means that the clock for
> +                the RMII of ksz88x3 is provided by the ksz88x3 internally
> +                and the REFCLKI pin is unconnected. For the external
> +                reference clock, the clock needs to be fed back to ksz88x3
> +                via REFCLKI.
> +                If microchip,rmii-clk-internal is set, ksz88x3 will provide
> +                rmii reference clock internally, otherwise reference clock
> +                should be provided externally.

> +          if:
> +            not:
> +              required: [ ethernet ]
> +          then:
> +            properties:
> +              microchip,rmii-clk-internal: false

This can be expressed as:

dependencies:
  microchip,rmii-clk-internal: [ethernet]


> +          unevaluatedProperties: false

Move this under the $ref.

> +
>  unevaluatedProperties: false
>  
>  examples:
> -- 
> 2.11.0
> 
