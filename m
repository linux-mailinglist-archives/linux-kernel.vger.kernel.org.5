Return-Path: <linux-kernel+bounces-58691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E895F84EA03
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E69B28F397
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CB24C3BC;
	Thu,  8 Feb 2024 21:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T1xQahhz"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9497A48CD1
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707426138; cv=none; b=FTM0/P8EOUkeXhqqpm8AapuPlDzqL2Q9rcNTD7hMUNOhcOdL8EW9H4EYwpJq+Mkh5v6xvJyXrK6kdr+ua2RNvEwgdmkrlAoBvt4N3MfKJLChPVx3BU3POkl125R0d7BsWMV5LZ6BfoqOELEi9B92CGwu2NCcStDmplOOOt8hvWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707426138; c=relaxed/simple;
	bh=MPrJBQh0W6C64dmzyrjqYpEo6yYMroytIsZryjcV2xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhNxiHY9SmWxj/seegJoGmxO6Jdk22+QLdpPbh8dY/wNXg1RChC//CFxzAIKjNRNYk7mo1SoEGsF4eZ3O1BQhMzEHX2QzKcHivsO4i2A70bLSv4eaeL5nUUeBQ5GpeM6i7MEfEYwkpvFIyImabX0BfgMWH0HmqUPW6YAjkwzJOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T1xQahhz; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso3065171fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 13:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707426133; x=1708030933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvjjVV3OVJFdrzwIkpIwh6ZmUksDN+MlaodV5B8GHkw=;
        b=T1xQahhzu1/VM2C03o7nTHgQLkWg3fbs62zGpOKGVS3VsJt6D9EMXqUQbm0F84gzvf
         emw602XVAV3QF7+zEfuC/JqzUExHrMEqkcxUymH13912dbVVEh4jsJWgZ5qlm3V3ERbf
         KKi3BrpYpX4enwtgAojLD0QfpTm7Pve68dKUxaDLqVTi1jlhuZUSQ1+IQuy/a3UUQmQ+
         KiAYeELgmwAxaa6GaHqxUXixTKeYcedLyJAPInqrY05YbF0Zrsnn/aRIRVWJXCu1Sksk
         +GWP9U71H+AJlCcg1vO+TBsm0xXiQuljhDCE9ph3CgVw4D0qoRlurrcaW8N+tWZYoOwL
         YH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707426133; x=1708030933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvjjVV3OVJFdrzwIkpIwh6ZmUksDN+MlaodV5B8GHkw=;
        b=Gh7VbmpEF/4xeSD8YBAnBvz3pw/cKIaLQe66TE5Uk1IrRS2XhKaF7M3r4a2Ob5loq4
         Ni29YkGVOzaD6RvOpP+MYXfCFvZB7ccWeSNP4UheflvWw5aPj+5Ks74yLGdJ3Mgzx7mU
         2AkKPngucAZ9TChe0WaL4vQVqk+bH8JA5oHg9txvjp71wzgDalgHzQ5uOaXI+qHKsoiV
         9fW3Ff6Vrxj094KdNK9qCgI9WxSgnMBZtnSjiDVpZPVD/rH4nO/4mAjDlGbuQOOvnone
         CaNuxl5cFRZ/UVnJ3u6VVQFq0sYewYzXZDLWR/ac0pU5WkTmPBvUFGiWB4qm4m8mfm/T
         zGPg==
X-Forwarded-Encrypted: i=1; AJvYcCUjjou1hDpKkcr4xEW/MlyBbJuLSTyUELuscVDp/U4wME/JQ/dpOd5GwC27AMqsbiCvDBPg/qPN3hTS9xJKNQQT3lZIHryrMSP+MCoG
X-Gm-Message-State: AOJu0YyXjmRwjgPMmfHY1TCTnb17qrryqIk+vcQMLBSc8t/x+S7jJA35
	NhnkNfJ/b1Li3RFTTxOXB+NlaVQr1dpch/gNpbbFqOrvk/c67GxmtJP2/8gSC0eCJUIFZ9yDO1T
	Fz43cFduuDN8HvogTxqGnXGmAf4I7k+pbXG6iVA==
