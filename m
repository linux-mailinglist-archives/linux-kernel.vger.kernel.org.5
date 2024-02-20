Return-Path: <linux-kernel+bounces-72774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C3985B88F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193CB282519
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACD060EE4;
	Tue, 20 Feb 2024 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ZNq9hKe3"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E612660DFC;
	Tue, 20 Feb 2024 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423624; cv=none; b=UUvmYOHNG4gdfuhXpLMCmqFWK1rAdv2IZ+LHPAz26iu6ls00TGQitTYOPMRQ3WSThkKJ78A5nyILRZ7WBiT3oSHH/90ZmLK4BR4Ggq31HFRuz1NNOcTyKnhATUqKJxJcaoex0cOOA3Ci8HjJJonXWi3NCs6zt1QwYBxgKesq9rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423624; c=relaxed/simple;
	bh=xIO592TEd7xsEYkhc1BTJL0fAK88FdF5U0RNn55ktZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUjN8wTZC7ZWfTHNka+xYqE1SVd+I4Zne3YxpwV3OeEsAa5cpDuhZfLX8ATE2WPjIoAA2V0tIo5ZsZ7sDwGPAXb9uyNdUb5wORuSw/ujTUcPWj/lQ1JTNNENalV2avBdSc1Kx0yPNaNfMFVWfFtJSLfqoyx65Vtu9uvgACiNtzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ZNq9hKe3; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708423621; x=1739959621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EzVIo/Erko3TaB1q/0Z3yVbLBXjoJVz6+76Ci1MxT2A=;
  b=ZNq9hKe3TGsbChXEd570e2C5SxLk9la8j3qKE5IggNGFiz44bPlaUEvi
   Zf2Yd/2WZFqo9APEDX1EkguwNKjCaPs+OQk/Lw4zf+eyoPruJ9RZ/lEhJ
   KPNJM+QpDNd1/ytq6r88xmKIgW3Jp4cwOrMtnM05HKtqxp7G59WbJLK4j
   KIITt2iWW2GpdxoxJfDRtY59zwx7Scp1KMmIgnZJqAWN6xtQK10VlJff4
   CP2D2ZF5jzcW1BY/a7QQhvzQfiRgiJ9jisj7yqv00i+7EHzJL4n5YyvJV
   cI1dk89TB9/6CbOvwafYErWk+JbGu2x5dMsv76RhkiL8xkW+Fe+ugcfP1
   g==;
X-IronPort-AV: E=Sophos;i="6.06,172,1705359600"; 
   d="scan'208";a="35495206"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 20 Feb 2024 11:06:52 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 458BD280075;
	Tue, 20 Feb 2024 11:06:52 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: dmitry.baryshkov@linaro.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, vkoul@kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, Sandor Yu <Sandor.yu@nxp.com>
Cc: kernel@pengutronix.de, linux-imx@nxp.com, Sandor.yu@nxp.com, oliver.brown@nxp.com, sam@ravnborg.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v14 5/7] dt-bindings: phy: Add Freescale iMX8MQ DP and HDMI PHY
Date: Tue, 20 Feb 2024 11:06:54 +0100
Message-ID: <10421561.nUPlyArG6x@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <8ddbb34b5f6bf2414bdb03f9e7cd9da70e4e7228.1708395604.git.Sandor.yu@nxp.com>
References: <cover.1708395604.git.Sandor.yu@nxp.com> <8ddbb34b5f6bf2414bdb03f9e7cd9da70e4e7228.1708395604.git.Sandor.yu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,

thanks for the update.

Am Dienstag, 20. Februar 2024, 04:23:53 CET schrieb Sandor Yu:
> Add bindings for Freescale iMX8MQ DP and HDMI PHY.
>=20
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> v9->v14:
>  *No change.
>=20
>  .../bindings/phy/fsl,imx8mq-dp-hdmi-phy.yaml  | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mq-dp-h=
dmi-phy.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8mq-dp-hdmi-phy=
=2Eyaml b/Documentation/devicetree/bindings/phy/fsl,imx8mq-dp-hdmi-phy.yaml
> new file mode 100644
> index 0000000000000..917f113503dca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/fsl,imx8mq-dp-hdmi-phy.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/fsl,imx8mq-dp-hdmi-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence HDP-TX DP/HDMI PHY for Freescale i.MX8MQ SoC
> +
> +maintainers:
> +  - Sandor Yu <sandor.yu@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8mq-dp-phy
> +      - fsl,imx8mq-hdmi-phy

While reading cdns-mhdp8501-core.c I'm not so sure about this. There is
only a single PHY which can be configured for either DP or HDMI.
Using separate compatibles for that somehow bugs me.
Maybe the DT maintainers can add some input if this should be single
or double compatibles.

Thanks and best regards,
Alexander

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: PHY reference clock.
> +      - description: APB clock.
> +
> +  clock-names:
> +    items:
> +      - const: ref
> +      - const: apb
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mq-clock.h>
> +    #include <dt-bindings/phy/phy.h>
> +    dp_phy: phy@32c00000 {
> +        compatible =3D "fsl,imx8mq-dp-phy";
> +        reg =3D <0x32c00000 0x100000>;
> +        #phy-cells =3D <0>;
> +        clocks =3D <&hdmi_phy_27m>, <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
> +        clock-names =3D "ref", "apb";
> +    };
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



