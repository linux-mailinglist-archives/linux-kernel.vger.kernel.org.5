Return-Path: <linux-kernel+bounces-66894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E3785633A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66AE91C215AC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CC412D740;
	Thu, 15 Feb 2024 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GisX5szz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C58C12CDA7;
	Thu, 15 Feb 2024 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000293; cv=none; b=BldbxlPeozHXVHBOTBSPA/JcipYppJaPtuKLUZq8VXz7dmpaJT6tJP886jfx1QsJ5ZNNuXaE4bxuP+00q/k8tAMFeJ2IvJEmRop0PiYyspruVTYgA6TSj8K+24cXVLaCgk9mWDFydF7JBj8XC7VGM2lCcoaVGvCITdQU8bbUFyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000293; c=relaxed/simple;
	bh=Rtv0ZqMtH22wW9o5CLE4ANcXNgzVDytLO9CvtPg0SkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPOWNO7FYHIZXRbUk+9opErCr5uZtOl4nDal0Z2l3HWnMAERAeUT1rNmzA/Vi4FBt5rC2AEmyX/vYWtpOuiZpp8gD5cUsp2YK/USPsrsgPXoDyDqJj4xLXzCdYgqQQacEA9PJFHr8HWZh8zKesNJzCbZPDLz5cV0OYrTU75kuK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GisX5szz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646FDC433C7;
	Thu, 15 Feb 2024 12:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708000290;
	bh=Rtv0ZqMtH22wW9o5CLE4ANcXNgzVDytLO9CvtPg0SkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GisX5szz172MOWHxrJ6VLy2Hi6J/ulEGFD7SFjzkGTrkt9FyYw3+DUKZf29RA5RyC
	 xTORMDyt4X7YRKEcuBI2Cx7psIyk4w5Ja9/p41UbAZQ/cHpyTyqR7Rj5Nb1oBVvISs
	 GNLSnkBPATXd8bp8uriJ/jM3jB52QqEn+n5V/migzlddtXiv0vkoA9/x8HSt+hka/R
	 51yBSdgZBrS2P9LTibJRw19TQroncSWhPTe/j74rQl77zH4BWaTkU+wX4X7alSgiNu
	 i+Bw1Dw6GFSECfuxp4yyJyhy484KO3FACaGt0qEWIqE05qWk4GYrEpVzPyt6MJ9w31
	 jPjEtAzijKqDg==
Date: Thu, 15 Feb 2024 06:31:27 -0600
From: Rob Herring <robh@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v2 03/12] dt-bindings: phy: add rockchip usbdp combo phy
 document
Message-ID: <20240215123127.GA3762185-robh@kernel.org>
References: <20240213163609.44930-1-sebastian.reichel@collabora.com>
 <20240213163609.44930-4-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213163609.44930-4-sebastian.reichel@collabora.com>

On Tue, Feb 13, 2024 at 05:32:37PM +0100, Sebastian Reichel wrote:
> Add device tree binding document for Rockchip USBDP Combo PHY
> with Samsung IP block.
> 
> Co-developed-by: Frank Wang <frank.wang@rock-chips.com>
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/phy/phy-rockchip-usbdp.yaml      | 169 ++++++++++++++++++
>  1 file changed, 169 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> new file mode 100644
> index 000000000000..4ac1825144d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> @@ -0,0 +1,169 @@
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

items:
  maximum: 3

> +    description:
> +      An array of physical Type-C lanes indexes. Position of an entry
> +      determines the DisplayPort (DP) lane index, while the value of an entry
> +      indicates physical Type-C lane. The supported DP lanes number are 2 or 4.
> +      e.g. for 2 lanes DP lanes map, we could have "rockchip,dp-lane-mux = <2,
> +      3>;", assuming DP lane0 on Type-C phy lane2, DP lane1 on Type-C phy
> +      lane3. For 4 lanes DP lanes map, we could have "rockchip,dp-lane-mux =
> +      <0, 1, 2, 3>;", assuming DP lane0 on Type-C phy lane0, DP lane1 on Type-C
> +      phy lane1, DP lane2 on Type-C phy lane2, DP lane3 on Type-C phy lane3. If
> +      DP lane map by DisplayPort Alt mode, this property is not need.
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
> +      When select the DP lane mapping will request its phandle.
> +
> +  sbu1-dc-gpios:
> +    description:
> +      GPIO connected to the SBU1 line of the USB-C connector via a big resistor
> +      (~100K) to apply a DC offset for signalling the connector orientation.
> +    maxItems: 1
> +
> +  sbu2-dc-gpios:
> +    description:
> +      GPIO connected to the SBU2 line of the USB-C connector via a big resistor
> +      (~100K) to apply a DC offset for signalling the connector orientation.
> +    maxItems: 1
> +
> +  orientation-switch:
> +    description: Flag the port as possible handler of orientation switching
> +    type: boolean
> +
> +  mode-switch:
> +    description: Flag the port as possible handler of altmode switching
> +    type: boolean
> +
> +  dp-port:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      "#phy-cells":
> +        const: 0
> +
> +    required:
> +      - "#phy-cells"
> +
> +  usb3-port:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      "#phy-cells":
> +        const: 0
> +
> +    required:
> +      - "#phy-cells"


I don't see why these child nodes are needed. Just use a cell to define 
DP and USB3 phys.

> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description:
> +      A port node to link the PHY to a TypeC controller for the purpose of
> +      handling orientation switching.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - dp-port
> +  - usb3-port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
> +    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
> +
> +    usbdp_phy0: phy@fed80000 {
> +      compatible = "rockchip,rk3588-usbdp-phy";
> +      reg = <0xfed80000 0x10000>;
> +      clocks = <&cru CLK_USBDPPHY_MIPIDCPPHY_REF>,
> +               <&cru CLK_USBDP_PHY0_IMMORTAL>,
> +               <&cru PCLK_USBDPPHY0>,
> +               <&u2phy0>;
> +      clock-names = "refclk", "immortal", "pclk", "utmi";
> +      resets = <&cru SRST_USBDP_COMBO_PHY0_INIT>,
> +               <&cru SRST_USBDP_COMBO_PHY0_CMN>,
> +               <&cru SRST_USBDP_COMBO_PHY0_LANE>,
> +               <&cru SRST_USBDP_COMBO_PHY0_PCS>,
> +               <&cru SRST_P_USBDPPHY0>;
> +      reset-names = "init", "cmn", "lane", "pcs_apb", "pma_apb";
> +      rockchip,u2phy-grf = <&usb2phy0_grf>;
> +      rockchip,usb-grf = <&usb_grf>;
> +      rockchip,usbdpphy-grf = <&usbdpphy0_grf>;
> +      rockchip,vo-grf = <&vo0_grf>;
> +
> +      usbdp_phy0_dp: dp-port {
> +        #phy-cells = <0>;
> +      };
> +
> +      usbdp_phy0_u3: usb3-port {
> +        #phy-cells = <0>;
> +      };
> +    };
> -- 
> 2.43.0
> 

