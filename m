Return-Path: <linux-kernel+bounces-148732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DBA8A86BD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61481C219E1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DD9142E66;
	Wed, 17 Apr 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g49HwvnD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DD1142625;
	Wed, 17 Apr 2024 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365560; cv=none; b=A+sNBkm8SIz/VwfST1Qru6urcelCsY2Jozb5tiMEk5gMxR6/ibHzwq1O2Ge8Mcuw0qJp5g0oBeIQKllFz5xB3H8K5tp3qCtunsHqgAluR8Yn/+JnG9JipGUcptjvcQrH7Ubff9UjkBDkUVRizYuLY+sXmJcVG9UI5rFVCekEI+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365560; c=relaxed/simple;
	bh=N/Kc5Ck+n/MV7oq1Wn9zhitTGVylQb+Utd6qvo1Q1h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeJJjiu2T++q0xVKdS5IOPco3aHHFMr7ypLuYkdbLuxKFv4GslTPYH+odX+THV09p5UBBc7PSY2+ejg//PrUbScV4t51G1xBhEYYa8GdUhKf+fv6EiOKUF/HxJsID/7FKc+M8LRZrDjxbs/HHjbOE1cml3I2UDn0vDkD8kL2RWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g49HwvnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263C9C072AA;
	Wed, 17 Apr 2024 14:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713365560;
	bh=N/Kc5Ck+n/MV7oq1Wn9zhitTGVylQb+Utd6qvo1Q1h8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g49HwvnDCP5I3WlHXrUM9ilJmC/qjtLqO8tAWQY/bZuYUZ94xZPW9ZfDZpfbeWuMc
	 v5jixX2SwPc4JgOXF43vI8bkftCCt+Rjr5GuKq4hzSasSgfY2RLx/y+7yWD4xR6arl
	 ELlsthg5adF+JAciW1xRuF2DThehy6OYCIPkWuoJvkAZZlzFOByp7/PoISevfQBpWi
	 9ikMpLYwWiyaNPVFBjCvuDMMqWhOJW1WnF7xjcVg06G+s4ZLlxzp6on607hp9j6RAo
	 IpRweKiynWVjHsJ75Cye0CVyC/VJaZOwXO5jwi77a76C4WU7aK1OT1gEwmtG0qwZim
	 5kcb95YqrbUhw==
Date: Wed, 17 Apr 2024 09:52:38 -0500
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
Subject: Re: [PATCH v2 1/7] dt-bindings: regulator: Add bindings for MediaTek
 DVFSRC Regulators
Message-ID: <20240417145238.GA2348962-robh@kernel.org>
References: <20240417091442.170505-1-angelogioacchino.delregno@collabora.com>
 <20240417091442.170505-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417091442.170505-2-angelogioacchino.delregno@collabora.com>

On Wed, Apr 17, 2024 at 11:14:36AM +0200, AngeloGioacchino Del Regno wrote:
> The Dynamic Voltage and Frequency Scaling Resource Collector Regulators
> are controlled with votes to the DVFSRC hardware.
> 
> This adds support for the regulators found in MT6873, MT8183, MT8192
> and MT8195 SoCs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../mediatek,mt6873-dvfsrc-regulator.yaml     | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
> new file mode 100644
> index 000000000000..446f1dab4d2e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6873-dvfsrc-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek DVFSRC-controlled Regulators
> +
> +description:
> +  The Dynamic Voltage and Frequency Scaling Resource Collector Regulators
> +  are controlled with votes to the DVFSRC hardware.
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt6873-dvfsrc-regulator
> +      - mediatek,mt8183-dvfsrc-regulator
> +      - mediatek,mt8192-dvfsrc-regulator
> +      - mediatek,mt8195-dvfsrc-regulator
> +
> +  reg:
> +    maxItems: 1
> +
> +  dvfsrc-vcore:
> +    description: DVFSRC-controlled SoC Vcore regulator
> +    $ref: regulator.yaml#

       unevaluatedProperties: false

> +
> +  dvfsrc-vscp:
> +    description: DVFSRC-controlled System Control Processor regulator
> +    $ref: regulator.yaml#

ditto

> +
> +required:
> +  - compatible

'reg' is never optional. And how is no regulators at all valid?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |

Drop the example here. Just one complete example in the MFD doc.

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
> +            regulators@0 {
> +                compatible = "mediatek,mt8195-dvfsrc-regulator";
> +                reg = <0>;

What does 'reg' value represent here? 0 and 1 seem pretty much made up.

> +
> +                dvfsrc_vcore: dvfsrc-vcore {
> +                        regulator-name = "dvfsrc-vcore";
> +                        regulator-min-microvolt = <550000>;
> +                        regulator-max-microvolt = <750000>;
> +                        regulator-always-on;
> +                };
> +
> +                dvfsrc_vscp: dvfsrc-vscp {
> +                        regulator-name = "dvfsrc-vscp";
> +                        regulator-min-microvolt = <550000>;
> +                        regulator-max-microvolt = <750000>;
> +                        regulator-always-on;
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.44.0
> 

