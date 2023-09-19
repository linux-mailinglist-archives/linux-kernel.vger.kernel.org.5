Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD867A5A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjISGuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjISGuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:50:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351F2102;
        Mon, 18 Sep 2023 23:50:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555ABC433C8;
        Tue, 19 Sep 2023 06:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695106209;
        bh=8ykH08SrK+UpkZuDjx7bRdFpiZ7TnPEbkWI00FaluZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=im0Xoi6WEWwazRuw04wuAyA0CvBWHPW1FS0/wgigvaMN2M1md/B3e5pve/J56I4fY
         djYRDAs87CTPU8JFrS57YEMbH/VPkuI0WRyA5Cro/n1JJ+B7XxWoLjbhDfXaCKvP4g
         I/jYio0lUpZuVuUn2ujGlvPeo62noxUjgUzLau/AO0mC69kwl7TC2L9eVnWIP85yV+
         /D8+NnsHw1olcXgr/7UD+AQ0ZNvJvkjUn2zTfCDhmg3DxbEB5j07Kpvv4QHAwanTUX
         Vl9ioEfAuBuuJ/m99Hhq+ApBtyUMUYmhgrHtwBIpn+1Qph/9EyeeitHRhxfHHDWnye
         tjbqZvzXVwfzw==
Date:   Tue, 19 Sep 2023 08:50:07 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Frank Oltmanns <frank@oltmanns.dev>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
Subject: Re: [PATCH 03/13] clk: implement clk_hw_set_rate()
Message-ID: <kiwkbr5rj5uu3hkfy37obsj4mky5fwmbseyntp4pxoez4e3yh2@t6jdjs456eal>
References: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
 <20230918-imx8mp-dtsi-v1-3-1d008b3237c0@skidata.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zqcwscft3pf37wli"
Content-Disposition: inline
In-Reply-To: <20230918-imx8mp-dtsi-v1-3-1d008b3237c0@skidata.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zqcwscft3pf37wli
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 18, 2023 at 12:39:59AM +0200, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
>=20
> This function can be used to set the rate of a clock hardware from a
> driver, e.g. to adapt the rate to a clock change coming from the parent.
>=20
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
>  drivers/clk/clk.c            | 15 +++++++++++++++
>  include/linux/clk-provider.h |  1 +
>  2 files changed, 16 insertions(+)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c249f9791ae8..3e222802b712 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2462,6 +2462,21 @@ static int clk_core_set_rate_nolock(struct clk_cor=
e *core,
>  	return ret;
>  }
> =20
> +int clk_hw_set_rate(struct clk_hw *hw, unsigned long req_rate)
> +{
> +	/* A rate change is ongoing, so just target the required rate.
> +	 * Note: this does not work if one clock along the line has
> +	 * CLK_RECALC_NEW_RATES active, as this overwrites the new_rate again.
> +	 */
> +	if (hw->core->new_rate !=3D hw->core->rate) {
> +		hw->core->new_rate =3D req_rate;
> +		return 0;
> +	}
> +
> +	return clk_core_set_rate_nolock(hw->core, req_rate);
> +}
> +EXPORT_SYMBOL_GPL(clk_hw_set_rate);

So, we discussed it recently, and it's non-obvious to see how it would
work if you're in a set_rate change that modifies the tree and the new
call to clk_hw_set_rate modifies the tree too. Some explanation on how
it's handled, and some unit tests are required here imo.

Maxime

--zqcwscft3pf37wli
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZQlEngAKCRDj7w1vZxhR
xcVLAQD+MQh60tqys+LGfnNI4GRlneejAkt3iWt4M+vMGYpz0AD8DXzRKpxvqkP9
UXLjfEUbzUdabsTtfxM2QDCesIiLoA0=
=gkun
-----END PGP SIGNATURE-----

--zqcwscft3pf37wli--
