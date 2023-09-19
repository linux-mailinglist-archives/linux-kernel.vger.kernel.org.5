Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E937A5A85
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjISHHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjISHHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:07:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DF2119;
        Tue, 19 Sep 2023 00:07:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9478DC433C8;
        Tue, 19 Sep 2023 07:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695107226;
        bh=xAVMwvYjBROv9OQIMFbARp+MSWiwtBbzjcXevpd/uFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=InoJHqfT1lVqdfuVmkP/5TY+fRMpQV1mBJKmM94Y434QDb7kA33bFRn+r3gDwqGUF
         aVBXrGbxaCtSlXv761k6PhYvhRGXUyaZ3p/Zj9jZxVHnSiJz2VR1x7+kD8aVe8s6bm
         m6FZXe5ZVZOWQZNYup5/UvmN0r9FpfdDMyPhetCH8/HKRg5bgc0FmGSxYXIrBqFf7f
         TQMIiWnkmqTgnk3uUAHJDY1eh6+vKBRJZ9c2bSX/bWi7n9tmtJF44banY5VzT64jc4
         JxB8rU6woVCmz/zZ6R2A/M24y5Ib5yK5yVIEpieGCvIKeSWqEyJWC5UF5/+ybLNYzE
         6iIMfVxionqJg==
Date:   Tue, 19 Sep 2023 09:07:03 +0200
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
Subject: Re: [PATCH 06/13] clk: keep track if a clock is explicitly configured
Message-ID: <pgnlrokdqqqclqvp4h2zk7iyq2jfncnvvwavovydovdmj3d2gf@kszpslmeswbr>
References: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
 <20230918-imx8mp-dtsi-v1-6-1d008b3237c0@skidata.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nz2do66haqaakwrg"
Content-Disposition: inline
In-Reply-To: <20230918-imx8mp-dtsi-v1-6-1d008b3237c0@skidata.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nz2do66haqaakwrg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 18, 2023 at 12:40:02AM +0200, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
>=20
> When we keep track if a clock has a given rate explicitly set by a
> consumer, we can identify unintentional clock rate changes in an easy
> way. This also helps during debugging, as one can see if a rate is set
> by accident or due to a consumer-related change.
>=20
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
>  drivers/clk/clk.c            | 25 +++++++++++++++++++++++++
>  include/linux/clk-provider.h |  1 +
>  2 files changed, 26 insertions(+)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 8f4f92547768..82c65ed432c5 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -70,6 +70,7 @@ struct clk_core {
>  	unsigned long		rate;
>  	unsigned long		req_rate;
>  	unsigned long		new_rate;
> +	unsigned long		set_rate;

This is pretty much what req_rate is supposed to be about. Why didn't it
work in your case?

Maxime

--nz2do66haqaakwrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZQlIlwAKCRDj7w1vZxhR
xX7CAQCJ88MP0IggxrZdwHzSEbK98JPULrdiQBePCHZXNxTCZwD/aTdF8wGwe2Ti
mSWGUcfCvtA5+45YPSnqsOb/vX59pgY=
=c2Lw
-----END PGP SIGNATURE-----

--nz2do66haqaakwrg--
