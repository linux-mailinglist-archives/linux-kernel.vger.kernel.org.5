Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2F77CEFE8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjJSGLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjJSGK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:10:58 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32701A7;
        Wed, 18 Oct 2023 23:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1697695256; x=1729231256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=730YXzJM/veidNKheQX/2/WJuZLbsKNszAfJOtRDQjk=;
  b=SQcFSLKzIHJEDOA7F/XPFFQheHAtN443vno+gcCPT2tC1ksc25Bw9kda
   vLOUsgouUKKxSgcyb4JMVk6Q6YOGIn1uiuqv9rSx3vMKLGaMRrWz+kAYD
   6ybPYi5yhFxKSe1EDXZa15/mZ5Uj2lxoJDfoG7A3ApoJEruEVXSz2x76G
   D7jA2uynUuhoWPAhy5QBhQ18RaLPUdGVBs6N15gpQ0oJ6LcN/+STYwdYd
   bNhUWP53yaYU0qYf3Sgx+vms9BB03B+vEdTy1T1lvNwJ1gXG+tjMctIUD
   xO8rWmDFc46aG3bW46mKPK3JtG91bZtPKVXaBnpIePbF0up/giFKAMju/
   Q==;
X-IronPort-AV: E=Sophos;i="6.03,236,1694728800"; 
   d="scan'208";a="33540707"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 19 Oct 2023 08:00:51 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id A3141280082;
        Thu, 19 Oct 2023 08:00:51 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     l.stach@pengutronix.de, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: Add NPU Node
Date:   Thu, 19 Oct 2023 08:00:53 +0200
Message-ID: <4261115.mogB4TqSGs@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20231019022300.1588041-1-aford173@gmail.com>
References: <20231019022300.1588041-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

thanks for the patch I tried a similar one.

Am Donnerstag, 19. Oktober 2023, 04:23:00 CEST schrieb Adam Ford:
> The NPU is based on the Vivante GC8000 and it enumerates as
>=20
>  etnaviv-gpu 38500000.npu: model: GC8000, revision: 8002
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mp.dtsi index
> c9a610ba4836..1ef8d17726ac 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -2012,6 +2012,25 @@ vpumix_blk_ctrl: blk-ctrl@38330000 {
>  			interconnect-names =3D "g1", "g2", "vc8000e";
>  		};
>=20
> +		npu: npu@38500000 {
> +			compatible =3D "vivante,gc";
> +			reg =3D <0x38500000 0x20000>;

Do you have some more information about the actual memory range? RM says 2M=
iB,=20
but NPU memory map lists up to 0x664.

> +			interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&clk IMX8MP_CLK_NPU_ROOT>,
> +				 <&clk IMX8MP_CLK_NPU_ROOT>,
> +				 <&clk IMX8MP_CLK_ML_AXI>,
> +				 <&clk IMX8MP_CLK_ML_AHB>;
> +			clock-names =3D "core", "shader", "bus", "reg";
> +			assigned-clocks =3D <&clk IMX8MP_CLK_ML_CORE>,
> +				  <&clk IMX8MP_CLK_ML_AXI>,
> +				  <&clk IMX8MP_CLK_ML_AHB>;
> +			assigned-clock-parents =3D <&clk=20
IMX8MP_SYS_PLL2_1000M>,
> +					 <&clk=20
IMX8MP_SYS_PLL1_800M>,
> +					 <&clk=20
IMX8MP_SYS_PLL1_800M>;
> +			assigned-clock-rates =3D <1000000000>,=20
<800000000>, <400000000>;

1GHz for ML_CLK_ROOT is only available in overdrive mode, 800MHz in nominal=
=20
mode. See datasheet IMX8MPIEC Rev 2.1. I don't think it's a good idea to=20
configure for overdrive mode by default.
Same goes for CLK_ML_AHB regarding 400 vs. 300 MHz.

Best regards,
Alexander

> +			power-domains =3D <&pgc_mlmix>;
> +		};
> +
>  		gic: interrupt-controller@38800000 {
>  			compatible =3D "arm,gic-v3";
>  			reg =3D <0x38800000 0x10000>,


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


