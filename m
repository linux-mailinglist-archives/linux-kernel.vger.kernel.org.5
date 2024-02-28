Return-Path: <linux-kernel+bounces-85154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C362A86B136
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B25DB250BF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1FE15699F;
	Wed, 28 Feb 2024 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKDX7KBg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB86B73519;
	Wed, 28 Feb 2024 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709129066; cv=none; b=PPwvPhBZAqjSzNbFkDj44aLnN26adWZQtWkreE7Oss4tdM2Vtc5GTKsDtMFLB62713zDLSRBgvQg9YSUaDF0VgKZcMgjJbCDKU7i2OKGgAtI95pStKA+En8aqBSQEPluD6gMTG9tSaJ/Rg6ci8+/nE25R2GiKF0DrnXllcRJEWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709129066; c=relaxed/simple;
	bh=1TNs0fPzFGmAK5ia7YQLux8YLRF98MfBzG5OMhCcGM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWe3nDRwUXXIpr2eVRzkCFIxKFWhPZheA5x/dHyCrYk0BO2YSiqAebaojwPIE6wId+OMIuIQ35F7rS9/wk5XCGoI3HlvtzoPtxW2qdgUh3dGTnpjYAS9QjH0mMoEYINre4tfa8JhiWeK9sDbPkDV2e5+bGH5N4X1CdS0B8FIyNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKDX7KBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6D3C433C7;
	Wed, 28 Feb 2024 14:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709129065;
	bh=1TNs0fPzFGmAK5ia7YQLux8YLRF98MfBzG5OMhCcGM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jKDX7KBgYqbzMtDmkJ6Mvp1hBbuEdwg5HQ4yXy4A59ZtmNsk1IyZqaT77v3Sd1PQO
	 wtFSDD+0qIO+MdDBI9W9qimMuqCm93Sxp+YigNBweI84DCVvRX2fdlF+fW9zYktFlA
	 keEFpEJQ36q5Pzs392eSo7v+LjOpu3+M03OUGs81e4yLzJjmM9MziE+bHAdmoyR6OX
	 vY/YFqgG3cXST7XeRzYISct/t5U16EwJdu/tSyS1WGuSKhr9rUI1GAIO+k424hPpmG
	 NE45X2jfxekJgafPybZZ0oHvbf7yxtEvNqPwOb5dhYFN1Vgqd4yDFudUy6uVR9pDxD
	 3U+EWOd6jZczQ==
Date: Wed, 28 Feb 2024 08:04:23 -0600
From: Rob Herring <robh@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andy@kernel.org, geert@linux-m68k.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, ojeda@kernel.org,
	tzimmermann@suse.de, javierm@redhat.com, robin@protonic.nl,
	lee@kernel.org, pavel@ucw.cz, devicetree@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] dt-bindings: auxdisplay: Add bindings for generic
 7 segment LED
Message-ID: <20240228140423.GA3307293-robh@kernel.org>
References: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz>
 <20240227212244.262710-3-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227212244.262710-3-chris.packham@alliedtelesis.co.nz>

On Wed, Feb 28, 2024 at 10:22:42AM +1300, Chris Packham wrote:
> Add bindings for a generic 7 segment LED display using GPIOs.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v2:
>     - Use compatible = "generic-gpio-7seg" to keep checkpatch.pl happy
> 
>  .../auxdisplay/generic-gpio-7seg.yaml         | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/generic-gpio-7seg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/auxdisplay/generic-gpio-7seg.yaml b/Documentation/devicetree/bindings/auxdisplay/generic-gpio-7seg.yaml
> new file mode 100644
> index 000000000000..46d53ebdf413
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/auxdisplay/generic-gpio-7seg.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/auxdisplay/generic,gpio-7seg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GPIO based LED segment display
> +
> +maintainers:
> +  - Chris Packham <chris.packham@alliedtelesis.co.nz>
> +
> +properties:
> +  compatible:
> +    const: generic-gpio-7seg

'generic' doesn't add anything of value. 7seg is kind of vague. So, 
gpio-7-segment?


> +
> +  segment-gpios:
> +    description:
> +      An array of GPIOs one per segment.
> +    minItems: 7

How does one know which GPIO is which segment?

Rob

