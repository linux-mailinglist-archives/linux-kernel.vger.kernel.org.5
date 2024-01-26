Return-Path: <linux-kernel+bounces-39901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 003D983D733
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9661F2B87F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2807E66B4D;
	Fri, 26 Jan 2024 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uBTAk+9P"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF87D6772A;
	Fri, 26 Jan 2024 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260424; cv=none; b=eK2aZ3l3kIGT8Z3e0Lge1Jsh/+TkLLnKxPUfy/UoFMzuUgPNr5WdY66iVG/jH6UMvmrcjvwEp3A0c4wLRzZR85NpoFkepgoZ4InQXSQrdeJQOh44qYYvD28ciQbThE98eot0tX7m/HgAUDU4rGOMKbUKDpNkXhymSHL0/YHWvas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260424; c=relaxed/simple;
	bh=ixHA4ByvJdYwI4VG4upsmomgkVlzfaNWXloCbrP7WpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dqzhx+/d1IT6jcbBCAV4kkBPh56bCFMwGbp+qrECsfpJbSRO5jNdt2LZ6tmFLx3Xewba71aQuMGAbkesmEB5rqZ1MrXQE/o8QJp2WguKZJhnCW/3IZA1s1X5fpTEbX6SV1ziBauDNDqCE0U7i7qsBJySLfx7G28FVujyYRR4FL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=uBTAk+9P; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706260421;
	bh=ixHA4ByvJdYwI4VG4upsmomgkVlzfaNWXloCbrP7WpE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uBTAk+9PlPa/wc0i6kX1JN/PCLrIrGXTAg4pE6Yb8HZ841bcL1/8hVSbFpjUzDrNS
	 Xdz97p6c9l6hSg01dkMz8HYQhvP9hSBtrYOcoJFiRP2DJtHKU2sOR9o9Ku+yrdfFAt
	 tHo7bZnc2fAkzgIu1DBJKIP2x4CU9uzjvjdvwcjRE4criuNib1zB/MXOawjUo+JMke
	 wujOIMXPvYxOQtweBNYBOVSvMet1rUIotg/0ro6h0IJTkZOCOKWYSVPd3zBUH5Khib
	 hkH7op4BoBDZ6mgXJx3inkYmJFew32r2Ba7R65I+fDD4iiQmTr2c2ynXx7SQkNWOSU
	 kwJR5SQa7Wydg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 528853782072;
	Fri, 26 Jan 2024 09:13:40 +0000 (UTC)
Message-ID: <69af3310-3e6f-4730-bebc-44d5e29498b6@collabora.com>
Date: Fri, 26 Jan 2024 10:13:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S
 SDIO Bluetooth
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Sean Wang <sean.wang@mediatek.com>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240126063500.2684087-1-wenst@chromium.org>
 <20240126063500.2684087-2-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240126063500.2684087-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/01/24 07:34, Chen-Yu Tsai ha scritto:
> The MediaTek MT7921S is a WiFi/Bluetooth combo chip that works over
> SDIO. While the Bluetooth function is fully discoverable, the chip
> has a pin that can reset just the Bluetooth side, as opposed to the
> full chip. This needs to be described in the device tree.
> 
> Add a device tree binding for MT7921S Bluetooth over SDIO specifically
> ot document the reset line.
> 
> Cc: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> Changes since v1:
> - Reworded descriptions
> - Moved binding maintainer section before description
> - Added missing reference to bluetooth-controller.yaml
> - Added missing GPIO header to example
> 
>   .../bluetooth/mediatek,mt7921s-bluetooth.yaml | 53 +++++++++++++++++++
>   MAINTAINERS                                   |  1 +
>   2 files changed, 54 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
> new file mode 100644
> index 000000000000..ff11c95c816c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/bluetooth/mediatek,mt7921s-bluetooth.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT7921S Bluetooth
> +
> +maintainers:
> +  - Sean Wang <sean.wang@mediatek.com>
> +
> +description:
> +  MT7921S is an SDIO-attached dual-radio WiFi+Bluetooth Combo chip; each
> +  function is its own SDIO function on a shared SDIO interface. The chip
> +  has two dedicated reset lines, one for each function core.
> +  This binding only covers the Bluetooth part of the chip.
> +
> +allOf:
> +  - $ref: bluetooth-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt7921s-bluetooth
> +  reg:
> +    const: 2
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      An active-low reset line for the Bluetooth core; on typical M.2
> +      key E modules this is the W_DISABLE2# pin.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    mmc {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        bluetooth@2 {
> +            compatible = "mediatek,mt7921s-bluetooth";
> +            reg = <2>;
> +            reset-gpios = <&pio 8 GPIO_ACTIVE_LOW>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b64a64ca7916..662957146852 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13657,6 +13657,7 @@ M:	Sean Wang <sean.wang@mediatek.com>
>   L:	linux-bluetooth@vger.kernel.org
>   L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
> +F:	Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
>   F:	Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
>   F:	drivers/bluetooth/btmtkuart.c
>   




