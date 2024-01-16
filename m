Return-Path: <linux-kernel+bounces-27450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC2182F043
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D266B22F04
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A481BDF1;
	Tue, 16 Jan 2024 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGQDl3PZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2681BF20;
	Tue, 16 Jan 2024 14:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331B7C43390;
	Tue, 16 Jan 2024 14:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705413996;
	bh=3K34axS1U2QPc0Dc0vgU79Rd/znytCwH56crKKfqXqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OGQDl3PZQuinRffGMkMz58USHXL9QR+uAXLfXFw7E31b7dPr7wlqv7I2gVD+enpWB
	 Krj47gTJf4N5mu0B1YAQLK7f3qZrD5LNDCzmbUDtq8KzqB4LE/iWXVX7t0vpb7+4wM
	 +iGQNth/SIWBEZ5FZ9kjeVIJny9hvEN7mLt4sCET2XPe/UofadLaMnsRtzN9LCiyA0
	 Ga+Ccik8+QD/bn2WzhA/j/RLBUxjoe5DW1ZnDOg53n5jsYaH9LZp9JFmueuf+CVw23
	 gKEaIN+FSDXuDyNzfDqNA/aSi67xZA0cBmvnAGBMTIWHK5Y9m3LicpinVXN5AKa4fe
	 49sQxik8DfNDg==
Date: Tue, 16 Jan 2024 08:06:34 -0600
From: Rob Herring <robh@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: iio: hmc425a: add conditional GPIO
 array size constraints
Message-ID: <20240116140634.GA3817501-robh@kernel.org>
References: <20240115133023.3465-1-mitrutzceclan@gmail.com>
 <20240115133023.3465-2-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115133023.3465-2-mitrutzceclan@gmail.com>

On Mon, Jan 15, 2024 at 03:30:14PM +0200, Dumitru Ceclan wrote:
> ADRF5740 and HMC540S have a 4 bit parallel interface.
> Update ctr-gpios description and min/maxItems values depending on the

ctrl-gpios

> matched compatible to correctly reflect the hardware properties.
> 
> Fixes: 79f2ff6461e7 ("dt-bindings: iio: hmc425a: add entry for ADRF5740 Attenuator")
> Fixes: 20f87a9a26be ("dt-bindings: iio: hmc425a: add entry for HMC540S")
> 

No blank line here.

> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---
>  .../bindings/iio/amplifiers/adi,hmc425a.yaml  | 33 +++++++++++++++++--
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> index 67de9d4e3a1d..a434cb8ddcc9 100644
> --- a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> +++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> @@ -33,11 +33,38 @@ properties:
>  
>    ctrl-gpios:
>      description:
> -      Must contain an array of 6 GPIO specifiers, referring to the GPIO pins
> -      connected to the control pins V1-V6.
> -    minItems: 6
> +      Must contain an array of GPIO specifiers, referring to the GPIO pins
> +      connected to the control pins.
> +        ADRF5740  - 4 GPIO connected to D2-D5
> +        HMC540S   - 4 GPIO connected to V1-V4
> +        HMC425A   - 6 GPIO connected to V1-V6
> +    minItems: 1
>      maxItems: 6
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,hmc425a
> +    then:
> +      properties:
> +        ctrl-gpios:
> +          minItems: 6
> +          maxItems: 6
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            anyOf:
> +              - const: adi,adrf5740
> +              - const: adi,hmc540s
> +    then:
> +      properties:
> +        ctrl-gpios:
> +          minItems: 4
> +          maxItems: 4
> +
>  required:
>    - compatible
>    - ctrl-gpios
> -- 
> 2.42.0
> 

