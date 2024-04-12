Return-Path: <linux-kernel+bounces-142980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B4E8A32E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0421C22A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBED148844;
	Fri, 12 Apr 2024 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KO9P4/t2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273681487F4;
	Fri, 12 Apr 2024 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937143; cv=none; b=mfc3n5cdwB0zujEs/hv4idYD2OW9COceVj4f9ScAOGFfR/b0c/6t25965+T6wIIvi03Sv3fejBBSFJux7Z5yR0u1zmGE7Ikxiyz+DtqCaO/mbYsF6UiO5t9nHCrHvbUIMj6lFiC0pchg1LO2eNsM5bJWHTsg81/hE1iR3BuGeXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937143; c=relaxed/simple;
	bh=p8OAbH8ik4uO7b+Ydee6KnfTe8Pqv3txAKJdlPzFN+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEU8B+yJqVXete+c7WrazGscBYFprHqkgAXcgtXThVA4SQYz+gR/o0IN3yYptLlSY89oWKQnw0GuU805tQQfVrqsn+IlZyy7LIfNAh1ByHwl/FSQ84V+RybBbh8s2ezU5+WoPW12k1ULA8KB/Veb+WkLCeHpZSeikhGAQ8BcVAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KO9P4/t2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B70AC113CC;
	Fri, 12 Apr 2024 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712937142;
	bh=p8OAbH8ik4uO7b+Ydee6KnfTe8Pqv3txAKJdlPzFN+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KO9P4/t2cDRuWl80w6gOUAPjO0AMXVxD7gC6uP2mwU8ISqAgxs6VNhHozXIZqPg4f
	 IxIfIc4IjyGe/b6QhzPnay8cP37wmaDZ88pFaCzUFOMc20t0ikqGC58OGZCV+GbyDz
	 WI93KbnDGseDAwz/NNdCUc5f/9jmB7Vx+RyIICUCQGBUzTfY6Lc75/E09y4R2RQe2v
	 XWWzyszKnIIXYWZ4k9iyjsQE/3nSlsJtdFf1/ZKtjaJr7IAxKHUFfK6JqE2B+fM4UJ
	 OZ/+WvCY1aZ1Sqg+hD4vkU9ARhl7iAtiPJbP+z/NrQJ8/kN6A/VFrOg8z4i27eJ5hK
	 Ci19pwIr5RJ6Q==
Date: Fri, 12 Apr 2024 10:52:20 -0500
From: Rob Herring <robh@kernel.org>
To: Seven Lee <wtli@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org, linux-sound@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
	YHCHuang@nuvoton.com, KCHSU0@nuvoton.com, CTLIN0@nuvoton.com,
	SJLIN0@nuvoton.com, scott6986@gmail.com, supercraig0719@gmail.com,
	dardar923@gmail.com, edson.drosdeck@gmail.com,
	u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: nau8821: Add delay control for ADC
Message-ID: <20240412155220.GA2918590-robh@kernel.org>
References: <20240412103554.3487290-1-wtli@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412103554.3487290-1-wtli@nuvoton.com>

On Fri, Apr 12, 2024 at 06:35:52PM +0800, Seven Lee wrote:
> Change the original fixed delay to the assignment from the property. It
> will make it more flexible to different platforms to avoid pop noise at
> the beginning of recording.
> 
> Signed-off-by: Seven Lee <wtli@nuvoton.com>
> ---
>  .../devicetree/bindings/sound/nuvoton,nau8821.yaml        | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
> index 054b53954ac3..a726c5a9b067 100644
> --- a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
> +++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
> @@ -103,6 +103,13 @@ properties:
>          just limited to the left adc for design demand.
>      type: boolean
>  
> +  nuvoton,adc-delay-ms:
> +    description: Delay (in ms) to make input path stable and avoid pop noise.
> +        The default value is 125 and range between 125 to 500 ms.

No need to state constraints in prose.

> +    minimum: 125
> +    maximum: 500
> +    default: 125
> +
>    '#sound-dai-cells':
>      const: 0
>  
> @@ -136,6 +143,7 @@ examples:
>              nuvoton,jack-eject-debounce = <0>;
>              nuvoton,dmic-clk-threshold = <3072000>;
>              nuvoton,dmic-slew-rate = <0>;
> +            nuvoton,nuvoton,adc-delay-ms = <125>;
>              #sound-dai-cells = <0>;
>          };
>      };
> -- 
> 2.25.1
> 

