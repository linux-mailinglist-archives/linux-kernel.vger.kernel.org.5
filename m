Return-Path: <linux-kernel+bounces-137231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FE689DF3D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57831C21DBF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7179F13E042;
	Tue,  9 Apr 2024 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmLWRjb9"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB0513E3E8;
	Tue,  9 Apr 2024 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676574; cv=none; b=qF04xVM29LxbiyrMbTylV3nfpO+HDplmx2HTZPQotn2+HRlU0bjSJp+b9DiDV3Rd+8YZ6YJt2tcO91fdOgO5MqCwI6vFowP42wOR0uDNxagSfglUIqJoPhB86T9WcZnDNV8r21Rg0lNtMHkek3dIqPTb87eiX+AU8sLE48srrz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676574; c=relaxed/simple;
	bh=p8GCIbQsrjA92CnY0L3dxkTqT4ceV3QuDXIAqDzM+bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWS4TUft5IBSUfMgosSVLhQAKmQMGRdia82dR6djb2I2fH8+2xX5sDr/aNuziN+C+5LgF6++crEY8EHBpqiRyZIkmF3R7xkzuIuV7nx3/xugRwavnfqngnJ6AVFAqOzp5pwwt/3+kbyM7e94bMUPnrO16QAR82WDKzZ4J84SleA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmLWRjb9; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a2f6da024eso3573748a91.3;
        Tue, 09 Apr 2024 08:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712676572; x=1713281372; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IXJi5llpZ+vhWTyedf01ExpUFEryZUwweTd1xXAkLeA=;
        b=JmLWRjb9KHPsbjcuhNVlgSm3y80Qi88yprGXTWwxnMTdZvJGnVZpfVZBzolRzNgvn7
         0ECsBkHci/7N2OOFFAfLVsHfUIB2KLSpRI0nEo+CprzB8hNX09/2s+AK4Ii7Ejpvf4VP
         dTJLqLkk/NMWjtr7HKkGgdgicuiEKAYXPuEynYMV7dRM+IWDMR3pcUXUsriSrVemRf0o
         P4z9s7Mu00jPx4qwbE5jNqCwW5n93RKRheTjizQI79EZy00cT6f/e6cdEY4ipl7zJybJ
         iadZsrSQk33FBvgMCHwWwaUqxkTWJ3vpPn27spHgAxXDp0esKwHJs7I0+sYlpKMWAHod
         rQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676572; x=1713281372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXJi5llpZ+vhWTyedf01ExpUFEryZUwweTd1xXAkLeA=;
        b=l6d56nEzFOWPcUQpjJv1iLpFLbr378cXabVPBTmrB5n1vb9HU12LrOPNKCXmBEc8eI
         ml1Z6T5CCRedOcxytrSQ1gMUcnJGzQtJ7MZXtcBrgS7sRNMffeoFKxSzXWXPrU2+x9rg
         KIyst5/JdEA4WJFw6qj4VHngUrXCvoB7/oL0h3mTo2rXiQSOoxt3sUMiiV4qPzu1RcQW
         o4KZ50zvi7LyjTgiYD3al2MjPznghdJYt77+bVR1zu+gQH5Qe3kyS7LJLs9eQUDI3oYl
         iPZWvoKmAFxNMl298e5TPXt9s19gZ/lz479w3DwQMIhk2JAvJo7yjas5SEDoJHHE9bh5
         Rv/A==
X-Forwarded-Encrypted: i=1; AJvYcCVCn+SaqzJatzETlq3eURHEiaUPYM438WEd22CALx6ICW59JB//6MgJT/3VVioC0e4egolEQ516maf3iyLnvcsDR2cMKoHjLsFjvc12bijIbmREQZEyit7nlwRyW/w3K1uhT8vqlcKzDqeL3tjG2bhR1h1L5G185q3tqMhfgGAIJSVeIQ==
X-Gm-Message-State: AOJu0Yx41AdwrI6KNtKcVs2xFc30EDCTgggAfmNVrjQjvaUlGE4vo7TC
	g6plk4pVzKjmeLdVZrQsr9leTFah8nxRULL0IVq/SMIvgVWk0Iec
X-Google-Smtp-Source: AGHT+IGlykDmbn4myicFVQlbrUlMJK5wpHx4pDcuR+/fuZbd8lLCjgz+ruZ7gvq460VXybZpHu0TEQ==
X-Received: by 2002:a17:90b:607:b0:2a2:55de:93eb with SMTP id gb7-20020a17090b060700b002a255de93ebmr9318567pjb.33.1712676571566;
        Tue, 09 Apr 2024 08:29:31 -0700 (PDT)
Received: from localhost ([2804:30c:1618:ed00:d152:440c:102b:144e])
        by smtp.gmail.com with ESMTPSA id bo3-20020a17090b090300b0029f349cc253sm10081435pjb.54.2024.04.09.08.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:29:30 -0700 (PDT)
