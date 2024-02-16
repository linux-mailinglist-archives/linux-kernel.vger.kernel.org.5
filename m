Return-Path: <linux-kernel+bounces-68538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B77857BED
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EA21F27391
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A01477F2C;
	Fri, 16 Feb 2024 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="aCHzXmcI"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0FB77F12;
	Fri, 16 Feb 2024 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083775; cv=none; b=QOCwvjiLNRVL+L5vhQIfKXVDs8WLPrmBDJelWksf+fz/0cSx+i1PNCtwkWMjzoHbNXRSm06SyjZi0eO7o4U5jlYEelVF0f+2pYItk+dges454WmRqbuTIimEFOqy2OJdOyMvX/Pp/TnuGTEs5kq9Bc4bO/++4gA2KZupXbi9+Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083775; c=relaxed/simple;
	bh=ir/2Fmuw0p7JWNzUui20venQobUnV6OhWF5JMo4bd4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXcMoFwxxUwJnTFeA6C0UyUCvGegwVPfFh/iN89AkyDNA8IGLJTnKTQ8dU+QaODQI64CDJjQ9NkIGatWeq5YimxdEalDUxyUNnDE5foYXpIdSkRe6DaqhUaktC4fb6K+tqtDHuEfU/tl5lgZyfcUDrdNctCj74m0XKWq3tjUzB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=aCHzXmcI; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708083771; x=1739619771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MD8PpJdyDycq4idMKhBHf1v7B8Lage9uviizqG+a/uo=;
  b=aCHzXmcIRYE5jUai2ns/GfF/4K7g5olCR6BVXq+cFaFS+4UIKNWsm1J2
   pXTDiRr9H83quIe4rTeEDuL4dvDtEaXEiXHk3wIEQOjzRQoEMJho3ysGg
   bPzHJn/SJzIuadO3pmFRpUB/cvsZ/nG7i9SKYG8jAcFhiM3kXZuMJCCMq
   6uu6Y+NRHBxSQ0b3CouAepushe/uXMmN7nl6i2xV05jwCtnSRObHP7RIq
   JKeY7UmHpPe399bi6rDjSPZ39c6PpQHeRpqMyD1JIT64+TOKZf6wf2hw+
   LSIs1xA+FtfMUN5lZEIdYaOEh/W2Oj/ZkPC9nMwIz2smCWgB270pb8V+s
   Q==;
X-IronPort-AV: E=Sophos;i="6.06,164,1705359600"; 
   d="scan'208";a="35445169"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Feb 2024 12:42:47 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 687E7280075;
	Fri, 16 Feb 2024 12:42:47 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, marex@denx.de, frieder.schrempf@kontron.de, Lucas Stach <l.stach@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>, Vinod Koul <vkoul@kernel.org>, Kish
 on Vijay Abraham I <kishon@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Liu Ying <victor.liu@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V8 09/12] dt-bindings: display: imx: add binding for i.MX8MP HDMI TX
