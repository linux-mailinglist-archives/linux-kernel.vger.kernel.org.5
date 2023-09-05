Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF5E792CC3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbjIERxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238163AbjIERxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:53:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014211AF2C;
        Tue,  5 Sep 2023 10:39:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 608E3B8125E;
        Tue,  5 Sep 2023 16:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF28CC433C7;
        Tue,  5 Sep 2023 16:32:18 +0000 (UTC)
Date:   Tue, 5 Sep 2023 12:32:16 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Dharma Balasubiramani <dharma.b@microchip.com>
Cc:     kamel.bouhara@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        balamanikandan.gunasundar@microchip.com,
        hari.prasathge@microchip.com, nicolas.ferre@microchip.com
Subject: Re: [linux][PATCH] counter: microchip-tcb-capture: Fix the use of
 internal GCLK logic
Message-ID: <ZPdYEC25YMSA0GEq@ishi>
References: <20230905100835.315024-1-dharma.b@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IBs/xuK4vyQAAN/S"
Content-Disposition: inline
In-Reply-To: <20230905100835.315024-1-dharma.b@microchip.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IBs/xuK4vyQAAN/S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2023 at 03:38:35PM +0530, Dharma Balasubiramani wrote:
> As per the datasheet, the clock selection Bits 2:0 =E2=80=93 TCCLKS[2:0] =
should
> be set to 0 while using the internal GCLK (TIMER_CLOCK1).
>=20
> Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
>  drivers/counter/microchip-tcb-capture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/mi=
crochip-tcb-capture.c
> index e2d1dc6ca668..c7af13aca36c 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -98,7 +98,7 @@ static int mchp_tc_count_function_write(struct counter_=
device *counter,
>  		priv->qdec_mode =3D 0;
>  		/* Set highest rate based on whether soc has gclk or not */
>  		bmr &=3D ~(ATMEL_TC_QDEN | ATMEL_TC_POSEN);
> -		if (priv->tc_cfg->has_gclk)
> +		if (!priv->tc_cfg->has_gclk)
>  			cmr |=3D ATMEL_TC_TIMER_CLOCK2;
>  		else
>  			cmr |=3D ATMEL_TC_TIMER_CLOCK1;
> --=20
> 2.25.1

Applied to counter-fixes as commit df8fdd01c98b.

Thanks,

William Breathitt Gray

--IBs/xuK4vyQAAN/S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZPdYEAAKCRC1SFbKvhIj
K1MKAP9E6JRTEYYf67ux4TBjDQjMrZOTu5kghFg/hzzk6Q0BhwD/cdGiI//RMHXq
Q4EZXZ0BJFEs6FAi8zbtNOAf4XXS7QI=
=lPuS
-----END PGP SIGNATURE-----

--IBs/xuK4vyQAAN/S--
