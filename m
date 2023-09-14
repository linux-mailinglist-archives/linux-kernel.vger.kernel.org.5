Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5537A0F35
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjINUqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjINUqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:46:17 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9BA2698;
        Thu, 14 Sep 2023 13:46:12 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E5D8B8619A;
        Thu, 14 Sep 2023 22:46:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1694724365;
        bh=XTngkan7RZTToUwglNOoCwHHF+jxvfkJf/daBGVqjuM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VELJEuCDUVPyjayr49XiisxPTFspdLKlhYLGem3UcavfgYKR+UzcXrhILe6zRu68u
         1DMe8+1XhS6qUcfbXAFhjcka/cKUW8CWGimU48GAiGc3ZoQZ8VnF7Hjx/Z8vITdYnM
         WQymlqiljsiN7yN7svhpFCTgbLKFRFzw3nRWysKdtE6NwMa0dcEUaDy8jGN8lONc8D
         ZLvkpfWcMgRKYhXtvR6QUgr53rl7kWws3L3J/F+/ZCcSRP0fLgRPudGjNhbfxJBPox
         jbcxTFaSYozFj+BpOrDOtAKWJOacr3urDbKiXbk0gFh7oKsgz2jLDx2bHlPSwwoCXC
         mZyQV0oM/vrZw==
Date:   Thu, 14 Sep 2023 22:45:57 +0200
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
Message-ID: <20230914224557.0ca0f057@wsk>
In-Reply-To: <20230913135102.hoyl4tifyf77kdo2@skbuf>
References: <20230912101748.0ca4eec8@wsk>
        <20230912092909.4yj4b2b4xrhzdztu@skbuf>
        <20230912160326.188e1d13@wsk>
        <20230912160326.188e1d13@wsk>
        <20230912142644.u4sdkveei3e5hwaf@skbuf>
        <20230912170641.5bfc3cfe@wsk>
        <20230912215523.as4puqamj65dikip@skbuf>
        <20230913102219.773e38f8@wsk>
        <20230913105806.g5p3wck675gbw5fo@skbuf>
        <20230913141548.70658940@wsk>
        <20230913135102.hoyl4tifyf77kdo2@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2qAaBY27j4Xi1V+4gXSYttg";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2qAaBY27j4Xi1V+4gXSYttg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Wed, Sep 13, 2023 at 02:15:48PM +0200, Lukasz Majewski wrote:
