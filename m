Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AAE7D8A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 23:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjJZVPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 17:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjJZVPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 17:15:11 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC72C0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 14:15:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qw7h1-0002cZ-UM; Thu, 26 Oct 2023 23:15:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qw7h1-004Um3-7O; Thu, 26 Oct 2023 23:15:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qw7h0-006qM6-UL; Thu, 26 Oct 2023 23:15:02 +0200
Date:   Thu, 26 Oct 2023 23:15:02 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] pwm: Use device_get_match_data()
Message-ID: <20231026211502.vg43o3n4kk5niv2b@pengutronix.de>
References: <20231026195417.68090-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sxyp6wtlbhi5qs3p"
Content-Disposition: inline
In-Reply-To: <20231026195417.68090-2-robh@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sxyp6wtlbhi5qs3p
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rob,

On Thu, Oct 26, 2023 at 02:54:17PM -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
>=20
> As these drivers only do DT based matching, of_match_device() will never
> return NULL if we've gotten to probe(). Therefore, the NULL check and
> error returns can be dropped.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks!
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sxyp6wtlbhi5qs3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmU61tUACgkQj4D7WH0S
/k4ikwf+NPbrvyDAsDhLiVOMSQhEdou/BRS+IXhJ2nlRPwgD0fydclcttWkAq4mU
O5bTZuGkAoXTBUtqTgsHzhJWDffG0JFf+LEvjLTUAWXwh09Snzu3D4gOYUSgtuyQ
r6TbNyRn2w0uZZcV5+cBvMMONJWha5T68NS/vltGocQvz10rJ/vYsquHDy9TvFyl
qnjzNhy2I7pDiEJecUcJSnPR5Afp+Myfek4ridtSXErI75EtLkI9UsLX7cgxgkck
ZoCnlqrKPUQyh9/dK3aj19A9+MlLTXpIybY031vlTvqDymKaXvsA41cJN0gCM8H2
97lu4N3QVm9Wytk3/BdIXxmR4tWhgA==
=4Z6b
-----END PGP SIGNATURE-----

--sxyp6wtlbhi5qs3p--
