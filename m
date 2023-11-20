Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05BC7F148C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjKTNmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjKTNmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:42:52 -0500
Received: from mail.subdimension.ro (unknown [IPv6:2a01:7e01:e001:1d1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F7E9E;
        Mon, 20 Nov 2023 05:42:47 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.subdimension.ro (Postfix) with ESMTPSA id A975D28EE6F;
        Mon, 20 Nov 2023 13:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
        s=skycaves; t=1700487765;
        bh=bWmlv7HcEBkDpHScBAIC+ls7pXqAHfS+VuHaY8KKih8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=i751HDfFooxJJbwvvaMsOURUCHavTnzSRP8g/B0V1tAxxngS7Ft1vvEfw0KITW87I
         Pi0fKtSxDMJguNdNEdjzWMBVRNwK/wkafPBScTZ9UlVVNwamsE3W3MPlbY9Rq7oWmX
         RdbTUAV1ewmb5prqUCcD+0XSf+P7cu7jWN/Z9BD4=
Date:   Mon, 20 Nov 2023 15:42:44 +0200
From:   Petre Rodan <petre.rodan@subdimension.ro>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Message-ID: <ZVtiVM2Gm1x1j_G1@sunspire>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
 <20231117192305.17612-1-petre.rodan@subdimension.ro>
 <5b2e4b05-9408-48ea-92ac-15883e102013@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b2e4b05-9408-48ea-92ac-15883e102013@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Krzysztof,

thanks for the pointer regarding the version requirement for jsonschema.
installing an older version fixed all python exceptions.


On Mon, Nov 20, 2023 at 11:21:42AM +0100, Krzysztof Kozlowski wrote:
> On 17/11/2023 20:22, Petre Rodan wrote:
> > Adds binding for digital Honeywell TruStability HSC and SSC series pressure 
> > and temperature sensors.
> > 
> > Datasheet:
> >  [HSC] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
> >  [SSC] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf

> > +properties:
> > +  compatible:
> > +    enum:
> > +      - honeywell,hsc
> 
> Way too generic

I'm new to this, please excuse my ignorance.
my driver covers all Honeywell pressure sensors under the "TruStability board mount HSC/SSC" moniker.
that is why my intention was to provide a rather generic name for the driver itself.
are you afraid that they will come up with a different device that they will call "hsc" in the future?
in this case honeywell,trustability-hsc would be fine?

as I see you prefer to target a particular chip, but I am a bit afraid that the end-user will be confused by needing to set up something like

pressure@28 {
	compatible = "honeywell,hsc030pa";
	reg = <0x28>;
	honeywell,transfer-function = <0>;
	honeywell,pressure-range = "250MD";
};

ie. specifying "hsc030pa" as driver while his chip is not in the 030PA range, but 250MD.

so do you prefer
 honeywell,trustability-hsc  OR
 honeywell,hsc030pa

> > +  honeywell,range_str:
> 
> No underscores in property names.
> 
> "str" is redundant. Instead say what is it, because "range" is way too
> vague.

will rename to honeywell,pressure-range if that is ok with you.

> > +    description: |
> > +      Five character string that defines "pressure range, unit and type"
> > +      as part of the device nomenclature. In the unlikely case of a custom
> > +      chip, set to "NA" and provide honeywell,pmin-pascal honeywell,pmax-pascal
> > +    enum: [001BA, 1.6BA, 2.5BA, 004BA, 006BA, 010BA, 1.6MD, 2.5MD, 004MD,
> > +           006MD, 010MD, 016MD, 025MD, 040MD, 060MD, 100MD, 160MD, 250MD,
> > +           400MD, 600MD, 001BD, 1.6BD, 2.5BD, 004BD, 2.5MG, 004MG, 006MG,
> > +           010MG, 016MG, 025MG, 040MG, 060MG, 100MG, 160MG, 250MG, 400MG,
> > +           600MG, 001BG, 1.6BG, 2.5BG, 004BG, 006BG, 010BG, 100KA, 160KA,
> > +           250KA, 400KA, 600KA, 001GA, 160LD, 250LD, 400LD, 600LD, 001KD,
> > +           1.6KD, 2.5KD, 004KD, 006KD, 010KD, 016KD, 025KD, 040KD, 060KD,
> > +           100KD, 160KD, 250KD, 400KD, 250LG, 400LG, 600LG, 001KG, 1.6KG,
> > +           2.5KG, 004KG, 006KG, 010KG, 016KG, 025KG, 040KG, 060KG, 100KG,
> > +           160KG, 250KG, 400KG, 600KG, 001GG, 015PA, 030PA, 060PA, 100PA,
> > +           150PA, 0.5ND, 001ND, 002ND, 004ND, 005ND, 010ND, 020ND, 030ND,
> > +           001PD, 005PD, 015PD, 030PD, 060PD, 001NG, 002NG, 004NG, 005NG,
> > +           010NG, 020NG, 030NG, 001PG, 005PG, 015PG, 030PG, 060PG, 100PG,
> > +           150PG, NA]
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +
> > +  honeywell,pmin-pascal:
> > +    description: |
> > +      Minimum pressure value the sensor can measure in pascal.
> > +      To be specified only if honeywell,range_str is set to "NA".
> > +    $ref: /schemas/types.yaml#/definitions/int32
> 
> That's uint32. Why do you need negative values?

signed int32 is intentional. some chips have two physical input ports and measure a pressure differential in which case pmin is negative.
see either of the pdfs at page 14, table 8, column 2, row 7+

> > +  honeywell,pmax-pascal:
> > +    description: |
> > +      Maximum pressure value the sensor can measure in pascal.
> > +      To be specified only if honeywell,range_str is set to "NA".
> > +    $ref: /schemas/types.yaml#/definitions/int32
> 
> Ditto

well, since we saw pmin needs to be signed should we have pmax unsigned?

> > +  vdd-supply:
> > +    description: |
> > +      Provide VDD power to the sensor (either 3.3V or 5V depending on the chip).
> > +      Optional, activate only if required by the target board.
> 
> Drop the last sentence. The supplies are required not by target board
> but by hardware. I also do not understand what "activate" means in terms
> of bindings and DTS.

ok, ignore rambling.

> > +
> > +  spi-max-frequency:
> > +    description: SPI clock to be kept between 50 and 800kHz
> 
> Drop description, add minimum/maximum constraints if worth.

will replace block with

  spi-max-frequency:
    maximum: 800000

as I saw in other yaml files
 
> > +  clock-frequency:
> > +    description: i2c clock to be kept between 100 and 400kHz
> 
> Drop, that's not really an I2C device property. Your driver must use
> common clock framework.

ack

> > +required:
> > +  - compatible
> > +  - reg
> > +  - honeywell,transfer-function
> > +  - honeywell,range_str
> > +  - clock-frequency
> 
> Why?

dropped clock-frequency

everything else below will be as you asked.

I will provide a new set of patches after I get your inpyt.

my very best regards,
peter

> > +  - spi-max-frequency
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    i2c {
> > +        status = "okay";
> 
> ?!? Drop
> 
> > +        clock-frequency = <400000>;
> 
> Drop
> 
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        HSCMRNN030PA2A3@28 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> Plus, upper case is not allowed...
> 
> > +          status = "okay";
> 
> Drop. BTW status never comes first!
> 
> > +          compatible = "honeywell,hsc";
> > +          reg = <0x28>;
> > +
> > +          honeywell,transfer-function = <0>;
> > +          honeywell,range_str = "030PA";
> > +        };
> > +    };
> > +
> > +    spi {
> > +        # note that MOSI is not required by this sensor
> 
> This should be then part of description, not example.
> 
> > +        status = "okay";
> 
> Drop
> 
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        HSCMLNN100PASA3@0 {
> 
> Eh...
> 
> > +          status = "okay";
> 
> Drop
> 
> > +          compatible = "honeywell,hsc";
> > +          reg = <0>;
> > +          spi-max-frequency = <800000>;
> > +
> > +          honeywell,transfer-function = <0>;
> > +          honeywell,range_str = "100PA";
> > +        };
> > +
> > +        HSC_CUSTOM_CHIP@0 {
> 
> Drop, not needed. One example is enough.
> 
> > +          status = "okay";
> > +          compatible = "honeywell,hsc";
> > +          reg = <1>;
> > +          spi-max-frequency = <800000>;
> 
> Also, your indentation is broken.
> 
> Use 4 spaces for example indentation.
> 
> > +
> > +          honeywell,transfer-function = <0>;
> > +          honeywell,range_str = "NA";
> > +          honeywell,pmin-pascal = <0>;
> > +          honeywell,pmax-pascal = <206850>;
> > +        };
> > +
> 
> No stray blank lines.
> 
> Best regards,
> Krzysztof
> 
> 

-- 
petre rodan
