Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD78676BBA0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjHARtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjHARtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:49:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06301BF3;
        Tue,  1 Aug 2023 10:49:07 -0700 (PDT)
Received: from mercury (dyndsl-091-248-215-079.ewe-ip-backbone.de [91.248.215.79])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5F4FE6606EEE;
        Tue,  1 Aug 2023 18:49:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690912146;
        bh=GDK5pX/yblFZu71XxyePOBifPxfmQKvLruQ1wqImdwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZjxVO2/4kbwAGCNx1skUyJAgr9x4OQgvmAme17pVZfSZOnM84vD9vtgQX/eAlwsnc
         pA+8YGrCu8FoxqDFN/gwSmws77sO9m/RLJHG3FHDxK4FH193edaCZRfdlprgRZe1Fh
         vfWYr9KkXrHItcPS+GdZ6crH4tbce/aVY2PQXfSYarQcUv58dmWV/+5IyGjEqSk9Pu
         xG/S+DODBzGIBvH9PKCbTN2raPH++mW5gll0oRN0Ty34SNyyrCVdd9aqwJFnSuRzdO
         xW3nHaqvr/pR8J4NZodgM5i2lYoyri2wG/zt/ndEVFw3n8TzA9oVfBqVvs05SBZDap
         CZhwrNMfCbOeg==
Received: by mercury (Postfix, from userid 1000)
        id BD97D10660D0; Tue,  1 Aug 2023 19:49:03 +0200 (CEST)
Date:   Tue, 1 Aug 2023 19:49:03 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, heiko@sntech.de,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com
Subject: Re: [PATCH v2 3/3] clk: rockchip: rk3588: Adjust the GATE_LINK
 parameter
Message-ID: <20230801174903.hzg3yeugppbxgp7f@mercury.elektranox.org>
References: <20230801074357.10770-1-zhangqing@rock-chips.com>
 <20230801074357.10770-4-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="erhvsdivwuvsfixh"
Content-Disposition: inline
In-Reply-To: <20230801074357.10770-4-zhangqing@rock-chips.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--erhvsdivwuvsfixh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 01, 2023 at 03:43:57PM +0800, Elaine Zhang wrote:
> Using Id instead of name, if use name needs to use __clk_lookup().
> But __clk_lookup() is not exported and is not friendly for GKI.
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---

