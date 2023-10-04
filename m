Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E32E7B7D16
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242176AbjJDK0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjJDK0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:26:13 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B64A95
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 03:26:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qnz4n-0007NJ-8z; Wed, 04 Oct 2023 12:25:57 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qnz4m-00B0Xz-M8; Wed, 04 Oct 2023 12:25:56 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4E5AE22ED1E;
        Wed,  4 Oct 2023 10:25:56 +0000 (UTC)
Date:   Wed, 4 Oct 2023 12:25:55 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     socketcan@hartkopp.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] can: raw: Remove NULL check before dev_{put, hold}
Message-ID: <20231004-shield-accurate-6b875651801b-mkl@pengutronix.de>
References: <20230825064656.87751-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7n5eokfyo5pa3sfp"
Content-Disposition: inline
In-Reply-To: <20230825064656.87751-1-jiapeng.chong@linux.alibaba.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7n5eokfyo5pa3sfp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.08.2023 14:46:56, Jiapeng Chong wrote:
> The call netdev_{put, hold} of dev_{put, hold} will check NULL, so there
> is no need to check before using dev_{put, hold}, remove it to silence
> the warning:
>=20
> ./net/can/raw.c:497:2-9: WARNING: NULL check before dev_{put, hold} funct=
ions is not needed.
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D6231
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied to linux-can-next/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7n5eokfyo5pa3sfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUdPbEACgkQvlAcSiqK
BOhaJAf8CJS4q8gjgzgbvGEY1oFdsFx5AOdvsIgFL4F3pg+7AjMNRXIX+CyDnGlf
8tmSvh/3670c5pL8EN5ptuvlUVlJDVOhiH4/28FCC+7zkoWRtEOu4U6v4Uz2onGB
d2FSb0cx7ifFIjrr6IOsBa67lPO5GD2AXXED8uyiE42K6cWYnpVqS6t48YDle5j2
u76Q97bvL2TGI1sh3FWKtrsSpgYKcRiKDW9BxodrQrboRqeUMyqfq5OMnn76bc0r
EyPe0zGVVE2peGfAWhdN1IC/5u7kuhPoB8WdymLnM99pSGeMVrPcvZ+vufB/hM3K
UnMXGbHpmSlZ18a4oJZuyYTQJaSQnQ==
=nayZ
-----END PGP SIGNATURE-----

--7n5eokfyo5pa3sfp--
