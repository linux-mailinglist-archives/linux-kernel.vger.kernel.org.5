Return-Path: <linux-kernel+bounces-7144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA0B81A22D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D721C20B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B4741841;
	Wed, 20 Dec 2023 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzUyk4tN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD2D4C3BC;
	Wed, 20 Dec 2023 15:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BCBC433CA;
	Wed, 20 Dec 2023 15:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703085418;
	bh=kbZ8Z22LWHTtUccjSUa1Yoqq/QsxCB9CBO/jZv+JC8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YzUyk4tNc1EhXC9S1JGsjUghj0ibkMs9QQsOwaK6bZpgHUUqpQ3DAuaKtxd2vNIEv
	 nJbQrW3jwQ8sfcXhkueQl4LLVSmNmCyscYEQKP4cGpOY2taNAwYB9g/LGID4zL0a+8
	 GyzmxZaX2pJER8NGIPTvyXo4i7HPmq2fgXGT5LI0goOkk62+zRi9E6f6mIaNu1448R
	 1UUdn5exPf1ccKGyX34AZzITKnDN8qAPg6ZiBAOtJA4nSagEYXXeeMpHcod1DP+/VN
	 qKXn8veGLyC06x4XTnhIaH1uuEyMU8Cq81oPtpCMv8Csy54ndeSc33rhJz0UJklBgZ
	 b2mRO+L/fnApw==
Date: Wed, 20 Dec 2023 15:16:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: pressure: honeywell,mprls0025pa
Message-ID: <20231220151645.16ada807@jic23-huawei>
In-Reply-To: <20231219130230.32584-2-petre.rodan@subdimension.ro>
References: <20231219130230.32584-1-petre.rodan@subdimension.ro>
	<20231219130230.32584-2-petre.rodan@subdimension.ro>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 15:02:20 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> ChangeLog

The whole patch description describes changes, so no need for a Changelog heading.

>  - add honeywell,pressure-triplet property that autoconfigures pmin, pmax
>     just like the hsc030pa sensor driver

Why?  Needs an explanation of why this binding is better and easier to use
+ how backwards compatibility is maintained.

>  - add support for spi-based sensors
> 
Two things, two patches.

> Datasheet:

It's a formal tag, so no line break (Even if checkpatch complains!)

> https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
>  .../iio/pressure/honeywell,mprls0025pa.yaml   | 60 ++++++++++++++++---
>  1 file changed, 52 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
> index d9e903fbfd99..7c4be2dec174 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
> +++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
> @@ -53,33 +53,59 @@ properties:
>    honeywell,pmin-pascal:
>      description:
>        Minimum pressure value the sensor can measure in pascal.
> +      To be specified only if honeywell,pressure-triplet is set to "NA".
That just added a backwards compatibility break.  It would be fine
if there was a default: NA for honeywell,pressure-triplet or a check that either
one or the other was supplied (which I'd prefer).  Thus old bindings will work
and new ones also supported.

>  
>    honeywell,pmax-pascal:
>      description:
>        Maximum pressure value the sensor can measure in pascal.
> +      To be specified only if honeywell,pressure-triplet is set to "NA".
>  
>    honeywell,transfer-function:
>      description: |
> -      Transfer function which defines the range of valid values delivered by the
> -      sensor.
> +      Transfer function which defines the range of valid values delivered by
> +      the sensor.
>        1 - A, 10% to 90% of 2^24 (1677722 .. 15099494)
>        2 - B, 2.5% to 22.5% of 2^24 (419430 .. 3774874)
>        3 - C, 20% to 80% of 2^24 (3355443 .. 13421773)
> +    enum: [1, 2, 3]
>      $ref: /schemas/types.yaml#/definitions/uint32
>  
> +  honeywell,pressure-triplet:
> +    description: |
> +      Case-sensitive five character string that defines pressure range, unit
> +      and type as part of the device nomenclature. In the unlikely case of a
> +      custom chip, set to "NA" and provide pmin-pascal and pmax-pascal.

Should not need to set to NA, just don't provide it.

> +    enum: [0001BA, 01.6BA, 02.5BA, 0060MG, 0100MG, 0160MG, 0250MG, 0400MG,
> +           0600MG, 0001BG, 01.6BG, 02.5BG, 0100KA, 0160KA, 0250KA, 0006KG,
> +           0010KG, 0016KG, 0025KG, 0040KG, 0060KG, 0100KG, 0160KG, 0250KG,
> +           0015PA, 0025PA, 0030PA, 0001PG, 0005PG, 0015PG, 0030PG, 0300YG,
> +           NA]
> +    $ref: /schemas/types.yaml#/definitions/string
> +
> +  spi-max-frequency:
> +    maximum: 800000
> +
>    vdd-supply:
>      description: provide VDD power to the sensor.
>  
>  required:
>    - compatible
>    - reg
> -  - honeywell,pmin-pascal
> -  - honeywell,pmax-pascal
> +  - honeywell,pressure-triplet
>    - honeywell,transfer-function
> -  - vdd-supply
>  
>  additionalProperties: false
>  
> +dependentSchemas:
> +  honeywell,pmin-pascal:
> +    properties:
> +      honeywell,pressure-triplet:
> +        const: NA
> +  honeywell,pmax-pascal:
> +    properties:
> +      honeywell,pressure-triplet:
> +        const: NA
> +
>  examples:
>    - |
>      #include <dt-bindings/gpio/gpio.h>
> @@ -93,10 +119,28 @@ examples:
>              reg = <0x18>;
>              reset-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
>              interrupt-parent = <&gpio3>;
> -            interrupts = <21 IRQ_TYPE_EDGE_FALLING>;
> -            honeywell,pmin-pascal = <0>;
> -            honeywell,pmax-pascal = <172369>;
> +            interrupts = <21 IRQ_TYPE_EDGE_RISING>;
> +
> +            honeywell,pressure-triplet = "0025PA";
>              honeywell,transfer-function = <1>;
>              vdd-supply = <&vcc_3v3>;
>          };
>      };
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pressure@0 {
> +            compatible = "honeywell,mprls0025pa";
> +            reg = <0>;
> +            spi-max-frequency = <800000>;
> +            reset-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <30 IRQ_TYPE_EDGE_RISING>;
> +
> +            honeywell,pressure-triplet = "0015PA";
> +            honeywell,transfer-function = <1>;
> +        };
> +    };
> +...


