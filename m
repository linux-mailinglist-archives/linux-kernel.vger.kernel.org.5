Return-Path: <linux-kernel+bounces-105536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A19BC87DFD7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5642B1F212EC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708981F941;
	Sun, 17 Mar 2024 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwOMIzsF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1201CD1F;
	Sun, 17 Mar 2024 19:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710705328; cv=none; b=PNUpTGsUgZUK0ZxVCaX8Bluix0Qmbt7JkyJV2G0oA9MA4UBwrTzIbxl9VD/EfCZ4tzI5yxKTYe87N1wzN5N5wt3BzECtw/miPF1IQ9gSCfeuDiulidHoZ4h1mvY/q72XNb9o4cgceTEipfEBSAWt2bF67IVMOhocXmSncGXfvj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710705328; c=relaxed/simple;
	bh=b6x9vDguIZN9njueij/R2IbOVFqm1TOTgS02u4bLeZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3UDMmgl5PMkX+MqnwusRpwRQoXAST+E7BeLK7A3a5Ce36G/KrBOpOAJBXYlEPfW5KBP6S0JpiKgAuBONcoLUhIc7ZYrRBSeekcPManKAuiQ7B7/lVVVjFjPsn1B0G3nHcOpF89wqD7YnXIzJsP3i0Xpgn//4CUR0PkgeyEwORI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwOMIzsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A58C433F1;
	Sun, 17 Mar 2024 19:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710705328;
	bh=b6x9vDguIZN9njueij/R2IbOVFqm1TOTgS02u4bLeZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GwOMIzsFPOibjwk1GUWaCLTNCXtZJA3dLjffqrk2nnjvKoOrxyGhgSuCu240UmKdZ
	 kBID0sUIboA+Y7Pq6Vjqe+AJaEZfExO6DJO/XrwyCsw+U/L1JZDuFiYpaqSPsbtXzn
	 Zyf3i/mIrKT3axFOwkO9raAlRmIRKkwm/YT05Ple0zIFQbzOrKokcm1DzbWZt55A6X
	 3fZWKssyP7nBBxkBz5bQG4XwGJUbpl2cwCy8UYHiUHR2guUVzU7Rzw3eI8TAZMy4JN
	 v7UwGRumIzNaL2VoV8HXe1JefKhOY6Zl6EpRtg+v5JVYcHS8Vyma6L/d0NAc1NIaEc
	 mey9RsnANPQQw==
Date: Sun, 17 Mar 2024 13:55:24 -0600
From: Rob Herring <robh@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
	shawnguo@kernel.org, conor+dt@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	peter.chen@kernel.org, jun.li@nxp.com, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 05/11] dt-bindings: usb: ci-hdrc-usb2-imx: add
 restrictions for reg, interrupts, clock and clock-names properties
Message-ID: <20240317195524.GA2109053-robh@kernel.org>
References: <20240315072455.2481613-1-xu.yang_2@nxp.com>
 <20240315072455.2481613-5-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315072455.2481613-5-xu.yang_2@nxp.com>

On Fri, Mar 15, 2024 at 03:24:49PM +0800, Xu Yang wrote:
> Add restrictions for reg, interrupts, clock and clock-names properties
> for imx Socs.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---

[...]

> +  # imx7d Soc need one clock
> +  - if:
> +      properties:
> +        compatible:
> +          items:
> +            - const: fsl,imx7d-usb
> +            - const: fsl,imx27-usb
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +        clock-names: false
> +
> +  # other Soc need one clock
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx23-usb
> +              - fsl,imx28-usb
> +              - fsl,imx50-usb
> +              - fsl,imx51-usb
> +              - fsl,imx53-usb
> +              - fsl,imx6q-usb
> +              - fsl,imx6sl-usb
> +              - fsl,imx6sx-usb
> +              - fsl,imx6ul-usb
> +              - fsl,imx8mm-usb
> +              - fsl,imx8mn-usb
> +              - fsl,vf610-usb

Can't you add 'fsl,imx7d-usb' here and drop the previous if/then?

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +        clock-names: false
> +
>  unevaluatedProperties: false
>  
>  examples:
> -- 
> 2.34.1
> 

