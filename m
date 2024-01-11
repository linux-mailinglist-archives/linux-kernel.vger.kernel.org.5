Return-Path: <linux-kernel+bounces-23875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D2082B313
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B733B2694A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348165026F;
	Thu, 11 Jan 2024 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Du7wM1aQ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D5050253;
	Thu, 11 Jan 2024 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MW6/932j529IcbPLZuE9sRIM5eRFWB8/wXQ+QFuqeWQ=; b=Du7wM1aQPgJreB3wMQY5XBx7i+
	Yhj99KSRD7o09HTrI9gr4PIh0Jv8TF2pMYibsbqJ4wcwlFw1bX8C2Vn+DjaMNsyujas/Hi5KI3dh/
	aIkZOAaOb7/zrkLC4Lib3W1EQQ3hlg02vbaBkCuCRMyZaWUpUSRNa4Ceb9IqJu+J9qTc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rNy1L-0050vo-QQ; Thu, 11 Jan 2024 17:35:07 +0100
Date: Thu, 11 Jan 2024 17:35:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, afd@ti.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: net: dp83826: add ti,cfg-dac-minus
 binding
Message-ID: <c795aa28-b6a2-4db8-b941-05b51b44f1fe@lunn.ch>
References: <20240111161927.3689084-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111161927.3689084-1-catalin.popescu@leica-geosystems.com>

On Thu, Jan 11, 2024 at 05:19:25PM +0100, Catalin Popescu wrote:
> Add property ti,cfg-dac-minus to allow for voltage tuning
> of logical level -1 of the MLT-3 encoded data.
> 
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> ---
>  Documentation/devicetree/bindings/net/ti,dp83822.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> index db74474207ed..2f010333be49 100644
> --- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> @@ -62,6 +62,15 @@ properties:
>         for the PHY.  The internal delay for the PHY is fixed to 3.5ns relative
>         to transmit data.
>  
> +  ti,cfg-dac-minus:
> +    description: |
> +       DP83826 PHY only.
> +       Sets the voltage ratio of the logical level -1 for the MLT-3 encoded data.
> +       0 = 50%, 1 = 56.25%, 2 = 62.50%, 3 = 68.75%, 4 = 75%, 5 = 81.25%, 6 = 87.50%,
> +       7 = 93.75%, 8 = 100%, 9 = 106.25%, 10 = 112.50%, 11 = 118.75%, 12 = 125%,
> +       13 = 131.25%, 14 = 137.50%, 15 = 143.75%, 16 = 150%.
> +    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]

We try to avoid register values in DT. We use real units. This is a
voltage you are configuring, so can you change the unit to millivolts?
Have the driver do the conversion of volts to register value.

Is it possible to configure any of the other logical levels?

    Andrew

---
pw-bot: cr

