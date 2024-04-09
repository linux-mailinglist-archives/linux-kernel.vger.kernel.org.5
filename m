Return-Path: <linux-kernel+bounces-136154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBBD89D08F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A3E282520
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F06D5466E;
	Tue,  9 Apr 2024 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Tnx7eNah"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3E654676
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 02:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712631437; cv=none; b=Hj8M9YOh2mgacFY/ar8zRigJ/CYeQ4Aejvb4ozTIbaX2eBWZohdcaPt89zcAILcyz3NrysDvQjrLsykKPLUtJ7h54OPJ1eN61dlsQZpnv7jmzfSfW/FgnpqGJ72NHZGUSYAamZNGbycVzr+oMd1SMtgxNwgC44KmCZwWgGISPLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712631437; c=relaxed/simple;
	bh=GXgy3D19Jmy+ZElcf6OzQKj4z//+/uSjztVnU0INY14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAsu4ml01cXvUO3FLYHga/Ka1uJxsY5ckfExW4cPSbKpxhaT1xd7FP52bujw7/dyIJCF/qYAvFBfu80Wh9/EdDbgOR5qK8GkazhDX5KAKVUSCEluUteLhFncRzS96N1+RXGL/415dg/oedEzuCgV7ZBOPDT00W9xvEcBuk/ECLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Tnx7eNah; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d6c9678cbdso66835161fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 19:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712631433; x=1713236233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMkhUrq0dHh3BVa5TCrKH8G2EJVYRVx8BZxFyRplNXE=;
        b=Tnx7eNahedoWm6HpfcYELTZzXuiUX9/pbq7rf2Yx13Tf2v5ycPFLMI5A3fsTLtMlWP
         QY2Bn3idESaDcjv3OhGOkBS8EIQr8jcG/2WTv9UKma6ocI+yPeQ8S1TgR9q8nK4MUZRE
         YiDK5hyGJyxiEtRYtsoocsyFHRV0wNsCMGzxHirkPju1YLaMz2wF7rq0M1woHpQfAahs
         N9s+hVEWvHZj1WA09II4Bo0qe5JSEsGYlIhwSN9cNQHvRVVGSRxR96hWXai1BNVauxCg
         mSmCPQ6g/3iI0V6xyhq6+Pn0PB0iqy2zlLQd/JE7Uk0eYQmqylV9IyviVetmK2WuOb9v
         nnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712631433; x=1713236233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMkhUrq0dHh3BVa5TCrKH8G2EJVYRVx8BZxFyRplNXE=;
        b=XHY08+2/OikA4OgZnTirQ8ojMXUG//M1AazMpNcIetuyPJ22jHBT2xwQSQgl3q/Zvy
         8hgf96YRWc5764xwvaYedGM4DZLgqUR3RXmftE0ZJuDW6SybEgtfigkeemokw2NT1egA
         VLK7Tjls3AgC/HyT8QNV45JNGLJ/kdoI9WzI0aUGlKM+DpJ1+N2sqokvbW2q3SOcYdTK
         wWRfp3LSBXKRf51LpSNMOBgmVRGZsBYJJbDDh+t/ol6Dp0hjYI049BR+49HZMrf41ayA
         GbakPzwEyyFyBD6//g+NjoYE8CdBJujTYEGyigiN3FvaYGCHTEyDSjeCmnAxTSsNGZ+/
         GDBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTf73HQwjjiOkPhV7SYYwiVYYYacHSEf3cLBNLlQEm7GVIxDfse288FPG0IIiaC2YvYai1CPO+2F+2zTTR+2uWv/vD7h/UOXnrGWrB
X-Gm-Message-State: AOJu0Yz7uCF+Up3KIcYOA6Z8MSHnSWWxqm31h6mRzKvJQveSJfrN6nPo
	Saw8jpdsL96/rKjKNJ6zEpAEnzGCYXOfgYwGbKBDMluDwTRKSN955vPtEu1KK5ycBJGzYM4Haqs
	Bdd+Q86e69ixRht2FjrMrgBaW+lPRZBJxC4Olvg==