Date: Tue, 9 Apr 2024 12:30:09 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add AD4000
Message-ID: <ZhVfARtMfOLOPRid@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1712585500.git.marcelo.schmitt@analog.com>
 <7c877c865f0b7da28d9f1f177b3b2692b0ae20b9.1712585500.git.marcelo.schmitt@analog.com>
 <CAMknhBGKNZhGbD7pQ0Z7SMCWqxqGux0LcO_wW0XGP4hLTOwNBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMknhBGKNZhGbD7pQ0Z7SMCWqxqGux0LcO_wW0XGP4hLTOwNBg@mail.gmail.com>

On 04/08, David Lechner wrote:
> On Mon, Apr 8, 2024 at 9:32 AM Marcelo Schmitt
> <marcelo.schmitt@analog.com> wrote:
> >
> > Add device tree documentation for AD4000 family of ADC devices.
> >
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4000-4004-4008.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4001-4005.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4002-4006-4010.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4003-4007-4011.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
> >
> 
> Suggested-by: David Lechner <dlechner@baylibre.com>
> 
> (if you still use mostly my suggestions in the end)

Yes, it's been of great help. Will include the tag in future ad4000 DT patches.

> 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> >  .../bindings/iio/adc/adi,ad4000.yaml          | 201 ++++++++++++++++++
> >  MAINTAINERS                                   |   7 +
> >  2 files changed, 208 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> > new file mode 100644
> > index 000000000000..ca06afb5149e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> > @@ -0,0 +1,201 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,ad4000.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD4000 and similar Analog to Digital Converters
> > +
> > +maintainers:
> > +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> > +
> > +description: |
> > +  Analog Devices AD4000 family of Analog to Digital Converters with SPI support.
> > +  Specifications can be found at:
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4000-4004-4008.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4001-4005.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4002-4006-4010.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4003-4007-4011.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
> > +
> > +$ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad4000
> > +      - adi,ad4001
> > +      - adi,ad4002
> > +      - adi,ad4003
> > +      - adi,ad4004
> > +      - adi,ad4005
> > +      - adi,ad4006
> > +      - adi,ad4007
> > +      - adi,ad4008
> > +      - adi,ad4010
> > +      - adi,ad4011
> > +      - adi,ad4020
> > +      - adi,ad4021
> > +      - adi,ad4022
> > +      - adi,adaq4001
> > +      - adi,adaq4003
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 102040816 # for VIO > 2.7 V, 81300813 for VIO > 1.7 V
> > +
> > +  spi-cpha: true
> > +
> > +  adi,spi-mode:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: [ single, chain ]
> 
> It sounds like there are more possible wiring configurations for these
> chips that I thought when suggesting reusing this binding from AD7944
> so we probably need more options here. (see my reply to the cover
> letter for the complete context of these remarks)
> 
> We identified A) an additional wiring configuration where SDI of the
> ADC chip is wired to SDO of the SPI controller and B) a potential need
> to pin mux between wiring modes to work around SPI controller
> limitations perhaps we could omit the adi,spi-mode property and just
> use the standard pinctrl properties.
> 
>   pinctrl-names:
>     description: |
>       Names for possible ways the SDI line of the controller is wired.
> 
>       * default: The SDI line of the ADC is connected to the SDO line of the
>         SPI controller.  CNV line of the ADC is connected to CS of the SPI
>         controller.
Not sure if should be DT, but maybe also point out that in default mode the
SPI controller must be capable of keeping ADC SDI (controller SDO) line high
during ADC conversions.

