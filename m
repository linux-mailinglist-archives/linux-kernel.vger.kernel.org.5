Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F557791DB5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjIDTfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjIDTfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:35:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9ED172E;
        Mon,  4 Sep 2023 12:34:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 87105CE0FBF;
        Mon,  4 Sep 2023 19:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58D5C433C9;
        Mon,  4 Sep 2023 19:34:45 +0000 (UTC)
Date:   Mon, 4 Sep 2023 15:34:43 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     lee@kernel.org, alexandre.torgue@foss.st.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] counter: stm32-timer-cnt: rename quadrature signal
Message-ID: <ZPYxUxW9xw0J5ogm@ishi>
References: <20230829134029.2402868-1-fabrice.gasnier@foss.st.com>
 <20230829134029.2402868-6-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NMsfRSzMtjBFjRBJ"
Content-Disposition: inline
In-Reply-To: <20230829134029.2402868-6-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NMsfRSzMtjBFjRBJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 03:40:26PM +0200, Fabrice Gasnier wrote:
> Rename "Channel 1 Quadrature B", as it corresponds to timer input ch2.
> I suspect it referred to the (unique) counter earlier, but the physical
> input really is CH2.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  drivers/counter/stm32-timer-cnt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-ti=
mer-cnt.c
> index 6206d2dc3d47..eae851f6db2c 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -283,7 +283,7 @@ static struct counter_signal stm32_signals[] =3D {
>  	},
>  	{
>  		.id =3D 1,
> -		.name =3D "Channel 1 Quadrature B"
> +		.name =3D "Channel 2 Quadrature B"
>  	}
>  };
> =20
> --=20
> 2.25.1
>=20

If these signals are going to be named after their channels, then I
prefer we just remove the "Quadrature A" and "Quadrature B" conventions
and leave the signals named "Channel 1" and "Channel 2" respectively.

William Breathitt Gray

--NMsfRSzMtjBFjRBJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZPYxUwAKCRC1SFbKvhIj
KwlZAQC5qqbW6yuzMVoOIa81HPFtxG55puiquwVLPEVVevubkgD/WDPQp5tCGI/7
SRz862UcpUqXwnje45wjxncgmbRXLgQ=
=+OS/
-----END PGP SIGNATURE-----

--NMsfRSzMtjBFjRBJ--