The patch description should mention, that it's also adding the
missing PCLK_VO0GRF and PCLK_VO1GRF entries. Otherwise:

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/clk/rockchip/clk-rk3588.c | 110 ++++++++++++++++--------------
>  1 file changed, 59 insertions(+), 51 deletions(-)
>=20
> diff --git a/drivers/clk/rockchip/clk-rk3588.c b/drivers/clk/rockchip/clk=
-rk3588.c
> index 6994165e0395..4135e96f44ee 100644
> --- a/drivers/clk/rockchip/clk-rk3588.c
> +++ b/drivers/clk/rockchip/clk-rk3588.c
> @@ -12,28 +12,6 @@
>  #include <dt-bindings/clock/rockchip,rk3588-cru.h>
>  #include "clk.h"
> =20
> -/*
> - * Recent Rockchip SoCs have a new hardware block called Native Interface
> - * Unit (NIU), which gates clocks to devices behind them. These effectiv=
ely
> - * need two parent clocks.
> - *
> - * Downstream enables the linked clock via runtime PM whenever the gate =
is
> - * enabled. This implementation uses separate clock nodes for each of the
> - * linked gate clocks, which leaks parts of the clock tree into DT.
> - *
> - * The GATE_LINK macro instead takes the second parent via 'linkname', b=
ut
> - * ignores the information. Once the clock framework is ready to handle =
it, the
> - * information should be passed on here. But since these clocks are requ=
ired to
> - * access multiple relevant IP blocks, such as PCIe or USB, we mark all =
linked
> - * clocks critical until a better solution is available. This will waste=
 some
> - * power, but avoids leaking implementation details into DT or hanging t=
he
> - * system.
> - */
> -#define GATE_LINK(_id, cname, pname, linkname, f, o, b, gf) \
> -	GATE(_id, cname, pname, f, o, b, gf)
> -#define RK3588_LINKED_CLK		CLK_IS_CRITICAL
> -
> -
>  #define RK3588_GRF_SOC_STATUS0		0x600
>  #define RK3588_PHYREF_ALT_GATE		0xc38
> =20
> @@ -1456,7 +1434,7 @@ static struct rockchip_clk_branch rk3588_clk_branch=
es[] __initdata =3D {
>  	COMPOSITE_NODIV(HCLK_NVM_ROOT,  "hclk_nvm_root", mux_200m_100m_50m_24m_=
p, 0,
>  			RK3588_CLKSEL_CON(77), 0, 2, MFLAGS,
>  			RK3588_CLKGATE_CON(31), 0, GFLAGS),
> -	COMPOSITE(ACLK_NVM_ROOT, "aclk_nvm_root", gpll_cpll_p, RK3588_LINKED_CL=
K,
> +	COMPOSITE(ACLK_NVM_ROOT, "aclk_nvm_root", gpll_cpll_p, 0,
>  			RK3588_CLKSEL_CON(77), 7, 1, MFLAGS, 2, 5, DFLAGS,
>  			RK3588_CLKGATE_CON(31), 1, GFLAGS),
>  	GATE(ACLK_EMMC, "aclk_emmc", "aclk_nvm_root", 0,
> @@ -1685,13 +1663,13 @@ static struct rockchip_clk_branch rk3588_clk_bran=
ches[] __initdata =3D {
>  			RK3588_CLKGATE_CON(42), 9, GFLAGS),
> =20
>  	/* vdpu */
> -	COMPOSITE(ACLK_VDPU_ROOT, "aclk_vdpu_root", gpll_cpll_aupll_p, RK3588_L=
INKED_CLK,
> +	COMPOSITE(ACLK_VDPU_ROOT, "aclk_vdpu_root", gpll_cpll_aupll_p, 0,
>  			RK3588_CLKSEL_CON(98), 5, 2, MFLAGS, 0, 5, DFLAGS,
>  			RK3588_CLKGATE_CON(44), 0, GFLAGS),
>  	COMPOSITE_NODIV(ACLK_VDPU_LOW_ROOT, "aclk_vdpu_low_root", mux_400m_200m=
_100m_24m_p, 0,
>  			RK3588_CLKSEL_CON(98), 7, 2, MFLAGS,
>  			RK3588_CLKGATE_CON(44), 1, GFLAGS),
> -	COMPOSITE_NODIV(HCLK_VDPU_ROOT, "hclk_vdpu_root", mux_200m_100m_50m_24m=
_p, RK3588_LINKED_CLK,
> +	COMPOSITE_NODIV(HCLK_VDPU_ROOT, "hclk_vdpu_root", mux_200m_100m_50m_24m=
_p, 0,
>  			RK3588_CLKSEL_CON(98), 9, 2, MFLAGS,
>  			RK3588_CLKGATE_CON(44), 2, GFLAGS),
>  	COMPOSITE(ACLK_JPEG_DECODER_ROOT, "aclk_jpeg_decoder_root", gpll_cpll_a=
upll_spll_p, 0,
> @@ -1742,9 +1720,9 @@ static struct rockchip_clk_branch rk3588_clk_branch=
es[] __initdata =3D {
>  	COMPOSITE(ACLK_RKVENC0_ROOT, "aclk_rkvenc0_root", gpll_cpll_npll_p, 0,
>  			RK3588_CLKSEL_CON(102), 7, 2, MFLAGS, 2, 5, DFLAGS,
>  			RK3588_CLKGATE_CON(47), 1, GFLAGS),
> -	GATE(HCLK_RKVENC0, "hclk_rkvenc0", "hclk_rkvenc0_root", RK3588_LINKED_C=
LK,
> +	GATE(HCLK_RKVENC0, "hclk_rkvenc0", "hclk_rkvenc0_root", 0,
>  			RK3588_CLKGATE_CON(47), 4, GFLAGS),
> -	GATE(ACLK_RKVENC0, "aclk_rkvenc0", "aclk_rkvenc0_root", RK3588_LINKED_C=
LK,
> +	GATE(ACLK_RKVENC0, "aclk_rkvenc0", "aclk_rkvenc0_root", 0,
>  			RK3588_CLKGATE_CON(47), 5, GFLAGS),
>  	COMPOSITE(CLK_RKVENC0_CORE, "clk_rkvenc0_core", gpll_cpll_aupll_npll_p,=
 0,
>  			RK3588_CLKSEL_CON(102), 14, 2, MFLAGS, 9, 5, DFLAGS,
> @@ -1754,10 +1732,10 @@ static struct rockchip_clk_branch rk3588_clk_bran=
ches[] __initdata =3D {
>  			RK3588_CLKGATE_CON(48), 6, GFLAGS),
> =20
>  	/* vi */
> -	COMPOSITE(ACLK_VI_ROOT, "aclk_vi_root", gpll_cpll_npll_aupll_spll_p, RK=
3588_LINKED_CLK,
> +	COMPOSITE(ACLK_VI_ROOT, "aclk_vi_root", gpll_cpll_npll_aupll_spll_p, 0,
>  			RK3588_CLKSEL_CON(106), 5, 3, MFLAGS, 0, 5, DFLAGS,
>  			RK3588_CLKGATE_CON(49), 0, GFLAGS),
> -	COMPOSITE_NODIV(HCLK_VI_ROOT, "hclk_vi_root", mux_200m_100m_50m_24m_p, =
RK3588_LINKED_CLK,
> +	COMPOSITE_NODIV(HCLK_VI_ROOT, "hclk_vi_root", mux_200m_100m_50m_24m_p, =
0,
>  			RK3588_CLKSEL_CON(106), 8, 2, MFLAGS,
>  			RK3588_CLKGATE_CON(49), 1, GFLAGS),
>  	COMPOSITE_NODIV(PCLK_VI_ROOT, "pclk_vi_root", mux_100m_50m_24m_p, 0,
> @@ -1929,10 +1907,10 @@ static struct rockchip_clk_branch rk3588_clk_bran=
ches[] __initdata =3D {
>  	COMPOSITE(ACLK_VOP_ROOT, "aclk_vop_root", gpll_cpll_dmyaupll_npll_spll_=
p, 0,
>  			RK3588_CLKSEL_CON(110), 5, 3, MFLAGS, 0, 5, DFLAGS,
>  			RK3588_CLKGATE_CON(52), 0, GFLAGS),
> -	COMPOSITE_NODIV(ACLK_VOP_LOW_ROOT, "aclk_vop_low_root", mux_400m_200m_1=
00m_24m_p, RK3588_LINKED_CLK,
> +	COMPOSITE_NODIV(ACLK_VOP_LOW_ROOT, "aclk_vop_low_root", mux_400m_200m_1=
00m_24m_p, 0,
>  			RK3588_CLKSEL_CON(110), 8, 2, MFLAGS,
>  			RK3588_CLKGATE_CON(52), 1, GFLAGS),
> -	COMPOSITE_NODIV(HCLK_VOP_ROOT, "hclk_vop_root", mux_200m_100m_50m_24m_p=
, RK3588_LINKED_CLK,
> +	COMPOSITE_NODIV(HCLK_VOP_ROOT, "hclk_vop_root", mux_200m_100m_50m_24m_p=
, 0,
>  			RK3588_CLKSEL_CON(110), 10, 2, MFLAGS,
>  			RK3588_CLKGATE_CON(52), 2, GFLAGS),
>  	COMPOSITE_NODIV(PCLK_VOP_ROOT, "pclk_vop_root", mux_100m_50m_24m_p, 0,
> @@ -2433,26 +2411,56 @@ static struct rockchip_clk_branch rk3588_clk_bran=
ches[] __initdata =3D {
>  	GATE(ACLK_AV1, "aclk_av1", "aclk_av1_pre", 0,
>  			RK3588_CLKGATE_CON(68), 2, GFLAGS),
> =20
> -	GATE_LINK(ACLK_ISP1_PRE, "aclk_isp1_pre", "aclk_isp1_root", "aclk_vi_ro=
ot", 0, RK3588_CLKGATE_CON(26), 6, GFLAGS),
> -	GATE_LINK(HCLK_ISP1_PRE, "hclk_isp1_pre", "hclk_isp1_root", "hclk_vi_ro=
ot", 0, RK3588_CLKGATE_CON(26), 8, GFLAGS),
> -	GATE_LINK(HCLK_NVM, "hclk_nvm", "hclk_nvm_root", "aclk_nvm_root", RK358=
8_LINKED_CLK, RK3588_CLKGATE_CON(31), 2, GFLAGS),
> -	GATE_LINK(ACLK_USB, "aclk_usb", "aclk_usb_root", "aclk_vo1usb_top_root"=
, 0, RK3588_CLKGATE_CON(42), 2, GFLAGS),
> -	GATE_LINK(HCLK_USB, "hclk_usb", "hclk_usb_root", "hclk_vo1usb_top_root"=
, 0, RK3588_CLKGATE_CON(42), 3, GFLAGS),
> -	GATE_LINK(ACLK_JPEG_DECODER_PRE, "aclk_jpeg_decoder_pre", "aclk_jpeg_de=
coder_root", "aclk_vdpu_root", 0, RK3588_CLKGATE_CON(44), 7, GFLAGS),
> -	GATE_LINK(ACLK_VDPU_LOW_PRE, "aclk_vdpu_low_pre", "aclk_vdpu_low_root",=
 "aclk_vdpu_root", 0, RK3588_CLKGATE_CON(44), 5, GFLAGS),
> -	GATE_LINK(ACLK_RKVENC1_PRE, "aclk_rkvenc1_pre", "aclk_rkvenc1_root", "a=
clk_rkvenc0", 0, RK3588_CLKGATE_CON(48), 3, GFLAGS),
> -	GATE_LINK(HCLK_RKVENC1_PRE, "hclk_rkvenc1_pre", "hclk_rkvenc1_root", "h=
clk_rkvenc0", 0, RK3588_CLKGATE_CON(48), 2, GFLAGS),
> -	GATE_LINK(HCLK_RKVDEC0_PRE, "hclk_rkvdec0_pre", "hclk_rkvdec0_root", "h=
clk_vdpu_root", 0, RK3588_CLKGATE_CON(40), 5, GFLAGS),
> -	GATE_LINK(ACLK_RKVDEC0_PRE, "aclk_rkvdec0_pre", "aclk_rkvdec0_root", "a=
clk_vdpu_root", 0, RK3588_CLKGATE_CON(40), 6, GFLAGS),
> -	GATE_LINK(HCLK_RKVDEC1_PRE, "hclk_rkvdec1_pre", "hclk_rkvdec1_root", "h=
clk_vdpu_root", 0, RK3588_CLKGATE_CON(41), 4, GFLAGS),
> -	GATE_LINK(ACLK_RKVDEC1_PRE, "aclk_rkvdec1_pre", "aclk_rkvdec1_root", "a=
clk_vdpu_root", 0, RK3588_CLKGATE_CON(41), 5, GFLAGS),
> -	GATE_LINK(ACLK_HDCP0_PRE, "aclk_hdcp0_pre", "aclk_vo0_root", "aclk_vop_=
low_root", 0, RK3588_CLKGATE_CON(55), 9, GFLAGS),
> -	GATE_LINK(HCLK_VO0, "hclk_vo0", "hclk_vo0_root", "hclk_vop_root", 0, RK=
3588_CLKGATE_CON(55), 5, GFLAGS),
> -	GATE_LINK(ACLK_HDCP1_PRE, "aclk_hdcp1_pre", "aclk_hdcp1_root", "aclk_vo=
1usb_top_root", 0, RK3588_CLKGATE_CON(59), 6, GFLAGS),
> -	GATE_LINK(HCLK_VO1, "hclk_vo1", "hclk_vo1_root", "hclk_vo1usb_top_root"=
, 0, RK3588_CLKGATE_CON(59), 9, GFLAGS),
> -	GATE_LINK(ACLK_AV1_PRE, "aclk_av1_pre", "aclk_av1_root", "aclk_vdpu_roo=
t", 0, RK3588_CLKGATE_CON(68), 1, GFLAGS),
> -	GATE_LINK(PCLK_AV1_PRE, "pclk_av1_pre", "pclk_av1_root", "hclk_vdpu_roo=
t", 0, RK3588_CLKGATE_CON(68), 4, GFLAGS),
> -	GATE_LINK(HCLK_SDIO_PRE, "hclk_sdio_pre", "hclk_sdio_root", "hclk_nvm",=
 0, RK3588_CLKGATE_CON(75), 1, GFLAGS),
> +	/*
> +	 * Recent Rockchip SoCs have a new hardware block called Native Interfa=
ce
> +	 * Unit (NIU), which gates clocks to devices behind them. These effecti=
vely
> +	 * need two parent clocks.
> +	 */
> +	GATE_LINK(ACLK_ISP1_PRE, "aclk_isp1_pre", "aclk_isp1_root", ACLK_VI_ROO=
T, 0,
> +			RK3588_CLKGATE_CON(26), 6, GFLAGS),
> +	GATE_LINK(HCLK_ISP1_PRE, "hclk_isp1_pre", "hclk_isp1_root", HCLK_VI_ROO=
T, 0,
> +			RK3588_CLKGATE_CON(26), 8, GFLAGS),
> +	GATE_LINK(HCLK_NVM, "hclk_nvm", "hclk_nvm_root", ACLK_NVM_ROOT, 0,
> +			RK3588_CLKGATE_CON(31), 2, GFLAGS),
> +	GATE_LINK(ACLK_USB, "aclk_usb", "aclk_usb_root", ACLK_VO1USB_TOP_ROOT, =
0,
> +			RK3588_CLKGATE_CON(42), 2, GFLAGS),
> +	GATE_LINK(HCLK_USB, "hclk_usb", "hclk_usb_root", HCLK_VO1USB_TOP_ROOT, =
0,
> +			RK3588_CLKGATE_CON(42), 3, GFLAGS),
> +	GATE_LINK(ACLK_JPEG_DECODER_PRE, "aclk_jpeg_decoder_pre", "aclk_jpeg_de=
coder_root",
> +			ACLK_VDPU_ROOT, 0,
> +			RK3588_CLKGATE_CON(44), 7, GFLAGS),
> +	GATE_LINK(ACLK_VDPU_LOW_PRE, "aclk_vdpu_low_pre", "aclk_vdpu_low_root",=
 ACLK_VDPU_ROOT, 0,
> +			RK3588_CLKGATE_CON(44), 5, GFLAGS),
> +	GATE_LINK(ACLK_RKVENC1_PRE, "aclk_rkvenc1_pre", "aclk_rkvenc1_root", AC=
LK_RKVENC0, 0,
> +			RK3588_CLKGATE_CON(48), 3, GFLAGS),
> +	GATE_LINK(HCLK_RKVENC1_PRE, "hclk_rkvenc1_pre", "hclk_rkvenc1_root", HC=
LK_RKVENC0, 0,
> +			RK3588_CLKGATE_CON(48), 2, GFLAGS),
> +	GATE_LINK(HCLK_RKVDEC0_PRE, "hclk_rkvdec0_pre", "hclk_rkvdec0_root", HC=
LK_VDPU_ROOT, 0,
> +			RK3588_CLKGATE_CON(40), 5, GFLAGS),
> +	GATE_LINK(ACLK_RKVDEC0_PRE, "aclk_rkvdec0_pre", "aclk_rkvdec0_root", AC=
LK_VDPU_ROOT, 0,
> +			RK3588_CLKGATE_CON(40), 6, GFLAGS),
> +	GATE_LINK(HCLK_RKVDEC1_PRE, "hclk_rkvdec1_pre", "hclk_rkvdec1_root", HC=
LK_VDPU_ROOT, 0,
> +			RK3588_CLKGATE_CON(41), 4, GFLAGS),
> +	GATE_LINK(ACLK_RKVDEC1_PRE, "aclk_rkvdec1_pre", "aclk_rkvdec1_root", AC=
LK_VDPU_ROOT, 0,
> +			RK3588_CLKGATE_CON(41), 5, GFLAGS),
> +	GATE_LINK(ACLK_HDCP0_PRE, "aclk_hdcp0_pre", "aclk_vo0_root", ACLK_VOP_L=
OW_ROOT, 0,
> +			RK3588_CLKGATE_CON(55), 9, GFLAGS),
> +	GATE_LINK(HCLK_VO0, "hclk_vo0", "hclk_vo0_root", HCLK_VOP_ROOT, 0,
> +			RK3588_CLKGATE_CON(55), 5, GFLAGS),
> +	GATE_LINK(ACLK_HDCP1_PRE, "aclk_hdcp1_pre", "aclk_hdcp1_root", ACLK_VO1=
USB_TOP_ROOT, 0,
> +			RK3588_CLKGATE_CON(59), 6, GFLAGS),
> +	GATE_LINK(HCLK_VO1, "hclk_vo1", "hclk_vo1_root", HCLK_VO1USB_TOP_ROOT, =
0,
> +			RK3588_CLKGATE_CON(59), 9, GFLAGS),
> +	GATE_LINK(ACLK_AV1_PRE, "aclk_av1_pre", "aclk_av1_root", ACLK_VDPU_ROOT=
, 0,
> +			RK3588_CLKGATE_CON(68), 1, GFLAGS),
> +	GATE_LINK(PCLK_AV1_PRE, "pclk_av1_pre", "pclk_av1_root", HCLK_VDPU_ROOT=
, 0,
> +			RK3588_CLKGATE_CON(68), 4, GFLAGS),
> +	GATE_LINK(HCLK_SDIO_PRE, "hclk_sdio_pre", "hclk_sdio_root", HCLK_NVM, 0,
> +			RK3588_CLKGATE_CON(75), 1, GFLAGS),
> +	GATE_LINK(PCLK_VO0GRF, "pclk_vo0grf", "pclk_vo0_root", HCLK_VO0, CLK_IG=
NORE_UNUSED,
> +			RK3588_CLKGATE_CON(55), 10, GFLAGS),
> +	GATE_LINK(PCLK_VO1GRF, "pclk_vo1grf", "pclk_vo1_root", HCLK_VO1, CLK_IG=
NORE_UNUSED,
> +			RK3588_CLKGATE_CON(59), 12, GFLAGS),
>  };
> =20
>  static void __init rk3588_clk_init(struct device_node *np)
> --=20
> 2.17.1
>=20

--erhvsdivwuvsfixh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmTJRY8ACgkQ2O7X88g7
+pq9FRAAl5wMvv6dCgCs/hClkkdRlBrZkULa6+AHp8f1BmpSWI38qH+zgg/av3R3
qb1FbXQHm8r2krDqc69RyPmFtQzcmyAWF2mazCFMABrKTz5iUpOQDJypjQ9P+GjI
RJUEFBntCPdLu3KSh5exUuJmvJA+jlFBgskNhHSUj5VerWLZ0mCX7QTIkl0ztBIx
gwMTopY7lgvjvf2MpsDsBkfdVcSqFGh5lDr0JOeWBTG6sNS+NpqX/Pb8L1qNC0uG
TQg2HwhAzU+aPY1E5RHMRaOCJgNF6LBRZTl81lNCPvddk57rFqsbwoUZEDW2Umv4
KlaXHHJsSiPhzsz06QiLfO8wkhQKjUxgTBUv2PYLFtV0X7iMGiegsiza80rNVKxr
gyDKo6YZxqNVpUooAyFdpk6lrQlJVRxB8X9ilOqVjJdikMCUVQqXnN2cuPhO+7tc
ZT7ayBxzeME5Bm+GOIMUVLPZQPQnYCuHB0RSBSIf5rIr5DPMbepuaXLpBiGQVFBw
8aZYSIbhtzmLGEvsGcZPQ1de5fwyD2rutPoD9clstxZifuYngedN1Sdf3l2zouA1
XLh//aX+RigaQp9Uxl7JeU8UAi7ONeG1Al8hNPTDYYPbRVrX81KImp6vuep6A3hQ
WsWY8xcknM800u+qw98B+mFNGz0HQoY4DjvfLxXK1R2cxtS0iY0=
=H7vs
-----END PGP SIGNATURE-----

--erhvsdivwuvsfixh--