> > > I thought we were in agreement to program the actual DSA user
> > > ports' MAC addresses to hardware. =20
> >=20
> > No - v4 of this solution uses HSR net device MAC address, which is
> > supposed to be the same as DSA master. =20
>=20
> By "in agreement" I mean "as a result of the discussion on v4 [ this
> discussion ], where it became obvious that the DSA master solution is
> not so robust". I hope the 12 emails already exchanged on this patch
> set weren't for nothing.
>=20
> > > With KSZ switches, a single CPU port is supported, so all ports
> > > share the same DSA master. So if the contents of
> > > REG_SW_MAC_ADDR_0 is different from the DSA master (the same DSA
> > > master that was used for an earlier HSR offload), why do you
> > > infer that it was altered by WoL? It makes no sense. =20
> >=20
> > So where is the issue? The only issue is that somebody would change
> > DSA master (and hence HSR) MAC address, so the REG_SW_MAC_ADDR_0
> > would not be changed. Or do I miss something? =20
>=20
> Changing the DSA master address and changing the HSR MAC address
> (indirectly through the ports' address) are different operations.
> The DSA master's address and the user ports' address are not
> necessarily in sync.
>=20
> Each address change is problematic in its own way, and each problem
> needs to be tackled in its own way, depending on which MAC address you
> desire for REG_SW_MAC_ADDR_0 to track.
>=20
> But yes, the only issue is that the MAC address can be changed at
> runtime, after the initial offload.
>=20
> > > - Changing the MAC address of (a) triggers a pre-existing bug.
> > > That bug can be separated from the HSR offload discussion if the
> > > HSR offload decides to not program the DSA master's MAC address to
> > > hardware, but a different MAC address. The pre-existence of the
> > > DSA bug is not a strong enough argument per se to avoid
> > > programming the DSA master's address to hardware. =20
> >=20
> > And this is how v4 is implemented. Or not? =20
>=20
> If A =3D=3D B initially, then there are 2 ways you can change that
> condition. You can change A, or you can change B. Replace "A" with
> "the DSA master's address" and "B" with "the HSR device's address".
>=20
> > > - Changing the MAC address of (c) does not seem directly possible,
> > > but:
> > >=20
> > > - Changing the MAC address of (b) also triggers (c) - see
> > > hsr_netdev_notify(). This is because the HSR driver makes sure
> > > that the addresses of port_A, port_B and the HSR device are equal
> > > at all times. =20
> >=20
> > Why changing HSR port would affect HSR device MAC address? =20
>=20
> I don't have a simpler answer than "because that's what the code
> does".
>=20
> If you don't have time to experiment to convince yourself that this is
> the case, below is a set of commands that should hopefully clarify.
>=20
> $ ip link
> 6: eno2: <BROADCAST,MULTICAST> mtu 1508 qdisc noop state DOWN group
> default qlen 1000 link/ether 2a:af:42:b7:73:11 brd ff:ff:ff:ff:ff:ff
>     altname end0
>     altname enp0s0f2
> 7: swp0@eno2: <BROADCAST,MULTICAST,M-DOWN> mtu 1504 qdisc noop state
> DOWN group default qlen 1000 link/ether a6:f4:af:fd:fc:73 brd
> ff:ff:ff:ff:ff:ff 8: swp1@eno2: <BROADCAST,MULTICAST,M-DOWN> mtu 1500
> qdisc noop state DOWN group default qlen 1000 link/ether
> a6:f4:af:fd:fc:73 brd ff:ff:ff:ff:ff:ff 9: swp2@eno2:
> <BROADCAST,MULTICAST,M-DOWN> mtu 1504 qdisc noop state DOWN group
> default qlen 1000 link/ether a6:f4:af:fd:fc:73 brd ff:ff:ff:ff:ff:ff
> 10: sw0p0@swp0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop
> state DOWN group default qlen 1000 link/ether a6:f4:af:fd:fc:73 brd
> ff:ff:ff:ff:ff:ff 11: sw0p1@swp0: <BROADCAST,MULTICAST,M-DOWN> mtu
> 1500 qdisc noop state DOWN group default qlen 1000 link/ether
> a6:f4:af:fd:fc:73 brd ff:ff:ff:ff:ff:ff 12: sw0p2@swp0:
> <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group
> default qlen 1000 link/ether a6:f4:af:fd:fc:73 brd ff:ff:ff:ff:ff:ff
> 13: sw2p0@swp2: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop
> state DOWN group default qlen 1000 link/ether a6:f4:af:fd:fc:73 brd
> ff:ff:ff:ff:ff:ff 14: sw2p1@swp2: <BROADCAST,MULTICAST,M-DOWN> mtu
> 1500 qdisc noop state DOWN group default qlen 1000 link/ether
> a6:f4:af:fd:fc:73 brd ff:ff:ff:ff:ff:ff 15: sw2p2@swp2:
> <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group
> default qlen 1000 link/ether a6:f4:af:fd:fc:73 brd ff:ff:ff:ff:ff:ff
> 16: sw2p3@swp2: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop
> state DOWN group default qlen 1000 link/ether a6:f4:af:fd:fc:73 brd
> ff:ff:ff:ff:ff:ff # Simplified in a table for brevity. The format
> will be kept below $ ip link show ... sw0p0              sw0p1
>       DSA master          hsr0 addr a6:f4:af:fd:fc:73
> a6:f4:af:fd:fc:73  a6:f4:af:fd:fc:73   n/a
>=20
> $ ip link add hsr0 type hsr slave1 sw0p0 slave2 sw0p1 version 1
> [   70.033711] sja1105 spi2.0 sw0p0: entered promiscuous mode
> [   70.058066] sja1105 spi2.0 sw0p1: entered promiscuous mode
> Warning: dsa_core: Offloading not supported.
>=20
> $ ip link show ...
>      sw0p0              sw0p1              DSA master          hsr0
> addr a6:f4:af:fd:fc:73  a6:f4:af:fd:fc:73  a6:f4:af:fd:fc:73
> a6:f4:af:fd:fc:73
>=20
> $ ip link set swp0 address 00:01:02:03:04:05 # DSA master
>=20
> $ ip link show ...
>      sw0p0              sw0p1              DSA master          hsr0
> addr a6:f4:af:fd:fc:73  a6:f4:af:fd:fc:73  00:01:02:03:04:05
> a6:f4:af:fd:fc:73
>=20
> $ ip link set sw0p0 address 00:01:02:03:04:06
>=20
> $ ip link show ...
>      sw0p0              sw0p1              DSA master          hsr0
> addr 00:01:02:03:04:06  a6:f4:af:fd:fc:73  00:01:02:03:04:05
> 00:01:02:03:04:06
>=20
> $ ip link set sw0p1 address 00:01:02:03:04:07
>=20
> $ ip link show ...
>      sw0p0              sw0p1              DSA master          hsr0
> addr 00:01:02:03:04:06  00:01:02:03:04:07  00:01:02:03:04:05
> 00:01:02:03:04:06
>=20
> > Shouldn't it be forbidden, and HSR ports shall inherit MAC address
> > of HSR device (hsr0) ? =20
>=20
> Since HSR does _actually_ track the MAC address of port_A (sw0p0
> above), I guess it would be best if the API introduced would always
> program REG_SW_MAC_ADDR_0 with the MAC address of the first port that
> joins the HSR (and requests a reference to REG_SW_MAC_ADDR_0). That
> way, the API should work with no changing for WoL as well. Anyway -
> minor difference between first user port and HSR dev_addr.

I've made wrong assumptions - I thought that when we have

hsr0    -> lan1
	-> lan2

it is only possible to adjust hsr0 MAC address as lan1,lan2 are in some
way "slaves" for hsr0.

In other words - I thought that lan1, lan2 "disappear" from "normal"
DSA control as they after "join" are "represented" to DSA by hsr0 (the
below hierarchy).

eth0 	-->  lan3
	-->  lan4
	-->  hsr0	-> lan2
			-> lan1

And then you explained a use case where one can adjust MAC address of
lan1 and it would be propagated to hsr0.

Now it is clear.

>=20
> > > The simple matter is: if you program the MAC address of a netdev
> > > (any netdev) to hardware =20
> >=20
> > Which netdev in this case? lan1, lan2, hsr0 or eth0 ? =20
>=20
> Any netdev. It is a general statement which had a continuation, which
> you've interrupted.
>=20
> > > , then for a correct and robust implementation, you
> > > need to make sure that the hardware will always be in sync with
> > > that address, keeping in mind that the user may change it. Either
> > > you deny changes, or you update the hardware when the address is
> > > updated.=20
> >=20
> > Why I cannot just:
> >=20
> > 1. Check on hsr_join if lan1, lan2, hsr0 and eth0 MAC is equal and
> > write it to REG_SW_MAC_ADDR_0? =20
>=20
> This is actually unnecessary if you implement the reference scheme on
> REG_SW_MAC_ADDR_0 that I've suggested. Checking the MAC address of
> eth0 is unnecessary in any case, if you don't program it to hardware.
>=20
> > 2. Forbid the change of lan1/lan2/eth0/hsr0 if it may affect HSR HW
> > offloading? If user want to change it - then one shall delete hsr0
> > net device, change MAC and create it again. =20
>=20
> I've been saying since yesterday that you should do this.
>=20
> > How point 2 can be achieved (if possible) ? =20
>=20
> Re-read earlier emails.
>=20
> > > If the DSA user port MAC address changes, =20
> >=20
> > You mean lan1, lan2, which are joined with hsr0? =20
>=20
> Yup. I've been saying this for a number of emails already:
> https://lore.kernel.org/netdev/20230912092909.4yj4b2b4xrhzdztu@skbuf/
>=20
> | The ports which hold a reference on REG_SW_MAC_ADDR_0 cannot have
> their | MAC address changed - and for this, you'd have to add a hook
> to | dsa_switch_ops (and thus to the driver) from
> | dsa_slave_set_mac_address().
>=20
> > > and REG_SW_MAC_ADDR_0 was
> > > previously programmed with it, and nothing is done in reaction to
> > > this, then this is a problem with the HSR offload.  =20
> >=20
> > This shall be just forbidden? =20
>=20
> Yup.
>=20
> > > So no, it's not
> > > just a problem with upcoming WoL patches as you imply. You need to
> > > integrate a solution to that problem as part of your HSR patches.
> > > =20
> >=20
> > I'm really stunned, how much extra work is required to add two
> > callbacks to DSA subsystem (to have already implemented feature)
> > for a single chip IC. =20
>=20
> Some observations are best kept to yourself. This is only the second
> HSR offload in the entire kernel. To complain that the infrastructure
> needs some extensions, for something that wasn't even needed for the
> first implementation (tracking a MAC address), is unrealistic.




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/2qAaBY27j4Xi1V+4gXSYttg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUDcQUACgkQAR8vZIA0
zr0O5wgAn/aJUC5VfmXzX8kEgoqA1c0n1OcVpfXz89/U9ulQIikxZTLpgxBQoe+T
/nbNbUUquZc9jn6HWY/nlSn8A++0zVqarsZdm/3MzeRfN+ySbaNzHttE2rYWAQpf
ObipY2rrFdvuyw4r0sR2XMOPMUuU7ToiLWFYHC3DcmKca6/rIgx/ln25L7ruH2Ox
Iv3gDh2e7T6mh4p+tCOhj3HLtXl85sGCT8DfYkY44STQgVCaxkbUA0959i63ND+N
5lysQX0RbR0U5TWgVSbR8bbcDX/Z08XYd6Ze4ZaZj5LqqAHyo67yrEx9fnUPSqkk
joqNqwYm+WAf2CaMKOtkPOUb0lZxbg==
=LkOe
-----END PGP SIGNATURE-----

--Sig_/2qAaBY27j4Xi1V+4gXSYttg--
