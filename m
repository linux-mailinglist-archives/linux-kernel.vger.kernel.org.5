Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8828A7B5B79
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbjJBTiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjJBTip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:38:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406EFAC;
        Mon,  2 Oct 2023 12:38:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15A5C433C8;
        Mon,  2 Oct 2023 19:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696275521;
        bh=3RlTZzQYaC/+oBacen75NhpiynitlSHubKdJ2Nak6tY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZWMakQzjBPIi8XauGl6bSkbTOR50c7ZX03Mm8TQ6dGqzdWCF5fyxj2DiowYBR/dcE
         EAiYm3QcczaP2m9KSWbGn5TJFvBaT/ChZmDKhIjvrL0SZFgfvHmR91wiXphloE7AJy
         QQRgBRqJFRkwlKIjr0acdh7NOAIAjNHS95u8ivuqUzXR+/2HavImNmufU0YeXkaA79
         mCy1F3j70Q0S5WfmMRhZ19FLPsJKNp2frVyIqFaxe7r9x+TgDUTnCJUeU4Z0WsvTgo
         nf40iiKGsEzAzBfwDOxaEOu6XX5/a2mi/uQ8SL6SMRx5jLOGsms5EH/QDidz/taiJh
         7bLdV/cYCVTLQ==
Received: (nullmailer pid 2400172 invoked by uid 1000);
        Mon, 02 Oct 2023 19:38:35 -0000
Date:   Mon, 2 Oct 2023 14:38:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc:     Conor Dooley <conor@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: ltc2991: add bindings
Message-ID: <20231002193835.GA2386834-robh@kernel.org>
References: <20231002101835.39624-1-antoniu.miclaus@analog.com>
 <20231002-babbling-justice-73d3601a71aa@spud>
 <CY4PR03MB33990FB22E1BB8686AC0CF509BC5A@CY4PR03MB3399.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR03MB33990FB22E1BB8686AC0CF509BC5A@CY4PR03MB3399.namprd03.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 01:46:53PM +0000, Miclaus, Antoniu wrote:
> 
> 
> --
> Antoniu Miclăuş
> 
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Monday, October 2, 2023 4:01 PM
> > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > Cc: Jean Delvare <jdelvare@suse.com>; Guenter Roeck <linux@roeck-
> > us.net>; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> > <conor+dt@kernel.org>; Jonathan Corbet <corbet@lwn.net>; linux-
> > hwmon@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-doc@vger.kernel.org
> > Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: ltc2991: add bindings
> > 
> > [External]
> > 
> > Hey,
> > 
> > On Mon, Oct 02, 2023 at 01:18:14PM +0300, Antoniu Miclaus wrote:
> > > Add dt-bindings for ltc2991 octal i2c voltage, current and temperature
> > > monitor.
> > >
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > ---
> > > changes in v2:
> > >  - make compatible const type
> > >  - remove `|` where not necessary
> > >  - switch to micro-ohms for the shunt resistor property
> > >  - add vendor prefix for temperature-enable
> > 
> > Thanks for the updates...
> > 
> > >  .../bindings/hwmon/adi,ltc2991.yaml           | 114 ++++++++++++++++++
> > >  1 file changed, 114 insertions(+)
> > >  create mode 100644
> > Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
> > b/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
> > > new file mode 100644
> > > index 000000000000..3811ea07a04f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
> > > @@ -0,0 +1,114 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +
> > > +$id: http://devicetree.org/schemas/hwmon/adi,ltc2991.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices LTC2991 Octal I2C Voltage, Current and Temperature
> > Monitor
> > > +
> > > +maintainers:
> > > +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > +
> > > +description: |
> > > +  The LTC2991 is used to monitor system temperatures, voltages and
> > currents.
> > > +  Through the I2C serial interface, the eight monitors can individually
> > measure
> > > +  supply voltages and can be paired for differential measurements of
> > current
> > > +  sense resistors or temperature sensing transistors.
> > > +
> > > +  Datasheet:
> > > +    https://www.analog.com/en/products/ltc2991.html
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: adi,ltc2991
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  '#address-cells':
> > > +    const: 1
> > > +
> > > +  '#size-cells':
> > > +    const: 0
> > > +
> > > +  vcc-supply: true
> > > +
> > > +patternProperties:
> > > +  "^channel@[0-3]$":
> > > +    type: object
> > > +    description:
> > > +      Represents the differential/temperature channels.
> > > +
> > > +    properties:
> > > +      reg:
> > > +        description:
> > > +          The channel number. LTC2991 can monitor 4 currents/temperatures.
> > > +        items:
> > > +          minimum: 0
> > > +          maximum: 3
> > > +
> > > +      shunt-resistor-micro-ohms:
> > > +        description:
> > > +          The value of curent sense resistor in miliohms. Enables differential
> > > +          input pair.
> > > +
> > > +      adi,temperature-enable:
> > > +        description:
> > > +          Enables temperature readings for a input pair.
> > > +        type: boolean
> > 
> > ...but I did not see an answer to my question on v1:
> > 	TBH, this seems like it is used just to control software behaviour.
> > 	Why would you want to actually disable this in DT?
> > In other words, is there something in that hardware that precludes
> > measuring temperature for channels that do not contain this property?
> > 
> > Thanks,
> > Conor.
> > 
> Sorry for missing that. I took in consideration this approach based on the pin functions
> described in the datasheet (page 8 of 32). For example the V1 pin of the part can support
> 3 different configurations: "V1 (Pin 1): First Monitor Input. This pin can be configured
> as a single-ended input (0V to 4.9V) or the positive inputfor a differential or remote diode
> temperature measurement (in combination with V2)."
> Moreover, looking at the multiple typical applications examples at the end of the datasheet
> there is a specific adjacent hardware circuit connected to this part for the temperature
> measurements configurations.

Makes sense. Please expand the description with some of this detail so 
the purpose is clear. The description should answer when do I set this 
property or not.

Rob
