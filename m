Return-Path: <linux-kernel+bounces-24729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9840682C176
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4313FB21B05
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375436DCF5;
	Fri, 12 Jan 2024 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/2TkSzw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B61C6BB41;
	Fri, 12 Jan 2024 14:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDD7C433C7;
	Fri, 12 Jan 2024 14:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705069221;
	bh=zmlC6jkMelq285ECzm84F7pJRpHbtewNs6IurYJ0/EM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K/2TkSzwlKIvIFYzFvUSp7Lg4gjIlDR9tPEg0iGi282ybmiyDw7wMISWdGupf5F4J
	 VX3Rp0AioRhHA7gWiKoOCWY1t/6DGST6UDp2Nt1u0psSL8dcwkfszVuMRCQGbBJEJC
	 q2SkJl392wwe2DahvMB5LLm4lI9R7e7ynEPPzvXwpHEpghxz66SskoRpgEP565I+RF
	 ApvkRqhD8HLTinyc7vdzCVCxaPJ1Uk+zENq20+NWUOcNJKL3CPjCL7IoKR+/tBMyx8
	 v059iRjQa93nv+5DSN9ooL0L+JLQK+7vkE5OSWfXmwcHUUJuFvLdSoZaZoIAYB1/jF
	 imbCsXe6C14vA==
Date: Fri, 12 Jan 2024 08:20:18 -0600
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, linux@roeck-us.net,
	heikki.krogerus@linux.intel.com, cy_huang@richtek.com,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 1/2] dt-bindings: usb: mt6360-tcpc: Rename IRQ to PD-IRQB
Message-ID: <20240112142018.GA3127117-robh@kernel.org>
References: <20240112094538.65639-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112094538.65639-1-angelogioacchino.delregno@collabora.com>

On Fri, Jan 12, 2024 at 10:45:37AM +0100, AngeloGioacchino Del Regno wrote:
> Since there is no user yet, rename the only interrupt of this device
> to "PD-IRQB", avoiding underscores.

It is primarily node and property names that have this recommendation, 
not so much -names values.

If there is only 1 interrupt, I'd just drop the name.

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml         | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> index 053264e60583..0bea23ce2f09 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> @@ -24,7 +24,7 @@ properties:
>  
>    interrupt-names:
>      items:
> -      - const: PD_IRQB
> +      - const: PD-IRQB
>  
>    connector:
>      type: object
> @@ -58,7 +58,7 @@ examples:
>          tcpc {
>            compatible = "mediatek,mt6360-tcpc";
>            interrupts-extended = <&gpio26 3 IRQ_TYPE_LEVEL_LOW>;
> -          interrupt-names = "PD_IRQB";
> +          interrupt-names = "PD-IRQB";
>  
>            connector {
>              compatible = "usb-c-connector";
> -- 
> 2.43.0
> 

