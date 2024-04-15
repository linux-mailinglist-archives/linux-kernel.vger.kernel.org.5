Return-Path: <linux-kernel+bounces-145986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA268A5DED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5150BB215B1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B83158873;
	Mon, 15 Apr 2024 22:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrXB+Wij"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3181B80F;
	Mon, 15 Apr 2024 22:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713221800; cv=none; b=ErWl9Wgffp9oNG4t/6qA25uTvj/yqkQZEuNWvN2Nbu4CQb8uvluCZsjFKzWJV8OBLKn7cmZz29yI9hjeVYuYsWpLJK7HG3MmUV/FehFRMLGEThZLTA1HXLRYUPPzUWzu01WQQfKWCP2BYkIBE4Mwi5g0ZJzHDuHve1TpaSRVEcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713221800; c=relaxed/simple;
	bh=8MzTTUx65njv3TFYp00CMmUN6yXR6c3L1wS1VBzTK+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cf+CoryLnBTo7Muf2mGRk2ZS4BdYi9hsWAGVtC3RwINyqdfyc9FQi3wRebZVB8Gp0zjsJH9iBWlhy9yBXJLhTVblTJ1d8u8sJLTHIl+wdKTaDy9+K4tFomlCFUbw98xi88taihCIOlqiUqVUhI3fB9gaoRfjROOSaRn+bMS4POU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrXB+Wij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F348FC113CC;
	Mon, 15 Apr 2024 22:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713221800;
	bh=8MzTTUx65njv3TFYp00CMmUN6yXR6c3L1wS1VBzTK+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JrXB+Wijs9KfbMzQPONxzKL2CY+wGjvgU4UIiPwAqxxpcNoBwWzCwkcLuYZcNttOt
	 RONckGdSQfRDH5Zhq7lKszHPgiKekKgB63QQQHjdib6AY36maQg2owL/RivVFk20D5
	 OGOgyfpIxEPRDQuzmE/y3K3U3SWwJa19WK+piRsCtO4OHyzY/Tws54AsqwfFdoSPgK
	 lVfMTBhvQzi6btk5VFDtEWcToRmh4Pi9lhFEsv6U3SKExTaTreaxPNslmARKlPS2gQ
	 Ul0x4fEdbiJLLJ9RkA+DLEadI5f5CdNFGdy5oxItYDwxJlJkV87ZE4UP3F3HB1fdq7
	 UMftr6iw+GddQ==
Date: Mon, 15 Apr 2024 17:56:37 -0500
From: Rob Herring <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/3] dt-bindings: firmware: arm,scmi: support i.MX95 SCMI
 Pinctrl
Message-ID: <20240415225637.GA234203-robh@kernel.org>
References: <20240412-pinctrl-scmi-oem-v1-v1-0-704f242544c1@nxp.com>
 <20240412-pinctrl-scmi-oem-v1-v1-2-704f242544c1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412-pinctrl-scmi-oem-v1-v1-2-704f242544c1@nxp.com>

On Fri, Apr 12, 2024 at 08:29:26AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX95 SCMI Pinctrl uses OEM specific units, so add '$ref' to
> '/schemas/pinctrl/nxp,imx95-pinctrl.yaml' and an example.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index e9d3f043c4ed..ebc6c083b538 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -249,9 +249,11 @@ properties:
>  
>    protocol@19:
>      type: object
> -    allOf:
> -      - $ref: '#/$defs/protocol-node'
> -      - $ref: /schemas/pinctrl/pinctrl.yaml

I don't think anything from here was actually used...


> +    anyOf:
> +      - $ref: /schemas/pinctrl/nxp,imx95-pinctrl.yaml
> +      - allOf:
> +          - $ref: '#/$defs/protocol-node'

This must always apply and should not be under the anyOf.

> +          - $ref: /schemas/pinctrl/pinctrl.yaml
>  
>      unevaluatedProperties: false
>  
> 
> -- 
> 2.37.1
> 

