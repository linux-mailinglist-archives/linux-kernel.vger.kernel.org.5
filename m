Return-Path: <linux-kernel+bounces-153050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA888AC86A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBBE8280CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F63D13E3EF;
	Mon, 22 Apr 2024 09:05:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46089548EC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776719; cv=none; b=B3DB4FVChoTVm4QNaCSOEmd5SHJh+2O9FihG5KQp7rlw6WEMy7vyCMJ3TkPF80MH3dWOswqU7VJlUG5pRJglB9VByq88WS3kCgsWnhEJGP2s70FLSg5mlQ5qg4bMCB9rqRrVrZziVlWg69towBrFzVG58HP0uIyRq/Q92VSTKTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776719; c=relaxed/simple;
	bh=pNJQKBOLWs8rDZ/RhtvowRqOazYDQAhBrisc2ohw9Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVp3z2yvlUsWp2HXgJ23qLsazGEcVxszQiP2Cg+g8Z8pL+MinrMSxrV4oSBPVe3hCx3XwgQWNkxwJrQqVdDZTj24s1HLb8szZTreRzgr6Azsd8+U7Pg5kl/BhrRGaas7kPV6EBJCfYztNif7arupwOQLAa9ExL5DX0+ZjBgjmR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rypal-0000jv-Fo; Mon, 22 Apr 2024 11:04:03 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rypaj-00Desi-1p; Mon, 22 Apr 2024 11:04:01 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7FC1A2BCE42;
	Mon, 22 Apr 2024 09:04:00 +0000 (UTC)
Date: Mon, 22 Apr 2024 11:04:00 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, Linux Team <linux-imx@nxp.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, imx@lists.linux.dev, devicetree@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] net: stmicro: imx: set TX_CLK direction in RMII mode
Message-ID: <20240422-vigilant-chupacabra-of-lightning-f11220-mkl@pengutronix.de>
References: <20240422-v6-9-topic-imx93-eqos-rmii-v1-0-30151fca43d2@pengutronix.de>
 <20240422-v6-9-topic-imx93-eqos-rmii-v1-3-30151fca43d2@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="54trwo3z7e7ncsqb"
Content-Disposition: inline
In-Reply-To: <20240422-v6-9-topic-imx93-eqos-rmii-v1-3-30151fca43d2@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--54trwo3z7e7ncsqb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.04.2024 10:46:19, Steffen Trumtrar wrote:
> In case of RMII connection, the TX_CLK must be set to output direction.
> Parse the register and offset from the devicetree and set the direction
> of the TX_CLK when the property was provided.
>=20
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 27 +++++++++++++++++++=
++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/ne=
t/ethernet/stmicro/stmmac/dwmac-imx.c
> index 6b65420e11b5c..0fc81a626a664 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> @@ -37,6 +37,9 @@
>  #define MX93_GPR_ENET_QOS_INTF_SEL_RGMII	(0x1 << 1)
>  #define MX93_GPR_ENET_QOS_CLK_GEN_EN		(0x1 << 0)
> =20
> +#define MX93_GPR_ENET_QOS_TX_CLK_SEL_MASK	GENMASK(1, 1)
> +#define MX93_GPR_ENET_QOS_TX_CLK_SEL		(0x1 << 1)
> +
>  #define DMA_BUS_MODE			0x00001000
>  #define DMA_BUS_MODE_SFT_RESET		(0x1 << 0)
>  #define RMII_RESET_SPEED		(0x3 << 14)
> @@ -57,7 +60,9 @@ struct imx_priv_data {
>  	struct clk *clk_tx;
>  	struct clk *clk_mem;
>  	struct regmap *intf_regmap;
> +	struct regmap *enet_clk_regmap;
>  	u32 intf_reg_off;
> +	u32 enet_clk_reg_off;
>  	bool rmii_refclk_ext;
>  	void __iomem *base_addr;
> =20
> @@ -116,6 +121,18 @@ static int imx93_set_intf_mode(struct plat_stmmacene=
t_data *plat_dat)
>  		break;
>  	case PHY_INTERFACE_MODE_RMII:
>  		val =3D MX93_GPR_ENET_QOS_INTF_SEL_RMII;
> +
> +		/* According to NXP AN14149, the direction of the
> +		 * TX_CLK must be set to output in RMII mode.
> +		 */
> +		if (dwmac->enet_clk_regmap)
> +			regmap_update_bits(dwmac->enet_clk_regmap,
> +					   dwmac->enet_clk_reg_off,
> +					   MX93_GPR_ENET_QOS_TX_CLK_SEL_MASK,
> +					   MX93_GPR_ENET_QOS_TX_CLK_SEL);

Please add error handling.

> +		else
> +			dev_warn(dwmac->dev, "TX_CLK can't be set to output mode.\n");

As far as I understand the AN14149, setting the TX_CLK_SEL is mandatory
for PHY_INTERFACE_MODE_RMII. IMHO this should be error, shouldn't it?

> +
>  		break;
>  	case PHY_INTERFACE_MODE_RGMII:
>  	case PHY_INTERFACE_MODE_RGMII_ID:
> @@ -310,6 +327,16 @@ imx_dwmac_parse_dt(struct imx_priv_data *dwmac, stru=
ct device *dev)
>  			dev_err(dev, "Can't get intf mode reg offset (%d)\n", err);
>  			return err;
>  		}
> +
> +		dwmac->enet_clk_regmap =3D syscon_regmap_lookup_by_phandle(np, "enet_c=
lk_sel");
> +		if (IS_ERR(dwmac->enet_clk_regmap))
> +			return PTR_ERR(dwmac->enet_clk_regmap);
> +
> +		err =3D of_property_read_u32_index(np, "enet_clk_sel", 1, &dwmac->enet=
_clk_reg_off);
> +		if (err) {
> +			dev_err(dev, "Can't get enet clk sel reg offset (%d)\n", err);
> +			return err;
> +		}

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--54trwo3z7e7ncsqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmYmJ/0ACgkQKDiiPnot
vG+rRAf/TCKV4SbXHqD5urbJNkZpU+ifAdUP8XnGCC49D+SYNZCjA4f8QR3fZ6Nc
cfBefjXWzvGrGQPcDx0oEssnxQXSXLGYsm68ZDuHJXoZyEqwuPr2g4KNYmKidHT/
bcUXJGJi8joRtN6RsQ8O/tkjC5OtfP2ydBNaZT8Vw3xxwHtv2PT9x7O66lGWVYLW
0FRe2Jva6Gq3MYr/SpVi16FrUDIMjyQPGuOuqWergNCESFEwPwcqK6vjHNXj2h3c
MUDoLwWv/Iuz/fohieOBSTSZIbIp7kbDZr23Pbc89XRI7ts6XtguerNGw6tEmefQ
Uqe8uR3JnqblFK2pOEeelWhnp+tFKQ==
=WXS4
-----END PGP SIGNATURE-----

--54trwo3z7e7ncsqb--

