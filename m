Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A12A7B4E5C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 10:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbjJBI7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 04:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbjJBI7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:59:12 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0417AB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 01:59:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qnElb-0002eL-Bo; Mon, 02 Oct 2023 10:59:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qnEla-00ATwv-NR; Mon, 02 Oct 2023 10:59:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qnEla-007iCB-EI; Mon, 02 Oct 2023 10:59:02 +0200
Date:   Mon, 2 Oct 2023 10:59:02 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Young <sean@mess.org>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/2] media: pwm-ir-tx: trigger edges from hrtimer
 interrupt context
Message-ID: <20231002085902.63b6cpql5tgwdhbw@pengutronix.de>
References: <cover.1696156485.git.sean@mess.org>
 <7efe4229514001b835fa70d51973cd3306dc0b04.1696156485.git.sean@mess.org>
 <5982681d-4fb5-0271-fdc5-712d6c8512e3@gmail.com>
 <ZRp9RE2jOZdL0+1/@gofer.mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w4mugfksby7fun6n"
Content-Disposition: inline
In-Reply-To: <ZRp9RE2jOZdL0+1/@gofer.mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w4mugfksby7fun6n
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Mon, Oct 02, 2023 at 09:20:20AM +0100, Sean Young wrote:
> Having said that, the extra call to pwm_apply_state() may have benefits,
> see this comment in the pwm-sifive driver:
>=20
>  * - When changing both duty cycle and period, we cannot prevent in
>  *   software that the output might produce a period with mixed
>  *   settings (new period length and old duty cycle).

You don't gain anything here I think. Disabling a PWM might also result
in a constant active level. If you want to prevent this, your best bet
is to never disable the PWM.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--w4mugfksby7fun6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUahlUACgkQj4D7WH0S
/k536ggAiK7eJvApJAJkjCl2635YReF9JlrqDIQZAV84fZYHq7+/8mGmyQjcM+5X
uxdpbFs72wBJX6h9r/nb3Oj1Tf0oEV7oV556yaOQEZNbCjojLUj/0LeY+32a6XBV
Xepz1LpfjZi/eSQqSAH6YBqL1t2L0vyBgxh2QBc81BuiIvnAZmZoO+v4cpxNi5Yn
1NrULzUIFkeNQv1vupoAFZ4VYow9cnvjdIR/5XsDsops7O3UMSZ0eUtM+0Y6hoJx
qNhQaVRqcCY70oRJIckZyZJlMRRbnSkY4KOO0h/LCGydOFmSfzVI8zjL4DXWw49E
RaSNesAi4lHXV4x8/+NOpeBggIAEzw==
=FKci
-----END PGP SIGNATURE-----

--w4mugfksby7fun6n--