>       * single: The datasheet calls this "3-wire mode".  (NOTE: The datasheet's
>         definition of 3-wire mode is NOT at all related to the standard
>         spi-3wire property!)  In this mode, SDI is tied to VIO, and the CNV line
>         can be connected to the CS line of the SPI controller (typical) or to a
>         GPIO, in which case the CS line of the controller is unused.  The SDO
>         line of the SPI controller is not connected.
>       * multi: The datasheet calls this "4-wire mode" and is used when multiple
>         chips are connected in parallel.  In this mode, the ADC SDI line is tied
>         to the CS line on the SPI controller and the CNV line is connected to
>         a GPIO.  The SDO line of the SPI controller is not connected.
>       * chain: The datasheet calls this "chain mode".  This mode is used to save
>         on wiring when multiple ADCs are used.  In this mode, the SDI line of
>         one chip is tied to the SDO of the next chip in the chain and the SDI of
>         the last chip in the chain is tied to GND.  Only the first chip in the
>         chain is connected to the SPI bus.  The CNV line of all chips are tied
>         together.  The CS line of the SPI controller can be used as the CNV line
>         only if it is active high.
> 
>       If one name is specified, it is assumed the chip is hard-wired in this
>       configuration.
> 
>       If two names are specified, it is assumed that a pinmux can switch between
>       the two wiring configurations.  The first is the default mode for reading
>       and writing registers on the chip and the second is the mode for reading
>       the conversion data from the chip.
>     oneOf:
>       - items:
>           - enum:
>             - default
>             - single
>             - multi
>             - chain
>       - items:
>           - const: default
>           - enum:
>             - single
>             - multi
>             - chain
> 
>   pinctrl-0:
>     maxItems: 1
> 
>   pinctrl-1:
>     maxItems: 1
> 
> 
> > +    description: |
> > +      This property indicates the SPI wiring configuration.
> > +
> > +      When this property is omitted, it is assumed that the device is using what
> > +      the datasheet calls "4-wire mode". This is the conventional SPI mode used
> > +      when there are multiple devices on the same bus. In this mode, the CNV
> > +      line is used to initiate the conversion and the SDI line is connected to
> > +      CS on the SPI controller.
> > +
> > +      When this property is present, it indicates that the device is using one
> > +      of the following alternative wiring configurations:
> > +
> > +      * single: The datasheet calls this "3-wire mode". (NOTE: The datasheet's
> > +        definition of 3-wire mode is NOT at all related to the standard
> > +        spi-3wire property!) This mode is often used when the ADC is the only
> > +        device on the bus. In this mode, SDI is tied to VIO, and the CNV line
> > +        can be connected to the CS line of the SPI controller or to a GPIO, in
> > +        which case the CS line of the controller is unused.
> > +      * chain: The datasheet calls this "chain mode". This mode is used to save
> > +        on wiring when multiple ADCs are used. In this mode, the SDI line of
> > +        one chip is tied to the SDO of the next chip in the chain and the SDI of
> > +        the last chip in the chain is tied to GND. Only the first chip in the
> > +        chain is connected to the SPI bus. The CNV line of all chips are tied
> > +        together. The CS line of the SPI controller can be used as the CNV line
> > +        only if it is active high.
> > +
> > +  '#daisy-chained-devices': true
> > +
> > +  vdd-supply:
> > +    description: A 1.8V supply that powers the chip (VDD).
> > +
> > +  vio-supply:
> > +    description:
> > +      A 1.8V to 5.5V supply for the digital inputs and outputs (VIO).
> > +
> > +  ref-supply:
> > +    description:
> > +      A 2.5 to 5V supply for the external reference voltage (REF).
> > +
> > +  cnv-gpios:
> > +    description:
> > +      The Convert Input (CNV). This input has multiple functions. It initiates
> > +      the conversions and selects the SPI mode of the device (chain or CS). In
> > +      'single' mode, this property is omitted if the CNV pin is connected to the
> > +      CS line of the SPI controller. If 'single' mode is selected and this GPIO
> > +      is provided, it must be active low.
> 
> Since the conversion is triggered on the low to high transition of
> CNV, I think it only makes sense to have it active high and not active
> low.

The idea was to use the GPIO as a replacement for the controller CS when
in "3-wire"/single mode so we could have simpler handling of SPI transfers.
But if changing transfer to avoid latency then this might not simplify anything
anymore. Will probably drop this last line.

> 
> > +    maxItems: 1
> > +
> > +  adi,high-z-input:
> > +    type: boolean
> > +    description:
> > +      High-Z mode allows the amplifier and RC filter in front of the ADC to be
> > +      chosen based on the signal bandwidth of interest, rather than the settling
> > +      requirements of the switched capacitor SAR ADC inputs.
> > +
> > +  adi,gain-milli:
> > +    description: |
> > +      The hardware gain applied to the ADC input (in milli units).
> > +      The gain provided by the ADC input scaler is defined by the hardware
> > +      connections between chip pins OUT+, R1K-, R1K1-, R1K+, R1K1+, and OUT-.
> > +      If not present, default to 1000 (no actual gain applied).
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [454, 909, 1000, 1900]
> > +    default: 1000
> 
> Same suggestion as in V1 - we should make it clear that this property
> only applies to ADAQ chips (in the description and also a -if: for the
> bindings validator). Also, looking at the datasheet, it looks like
> there are a lot more pins on the ADAQ chips, so I think there are more
> properties missing here.
> 
> Some trivial ones:
> 
> vs-pos-supply (VS+ pin, 0 to 11V supply) and vs-neg-supply (VS- pin,
> -11 to 0V supply)
> 
> pd-amp-gpios (active low) and pd-ref-gpios (active low) for optional
> runtime power management.

Ok, will have closer look to these and other pins described in the datasheet and
include them here too.

> 
> Also the datasheet says the ADAQ chips supports "Single-ended to
> differential conversion". So it seems like we might need some extra
> properties to describe that case (a flag for indicating single-ended
> wiring and an optional voltage supply to describe what is connected to
> the negative input if it isn't tied to GND)

Yes, the differential ADCs also support "Single-ended to differential conversion".
Will provide support those too.

