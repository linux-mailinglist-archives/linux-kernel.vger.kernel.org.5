Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB0D797D9B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 22:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbjIGUyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 16:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjIGUye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:54:34 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D261990
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 13:54:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qeM1F-0000v9-A8; Thu, 07 Sep 2023 22:54:29 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qeM1E-004jKK-HG; Thu, 07 Sep 2023 22:54:28 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qeM1D-00HHCn-Tg; Thu, 07 Sep 2023 22:54:27 +0200
Date:   Thu, 7 Sep 2023 22:54:27 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, vibhore@ti.com
Subject: Re: [PATCH] firmware: ti_sci: Mark driver as non removable
Message-ID: <20230907205427.tilwp6fk2q7hpfof@pengutronix.de>
References: <20230907171700.1922453-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eqnbnfzxrnfhtna3"
Content-Disposition: inline
In-Reply-To: <20230907171700.1922453-1-d-gole@ti.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eqnbnfzxrnfhtna3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Sep 07, 2023 at 10:47:00PM +0530, Dhruva Gole wrote:
> The TI-SCI message protocol provides a way to communicate between
> various compute processors with a central system controller entity. It
> provides the fundamental device management capability and clock control
> in the SOCs that it's used in.
>=20

Maybe add:

	The remove function failed to do all the necessary cleanup if
	there are registered users. Some things are freed however which
	likely results in an oops later on.

> Ensure that the driver isn't unbound by suppressing its bind and unbind
> sysfs attributes. As the driver is built-in there is no way to remove
> device once bound.
>=20
> We can also remove the ti_sci_remove call along with the
> ti_sci_debugfs_destroy as there are no callers for it any longer.
>=20
> Fixes: aa276781a64a ("firmware: Add basic support for TI System Control I=
nterface (TI-SCI) protocol")
> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>

While this isn't the most elegant solution, this is probably the most
feasible one.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

(with or without the suggested addition to the commit log above).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--eqnbnfzxrnfhtna3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmT6OIIACgkQj4D7WH0S
/k7uigf9Fy8T7gOB8S67eFUtrBxEwOgLrSnRVjGZhrTS3UeJlOQ7evLsrZc4kRcW
qwmGgBvPh3hoTo0gdMaamwUM8QGzxhv4LHHHkRUnv6jWyJ/u/x76oCqbWG48WmKt
ueOcYNhYhy9L/EU6hI/GbnUzJ+aG9T0SzhqNjIGpM6v3BmzpJXdDSMK66f3Wb8t5
+8dafVVNdWjVFot/2f9s4se4lS2aVgXPJUkMeWpa88BlW8ufzQW4p7SsIh7fwqut
lomS3u5bL6WWB3nVkV12urlhDzMIZtxmnkyFf4aYBtPgdvAmO0Tb02WMRjuWE0zN
RmYk2GC9MDS+lDWAbfQSSWVYT282Kg==
=b4Jr
-----END PGP SIGNATURE-----

--eqnbnfzxrnfhtna3--
