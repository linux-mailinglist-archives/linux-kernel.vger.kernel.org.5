Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B89A79BA5A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349176AbjIKVcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244243AbjIKTsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:48:04 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5B11A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:48:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qfmt0-0001wQ-C2; Mon, 11 Sep 2023 21:47:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qfmsy-005cTP-2P; Mon, 11 Sep 2023 21:47:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qfmsx-000lo0-DE; Mon, 11 Sep 2023 21:47:51 +0200
Date:   Mon, 11 Sep 2023 21:47:51 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com
Subject: Re: [PATCH v9 4/6] pwm: dwc: use clock rate in hz to avoid rounding
 issues
Message-ID: <20230911194751.mohdwipo74ccgail@pengutronix.de>
References: <20230907161242.67190-1-ben.dooks@codethink.co.uk>
 <20230907161242.67190-5-ben.dooks@codethink.co.uk>
 <20230907213419.aqzwoppznj5tx7w6@pengutronix.de>
 <d45c3d25-13ca-474f-a3e3-c295d3cea866@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uwxa5sotju3k4kg3"
Content-Disposition: inline
In-Reply-To: <d45c3d25-13ca-474f-a3e3-c295d3cea866@codethink.co.uk>
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


--uwxa5sotju3k4kg3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ben,

On Mon, Sep 11, 2023 at 08:33:02AM +0100, Ben Dooks wrote:
> On 07/09/2023 22:34, Uwe Kleine-K=F6nig wrote:
> > > +	duty *=3D NSEC_PER_SEC;
> > > +	period *=3D NSEC_PER_SEC;
> >=20
> > A comment that/why this cannot overflow would be nice. (I didn't check,
> > maybe it can?)
>=20
> I /think/ that as long as NSEC_PER_SEC  2^32 then this shouldn't
> overflow.

I guess NSEC_PER_SEC won't change in the near future :-)

double checking and writing the result down in a comment would be
appreciated.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uwxa5sotju3k4kg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmT/buYACgkQj4D7WH0S
/k7fkAf1HwAtY7KGch3Cs4SdN1Y6smI/ObhPJ69Yi+fc+PidJZKGgdJO4OOaWNmD
cH1uqZwbQMe7W3ktv1bM7ZE85/IK9krstGiFKnEoiDSxzUqggCXo3yLr9jHuslzB
OxwIreyiCJWTOp6L2DixbWd8JEm+RxVDjx4ZfOr+G45m4bT9Eic1pZVvw1HR/cL6
LuAFKvhcqYygQ7WOa8ts1ZqkfmQ/vdR5fLCde7AUY7Y9r/fyB9fmmmiekxTX4HG1
VGGanMyG2afGK3XVMimFeuezH1LZwr0b6JI7+CSFqzMHxy4MHdvjsubO4K7vTuWx
PZBP5tENw1htEY5LYD0Jlr7hqzew
=wPVQ
-----END PGP SIGNATURE-----

--uwxa5sotju3k4kg3--
