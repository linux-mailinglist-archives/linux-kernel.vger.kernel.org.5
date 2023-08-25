Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49C7788123
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbjHYHnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241338AbjHYHm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:42:57 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D140E6A;
        Fri, 25 Aug 2023 00:42:55 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A82D086824;
        Fri, 25 Aug 2023 09:42:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1692949373;
        bh=GIqC9Xv384AEKjzYxVeUMeLxfZbuNJ6onBjh++8s48U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k5dCYTGsrkBunazjaC+Ml4N/V7NfK1RQX2Egrqq0Kr8wMSFStnYN2+krulSLH/6p3
         cfw0fyyifAIjjw0u9KeFw1cNHSA/QkGNu/qvBinMRKVEqkIpWX6cFrcB/E4IQNYtXk
         1JUsOzw8ykjB9mLE36NC+9sor3uK+ut6GWtMx3taEscB/1MTm0ENB7Q8qUzIf8yvjs
         UrzYABsfOD27gYwLKCWOkQfsF30XR3KfdZw0WiPE0F2uoTxQJZEdTj65T64xrNOJ7C
         il3Nhj9KyRzBIsDWpoAgIBBkhr0pU6glI4dZLuJeeWMRtEnM0VIJOUeF/9c7LXsj/K
         U7X5IRwa4jWBg==
Date:   Fri, 25 Aug 2023 09:42:46 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477
 errata (DS80000754C)
Message-ID: <20230825094246.211a4898@wsk>
In-Reply-To: <9504d420-c137-2fde-312d-2c8e6f84ddd1@gmail.com>
References: <20230824154827.166274-1-lukma@denx.de>
        <20230824154827.166274-2-lukma@denx.de>
        <9504d420-c137-2fde-312d-2c8e6f84ddd1@gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/X5uYKu_bpYe++gKJ4hIqhg7";
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

--Sig_/X5uYKu_bpYe++gKJ4hIqhg7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Aug 2023 08:54:37 -0700
Florian Fainelli <f.fainelli@gmail.com> wrote:

> On 8/24/2023 8:48 AM, Lukasz Majewski wrote:
> > The KSZ9477 errata points out the link up/down problem when EEE is
> > enabled in the device to which the KSZ9477 tries to auto negotiate.
> >=20
> > The suggested workaround is to clear advertisement EEE registers
> > (accessed as per port MMD one).
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >   drivers/net/dsa/microchip/ksz9477.c | 40
> > ++++++++++++++++++++++++++++- 1 file changed, 39 insertions(+), 1
> > deletion(-)
> >=20
> > diff --git a/drivers/net/dsa/microchip/ksz9477.c
> > b/drivers/net/dsa/microchip/ksz9477.c index
> > cb6aa7c668a8..563f497ba656 100644 ---
> > a/drivers/net/dsa/microchip/ksz9477.c +++
> > b/drivers/net/dsa/microchip/ksz9477.c @@ -1128,6 +1128,44 @@ int
> > ksz9477_enable_stp_addr(struct ksz_device *dev) return 0;
> >   }
> >  =20
> > +static int ksz9477_errata(struct dsa_switch *ds)
> > +{
> > +	struct ksz_device *dev =3D ds->priv;
> > +	u16 val;
> > +	int p;
> > +
> > +	/* KSZ9477 Errata DS80000754C
> > +	 *
> > +	 * Module 4: Energy Efficient Ethernet (EEE) feature
> > select must be
> > +	 * manually disabled
> > +	 *   The EEE feature is enabled by default, but it is not
> > fully
> > +	 *   operational. It must be manually disabled through
> > register
> > +	 *   controls. If not disabled, the PHY ports can
> > auto-negotiate
> > +	 *   to enable EEE, and this feature can cause link drops
> > when linked
> > +	 *   to another device supporting EEE.
> > +	 *
> > +	 *   Only PHY ports (dsa user) [0-4] need to have the EEE
> > advertisement
> > +	 *   bits cleared.
> > +	 */
> > +
> > +	for (p =3D 0; p < ds->num_ports; p++) {
> > +		if (!dsa_is_user_port(ds, p))
> > +			continue;
> > +
> > +		ksz9477_port_mmd_read(dev, p,
> > MMD_DEVICE_ID_EEE_ADV,
> > +				      MMD_EEE_ADV, &val, 1);
> > +
> > +		pr_err("%s: PORT: %d val: 0x%x pc: %d\n",
> > __func__, p, val,
> > +		       ds->num_ports); =20
>=20
> Left over debugging?
>=20

Yes, correct - I will fix it.

> > +
> > +		val &=3D ~(EEE_ADV_100MBIT | EEE_ADV_1GBIT);
> > +		ksz9477_port_mmd_write(dev, p,
> > MMD_DEVICE_ID_EEE_ADV,
> > +				       MMD_EEE_ADV, &val, 1);
> > +	}
> > +
> > +	return 0; =20
>=20
> You don't propagate any error, so make this return void?

I will fix this too.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/X5uYKu_bpYe++gKJ4hIqhg7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmToW3YACgkQAR8vZIA0
zr13rQgAodpJW/I8pztGdsV0lEkJ0kEYvyxD3TJoLaVUfK7kDwsenxyKcV6ggeCE
katdjiNpQvjPMQR2MC1Dkz1wAGSVD+b6vqykHygF6IKPd5oS5lesVV+emAo0qbXV
gXKEwMsLQ2nbjrp6z/ZikvSFvtZujny0ez4PLXnijf0tOfHEixiVGd23e15UvN8B
i3fmq3zOXa5tq0i4J2/J94ll8h3iHsGreYIzWr9aXpdlxzQvgM629FPa3KmchXbk
HVbV7SIeG8qbNwHdkft4FszAui/mLCqb6Aia4bO619+1N3yZhLzbpdTLPZIMZSi8
B9mpiPFnLSu9YPIJMSwbPYnt4C+skQ==
=RxGt
-----END PGP SIGNATURE-----

--Sig_/X5uYKu_bpYe++gKJ4hIqhg7--
