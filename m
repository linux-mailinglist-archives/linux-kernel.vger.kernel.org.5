Return-Path: <linux-kernel+bounces-24607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE63482BF19
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF3E1F22E55
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B4167E79;
	Fri, 12 Jan 2024 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdGNKmTs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2869265198;
	Fri, 12 Jan 2024 11:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6902BC433C7;
	Fri, 12 Jan 2024 11:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705058106;
	bh=eDP68AxPwKFZxVK+hqHIw7GIyQdIy4JXRj3huwM1kIM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fdGNKmTse8tw0KRJfFiYEux1Fgi/qCsXBGhsmdNt72paaKb/GGGPaPdLkIwXTsXz3
	 U1knuRqfh1gCPK3AIlRFYJ1MAj3F4KtbrWKeMvV9je2PgxU0F+A6tBwflQXu+Y3t+B
	 D3IOB5Jn2JyDTYwrzVvxPJvI5XudYHZj2w97mclY68+PIq8F6XTRnU0Y1/0AkUK6lf
	 C1onrq9NTbv7QEpsn6a4QNNhBV3oOUNAMYu7OFAtFnvilg3Srd4eLHhbBGLlaMe0hA
	 sr9m34Iqg+/80OeCsqLApKhXFGcQRDJJFdtw9BelIvMfISRPJfqtinfTrZKz8C6tVl
	 FfOWEqKh0f+2A==
Date: Fri, 12 Jan 2024 05:15:05 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, linux@roeck-us.net, 
 linux-arm-kernel@lists.infradead.org, conor+dt@kernel.org, 
 kernel@collabora.com, matthias.bgg@gmail.com, gregkh@linuxfoundation.org, 
 heikki.krogerus@linux.intel.com, robh+dt@kernel.org, cy_huang@richtek.com, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, chunfeng.yun@mediatek.com, 
 devicetree@vger.kernel.org
In-Reply-To: <20240112094538.65639-1-angelogioacchino.delregno@collabora.com>
References: <20240112094538.65639-1-angelogioacchino.delregno@collabora.com>
Message-Id: <170505810426.2663263.815471300666938167.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: usb: mt6360-tcpc: Rename IRQ to
 PD-IRQB


On Fri, 12 Jan 2024 10:45:37 +0100, AngeloGioacchino Del Regno wrote:
> Since there is no user yet, rename the only interrupt of this device
> to "PD-IRQB", avoiding underscores.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml         | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mediatek,mt6360.example.dtb: pmic@34: tcpc:interrupt-names:0: 'PD-IRQB' was expected
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6360.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mediatek,mt6360.example.dtb: tcpc: interrupt-names:0: 'PD-IRQB' was expected
	from schema $id: http://devicetree.org/schemas/usb/mediatek,mt6360-tcpc.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240112094538.65639-1-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


