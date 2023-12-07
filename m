Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCF38096D2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjLGX47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 18:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLGX45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:56:57 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A9810FC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 15:57:01 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9fbb846b7so16476081fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 15:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701993420; x=1702598220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCO9xsQmxA+zz0fLWQyERmhIN174RlFcf3T1BFbUB/o=;
        b=ybilJOTfi6Qq6HOs3agWBEkiMRV0Y2uZFVcKZUC7tnrN4cWIMarvy/1ryJ535V0PeH
         YJztKRz3P7tkmE70gcPJjyYr/cYSrD+N3wIlg5fAaoDMgXtFptasvGCvAhtcQHMlHlkX
         /1c1O2LIHX0/N4cVsHYzSyoXqRYgvHGkVV5WivnHL0gI5Gzk5MpKXAx9GJYn/2UyymfQ
         ZSS9EnLLDnJDbL+kPFRi9sNdEqXNT38raVUC7GBL7j/QCsLtT4KZ+MAjNe2Eros5NoWW
         L2Ukg6FKlG62/YDeGHiyWKDdcEpEiAYusz/9rXGTkbFuz9qsGBX0rNd3sQfv0ZGZrx1D
         8yPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701993420; x=1702598220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCO9xsQmxA+zz0fLWQyERmhIN174RlFcf3T1BFbUB/o=;
        b=OxJWLVV7XiSIhGFJ120bgZUhE0cV+dZe53jr2NfLI54cmKRTShAfn35hqbWRNjfVcO
         lmibz9cyE5XKtCCCgyHWiQI//7LzrzfXJwiqmPrnONWb+aOjCD8gncO3uRcUKStx2WtQ
         vo4vbgPR0e/i5SKx9ne5vVb47kceviIHiKWu7S85CxBMftqXoW+MUlb6vIBfGSfMib5m
         1U7bz7fdtfF8L7O9PEEZBOpOs7VPXhb44HHlX/Q68Ef2a9Aw3b0WCRpcwx7XRFyrJ3FQ
         +oGkfMIfJNB0RSPProHdGC/HhySjeOI0mXcuYlhko7ONkdjwoEKTJIEk+PdYilvGYys6
         6SZA==
X-Gm-Message-State: AOJu0YzqYoxxtH3b+OpbByWaOrVgKzGsneuWzUHSxGwyozUehtebXhmL
        hZNpRbtKtn9ZWzdx4RwDaXEiy4glvUccDLvoidjCZw==
X-Google-Smtp-Source: AGHT+IEyjluygHw09UGFMiMZ7prFJI/6OqOyKXgeBZFa+o49V2RIKm3uf5+Bs9y/AtDjTBYcfpIqB8tU7KDM9R6mvRk=
X-Received: by 2002:a2e:9859:0:b0:2c9:f962:48f1 with SMTP id
 e25-20020a2e9859000000b002c9f96248f1mr1616613ljj.96.1701993420060; Thu, 07
 Dec 2023 15:57:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com> <53d55f3195b15bd8d47387e296036730ea270770.1701971344.git.marcelo.schmitt1@gmail.com>
In-Reply-To: <53d55f3195b15bd8d47387e296036730ea270770.1701971344.git.marcelo.schmitt1@gmail.com>
From:   David Lechner <dlechner@baylibre.com>
Date:   Thu, 7 Dec 2023 17:56:48 -0600
Message-ID: <CAMknhBEFnTUm9FPK-74+GkJs2d80dS+Q9WeGTxd3Ajs-JJGcdA@mail.gmail.com>
Subject: Re: [PATCH v3 10/13] dt-bindings: iio: Add AD7091R-8
To:     Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com, paul.cercueil@analog.com,
        Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dan.carpenter@linaro.org,
        marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 12:42=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> Add device tree documentation for AD7091R-8.
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7091r8.yaml        | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7091r=
8.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml
> new file mode 100644
> index 000000000000..02320778f225
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7091r8.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7091R8 8-Channel 12-Bit ADC
> +
> +maintainers:
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +
> +description: |
> +  Analog Devices AD7091R-8 8-Channel 12-Bit ADC
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
7091R-2_7091R-4_7091R-8.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7091r2
> +      - adi,ad7091r4
> +      - adi,ad7091r8
> +
> +  reg:
> +    maxItems: 1
> +

Missing other supplies? Like vdd-supply and vdrive-supply?

> +  vref-supply: true

refin-supply might be a better name to match the datasheet pin name.

> +
> +  adi,conversion-start-gpios:

gpios usually don't get a vendor prefix do they?

convst-gpios could be a better name to match the pin name on the datasheet.

> +    description:
> +      GPIO connected to the CONVST pin.
> +      This logic input is used to initiate conversions on the analog
> +      input channels.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1

A description of what the interrupt is attached to (ALERT/BUSY/GPO0
pin) would be helpful.

> +
> +patternProperties:
> +  "^channel@[0-7]$":
> +    $ref: adc.yaml
> +    type: object
> +    description: Represents the external channels which are connected to=
 the ADC.
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 7

Shouldn't this be:

        items:
          - minimum: 0
            maximum: 7

> +
> +    required:
> +      - reg

Missing `unevaluatedProperties: false` for channels?

Bigger picture: since no other properties besides `reg` are included
here, do we actually need channel nodes?

> +
> +required:
> +  - compatible
> +  - reg
> +  - adi,conversion-start-gpios
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +  # AD7091R-2 does not have ALERT/BUSY/GPO pin
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad7091r4
> +              - adi,ad7091r8
> +    then:
> +      properties:
> +        interrupts: true

Interrupts is already true. Maybe better to only match chips without
interrupts and set false?

> +    else:
> +      properties:
> +        interrupts: false
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +                compatible =3D "adi,ad7091r8";
> +                reg =3D <0x0>;
> +                spi-max-frequency =3D <45454545>;
> +                vref-supply =3D <&adc_vref>;
> +                adi,conversion-start-gpios =3D <&gpio 25 GPIO_ACTIVE_LOW=
>;
> +                reset-gpios =3D <&gpio 27 GPIO_ACTIVE_LOW>;
> +                interrupts =3D <22 IRQ_TYPE_EDGE_FALLING>;
> +                interrupt-parent =3D <&gpio>;
> +        };
> +    };
> +...
> --
> 2.42.0
>
>
