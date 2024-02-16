Return-Path: <linux-kernel+bounces-68304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B0085787A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04DA7B2355C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EA21BDDB;
	Fri, 16 Feb 2024 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="NfhGZJqI"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650351B978;
	Fri, 16 Feb 2024 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708074333; cv=none; b=V1dfyeb8CYRHYvno07OVku+bXyMIPC7Xz0kxNvtSKZ6farirWm7zm3xEZTxKxo7Zvh+Yru2f95n2SqNL6K1dbi60PLDlm0I1C2HFilyuX0HPDqAO8GvDlvIoiBBA3q/lSXRc4hcRhAfm7Rh9OT73FvkpaaLs5oRxjLPNHT9mnuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708074333; c=relaxed/simple;
	bh=b3i9lcb0CgqU/Tao29pcsoyVFjxM+a2TkJlbTzzBGVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYIRxG9aIpiiIwJlgr+boVBAxBZd8cq422enOEPAQDxdXkeqSm4kCPQfHDmsyR+AlsS/I74L1UwHbR+NJ3p6uVUQBM72TCBgVAGJnAIPtWfmhf3IhejY06BEwpnJ8EYXXxdud27LwfEfeuGL9l3D6dmqZ3YCLpejkpWHQTCfK1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=NfhGZJqI; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708074330; x=1739610330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9vIOGZfDhKu9DGx5o5UYxS0vQjX/6Zu979oLg6n9Etg=;
  b=NfhGZJqIdAixnWZJbLGuVmX0Ds3WOiW7B06rQtC2uF+MFvZ9rcDKkeP3
   dT4UhbSibnZyyZ6xHK2Bb07boZVXa1AFGzqLb/Kv7Pq2aLJLM/gyr9muu
   aHv0hwzF/AeWhz8yc5hwQE4DvAPvRCYvnuNBKt+b8hMy7Siuu+2hbrCyX
   x6KGt6vkYYgNy4CL1yNH7mwDWphe34GEXgz8K5GU26oGOi6pj/2Pn2+0v
   fKa2naKzpUmXxJiMgp6HYU6gQvHRGaO75JjOegLyuKUuv157oQ2gCHXRY
   1kJIX6fvVR2w95Vpjl/teLCAwiN7eypmPik1JEBfKdGlBcjsabnJ4C+Ac
   w==;
X-IronPort-AV: E=Sophos;i="6.06,164,1705359600"; 
   d="scan'208";a="35440531"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Feb 2024 10:05:25 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 1BAE5280075;
	Fri, 16 Feb 2024 10:05:25 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org
Cc: marex@denx.de, frieder.schrempf@kontron.de, Lucas Stach <l.stach@pengutronix.de>, Adam Ford <aford173@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
  Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Liu Ying <victor.liu@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH V8 09/12] dt-bindings: display: imx: add binding for i.MX8MP HDMI TX
Date: Fri, 16 Feb 2024 10:05:26 +0100
Message-ID: <5916132.MhkbZ0Pkbq@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240203165307.7806-10-aford173@gmail.com>
References: <20240203165307.7806-1-aford173@gmail.com> <20240203165307.7806-10-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi all,

Am Samstag, 3. Februar 2024, 17:52:49 CET schrieb Adam Ford:
> From: Lucas Stach <l.stach@pengutronix.de>
>=20
> The HDMI TX controller on the i.MX8MP SoC is a Synopsys designware IP
> core with a little bit of SoC integration around it.
>=20
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Adam Ford <aford173@gmail.com>
>=20
> ---
> V3:  Change name and location to better idenfity as a bridge and
>      HDMI 2.0a transmitter
>=20
>      Fix typos and feedback from Rob and added ports.
> ---
>  .../display/bridge/fsl,imx8mp-hdmi-tx.yaml    | 102 ++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.yaml
>=20
> diff --git
> a/Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.yaml
> b/Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.yaml
> new file mode 100644
> index 000000000000..3791c9f4ebab
> --- /dev/null
> +++
> b/Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/fsl,imx8mp-hdmi-tx.yam=
l#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX8MP DWC HDMI TX Encoder
> +
> +maintainers:
> +  - Lucas Stach <l.stach@pengutronix.de>
> +
> +description:
> +  The i.MX8MP HDMI transmitter is a Synopsys DesignWare
> +  HDMI 2.0a TX controller IP.
> +
> +allOf:
> +  - $ref: /schemas/display/bridge/synopsys,dw-hdmi.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8mp-hdmi-tx
> +
> +  reg-io-width:
> +    const: 1
> +
> +  clocks:
> +    maxItems: 4
> +
> +  clock-names:
> +    items:
> +      - const: iahb
> +      - const: isfr
> +      - const: cec
> +      - const: pix
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
> +        description: Parallel RGB input port
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: HDMI output port
> +
> +    required:
> +      - port@0
> +      - port@1

Is this really correct that port@1 is required? AFAICS this host already=20
supports HPD and DDC by itself, so there is no need for a dedicated HDMI=20
connector.
With the current state of the drivers this output port is completely ignore=
d=20
anyway. Yet it works for a lot of people.

Best regards,
Alexander

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - power-domains
> +  - ports
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mp-clock.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/power/imx8mp-power.h>
> +
> +    hdmi@32fd8000 {
> +        compatible =3D "fsl,imx8mp-hdmi-tx";
> +        reg =3D <0x32fd8000 0x7eff>;
> +        interrupts =3D <0 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks =3D <&clk IMX8MP_CLK_HDMI_APB>,
> +                 <&clk IMX8MP_CLK_HDMI_REF_266M>,
> +                 <&clk IMX8MP_CLK_32K>,
> +                 <&hdmi_tx_phy>;
> +        clock-names =3D "iahb", "isfr", "cec", "pix";
> +        power-domains =3D <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_HDMI_TX>;
> +        reg-io-width =3D <1>;
> +        ports {
> +           #address-cells =3D <1>;
> +           #size-cells =3D <0>;
> +           port@0 {
> +             reg =3D <0>;
> +
> +             hdmi_tx_from_pvi: endpoint {
> +               remote-endpoint =3D <&pvi_to_hdmi_tx>;
> +             };
> +          };
> +
> +          port@1 {
> +            reg =3D <1>;
> +              hdmi_tx_out: endpoint {
> +                remote-endpoint =3D <&hdmi0_con>;
> +              };
> +          };
> +        };
> +    };


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



