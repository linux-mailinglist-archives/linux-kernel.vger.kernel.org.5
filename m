Return-Path: <linux-kernel+bounces-157661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3464A8B142A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86760B216EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66D013CAB3;
	Wed, 24 Apr 2024 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1r8frj1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDCE1772F;
	Wed, 24 Apr 2024 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989468; cv=none; b=h0PNnCbFgKAfWKGhYrP55ld2o+oHTE0ibkjc7cwIYA8Vzq5HMrOfl16vKJxraDTChOeEYqzlA61kCFWAYDEdh6ufeVykz5lR0A40oW1rzLBQRiqiBR/rEPYHg2PlhgznfW4ItyjPo0MtpCo5h21AZ54mlKwzVBgbRmXw2me5XLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989468; c=relaxed/simple;
	bh=x3GHFC5BJuYldoD0tBI34oiwHd0Wr2pV7QJt4WPiLto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGWbMDbF6QVSEw3Hq13g89j7etIQ6ArgDLFX1Yp4+H9seGs6le/htf2KznJY4ccxXCA/ojp40L5lolHPFUYLDuPS9BxhXRJ3jvuDAl7fq3hFpKuX7fv9XNKdp3eIW0pW0L553WsOYRzywjy0zzkcdKJKNOCcK8b74plfdze3Vjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1r8frj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7A2C113CD;
	Wed, 24 Apr 2024 20:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713989467;
	bh=x3GHFC5BJuYldoD0tBI34oiwHd0Wr2pV7QJt4WPiLto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r1r8frj1jZ/haQSWw19cJ7Tapp8PhJpCaFEiZKfhubdSrEL6XAOni1hTtDHK27kJC
	 gq/5epJz1JAHtkT3bfmyXJiJYuY1je20YrNDggHiyeWwgvUCsP5mfUkJSKXcKeghh3
	 MPD67Y1rG57etkA4YYv8hEe1j95pJVtDRjHeOYgH/66kJYI2O/61GGP0HTFRc3Y2Oc
	 F9qHSWheUJq2wlwidEH/MNyl9RMBOYewxUQplKnEOzc0nwt1Vnr8b+e6FsSo9X7WBc
	 yF+wxq9XyT6i9/i+5zlkOTmXpVE2jvD8iPmWm6lkBhRxPAqqKcK1PoroHvNDzsBiPM
	 3Cahcqts0JSzQ==
Date: Wed, 24 Apr 2024 15:11:05 -0500
From: Rob Herring <robh@kernel.org>
To: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Cc: Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michal Simek <michal.simek@amd.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eng Lee Teh <englee.teh@starfivetech.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: spi: spi-cadence: Add optional reset
 control
Message-ID: <20240424201105.GA428137-robh@kernel.org>
References: <20240424051317.2084059-1-jisheng.teoh@starfivetech.com>
 <20240424051317.2084059-3-jisheng.teoh@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424051317.2084059-3-jisheng.teoh@starfivetech.com>

On Wed, Apr 24, 2024 at 01:13:17PM +0800, Ji Sheng Teoh wrote:
> Document the optional reset control to SPI.
> 
> Signed-off-by: Eng Lee Teh <englee.teh@starfivetech.com>
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>

3 people developed 4 lines of code? Generally the first S-o-b should be 
the author (.i.e. a From line).

> ---
>  Documentation/devicetree/bindings/spi/spi-cadence.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.yaml b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
> index d4b61b0e8301..2358489be4bc 100644
> --- a/Documentation/devicetree/bindings/spi/spi-cadence.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
> @@ -55,6 +55,11 @@ properties:
>    label:
>      description: Descriptive name of the SPI controller.
>  
> +  resets:
> +    description: |
> +      Optional entry to specify the reset controller to the SPI

Drop the description.

> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.43.2
> 

