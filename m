Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B6F7795DE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbjHKRKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236290AbjHKRKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:10:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B8230FB;
        Fri, 11 Aug 2023 10:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2724D677C0;
        Fri, 11 Aug 2023 17:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6671BC433C7;
        Fri, 11 Aug 2023 17:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691773813;
        bh=UdEqF3pGPTwVExsOaFfOCqMxAjBH843Ugv8NaoMyVwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KJ3NFlDcFjDpk1FuN54RAdpfWhRoISGqyl5eUZm2e3WsGQuNOme5lQFSu4XhuE5Gq
         MEog3qPjSUzn77qziQ0HAQZpAyJTDskSZq4vd104RLovJiaveLDamut4I1HVrk4CTq
         PgjZEecxM4pXTnEXb8tNTwsocMV5Pk9q5vO68FW8mlX0hjEF6O+8b4PnKMqiVnSVIZ
         5GHdJY/UA4I3zw45RmUz1C0biG+utvEVlxyELz8/HXKTH3KEY01yEhI7GqfBUiXEpe
         N8U1pZ0qVSzU1NsK/s+oNRi3alFikMaZOYFT48ZB+aYRTGbNvU16fyxI4Sxem7AoMI
         JP2Xvru9GJyng==
Received: (nullmailer pid 3621153 invoked by uid 1000);
        Fri, 11 Aug 2023 17:10:11 -0000
Date:   Fri, 11 Aug 2023 11:10:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        alsa-devel@alsa-project.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 03/11] dt-bindings: iio: stm32-dfsdm-adc: add scaling
 support
Message-ID: <20230811171011.GA3618531-robh@kernel.org>
References: <20230727150324.1157933-1-olivier.moysan@foss.st.com>
 <20230727150324.1157933-4-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727150324.1157933-4-olivier.moysan@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 05:03:14PM +0200, Olivier Moysan wrote:
> Add scaling support to STM32 DFSDM.
> 
> This introduces the following changes:

Why?

> - Add ADC generic channel binding and remove support of deprecated
> channel bindings.

When was it deprecated?

> - DFSDM is now implemented as a channel provider, so remove io-channels
> properties.
> - Add iio-backend property to connect DFSDM to an SD modulator.

io-backends

All sorts of ABI issues with this change. Please explain why you don't 
care.

> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml  | 189 ++++++------------
>  1 file changed, 63 insertions(+), 126 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> index 1970503389aa..128545cedc7f 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> @@ -85,22 +85,14 @@ patternProperties:
>          description: Specifies the DFSDM filter instance used.
>          maxItems: 1
>  
> -      interrupts:
> -        maxItems: 1
> +      '#address-cells':
> +        const: 1
>  
> -      st,adc-channels:
> -        description: |
> -          List of single-ended channels muxed for this ADC.
> -          On stm32h7 and stm32mp1:
> -          - For st,stm32-dfsdm-adc: up to 8 channels numbered from 0 to 7.
> -          - For st,stm32-dfsdm-dmic: 1 channel numbered from 0 to 7.
> -        $ref: /schemas/types.yaml#/definitions/uint32-array
> -        items:
> -          minimum: 0
> -          maximum: 7
> +      '#size-cells':
> +        const: 0
>  
> -      st,adc-channel-names:
> -        description: List of single-ended channel names.
> +      interrupts:
> +        maxItems: 1
>  
>        st,filter-order:
>          description: |
> @@ -111,39 +103,6 @@ patternProperties:
>          $ref: /schemas/types.yaml#/definitions/uint32
>          maximum: 5
>  
> -      "#io-channel-cells":
> -        const: 1
> -
> -      st,adc-channel-types:
> -        description: |
> -          Single-ended channel input type.
> -          - "SPI_R": SPI with data on rising edge (default)
> -          - "SPI_F": SPI with data on falling edge
> -          - "MANCH_R": manchester codec, rising edge = logic 0, falling edge = logic 1
> -          - "MANCH_F": manchester codec, rising edge = logic 1, falling edge = logic 0
> -        items:
> -          enum: [ SPI_R, SPI_F, MANCH_R, MANCH_F ]
> -        $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> -
> -      st,adc-channel-clk-src:
> -        description: |
> -          Conversion clock source.
> -          - "CLKIN": external SPI clock (CLKIN x)
> -          - "CLKOUT": internal SPI clock (CLKOUT) (default)
> -          - "CLKOUT_F": internal SPI clock divided by 2 (falling edge).
> -          - "CLKOUT_R": internal SPI clock divided by 2 (rising edge).
> -        items:
> -          enum: [ CLKIN, CLKOUT, CLKOUT_F, CLKOUT_R ]
> -        $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> -
> -      st,adc-alt-channel:
> -        description:
> -          Must be defined if two sigma delta modulators are
> -          connected on same SPI input.
> -          If not set, channel n is connected to SPI input n.
> -          If set, channel n is connected to SPI input n + 1.
> -        type: boolean
> -
>        st,filter0-sync:
>          description:
>            Set to 1 to synchronize with DFSDM filter instance 0.
> @@ -157,14 +116,68 @@ patternProperties:
>          items:
>            - const: rx
>  
> +    patternProperties:
> +      "^channel@([0-9]|1[0-9])$":
> +        type: object
> +        $ref: "adc.yaml"
> +        description: Represents the external channels which are connected to the DFSDM.
> +
> +        properties:
> +          reg:
> +            items:
> +              minimum: 0
> +              maximum: 19
> +
> +          label:
> +            description: |
> +              Unique name to identify channel.
> +
> +          st,adc-channel-types:
> +            description: |
> +              Single-ended channel input type.
> +              - "SPI_R": SPI with data on rising edge (default)
> +              - "SPI_F": SPI with data on falling edge
> +              - "MANCH_R": manchester codec, rising edge = logic 0, falling edge = logic 1
> +              - "MANCH_F": manchester codec, rising edge = logic 1, falling edge = logic 0
> +            items:
> +              enum: [ SPI_R, SPI_F, MANCH_R, MANCH_F ]
> +            $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +
> +          st,adc-channel-clk-src:
> +            description: |
> +              Conversion clock source.
> +              - "CLKIN": external SPI clock (CLKIN x)
> +              - "CLKOUT": internal SPI clock (CLKOUT) (default)
> +              - "CLKOUT_F": internal SPI clock divided by 2 (falling edge).
> +              - "CLKOUT_R": internal SPI clock divided by 2 (rising edge).
> +            items:
> +              enum: [ CLKIN, CLKOUT, CLKOUT_F, CLKOUT_R ]
> +            $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +
> +          st,adc-alt-channel:
> +            description:
> +              Must be defined if two sigma delta modulators are
> +              connected on same SPI input.
> +              If not set, channel n is connected to SPI input n.
> +              If set, channel n is connected to SPI input n + 1.
> +            type: boolean
> +
> +          io-backends:
> +            description: |
> +              phandle to an external sigma delta modulator or internal ADC output.
> +            $ref: /schemas/types.yaml#/definitions/phandle
> +
> +        required:
> +          - reg
> +          - io-backends
> +
> +        additionalProperties: false
> +
>      required:
>        - compatible
>        - reg
>        - interrupts
> -      - st,adc-channels
> -      - st,adc-channel-names
>        - st,filter-order
> -      - "#io-channel-cells"
>  
>      allOf:
>        - if:
> @@ -175,14 +188,6 @@ patternProperties:
>  
>          then:
>            properties:
> -            st,adc-channels:
> -              minItems: 1
> -              maxItems: 8
> -
> -            st,adc-channel-names:
> -              minItems: 1
> -              maxItems: 8
> -
>              st,adc-channel-types:
>                minItems: 1
>                maxItems: 8
> @@ -191,14 +196,6 @@ patternProperties:
>                minItems: 1
>                maxItems: 8
>  
> -            io-channels:
> -              description:
> -                From common IIO binding. Used to pipe external sigma delta
> -                modulator or internal ADC output to DFSDM channel.
> -
> -          required:
> -            - io-channels
> -
>        - if:
>            properties:
>              compatible:
> @@ -207,12 +204,6 @@ patternProperties:
>  
>          then:
>            properties:
> -            st,adc-channels:
> -              maxItems: 1
> -
> -            st,adc-channel-names:
> -              maxItems: 1
> -
>              st,adc-channel-types:
>                maxItems: 1
>  
> @@ -237,15 +228,9 @@ patternProperties:
>                  "#sound-dai-cells":
>                    const: 0
>  
> -                io-channels:
> -                  description:
> -                    From common IIO binding. Used to pipe external sigma delta
> -                    modulator or internal ADC output to DFSDM channel.
> -
>                required:
>                  - compatible
>                  - "#sound-dai-cells"
> -                - io-channels
>  
>  allOf:
>    - if:
> @@ -278,52 +263,4 @@ allOf:
>                  minimum: 0
>                  maximum: 5
>  
> -examples:
> -  - |
> -    #include <dt-bindings/interrupt-controller/arm-gic.h>
> -    #include <dt-bindings/clock/stm32mp1-clks.h>
> -    dfsdm: dfsdm@4400d000 {
> -      compatible = "st,stm32mp1-dfsdm";
> -      reg = <0x4400d000 0x800>;
> -      clocks = <&rcc DFSDM_K>, <&rcc ADFSDM_K>;
> -      clock-names = "dfsdm", "audio";
> -      #address-cells = <1>;
> -      #size-cells = <0>;
> -
> -      dfsdm0: filter@0 {
> -        compatible = "st,stm32-dfsdm-dmic";
> -        reg = <0>;
> -        interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> -        dmas = <&dmamux1 101 0x400 0x01>;
> -        dma-names = "rx";
> -        #io-channel-cells = <1>;
> -        st,adc-channels = <1>;
> -        st,adc-channel-names = "dmic0";
> -        st,adc-channel-types = "SPI_R";
> -        st,adc-channel-clk-src = "CLKOUT";
> -        st,filter-order = <5>;
> -
> -        asoc_pdm0: dfsdm-dai {
> -          compatible = "st,stm32h7-dfsdm-dai";
> -          #sound-dai-cells = <0>;
> -          io-channels = <&dfsdm0 0>;
> -        };
> -      };
> -
> -      dfsdm_pdm1: filter@1 {
> -        compatible = "st,stm32-dfsdm-adc";
> -        reg = <1>;
> -        interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
> -        dmas = <&dmamux1 102 0x400 0x01>;
> -        dma-names = "rx";
> -        #io-channel-cells = <1>;
> -        st,adc-channels = <2 3>;
> -        st,adc-channel-names = "in2", "in3";
> -        st,adc-channel-types = "SPI_R", "SPI_R";
> -        st,adc-channel-clk-src = "CLKOUT_F", "CLKOUT_F";
> -        io-channels = <&sd_adc2 &sd_adc3>;
> -        st,filter-order = <1>;
> -      };
> -    };
> -
>  ...
> -- 
> 2.25.1
> 
