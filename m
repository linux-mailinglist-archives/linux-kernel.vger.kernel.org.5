Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F59A813550
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573930AbjLNPxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573935AbjLNPxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:53:04 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F05129
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=AY8d
        +sEQGQaRJ6K6hiCtr1zH809ucxRUF3zOxIkfyL8=; b=KhVRJ8Bc7B347PKoXwOY
        TVIo7wzTa2JPIO5GoWUkSMGo/c+syKKehuU2+ISCRiBvOM2xJSeoyhLvAR3/0y5D
        HKS3wKIW4vDmFx68Neef3S0fn6Q0K8qlVrmD2L0w8m29qWNGGjHZDB6UBY0ST2LG
        LUzBjdzroekMVaL3XJE/rtfJNhXRVIXw6yatDwm2bBv27JegV5CcA/aOdewtXSPd
        X3WqPOkr/swlT8xTX0FFydG7p+Kzv8mgpWIRUDFRdZ7NChN1zpSL30jkeCrFzbaB
        EWY8bzb2j2pVVPPiGbV/pu5IBOyfbGSxBlphCug5dncwXC4hLF1DgS2FHjw9iqMA
        eQ==
Received: (qmail 973020 invoked from network); 14 Dec 2023 16:53:08 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Dec 2023 16:53:08 +0100
X-UD-Smtp-Session: l3s3148p1@mZakR3oMsukujnuR
Date:   Thu, 14 Dec 2023 16:53:06 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] gnss: ubx: support the reset pin of the Neo-M8
 variant
Message-ID: <ZXsk4i/OTGFhiCk9@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
References: <20231113005152.10656-1-wsa+renesas@sang-engineering.com>
 <ZXfTwscAltoVY1lV@shikoro>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PKRATVOl1tJO9Tu6"
Content-Disposition: inline
In-Reply-To: <ZXfTwscAltoVY1lV@shikoro>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PKRATVOl1tJO9Tu6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 04:30:10AM +0100, Wolfram Sang wrote:
> On Sun, Nov 12, 2023 at 07:51:48PM -0500, Wolfram Sang wrote:
> > The Renesas KingFisher board includes a U-Blox Neo-M8 chip with its
> > reset pin wired to a GPIO. To support that, we need "reset-gpio" support
> > (patches 2+3). But first, simplify regulator handling with a new helper
> > (patch 1).
> >=20
> > Changes since v4:
> >=20
> > * don't touch reset during open/close. Only deassert it during probe.
> >   [patch 3]
>=20
> Johan, all good now?

If there are no further comments, can we have this series in 6.8.?


--PKRATVOl1tJO9Tu6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmV7JOIACgkQFA3kzBSg
KbYO4hAAn1J7NbLQ2GuIZrT6AKKsXZdHGWDc0ThG1vWgO1WYOxdSnvm6eGEUk0Bc
AFEKVxyNAe/jP0EHUHylnBxgoSjA2Hse/zXERqjijVdJLr4X09D3o5PWNbalcXWE
3wxEO/2cIcwe9W+5uBOy5miHEIwjJN4+gDdBl1w2SOVQiOAuFFF8Ihp+5Q/sNPBv
7lSM2TL+mRnkVfSyCW/viAtrWSfjn+FVHrc5AsILWl3na0ux7nMqSyKjGV7IGjfq
vrEU3QxB62BeOtLG0hZXpzbYKPHuRCFocp0WBsjNBgRSE9bysDRT+Hmm4kh7frdN
0eC6mTunToh70ziCg6y2DIN+ix/9jl34BncbOavCszGYrXKz1lgLtDQkes7T6xKH
eVBS3VatU9W/Sf5w/ttLv/kya6KJ5KrTdyq5He19Xov4G6sC0ZQVZr6tOnXTeinH
7MdXPgzZTf/ub5MrffIEj869A5rmeyqEoczJYovCtOga+IOQJ8JrYrMQczRgsxRF
3wdcLqdqVI4YHboaidKlefZxxdgoLEPQcyYE+3puiLo0hk0SEqw5FKzlzGRxytiL
r9UHSu9UFYYIEFKGgggIwZLDcx5UX7cGWR6ocygGGw2aUB9/Oo6V2ckiEv58Ozqi
Rgdle6iawBwe5K2KVl3dgoSoHrJ6PwWSyX3Lf677z/dfLJA/rgY=
=NTsT
-----END PGP SIGNATURE-----

--PKRATVOl1tJO9Tu6--