Date: Fri, 16 Feb 2024 12:42:49 +0100
Message-ID: <2184519.Mh6RI2rZIc@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CAHCN7x+80iw0PWa4F4dMA=3RRaChNEO534LPACXd6FK0ndAHpw@mail.gmail.com>
References: <20240203165307.7806-1-aford173@gmail.com> <5916132.MhkbZ0Pkbq@steina-w> <CAHCN7x+80iw0PWa4F4dMA=3RRaChNEO534LPACXd6FK0ndAHpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Freitag, 16. Februar 2024, 12:31:12 CET schrieb Adam Ford:
> On Fri, Feb 16, 2024 at 3:05=E2=80=AFAM Alexander Stein
>=20
> <alexander.stein@ew.tq-group.com> wrote:
> > Hi all,
> >=20
> > Am Samstag, 3. Februar 2024, 17:52:49 CET schrieb Adam Ford:
> > > From: Lucas Stach <l.stach@pengutronix.de>
> > >=20
> > > The HDMI TX controller on the i.MX8MP SoC is a Synopsys designware IP
> > > core with a little bit of SoC integration around it.
> > >=20
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > >=20
> > > ---
> > > V3:  Change name and location to better idenfity as a bridge and
> > >=20
> > >      HDMI 2.0a transmitter
> > >     =20
> > >      Fix typos and feedback from Rob and added ports.
> > >=20
> > > ---
> > >=20
> > >  .../display/bridge/fsl,imx8mp-hdmi-tx.yaml    | 102 ++++++++++++++++=
++
> > >  1 file changed, 102 insertions(+)
> > >  create mode 100644
> > >=20
> > > Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.y=
aml
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx=
=2Eya
> > > ml
> > > b/Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx=
=2Eya
> > > ml
> > > new file mode 100644
> > > index 000000000000..3791c9f4ebab
> > > --- /dev/null
> > > +++
> > > b/Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx=
=2Eya
> > > ml
> > > @@ -0,0 +1,102 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id:
> > > http://devicetree.org/schemas/display/bridge/fsl,imx8mp-hdmi-tx.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Freescale i.MX8MP DWC HDMI TX Encoder
> > > +
> > > +maintainers:
> > > +  - Lucas Stach <l.stach@pengutronix.de>
> > > +
> > > +description:
> > > +  The i.MX8MP HDMI transmitter is a Synopsys DesignWare
> > > +  HDMI 2.0a TX controller IP.
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/display/bridge/synopsys,dw-hdmi.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - fsl,imx8mp-hdmi-tx
> > > +
> > > +  reg-io-width:
> > > +    const: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 4
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: iahb
> > > +      - const: isfr
> > > +      - const: cec
> > > +      - const: pix
> > > +
> > > +  power-domains:
> > > +    maxItems: 1
> > > +
> > > +  ports:
> > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > +
> > > +    properties:
> > > +      port@0:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: Parallel RGB input port
> > > +
> > > +      port@1:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: HDMI output port
> > > +
> > > +    required:
> > > +      - port@0
> > > +      - port@1
> >=20
> > Is this really correct that port@1 is required? AFAICS this host already
> > supports HPD and DDC by itself, so there is no need for a dedicated HDMI
> > connector.
> > With the current state of the drivers this output port is completely
> > ignored anyway. Yet it works for a lot of people.
>=20
> One of the feedback responses Lucas got was that it was missing the
> reference to the HDMI connector, so I added it as a response to that
> feedback.  I have tried device trees with and without it, and it
> doesn't impact anything, but It seems like there may be a requirement
> for it.

Yes, I noticed as well. A specified connector is completely ignored.
One reason is that dw_hdmi_plat_data.output_port is unsed in drivers/gpu/dr=
m/
bridge/imx/imx8mp-hdmi-tx.c. Another one is that without=20
DRM_BRIDGE_ATTACH_NO_CONNECTOR support in drivers/gpu/drm/mxsfb/lcdif_drv.c=
=20
nothing changes.

Best regards,
Alexander

> adam
>=20
> > Best regards,
> > Alexander
> >=20
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - clocks
> > > +  - clock-names
> > > +  - interrupts
> > > +  - power-domains
> > > +  - ports
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/imx8mp-clock.h>
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +    #include <dt-bindings/power/imx8mp-power.h>
> > > +
> > > +    hdmi@32fd8000 {
> > > +        compatible =3D "fsl,imx8mp-hdmi-tx";
> > > +        reg =3D <0x32fd8000 0x7eff>;
> > > +        interrupts =3D <0 IRQ_TYPE_LEVEL_HIGH>;
> > > +        clocks =3D <&clk IMX8MP_CLK_HDMI_APB>,
> > > +                 <&clk IMX8MP_CLK_HDMI_REF_266M>,
> > > +                 <&clk IMX8MP_CLK_32K>,
> > > +                 <&hdmi_tx_phy>;
> > > +        clock-names =3D "iahb", "isfr", "cec", "pix";
> > > +        power-domains =3D <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_HDMI_TX>;
> > > +        reg-io-width =3D <1>;
> > > +        ports {
> > > +           #address-cells =3D <1>;
> > > +           #size-cells =3D <0>;
> > > +           port@0 {
> > > +             reg =3D <0>;
> > > +
> > > +             hdmi_tx_from_pvi: endpoint {
> > > +               remote-endpoint =3D <&pvi_to_hdmi_tx>;
> > > +             };
> > > +          };
> > > +
> > > +          port@1 {
> > > +            reg =3D <1>;
> > > +              hdmi_tx_out: endpoint {
> > > +                remote-endpoint =3D <&hdmi0_con>;
> > > +              };
> > > +          };
> > > +        };
> > > +    };
> >=20
> > --
> > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, =
Germany
> > Amtsgericht M=C3=BCnchen, HRB 105018
> > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan=
 Schneider
> > http://www.tq-group.com/


=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/



