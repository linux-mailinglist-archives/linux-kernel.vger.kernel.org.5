Return-Path: <linux-kernel+bounces-126663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFA2893B2E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD191C20D6A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA0B3EA74;
	Mon,  1 Apr 2024 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9tDxF+B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B8C1E888;
	Mon,  1 Apr 2024 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711976630; cv=none; b=efrPEvKDrnglGvmhYf0rmq1tKwf/SbKb7zMjDo5C68QfVKD3R0yBaWPfpA0EAzgeZZwzF62Hysmzmursy/a8YlN9VAGMCOVAUp7IOetpjEXXh4LgmmqegPFq5XSKetphAP70b8y0e6G2uvaC+lFEE+1s7/GHTWa3ZIVM/tTN+eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711976630; c=relaxed/simple;
	bh=6IX8cDFUlSsk6IxtbhcF68yxgznuBZCAUSinqNSI60Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TL2whoBUq9rL4IQyYOEjNJ9s8cLnvFwJMvl0v+OSvQ2V3IpgOpGRGmxZFB6KjxMz0mVrex/cMx+hvt9OJ4jR6ygcfZLPJXzdFGk1r3htJ7L24qneeWTAv7KKH5t31glw6+t8c43KZFF2spw5x6qa/s/Nnt+tDI9Q2Q0cJzwHw4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9tDxF+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F3AC43390;
	Mon,  1 Apr 2024 13:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711976629;
	bh=6IX8cDFUlSsk6IxtbhcF68yxgznuBZCAUSinqNSI60Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t9tDxF+B/kICX01tgWTInIvIoSP9ORRRD9KOxwP84iHOUi0SKK/Ie42RUnp7t63FN
	 HVqjkZ5KlC6r9xKWCl/PeAJMG/KIh5KXuih4+kiHghdkd8/st153SMr/ZNhz+ZL23p
	 D6EuKGrsL+Ai1zBEWIcpOvcddijki3UnjLotM8odP4gXTf7VBLo8n3OihiTeVz6O/V
	 93Vr1FFFPxCnRAvBkZ9v758Qjjkohp6VSPznDAbcnaGecnpbMEcO5WLl7vGxIXqsxs
	 CUw4xRe+JpxokeW//OF/xQU0Z3nndTfOdl9EVWPpGm58X/UdaltgtXdup/n47CR6ru
	 8Mu87fvXgThzg==
Date: Mon, 1 Apr 2024 08:03:47 -0500
From: Rob Herring <robh@kernel.org>
To: Patrick Gansterer <paroga@paroga.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: backlight: Add Texas Instruments
 LM3509
Message-ID: <20240401130347.GA274540-robh@kernel.org>
References: <20240330145931.729116-1-paroga@paroga.com>
 <20240330145931.729116-2-paroga@paroga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330145931.729116-2-paroga@paroga.com>

On Sat, Mar 30, 2024 at 03:59:24PM +0100, Patrick Gansterer wrote:
> Add Device Tree bindings for Texas Instruments LM3509 - a
> High Efficiency Boost for White LED's and/or OLED Displays
> 
> Signed-off-by: Patrick Gansterer <paroga@paroga.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  .../bindings/leds/backlight/ti,lm3509.yaml    | 139 ++++++++++++++++++
>  1 file changed, 139 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3509.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,lm3509.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,lm3509.yaml
> new file mode 100644
> index 000000000000..b67f67648852
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/ti,lm3509.yaml
> @@ -0,0 +1,139 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/ti,lm3509.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI LM3509 High Efficiency Boost for White LED's and/or OLED Displays
> +
> +maintainers:
> +  - Patrick Gansterer <paroga@paroga.com>
> +
> +description:
> +  The LM3509 current mode boost converter offers two separate outputs.
> +  https://www.ti.com/product/LM3509
> +
> +properties:
> +  compatible:
> +    const: ti,lm3509
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  ti,brightness-rate-of-change-us:
> +    description: Brightness Rate of Change in microseconds.
> +    enum: [51, 13000, 26000, 52000]
> +
> +  ti,oled-mode:
> +    description: Enable OLED mode.
> +    type: boolean
> +
> +patternProperties:
> +  "^led@[01]$":
> +    type: object
> +    description: Properties for a string of connected LEDs.
> +
> +    allOf:

You don't need allOf here.

> +      - $ref: common.yaml#
> +
> +    properties:
> +      reg:
> +        description:
> +          The control register that is used to program the two current sinks.
> +          The LM3509 has two registers (BMAIN and BSUB) and are represented
> +          as 0 or 1 in this property. The two current sinks can be controlled
> +          independently with both registers, or register BMAIN can be
> +          configured to control both sinks with the led-sources property.
> +        minimum: 0
> +        maximum: 1
> +
> +      label: true
> +
> +      led-sources:
> +        allOf:

Or here.

> +          - minItems: 1
> +            maxItems: 2
> +            items:
> +              minimum: 0
> +              maximum: 1

