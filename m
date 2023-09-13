Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB4C79F29E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjIMUMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjIMUM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:12:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5617C1BC6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 13:12:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qgWDi-0001jv-1g; Wed, 13 Sep 2023 22:12:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qgWDd-0069Er-3M; Wed, 13 Sep 2023 22:12:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qgWDc-001Q1d-Pi; Wed, 13 Sep 2023 22:12:12 +0200
Date:   Wed, 13 Sep 2023 22:12:12 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Paolo Abeni <pabeni@redhat.com>, kernel@pengutronix.de,
        Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [REGRESSION] [PATCH net-next v5 2/2] net: stmmac: use per-queue
 64 bit statistics where necessary
Message-ID: <20230913201212.eiedub5rsztuwaa7@pengutronix.de>
References: <20230717160630.1892-1-jszhang@kernel.org>
 <20230717160630.1892-3-jszhang@kernel.org>
 <20230911171102.cwieugrpthm7ywbm@pengutronix.de>
 <ZQAa3277GC4c9W1D@xhacker>
 <99695befef06b025de2c457ea5f861aa81a0883c.camel@pengutronix.de>
 <20230912092411.pprnpvrbxwz77x6a@pengutronix.de>
 <2fcc9fb0e40ceff8ea4ae55cca3ce0aff75a20ca.camel@sipsolutions.net>
 <ZQHIgmcnCNoZwtwu@xhacker>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dpbv4jds3tisu2kp"
Content-Disposition: inline
In-Reply-To: <ZQHIgmcnCNoZwtwu@xhacker>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dpbv4jds3tisu2kp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Sep 13, 2023 at 10:34:42PM +0800, Jisheng Zhang wrote:
> On Tue, Sep 12, 2023 at 11:30:14AM +0200, Johannes Berg wrote:
> > On Tue, 2023-09-12 at 11:24 +0200, Uwe Kleine-K=F6nig wrote:
> > > >=20
> > > > The newly added "struct u64_stats_sync syncp" uses a seqlock
> > > > internally, which is broken into multiple words on 32bit machines, =
and
> > > > needs to be initialized properly. You need to call u64_stats_init on
> > > > syncp before first usage.
> > >=20
> > > This is done. The problematic thing is that in stmmac_open() ->
> > > __stmmac_open() the syncp initialized before is overwritten by
> > >=20
> > > 	memcpy(&priv->dma_conf, dma_conf, sizeof(*dma_conf));
>=20
> Thank Johannes and Uwe for pointing out the issue.
>=20
> > >=20
> > > Do I need to point out that this is ugly?
> >=20
> > I think it also leaks the (lockdep) state since it reinits the syncp
> > (and a lot of other state) doing this. This is also called when the MTU
> > changes.
> >=20
> > Also, I couldn't convince myself that it's even race-free? Even if it
> > is, it's not really obvious, IMHO.
> >=20
> > So it seems to me that really this needs to be split into data that
> > actually should be reinitialized, and data that shouldn't, or just not
> > use memcpy() here but copy only the relevant state?
>=20
> Since we are in rc1, I need to fix the bug with as small changes as
> possible. so another solution could be: replace rx/tx stats structure
> with pointers, then setup pointers in the new allocated dma_conf with
> the old one as current code did for dma_tx_size/dma_rx_size in
> stmmac_setup_dma_desc():
>=20
> dma_conf->dma_tx_size =3D priv->dma_conf.dma_tx_size
>=20
> Is it acceptable?

I wondered if you can just initialize the data directly in *priv, instead
of setting up a local copy, initialize that one + copy it over?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dpbv4jds3tisu2kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUCF5sACgkQj4D7WH0S
/k5YqAf/QoHjd1H4OMaQOFFZq5Z1GnCqzupN9tFvF4XnK2Y0RUzjcmrLVkjEZSvA
GbuGtwdxWJr8ixqCzqbfibyZAY7i8nK6se1X4wOUikFWfsd4VVlMAvLwyvZDIeEM
6EmLYW1jMo6O+PvxapPzIKtKkNuO51/BmZ1pLy40UKINT8txpwMrCLSvCJgGTbhr
abaJvfJZS2Pel0QVCkYpm7dqX7pNPmLiNlDXwJwatnQrT2FmSxH1ftchDS3KE4Rl
QSFlKi7cYMQydd8QZp3i4NzQ+xeTWL0WROSxm7p376NFUYItnDXIBmMw0MvkyL82
XY/qJUJCraljLXTiRlSGhrHVHDMUqQ==
=fL1E
-----END PGP SIGNATURE-----

--dpbv4jds3tisu2kp--
