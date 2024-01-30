Return-Path: <linux-kernel+bounces-45274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2F5842DF6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19DE51C249D2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536D755E57;
	Tue, 30 Jan 2024 20:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1yds/eq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910C669E1A;
	Tue, 30 Jan 2024 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706646980; cv=none; b=PvTxgdIQT+3vqKkci2cJh/3ptBFIvutf7bcKCUKeS8IIbg/3QCisOTHekl5YVLcH3gzAGXJidzYkGhMLIplhYOIzK7hqKDxNLBA1+nQLWF3rXiiXPLB84Y62ar08f8M8MydPm9GB4Yc1GmOSSwj8tnV4iiloGSDmp9a96BHaWsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706646980; c=relaxed/simple;
	bh=L0Z4Y+2fjawz/djs1mYllXzmcvlnHK3ZDV6yTPhasGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4sUTcbEQhXMSMnIDtHBfSNKSyNpDW5K+FoFcLT2caA1dcTKIYPjQt1sKUvqxYUKiZ3H770hBtk6s0rP1WecKcfpoMweXmzW/6BhxfFVuAZIinkx61SEdxTR4mKSRrC/snC4oKPN7oB9Dp1d6ZfLF5UWlPvpEUydEg8tjDGocyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1yds/eq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB16C433C7;
	Tue, 30 Jan 2024 20:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706646980;
	bh=L0Z4Y+2fjawz/djs1mYllXzmcvlnHK3ZDV6yTPhasGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i1yds/eqjcxMrQ/ltGVfj/lMNN0pOHm55eLpUfjO+qRrT0W3KA5I7AKDV+d8qoA+x
	 mLud5G8F6A7GaS2Rn+ZWgQULiRpp9IOMyA3luDDge/g7aY5wl4N8gs5eADu1sGF7CK
	 lUb03ba1HoYULO/SLqW0zjp7CtPJ5R+hjQVH/MPD+WQGiZmS0DuwzuoOSizSTSN17n
	 gINuYskiCX9CeBCLimfN/MRFPTQXarDizMFviW4tjt8xkQBrHonVm1OShpD+cI5uPT
	 QW76LnZg2Va9xwHGLrsEydg6Qv7wgislPNzwIpaUzBehSbu+KPdiqcTZe2EAvm1N0y
	 a7m5yC5ATYYFw==
Date: Tue, 30 Jan 2024 14:36:17 -0600
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/3] dt-bindings: arm: mediatek: convert hifsys to the
 json-schema
Message-ID: <20240130203617.GB2290196-robh@kernel.org>
References: <20240123082100.7334-1-zajec5@gmail.com>
 <20240123082100.7334-2-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240123082100.7334-2-zajec5@gmail.com>

On Tue, Jan 23, 2024 at 09:20:58AM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files. Introduced changes:
> 1. Documented "reg" property
> 2. Documented "#reset-cells" property
> 3. Adjusted "reg" in example
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../bindings/arm/mediatek/mediatek,hifsys.txt | 26 ---------
>  .../arm/mediatek/mediatek,mt2701-hifsys.yaml  | 54 +++++++++++++++++++

Like the other one, please move this.

>  2 files changed, 54 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt2701-hifsys.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
> deleted file mode 100644
> index 323905af82c3..000000000000
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -Mediatek hifsys controller
> -============================
> -
> -The Mediatek hifsys controller provides various clocks and reset
> -outputs to the system.
> -
> -Required Properties:
> -
> -- compatible: Should be:
> -	- "mediatek,mt2701-hifsys", "syscon"
> -	- "mediatek,mt7622-hifsys", "syscon"
> -	- "mediatek,mt7623-hifsys", "mediatek,mt2701-hifsys", "syscon"
> -- #clock-cells: Must be 1
> -
> -The hifsys controller uses the common clk binding from
> -Documentation/devicetree/bindings/clock/clock-bindings.txt
> -The available clocks are defined in dt-bindings/clock/mt*-clk.h.
> -
> -Example:
> -
> -hifsys: clock-controller@1a000000 {
> -	compatible = "mediatek,mt2701-hifsys", "syscon";
> -	reg = <0 0x1a000000 0 0x1000>;
> -	#clock-cells = <1>;
> -	#reset-cells = <1>;
> -};
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt2701-hifsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt2701-hifsys.yaml
> new file mode 100644
> index 000000000000..7c7b7b7b1142
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt2701-hifsys.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt2701-hifsys.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek hifsys controller
> +
> +description:
> +  The Mediatek hifsys controller provides various clocks and reset outputs to
> +  the system.
> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: mediatek,mt2701-hifsys
> +          - const: syscon
> +      - items:
> +          - enum:
> +              - mediatek,mt7623-hifsys
> +          - const: mediatek,mt2701-hifsys
> +          - const: syscon
> +      - items:
> +          - const: mediatek,mt7622-hifsys
> +          - const: syscon

The 1st and 3rd entries can be combined.

> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 1
> +    description: The available clocks are defined in dt-bindings/clock/mt*-clk.h
> +
> +  "#reset-cells":
> +    const: 1
> +
> +required:
> +  - reg
> +  - "#clock-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@1a000000 {
> +        compatible = "mediatek,mt2701-hifsys", "syscon";
> +        reg = <0x1a000000 0x1000>;
> +        #clock-cells = <1>;
> +        #reset-cells = <1>;
> +    };
> -- 
> 2.35.3
> 

