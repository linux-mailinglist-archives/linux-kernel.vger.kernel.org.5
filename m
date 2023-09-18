Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0249D7A4583
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240866AbjIRJGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240963AbjIRJGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:06:39 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECC9102;
        Mon, 18 Sep 2023 02:06:28 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id BABE580274;
        Mon, 18 Sep 2023 11:06:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1695027986;
        bh=9cj5r2iDVR9dQMi7AsSJAdpzOyExQqvdECqIQVMXI64=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UKZreKQsgoV36ulY/UZpeYLvL8biFmb9x4ieBRztjO80T3278chxly1b8J1X9/8Kv
         /8i5oSgnx/M3hCxF1WCaBQVKcQ3bJbeWXscT9JYN9PXu/ljIA6RQ59d8ZK4a7Fmw3r
         Nt2TnhrWtNkj211h9b3Yw3krswa26FlQVH5KG1e3PlYeyw6rH9Q7G5L1eWrAnfmeT6
         TFtKyOJGDnGJPnK4eAh4VCCb1R5TlCN49OrO0A3qAGhD46aWYIM9rmsieM/ufopSvo
         izOQ33863oLhu1SzXG/gutqc/y/mj++nvsixh+2wxEnDl+D8/ip5bRU0vRuYyq5b20
         WeAtEiBc5y3iw==
Date:   Mon, 18 Sep 2023 11:06:18 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Tristram.Ha@microchip.com,
        Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Oleksij Rempel <linux@rempel-privat.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [[RFC PATCH v4 net-next] 0/2] net: dsa: hsr: Enable HSR HW
 offloading for KSZ9477
Message-ID: <20230918110618.406192aa@wsk>
In-Reply-To: <20230915142255.dcosmtrh25nbw5x7@skbuf>
References: <20230912160326.188e1d13@wsk>
        <20230912142644.u4sdkveei3e5hwaf@skbuf>
        <20230912170641.5bfc3cfe@wsk>
        <20230912215523.as4puqamj65dikip@skbuf>
        <20230913102219.773e38f8@wsk>
        <20230913105806.g5p3wck675gbw5fo@skbuf>
        <20230913141548.70658940@wsk>
        <20230913135102.hoyl4tifyf77kdo2@skbuf>
        <20230913184206.6dmfw4weoomjqwfp@skbuf>
        <20230914231831.0f406585@wsk>
        <20230915142255.dcosmtrh25nbw5x7@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A9KPOZJlzYqXN8kBEc2=SvE";
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

--Sig_/A9KPOZJlzYqXN8kBEc2=SvE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Thu, Sep 14, 2023 at 11:18:31PM +0200, Lukasz Majewski wrote:
> > As fair as I understood from the commit message - some part of this
> > patch needs to be applied before HSR offloading v4.
> >=20
> > Hence I will wait for it to be posted and upstreamed.
> >=20
> > Only then some of this patch code would be squashed to v5 of hsr
> > support. =20
>=20
> No, this isn't how this is going to work. I can't post my patches and
> then you post yours, because that would mean some functionality is
> introduced without a user (ds->ops->port_set_mac_address), and we
> don't accept that, because you may or may not resubmit your HSR
> patches as a first user of the new infra.

Ok. Thanks for the clarification.

>=20
> So, what needs to happen is you need to post all the patches as an
> all-or-nothing series. Somewhere in Documentation/process/ it is
> probably explained in more detail what to pay attention to, when
> reposting what is partly others' work. But the basic idea is that you
> need to keep the Author: and Signed-off-by: fields if you aren't
> making major changes, but you must also add your own Signed-off-by:
> at the end. You also have responsibility for the patches that you
> post, and have to respond to review feedback, even if they aren't
> authored for you. You are obviously free to make changes to patches
> until they pass your own criteria.
>=20
> The most that I can do to help you is to split that squashed patch and
> put the result on a branch:
> https://github.com/vladimiroltean/linux/commits/lukma-ksz-hsr-rfc-v4
>=20
> But it's up to you to take it from there, rebase it on net-next,
> review the result, test it, make sure that the changes are something
> that you can justify when submitting, etc. You won't be alone if you
> need help, of course, but the point is that you're not 100% passive
> to this activity.

No problem. I will test it for a while and then send them for review.

Many thanks for help.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/A9KPOZJlzYqXN8kBEc2=SvE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUIEwoACgkQAR8vZIA0
zr3iVwf/Yo0c6PviMOAbhRsIiHe3qHKqLImGlTfqUZaUhiwNQncaURH1+Y74Qfnp
jvwTWNrfys2SFO+E+vhSwEowcfdIwV4oaJVyibA9dbHWNxkjpMwB/OcxR6CHdm4F
L8pe3pZLh0cC5ENeOClKXmSyBufh8hyeMJ6tQZBSmP39evvuOxzGbtyqlmgwuBcM
bJo1S6tJNN18bCiIijAGkxUUjji3VZgJwY1uPhNRsqOfZjU1PGXVS3NoXFQ5kvkz
BrsFZu2Qu0/BLXW7YfxGsVuB6DNUz+pnjXtOq+vuCdfiF5LTzxX4cDnwpaYE/cwS
q9Uc0VQPuPjQVMtsiBI+TWdPymB6jw==
=DNew
-----END PGP SIGNATURE-----

--Sig_/A9KPOZJlzYqXN8kBEc2=SvE--
