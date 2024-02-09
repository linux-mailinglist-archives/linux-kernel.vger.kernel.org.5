Return-Path: <linux-kernel+bounces-60093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA2984FFBD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D31281D0D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1D1381BF;
	Fri,  9 Feb 2024 22:18:08 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B2925748;
	Fri,  9 Feb 2024 22:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517087; cv=none; b=b2T7MJVy39j0gIPfsOHKSFxzRTuvEKXxIifFwlFdCUdXM3A40/+Oe4Em+Q2GsGd+++x0CeQ158/Jt0FA3Bn47R4pypHC1WHZhJCqFu15dJHZ6e51xF7I1WOHXad8uIY09JM7WRJj5ppe9lfvT+zMhqeOf1lMuAgjUZ5hrts5e+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517087; c=relaxed/simple;
	bh=7tbkgyy9saKSRyBIxabQor3qpnFHI3DnO5mdDOv/3Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPBxPlniuuStgTxt2xjX6O55sOcdIYpuy3VkqLoaQilwk2MUw5sVTJBz4FoaedAtVK/ehPKzowgc0mSzqtMS1iDm5TGc5xn81t64B8IAYVvBPV9X/Ql3/raRm10Uzy8wu0CLxd9NVNPpoFWORsFxWlxCKB8Ck5r2NQ91VaStguk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861914.versanet.de ([94.134.25.20] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rYZBm-00089k-3z; Fri, 09 Feb 2024 23:17:42 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Wang <frank.wang@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com
Subject:
 Re: [PATCH v1 03/10] dt-bindings: phy: add rockchip usbdp combo phy document
Date: Fri, 09 Feb 2024 23:17:40 +0100
Message-ID: <3267388.oiGErgHkdL@diego>
In-Reply-To: <20240209181831.104687-4-sebastian.reichel@collabora.com>
References:
 <20240209181831.104687-1-sebastian.reichel@collabora.com>
 <20240209181831.104687-4-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Am Freitag, 9. Februar 2024, 19:17:19 CET schrieb Sebastian Reichel:
> Add device tree binding document for Rockchip USBDP Combo PHY
> with Samsung IP block.
> 
> Co-developed-by: Frank Wang <frank.wang@rock-chips.com>
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

looks ok to me overall, but I stumbled over some spelling below.

> ---
>  .../bindings/phy/phy-rockchip-usbdp.yaml      | 166 ++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> new file mode 100644
> index 000000000000..3375a3099038
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> @@ -0,0 +1,166 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/phy-rockchip-usbdp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip USBDP Combo PHY with Samsung IP block
> +
> +maintainers:
> +  - Frank Wang <frank.wang@rock-chips.com>
> +  - Zhang Yubing <yubing.zhang@rock-chips.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3588-usbdp-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 4
> +
> +  clock-names:
> +    items:
> +      - const: refclk
> +      - const: immortal
> +      - const: pclk
> +      - const: utmi
> +
> +  resets:
> +    maxItems: 5
> +
> +  reset-names:
> +    items:
> +      - const: init
> +      - const: cmn
> +      - const: lane
> +      - const: pcs_apb
> +      - const: pma_apb
> +
> +  rockchip,dp-lane-mux:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 2
> +    maxItems: 4
> +    description:
> +      An array of physical Tyep-C lanes indexes. Position of an entry determines

nit: Type-C lane indexes

> +      the dp lane index, while the value of an entry indicater physical Type-C lane.

nit: indicates instead of indicater?

> +      The support dp lanes number are 2 or 4. e.g. for 2 lanes dp lanes map, we could

nit: The supported dp lane numbers ... ?


> +      have "rockchip,dp-lane-mux = <2, 3>;", assuming dp lane0 on Type-C phy lane2,
> +      dp lane1 on Type-C phy lane3. For 4 lanes dp lanes map, we could have
> +      "rockchip,dp-lane-mux = <0, 1, 2, 3>;", assuming dp lane0 on Type-C phy lane0,
> +      dp lane1 on Type-C phy lane1, dp lane2 on Type-C phy lane2, dp lane3 on Type-C
> +      phy lane3. If dp lane map by DisplayPort Alt mode, this property is not need.
> +
> +  rockchip,u2phy-grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon managing the 'usb2 phy general register files'.
> +
> +  rockchip,usb-grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon managing the 'usb general register files'.
> +
> +  rockchip,usbdpphy-grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon managing the 'usbdp phy general register files'.
> +
> +  rockchip,vo-grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon managing the 'video output general register files'.
> +      When select the dp lane mapping will request its phandle.
> +
> +  sbu1-dc-gpios:
> +    description:
> +      GPIO connected to the SBU1 line of the USB-C connector via a big resistor
> +      (~100K) to apply a DC offset for signalling the connector orientation.
> +
> +  sbu2-dc-gpios:
> +    description:
> +      GPIO connected to the SBU2 line of the USB-C connector via a big resistor
> +      (~100K) to apply a DC offset for signalling the connector orientation.
> +
> +  orientation-switch:
> +    description: Flag the port as possible handler of orientation switching
> +    type: boolean
> +
> +  mode-switch:
> +    description: Flag the port as possible handle of altmode switching

nit: also a handler ... aka add an r ?


Heiko



