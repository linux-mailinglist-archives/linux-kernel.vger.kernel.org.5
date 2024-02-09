Return-Path: <linux-kernel+bounces-59133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF3B84F1BD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0EDDB29369
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB4C66B5A;
	Fri,  9 Feb 2024 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="og1eab/P"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C54664AF;
	Fri,  9 Feb 2024 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468802; cv=none; b=p9VgpCmI+emJ7SLHXs9MTTEHbW+WvTYvTSu4Vm+ngRStIVU5N/j1IOYztHsx6xC42+GR1fqHin9BDQK3THSj33N90eBofc+Y3IJBVkANPOx/JTOX6+dOCSqmcxC+Q8PmOJq7iyL0vdQ8RokiWzltPireKdi7ybXfVhOSEAvhqmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468802; c=relaxed/simple;
	bh=30icvp5V3/sN88X5yZ5Qu/GuxcwktWzuh4T4oylBLLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SnhIzKEHAHG1GFAIFPPmzWvJvw1m+dDM5gLQgw9Y/+aWMjn98ojZcSoOZKeSD90zKBdn6vdzb0Ur4P1TL047iuqEydt4Iwu4FocSfEp/pc/7Ax8jQc2hHY0pA0USemcsGuY7JjwhCGfnj2fJl1tct3xNt/CsRDa1cWgC1U6c/VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=og1eab/P; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707468799;
	bh=30icvp5V3/sN88X5yZ5Qu/GuxcwktWzuh4T4oylBLLM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=og1eab/P3zYG4XIff5Tzr59qJhbZSaeeoG4aGvVSriIqow5keEhjlYxUdPUGkr1Bb
	 dinNWGwZ367ad6BycXdiHtXo+Ba2DwIazn8S9beJLq5yEmxb0maXqc1TBzmOtRORot
	 i3YIjpXLZe74qPqvXooQdhr51SuWNb03mYd6VQodEtpD05ZiAk1qPi82WOieRhOhwz
	 mXCbgiYVO5KNP6yjtM0xws4+cJrQktkCJxtUalRP1gGNWR/qdERPI0HOdLlTtOyNHq
	 wmxwHxseaT0NfCc78o2mwk0L3ijI9aVMPVrURWeHZ3v52YnRn+R+Hc0uOMgFdTEZsc
	 piYoRWqubbWqg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2E9533782069;
	Fri,  9 Feb 2024 08:53:18 +0000 (UTC)
Message-ID: <d4a4a468-4a81-413e-9de6-060c2ba9e0b6@collabora.com>
Date: Fri, 9 Feb 2024 09:53:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] dt-bindings: arm: mediatek: convert hifsys to the
 json-schema clock
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240208215926.10085-1-zajec5@gmail.com>
 <20240208215926.10085-2-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240208215926.10085-2-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 08/02/24 22:59, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files. Introduced changes:
> 1. Documented "reg" property
> 2. Documented "#reset-cells" property
> 3. Dropped "syscon" as it was incorrectly used
> 4. Adjusted "compatible" and "reg" in example
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   .../bindings/arm/mediatek/mediatek,hifsys.txt | 26 ----------
>   .../clock/mediatek,mt2701-hifsys.yaml         | 51 +++++++++++++++++++
>   2 files changed, 51 insertions(+), 26 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
>   create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
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
> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
> new file mode 100644
> index 000000000000..eb429337cdf4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/mediatek,mt2701-hifsys.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek hifsys controller

Please, "MediaTek HIFSYS controller"

> +
> +description:
> +  The Mediatek hifsys controller provides various clocks and reset outputs to
> +  the system.

Same here, "The MediaTek HIFSYS controller..."

Anyway, apart from that

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers!

