Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B79792573
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbjIEQFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354873AbjIEPU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 11:20:56 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2660197;
        Tue,  5 Sep 2023 08:20:52 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 0C2FD86568;
        Tue,  5 Sep 2023 17:20:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693927251;
        bh=T1uTBxVz9fEuMymC1e29HHIynA4YqjuQ7wSHalYu748=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cn7PT9z1pO8YaE3Aw/xl9jSafgAPJMOhMlgdKis4TD+7HfSQJ0p7YKovvyH79OhQP
         NZGUl1lT0Joc54/WdjvAb5S2vgUP6Eq9Otk9VebO+QmmWhhy4oNMGgoKF+PvB73ati
         tQkqiSQvMv72vpMDwQkPa/unrxhoAMM5giJkKLRFJI1tmswKH1up9MkDhcgmchait+
         yvgwNiGmTuw3ZycAp5f98MsnXWUW+iWeEdO6vLB9HIkn3PhHv1Xu3lYMjdlO1dCXMN
         Ynf8K7kNR67zO9Bz8uYWBwLMvK0C9du4yQkezba9Csn2UsJjMao5EXWnSbB8uDLPJ6
         U9V3bfdypv9eA==
Date:   Tue, 5 Sep 2023 17:20:50 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
        davem@davemloft.net, Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Tristram.Ha@microchip.com, Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
        George McCollister <george.mccollister@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RFC 3/4] net: dsa: hsr: Enable in KSZ9477 switch HW
 HSR offloading
Message-ID: <20230905172050.2834d2df@wsk>
In-Reply-To: <20230905134837.dzp3yk2hjgt6hf4a@skbuf>
References: <20230904120209.741207-1-lukma@denx.de>
        <20230904120209.741207-1-lukma@denx.de>
        <20230904120209.741207-4-lukma@denx.de>
        <20230904120209.741207-4-lukma@denx.de>
        <20230905103750.u3hbn6xmgthgdpnw@skbuf>
        <20230905131103.67f41c13@wsk>
        <20230905130355.7x3vpgdlmdzg6skz@skbuf>
        <20230905134837.dzp3yk2hjgt6hf4a@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Fg0cFCxgPXtz_OmM9qIQy/n";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Fg0cFCxgPXtz_OmM9qIQy/n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Tue, Sep 05, 2023 at 04:03:55PM +0300, Vladimir Oltean wrote:
> > > > What are the causes due to which self-address filtering and
> > > > duplicate elimination only work "most of the time"? =20
> > >=20
> > > Please refer to section "KSZ9477 CHIP LIMITATIONS" in:
> > > https://ww1.microchip.com/downloads/en/Appnotes/AN3474-KSZ9477-High-A=
vailability-Seamless-Redundancy-Application-Note-00003474A.pdf
> > > =20
> >=20
> > Ok, so the limitation is a race condition in hardware such that,
> > when duplicate packets are received on member ports very close in
> > time to each other, the hardware fails to detect that they're
> > duplicates. =20
>=20
> It would be good to leave at least the link as part of the comment,
> if not also a short summary (in case the PDF URL gets moved/removed).

Ok.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/Fg0cFCxgPXtz_OmM9qIQy/n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmT3R1IACgkQAR8vZIA0
zr1iMwgAmOimDVrRtYK0fKVZ58n11pSAlMPeA5gm31LbU9V7Vw1FdlcAoMz76bAH
hTH6bugjTvkpR+kCRdUmrgBDbAdeQmtuTBChCvW7puLVjAofzAP5j9HfC2OrUsYR
6SOYh8r4lWAHzsSpGwyboJK5qYaILwGBcIM2/sGr0eFplVzmCM8lD7Z6zQjKV5h1
ALP6mRH4dRxfd8/xmO1pc/XK3fe2jRHXVBz9/hlMLIohSJ2KQ+raSOPM0bdc8PVv
zUlqQe16/2Z/8Krt9hV/F/uLzmbMKSg+5/YDEhOeem0aLo4r8WK66DK70wl7C+bs
ba4SiVpiUZlSbtorq088jjo7CS8oAg==
=1mul
-----END PGP SIGNATURE-----

--Sig_/Fg0cFCxgPXtz_OmM9qIQy/n--
