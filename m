Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65197C4B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344443AbjJKHAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343968AbjJKHAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:00:37 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82528F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:00:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qqTCm-00078l-LL; Wed, 11 Oct 2023 09:00:28 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qqTCl-000pxA-St; Wed, 11 Oct 2023 09:00:27 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 8E08E233ECB;
        Wed, 11 Oct 2023 07:00:27 +0000 (UTC)
Date:   Wed, 11 Oct 2023 09:00:27 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Don't use flexible array in struct
 spi_message definition
Message-ID: <20231011-lemon-exert-e4d695a5cb7e-mkl@pengutronix.de>
References: <20231010163100.89734-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b5bnlnopjnf3rcof"
Content-Disposition: inline
In-Reply-To: <20231010163100.89734-1-andriy.shevchenko@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b5bnlnopjnf3rcof
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.10.2023 19:31:00, Andy Shevchenko wrote:
> The struct spi_message can be embedded into another structures.
> With that the flexible array might be problematic as sparse
> complains about it, although there is no real issue in the code
> because when the message is embedded it doesn't use flexible array
> member. That memeber is a private to spi_message_alloc() API, so
> move it to that API in a form of an inherited data type.
>=20
> Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Fixes: 75e308ffc4f0 ("spi: Use struct_size() helper"))
> Closes: https://lore.kernel.org/r/20231009-onshore-underage-c58415adfd92-=
mkl@pengutronix.de
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

Thank you for the timely fix!

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--b5bnlnopjnf3rcof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUmSAgACgkQvlAcSiqK
BOh1ywgAo221eC4HxukbarLHWA+DUMI5iwhtJRNLq0M+zcHL3PLinUX+JS7ek1i2
yuaroughFdtzAzaRPJDtoOMjZ2+A4Umei8AXbR4An4CgMZcy6TTnemLaikdbB4XJ
HkPeIBh0mXwX9WxQHFr6TEVZgpmnbPo3Tha2ROWaJjwNXpjPA9Zi8TW8VzDEtLNR
5VvUII3vcDLwGPh6tm0aR/WMdgN80Qw79vXyLGgTgJ1YF4T7Rolm8gYJXDXnBJnJ
uB5VmU+hDmpQ5RvAEyCL6giObM6PDAxMwg5Cyjxoc5h7dNChkZ/Yf+Uv+JaFK+CP
DbwIvQ/8c9J5VB8JFf0YUo8E6qoeww==
=yh5C
-----END PGP SIGNATURE-----

--b5bnlnopjnf3rcof--
