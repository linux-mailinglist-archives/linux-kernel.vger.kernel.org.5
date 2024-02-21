Return-Path: <linux-kernel+bounces-74878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB92785DED5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E5B1B2C6AD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40187A715;
	Wed, 21 Feb 2024 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="KN6Nomwx"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462243CF42;
	Wed, 21 Feb 2024 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525151; cv=none; b=RMWiziafMIa+1/r+KZ04ekUAmiLn4g/BKJe+tHTZeyvUh8vRcdu+E/SDayJ95iQ6XeMbv3X78/6s/AdqFBSUa5K3aHECK4QYAqA/xq0CLJUbooEokI+dp2W5lJoxG0shMvcQWsOJe4FO/K58PBWas5lg9sCBrBeSFQVuKITuJds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525151; c=relaxed/simple;
	bh=484XVZMEV57wsb7+3XUHDx88xuKknYIRkJzEl41wSd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1HPtPDltzZAdKBIs0AIrNd4I63BlU+PL7LiN04/JDZaz8wKB0uHOMAQCKb2+S7Ip1m4IZDkatW+acoejwIGuacFTcHNBuRGlGOSiYHmV9OKYX+gCfBk142LFl1vzRu092TOqDJCIOPZYNBleFRIqxkiHxjmZa1LJVw+BpfADDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=KN6Nomwx; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708525147; x=1740061147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4tGYCuZ8S9Z/8bIyUQU7cinajEjRFCnLFwqKv4o4HsY=;
  b=KN6NomwxsbywSV83rUmr+RkXr4grvoxoJbBXz8mXMawbMjK7TmvdEcCS
   IK/jLmBvy4sS3W5EtPlDKmLK65soErECU9LMyMJ1uBP0NzCGuRiexKGdx
   gnpjlEBjDfD+ixd6TyZsDCEgnKZTubeRoykmO2JiSYzMyGjPUMGsHMLGf
   nAbnySfK4bmQBo9L/ba5gD1y5s6ttuMHu8gy0cgufKiQdpawKYAeiqeuN
   SI8jJ2VykOLr9dldka5edLiPxHCEFgL2S3BILebY1JeHCDcaX0+lSrS1D
   9r/UzBYfJUDqHhgcd/XOXWXVhUfO85A9eAYFN3UmAAXGevNNGIuJ5HR/u
   g==;
X-IronPort-AV: E=Sophos;i="6.06,175,1705359600"; 
   d="scan'208";a="35525266"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 21 Feb 2024 15:18:58 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 603C7280075;
	Wed, 21 Feb 2024 15:18:58 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
	"andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	"jonas@kwiboo.se" <jonas@kwiboo.se>,
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <"li nux-phy"@lists.infradead.org>,
	Sandor Yu <sandor.yu@nxp.com>
Cc: "kernel@pengutronix.de" <kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, Oliver Brown <oliver.brown@nxp.com>, "sam@ravnborg.org" <sam@ravnborg.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v14 5/7] dt-bindings: phy: Add Freescale iMX8MQ DP and HDMI PHY
Date: Wed, 21 Feb 2024 15:18:58 +0100
Message-ID: <12385213.O9o76ZdvQC@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <PAXPR04MB9448F3065AE9F838C4553CB1F4572@PAXPR04MB9448.eurprd04.prod.outlook.com>
References: <cover.1708395604.git.Sandor.yu@nxp.com> <10421561.nUPlyArG6x@steina-w> <PAXPR04MB9448F3065AE9F838C4553CB1F4572@PAXPR04MB9448.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,

