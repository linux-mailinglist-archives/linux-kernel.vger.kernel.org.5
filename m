Return-Path: <linux-kernel+bounces-145972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 245D88A5DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86BE1F21C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FBD158217;
	Mon, 15 Apr 2024 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+IeCmqy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB368157485;
	Mon, 15 Apr 2024 22:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713220164; cv=none; b=M91OmKWXAJiBa0bR+WMk64KbrbzU7lpGUOofJCnFf+g0a3Ia1ReYyMinu5uCO85ssWhcC4BoljO+tOBkpqt/lKKBsP/aVPmJaa0IHNMQDNRXGMUcLY1qNE9YX4XgmCQ9GZxJoE7M64ROv4NUPYNXKD6Dddxtqs5D1gZ1xxy2jUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713220164; c=relaxed/simple;
	bh=XwTiu8X+FXFyNS9KWXZCeF2yN0mvFNnsMIYBii4sMME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aj9g4tqFhi2vwYNV0dTyTkNAIG3+YxwGAxbvKSrxAY0vQ+Zg2ymQJx95hb89iqO+f+DTjAfJQ45kImcUC+/blVeet05zoG9RwiMdJ6J3Y8DwJGgG5wdiXfqLvz9RkA66D/Cm9uzQKsgkA47XurSSv1n1m//HWi3xRilYFOSafrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+IeCmqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12010C113CC;
	Mon, 15 Apr 2024 22:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713220164;
	bh=XwTiu8X+FXFyNS9KWXZCeF2yN0mvFNnsMIYBii4sMME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+IeCmqyeS2ygnY/sw098tqlBOrgReipIJ43IzksFXD1j41GQBq+nzUTjhyhUfct9
	 2EOAURC5k67ytUJUs96Z9AtTO8GpIRwymfc0R+d1wLyeKBkMX4HT7ZWZuWodnr77EZ
	 X86hjwCfs7inz502FfjSplZfwiXi2cGQfa66EMEnpo0KvPubWIgkJ68TaRLiOnKHLz
	 yEAEaIryORD6mV/HLlw20KkRzx8kFPOBF3tksUxSLnmJZBop+ZeyhV/XwXYQIoGwC2
	 m7AjHpYFVzYE5swhD1hHWZlk4oWTh2fedq2Wi8vICcDWCMnyBuWRmgcov0apavFbHK
	 +wpdJkthEZfsw==
Date: Mon, 15 Apr 2024 17:29:22 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: fsl-esai: Remove 'fsl,*' from
 required list
Message-ID: <20240415222922.GA198321-robh@kernel.org>
References: <20240411-esai_arm_dts_warning-v1-0-5e1a7c7be9b9@nxp.com>
 <20240411-esai_arm_dts_warning-v1-1-5e1a7c7be9b9@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411-esai_arm_dts_warning-v1-1-5e1a7c7be9b9@nxp.com>

On Thu, Apr 11, 2024 at 01:07:45PM -0400, Frank Li wrote:
> fsl,fifo-depth have default value 64 in driver(sound/soc/fsl/fsl_esai.c).
> 
> fsl,esai-synchronous is flag(bool) type. It doesn't make sense to put flag
> type into 'required'.
> 
> Fix warning:
> 
> arch/arm/boot/dts/nxp/imx/imx6q-sabreauto.dtb: esai@2024000: 'fsl,fifo-depth' is a required property
> arch/arm/boot/dts/nxp/imx/imx6q-sabreauto.dtb: esai@2024000: 'fsl,esai-synchronous' is a required property
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,esai.yaml | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.yaml b/Documentation/devicetree/bindings/sound/fsl,esai.yaml
> index f167f1634d7e3..66f20ecaa42b4 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,esai.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,esai.yaml
> @@ -70,7 +70,7 @@ properties:
>      description:
>        The number of elements in the transmit and receive
>        FIFOs. This number is the maximum allowed value for
> -      TFCR[TFWM] or RFCR[RFWM].
> +      TFCR[TFWM] or RFCR[RFWM]. Default value is 64.

default: 64

>  
>    fsl,esai-synchronous:
>      $ref: /schemas/types.yaml#/definitions/flag
> @@ -95,8 +95,6 @@ required:
>    - clock-names
>    - dmas
>    - dma-names
> -  - fsl,fifo-depth
> -  - fsl,esai-synchronous
>  
>  unevaluatedProperties: false
>  
> 
> -- 
> 2.34.1
> 

