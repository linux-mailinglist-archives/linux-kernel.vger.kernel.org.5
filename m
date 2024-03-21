Return-Path: <linux-kernel+bounces-110120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7050885A42
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F141F2225C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA09C84FB3;
	Thu, 21 Mar 2024 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mj1mMVIB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B358AA8;
	Thu, 21 Mar 2024 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711029819; cv=none; b=puZIKZ7yqr6YN/wV/3W4is9POsHcELGgfiBtrzfkRR7hDur9dg07CLP6ZtN86hxtaxw6kbKtDMqb8jm1HvZXnKD1GuU7aUPv9PlcGQBv4Znty3hUSRhz+SiMflboFG7iWkZoJHGlDnZCwwCRG4sDz6pRfCWBrCuzJhN77ThGrXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711029819; c=relaxed/simple;
	bh=EDTfNG01mNck7oovqk3rbelnkIsr/GyWywA2AJy9N/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLX8w+acB+WTUFuXhdJxByDMnHLAjHDMdm42tPG3EPlNN9+8VEnnBRuZyrzp5J7fOy40bcQVIU2CefFTMUx+31kAN1luhIFCw8JA/neqHtI+JPDUhXJp2od1QaOZpKKnSw/AmtEOPKayYD/lljelUDW3uIMARvylifZMHxJiatY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mj1mMVIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18F5C433F1;
	Thu, 21 Mar 2024 14:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711029818;
	bh=EDTfNG01mNck7oovqk3rbelnkIsr/GyWywA2AJy9N/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mj1mMVIB5r4PTJkPy0n1SkwglSpgL+22sXDwmi9LAfniig4nTO04AgnY3ykhGyQw3
	 9MS3Q3UQuO7MZXcMlBo0KvUljxleFvxWcSOTZFO5xZyOCj/YjfDVOwHolqESwN08TB
	 GAjesDKvvZ8ixHOiJ9+9c8AS7fQquIcNvPRygTEAjHUrKy6tA1x9oijKhsPhgcUHjM
	 ZvnwNLPyiM6NzJ1aBQ64iDmws7GaekVGsQ0rjVbqtDQSJ49ph/wkDd7XaoaOPgCi5E
	 GbRzQA2DyQ8s+fLfjpaH3zjerD5/xRhLcgtNNE5SkyLDPddUtRnwdzO9nf+7S14iAz
	 amrCSnkvI+Y4g==
Date: Thu, 21 Mar 2024 09:03:36 -0500
From: Rob Herring <robh@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, peiyu li <579lpy@gmail.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: max6650: convert to dtschema
Message-ID: <20240321140336.GA1648289-robh@kernel.org>
References: <20240320-hwmon_yaml-v1-0-a349ca21ccab@gmail.com>
 <20240320-hwmon_yaml-v1-2-a349ca21ccab@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320-hwmon_yaml-v1-2-a349ca21ccab@gmail.com>

On Wed, Mar 20, 2024 at 06:04:58PM +0100, Javier Carrasco wrote:
>  Convert existing bindings to dtschema to support validation.
> 
>  This is a straightforward conversion with no new properties.

Why the indentation?

> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/hwmon/max6650.txt          | 28 ---------
>  .../devicetree/bindings/hwmon/maxim,max6650.yaml   | 68 ++++++++++++++++++++++
>  2 files changed, 68 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/max6650.txt b/Documentation/devicetree/bindings/hwmon/max6650.txt
> deleted file mode 100644
> index f6bd87d8e284..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/max6650.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -Bindings for MAX6651 and MAX6650 I2C fan controllers
> -
> -Reference:
> -[1]	https://datasheets.maximintegrated.com/en/ds/MAX6650-MAX6651.pdf
> -
> -Required properties:
> -- compatible : One of "maxim,max6650" or "maxim,max6651"
> -- reg        : I2C address, one of 0x1b, 0x1f, 0x4b, 0x48.
> -
> -Optional properties, default is to retain the chip's current setting:
> -- maxim,fan-microvolt : The supply voltage of the fan, either 5000000 uV or
> -			12000000 uV.
> -- maxim,fan-prescale  : Pre-scaling value, as per datasheet [1]. Lower values
> -			allow more fine-grained control of slower fans.
> -			Valid: 1, 2, 4, 8, 16.
> -- maxim,fan-target-rpm: Initial requested fan rotation speed. If specified, the
> -			driver selects closed-loop mode and the requested speed.
> -			This ensures the fan is already running before userspace
> -			takes over.
> -
> -Example:
> -	fan-max6650: max6650@1b {
> -		reg = <0x1b>;
> -		compatible = "maxim,max6650";
> -		maxim,fan-microvolt = <12000000>;
> -		maxim,fan-prescale = <4>;
> -		maxim,fan-target-rpm = <1200>;
> -	};
> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6650.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6650.yaml
> new file mode 100644
> index 000000000000..1b33b5fb606d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6650.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/maxim,max6650.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX6650 and MAX6651 I2C Fan Controllers
> +
> +maintainers:
> +  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
> +
> +description: |
> +  The MAX6650 and MAX6651 regulate and monitor the speed
> +  of 5VDC/12VDC burshless fans with built-in tachometers.
> +
> +  Datasheets:
> +    https://datasheets.maximintegrated.com/en/ds/MAX6650-MAX6651.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max6650
> +      - maxim,max6651
> +
> +  reg:
> +    maxItems: 1
> +
> +  maxim,fan-microvolt:
> +    description:
> +      The supply voltage of the fan, either 5000000 uV or
> +      12000000 uV.

Looks like constraints. Please add them.

> +
> +  maxim,fan-prescale:
> +    description:
> +      Pre-scaling value, as per datasheet. Lower values
> +      allow more fine-grained control of slower fans.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8, 16]
> +
> +  maxim,fan-target-rpm:
> +    description:
> +      Initial requested fan rotation speed. If specified, the
> +      driver selects closed-loop mode and the requested speed.
> +      This ensures the fan is already running before userspace
> +      takes over.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Constraints? I'm sure no fan RPM is higher than 10000 and probably much 
less than that.

Rob

