Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93EA79E1E9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbjIMIWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjIMIWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:22:33 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276D4C3;
        Wed, 13 Sep 2023 01:22:28 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id B0E1586823;
        Wed, 13 Sep 2023 10:22:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1694593346;
        bh=FfGne0WgsVfqXylHiwFj1ygRcfdEUwRbXoP1KKdbSDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z4TsVOpyAqa90KLQUBT5JR2Tn1agpnaARKwbrh9ckZZM+7/CWaZtzLJ0gnULseHsI
         5WZ+kF5HZoU2Y9x917A/ON0Qse1GCuwJtc3MK5KxcHsKMRIrnjqHCYhrq66jERgZQQ
         XS7OhQhAXSqO9faKT6T/VTFOi0CGxweaVboKN+KJokcxku2LnVG9tdLpwoVwXCnEG2
         YICzheb/iWSto8+7Adxdav36JJKd7LCYM0zX0O+vm9RsLfNRGaQFPS0cW7UD90guNz
         kYJ/ONzlo7VRTpf44T5Zt0TiwSBkLMmszJjPt0L47crhTNW5EKTF8kC3RdKlRYctXJ
         AMjhvontiDAWg==
Date:   Wed, 13 Sep 2023 10:22:19 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        davem@davemloft.net, Woojung Huh <woojung.huh@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Oleksij Rempel <linux@rempel-privat.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [[RFC PATCH v4 net-next] 0/2] net: dsa: hsr: Enable HSR HW
 offloading for KSZ9477
Message-ID: <20230913102219.773e38f8@wsk>
In-Reply-To: <20230912215523.as4puqamj65dikip@skbuf>
References: <20230912092909.4yj4b2b4xrhzdztu@skbuf>
        <20230906152801.921664-1-lukma@denx.de>
        <20230911165848.0741c03c@wsk>
        <20230911160501.5vc4nttz6fnww56h@skbuf>
        <20230912101748.0ca4eec8@wsk>
        <20230912092909.4yj4b2b4xrhzdztu@skbuf>
        <20230912160326.188e1d13@wsk>
        <20230912160326.188e1d13@wsk>
        <20230912142644.u4sdkveei3e5hwaf@skbuf>
        <20230912170641.5bfc3cfe@wsk>
        <20230912215523.as4puqamj65dikip@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VUl7zmoZGIpwqGbfIpDnoV4";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VUl7zmoZGIpwqGbfIpDnoV4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Tue, Sep 12, 2023 at 05:06:41PM +0200, Lukasz Majewski wrote:
> > Are we debating about some possible impact on patches which were
> > posted and (in a near future?) would be reposted? =20
>=20
> We are discussing the ways in which a multi-purpose register should be
> programmed. Not "the impact on patches" per se, because Oleksij will
> have to adapt no matter what you do, but rather the options that
> remain available to him, after the first feature that makes use of the
> multi-purpose register makes its way to mainline.
>=20
> > > > Considering the above - the HSR implementation is safe (to the
> > > > extend to the whole DSA subsystem current operation). Am I
> > > > correct?=20
> > >=20
> > > If we exclude the aforementioned bug (which won't be a bug
> > > forever), there still exists the case where the MAC address of a
> > > DSA user port can be changed. The HSR driver has a
> > > NETDEV_CHANGEADDR handler for this as well, and updates its own
> > > MAC address to follow the port. If that is allowed to happen
> > > after the offload, currently it will break the offload. =20
> >=20
> > But then we can have struct ksz_device extended with bitmask -
> > hw_mac_addr_ports, which could be set to ports (WoL or HSR) when
> > REG_MAC_ADDR_0 is written.
> >=20
> > If WoL would like to alter it after it was written by HSR, then the
> > error is presented (printed) to the user and we return.
> >=20
> > The same would be with HSR altering the WoL's MAC in-device setup.
> >=20
> >=20
> > The HSR or WoL can be added without issues (the first one which is
> > accepted).
> >=20
> > Then the second feature would need to implement this check. =20
>=20
> This is more or less a rehash of what I proposed as option 2, except
> for the fact that you suggest a port mask and I suggest a proper
> refcount_t. And the reason why I suggest that is to allow the
> "WoL+HSR on the same port" to work. With your proposal, both the HSR
> and WoL code paths would set the same bit in hw_mac_addr_ports, which
> would become problematic when the time comes to unset it. Not so much
> when every port calls refcount_inc() per feature. With WoL+HSR on the
> same port, the MAC address would have a refcount of 2, and you could
> call port_hsr_leave() and that refcount would just drop to 1 instead
> of letting go.
>=20

Why we cannot have even simpler solution - in the HSR/Wol code we read
content of REG_SW_MAC_ADDR_0 (the actually programmed MAC) and:

- If not programmed - use DSA master one (like done in mine patches)

- If already programmed:
	 - check if equal to DSA master - proceed with HSR.
	 - if not equal to DSA master (e.g. WoL altered) - exit HSR join
	   with information that offloading is not possible

Then, the content of REG_SW_MAC_ADDR_X would determine what to do with
it.

> There are probably hundreds of implementations of this idea in the
> kernel, but the one that comes to my mind is ocelot_mirror_get() +
> ocelot_mirror_put(). Again, I need to mention that I know that port
> mirroring !=3D HSR - I'm just talking about the technique.
>=20
> There is one more thing that your reply to my observation fails to
> address. Even with this refcount thing, you will still need to add
> code to dsa_slave_set_mac_address() which notifies the ksz driver, so
> that the driver can refuse MAC address changes, which would break the
> offloads. Ack?

And the above problem is not related to the DSA slave address change
discussed earlier?

>=20
> In principle it sounds like a plan. It just needs to be implemented.

To clarify:

0. It looks like described above prevention from REG_SW_MAC_ADDR_X
overwriting and DSA slave port MAC address change are needed.

Then questions about time line:

1. The HSR code is accepted without fixes from 0. and then when other
user (WoL) patches are posted problems from 0. needs to be addressed.


or=20


2. To accept the HSR code you (and other community members? Russell,
Andrew) require the fixes from 0. first.=20


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/VUl7zmoZGIpwqGbfIpDnoV4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUBcTsACgkQAR8vZIA0
zr0ogAgA0webWRC7J32HSocwpeFgRbKldfCbkZ6uN2y7jBdjlJd+UsXiIlgrIj76
tepQ8l2geDOQ9PlutvBHLfrCY0EZbvAzcAydb4p9PYuD+H2u6FIy0q6c2xPy0Hf7
qd8CrcJFQMu9vObKK2oiC1i/H0umcySGnoseb9dYYphAUTJobSvQHjeYzu6PwWdN
//3AckO3/1eMrYrBhcMapGxAuj+gA5VUdMKVJRWY9+4OOcfO1qLdZvLfa3/5cxx0
E9CZmzCJI+gwO2bxwLi4+oVjVqBYywKbkON+LRXIIF2S43VIRC8MLBdWCmTmOYyZ
vkU/ocIGygyX/yqnmiPPsNJ4E28xRQ==
=6j3Z
-----END PGP SIGNATURE-----

--Sig_/VUl7zmoZGIpwqGbfIpDnoV4--
