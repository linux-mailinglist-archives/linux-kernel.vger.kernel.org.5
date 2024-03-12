Return-Path: <linux-kernel+bounces-100394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A1C8796DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC4D5B22A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55BD7BAE8;
	Tue, 12 Mar 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ch/HFhvZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6241DFD8;
	Tue, 12 Mar 2024 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710255038; cv=none; b=cRtcYqNi+xAHPDDCs2Hrr4L1nb95ZKAaTkxtkabkEw+PvACfgXgJlqEaCBLReu2pgKMGLeDSJqOHicdEYpeP0Z3XInEf9+J5IjJdNFbobx0CUyzKtKycCOXtcKgmc+f7NBo9y+bZJZEgOUXEAsDNCKjSaWdBt9XW+JbCuf2FX4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710255038; c=relaxed/simple;
	bh=weQH3/gYArkWG361nWx6QB+7+ypFbZg4bPxLz+L6YaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gekihOxWEO6Fvoqxd7ocGsFBvhHbUSNqe0ArzrxSHCuxWSXnEfhwvAwN6857NNQsz4nK4TJIh9AllNWVJfJycdjvubMHvglYyEsYWWXU3St9jg7yT59Ebpi58b6lZ98R7/Q8ZA4v40tO7qCGPjgDS/Dtdb9pfxBQCZBsrctbrPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ch/HFhvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD9DC43394;
	Tue, 12 Mar 2024 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710255037;
	bh=weQH3/gYArkWG361nWx6QB+7+ypFbZg4bPxLz+L6YaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ch/HFhvZSluXRP17dbhV2T8wcG4TrWNoidrLt5OgAwb5ee6GUl58rKrFLKeA9HZSI
	 GGuBtiLqrNsl91nynLWcXj9/uuafLbUew/Qw2K/gxiOWC5T2WzfIwbh07asP7JP8dN
	 wjNdOxeoFkPzuEf4xXVcD10MvH8e/zVggavxjoaGVe9P6Kq2Pi//ilHivKW/Ymr3uG
	 ZD0vmyPh/Q/J/H6lQGyMETa2s5/JYsmhSNG2Bo7BQOq3mX7R5X1vLqVW0zmHrbFctc
	 UfiayyZNXre9mfAjhjEOWiqe+dL2fkw6bxJWxQCLdnOpVyP9DMfgUeeivS4vEj4v70
	 EXxy27b5ukYgw==
Date: Tue, 12 Mar 2024 08:50:35 -0600
From: Rob Herring <robh@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
	shawnguo@kernel.org, conor+dt@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	peter.chen@kernel.org, jun.li@nxp.com, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 05/10] dt-bindings: usb: ci-hdrc-usb2-imx: add
 restrictions for reg, interrupts, clock and clock-names properties
Message-ID: <20240312145035.GA2204647-robh@kernel.org>
References: <20240312091703.1220649-1-xu.yang_2@nxp.com>
 <20240312091703.1220649-5-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312091703.1220649-5-xu.yang_2@nxp.com>

On Tue, Mar 12, 2024 at 05:16:58PM +0800, Xu Yang wrote:
> Add restrictions for reg, interrupts, clock and clock-names properties
> for imx Socs.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v4:
>  - new patch since v3's discussion
>  - split the reg, interrupts, clock and clock-names properties into
>    common part and device-specific
> Changes in v5:
>  - keep common property unchanged
>  - make if-then more readable
>  - remove non imx part
> Changes in v6:
>  - new patch based on ci-hdrc-usb2-imx.yaml
> Changes in v7:
>  - no changes
> Changes in v8:
>  - remove if:else:if:else:if:else block
> ---
>  .../bindings/usb/chipidea,usb2-imx.yaml       | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml b/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
> index cdbb224e9f68..fb1c378dfe88 100644
> --- a/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
> +++ b/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
> @@ -49,6 +49,12 @@ properties:
>            - const: fsl,imx6ul-usb
>            - const: fsl,imx27-usb
>  
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
>    clocks:
>      minItems: 1
>      maxItems: 3
> @@ -144,6 +150,80 @@ allOf:
>              - const: idle
>              - const: active
>  
> +  # imx27 Soc needs three clocks
> +  - if:
> +      properties:
> +        compatible:
> +          const: fsl,imx27-usb
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3
> +          maxItems: 3

The max is already 3, so drop maxItems.

> +        clock-names:
> +          items:
> +            - const: ipg
> +            - const: ahb
> +            - const: per
> +
> +  # imx25 and imx35 Soc need three clocks
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx25-usb
> +              - fsl,imx35-usb
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3
> +          maxItems: 3

Same here.

> +        clock-names:
> +          items:
> +            - const: ipg
> +            - const: ahb
> +            - const: per
> +
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
> +        clock-names:
> +          maxItems: 1

What's the name?

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
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +        clock-names:
> +          maxItems: 1
> +
>  unevaluatedProperties: false
>  
>  examples:
> -- 
> 2.34.1
> 

