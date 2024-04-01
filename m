Return-Path: <linux-kernel+bounces-126995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D158B89458C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9B71F21DB8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CAB5337F;
	Mon,  1 Apr 2024 19:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XnqFa7q2"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B40F1EB37
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000286; cv=none; b=cb/q+KIn/EkKr49q4LtievjcTsixYVylllUJuB6/VDMDCKxYRXYvjpHJfKLzZPV3mVml6PCc0fQjTMtwwQRHx+f4rF4Z20xw3gYf7FAIgVnDXb0SQiv31/ghZgDw2nCZ0QyD/NpdkzGRPB/eXlzY8DA3GKv7umvNNZaRurDYqy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000286; c=relaxed/simple;
	bh=kAU0aYIXhgkFLYZSUSg5PZ1VapVsVEfo2juD1x2+LDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppX33oFiLeJx3gIJd451BXvkaQClo2D6I1ol4kCuPrGApTJnx/tMTGiwOC+O9ihr7Gi6hnTCWPr4IJQD8MtTzSrayPYFTy1f2k3PLJhI4uUwaWcGVI0YR3lTV3eDd0Z/3fX1+niYeCfWq1Qrn98RsWvKysVe5CvUDZDCyzBzGd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XnqFa7q2; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so60748581fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 12:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712000281; x=1712605081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ud/NuSHYkcJgOcZcI1q1wClx6fmxezAeXXOYZJFZkjI=;
        b=XnqFa7q2kaUbh9akksIsO9vGrmTzNSofNeX5i4+JyFzL3ABvQjWYeAkAUZtrYBFIu8
         EMDZJSMQuFnZwuD4iSm8SVLp2lX/Onzu+xtesypCAPmKqKSq19pZnniJNgIUA7bUfpOe
         CyWmWkLktJMCilb9LTChYDECqlskNDmw1SzeFmpiB+ABuAAkCPwqs8vaoHCzxFmduF2q
         gqK6UV0ZI2GB/2XbyQDUrhYbHFwejKjc8OWNN5rndcfz4FKAwmfd1NiVvRr2higpg+8V
         zFQR7rnszjsuzD+eoUzw3c/c+MBRNaJLh8/vQRNKr/DQ/vl3LnNE0xF4PAlL+MoGHuA6
         Vufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000282; x=1712605082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ud/NuSHYkcJgOcZcI1q1wClx6fmxezAeXXOYZJFZkjI=;
        b=mMFvEhd8U0ZfdhmpQzVF+BBTWbK/ejzOo4TrZE9tsIFXkzqOh/bA6WDg0ngNc5CCat
         JkmE1jN/EqMEzJN4hQ3qtd8yI7dddQjjq3ho/6bgJB8La9OXbWR5TEBgaupQ+jSZJLV0
         Hw2Nku6Gymh+LWv3eS38GGSIz82qUgo7RW9kUY8PYELkR4+pk2Rh5i9LUWIYaV2184yc
         /qJTQqz6W2v0Mw3EkpGjBIcrJ6zIwTCe1UJMzNsX5ydk/5Wafe+ELE/QnHNjzS3uYN1G
         Q3GTdF2Oq/YxeVIYrXUp+nM9tHuWf08VrfOy7f4/RGAl+XtyIMFFezE/lzYLwU1rmlQJ
         osdg==
X-Forwarded-Encrypted: i=1; AJvYcCXPBBYtqISxDxLYUfu9ZAoy7R9F3Uq8DjgwmHFndVafRGXPDfsNkxwL9BdMhDR0g9upsz41AMFdhVIokmNHG8fYXJAr5qRgU7ZslnHb
X-Gm-Message-State: AOJu0YyJn2UcQMoePDQar/FKG3fMRjvrR5Ic0NJYFy9qcVqTGVlq9wVt
	cquTctV5NcdbadE3nWcGWczZUEWGxirVozj8e5orL7pW8q+969mxxZBkwQbYj9qddlpYY0WGBPx
	4vaO9vCgctM/6oUAlNPboPOartAkwcT/BhJbZAPDvIx7sfTVq
X-Google-Smtp-Source: AGHT+IHJqJKfosHVyevU1aS9w9uyqWtEP/uOltOm2hMAeNUcdIJ/rohrq7G8IwsDoE0Ec3PQkk44ZH18XA6mCtX/SFg=
X-Received: by 2002:a2e:98d8:0:b0:2d8:113c:d58 with SMTP id
 s24-20020a2e98d8000000b002d8113c0d58mr3269028ljj.20.1712000281529; Mon, 01
 Apr 2024 12:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com> <20240401-ad4111-v1-1-34618a9cc502@analog.com>
