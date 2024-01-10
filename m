Return-Path: <linux-kernel+bounces-22136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6698299D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34D11F23737
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEE0487BF;
	Wed, 10 Jan 2024 11:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="VVgp4dqZ"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3682487AC;
	Wed, 10 Jan 2024 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1704887297; x=1736423297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ea1LooPjn1EmXpCfsnqv36G7KDBDnulmi18AGgzvGbw=;
  b=VVgp4dqZcv/SyauaDlMsuMWsxGVdt6U8eJCxsJNhB9weldn1X+/qwon4
   AX5zEirW7OLndTVWYDF/2Unb7fZTqCQ5LVxPCInS+2hoQp9pxMupfFKEC
   iNKKOAjsESpEOU4F7LD6wcFru9XjDRK4wFe0Luk808HIlMh48fTriILxi
   BfsOo/RLMcXLFCYHaIeSqKovNZ/YHyaxWw+D65gx/QsQypQ6fYhlOurVU
   23ddhb5S0GuRjWi/T2Fu9eX/iZIMikEnt7XZ52CveK5YfQde/aB6VGCSx
   gRMq6uNZglKOUWCkXS5kzDqrXcudG6/uvHLJ+K9KCPPKE/g32GALa8KCD
   Q==;
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="34827806"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Jan 2024 12:48:14 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 23C77280075;
	Wed, 10 Jan 2024 12:48:14 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: dri-devel@lists.freedesktop.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor.dooley@microchip.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Andrzej Hajda <andrzej.hajda@intel.com>, Fabio Estevam <festevam@gmail.com>, Robert Foss <rfoss@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Jonas Karlman <jonas@kwiboo.se>, Liu Ying <victor.liu@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, Maxime Ripard <mripard@kernel.org>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Neil Armstrong <neil.armstrong@linaro.org>, linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH V7 1/2] dt-bindings: display: imx: add binding for i.MX8MP HDMI PVI
Date: Wed, 10 Jan 2024 12:48:13 +0100
Message-ID: <10409718.nUPlyArG6x@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240106215146.147922-1-aford173@gmail.com>
References: <20240106215146.147922-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Adam,

thanks for pushing this forward.

Am Samstag, 6. Januar 2024, 22:51:44 CET schrieb Adam Ford:
> From: Lucas Stach <l.stach@pengutronix.de>
>=20
> Add binding for the i.MX8MP HDMI parallel video interface block.
>=20
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V7:  No Change
>=20
> V6:  Add s-o-b message for myself (Adam)
>=20
> V5:  I tried to help move this along, so I took Lucas' patch and
>      attempted to apply fixes based on feedback.  I don't have
>      all the history, so apologies for that.
>      Removed the pipe character from the Description.
>      Increased the register size from 0x40 to 0x44.
> diff --git
> a/Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdmi-pvi.yaml
> b/Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdmi-pvi.yaml
> new file mode 100644
> index 000000000000..3377f152f319
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdmi-pvi.y=
aml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/imx/fsl,imx8mp-hdmi-pvi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX8MP HDMI Parallel Video Interface
> +
> +maintainers:
> +  - Lucas Stach <l.stach@pengutronix.de>
> +
> +description:
> +  The HDMI parallel video interface is a timing and sync generator block=
 in
> the +  i.MX8MP SoC, that sits between the video source and the HDMI TX
> controller. +
> +properties:
> +  compatible:
> +    const: fsl,imx8mp-hdmi-pvi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Input from the LCDIF controller.
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Output to the HDMI TX controller.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - power-domains
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/power/imx8mp-power.h>
> +
> +    display-bridge@32fc4000 {
> +        compatible =3D "fsl,imx8mp-hdmi-pvi";
> +        reg =3D <0x32fc4000 0x44>;

Shall interrupt-parent =3D <&irqsteer_hdmi>; be added here as well?

Best regards,
Alexander

> +        interrupts =3D <12 IRQ_TYPE_LEVEL_HIGH>;
> +        power-domains =3D <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_PVI>;
> +
> +        ports {
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            port@0 {
> +                reg =3D <0>;
> +                pvi_from_lcdif3: endpoint {
> +                    remote-endpoint =3D <&lcdif3_to_pvi>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg =3D <1>;
> +                pvi_to_hdmi_tx: endpoint {
> +                    remote-endpoint =3D <&hdmi_tx_from_pvi>;
> +                };
> +            };
> +        };
> +    };


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



