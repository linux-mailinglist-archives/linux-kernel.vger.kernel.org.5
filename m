Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A3B7B696F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjJCMvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjJCMvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:51:21 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED6D91;
        Tue,  3 Oct 2023 05:51:15 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 1C85687102;
        Tue,  3 Oct 2023 14:51:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1696337473;
        bh=aaprkLAz8M28X4vHEFfK4xuZcsmFV8/uA9susaQBpHI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gUy6gV7Jf2LmC+75CGPiHiNeLdQZqdbjOXHDGCWy2IVIny+rTbN0fjqN1FO5z4Mgh
         AnuxgZrU5yy8FI4edE5i46BvziysCcF3FhxL3BqaSe4Q0ggW2GHUDbFmY6zKMJh3ja
         juiXSzXboZewVRIKjTZKxkRwjcDGyoTTTewijkPqkzbyIV6rrjafLgeiQvncpjTuti
         a5fCeLJJvMocllC96iDPP9A6oITP10g/Chr6b4YrJrvf0ozPoHVOSuSzGJS0J5t0U1
         ayAYjXGp0k4svj0ufq53k5UxWinq4/Ed8mX8C4PXGzubg4uYkV3AXxKAqG+j/nKOlH
         cpc789T6qLz2Q==
Date:   Tue, 3 Oct 2023 14:51:06 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Woojung Huh <woojung.huh@microchip.com>,
        Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        davem@davemloft.net, Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 net-next 0/5] net: dsa: hsr: Enable HSR HW offloading
 for KSZ9477
Message-ID: <20231003145106.3cd5a19f@wsk>
In-Reply-To: <20231003104410.dhngn3vvdfdcurga@skbuf>
References: <20230922133108.2090612-1-lukma@denx.de>
        <20230926225401.bganxwmtrgkiz2di@skbuf>
        <20230928124127.379115e6@wsk>
        <20231003095832.4bec4c72@wsk>
        <20231003104410.dhngn3vvdfdcurga@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DeKx4JaPtFZ3VK4fxaRFAgh";
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

--Sig_/DeKx4JaPtFZ3VK4fxaRFAgh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Tue, Oct 03, 2023 at 09:58:32AM +0200, Lukasz Majewski wrote:
> > I'm a bit puzzled with this patch series - will it be pulled
> > directly to net-next [1] or is there any other (KSZ maintainer's?)
> > tree to which it will be first pulled and then PR will be send to
> > net-next?
> >=20
> > Thanks in advance for the clarification.
> >=20
> > Links:
> >=20
> > [1] -
> > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/log/
> > =20
>=20
> No, there's no other tree than net-next. I see your patch was marked
> as "Changes requested", let me see if I can transition it back to
> "Under review" so that it gains the netdev maintainers' attention
> again:
>=20
> https://patchwork.kernel.org/project/netdevbpf/cover/20230922133108.20906=
12-1-lukma@denx.de/
>=20
> pw-bot: under-review

Thanks!

I've just noticed that there is a WARNING:
https://patchwork.kernel.org/project/netdevbpf/patch/20230922133108.2090612=
-6-lukma@denx.de/

but then on the newest kernel checkpatch.pl is silent:
./scripts/checkpatch.pl
0005-net-dsa-microchip-Enable-HSR-offloading-for-KSZ9477.patch total: 0
errors, 0 warnings, 0 checks, 277 lines checked

0005-net-dsa-microchip-Enable-HSR-offloading-for-KSZ9477.patch has no
obvious style problems and is ready for submission.

Does the checkpatch for patchwork differs in any way from mainline?


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/DeKx4JaPtFZ3VK4fxaRFAgh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUcDjoACgkQAR8vZIA0
zr383Qf/UDs6iZwqUh3JPM8lRrI19Hze1fJ2qEnCAinjhHYz5KFN2kpzFsOJvYN9
ESkNWN2mYJe55GyWs/BiV7vwGmtDR5PjcBvXSu/h8MkOnaJndK7ArvhscyssqyWv
M4jFjLRAA7UKAS83gkm4ANa9aIs0MM3Q8dqg0akJq/QZFNYko7WyDLvZYBTe9psE
+jsmzqTvRkqDFr4YwY0yflCdRO8ykYCdXsfgJaPz8uEQ5B271OpVhJMYNuJjpjh6
dL+8baMb1sqDF6OvkWq/pUl5DhY3c0SICRMPJGOoZBqf6HUO/6753e3rhq4U7dC7
9C2tMT/sYG31cCwhTLWXG06n3IERDw==
=E0iA
-----END PGP SIGNATURE-----

--Sig_/DeKx4JaPtFZ3VK4fxaRFAgh--