In-Reply-To: <20240401-ad4111-v1-1-34618a9cc502@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 1 Apr 2024 14:37:50 -0500
Message-ID: <CAMknhBHeKAQ45=5-dL1T1tv-mZcPN+bNo3vxWJYgWpEPE+8p3Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: adc: ad7173: add support for ad411x
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
<devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>
> Add support for: AD4111, AD4112, AD4114, AD4115, AD4116.
>
> AD411x family ADCs support a VCOM pin, dedicated for single-ended usage.
> AD4111/AD4112 support current channels, usage is implemented by
>  specifying channel reg values bigger than 15.
>
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7173.yaml    | 59 ++++++++++++++++=
+++++-
>  1 file changed, 57 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> index ea6cfcd0aff4..bba2de0a52f3 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> @@ -19,7 +19,18 @@ description: |
>    primarily for measurement of signals close to DC but also delivers
>    outstanding performance with input bandwidths out to ~10kHz.
>
> +  Analog Devices AD411x ADC's:
> +  The AD411X family encompasses a series of low power, low noise, 24-bit=
,
> +  sigma-delta analog-to-digital converters that offer a versatile range =
of
> +  specifications. They integrate an analog front end suitable for proces=
sing
> +  fully differential/single-ended and bipolar voltage inputs.
> +
>    Datasheets for supported chips:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4111.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4112.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4114.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4115.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4116.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7172-2.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7172-4.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7173-8.pdf
> @@ -31,6 +42,11 @@ description: |
>  properties:
>    compatible:
>      enum:
> +      - adi,ad4111
> +      - adi,ad4112
> +      - adi,ad4114
> +      - adi,ad4115
> +      - adi,ad4116
>        - adi,ad7172-2
>        - adi,ad7172-4
>        - adi,ad7173-8
> @@ -125,10 +141,19 @@ patternProperties:
>
>      properties:
>        reg:
> +        description:
> +          Reg values 16-19 are only permitted for ad4111/ad4112 current =
channels.
>          minimum: 0
> -        maximum: 15
> +        maximum: 19

This looks wrong. Isn't reg describing the number of logical channels
(# of channel config registers)?

After reviewing the driver, I see that > 16 is used as a way of
flagging current inputs, but still seems like the wrong way to do it.
See suggestion below.

>
>        diff-channels:
> +        description:
> +          For using current channels specify only the positive channel.
> +            (IIN2+, IIN2=E2=88=92) -> diff-channels =3D <2 0>

I find this a bit confusing since 2 is already VIN2 and 0 is already
VIN0. I think it would make more sense to assign unique channel
numbers individually to the negative and positive current inputs.
Also, I think it makes sense to use the same numbers that the
registers in the datasheet use (8 - 11 for negative and 12 to 15 for
positive).

So: (IIN2+, IIN2=E2=88=92) -> diff-channels =3D <13 10>


> +
> +          Family AD411x supports a dedicated VCOM voltage input.
> +          To select it set the second channel to 16.
> +            (VIN2, VCOM) -> diff-channels =3D <2 16>

The 411x datasheets call this pin VINCOM so calling it VCOM here is a
bit confusing.

Also, do we need to add a vincom-supply to get this voltage? Or is it
safe to assume it is always connected to AVSS? The datasheet seems to
indicate that the latter is the case. But then it also has this
special case (at least for AD4116, didn't check all datasheets)
"VIN10, VINCOM (single-ended or differential pair)". If it can be used
as part of a fully differential input, we probably need some extra
flag to indicate that case.

Similarly, do we need special handling for ADCIN15 on AD4116? It has a
"(pseudo differential or differential pair)" notation that other
inputs don't. In other words, it is more like VINCOM than it is to the
other ADCINxx pins. So we probably need an adcin15-supply for this pin
to properly get the right channel configuration. I.e. the logic in the
IIO driver would be if adcin15-supply is present, any channels that
use this input are pseudo-differential, otherwise any channels that
use it are fully differential.

>          items:
>            minimum: 0
>            maximum: 31
> @@ -166,7 +191,6 @@ allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
>
>    # Only ad7172-4, ad7173-8 and ad7175-8 support vref2
> -  # Other models have [0-3] channel registers

Did you forget to remove

            reg:
              maximum: 3

from this if statement that this comment is referring to?


>    - if:
>        properties:
>          compatible:
> @@ -187,6 +211,37 @@ allOf:
>                  - vref
>                  - refout-avss
>                  - avdd
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad4114
> +              - adi,ad4115
> +              - adi,ad4116
> +              - adi,ad7173-8
> +              - adi,ad7175-8
> +    then:
> +      patternProperties:
> +        "^channel@[0-9a-f]$":
> +          properties:
> +            reg:
> +              maximum: 15

As with the previous reg comment, this if statement should not be
needed since maximum should not be changed to 19.

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad7172-2
> +              - adi,ad7175-2
> +              - adi,ad7176-2
> +              - adi,ad7177-2
> +    then:
> +      patternProperties:
> +        "^channel@[0-9a-f]$":
> +          properties:
>              reg:
>                maximum: 3

It looks to me like AD7172-4 actually has 8 possible channels rather
than 16. So it would need a special condition as well. But that is a
bug in the previous bindings and should therefore be fixed in a
separate patch.