X-Google-Smtp-Source: AGHT+IEmOae9wjka2hbpxlHm4kKA6Qy7H854xuj1LZpVQ0vWiZs28kTzmDWZLUiDYbmoFUh7D3xPfCz302NM5h7HR7c=
X-Received: by 2002:a2e:8550:0:b0:2d0:d294:60f3 with SMTP id
 u16-20020a2e8550000000b002d0d29460f3mr336715ljj.37.1707426133301; Thu, 08 Feb
 2024 13:02:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208172459.280189-1-alisa.roman@analog.com> <20240208172459.280189-5-alisa.roman@analog.com>
In-Reply-To: <20240208172459.280189-5-alisa.roman@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 8 Feb 2024 15:02:02 -0600
Message-ID: <CAMknhBGauvnrNipcAoVrM5xnTHWoHyYuzDxmz=AY9_QHigwsAQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: iio: adc: ad7192: Add AD7194 support
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: alexandru.tachici@analog.com, alisa.roman@analog.com, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org, 
	lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.hennerich@analog.com, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 11:25=E2=80=AFAM Alisa-Dariana Roman
<alisadariana@gmail.com> wrote:
>
> Unlike the other AD719Xs, AD7194 has configurable differential
> channels. The default configuration for these channels can be changed
> from the devicetree.
>
> Also add an example for AD7194 devicetree.
>
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7192.yaml          | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index 16def2985ab4..169bdd1dd0e1 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -21,8 +21,15 @@ properties:
>        - adi,ad7190
>        - adi,ad7192
>        - adi,ad7193
> +      - adi,ad7194
>        - adi,ad7195
>
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
>    reg:
>      maxItems: 1
>
> @@ -96,8 +103,44 @@ required:
>    - spi-cpol
>    - spi-cpha
>
> +patternProperties:
> +  "^channel@([0-7a-f])$":
> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        description: The channel index.
> +        minimum: 0
> +        maximum: 7

Should the max be 16 since in pseudo-differential mode there can be up
to 16 inputs?

> +
> +      diff-channels:
> +        description: |
> +          The differential channel pair for Ad7194 configurable channels=
 The

all caps: AD7194

> +          first channel is the positive input, the second channel is the
> +          negative input.
> +        items:
> +          minimum: 1
> +          maximum: 16

As someone who would need to write a .dts based on these bindings, the
information I would find helpful in the description here is that this
is specifying how the logical channels are mapped to the 16 possible
input pins. It seems safe to assume that the values 1 to 16 correspond
to the pins AIN1 to AIN16, but it would be nice to say this
explicitly. And what do we do when using pseudo-differential inputs
where AINCOM is used as the negative input? Use 0?

> +
> +    required:
> +      - reg
> +      - diff-channels
> +
>  allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - adi,ad7190
> +            - adi,ad7192
> +            - adi,ad7193
> +            - adi,ad7195
> +    then:
> +      patternProperties:
> +        "^channel@([0-7a-f])$": false
>
>  unevaluatedProperties: false
>
> @@ -127,3 +170,35 @@ examples:
>              adi,burnout-currents-enable;
>          };
>      };
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +            compatible =3D "adi,ad7194";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <1000000>;
> +            spi-cpol;
> +            spi-cpha;
> +            clocks =3D <&ad7192_mclk>;
> +            clock-names =3D "mclk";
> +            interrupts =3D <25 0x2>;
> +            interrupt-parent =3D <&gpio>;
> +            dvdd-supply =3D <&dvdd>;
> +            avdd-supply =3D <&avdd>;
> +            vref-supply =3D <&vref>;
> +
> +            channel@0 {
> +                reg =3D <0>;
> +                diff-channels =3D <1 6>;
> +            };
> +
> +            channel@1 {
> +                reg =3D <1>;
> +                diff-channels =3D <2 5>;
> +            };
> +        };
> +    };
> --
> 2.34.1
>

