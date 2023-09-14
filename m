Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042B77A0FAE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjINVSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjINVSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:18:44 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8B426B2;
        Thu, 14 Sep 2023 14:18:40 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 57E1F864F1;
        Thu, 14 Sep 2023 23:18:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1694726317;
        bh=GaCjucgmR2ewr/vach/jiJUHP6lxAeRNjrbpvetIbhs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W4ifAGTqsSa9eHpgsVjOY1+CAYl9DanA2tnNIWVs2BvES+m9hqf+S8FbE0sQ9lY++
         L1KOLJlDCYVT/bgCK9fAcufKw53sZ2YDPkhZpbBoCoANkPXNUMwakvpTUfU7CXUP1A
         WMBChieM5Hh1gLucp4OqDnpAz73h5xMSbZjGzSSiQnac2zUqI0HLc3qxcDwViLiOP7
         7BThGVgKobx7lrxVEbfi5fDBCxdZ44IxG3aM8536i7s4gW0+amNXoXCgOcUz7EVMxT
         fDmeAO6hkAZZG8Ec3FPBVA5/rwaRIviUWGbCpzcw3wDUbWAZ0N1FBeM4FQKqPcBHXB
         8BLxWtb8/wCKg==
Date:   Thu, 14 Sep 2023 23:18:31 +0200
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
Message-ID: <20230914231831.0f406585@wsk>
In-Reply-To: <20230913184206.6dmfw4weoomjqwfp@skbuf>
References: <20230912092909.4yj4b2b4xrhzdztu@skbuf>
        <20230912160326.188e1d13@wsk>
        <20230912160326.188e1d13@wsk>
        <20230912142644.u4sdkveei3e5hwaf@skbuf>
        <20230912170641.5bfc3cfe@wsk>
        <20230912215523.as4puqamj65dikip@skbuf>
        <20230913102219.773e38f8@wsk>
        <20230913105806.g5p3wck675gbw5fo@skbuf>
        <20230913141548.70658940@wsk>
        <20230913135102.hoyl4tifyf77kdo2@skbuf>
        <20230913184206.6dmfw4weoomjqwfp@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/f7Bh6uyRP=wObsNfKuHGfr2";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/f7Bh6uyRP=wObsNfKuHGfr2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Wed, Sep 13, 2023 at 04:51:02PM +0300, Vladimir Oltean wrote:
> > > I'm really stunned, how much extra work is required to add two
> > > callbacks to DSA subsystem (to have already implemented feature)
> > > for a single chip IC. =20
> >=20
> > Some observations are best kept to yourself. This is only the
> > second HSR offload in the entire kernel. To complain that the
> > infrastructure needs some extensions, for something that wasn't
> > even needed for the first implementation (tracking a MAC address),
> > is unrealistic. =20
>=20
> Can you please test the attached incremental patch, which applies on
> top of your RFC v4 series? It contains an implementation of my own
> review feedback.

Thanks for preparing the patch - it clarified all the point from
previous e-mails... (and shed some light on mine understanding of DSA
internals)

It works when applied on top of v4. No performance regressions (with
nuttcp) observed.

I've also tested the scenario when one tried to alter lan1 after HW
offloading enabled. It was not possible to alter the MAC address.


As fair as I understood from the commit message - some part of this
patch needs to be applied before HSR offloading v4.

Hence I will wait for it to be posted and upstreamed.

Only then some of this patch code would be squashed to v5 of hsr
support.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/f7Bh6uyRP=wObsNfKuHGfr2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUDeKcACgkQAR8vZIA0
zr2aiQgAjbddYHIsZ5gXqPROrAWEQ6T4afqk4bryUfpgNiXiT6uDYt+m0ohRfezL
gzEU+D1pom+5m9YPNXJpM67lIO1HKx55v30d7vOo3wY4xwPYBDvo9kkK2j0gtEHl
6iJoJn6tTqZnY6Oyusd4WfUo2YSmFyM6PwyaRf5vYtGDhnjogKEn7oBf7nPMJt71
D+fGRo5eJuV8Ckdez7BzePskYzCr3VygnBoZfVWcQhfSA4JlhQfednx/WslgPNFS
75XhnDxePuozbC1rUt1LBAzXYvEOgWG6T6oElIXBCB2TsrIWcuIXeIS9Ys26ZsH/
F+IqSoVI5kWml9IvOiscMxUwFkTx2w==
=5sNg
-----END PGP SIGNATURE-----

--Sig_/f7Bh6uyRP=wObsNfKuHGfr2--
