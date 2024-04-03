Return-Path: <linux-kernel+bounces-130230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA3C8975BB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55AAC1F28D7A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B41152171;
	Wed,  3 Apr 2024 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+rl5fcW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70E63E487;
	Wed,  3 Apr 2024 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163443; cv=none; b=A0+kBFuX95nt9AOWmsaGcASRpQh3e9uwgtuxYJFgPay49N/jFzxMDFDQXzNf5FzhFOe43DnUPemiri4z8VpBF+ji26eBxh9ZspfBB1+p6vgjUyDB9X/jKpZOri7zY9LbrK/zQpz9iMTRFySttAXDU3lmgHktW10FnjRbQSzR2Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163443; c=relaxed/simple;
	bh=Lyo2Jkd+NP2jcyMjfmSSDQpvC/i5lfwUw1klvOt8u4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/GJvqAhDi0hUj8L7rX+y36aBnVWe0UlrwVEAiO30C+7hbGqZRNFAVD4HM0Oa/d74B1vivSQBRKxHEvUggk4vbRHaVt2ixMBhm8A+FKMs7Yx/vblsiLbghD8VOBoere/grTx+4Pug9htbzB6fuJezd3E1Qe4PxCtYqSIrxwxydk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+rl5fcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20326C433C7;
	Wed,  3 Apr 2024 16:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712163443;
	bh=Lyo2Jkd+NP2jcyMjfmSSDQpvC/i5lfwUw1klvOt8u4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+rl5fcWtGDnzgkuQ9dJB/MwuM578FH1ChxNzfvkUSA1zsCW76Y+Jb4K9xEuvgOV9
	 tjL5skqR7xA4W7dv6pD6ffSM0hGgqXNvpUa8crYjhlaVvlVOm6GZImf5s+rCDgvLdL
	 d8n4yFN+d9HK5MX0H5vxMv30iOwMHPwedVEyhg7j9qrLoH4jHgIXBqjhCXPXmppdMF
	 Z3dJ9WiTjuNXu4DHm6rMM79HQcX33+Ni+dUKHOwTBKt3heDHMBYh2j2WN8lWTxBfzw
	 ITXeEK9Ygz/3cFHNLCE7mVVIaBGfeJc1qe84Gn7G++0NFjlAUIhvQRbJOOkF+nkLk/
	 +ZXGCFDUSq93g==
Date: Wed, 3 Apr 2024 11:57:21 -0500
From: Rob Herring <robh@kernel.org>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] dt-bindings: arm: fsl: remove reduntant
 toradex,colibri-imx8x
Message-ID: <20240403165721.GA3980362-robh@kernel.org>
References: <20240402193512.240417-1-hiagofranco@gmail.com>
 <20240402193512.240417-3-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402193512.240417-3-hiagofranco@gmail.com>

On Tue, Apr 02, 2024 at 04:35:10PM -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> 'toradex,colibri-imx8x' is already present as a constant value for
> 'i.MX8QP Board with Toradex Colibri iMX8X Modules', so there is no need
> to keep it twice as a enum value for 'i.MX8QXP based Boards'.

If the module can operate on its own, then it would be valid to have 
just "toradex,colibri-imx8x". If not, then:

Acked-by: Rob Herring <robh@kernel.org>

> 
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 0027201e19f8..6fdfa10af43c 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1218,7 +1218,6 @@ properties:
>            - enum:
>                - einfochips,imx8qxp-ai_ml  # i.MX8QXP AI_ML Board
>                - fsl,imx8qxp-mek           # i.MX8QXP MEK Board
> -              - toradex,colibri-imx8x     # Colibri iMX8X Modules
>            - const: fsl,imx8qxp
>  
>        - description: i.MX8DXL based Boards
> -- 
> 2.39.2
> 

