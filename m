Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82A280AA8E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbjLHRU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbjLHRUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:20:13 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAC4212E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:19:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1rBeU9-0006oS-Lt; Fri, 08 Dec 2023 18:17:57 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1rBeU8-00ESyf-8k; Fri, 08 Dec 2023 18:17:56 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CB34F25EAD8;
        Fri,  8 Dec 2023 17:17:55 +0000 (UTC)
Date:   Fri, 8 Dec 2023 18:17:54 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH RESEND v1 0/7] MPFS clock fixes required for correct CAN
 clock modeling
Message-ID: <20231208-atonable-cable-24ce1ceec083-mkl@pengutronix.de>
References: <20231208-reenter-ajar-b6223e5134b3@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xyc7h6dsb2frvsw2"
Content-Disposition: inline
In-Reply-To: <20231208-reenter-ajar-b6223e5134b3@spud>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xyc7h6dsb2frvsw2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.12.2023 17:12:22, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> Resending cos I accidentally only sent the cover letter a few minutes
> prior to this series, due to screwing up a dry run of sending.
> :clown_face:
>=20
> While reviewing a CAN clock driver internally for MPFS [1]

> 1 - Hopefully that'll show up on the lists soon, once we are happy with
>   it ourselves.

A CAN clock driver or a complete CAN driver?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xyc7h6dsb2frvsw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmVzT78ACgkQvlAcSiqK
BOhBxQf7BYrhkxcGONNExkw5pTvSe2aLsApA8F4gr/MdexrCCcTenD7cTeiajOzK
K0oLIoWt5Gu2YpWLNf9rl6YAjTSMel/sbvSpwi5VpC0sJXtQ6snB522S7zB40dBX
DlV/YH+cIaYauSFFcCRGD/SBAKdNn24jn87i/lG4Ban1OXDZ979dRxwqZC+OXhJ+
E4noB9XsO4EalZtLDH6R3jKxTUmEgh43ic9c2v73S0tJO4P8v3bEWocQoManBJsa
09Lk42+pknYNywmrtNJnzBoJ5CAm5DojiSVBRmi0/3VTcOZDulX+1rY4+BeDFtG7
CszXgKFkjG9kv7z0kmuxK0NANfvGxw==
=7yOt
-----END PGP SIGNATURE-----

--xyc7h6dsb2frvsw2--
