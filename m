Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C245C79C70C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjILGiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjILGiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:38:00 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19634E75
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:37:56 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qfx1k-0006PS-HP; Tue, 12 Sep 2023 08:37:36 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C06B721E7FC;
        Tue, 12 Sep 2023 06:37:34 +0000 (UTC)
Date:   Tue, 12 Sep 2023 08:37:32 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Srinivas Goud <srinivas.goud@amd.com>
Cc:     wg@grandegger.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, git@amd.com, michal.simek@amd.com,
        linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, appana.durga.rao@xilinx.com,
        naga.sureshkumar.relli@xilinx.com
Subject: Re: [PATCH v4 3/3] can: xilinx_can: Add ethtool stats interface for
 ECC errors
Message-ID: <20230912-drowsily-smoking-8c8f48c10f29-mkl@pengutronix.de>
References: <1693557645-2728466-1-git-send-email-srinivas.goud@amd.com>
 <1693557645-2728466-4-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l5vvd2wtknntl2aj"
Content-Disposition: inline
In-Reply-To: <1693557645-2728466-4-git-send-email-srinivas.goud@amd.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l5vvd2wtknntl2aj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.09.2023 14:10:45, Srinivas Goud wrote:
> Add ethtool stats interface for reading FIFO 1bit/2bit
> ECC errors information.

I just figured out, that there is an u64 stats helper:

https://elixir.bootlin.com/linux/latest/source/include/linux/u64_stats_sync=
=2Eh

Please make use of this one.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--l5vvd2wtknntl2aj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUABykACgkQvlAcSiqK
BOhREwf/eDuGUyy6bTBn0WZUOknRwaFJNz/q/sdZBpFZUL469b0U2LZGsh09KyH2
OLhRHxHumjIpt+sBBBt5EReH9SJm8BceatVSHwr0oucOKiHEhJZGeHHXpa64DhVu
6e29Td5MQH4qiv6UTwkIBvzhIoi0TdfFDmLDkcGC9svoZYNgvpW1Cq2UlljE1K/C
7NEFFyNGemCLdAM4rCALm8Jf4RonIqj3Sme6suyKXAkfyGqmYeY89aHqSsS07i1E
1NhHVGaHWBK4jvOolh5ImLjc4u/bgyy1LbugIeHCSqr1CX8ik8bp3wf601gZEIhQ
8Fjkq5g/f7r7hT5zySaGRiBDJqN40w==
=39w6
-----END PGP SIGNATURE-----

--l5vvd2wtknntl2aj--
