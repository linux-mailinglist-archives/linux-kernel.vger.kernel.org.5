Return-Path: <linux-kernel+bounces-81745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7662F8679A3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F461F27220
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61861353FF;
	Mon, 26 Feb 2024 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WadZePrh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309971350E7;
	Mon, 26 Feb 2024 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959320; cv=none; b=UqVX6CIwDFPUBcvgt5Odt9hAA0ioUFRSMH0+Q6C1HtyFXE0a228g5AQ/3ODCIhgdWMHon5jrOmip6RejZ/3QwzJo3iRbWEb8SeA1lyCMuR9ezBCASESyLK76fbSCSneiiyCy1YEXT9yKCE/SeEe1eowpXOvMd3oPh/oErNXlXAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959320; c=relaxed/simple;
	bh=SHDBTf5C5XMzZppp5DC1oDDIjabtSADDcRTNwJ3pHAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ac911gAvcCT4103X4swOdA9T5/ksBH6TPPs4d5sSFo9+VPKLiPUsF+OhgcDvkXtIS9SV0orZH0ertTC6rg9wUy3KTOrLM/SMmbuKdiz49PDkNslyCGxwcd/Uf9EThFpiSIbqk3AfwXnlxp7Bb3XJLW5mXO6bd9ys3LZwoRVp3QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WadZePrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1FAC433F1;
	Mon, 26 Feb 2024 14:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708959319;
	bh=SHDBTf5C5XMzZppp5DC1oDDIjabtSADDcRTNwJ3pHAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WadZePrhydomBWSz8uFS7lO8azeX2/uaMhOWABcgLXAagrkhRukFAJ1Ru4x9gfGdk
	 l0AvNL9nmp0mxTlE1BrXGA+q17oe3G6z+J67aUVfMcvdRCB24jq2audnmjgNyLqAYO
	 JuzHcuzdnFaiYcZkZ6AekL7P84Omu4apAE0t1fx9lhzzOlTNkj0uhDXzTfaCuSEguX
	 EB+uRGDUiFaxUN4W8b/PZVlhMCnOZo83OplURxF1TEIbkfNdXvB1VswNgh0BrxF8cp
	 HrgJGL0MLeWeSYFT5AYiOFLTpLFxAZ+s/xSY3tOgWI70lrMNYatuSv0YaLvwfpxIOS
	 UhzuBVYWHV7kA==
Date: Mon, 26 Feb 2024 08:55:17 -0600
From: Rob Herring <robh@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 06/16] dt-bindings: lcdif: Do not require
 power-domains for i.MX6ULL
Message-ID: <170895931635.643835.3601839818121921964.robh@kernel.org>
References: <20240224213240.1854709-1-sre@kernel.org>
 <20240224213240.1854709-7-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224213240.1854709-7-sre@kernel.org>


On Sat, 24 Feb 2024 22:29:38 +0100, Sebastian Reichel wrote:
> i.MX6UL(L) uses "fsl,imx6sx-lcdif" as fallback compatible string,
> but has only very lightweight DISPLAY power domain. Its DISPLAY
> power domain is not supported by the binding / Linux kernel at
> the moment. Since the current setup is working, let's remove the
> power-domain from being required for that platform to fix the warning
> printed by CHECK_DTBS=y.
> 
> Fixes: f62678a77d58 ("dt-bindings: mxsfb: Document i.MX8M/i.MX6SX/i.MX6SL power-domains property")
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/fsl,lcdif.yaml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Applied, thanks!