X-Google-Smtp-Source: AGHT+IEbWcT33vONJvtIvt4iYl4X7oi5SXfzHXGifOFeQmxXEYX5nZZCtNpOWL+Qac2KzQVtiExE/N/Sx6axxWObJ9k=
X-Received: by 2002:a2e:8894:0:b0:2d8:59cb:89ef with SMTP id
 k20-20020a2e8894000000b002d859cb89efmr6670865lji.24.1712631433527; Mon, 08
 Apr 2024 19:57:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712585500.git.marcelo.schmitt@analog.com> <7c877c865f0b7da28d9f1f177b3b2692b0ae20b9.1712585500.git.marcelo.schmitt@analog.com>
In-Reply-To: <7c877c865f0b7da28d9f1f177b3b2692b0ae20b9.1712585500.git.marcelo.schmitt@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 8 Apr 2024 21:57:02 -0500
Message-ID: <CAMknhBGKNZhGbD7pQ0Z7SMCWqxqGux0LcO_wW0XGP4hLTOwNBg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add AD4000
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 9:32=E2=80=AFAM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> Add device tree documentation for AD4000 family of ADC devices.
>
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/ad4000-4004-4008.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/ad4001-4005.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/ad4002-4006-4010.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/ad4003-4007-4011.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/ad4020-4021-4022.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/adaq4001.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/adaq4003.pdf
>

Suggested-by: David Lechner <dlechner@baylibre.com>

(if you still use mostly my suggestions in the end)

> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad4000.yaml          | 201 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 208 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.=
yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> new file mode 100644
> index 000000000000..ca06afb5149e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> @@ -0,0 +1,201 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD4000 and similar Analog to Digital Converters
> +
> +maintainers:
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +
> +description: |
> +  Analog Devices AD4000 family of Analog to Digital Converters with SPI =
support.
> +  Specifications can be found at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4000-4004-4008.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4001-4005.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4002-4006-4010.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4003-4007-4011.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4020-4021-4022.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
adaq4001.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
adaq4003.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad4000
> +      - adi,ad4001
> +      - adi,ad4002
> +      - adi,ad4003
> +      - adi,ad4004
> +      - adi,ad4005
> +      - adi,ad4006
> +      - adi,ad4007
> +      - adi,ad4008
> +      - adi,ad4010
> +      - adi,ad4011
> +      - adi,ad4020
> +      - adi,ad4021
> +      - adi,ad4022
> +      - adi,adaq4001
> +      - adi,adaq4003
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 102040816 # for VIO > 2.7 V, 81300813 for VIO > 1.7 V
> +
> +  spi-cpha: true
> +
> +  adi,spi-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ single, chain ]

It sounds like there are more possible wiring configurations for these
chips that I thought when suggesting reusing this binding from AD7944
so we probably need more options here. (see my reply to the cover
letter for the complete context of these remarks)

We identified A) an additional wiring configuration where SDI of the
ADC chip is wired to SDO of the SPI controller and B) a potential need
to pin mux between wiring modes to work around SPI controller
limitations perhaps we could omit the adi,spi-mode property and just
use the standard pinctrl properties.

  pinctrl-names:
    description: |
      Names for possible ways the SDI line of the controller is wired.

      * default: The SDI line of the ADC is connected to the SDO line of th=
e
        SPI controller.  CNV line of the ADC is connected to CS of the SPI
        controller.
      * single: The datasheet calls this "3-wire mode".  (NOTE: The datashe=
et's
        definition of 3-wire mode is NOT at all related to the standard
        spi-3wire property!)  In this mode, SDI is tied to VIO, and the CNV=
 line
        can be connected to the CS line of the SPI controller (typical) or =
to a
        GPIO, in which case the CS line of the controller is unused.  The S=
DO
        line of the SPI controller is not connected.
      * multi: The datasheet calls this "4-wire mode" and is used when mult=
iple
        chips are connected in parallel.  In this mode, the ADC SDI line is=
 tied
        to the CS line on the SPI controller and the CNV line is connected =
to
        a GPIO.  The SDO line of the SPI controller is not connected.
      * chain: The datasheet calls this "chain mode".  This mode is used to=
 save
        on wiring when multiple ADCs are used.  In this mode, the SDI line =
of
        one chip is tied to the SDO of the next chip in the chain and the S=
DI of
        the last chip in the chain is tied to GND.  Only the first chip in =
the
        chain is connected to the SPI bus.  The CNV line of all chips are t=
ied
        together.  The CS line of the SPI controller can be used as the CNV=
 line
        only if it is active high.

      If one name is specified, it is assumed the chip is hard-wired in thi=
s
      configuration.

      If two names are specified, it is assumed that a pinmux can switch be=
