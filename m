Return-Path: <linux-kernel+bounces-77027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68320860041
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7215F1C2531B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DFF157E95;
	Thu, 22 Feb 2024 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/Rou46X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59106153BEF;
	Thu, 22 Feb 2024 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624763; cv=none; b=ISr79GV8rXAdoqwR4JjfWx6STMANA84bwdcdonKYgZUxfS1iZcB+JrIoO0bm3ERp/xHnENvrKMQlM/iXmt3ee79Kyt1u0UA7jjJ0HUrDfECLgeBM1740E/IbSFJG98hVNY1UtkHDdwsZH/szJdwN2ICecSrzD0ujH74BRiBUZDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624763; c=relaxed/simple;
	bh=wdnO0bFfHymT5iCbsiUCX/eH2jaKJvVYJF6RugEQ6ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJKLZACgw80yF4FI1a47qSj6xgquzzriTSCBKwUaNuvRHLPuxaajhSka7qkSAd0CGuwDimsUaV0isrkDPwgiZ1xVUIfOIfLj49gRVAx+n0GLo1LoQnudKkHd+Xa+PBsUGa1gNS5ZrgMF/A2Zj7uEMho2hqi197X1IYtU2UWjynk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/Rou46X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E618C433F1;
	Thu, 22 Feb 2024 17:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708624762;
	bh=wdnO0bFfHymT5iCbsiUCX/eH2jaKJvVYJF6RugEQ6ZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d/Rou46XoeDVCackneWERhF7n8kwnrl/gU/Vr0pLn9yDrVgMvCxjRhrUAXm+TYb8e
	 BxgA8ftVrWEEbAoq/CYx2arEmh6w7yrXkSQG5NTJjCHbA+yo0vM7LeLom1I1WROFhJ
	 tTH7iVbkZ1D1Vs3OfSDyuOZCX2OV6YoVTkU977KlgYbtdQkudT4MCTvi81LQUjyx8Z
	 wUHGZgwSwh+arqkj3SUW8cB5ZrqdMY1eAB+8ukEwCpyzkQ5L2JfveFUbXI3QCwuMI4
	 LlF0XNDeh5SZOcz6LVTRTOauO2th45VNxBDr3m6pIuihZQ9MlNcLeWOpGa3rwltHWK
	 j1HQahO9xKuAg==
Date: Thu, 22 Feb 2024 10:59:18 -0700
From: Rob Herring <robh@kernel.org>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux@armlinux.org.uk,
	vadim.fedorenko@linux.dev, andrew@lunn.ch, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	git@amd.com
Subject: Re: [PATCH net-next v2 4/4] dt-bindings: net: cdns,macb: Deprecate
 magic-packet property
Message-ID: <20240222175918.GA3500038-robh@kernel.org>
References: <20240222153848.2374782-1-vineeth.karumanchi@amd.com>
 <20240222153848.2374782-5-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222153848.2374782-5-vineeth.karumanchi@amd.com>

On Thu, Feb 22, 2024 at 09:08:48PM +0530, Vineeth Karumanchi wrote:
> WOL modes such as magic-packet should be an OS policy.
> Leverage MACB_CAPS_WOL on supported devices to advertise
> supported modes through ethtool. Use ethtool to activate
> the required mode.

According to the description of the property, it indicates whether magic 
packet is supported by the h/w or not. Enabling WOL or not is a separate 
matter. OTOH, I would think WOL support would be implied by compatible 
properties. No objection from me, just highlighting the distinction.

> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---
>  Documentation/devicetree/bindings/net/cdns,macb.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> index bf8894a0257e..096309bf3235 100644
> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> @@ -141,6 +141,7 @@ patternProperties:
>  
>        magic-packet:
>          type: boolean
> +        deprecated: true
>          description:
>            Indicates that the hardware supports waking up via magic packet.
>  
> -- 
> 2.34.1
> 