Am Mittwoch, 21. Februar 2024, 08:46:46 CET schrieb Sandor Yu:
> Hi Alexander,
>=20
> Thanks for your comments,
>=20
> >
> >
> > Hi,
> >
> > thanks for the update.
> >
> > Am Dienstag, 20. Februar 2024, 04:23:53 CET schrieb Sandor Yu:
> > > Add bindings for Freescale iMX8MQ DP and HDMI PHY.
> > >
> > > Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > > v9->v14:
> > >  *No change.
> > >
> > >  .../bindings/phy/fsl,imx8mq-dp-hdmi-phy.yaml  | 53
> > > +++++++++++++++++++
> > >  1 file changed, 53 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/phy/fsl,imx8mq-dp-hdmi-phy.yaml
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/phy/fsl,imx8mq-dp-hdmi-phy.yaml
> > > b/Documentation/devicetree/bindings/phy/fsl,imx8mq-dp-hdmi-phy.yaml
> > > new file mode 100644
> > > index 0000000000000..917f113503dca
> > > --- /dev/null
> > > +++
> > b/Documentation/devicetree/bindings/phy/fsl,imx8mq-dp-hdmi-phy.yam
> > > +++ l
> > > @@ -0,0 +1,53 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id:
> > > +http://devi/
> > >
> > +cetree.org%2Fschemas%2Fphy%2Ffsl%2Cimx8mq-dp-hdmi-phy.yaml%23&da
> > ta=3D05
> > >
> > +%7C02%7CSandor.yu%40nxp.com%7Ce79b4d15c204494963c508dc31fbab5d
> > %7C686e
> > >
> > +a1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638440204190687801%7C
> > Unknown%7
> > >
> > +CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw
> > iLCJX
> > >
> > +VCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DrKWiYc1wbOvKMO%2BWnvT6agxo
> > 9V%2B1ndZVTxh
> > > +gLT0g7h8%3D&reserved=3D0
> > > +$schema:
> > > +http://devi/
> > >
> > +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&data=3D05%7C02%7CSandor.y
> > u%40n
> > >
> > +xp.com%7Ce79b4d15c204494963c508dc31fbab5d%7C686ea1d3bc2b4c6fa9
> > 2cd99c5
> > >
> > +c301635%7C0%7C0%7C638440204190709341%7CUnknown%7CTWFpbGZsb
> > 3d8eyJWIjoi
> > >
> > +MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0
> > %7C%7C%
> > >
> > +7C&sdata=3D%2FuCSz0aVVsRLorOqrorbZIyT7iU5BavPKCbA9qL9qDI%3D&reserv
> > ed=3D0
> > > +
> > > +title: Cadence HDP-TX DP/HDMI PHY for Freescale i.MX8MQ SoC
> > > +
> > > +maintainers:
> > > +  - Sandor Yu <sandor.yu@nxp.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - fsl,imx8mq-dp-phy
> > > +      - fsl,imx8mq-hdmi-phy
> >
> > While reading cdns-mhdp8501-core.c I'm not so sure about this. There is=
 only
> > a single PHY which can be configured for either DP or HDMI.
> > Using separate compatibles for that somehow bugs me.
> > Maybe the DT maintainers can add some input if this should be single or
> > double compatibles.
> >
> When user enable MHDP8501 HDMI or DP, he should clearly know which type h=
e want to enable,
> From board type, flash.bin(firmware) to dts(connector and phy type), they=
 are all need align to HDMI or DP.

I understand your concerns. On the other hand cdns_mhdp8501_dt_parse() from
patch 4 already parses DT setup to decide whether the output is DP or HDMI.
mhdp->connector_type can be used to configure the PHY accordingly.

Best regards,
Alexander

> B.R
> Sandor
>=20
> > Thanks and best regards,
> > Alexander
> >
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: PHY reference clock.
> > > +      - description: APB clock.
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: ref
> > > +      - const: apb
> > > +
> > > +  "#phy-cells":
> > > +    const: 0
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - clocks
> > > +  - clock-names
> > > +  - "#phy-cells"
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/imx8mq-clock.h>
> > > +    #include <dt-bindings/phy/phy.h>
> > > +    dp_phy: phy@32c00000 {
> > > +        compatible =3D "fsl,imx8mq-dp-phy";
> > > +        reg =3D <0x32c00000 0x100000>;
> > > +        #phy-cells =3D <0>;
> > > +        clocks =3D <&hdmi_phy_27m>, <&clk
> > IMX8MQ_CLK_DISP_APB_ROOT>;
> > > +        clock-names =3D "ref", "apb";
> > > +    };
> > >
> >
> >
> > --
> > TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
> > Amtsgericht M=FCnchen, HRB 105018
> > Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
> > http://www.tq-/
> > group.com%2F&data=3D05%7C02%7CSandor.yu%40nxp.com%7Ce79b4d15c2044
> > 94963c508dc31fbab5d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> > %7C638440204190726471%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> > wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7
> > C&sdata=3D7xs1%2FC%2BK1cSFDc3rlBEZdNBsYw6Gc8AR6CWr2Djz4s0%3D&res
> > erved=3D0
> >
>=20
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



