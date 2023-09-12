Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B36579D458
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbjILPHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbjILPHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:07:04 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BA7CC3;
        Tue, 12 Sep 2023 08:07:00 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 416AB86EF6;
        Tue, 12 Sep 2023 17:06:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1694531208;
        bh=kAO8rV3vrUUn8vnr/0rLlGCFof1rPKUtl5QB+NrrSuI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CBmPjljgvxQYrvCjsqWXm9BVcPi9OqZi04b4AdwshjFpI70YFmUABYJ6y77Ml10DI
         j56B6u/G0WfGoOWOGvxBZI6UbeQTOI7Q7dhykf/BMSmRl1C4Tk/wl2iBWq9Ez22L2g
         NBjUTijiAwxMX0pggZktBTf8A6D/9889Ko5M9XO67ZJ1P5KXw58eVwLNF8dJUGceVd
         Xz/1dV4/JPeDfFng942dfvw6R6CHzL0JxniVQx6KiGF3s4cBRmB/jbE92iLtIg8dMn
         vB/NtuNKkmvfrrWxGgRAJUCPZmjkxlmJ9X+Es/12ccfM+0tgfj14id156SPwtOJJe1
         Q+Oy1VFD482lA==
Date:   Tue, 12 Sep 2023 17:06:41 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Oleksij Rempel <linux@rempel-privat.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [[RFC PATCH v4 net-next] 0/2] net: dsa: hsr: Enable HSR HW
 offloading for KSZ9477
Message-ID: <20230912170641.5bfc3cfe@wsk>
In-Reply-To: <20230912142644.u4sdkveei3e5hwaf@skbuf>
References: <20230911160501.5vc4nttz6fnww56h@skbuf>
        <20230912101748.0ca4eec8@wsk>
        <20230912092909.4yj4b2b4xrhzdztu@skbuf>
        <20230906152801.921664-1-lukma@denx.de>
        <20230911165848.0741c03c@wsk>
        <20230911160501.5vc4nttz6fnww56h@skbuf>
        <20230912101748.0ca4eec8@wsk>
        <20230912092909.4yj4b2b4xrhzdztu@skbuf>
        <20230912160326.188e1d13@wsk>
        <20230912160326.188e1d13@wsk>
        <20230912142644.u4sdkveei3e5hwaf@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XGZYAjXanzDzdalXDjH+rp9";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XGZYAjXanzDzdalXDjH+rp9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Tue, Sep 12, 2023 at 04:03:26PM +0200, Lukasz Majewski wrote:
> > > In any case, as long as it's the DSA master's address that we
> > > program to hardware, then I see it as inevitable to add a new
> > > struct dsa_switch_ops :: master_addr_change() function =20
> >=20
> > Please correct my understanding. The above change would affect the
> > whole DSA subsystem. It would require to have the core DSA modified
> > and would affect its operation? =20
>=20
> Uhm, yes, that would be the idea. If we were going to track changes to
> the DSA master's MAC address, we should do it from the DSA framework
> which has the existing netdev notifier listener infrastructure in
> place.
>=20
> > > Or you can argue that dragging the DSA master into the discussion
> > > about how we should program REG_SW_MAC_ADDR_0 is a complication. =20
> >=20
> > Yes, it is IMHO the complication. =20
>=20
> Ok, it's a point of view.
>=20
> > git grep -n "REG_SW_MAC_ADDR_0"
> > drivers/net/dsa/microchip/ksz8795_reg.h:326:#define
> > REG_SW_MAC_ADDR_0 0x68=20
> > drivers/net/dsa/microchip/ksz9477.c:1194:
> >      ksz_write8(dev, REG_SW_MAC_ADDR_0 + i,
> >=20
> > drivers/net/dsa/microchip/ksz9477_reg.h:169:#define
> > REG_SW_MAC_ADDR_0 0x0302
> >=20
> > In the current net-next the REG_SW_MAC_ADDR_0 is altered used (the
> > only usage are now with mine patches on ksz9477).
> >=20
> > To sum up:
> >=20
> > 1. Up till now in (net-next) REG_SW_MAC_ADDR_0 is ONLY declared for
> > Microchip switches. No risk for access - other than HSR patches. =20
>=20
> I know (except for Oleksij's WoL patches, which will eventually be
> resubmitted).

Are we debating about some possible impact on patches which were posted
and (in a near future?) would be reposted?

>=20
> > 2. The MAC address alteration of DSA master and propagation to
> > slaves is a generic DSA bug. =20
>=20
> Which can be/will be fixed. The diff I've included in the question to
> Jakub closes it, in fact.

Ok.

>=20
> > Considering the above - the HSR implementation is safe (to the
> > extend to the whole DSA subsystem current operation). Am I correct?
> > =20
>=20
> If we exclude the aforementioned bug (which won't be a bug forever),
> there still exists the case where the MAC address of a DSA user port
> can be changed. The HSR driver has a NETDEV_CHANGEADDR handler for
> this as well, and updates its own MAC address to follow the port. If
> that is allowed to happen after the offload, currently it will break
> the offload.

But then we can have struct ksz_device extended with bitmask -
hw_mac_addr_ports, which could be set to ports (WoL or HSR) when
REG_MAC_ADDR_0 is written.

If WoL would like to alter it after it was written by HSR, then the
error is presented (printed) to the user and we return.

The same would be with HSR altering the WoL's MAC in-device setup.


The HSR or WoL can be added without issues (the first one which is
accepted).

Then the second feature would need to implement this check.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/XGZYAjXanzDzdalXDjH+rp9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUAfoIACgkQAR8vZIA0
zr3OWQf+OU0d++AGcr9DO/5c9XDot4JfUCMuN2rGlna5MYir6nOvPMSXVLboFqEG
BejwbfiWa7o1OVVXvnbvNN1K+v1Bf1Puz9x9VBNpvUCNulPVfuuAbgeK/8noNerh
P1ugl4aZPu2paOFaCaXnhuGeM6Zv5RBkEybo75PXgSnZNUjAm12WUjqfdw7FqLOc
+iqInlXdnTbQZX5FA7hryxmwGoJj/9seRrlK7DxYyxFJ29k0/OBJ6CygmE5NYzlb
SlJrKpC1Oo6aAdDy8XEaYJPMu/QR+/p6czVXZQ3bSV1Q8r22bfIHpGd/NoLhy39C
zhB04X3y5LykB70wuqakCbqmWyCz1A==
=FKeJ
-----END PGP SIGNATURE-----

--Sig_/XGZYAjXanzDzdalXDjH+rp9--
