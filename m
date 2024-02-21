Return-Path: <linux-kernel+bounces-74990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB9685E0E5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40181F24363
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9609480610;
	Wed, 21 Feb 2024 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMGyCEkB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00F87F7DA;
	Wed, 21 Feb 2024 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528949; cv=none; b=Mxs3TDUUphblV4lI/gfwPKv+SutYfGyw0aVrvNUntRST7cnMdH/TyDOicKSKN47326nlavF3YPfOxPcZ70QerOtFnyaq/9G9ATCKOvXXSYDKxAT3+hETd39/9pOKP2zxL72f9q/9NEuYerVKd2zueAixYEBWGbY6LvBtPSIENW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528949; c=relaxed/simple;
	bh=TCtBpdIY7450Ty+SdGZtoT1IyppeoEDJ8gGAm0LnTiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDKFGEebFGc0lzWZFVRniqnVLM2XtTCwSHd777HZn9YpouD1zo2E9uikYk1ZhC25fOGYbUSKhNIehA56zO+XDYmQHUsZ6+wjDLYYgPW+y7JhiqSLA5dtoRd76S7TookBeEuq4p6t2ocoJLaeUjgpFq1N2DCllEft3vZRvVtZqgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMGyCEkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5EBC433F1;
	Wed, 21 Feb 2024 15:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708528949;
	bh=TCtBpdIY7450Ty+SdGZtoT1IyppeoEDJ8gGAm0LnTiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MMGyCEkBJYH1XwA80dc+qUCu/cOXpEl3HiZXgftka+aMyQbtI3GIlyhflIWpSZLe3
	 iGDsz3jH4054EU0NKQv0fEJ7P/kTV2kusLyGo+Ws9keDj1mnLeGazBq3cmiYPvEtZF
	 roD9hoj4iqu6Qh+iCsuosQVpsei+XZHMw4NnsFFE6atsvo07Gy+ouAZG1Hs6a3BRH9
	 9B67sx7ijI39SgJX2fX9fk49wlYljyxe6qnCxcVChR8dkeGuMWpdcy3hhyI1b8e1zM
	 C5aO8WeTqtqEbiPNl9w/p2yG0X0p5R3XVcFGZYEsMemAGlenhaPrXinHPw+KNmgRJP
	 4zdBYxpn+/yJw==
Date: Wed, 21 Feb 2024 08:22:26 -0700
From: Rob Herring <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add ad7944 ADCs
Message-ID: <20240221152226.GA2868707-robh@kernel.org>
References: <20240216-ad7944-mainline-v2-0-7eb69651e592@baylibre.com>
 <20240216-ad7944-mainline-v2-1-7eb69651e592@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240216-ad7944-mainline-v2-1-7eb69651e592@baylibre.com>

On Fri, Feb 16, 2024 at 01:46:18PM -0600, David Lechner wrote:
> This adds a new binding for the Analog Devices, Inc. AD7944, AD7985, and
> AD7986 ADCs.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7944.yaml    | 204 +++++++++++++++++++++
>  MAINTAINERS                                        |   8 +
>  2 files changed, 212 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
> new file mode 100644
> index 000000000000..61ee81326660
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
> @@ -0,0 +1,204 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7944.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices PulSAR LFCSP Analog to Digital Converters
> +
> +maintainers:
> +  - Michael Hennerich <Michael.Hennerich@analog.com>
> +  - Nuno Sá <nuno.sa@analog.com>
> +
> +description: |
> +  A family of pin-compatible single channel differential analog to digital
> +  converters with SPI support in a LFCSP package.
> +
> +  * https://www.analog.com/en/products/ad7944.html
> +  * https://www.analog.com/en/products/ad7985.html
> +  * https://www.analog.com/en/products/ad7986.html
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7944
> +      - adi,ad7985
> +      - adi,ad7986
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 111111111
> +
> +  spi-cpol: true
> +  spi-cpha: true
> +
> +  adi,spi-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ single, multi, chain ]
> +    default: multi
> +    description: |
> +      * single: The datasheet calls this "3-wire mode". It is often used when
> +        the ADC is the only device on the bus. In this mode, SDI is tied to VIO,
> +        and the CNV line can be connected to the CS line of the SPI controller
> +        or to a GPIO, in which case the CS line of the controller is unused.

We have a standard property for this.

> +      * multi: The datasheet calls this "4-wire mode". This is the convential
> +        SPI mode used when there are multiple devices on the same bus. In this
> +        mode, the CNV line is used to initiate the conversion and the SDI line
> +        is connected to CS on the SPI controller.

That's "normal" mode.

> +      * chain: The datasheet calls this "chain mode". This mode is used to save
> +        on wiring when multiple ADCs are used. In this mode, the SDI line of
> +        one chip is tied to the SDO of the next chip in the chain and the SDI of
> +        the last chip in the chain is tied to GND. Only the first chip in the
> +        chain is connected to the SPI bus. The CNV line of all chips are tied
> +        together. The CS line of the SPI controller is unused.

Don't you need to know how many chips are chained? In any case, you just 
need a property for chain mode. There's some existing properties for 
chained devices I think. Standard logic shift register based GPIO IIRC.

CNV are tied together, but must be driven by something? I suppose 
cnv-gpios? But wouldn't that be the same as the SPI controller GPIO CS? 
Does a SPI controller CS line connected to CNV not work in this case?

Rob