tween
      the two wiring configurations.  The first is the default mode for rea=
ding
      and writing registers on the chip and the second is the mode for read=
ing
      the conversion data from the chip.
    oneOf:
      - items:
          - enum:
            - default
            - single
            - multi
            - chain
      - items:
          - const: default
          - enum:
            - single
            - multi
            - chain

  pinctrl-0:
    maxItems: 1

  pinctrl-1:
    maxItems: 1


> +    description: |
> +      This property indicates the SPI wiring configuration.
> +
> +      When this property is omitted, it is assumed that the device is us=
ing what
> +      the datasheet calls "4-wire mode". This is the conventional SPI mo=
de used
> +      when there are multiple devices on the same bus. In this mode, the=
 CNV
> +      line is used to initiate the conversion and the SDI line is connec=
ted to
> +      CS on the SPI controller.
> +
> +      When this property is present, it indicates that the device is usi=
ng one
> +      of the following alternative wiring configurations:
> +
> +      * single: The datasheet calls this "3-wire mode". (NOTE: The datas=
heet's
> +        definition of 3-wire mode is NOT at all related to the standard
> +        spi-3wire property!) This mode is often used when the ADC is the=
 only
> +        device on the bus. In this mode, SDI is tied to VIO, and the CNV=
 line
> +        can be connected to the CS line of the SPI controller or to a GP=
IO, in
> +        which case the CS line of the controller is unused.
> +      * chain: The datasheet calls this "chain mode". This mode is used =
to save
> +        on wiring when multiple ADCs are used. In this mode, the SDI lin=
e of
> +        one chip is tied to the SDO of the next chip in the chain and th=
e SDI of
> +        the last chip in the chain is tied to GND. Only the first chip i=
n the
> +        chain is connected to the SPI bus. The CNV line of all chips are=
 tied
> +        together. The CS line of the SPI controller can be used as the C=
NV line
> +        only if it is active high.
> +
> +  '#daisy-chained-devices': true
> +
> +  vdd-supply:
> +    description: A 1.8V supply that powers the chip (VDD).
> +
> +  vio-supply:
> +    description:
> +      A 1.8V to 5.5V supply for the digital inputs and outputs (VIO).
> +
> +  ref-supply:
> +    description:
> +      A 2.5 to 5V supply for the external reference voltage (REF).
> +
> +  cnv-gpios:
> +    description:
> +      The Convert Input (CNV). This input has multiple functions. It ini=
tiates
> +      the conversions and selects the SPI mode of the device (chain or C=
S). In
> +      'single' mode, this property is omitted if the CNV pin is connecte=
d to the
> +      CS line of the SPI controller. If 'single' mode is selected and th=
is GPIO
> +      is provided, it must be active low.

Since the conversion is triggered on the low to high transition of
CNV, I think it only makes sense to have it active high and not active
low.

> +    maxItems: 1
> +
> +  adi,high-z-input:
> +    type: boolean
> +    description:
> +      High-Z mode allows the amplifier and RC filter in front of the ADC=
 to be
> +      chosen based on the signal bandwidth of interest, rather than the =
settling
> +      requirements of the switched capacitor SAR ADC inputs.
> +
> +  adi,gain-milli:
> +    description: |
> +      The hardware gain applied to the ADC input (in milli units).
> +      The gain provided by the ADC input scaler is defined by the hardwa=
re
> +      connections between chip pins OUT+, R1K-, R1K1-, R1K+, R1K1+, and =
OUT-.
> +      If not present, default to 1000 (no actual gain applied).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [454, 909, 1000, 1900]
> +    default: 1000

Same suggestion as in V1 - we should make it clear that this property
only applies to ADAQ chips (in the description and also a -if: for the
bindings validator). Also, looking at the datasheet, it looks like
there are a lot more pins on the ADAQ chips, so I think there are more
properties missing here.

Some trivial ones:

vs-pos-supply (VS+ pin, 0 to 11V supply) and vs-neg-supply (VS- pin,
-11 to 0V supply)

pd-amp-gpios (active low) and pd-ref-gpios (active low) for optional
runtime power management.

Also the datasheet says the ADAQ chips supports "Single-ended to
differential conversion". So it seems like we might need some extra
properties to describe that case (a flag for indicating single-ended
wiring and an optional voltage supply to describe what is connected to
the negative input if it isn't tied to GND)

