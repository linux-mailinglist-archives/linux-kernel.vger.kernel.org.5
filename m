Return-Path: <linux-kernel+bounces-157601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 027498B136E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22A628440A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F8F7580C;
	Wed, 24 Apr 2024 19:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIIuMGv7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A85568A;
	Wed, 24 Apr 2024 19:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986296; cv=none; b=TW1t0NAmLQFHrFT0zb2u66XwEqtjxFaUpkb9kuDHweObAoQUzIYqQb+U34EkU4wmvYjrO57ubPgeCuJ8xdeotTTj/sxcWb8BvU+4PxyZWzkCftj7+U4LueRgQzUb9lL8Y1mZIO39nltmEyvpGNaxLqpGwuCIy4OYboRN5b9GRAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986296; c=relaxed/simple;
	bh=UnAUwzO2559vcgVgMa9POjX+k5ATpzHsJexpuTT9rDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQ4P5a4yV1l2aDRl5c25upInf3QpMMUwQYRiLEGR4n9JwrqK85QUNTFEg54jP7H1LVu/ZKuRp9bNFwLx68YgtJPrIy3iJDlmAunMkzQbcxDcw3h/HNKF1+XtR5fdvgC3a01XuGNFXEdzzoztWm3/WraF20cX5CplryZ9pqpN/ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIIuMGv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054C1C113CD;
	Wed, 24 Apr 2024 19:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713986296;
	bh=UnAUwzO2559vcgVgMa9POjX+k5ATpzHsJexpuTT9rDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pIIuMGv7o31zrYHjWo3wlKbj/vwHzyrgML3IfBH/6UvhS+DWLVYfHQYeWPvkGG30T
	 R9ojRaKkVQMNHk66hRglCLuK4bcfLTMO2igPFnOZXpHtNuGTkXgT/gmSTK4hOruOmF
	 7e21MDbtyvfZUU12ZriKBT82Q0SL5+hrAFjGsitjooEqty9msYew3SOM/I3Tr7pb0D
	 t1PfbPJA+kyixyhrGDTqHVD37U/PLey29GBHGOSKEf7yAUl7z6sVggEf1De1DFYkgo
	 3g8s1j5w0eXFaVaxUk8WVJJiaWU2OK4jT2Qn/ybQADpjjqh85XCtIjCdauCHWH+qm3
	 DXpCI8V2RR6xA==
Date: Wed, 24 Apr 2024 14:18:13 -0500
From: Rob Herring <robh@kernel.org>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: git@amd.com, gregkh@linuxfoundation.org, jirislaby@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, michal.simek@amd.com,
	p.zabel@pengutronix.de, laurent.pinchart@ideasonboard.com,
	radhey.shyam.pandey@amd.com, parth.gajjar@amd.com,
	u.kleine-koenig@pengutronix.de, tglx@linutronix.de,
	julien.malik@unseenlabs.fr, ruanjinjie@huawei.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srinivas.goud@amd.com, shubhrajyoti.datta@amd.com,
	manion05gk@gmail.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH V2 1/3] dt-bindings: serial: cdsn,uart: Add optional
 reset property
Message-ID: <20240424191813.GA324342-robh@kernel.org>
References: <20240424112933.3528590-1-manikanta.guntupalli@amd.com>
 <20240424112933.3528590-2-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424112933.3528590-2-manikanta.guntupalli@amd.com>

On Wed, Apr 24, 2024 at 04:59:31PM +0530, Manikanta Guntupalli wrote:
> Add optional reset device-tree property to the uartps controller.

Typo in the subject.

> 
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changes for V2:
> Added ack signature.
> ---
>  Documentation/devicetree/bindings/serial/cdns,uart.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> index 2129247d7c81..d7f047b0bf24 100644
> --- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> @@ -46,6 +46,9 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  resets:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.25.1
> 

