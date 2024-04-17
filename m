Return-Path: <linux-kernel+bounces-148737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B1E8A86C8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24495287FED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50989142654;
	Wed, 17 Apr 2024 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIwLMovJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0DF1420D0;
	Wed, 17 Apr 2024 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365645; cv=none; b=o/LYWowRkjZUARZb43T7qxFpGBmJH3HHBFiLuhz6yEgnb++COWxlpdh5KqhfG5lBhNCTirmf5HAdJjbU74i7QtlUkg7CZRIAFiiXp01ZpkCw12B/ZZIx13vv0v89U1ytzYoSym62qd5TQ23mJ3lMpfM3tkGNfhCltW0oD360zbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365645; c=relaxed/simple;
	bh=7RPukjZeREzRQeYifxWz1+LP+GxBg1xWTJAJdsC2t/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0DlvNuetNy/n3PaNBv9Vx+PAs6KDzFOX7NCA7Su9U18Fe11Aa6SPhKU68OqoV3C3mEzqBQNbZMhvWRcm8UqvTmL8yBbrVMEOdCfvtdWE905cfwX4/wD7KBpIddpgHNG5hAVbkO25GpyOgh6yY6qbZlA/hYxvNDoT3icybQd8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIwLMovJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11EFC32781;
	Wed, 17 Apr 2024 14:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713365645;
	bh=7RPukjZeREzRQeYifxWz1+LP+GxBg1xWTJAJdsC2t/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WIwLMovJAc/KjZB0q7r91gFvQ9By8zffzDPKt2zIopXCNOgRS+z5UWF/60XkNHHGM
	 H2nXO4a4yZ1lVYPUhCFDyPsAUvNzLh1UB4gskJZweclhTriS6lf3PzDWgTuXezJRRH
	 5t2zTgpRu9ERroCtgr4/k2KrvkpOHRrG3sUsCKBXlnc7Vk7ZNJsCos+m+ArrUcRwVV
	 /z2WtMRpV8FZlk0Letk8YWc7WyzFhQTqZOVKCnVewE+PdOHE4BwKMxBDiHKToYtyhO
	 BnnTJH/4uxJtMcoeytc07olK4uqP3kzpHw22fFrPv4eo29IS9uKOSb4sX7nQwAGnA8
	 u7YNzxq6MEd9A==
Date: Wed, 17 Apr 2024 09:54:02 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: djakov@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
	broonie@kernel.org, keescook@chromium.org, gustavoars@kernel.org,
	henryc.chen@mediatek.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com,
	wenst@chromium.org, amergnat@baylibre.com
Subject: Re: [PATCH v2 2/7] dt-bindings: interconnect: Add MediaTek EMI
 Interconnect bindings
Message-ID: <20240417145402.GA2355631-robh@kernel.org>
References: <20240417091442.170505-1-angelogioacchino.delregno@collabora.com>
 <20240417091442.170505-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417091442.170505-3-angelogioacchino.delregno@collabora.com>

On Wed, Apr 17, 2024 at 11:14:37AM +0200, AngeloGioacchino Del Regno wrote:
> Add bindings for the MediaTek External Memory Interface Interconnect,
> which providers support system bandwidth requirements through Dynamic
> Voltage Frequency Scaling Resource Collector (DVFSRC) hardware.
> 
> This adds bindings for MediaTek MT8183 and MT8195 SoCs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../interconnect/mediatek,mt8183-emi.yaml     | 76 +++++++++++++++++++
>  .../interconnect/mediatek,mt8183.h            | 23 ++++++
>  .../interconnect/mediatek,mt8195.h            | 44 +++++++++++
>  3 files changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml
>  create mode 100644 include/dt-bindings/interconnect/mediatek,mt8183.h
>  create mode 100644 include/dt-bindings/interconnect/mediatek,mt8195.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml b/Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml
> new file mode 100644
> index 000000000000..3ad60fd21f83
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/mediatek,mt8183-emi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek External Memory Interface (EMI) Interconnect
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +
> +description: |
> +  EMI interconnect providers support system bandwidth requirements through
> +  Dynamic Voltage Frequency Scaling Resource Collector (DVFSRC) hardware.
> +  The provider is able to communicate with the DVFSRC through Secure Monitor
> +  Call (SMC).
> +
> +             ICC provider         ICC Nodes
> +                              ----          ----
> +             _________       |CPU |   |--- |VPU |
> +    _____   |         |-----  ----    |     ----
> +   |     |->|  DRAM   |       ----    |     ----
> +   |DRAM |->|scheduler|----- |GPU |   |--- |DISP|
> +   |     |->|  (EMI)  |       ----    |     ----
> +   |_____|->|_________|---.   -----   |     ----
> +               /|\         `-|MMSYS|--|--- |VDEC|
> +                |             -----   |     ----
> +                |                     |     ----
> +                | change DRAM freq    |--- |VENC|
> +             --------                 |     ----
> +    SMC --> | DVFSRC |                |     ----
> +             --------                 |--- |IMG |
> +                                      |     ----
> +                                      |     ----
> +                                      |--- |CAM |
> +                                            ----
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8183-emi
> +      - mediatek,mt8195-emi
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#interconnect-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - '#interconnect-cells'
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interconnect/mediatek,mt8195.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        system-controller@10012000 {
> +            compatible = "mediatek,mt8195-dvfsrc";
> +            reg = <0 0x10012000 0 0x1000>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            emi_icc: interconnect@1 {
> +                compatible = "mediatek,mt8195-emi";
> +                reg = <1>;
> +                #interconnect-cells = <1>;


There's not really any need for this node. Just put #interconnect-cells 
in the parent.

Rob

