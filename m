Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752887B2C77
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 08:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjI2GkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 02:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjI2Gj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 02:39:56 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFF91A4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 23:39:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qm7A9-0001A2-2a; Fri, 29 Sep 2023 08:39:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qm7A7-009kiZ-1I; Fri, 29 Sep 2023 08:39:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qm7A6-005qWN-Nj; Fri, 29 Sep 2023 08:39:42 +0200
Date:   Fri, 29 Sep 2023 08:39:42 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        ilpo.jarvinen@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH 6/6] serial: imx: do not set RS485 enabled if it is not
 supported
Message-ID: <20230929063942.qukemr4o7l5vdmud@pengutronix.de>
References: <20230928221246.13689-1-LinoSanfilippo@gmx.de>
 <20230928221246.13689-7-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yu5mcexmqulaqvex"
Content-Disposition: inline
In-Reply-To: <20230928221246.13689-7-LinoSanfilippo@gmx.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yu5mcexmqulaqvex
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 12:12:46AM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>=20
> If the imx driver cannot support RS485 it sets the UARTS rs485_supported
> structure to NULL. But it still calls uart_get_rs485_mode() which may set
> the RS485_ENABLED flag.
> The flag however is evaluated by the serial core in uart_configure_port()

I wonder if this is the code location where this problem should be
addressed. Or alternatively don't let uart_get_rs485_mode() set
RS485_ENABLED (and other flags) if rs485_supported doesn't suggest that
this works?

> [...]
>=20
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>

I don't know how picky Greg is here, but formally you missed to add an
S-o-b line for the sender of this patch (i.e. you with your gmx
address).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yu5mcexmqulaqvex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUWcS0ACgkQj4D7WH0S
/k47wAgAniMRiA+dl7M7pf4WXvom8QfwhOuzi/ZJVgQr7Sj0ZAnIWPLIKiiaR0zP
pNXr8qWggxnpYHw16JMLUsxCsPc5ZIudcgKzKBGQCbwG4TZreZJI7UGiV0UXoHku
Owvhb7x76chV/Zp+pCusPHMZZiN1VlS90to/oc3FnAg4PH65vuyMvgxPAX3SSUhB
qzHII257rxUIfET19HOFHKFyNgA4QNgme1XTyBxKbOB8tb+qLiMAFOpe+5XG/5Qq
LxkfDfi1dV9UHpTY5JvlmwgODB04srgN2v5zsiZ+ghujB8T0RpR6aaTaMptqBCOy
+Gusp1Hp79etQUN4XmNNMWn9ozjWqw==
=Gvvs
-----END PGP SIGNATURE-----

--yu5mcexmqulaqvex--
