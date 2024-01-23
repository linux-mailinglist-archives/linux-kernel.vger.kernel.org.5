Return-Path: <linux-kernel+bounces-35188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E31838D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3120D1F2905E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9375A5D907;
	Tue, 23 Jan 2024 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OiIjpPi+"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8D75D8EB;
	Tue, 23 Jan 2024 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008834; cv=none; b=Um0ZGhkqhw4EywePvxIFaBtOtEuShMvdxWC9uB1pu5srb+lHC4vY3Gt1fwU+mmnWtX+yKan9AdnMCx2Pb9hiHAGK9IL4GwLOhPFUYpf9YifSKyWk1EX/WT1nzKIfxKiLSb//ORSt3Gran3HQYhoykwNv/u4biOJP06TT033uQbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008834; c=relaxed/simple;
	bh=Ma8J6HFntmgJqAnxZ1TzwNoqA60TOtVPoP1qAOVBdOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMPA7sJywQX9+g+DQti/+4zpzpPVvSoaJAwvWXHODouqBeMHgSADxEm6Gaw+51kc6ZmeSKfQvjir4yaRq2n8skjhlgSLn1hI/a6/pa3UV/JBNuCcpu7Rz2hBxVe8kUfhE2XxgNBsnMJeAGC5qqdpsNToZGxg6S3oQxIn9PdSxug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OiIjpPi+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706008831;
	bh=Ma8J6HFntmgJqAnxZ1TzwNoqA60TOtVPoP1qAOVBdOo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OiIjpPi+qqbZF55b3g1FH53iADZRQPVIE3JvYXt24FNRlry7Mc/kxIGxSJjltIY8t
	 paaOhSDkeW/GZIyZqk/I3coGbW7gHp/dEAQKoj3DpID416Tm0AvXMs5R0o7FVT7nHv
	 n8z04qnbz8DdYLedWX5n8/cgCu2QEJ1c9qXdANZJsK+ZTrGGzUFO5ZBduQQW5P2UYr
	 VZtb1xEHO2r9LVunE4J8+Kl5Edo4MWJCUv+pMq4282q+CcC39d3P00sY+9h/fNWkja
	 EM0P7HPeVqgxT4jnvw2DZRHpYfEtgffMl6KGYqxdBOornIlk/jMc5lsF+vYmZpK+mB
	 z/OYXluJ/LUvg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 94BD937813B5;
	Tue, 23 Jan 2024 11:20:30 +0000 (UTC)
Message-ID: <e17b85b1-7f1f-4b60-89b7-43f560466cc2@collabora.com>
Date: Tue, 23 Jan 2024 12:20:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: arm: mediatek: convert PCIESYS to the
 json-schema
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Russell King <linux@armlinux.org.uk>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20240123082100.7334-1-zajec5@gmail.com>
 <20240123082100.7334-3-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240123082100.7334-3-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 23/01/24 09:20, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files. Introduced changes:
> 1. Documented "reg" property
> 2. Adjusted "reg" in example
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   .../arm/mediatek/mediatek,mt7622-pciesys.yaml | 47 +++++++++++++++++++
>   .../arm/mediatek/mediatek,pciesys.txt         | 25 ----------
>   2 files changed, 47 insertions(+), 25 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pciesys.yaml
>   delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pciesys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pciesys.yaml
> new file mode 100644
> index 000000000000..7340a2512402
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pciesys.yaml

I think that we should really move all those clock controller yaml files to their
proper directory, which would be

Documentation/devicetree/bindings/clock/

..because those are clock controllers anyway and the fact that they do also
provide a reset controller doesn't really justify having them in arm/mediatek.

Besides, I would appreciate if you could also move mt8186/92/95 and eventual
others that are there to clock/.

> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt7622-pciesys.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek PCIESYS controller
> +
> +description:
> +  The MediaTek PCIESYS controller provides various clocks to the system.
> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt7622-pciesys
> +          - mediatek,mt7629-pciesys
> +      - const: syscon

I know that there's syscon all over the place and, even if I admit I didn't check,
I am fairly sure that there's absolutely no reason to have syscon there, and that
the syscon compatible never did anything for (most of, or all of) those clock
controllers, at all.

I'm not sure - though - if removing syscon during the txt->yaml conversion is
acceptable (yeah we'd be cheating a bit), but something makes me say it is, because
the bindings couldn't validate before that one as well.

Of course you'd have to remove the syscon compatible from the affected device trees
as well as omitting it here.

However, to be sure that we're doing the right thing here, I have to summon someone
that can actually give a definitive answer to what I just said.....

Krzysztof, please? :-)

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
> +  - "#reset-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pciesys@1a100800 {

This is a clock controller, so it is clock-controller@1a100800

> +        compatible = "mediatek,mt7622-pciesys", "syscon";
> +        reg = <0x1a100800 0x1000>;
> +        #clock-cells = <1>;
> +        #reset-cells = <1>;
> +    };
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
> deleted file mode 100644
> index d179a61536f4..000000000000
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -MediaTek PCIESYS controller
> -============================
> -
> -The MediaTek PCIESYS controller provides various clocks to the system.
> -
> -Required Properties:
> -
> -- compatible: Should be:
> -	- "mediatek,mt7622-pciesys", "syscon"
> -	- "mediatek,mt7629-pciesys", "syscon"
> -- #clock-cells: Must be 1
> -- #reset-cells: Must be 1
> -
> -The PCIESYS controller uses the common clk binding from
> -Documentation/devicetree/bindings/clock/clock-bindings.txt
> -The available clocks are defined in dt-bindings/clock/mt*-clk.h.
> -
> -Example:
> -
> -pciesys: pciesys@1a100800 {
> -	compatible = "mediatek,mt7622-pciesys", "syscon";
> -	reg = <0 0x1a100800 0 0x1000>;
> -	#clock-cells = <1>;
> -	#reset-cells = <1>;
> -};



