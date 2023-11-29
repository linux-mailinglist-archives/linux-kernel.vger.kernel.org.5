Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE117FD3FC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjK2KUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjK2KUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:20:05 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441B7AF;
        Wed, 29 Nov 2023 02:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1701253210; x=1732789210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KZkH8bl3BtculFLewEii2JTZkTpl2Gc15g5xYx6zHoQ=;
  b=Z9DqCNf/6k10xKzhLFM1lpDEiya4zzh8+W7mjBUN5+bmbc0Zq4d40gIG
   +9AZtgejVTDpkFAbs6HbDZS7wxnL/6+rxK0EQyNVguWPprczA2Jn2lML1
   9ILvU1xY6SBufQXG2j1e6+QRZ8i+jgD5ux33938sCK/UcRvibfuDERPlf
   vIFo/7lkM8Wt4dY2Y8MKwVXiIB+fP4T2IT1EGJLEwfbWZHxfA4n8okEqD
   eYOgMZWo3+dFq1ElOiMjZ/WhgtDr6H5813rZvK1UdemAxpWU76JDpyqMP
   AAK0tmTh3zzjzGE24Thf7O5R/Q8burtiyztVx25+eE2A93ksCTIjxj80/
   A==;
X-IronPort-AV: E=Sophos;i="6.04,235,1695679200"; 
   d="scan'208";a="34234253"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 29 Nov 2023 11:20:08 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 240C3280075;
        Wed, 29 Nov 2023 11:20:08 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Paul Elder <paul.elder@ideasonboard.com>
Cc:     kieran.bingham@ideasonboard.com, tomi.valkeinen@ideasonboard.com,
        umang.jain@ideasonboard.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mp: Add overlays for ISP instances
Date:   Wed, 29 Nov 2023 11:20:07 +0100
Message-ID: <7122934.GXAFRqVoOG@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20231129093113.255161-3-paul.elder@ideasonboard.com>
References: <20231129093113.255161-1-paul.elder@ideasonboard.com> <20231129093113.255161-3-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

thanks for the patch.

Am Mittwoch, 29. November 2023, 10:31:13 CET schrieb Paul Elder:
> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>=20
> Add two overlay to enable each ISP instance. The ISP is wired directly
> to the CSIS for now, bypassing the ISI completely.

I'm not sure if this is worth adding in a separate overlay.

> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |  2 ++
>  .../arm64/boot/dts/freescale/imx8mp-isp1.dtso | 36 +++++++++++++++++++
>  .../arm64/boot/dts/freescale/imx8mp-isp2.dtso | 36 +++++++++++++++++++
>  3 files changed, 74 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-isp1.dtso
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-isp2.dtso
>=20
> diff --git a/arch/arm64/boot/dts/freescale/Makefile
> b/arch/arm64/boot/dts/freescale/Makefile index 300049037eb0..f97dfac11189
> 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -113,6 +113,8 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-dhcom-pdk2.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-dhcom-pdk3.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-icore-mx8mp-edimm2.2.dtb
> +dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-isp1.dtbo
> +dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-isp2.dtbo
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-msc-sm2s-ep1.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-phyboard-pollux-rdk.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-tqma8mpql-mba8mpxl.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-isp1.dtso
> b/arch/arm64/boot/dts/freescale/imx8mp-isp1.dtso new file mode 100644
> index 000000000000..cf394ed224ab
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-isp1.dtso
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2022 Ideas on Board Oy
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/media/video-interfaces.h>
> +
> +&isi_0 {
> +	status =3D "disabled";

ISI is disabled by default. What is your intention here?

> +
> +	ports {
> +		port@0 {
> +			/delete-node/ endpoint;

This doesn't work in overlays. See [1]. Otherwise the OF graph connections=
=20
look fine to me. I'm using the same in my local overlay.

Best regards,
Alexander

[1] https://lore.kernel.org/all/
CAMuHMdWu4KZbBkvEofUV2wuA1g2S=3DXHHM3RUN1cNrcZBkhsPZA@mail.gmail.com/

> +		};
> +	};
> +};
> +
> +&isp_0 {
> +	status =3D "okay";
> +
> +	ports {
> +		port@1 {
> +			isp0_in: endpoint {
> +				bus-type =3D <MEDIA_BUS_TYPE_PARALLEL>;
> +				remote-endpoint =3D <&mipi_csi_0_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&mipi_csi_0_out {
> +	remote-endpoint =3D <&isp0_in>;
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-isp2.dtso
> b/arch/arm64/boot/dts/freescale/imx8mp-isp2.dtso new file mode 100644
> index 000000000000..14e2e7b2617f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-isp2.dtso
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2022 Ideas on Board Oy
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/media/video-interfaces.h>
> +
> +&isi_0 {
> +	status =3D "disabled";
> +
> +	ports {
> +		port@1 {
> +			/delete-node/ endpoint;
> +		};
> +	};
> +};
> +
> +&isp_1 {
> +	status =3D "okay";
> +
> +	ports {
> +		port@1 {
> +			isp1_in: endpoint {
> +				bus-type =3D <MEDIA_BUS_TYPE_PARALLEL>;
> +				remote-endpoint =3D <&mipi_csi_1_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&mipi_csi_1_out {
> +	remote-endpoint =3D <&isp1_in>;
> +};


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


