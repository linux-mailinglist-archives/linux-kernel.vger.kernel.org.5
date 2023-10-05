Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8267BA075
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbjJEOhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjJEOfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:35:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF6465A5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 23:16:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoHf4-0006nV-35; Thu, 05 Oct 2023 08:16:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoHf1-00BCbY-Vy; Thu, 05 Oct 2023 08:16:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoHf1-009KE1-MX; Thu, 05 Oct 2023 08:16:35 +0200
Date:   Thu, 5 Oct 2023 08:16:23 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ken Lin <ken_lin5@hotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, groeck@chromium.org,
        Benson Leung <bleung@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Reka Norman <rekanorman@chromium.org>,
        Stefan Adolfsson <sadolfsson@chromium.org>,
        chrome-platform@lists.linux.dev, linux-media@vger.kernel.org,
        "rasheed.hsueh" <rasheed.hsueh@lcfc.corp-partner.google.com>
Subject: Re: [1/2] media: platform: cros-ec: Rename conns array for the match
 table
Message-ID: <20231005061623.hjsd4xiubqblo772@pengutronix.de>
References: <KL1PR01MB38096300BE18095E51FB7A5BAECAA@KL1PR01MB3809.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cj6vpskierrgyefj"
Content-Disposition: inline
In-Reply-To: <KL1PR01MB38096300BE18095E51FB7A5BAECAA@KL1PR01MB3809.apcprd01.prod.exchangelabs.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
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


--cj6vpskierrgyefj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Oct 05, 2023 at 09:38:40AM +0800, Ken Lin wrote:
> Rename conns array to port_**_conns, ** is the ports which support cec.
> ex: dibbi_conns support Port D and B will be renamed to port_db_conns.
> Make it much cleaner and readable.
>=20
> Signed-off-by: Ken Lin <ken_lin5@hotmail.com>
> ---

Two procedural hints:

Please send patch series in a way that they form a thread. git
send-email should get this right. Patch 2/2 is completely separate
=66rom this patch which might make it harder for maintainers to apply
your patches

This patch doesn't fit on current mainline. It's a good idea to use
the --base parameter for git format-patch or to explicitly mention the
tree you based your patches on. (Ok, found it, it fits on next.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cj6vpskierrgyefj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUeVLcACgkQj4D7WH0S
/k4x1wf+MViJOuZ1uIXTReTvTvgQbcXNTX6J3b3CCTmo1+USWjuAMAsrxTibfY6u
ai92ZiJ42zaQzxwmcSEIv7bSNrK263WKgOzgnqwJsBum0skhzj5pg2f/ZPhKyIPA
XMiYTUmS4TDIcOzKC8ErgBgCX6vZbqbzvt3WtMMUXaW9/wJ6dtnDo5F6F4dcZT/V
GBGKyIcc22FFPjQJutk5DwYqygOhTKEYAPCFaADV7KyjJfvvQ+QJhSoQc0MF6NLa
GPNMjUYPa8cm3HlAutZf5ODuNiNawC9y/xCIHGF35376OkoCYYbb+zwRV4u2tVv+
fV+K/LWktF6E2IjMFmtyN2VOfJ3roQ==
=+Kty
-----END PGP SIGNATURE-----

--cj6vpskierrgyefj--
