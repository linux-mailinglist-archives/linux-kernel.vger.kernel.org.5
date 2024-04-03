Return-Path: <linux-kernel+bounces-130256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5EF897605
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A852283273
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAAC152DE6;
	Wed,  3 Apr 2024 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tb5w0YDG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267C36E60F;
	Wed,  3 Apr 2024 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164404; cv=none; b=QsDk5qJmF5Zpj8hoe91qLy0ScRiXJCQQDTjbO1LOE9JyA34QVgo7zu3hJQpEnhY8EI22bxZ8dP3ter/27U2JhwfXMHntlsQuhXqNd7wMlfA2t0Srk3ABw9MQ4yr8rz1zhB8KyW8RCVjdjaLhiIdHAh211iWwRCwEnw/2BchMWsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164404; c=relaxed/simple;
	bh=iDTAlDyhhR24NhTX+LufgKRCpVJp7F5FVJPBKNDeZXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lk8jxUPjgrlH7bSa019FKZ2MfqD/X66j2GutwFHo+pNNbYmLOACei0cWO8dxGpnkp+OYSxE+EVFDnmD3yL1l6c0YK7z53q6radMTqroaW+eXtFbS+CbX5jLTzpk4M/Sftr+wZmtBasd1SqaZWn04NmtJbjNMLbLULIzBSqRThEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tb5w0YDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639AFC433F1;
	Wed,  3 Apr 2024 17:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164403;
	bh=iDTAlDyhhR24NhTX+LufgKRCpVJp7F5FVJPBKNDeZXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tb5w0YDGe4x+imn77oCq7en/5vXnu1PuX2SN6Yqg+ZNVugpAHzKHObawruVxu5sVX
	 IBzzZhKicpNFzkAWWF0aed24aA3Ed99diLIAIjUDDY/ToweyWoiCNH/EJ3ImFBnOYo
	 oYjQq8oSJb4st8TstbqOakzA2cntQfiMmDogL9bEtNnnIsCOoVdfRif8RtEvjghM1Q
	 lzO4XQP/rlgL7DE+klootx5667C7jOoof9fcdk881uoRfpCIAB3vZX1JspBLBu3Sf5
	 kUoYcuXIlLpN+CA72QAVnK6v/RfUwOzSjuE+H3PxOwtc9NFiyZsePxcZlTx7ronxCS
	 4W05MzHEeYVdg==
Date: Wed, 3 Apr 2024 12:13:21 -0500
From: Rob Herring <robh@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: wim@linux-watchdog.org, linux@roeck-us.net,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	joel@jms.id.au, zev@bewilderbeest.net,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: watchdog: aspeed,ast2400-wdt: Convert to
 DT schema
Message-ID: <20240403171321.GA3996007-robh@kernel.org>
References: <20240403020439.418788-1-andrew@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403020439.418788-1-andrew@codeconstruct.com.au>

On Wed, Apr 03, 2024 at 12:34:39PM +1030, Andrew Jeffery wrote:
> Squash warnings such as:
> 
> ```
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb@1e600000/watchdog@1e785000: failed to match any schema with compatible: ['aspeed,ast2400-wdt']
> ```
> 
> The schema binding additionally defines the clocks property over the
> prose binding to align with use of the node in the DTS files.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
> v2: Address feedback from Rob and Zev
> 
>     - Rob: https://lore.kernel.org/linux-watchdog/20240402180718.GA358505-robh@kernel.org/
>     - Zev: https://lore.kernel.org/linux-watchdog/65722a59-2e94-4616-81e1-835615b0e600@hatter.bewilderbeest.net/
> 
> v1: https://lore.kernel.org/linux-watchdog/20240402120118.282035-1-andrew@codeconstruct.com.au/
> 
>  .../bindings/watchdog/aspeed,ast2400-wdt.yaml | 142 ++++++++++++++++++
>  .../bindings/watchdog/aspeed-wdt.txt          |  73 ---------
>  2 files changed, 142 insertions(+), 73 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml b/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
> new file mode 100644
> index 000000000000..be78a9865584
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
> @@ -0,0 +1,142 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed watchdog timer controllers
> +
> +maintainers:
> +  - Andrew Jeffery <andrew@codeconstruct.com.au>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2400-wdt
> +      - aspeed,ast2500-wdt
> +      - aspeed,ast2600-wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: >

You don't need '>' either. I guess it is equivalent here as there are no 
double newlines. Drop these if you respin, otherwise:

Reviewed-by: Rob Herring <robh@kernel.org>

