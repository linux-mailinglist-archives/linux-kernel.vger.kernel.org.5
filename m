Return-Path: <linux-kernel+bounces-157622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF16B8B13B8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C86C1C2357E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8229513AD06;
	Wed, 24 Apr 2024 19:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJLpfqld"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAA91772F;
	Wed, 24 Apr 2024 19:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713987814; cv=none; b=F4NO8jlRbAaERtMN0N1no/BN8f/y2stozWnaboXk8YDSqcKCMMcthjfjcsfk/E7Cu1lBxB8tQdt6WIElavqQX6/zHzSJ2xViQm3m1hQA75X50svOWYMhztw0sh+bPtUT0iA41wHDZiRsOKXa18oXDvHWrbbIud+GpBLewyGbxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713987814; c=relaxed/simple;
	bh=vKFYekx4zyI62STnk+FA6F7HSB3eErVD+QjnOQSj1zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+H4CKy808fLGiVJhOVQj2tctgEuSlbrVE44bd55F5bmOGMzFyC2p9+D3RQBt0jWVTfJkYtRNx4Fws/BLkU4m/fnOc8vCJa6pfL7Xdqyj4nTOtNyUxxBN8Rv2INIRnA/pTkx+Z9l99QMQ/GwWX/mZygEldg2TqyUBS1xkrUJyOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJLpfqld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CE8C113CD;
	Wed, 24 Apr 2024 19:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713987814;
	bh=vKFYekx4zyI62STnk+FA6F7HSB3eErVD+QjnOQSj1zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJLpfqld/3oPnXCMuNWmUg+dzsWu9g5aWo3ExrrsKERD1UuKm7b6qJJwf8r47fTSP
	 TOTA8OFSenxTbjqqCgWrfM6h0yzb4/dm9sEX7FpCf59AS6VTYAY0KSMmeqW7/L/Jsa
	 +oPs17OTG2cWSX8qfdrgu65VGgpP+Vjt7WeMzkgNPstKbbOFzVayCpLCunJla1/n+/
	 l85xedaTFLhc/r6hZnmlvO5IvPTE4sToreAqtEKPq4eW9qlTPFlenSfvIuv7w5Wt3o
	 ggC33kausbftez9qr1TZX7mnrSsEVFr8U0h6VPteLc0kwF7ItP7lV5DFcuhII31c9c
	 2yVCBUSJtMT3Q==
Date: Wed, 24 Apr 2024 14:43:31 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Roy Luo <royluo@google.com>, kernel-team@android.com,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/7] dt-bindings: phy: samsung,usb3-drd-phy: add gs101
 compatible
Message-ID: <20240424194331.GA352392-robh@kernel.org>
References: <20240423-usb-phy-gs101-v1-0-ebdcb3ac174d@linaro.org>
 <20240423-usb-phy-gs101-v1-1-ebdcb3ac174d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423-usb-phy-gs101-v1-1-ebdcb3ac174d@linaro.org>

On Tue, Apr 23, 2024 at 06:06:03PM +0100, André Draszik wrote:
> Add a dedicated google,gs101-usb31drd-phy compatible for Google Tensor
> gs101 SoC.
> 
> It needs additional clocks enabled for register access, and additional
> memory regions (PCS & PMA) are required for successful configuration.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
>  .../bindings/phy/samsung,usb3-drd-phy.yaml         | 78 +++++++++++++++++-----
>  1 file changed, 61 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
> index 452e584d9812..db1dc4c60b72 100644
> --- a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
> @@ -25,6 +25,7 @@ description: |
>  properties:
>    compatible:
>      enum:
> +      - google,gs101-usb31drd-phy
>        - samsung,exynos5250-usbdrd-phy
>        - samsung,exynos5420-usbdrd-phy
>        - samsung,exynos5433-usbdrd-phy
> @@ -57,7 +58,18 @@ properties:
>        the OF graph bindings specified.
>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description: PHY register base address.
> +      - description: PCS register base address.
> +      - description: PMA register base address.
> +
> +  reg-names:
> +    minItems: 1
> +    items:
> +      - const: phy
> +      - const: pcs
> +      - const: pma
>  
>    samsung,pmu-syscon:
>      $ref: /schemas/types.yaml#/definitions/phandle
> @@ -85,30 +97,62 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            enum:
> -              - samsung,exynos5433-usbdrd-phy
> -              - samsung,exynos7-usbdrd-phy
> +            const: google,gs101-usb31drd-phy
>      then:
>        properties:
>          clocks:
> -          minItems: 5
> -          maxItems: 5
> -        clock-names:
>            items:
> -            - const: phy
> -            - const: ref
> -            - const: phy_utmi
> -            - const: phy_pipe
> -            - const: itp
> -    else:
> -      properties:
> -        clocks:
> -          minItems: 2
> -          maxItems: 2
> +            - description: Gate of main PHY clock
> +            - description: Gate of PHY reference clock
> +            - description: Gate of control interface AXI clock
> +            - description: Gate of control interface APB clock
> +            - description: Gate of SCL APB clock
>          clock-names:
>            items:
>              - const: phy
>              - const: ref
> +            - const: ctrl_aclk
> +            - const: ctrl_pclk
> +            - const: scl_pclk
> +        reg:
> +          minItems: 3
> +        reg-names:
> +          minItems: 3
> +      required:
> +        - reg-names
> +    else:
> +      if:

We generally try to avoid having nested else/if like this. Please change 
the existing 'else' to an 'if' and then add an 'if' for your new 
compatible.

Rob

