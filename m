Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363FA79C9A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjILISj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjILISf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:18:35 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73814E73;
        Tue, 12 Sep 2023 01:18:31 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id B5CCE86579;
        Tue, 12 Sep 2023 10:18:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1694506710;
        bh=9wb5FeWubky1oIAbeo9edOrsVfoQdXCFNWMwrsrUg9A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qSK5Uh7ssG23jMK4Y6G801yywaMGez2TrqRS7/BS1GC5ix5D1NbcMV8NTqsK7DQ6q
         HGPlby9zwJA3LZaQ+QO9xV0eOfIT4IzdfKFvmCVqckupTdROuYStjDNojGU6RpNj9U
         feLawE00B+m4TVMemyU8ujyr4oQLQ4VPlAHSuenulHdgxrwwqXxjTjTXIotI8mo7sX
         nw1r7BGTH3xdkKfRyhoFwydVZTv0ud2x4hAFoQ1rkCZvgBjxEGmEOlne1NcbOtgU6e
         sAjsjZMDtmptEW3XJIcAzZQl4PhQ9S5q8y/nJozvpAz5CDigT8Yy10cf9jX/Xx7ubd
         w/9cBeDDb2luw==
Date:   Tue, 12 Sep 2023 10:18:28 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kristian Overskeid <koverskeid@gmail.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Oetken <ennoerlangen@gmail.com>
Subject: Re: [PATCH] net: hsr : Provide fix for HSRv1 supervisor frames
 decoding
Message-ID: <20230912101828.06cb403d@wsk>
In-Reply-To: <20230911150144.cG1ZHTCC@linutronix.de>
References: <20230825153111.228768-1-lukma@denx.de>
        <20230905080614.ImjTS6iw@linutronix.de>
        <20230905115512.3ac6649c@wsk>
        <20230911165708.0bc32e3c@wsk>
        <20230911150144.cG1ZHTCC@linutronix.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/w1cpGf5uIBTaYfp_sMHo70t";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/w1cpGf5uIBTaYfp_sMHo70t
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

> On 2023-09-11 16:57:08 [+0200], Lukasz Majewski wrote:
> > Hi Sebastian, =20
> Hi,
>=20
> >=20
> > Have you had time to review this patch? =20
>=20
> got distracted a few times. I need a quiet moment=E2=80=A6 Will do this w=
eek=E2=80=A6
>=20

Ok. No problem. Thanks for the information.

> > Your comments are more than welcome. =20
>=20
> Sebastian




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/w1cpGf5uIBTaYfp_sMHo70t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUAHtQACgkQAR8vZIA0
zr30XAgA3NOG4MD0rN/IH6TpqM+cORRax7QUIJr2dL93JsYwV+XoljCH9R2NXrOh
HJ7XzNzaF5p6baUgpKs2qtocwYSrd4UPHUZlSYG8+uLCwSSeBZlRtCi6gHmBeFbH
8XeOR5ZXME5y0KI6TX69IcvaqsH0WNWNa22r1XMeICV7dEvYf7cfLqCfoWqQ/FVh
C8FEzBfahpmYu8PHI/ELoVQDHOAEQ9vA4wtzLc4qaf2E4MZ+IciOBavzjFjaK3Hk
bFvPpGGiC3Xq1Ppovqm3URYZ8V3NKyHkVREkhX/1/742ZcHLRHRSKZdIKmEu1Dq7
L8nLHuMIwSp6yw3Cr5qwdjcOYb/iAQ==
=Zt4n
-----END PGP SIGNATURE-----

--Sig_/w1cpGf5uIBTaYfp_sMHo70t--
